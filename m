Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69265C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 05:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1re7So-0000Qw-PS; Sun, 25 Feb 2024 00:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1re7Sm-0000Qd-8I
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 00:54:13 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1re7Si-0000Xk-6T
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 00:54:11 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3c19dcb76ccso18148b6e.0
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 21:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708840445; x=1709445245;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z0h/tZr/hCGr4S4UnF/XAb1u/9XUlLx2lJTHeHYzEvs=;
 b=r0Mp8uIaKIvNqa1QFsy2xOPNYSBk8V9i5CVdDyHEIHKqUpjwUrtXfhz5sGIiVOJnS0
 xopoWmUt0RCO+QU3N5rn2UU9gXeFyjioUpObeT3ophWC8eNXDbWulKonTeHC7q85ffmR
 59shLr+smbfakRdcHX6/JKo9zbTIylQdPVLTuWKWOd/SvDlmV0318J+D1r6/TD5A3B+N
 rPrll5IkUMSBW3A5ntyd5i69mCwvkOXdiDLoAcDCEl3aykD+nNBODJcBG3hxFygXt6Jg
 VdpUSF3JYYc/9FCWEM39ufKL49aRrUXU/Q/3FCMS4AJRkLKfxOxgZVVPuMjoYD7trHgB
 FxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708840445; x=1709445245;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z0h/tZr/hCGr4S4UnF/XAb1u/9XUlLx2lJTHeHYzEvs=;
 b=lxi26oQA5G5vP0dF2p7y6v9R0aWvwJwCfQCZRC3Sc/M/wVWpO4nBOsRbEyep2DtIZs
 g++9/75HojV7jzF0O15eRjKVnC5X1Wmw0yJvkpXKsISDSl/0i6eTb657QJTqBZAKgL72
 CZ31RplGjhFkS/v4p7/tste/DX/8LUzy6LNpY2rQ3Of5WkFbAbco0AZTgoBuH9ZIun8d
 YhAdq+cWEpk48TsjaCX3tg578OA1oni4utHRUnH6Kzul6FGS2Dd2NvTDDxBRaS7pwF8e
 OD/Jealv7N2ZcmRz8d5OaSpiAi6KX3qxjxYghIbhoR3ffakFgvJTcA0Zy2W1ksYjLnBq
 VxeQ==
X-Gm-Message-State: AOJu0Ywk49CyDu2RNtBZ9B0njNbmQTmDXsDeAAYwnNx6iC80EviuANJc
 6wH3+EOX8jajGMzjPS1Y2tnWsnHhx6pI4F9uotzvU4l1g8eSDBDzTFfHHflszhY=
X-Google-Smtp-Source: AGHT+IFA6fBnquAUKq3EfIAJLXHhVslAXjWIa5exNgZSxRqpf4PrUs0ZbOJLgLVVKskmt7eU5CjDIw==
X-Received: by 2002:aca:1314:0:b0:3c0:34b4:ee0f with SMTP id
 e20-20020aca1314000000b003c034b4ee0fmr3967648oii.53.1708840445313; 
 Sat, 24 Feb 2024 21:54:05 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 i18-20020aa79092000000b006e48b41aba7sm1893947pfa.12.2024.02.24.21.54.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 21:54:04 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 25 Feb 2024 14:54:01 +0900
Subject: [PATCH] migration: Free argv
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240225-argv-v1-1-a11e772884d9@daynix.com>
X-B4-Tracking: v=1; b=H4sIAPjV2mUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0NL3cSi9DJdU0MLAzPTVCODVAtzJaDSgqLUtMwKsDHRsbW1AMfCxsN
 WAAAA
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::22d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22d.google.com
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

exec_start_outgoing_migration() and exec_start_incoming_migration()
leak argv because it uses g_steal_pointer() is used to pass argv
qio_channel_command_new_spawn() while it does not free argv either.

Removing g_steal_pointer() is not sufficient though because argv is
typed g_auto(GStrv), which means the array of strings *and strings* will
be freed. The strings are only borrowed from the caller of
exec_start_outgoing_migration() and exec_start_incoming_migration() so
freeing them result in double-free.

Instead, type argv as g_autofree char **. This ensures only the array
of strings will be freed and the strings won't be freed. Also, remove
unnecessary casts according to the new type.

Fixes: cbab4face57b ("migration: convert exec backend to accept MigrateAddress.")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 migration/exec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index 47d2f3b8fb02..205675265ea1 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -73,15 +73,15 @@ void exec_start_outgoing_migration(MigrationState *s, strList *command,
     QIOChannel *ioc;
 
     int length = str_list_length(command);
-    g_auto(GStrv) argv = (char **) g_new0(const char *, length + 1);
+    g_autofree char **argv = g_new0(char *, length + 1);
 
     init_exec_array(command, argv, errp);
-    g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
+    g_autofree char *new_command = g_strjoinv(" ", argv);
 
     trace_migration_exec_outgoing(new_command);
     ioc = QIO_CHANNEL(
         qio_channel_command_new_spawn(
-                            (const char * const *) g_steal_pointer(&argv),
+                            (const char * const *) argv,
                             O_RDWR,
                             errp));
     if (!ioc) {
@@ -107,15 +107,15 @@ void exec_start_incoming_migration(strList *command, Error **errp)
     QIOChannel *ioc;
 
     int length = str_list_length(command);
-    g_auto(GStrv) argv = (char **) g_new0(const char *, length + 1);
+    g_autofree char **argv = g_new0(char *, length + 1);
 
     init_exec_array(command, argv, errp);
-    g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
+    g_autofree char *new_command = g_strjoinv(" ", argv);
 
     trace_migration_exec_incoming(new_command);
     ioc = QIO_CHANNEL(
         qio_channel_command_new_spawn(
-                            (const char * const *) g_steal_pointer(&argv),
+                            (const char * const *) argv,
                             O_RDWR,
                             errp));
     if (!ioc) {

---
base-commit: 5005aed8a7e728d028efb40e243ecfc2b4f3df3a
change-id: 20240219-argv-518065e20e87

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


