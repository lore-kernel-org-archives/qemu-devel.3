Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC255C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 17:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD5lP-0007Fg-Lz; Fri, 31 May 2024 13:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD5lO-0007F8-LX
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:09:58 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD5lM-0001Bi-3c
 for qemu-devel@nongnu.org; Fri, 31 May 2024 13:09:57 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4202ca70270so28641935e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717175394; x=1717780194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wzDIXdFU+DrFp8GTpCb4Xzr4LdwXmpcYy3SiUBUKw8o=;
 b=gOkNZiJPyqDQ/Vb7nRrbTnK0succ6CtE54BzVjecWB1undIgQ7oIe9P7VHXkQHO1yb
 bZQtaBwp6xru/r13dw0vh1iS4Xt46rQ0/Uvuln+oMaaCUQ92xSA+77s3Rc+WJjYGT6C/
 h2a8OVhndeHqNlFOhKKzdctkce1/tvvw2NVvCRUEAbDkzpNTaK+Taful2FSIANF1KqAX
 ouy4ovre1VWt7lBbRUrX31bW1AnOW/DMQvjkWxMkseVG1rQVEOLRl13wj+VeBD2EurWv
 hWtwOo9VvLXInYv0Vmt9uRPOtTX3WzfhN6s7TlozDizTGiWOWPnxsjlfadXgdWxPcYUD
 EKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717175394; x=1717780194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wzDIXdFU+DrFp8GTpCb4Xzr4LdwXmpcYy3SiUBUKw8o=;
 b=JtoCIxLYJxoVj/v7zPTsQvCFqiIdhEcLUZo35PE2im85xe9C3LuOv7agOq8goIX764
 hKIaLwajld9Fdpz4bWiL6340SSKJxNf0kGkT9xRJX4Ac4uadm+VdFYTXbCDzOvuW6V54
 MyXqDeFoUKFMbTafI3XWXRKxjJlljfUtU514YGRMf1w97MvsJikHOEFvaRYyy3in3GY7
 5vWHHNHHQGrl/BAV3Yc3cht57Zyj5Ue+0Pz+NbzEtqD/oveavyPCc0RyvJk1cZDIwqBd
 xR9gp9Wi83sUW8qw5bkQJQcW7zSAoaGNxcIuZChDp1splUQVX7Aewlt/Ps3IdmWUjAcE
 /jsQ==
X-Gm-Message-State: AOJu0Yw2q00rIe37f1Tt/8Obg8VmYkGxK8LWrms113YaMDJWOtDb2uTA
 wGVgMso/7n+bUvq2+at25x+WQAH3uDtPCr9PFw0/Vb3vCDQOduNjz1pgd/mm77BKNtiSJ2kv+1S
 p
X-Google-Smtp-Source: AGHT+IHGM2kcndaTj6O/saurBDnk1/Wfh3DYeHtNTLIC0C9MlmPxcz76cYtSZzP+aEujRP9eYTHO/A==
X-Received: by 2002:a05:6000:e48:b0:34d:9456:b8d6 with SMTP id
 ffacd0b85a97d-35e0f297876mr2008520f8f.42.1717175394143; 
 Fri, 31 May 2024 10:09:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04d96f6sm2278969f8f.61.2024.05.31.10.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 10:09:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH] accel/kvm: Fix two lines with hard-coded tabs
Date: Fri, 31 May 2024 18:09:52 +0100
Message-Id: <20240531170952.505323-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

In kvm-all.c, two lines have been accidentally indented with
hard-coded tabs rather than spaces. Normalise to match the rest
of the file.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/kvm/kvm-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c0be9f5eedb..009b49de447 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2893,7 +2893,7 @@ int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
             !memory_region_is_ram_device(mr) &&
             !memory_region_is_rom(mr) &&
             !memory_region_is_romd(mr)) {
-		    ret = 0;
+            ret = 0;
         } else {
             error_report("Convert non guest_memfd backed memory region "
                         "(0x%"HWADDR_PRIx" ,+ 0x%"HWADDR_PRIx") to %s",
@@ -2964,7 +2964,7 @@ int kvm_cpu_exec(CPUState *cpu)
 
         kvm_arch_pre_run(cpu, run);
         if (qatomic_read(&cpu->exit_request)) {
-	    trace_kvm_interrupt_exit_request();
+            trace_kvm_interrupt_exit_request();
             /*
              * KVM requires us to reenter the kernel after IO exits to complete
              * instruction emulation. This self-signal will ensure that we
-- 
2.34.1


