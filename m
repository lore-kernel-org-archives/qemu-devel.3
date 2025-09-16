Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F355DCAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 17:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyZB9-0005zu-T9; Tue, 16 Sep 2025 13:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyZB8-0005zH-Bt
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:09:18 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyZB6-0001P4-62
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:09:17 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-327f87275d4so5542691a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 10:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758042554; x=1758647354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GoK+dtpaofxfWpfSRy8xfu6FnNTXifoVzDy23ofU9fg=;
 b=JspJa8SpTYzYXe4+NOXzZDFWIcUG8tVKkvCAvK7hNiyVVwg5LkNc88kbQBaTAalHmy
 u5anj2M4QyZdDc+QT0fA4QD35C9JQXsxyDFjm9do5wXPY15NoMDS7OhLrOsyy27ETFXn
 LiA/6PRBYPTj3e7ruw1Op9Qmu/dS7AGX5O8x/t52qJmjouSERYTYFnBWbb9M2dyiwkcn
 nA89Hovx3xj/drWh+dwAuf23RSBiQ+0tWeF6cQa7s9++vob+RKxIO3XPswdZNy+RUO48
 PVQqT37moH1DcEF5j2RIQi5F9E1BT74FlcO5VmaBRsFgXt8yD9oTs2cp5Rx+gvNWBCdo
 qqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758042554; x=1758647354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GoK+dtpaofxfWpfSRy8xfu6FnNTXifoVzDy23ofU9fg=;
 b=Ic7a22g+AbGmcwFeSWBL1wMZR7rFbAHUzJy69Nb35FvNqyhed5qopAOoVBHsax+izv
 VSevFv/SNvOY5ICMm7u20jN19UEog3ExRwFn/rtJsAEaIkbVDAbP2t5HU1+kqSP12iEi
 pHAwdXoPq6VCf3FjBwTk5HIPgiLdF7HBwThguUsEYExeWH3ufor9P7XguovhED7LYbiS
 c7o5G5Q2CE5pjBeKhw5eFx1tHjkofEIUBtJBMJsb72fImDPzNeW1FT4Uy0JmuIlPkgo4
 hC9RW0vF+BH2lAvii0p/nLJv4W7gL3PEd+Bf+0Hj2/vXrwk6PsxU+DfiSuQf9gQX4+ct
 gXaQ==
X-Gm-Message-State: AOJu0YxuG57LGhIfv4u0xglT/2iYSzMb3aP6JwqvjCGNW9MqHGcIz63K
 UdQL98IspfKag+Nyn21ZAYwf4NrOIIaFc2tq7r2oNWc2n5gBc9HZNmll/AYwmX0OE9KOuuY53H1
 SUgpk
X-Gm-Gg: ASbGnctMXanqRdbwRdtov8g+yWmNtEbTdSPdpSQL+9MoH3mFLr8JG5byZ3HZzAnBV2Y
 UPUTzxMLvAGLvEBWf2kiuhKcD6SD+xw3wW/n4qCE6ErnI2AModP1XsN9T+VlcPmECD5m4siPr4W
 LtWBs2GD3D7ALrpQZiy+YCDBNHKYiq1R6vLunKqy/OEhveBQtR7LtnloeqPCkVoTV5TggN/PiVU
 kkjufyKxsi5YWa7PSHTIk5caFbQ0OIpjkSjMukntjDwihcGAjdhsVwo4nbZ7oSGoEfy/EjeZ/P1
 vDjANbRMreGARZUkuep9r97nPYEnj4tNhV6a9tu5Zi8jFub+8Wat4ABe39EBIUckDSvlYJ5hjF0
 FMExDVs+8CsPBdcr2N2NUuHYQtT1OAK30JpN4q4o=
X-Google-Smtp-Source: AGHT+IHuse+UqIRRMrTEt6yQIVBprNfbLh4vlck0r7lRbe0m74ukbC0SVkK3ZwB/oNwL1hnuO38h4w==
X-Received: by 2002:a17:90b:3a08:b0:32e:a5c2:7f87 with SMTP id
 98e67ed59e1d1-32ea5c28057mr3497054a91.22.1758042553774; 
 Tue, 16 Sep 2025 10:09:13 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32ed275e795sm95531a91.19.2025.09.16.10.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 10:09:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 1/2] tests/functional/x86_64: Accept a few locked pages in
 test_memlock.py
Date: Tue, 16 Sep 2025 10:09:11 -0700
Message-ID: <20250916170912.706610-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916170912.706610-1-richard.henderson@linaro.org>
References: <20250916170912.706610-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Startup of libgcrypt locks a small pool of pages -- by default 16k.
Testing for zero locked pages is isn't correct, while testing for
32k is a decent compromise.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/functional/x86_64/test_memlock.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/functional/x86_64/test_memlock.py b/tests/functional/x86_64/test_memlock.py
index 2b515ff979..81bce80b0c 100755
--- a/tests/functional/x86_64/test_memlock.py
+++ b/tests/functional/x86_64/test_memlock.py
@@ -37,7 +37,8 @@ def test_memlock_off(self):
 
         status = self.get_process_status_values(self.vm.get_pid())
 
-        self.assertTrue(status['VmLck'] == 0)
+        # libgcrypt may mlock a few pages
+        self.assertTrue(status['VmLck'] < 32)
 
     def test_memlock_on(self):
         self.common_vm_setup_with_memlock('on')
-- 
2.43.0


