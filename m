Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D03C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 10:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGz9D-0004OE-AQ; Tue, 11 Jun 2024 06:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sGz9B-0004MH-D4
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:54:37 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1sGz98-0006Gt-Ux
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:54:37 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d226c5a157so1439744b6e.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1718103273; x=1718708073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=32rmZDa/NUdv9XGXHqT9UuGO3ES+c10j4EjbZZAmvbw=;
 b=aCqTAF2edBLtSpeGZ1d7o9mzqbuwNPrMCFbLjAkyHRDb4PizzkclcWyhB//EAxhTzo
 wpZ0KQtAOSgd83jyTEwLqz8FbylSHaBh/TWew9ZOSAAqz0+yzCXEgWwFuCqZlI25Y/Im
 y7mxnfF2O6oQ2B/PpWPXDKpu3rVZpzFQLD1tzwaiVVwFgt79Wko5CHH/fSyqCYMRCQ/A
 oHJQmXGkQwiYFN2K5STxAdBSdfcypSg0HeFfzARMQdmnTqB/n2OmJ7A3y0wjzVrSY1rv
 T7mjOBK1sq9E8wXIz++durlh/w+lCtxpQJZd0UzOQc02Q9tLTxRwY32MgxfKSfHbbhNe
 NzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718103273; x=1718708073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=32rmZDa/NUdv9XGXHqT9UuGO3ES+c10j4EjbZZAmvbw=;
 b=F+Kf4Dfi1faUcHaOtkcNNY7rj2gGra3PgmWhxGQ2X6x0CMThpgY57+NJBtOyeU/qfe
 VILPEo8XaNrP8MpvvjkObAxdcnkPMiUA6WUowT0B67jqbrBB/l/tdwaM4Zu2Txr5CbVv
 mk1fU2wOAEc/XkM5waXIlosuLu9TjjPhQs4BuWlyqPI0RDPDhnzfyguJcUwBPOZo3kQ8
 dzTiZ3s60qRiqeusq+Wcwi8LfhJmKzOypUdyuMWIxyLLf4EV1JridsyzTvfNpzSBrKAp
 WfISqv0Ubhs0JfDYpn76DeuqtONMiZqSPqyada05SPBn85vCxKWgdJfTf6uXLxcTvMwT
 2XQw==
X-Gm-Message-State: AOJu0YwK8qZwypt0Z0yRJAHet3tPDVJI6DLmfGtDKJpnLzNz70dJ8jhp
 uEbuH0ooxu0q6yC/xT9Vi0lWe+FhQ7jrWx4zjvn+80hHFJ59WiQw1mbU84+pbHg/c2tCJOeZ+Pn
 NZto=
X-Google-Smtp-Source: AGHT+IE9nBDWLnjBLO6CuTZG7iSRRhIvqvtO1kVss85kQG2VuwEJC6UU78KEmhzo03qyCnWrs1FagQ==
X-Received: by 2002:a05:6870:b6a1:b0:254:c777:6327 with SMTP id
 586e51a60fabf-254c7776564mr5811977fac.36.1718103272822; 
 Tue, 11 Jun 2024 03:54:32 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7042488212dsm5605381b3a.15.2024.06.11.03.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 03:54:32 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v3 0/2] meson: Remove libibumad dependence
Date: Tue, 11 Jun 2024 18:54:25 +0800
Message-Id: <20240611105427.61395-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=pizhenwei@bytedance.com; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v2 -> v3:
- refresh lcitool after removing libibumad

v1 -> v2:
- remove libibumad from tests/lcitool/projects/qemu.yml

v1:
- remove libibumad dependence

Zhenwei Pi (2):
  meson: Remove libibumad dependence
  test: Remove libibumad dependence

 meson.build                                           | 4 +---
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      | 1 -
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        | 1 -
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 1 -
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 -
 tests/docker/dockerfiles/debian-armel-cross.docker    | 1 -
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 -
 tests/docker/dockerfiles/debian-i686-cross.docker     | 1 -
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 -
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 1 -
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 -
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 -
 tests/docker/dockerfiles/debian.docker                | 1 -
 tests/docker/dockerfiles/ubuntu2204.docker            | 1 -
 tests/lcitool/projects/qemu.yml                       | 1 -
 15 files changed, 1 insertion(+), 17 deletions(-)

-- 
2.34.1


