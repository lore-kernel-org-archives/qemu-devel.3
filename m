Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5843C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 22:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAcVx-0002OV-A8; Thu, 01 May 2025 18:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcVo-0002Mz-Ov
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:36:12 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAcVn-0002zQ-92
 for qemu-devel@nongnu.org; Thu, 01 May 2025 18:36:12 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-8640d43f5e0so122303739f.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 15:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746138970; x=1746743770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmhBmYebiRFz0OgzLtlxL2sc6it26EKxebtheKN6ZCc=;
 b=pwk5Oe2MnWz4SFYJ52v4CEE+LJievwsMW7SJ7vWx4ASvyyt5CUEPMrlYJ8CBIiWOWf
 1ZWAk+DLUcLq3ZvG6DuUNNnOPzX/PWiYR+eVdAGFR8K0j/7yURHLLNfTMHxttuMVTC3B
 Ciws2muea5cexcAsBKy/reLsvrRdMUcdP6mQfL8iZdvogdkV9e2NRZAkfkX6pzogMiv7
 n1y7UE/CLi+2TJ2Ydol8QD3JJnyPO7nNsLPW7wKyPi5MiMpaLqISJsCYpOBYoKX2EamR
 NZtonTVEVput2TRw3+b8Tc3P317vgdkAGy3PeE5ms/jESPNxw0A/B+uU+uUig09IJyfN
 N0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746138970; x=1746743770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kmhBmYebiRFz0OgzLtlxL2sc6it26EKxebtheKN6ZCc=;
 b=HxtBEG+LFqRKkadYTvQLaRi82/yKtdTzBv0qaOwmNXnTqSKpwgMysftpAMbYtdchhy
 kvTg8Yhj45cUCLTtBo+uAMG1e2IYvf6Ltwa5QZSpL7j58LC+TDup1TQMxH1nJViFzfyi
 CAhci59XyDzBvkEX/Jw+S44Wx4eFCcTYf9QZ8EGZpo38Qlm2sg0ZfmVB5HNNzc2Se7ir
 dtEGu0sU0U/l+jReI2EFnSewl4ed1wXtMtuBnzua8MZwY9eY/j5iMMH0cs9/gNmt+7r2
 8B1xyTilJ4l25My5YyVzSnZKJ5xsZ4awPtAzG1MjxZwOIWjPqlSnYQvtj/xuZWHrJr7l
 lu3g==
X-Gm-Message-State: AOJu0YwtjhhjLNor3bhZ9Hq2Oc37dMF6sGKPDrYkaXI1TY6iFbMh7JaO
 qkIg8urIsByCCmPYj5OG3BGrlH2BSURyuaAtX59ekXkpP1NRzUsPEHrnCilNlwfQpxNa9m9LAgs
 p
X-Gm-Gg: ASbGnct2f1X4NhiKH3Qf+y8hmLyd/T7dPzwKCGJBmoDOGxXJBLtz5o0mGk1FshdrNj5
 bKG5So3x1upMtdkaYZiNsPRp5z+JQURw6tVt6djyukr1v53dm0oMFWpqFJd0msuDds/2KpmDKqL
 QnT60oaisST3FTlvc/+37NhysGj/SOXixlDw917hrTtNwAjacsi0i0AnuU87ainA56b5wEDTsNV
 f4Jko8N8aJVSGpgbLam7CpCIHvuOhslYBkSFBt+AxD09TiNhw83TmINOmsTzqP2nRJmjS4H0oNM
 W20ACxrGhPjwjtoiBUJqaZKy4tTwWHvk5te+O5zMR+csAzRUL6jzBSQZIbRAmONI/gB4ZVjZn3L
 jwTVd0VG+3aKJrSsl9pe8
X-Google-Smtp-Source: AGHT+IEfLOZVByKj+xgAVOHfaa0gz21gDzOj8DOGXHsB//Sm8rvH31F9UyoQav1e6J46198dQqd3jg==
X-Received: by 2002:a05:6e02:318c:b0:3d9:64cd:9490 with SMTP id
 e9e14a558f8ab-3d97c237f65mr9137645ab.16.1746138969972; 
 Thu, 01 May 2025 15:36:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aa8e162sm76335173.120.2025.05.01.15.36.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 15:36:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/8] hw/i386/pc: Remove pc_compat_2_11[] array
Date: Fri,  2 May 2025 00:35:20 +0200
Message-ID: <20250501223522.99772-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501223522.99772-1-philmd@linaro.org>
References: <20250501223522.99772-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd2b.google.com
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

The pc_compat_2_11[] array was only used by the pc-q35-2.11
and pc-i440fx-2.11 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 6 ------
 2 files changed, 9 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index c27ff262033..a81b9c4664c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -277,9 +277,6 @@ extern const size_t pc_compat_3_0_len;
 extern GlobalProperty pc_compat_2_12[];
 extern const size_t pc_compat_2_12_len;
 
-extern GlobalProperty pc_compat_2_11[];
-extern const size_t pc_compat_2_11_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d3e38cf9f92..2119029f4be 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -214,12 +214,6 @@ GlobalProperty pc_compat_2_12[] = {
 };
 const size_t pc_compat_2_12_len = G_N_ELEMENTS(pc_compat_2_12);
 
-GlobalProperty pc_compat_2_11[] = {
-    { TYPE_X86_CPU, "x-migrate-smi-count", "off" },
-    { "Skylake-Server" "-" TYPE_X86_CPU, "clflushopt", "off" },
-};
-const size_t pc_compat_2_11_len = G_N_ELEMENTS(pc_compat_2_11);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.47.1


