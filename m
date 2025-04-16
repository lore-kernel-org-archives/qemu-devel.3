Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF48C369C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 08:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4xwD-0001C3-0I; Wed, 16 Apr 2025 04:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xvf-0000zF-FV; Wed, 16 Apr 2025 04:15:31 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u4xvd-0005bP-O0; Wed, 16 Apr 2025 04:15:31 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736b34a71a1so7521893b3a.0; 
 Wed, 16 Apr 2025 01:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744791327; x=1745396127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54fvmwWjMs9r9UxnEGWRIsjHuD2f1lQSXGzb4EteMDc=;
 b=ejfh4lWaon5/yvWPNzCr041/ZLYHT/gbyu6fc4p0bdQYBHHUqlWFrNAdDyJps/SeYx
 diWjA3aW67X6VpyUcNn/69q6Gmcwkrn8NcXCkhmBAJ2Yao1WEFYnpPkkBCgyjg/EB2g9
 Rvz8aLEDhQSk99wsH2yryBBP6cURW9OhFQSva5o17vjgQWwhlRSIBfqwR9/tW0BaSZlO
 djluD4Uq2rNVXgHAG4fVpYuOtMd3lf8FichHj2FDRQUIox8kHFVbtjKNQj5w8xK2FkdN
 ZQ5OXX0Y52lSgoKXUwWEBGyeU7LwKCEneaLXxcgVAUYniUb9it3FRAcvgTiA183sXCpo
 ugBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744791327; x=1745396127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=54fvmwWjMs9r9UxnEGWRIsjHuD2f1lQSXGzb4EteMDc=;
 b=ZhGnyUiipwRonzfEu/E761T1GBLSYuWgYyPbSRSvDHbop9xSj2r/MjlqqJrxBVDepn
 DweDi0vFtrUQMZK1CRDf+r5+VbVev1r4iaaZhxR1CFZjYsmBrValQSwKt+v+Jhare4zZ
 QF9YByxd3EOxtf9XaEaiYxvQhMqacp9a0WmqN4/4qxMXXwQoROm30sOWWkxMUHBdxd+4
 quFxfagBhSVxf1EXWhkrCRbLMLplmxKBHPed9Q1b6vPUbcD7FNddC98FJ+K1zUkkYcng
 emoxR9cBFvjfPWwm8m+VjP5v81rrfwMWEUQypwnRPIdLGm7fHzr9KAIaj3Wg9BihCjL5
 HhtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDIF7Bzu/lE/wM8nSTNdgfO+e2PIBvf/AYLgW8Fbe3BmoszGcQ1YxFevrPdlFe+EhSuIJ+IuUkV8ULHw==@nongnu.org,
 AJvYcCW/dcafNPuUUTj3M4jDLT342kaNNbQ43TLtLIkxHN6G4JC6DRCFda6doW9Pfpvov7iwk16BhhnAXA==@nongnu.org,
 AJvYcCWKSv2PHJRzJAVxN3UucgnDuTKunf6/PE4/QoZIDfAzwXj7AXdWX6M3XuRHxJQI8Mq9cwQnTcxaS4f/Ag==@nongnu.org,
 AJvYcCXM7zhbe4efSJImiIkBdeY0vgCSEHnUgGyh6bTOkKnFTiuMOkLHGI01w5h16S8BK9qX+MZdKmvMRYw=@nongnu.org
X-Gm-Message-State: AOJu0YzsWfFLVSpJ5irOUd1fcpvUrLoCGpkNTj6AjzLFk9+LTDoytSGS
 UeV69pnXYgol2KHjp3nksGxC5aXtlIW/AbKnhZhw3KMFm0SGIjdWC/XtJ0df
X-Gm-Gg: ASbGncuMYxhKqA86XSd3wd44EpIHBRkeSPHy3gTjmf9bc9l1UNGEr23wEClRfmQCSYX
 Thh0bh4Fl0EceGmz18sHsFM1+UVNVlE14sZTX3XFG8LgWPTlq9ie4N6bl3p1DbTebpUyrfuPRyL
 9otqRJzpPWpu3XGEIhQERIV2/DnNyoj0itpiYaUgNy+evuBM54Td7ZG4zMq0rfF8elEf/tdWpeW
 7J9qeYOJN8wjHZe8/tUE3Tv0f0XvxuBSKp46w6G1OUgZNucmRzR7wCnaCWyd70BSia51WcvVun6
 qumS/+NTRFWLVrGnwH3EC6/fBs9q1nsL1A3U+9hd3ZxgIZX/zaTS3OyJd/EQCx6ujRxt
X-Google-Smtp-Source: AGHT+IFsEp+s42sEcYEFipg6DWWv1zGm/h/cH9AFZLSWq7fBYiIxmgXiSE9RfWArjeKLVvHcyDiDpA==
X-Received: by 2002:a05:6a00:198c:b0:736:a638:7f9e with SMTP id
 d2e1a72fcca58-73c26700979mr1705820b3a.8.1744791326551; 
 Wed, 16 Apr 2025 01:15:26 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:ee5a:e672:7d4c:d43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd21c3263sm9839445b3a.38.2025.04.16.01.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 01:15:25 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 03/19] system/vl.c: Fix type conflict of GLib function pointers
Date: Wed, 16 Apr 2025 17:14:08 +0900
Message-Id: <b7e0092e8e7157ae659e32e8ec0e54b778cc1909.1744787186.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744787186.git.ktokunaga.mail@gmail.com>
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On emscripten, function pointer casts can cause function call failure.
This commit fixes the function definition to match to the type of the
function call using g_slist_sort_with_data.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 system/vl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index ec93988a03..8d89394b45 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1523,7 +1523,7 @@ static bool debugcon_parse(const char *devname, Error **errp)
     return true;
 }
 
-static gint machine_class_cmp(gconstpointer a, gconstpointer b)
+static gint machine_class_cmp(gconstpointer a, gconstpointer b, gpointer d)
 {
     const MachineClass *mc1 = a, *mc2 = b;
     int res;
@@ -1573,7 +1573,7 @@ static void machine_help_func(const QDict *qdict)
     }
 
     printf("Supported machines are:\n");
-    machines = g_slist_sort(machines, machine_class_cmp);
+    machines = g_slist_sort_with_data(machines, machine_class_cmp, NULL);
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
         if (mc->alias) {
-- 
2.25.1


