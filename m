Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFDBC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 21:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAyCn-0000ef-T2; Fri, 02 May 2025 17:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyCl-0000dr-JC
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:45:59 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyCj-0003Uq-G1
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:45:59 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5f6c3f7b0b0so4898076a12.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 14:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746222354; x=1746827154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WJue50/VmyGCP58mS6SkkABhk9OOPodCUl+4aWPhSxI=;
 b=emOprTKkOs2HrtYSWbk3C6e08h0rKsxhW1p2rC2QniII4KEctbw3dgCil1Xl9Wok/d
 lwiaeZu91ssZZ4z+5smUH8httNRs7VpDqvczsLbPG3tg5ebbSy13IHG7JxdiKKBabWOv
 14km5HzRiVe8lE5mImLZ1oe4mJaBxFluJwLlhOnavJMnm4HILXaRqNy/LB2FGNFMtMZW
 e42G+I6dON91hQAIkP5VbnXcC6V/60MgsTF8Cuh4JGe/0+RkgXNjzedGXoXY+N0cLChw
 HdOHCog2+ai69rD5Y8M5WHWrFGU//RkuwSugSkAoPFKMjBsVmmJgbjpVHyu6mSd4Cg/u
 P5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746222354; x=1746827154;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WJue50/VmyGCP58mS6SkkABhk9OOPodCUl+4aWPhSxI=;
 b=iUkRGUaVM42KZ2q+VPRj/nXOtaYLLJkazlOHWRXVloXT7EQDTYk7GAbsE3uHmOZ7MK
 MkQBrpWbh7mU2+1btXzbkl+y9diEiMP9HV2NjIWTmDHWDP9DOBvuinuatNmHrSk8xbg6
 Zhb6Etxvq0nn2EZ53SHyZ9qdb62c9lspiRtCu7KN1ZNudoWycBTv0bdHoANrPsRXeQ2g
 RXyydHjNa6SvWImX5O4T6YSCiljZLBPZGPX4p/brdP7YyT++MZvcruYyodWfueilHJwj
 rpcC6Ti867pwrxUnurfccflRILaGZm2qjxnPzzLvc4GiFkC1AageshdqfhPlJB6vv5+M
 6d9Q==
X-Gm-Message-State: AOJu0Yzka/gXnF1Gv/P3ibBcjO8UsNWASozlCw7FQgiyRrlP2vaQ/Ntz
 1gH0k0yVQF8MLcf7zoiqhNXCxP8QiQnY6mIg3UE+IzqmNICig5yeH6AckVHF3QhTYIDXY9sSsIZ
 +
X-Gm-Gg: ASbGnct3aV1626s+mEXwBr6CVTGeNqjaU92REfQJfQ2wnO71V98BaT1suLmZJSJ9Opc
 0FG9tnqapZF2S/PJLrPKWwU5irNQ41+CoE3A3vWdzquLsVT8XxO8W3mwCfjUD2EO5FDyr5byNoS
 +NyMdbK8+mis1hKayE6hLMhsqdEcehK4Rcc1aQPnGPtRnhZxMm6VUz/P9P4uwcjhignr5CZv/yL
 RVz2LDwA53en27evOY4a8K5OZCpcgwsNO5A349fWwFy4+MIcOQgWAglgJM2KaJJla2JwLtU0sTI
 +bWdxRc8iwiF0m/kqkfq86l/3jpN7Fo9wQitOaaDNhDgy3EnobXuMm7d3Er91Qprpy2WxXsgeOY
 tKBdpinlvHGAGSEo=
X-Google-Smtp-Source: AGHT+IGmmVKp16PbLyG2G6NxkgAfj5BlE4BtwOP1bhtIh4DtDZgIMIW+xg8vzD1/m8K88oKox5tOVg==
X-Received: by 2002:a05:6402:d08:b0:5ee:497:89fc with SMTP id
 4fb4d7f45d1cf-5fa7891aae1mr3832968a12.33.1746222354349; 
 Fri, 02 May 2025 14:45:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa77bf2893sm1774611a12.71.2025.05.02.14.45.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 14:45:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 0/5] hw/virtio: Build virtio-mem.c once
Date: Fri,  2 May 2025 23:45:46 +0200
Message-ID: <20250502214551.80401-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since v2:
- Use TargetInfo API (Pierrick)

Since v1:
- Use max extent size of all archs (David)

Based-on: <20250501212113.2961531-1-richard.henderson@linaro.org>

Philippe Mathieu-Daudé (5):
  qemu/target-info: Factor target_system_arch() out
  qemu/target-info: Add %target_arch field to TargetInfo
  hw/virtio/virtio-mem: Convert VIRTIO_MEM_USABLE_EXTENT to runtime
  hw/virtio/virtio-mem: Convert VIRTIO_MEM_HAS_LEGACY_GUESTS to runtime
  hw/virtio: Compile virtio-mem.c once

 include/qemu/target-info-impl.h |   4 +-
 include/qemu/target-info.h      |   9 +++
 hw/core/machine-qmp-cmds.c      |   6 +-
 hw/virtio/virtio-mem.c          | 101 +++++++++++++++++++-------------
 target-info-stub.c              |   1 +
 target-info.c                   |  15 +++++
 hw/virtio/meson.build           |   2 +-
 7 files changed, 90 insertions(+), 48 deletions(-)

-- 
2.47.1


