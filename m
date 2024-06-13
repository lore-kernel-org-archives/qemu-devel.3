Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2ECC27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 08:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHfUC-0000Xx-WD; Thu, 13 Jun 2024 04:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHfUB-0000Wb-5I
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:07:07 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHfU9-0008Ib-I1
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:07:06 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52b7ffd9f6eso795841e87.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 01:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718266023; x=1718870823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0HL0/tVcV9enNc0XY8fXI7wJenL+7Z2ycjUc8zKtd4=;
 b=UKIzJfAtTRn8uv/Yg42EQfM9RaCJH0L9K3IS0aH0ESnBBaLWMUMgyDIWAm18NO4yOk
 FcDei4LRbYMwqc20dwJWDWhnXXgxrWShXqgy42U0SWE3+DVEAStFIAKii+mYitMBy5Q0
 +sVoCyxf5iu5X755mCWKWnr654XnTT1ylkKBi1yxh2K3GKcR4vRCr8S9FGTDh4rPQwVM
 T3uUjmU5Ky5Op3q2hBFxm1zI5isz+fOaK4J6hYYRBOeDsZL2VKCUiDvVMkq5trQBgC1F
 fRyYWg9gHSIhhOaiciP5voOA8mhi+9ve83TYeTM/JoD0PofK4zKBkGW6dGxNoOkxtqsP
 qytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718266023; x=1718870823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0HL0/tVcV9enNc0XY8fXI7wJenL+7Z2ycjUc8zKtd4=;
 b=HazOsSGA2KkwCtqr0zEYE/58dWF3nFqKrjGdhvBzytLaRJrtIgQLAwITAbE5Gt0ek+
 1MxK1Gh/D1x+XsFxHlKnE9DBBftwEmWuXwt5CexDBHhGEm277RNtSqEvgeHOG7qLVAzq
 CHszOzrllA7o4HEJ1CjoxSr3u92fXhkmf5WqguN42IlLMphRCsQi/ATCsFV+TSqjw+Go
 pUwBrchN3oKrYDv+Yxnvmx6a9/6OCGiAScEROk9FODAmN3fpf/H23EAkY9w5yZVVEf4F
 k3YQ4Edc0bq6+mBcmEJ0Ns3QXBQt8ElJm+ce0G/LjGl4TkbYzS6tYMGNlPH42kVLvJi7
 zjxw==
X-Gm-Message-State: AOJu0YzIrYrPmTf9LSfkFt1/fIZxlRdhZhrnwBUPkjVE+c4m/iN+Uzrt
 99TH1oCwXyKiYJCe7OuK43U3UPxfL16Nfl0u0m01SsmPu3CVtlpjymgQ+rziNmeyHIZ2ITIVOv7
 OsII=
X-Google-Smtp-Source: AGHT+IFruD4qHGal+kOkwGFXynZZ6VzLjNsVBDoNtj9Wx6s9l7aUVTeuodBnamQmuHhtx6+B8e1yOA==
X-Received: by 2002:a05:6512:6d1:b0:52b:c29a:7493 with SMTP id
 2adb3069b0e04-52c9a3dd87cmr2987858e87.33.1718266023524; 
 Thu, 13 Jun 2024 01:07:03 -0700 (PDT)
Received: from localhost.localdomain (adsl-105.37.6.1.tellas.gr. [37.6.1.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104d88sm910811f8f.104.2024.06.13.01.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 01:07:03 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v1 3/3] util/readline.c: add C-u shortcut
Date: Thu, 13 Jun 2024 11:06:13 +0300
Message-ID: <6772067e1c0d4b1c5310e5446e9e3e1c6b3b5bc0.1718265822.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <readline-shortcuts-v1.1718265822.manos.pitsidianakis@linaro.org>
References: <readline-shortcuts-v1.1718265822.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x131.google.com
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

Add support for the unix-line-discard readline action, which erases from
the cursor position up to the beginning of the line. The default
binding, C-u, was chosen.

This is useful to quickly erase command input while working on the
monitor interface.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 util/readline.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/util/readline.c b/util/readline.c
index 0b627d62ad..0f19674f52 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -271,6 +271,14 @@ static void readline_hist_add(ReadLineState *rs, const char *cmdline)
     rs->hist_entry = -1;
 }
 
+static void readline_kill_line(ReadLineState *rs)
+{
+    while (rs->cmd_buf_index > 0) {
+        readline_backward_char(rs);
+        readline_delete_char(rs);
+    }
+}
+
 /* completion support */
 
 void readline_add_completion(ReadLineState *rs, const char *str)
@@ -426,6 +434,10 @@ void readline_handle_byte(ReadLineState *rs, int ch)
             /* ^P Prev line in history */
             readline_up_char(rs);
             break;
+        case 21:
+            /* ^U Kill backward from point to the beginning of the line. */
+            readline_kill_line(rs);
+            break;
         case 23:
             /* ^W */
             readline_backword(rs);
-- 
γαῖα πυρί μιχθήτω


