Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB52C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 17:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaHSm-0001ob-OC; Fri, 11 Jul 2025 13:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSj-0001jv-7g
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:05 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaHSh-00030m-Iz
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 13:23:04 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-40b31468da3so742593b6e.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752254582; x=1752859382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbvFJbF5XPFsYap/Rj9OWqngvL2EB4p0iDRPnlUGu/U=;
 b=y7YNWV8Hbn7MsX7taoPKf03IL900ngkmaJklhsLLCFxTQJNaKeLG7WE3/CtGbSNtJC
 RMBEnEIJIBaHXcfRzlzbwJOTdn9z2xZR8UqoSSDnN//LQ7dxmsYKjZX/5MFjlJIq9Lei
 KgWSGLgXUASrptzOAhOdNeIQw0jAT0U6AmF0qlb3qBVVCsljCQ2hYKcQgUmPDsya/LbN
 MmwCZ9taTimzdxBZIP0HrW7rSGewEtYdeJVwusKgJm+OUBERXGXZYTAoBlDNGxz+fuiU
 APv62OKLY7waLbfNISRpoPTMIMyuQcnTtWgQAtaDNYMDSC5rzJ1wk8JTxZqrRJVQQkPj
 ekuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752254582; x=1752859382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KbvFJbF5XPFsYap/Rj9OWqngvL2EB4p0iDRPnlUGu/U=;
 b=Xg8MiwAT+hP8SqRnaNudOH9kCOOV7nYHEr8b9IY8v0QHdKA+kXTDgeQ9P6mzl3xn92
 wfO+PmnmWzLIrNq2hxpOIEcT3MG/54tvIUxBbltNmM378cDWcnxAYHrZI1ORTBgLgNYt
 cjoyo1jimVfmow/cumlxNZq+TExNcpc5hXkMfLdWs71xoL6/htLn6WD2RJ58sGz4b62x
 zhiNzoKieeJBkc/mexY6oHHKI0lnSe5BpyD5Fpru58btqI9E/axUvyRja1ly0RnKTZhg
 4mPJhywdm+WCuAGtOvTK4mxHlxAfY/N80fcED0p9KzjQyaMRO3ItR+iXgBdoYbO9IqUj
 8OBw==
X-Gm-Message-State: AOJu0Yy6VYkh2rN9J/jgpN92Lo5I/GG44QCLJ7Pw2y9UrqMh2wGhNikV
 uj2yY1iFLLhlmwbDwF9bE2XfVbKWIF0d1RCTrjgLWF5ZASnCU4hVNexFfzRG+8XXQ0dg9MtAtZk
 6WQJ2j+s=
X-Gm-Gg: ASbGncuI0hS0JIKxEEZDDM0sw+T5hsyRclhyDxpEPIS54jc0m8Pm18HHAHOnG2gisuc
 odI+Rx99zefhKa+fWeMx+ZyV/QgNyAX0FwFqzibKMOxi2YEp7Htypsfx0qFvNsIgKWxzfSKAuTN
 6O/U/mow4PW/IOxZ1Wqb6ZJ9Us/nD9i8fpSobDGkyIpuOvZiiaUqYhHfTHDdduyMRKtA97vEujw
 I2ovw8LoK0I7gmIrEB5VUj7aB7vEdk6zCI/PU8vT8Cry3W8YNIqvlRrUIF3beKnWft1NAmnfoRw
 S3I7RftLcMDuZjT32GSxSvvxodbNiKbZa1LSu8hbaBuuCRcXqDTKBALsw5j5yHWOqlzTKIX9JF6
 qnMpD7XF+5Ycmx2E1zf9BAjF20+9Oe7gsmyuvhsaLQeb/BQ/rrkWuLggyu2So0oKT6o63Lxau7l
 4hzC7wAeWj
X-Google-Smtp-Source: AGHT+IESlgROdwpepOV+/wYlJRog07cgPlcOGuNab3KUFrXmBvMGhd5f8grJwmewYoCab7KqCd8G8g==
X-Received: by 2002:a05:6808:6547:20b0:40b:9948:f26c with SMTP id
 5614622812f47-4150dc288bbmr2277044b6e.12.1752254582130; 
 Fri, 11 Jul 2025 10:23:02 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141c77ada0sm602041b6e.44.2025.07.11.10.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 10:23:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/9] linux-user/gen-vdso: Handle fseek() failure
Date: Fri, 11 Jul 2025 11:22:49 -0600
Message-ID: <20250711172254.229201-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711172254.229201-1-richard.henderson@linaro.org>
References: <20250711172254.229201-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Coverity points out that we don't check for fseek() failure in gen-vdso.c,
and so we might pass -1 to malloc(). Add the error checking.

(This is a standalone executable that doesn't link against glib, so
we can't do the easy thing and use g_file_get_contents().)

Coverity: CID 1523742
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250710170707.1299926-2-peter.maydell@linaro.org>
---
 linux-user/gen-vdso.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/linux-user/gen-vdso.c b/linux-user/gen-vdso.c
index fce9d5cbc3..1c406d1b10 100644
--- a/linux-user/gen-vdso.c
+++ b/linux-user/gen-vdso.c
@@ -113,9 +113,16 @@ int main(int argc, char **argv)
      * We expect the vdso to be small, on the order of one page,
      * therefore we do not expect a partial read.
      */
-    fseek(inf, 0, SEEK_END);
+    if (fseek(inf, 0, SEEK_END) < 0) {
+        goto perror_inf;
+    }
     total_len = ftell(inf);
-    fseek(inf, 0, SEEK_SET);
+    if (total_len < 0) {
+        goto perror_inf;
+    }
+    if (fseek(inf, 0, SEEK_SET) < 0) {
+        goto perror_inf;
+    }
 
     buf = malloc(total_len);
     if (buf == NULL) {
-- 
2.43.0


