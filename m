Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFFCC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 13:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcm38-0004TF-Cy; Tue, 28 Jan 2025 08:54:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcm30-0004S7-HQ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:54:35 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcm2z-0006YE-2f
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:54:34 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso4970366f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 05:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738072471; x=1738677271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a+r7ODhuu9s0569fMZKjXAvTdbCLGmUJt4rbO9ZfXGQ=;
 b=RMCxZD/YtMrOmufKiKsMhHKYfThvWCvogewbBLlwgZg4pd8kbgWhNq3BSrH9I0AENx
 1lR/3kmBEKMuMwjWIgYowOTMQA2OlwYsKBgtFXvTFlxOCqK63+s72hxrD1OVnPKsRoPW
 ugC+LvCHgmr/4SJvtg1VqYgWK5sQ/iolAlLtTnark5O2PHgr0rP9SRyfrplwnqdAe3iv
 nU1LMiKHLX4H7BmLISuw/JeXwVR6owbgJO+BbVGi2xQG6ltL3AUZfhla65Md/Ib2qBeW
 cdHiUd+FXb2Em1VZd0waNwIP7vqkfcCRoFNFvGZjVABhyTO/cvdswYGArx5bBb0qhabc
 HFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738072471; x=1738677271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a+r7ODhuu9s0569fMZKjXAvTdbCLGmUJt4rbO9ZfXGQ=;
 b=uhKZgFeED4npyAfbLJ3aSuszBHI20GzVZJKEfivvlMli6ZxkyRz9ROxq8QKmt41HWq
 qIwgspxBD6Qh/fWL14KHzBrz1hTPxPnYEIl547Utrjbss0tQ9ArMRRU1JIoGfFJHPLcj
 YiG6fFvwo4rpapz1PBVkPp+F7KrRfnlqlYF1gtRV1JRigHg5QVfJ9CgZDecuAJ9LtvF0
 kqwTEM9NEvGe9Gd85BxpARmSREKhi/5N6RA/efcdUGNvfEeI615DR4MVpYReJKtTHycS
 g3lBfguzbGDaAKqmWWsXmUDxiL6FAiXmdFSRnprH0SAwzcc4Yt87v/DLyim0gCKDNqD9
 BheQ==
X-Gm-Message-State: AOJu0YxpgwdP9SEPu6SSel8Bf8KIouMhsnFQ0Emd3TtG3gc5lRJwI5CS
 wOJwNLFY6J1Z655iLWF+FD1OZI7RId8Q2ff0LmW55SkieQ8SXgR5Za1kvoFS1AyVMBlgAYy8rXa
 mKWE=
X-Gm-Gg: ASbGncuxgshOZhu0wdvxo/S9v+sWMlekLKtbxGL5UP+3/qSsWMbIOTOWPQ239I8p75Z
 gAgQi541Keeb1jCJIAlqc76BsZlvv4atdSY2bc9kxfQHQeULG09rnfDERvIkJFic1pALHLbOE3H
 818X4d6VlH83diM7YXoTbvBVTa8ZE+rTozxOsxz4GlqGj21mTg5mQ6rw9pwfGupCB0KCqemAj8G
 3ehYbfe3Ew+KmuGZloBzAq8Dws4zUmo31xtrxOp1Z5ljTPmAFo4uybQFds9mUsvtAedKOgPdtH/
 tX25eP1qFxFzowLvdzqYaQFXF46jdMEQNWIQm+9OBrPxgNgg1AqtU356x9jJW2/LIQ==
X-Google-Smtp-Source: AGHT+IHjU9b1hywaCt9ZZDZOTAJ9SR1tTjRqfBZNwE+PZczTctgcNXvDhfPe2+qhd2h4R/nm0QLLSg==
X-Received: by 2002:a5d:47a9:0:b0:382:40ad:44b2 with SMTP id
 ffacd0b85a97d-38bf57a77aemr41255759f8f.34.1738072471175; 
 Tue, 28 Jan 2025 05:54:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1764e9sm14380488f8f.17.2025.01.28.05.54.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 05:54:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/7] tests/qtest/migration: Update framework to allow using
 HVF accelerator
Date: Tue, 28 Jan 2025 14:54:22 +0100
Message-ID: <20250128135429.8500-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Hi,

This series modify few bits of the migration QTest framework
to allow running the tests using the HVF framework (also
leaving the possibilty for other ones, removing the KVM/TCG
restriction).

Philippe Mathieu-Daudé (7):
  migration/dirtyrate: Do not unlock cpu_list lock twice
  tests/qtest/migration: Make 'has_dirty_ring' generic
  tests/qtest/migration: Initialize MigrationTestEnv::arch early
  tests/qtest/migration: Pass accelerator arguments as machine option
  tests/qtest/migration: Add MigrationTestEnv::has_hvf field
  tests/qtest/migration: Run aarch64/HVF tests using GICv2
  tests/qtest/migration: Allow using accelerators different of TCG / KVM

 tests/qtest/migration/framework.h     |  1 +
 migration/dirtyrate.c                 |  1 -
 tests/qtest/migration/framework.c     | 43 ++++++++++++++-------------
 tests/qtest/migration/precopy-tests.c |  6 ++--
 4 files changed, 26 insertions(+), 25 deletions(-)

-- 
2.47.1


