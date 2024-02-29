Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C4CC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 09:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfci7-0003NQ-LF; Thu, 29 Feb 2024 04:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfci5-0003NI-Nh
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:28:13 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfci0-0002sK-3p
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:28:13 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5c6bd3100fcso495338a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 01:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709198887; x=1709803687;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XYYMhwPjKWKZ+gKXxv+a+ugdek5N1Vy0cwNUDZ8NyR8=;
 b=SMrD9xV2VpL7eDI1xXUmQpLWK7IY3ghrVN/RqXXI+3BnQk6sw8wYqhImIkZ9N2PFEC
 ksmt4Ja0tCjQhD3PP15nfbHA8zJR0Y/wOcw4x/+y1LWTPB1euy04iBIkVGwpE3KsGpi6
 0KoHUw9/ErRJg8z/p0TLGpOqI8Qvm1GDTT5JfA3dYCXF1XH2Lqssqc5oWmWQsK/ygL61
 KKOgRVxQne9wXMnhuPBBm+BuFyy6Vgh7vLVpSumqPUrPrRRVA9Xa6jvNKH7bUkl0ScY2
 qb2pD6I9eHw/biEfJLBeGFtLWbz8zzWHmtZHacZK9vMVZjqUWzE4wMbNtLJgUP1HbMW+
 PFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709198887; x=1709803687;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XYYMhwPjKWKZ+gKXxv+a+ugdek5N1Vy0cwNUDZ8NyR8=;
 b=fcdNApQYoMH13vTndbnr1LS1/UdBb5zdeL1zu0hZPMxZzVJHWojsc/ADtmUwTt4N/i
 8o4JXXbE1iUCyNcFh9tVm6ye7FooC3zVSfHnJqsTWQj2Z97WprYMWgylv7Kdoz4RqfbF
 NiuF3yUUJDBFj+oc5uVyqbQE0Vf4Z63MieFzHNUYbGsogks3cO7/uBji25ru+s51GdBo
 sTzhKjTIRzvygfskeXiiSRgpvVUgvHfDCqelBq1++IdTUVrp9bONXVrONZbF5ivvCXWe
 FUNl65lkxk/dqdvrPyxUtaY1pabfmyQr6k4cA3Gnrg87nORSXSsnm3hhSkmIL1OWCavN
 PX6w==
X-Gm-Message-State: AOJu0YxgTb6IS/DA4vINbc4fMBsl+tc++9EISAEaW5cadJGnatWpbiSb
 YwfJGrmuPG/amA3J1875coICdS1Oznq0pwpVGQg/m7oI7u4PzJI+HRCpZhzoDB4=
X-Google-Smtp-Source: AGHT+IHMPhuDh9kEIoUBHPXxPioKrN6lsAZgug0XNBGlsDFqp31TR+JVGNX3UyuO8ioJp4kpD28Wfw==
X-Received: by 2002:a05:6a21:1786:b0:1a1:209b:fb87 with SMTP id
 nx6-20020a056a21178600b001a1209bfb87mr1836057pzb.37.1709198886629; 
 Thu, 29 Feb 2024 01:28:06 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 g10-20020a17090a714a00b0029ab460019asm978804pjs.1.2024.02.29.01.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 01:28:06 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 29 Feb 2024 18:28:00 +0900
Subject: [PATCH] plugins: Ensure register handles are not NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-null-v1-1-e716501d981e@daynix.com>
X-B4-Tracking: v=1; b=H4sIAB9O4GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyNL3bzSnBxdCxPD1LREAyPjZEtjJaDSgqLUtMwKsDHRsbW1AHHY85Z
 WAAAA
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::52c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Ensure register handles are not NULL so that a plugin can assume NULL is
invalid as a register handle.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 plugins/api.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index 81f43c9ce8a4..74e24f0697cd 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -442,7 +442,7 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
         }
 
         /* Create a record for the plugin */
-        desc.handle = GINT_TO_POINTER(grd->gdb_reg);
+        desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
         desc.name = g_intern_string(grd->name);
         desc.feature = g_intern_string(grd->feature_name);
         g_array_append_val(find_data, desc);
@@ -463,5 +463,5 @@ int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
 {
     g_assert(current_cpu);
 
-    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg));
+    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
 }

---
base-commit: bfe8020c814a30479a4241aaa78b63960655962b
change-id: 20240229-null-841efa023c93

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


