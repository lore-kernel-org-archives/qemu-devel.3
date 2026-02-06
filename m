Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA102EE6B49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQD8-00085O-40; Fri, 06 Feb 2026 13:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCs-0007yy-Kt
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:26 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1voQCr-0001Ri-1Y
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:05:26 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b8869cd7bb1so178883666b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770401123; x=1771005923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDj3W3VJSOsTqOq/DOAQGw7i1dIQG9XZJxz/RTmuEbU=;
 b=WB78Y9ODdOaEc+wSxLvg6wbRfz9RPMCX5gXrk8xIlXeCRLg1/u/AsNa3LkqwLrC2h7
 l4xzgLqTsxpNSvM79cPprNK/31S3NgIarYPhcueJw4nKCbP/feh/pGjGtBFpbnsJ4KBF
 IDfSUm4QBhAV2jB1RWzcS929ldGTPwL3N53lPnXNLit8SbTh0RdUUNCbB6Hv2mG4ZF7f
 Uz5DCUMHZeTYuDc9uihmWDXkvIZR5u7Vd1P+yNLBJQ4fcR5f3wLUpkkebpAWsVZ1AEMt
 AZLk+TEnqNhxawX3C2ya9BVjOlapnVUwoXPne1q1G3oSpzt9u3hZw6/3kXUTVKlAZrx5
 a2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401123; x=1771005923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LDj3W3VJSOsTqOq/DOAQGw7i1dIQG9XZJxz/RTmuEbU=;
 b=Gg9dRWHMFacplGGjgygNkJmk/vr0sckALgYtjyYPhYWpQCUUGByzhWg+KlD6Ed8ez6
 Insdj7G4hcEZRA710Mt18fKmNGGxCIrbNpUSTnmkKcSvosQxV2FpLthCt7B3ApQH+pJO
 WDfH4suJ1up0OlDRlfbgTgY3XHKmXiVKVgAwUfB/3nU78LG0Yhk5AozYI9u+N1eeUZZn
 q3hjq75tOHBdkty4E1k6SRvhJviXZwayRMgFAIJUGmpci/ZDEZu+uibhwE3G4urWhqqm
 +0dXXmKf3cOKj/7JdPbjkVrB5x2x2GBdLhb4WsTSZLv3M83hwoFg8bZRDgdGGkHm6WZL
 MVUA==
X-Gm-Message-State: AOJu0YwPaIzcquPqNWelUUPiDLy/QUz40kb7BjqjtxkGwhXf1PCVoYNV
 LL7Q1eULY4ESvSGIokj6eHIsTsUqOLOW0bDeIH6z3TYLXc0jvz2mVTEBJvQQne/ZqJY=
X-Gm-Gg: AZuq6aJTPH0ATMSlBa7NyQcdr8X/K4UlE+SRzyEDTzas7OQpKCc+SoSgZ+YITqUc5Bt
 LynCAfQXeMvJmdZ47DtfemvfcWvCQpaernzhJmYi2IX/HYwfsaaKQwNfIYw337RB95f0abG6nd/
 X753poytVsbVLSO+365wQXmKnzcPcEw3l2DrGTAsIXQ71z2g/I7m01A8P09oIcf1PKlMG5RARub
 u6jluk0pX8eQvff2VebyAkfxgPJNOh00ASFYbGJT36vBJYcrTg5JlZQ2UbQ3AYv8SNTKQFyDm5E
 FCMkYf/gZy0bCXwREj6SJ1zkCtYjnBeSCfIVA5hfcMIWUNuPTJz+GVIHaHpLC8wW5ByR4d5vbE/
 DwOHkfGnuBBiiPdPOSMaL1/WpLyzdJ22dqE2K/mMb5ZFzKhYG+vrJE2uwlEoZdlAMNcX6PPgiCU
 39F1Ic1TLcDVY=
X-Received: by 2002:a17:907:2da2:b0:b87:711f:97b9 with SMTP id
 a640c23a62f3a-b8edf2fb575mr209458266b.31.1770401123424; 
 Fri, 06 Feb 2026 10:05:23 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8ef25388dcsm38965266b.54.2026.02.06.10.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:05:21 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 52615607CF;
 Fri, 06 Feb 2026 18:05:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yodel Eldar <yodel.eldar@yodel.dev>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 06/10] include/gdbstub/syscalls: Add EIO and ENOSYS GDB
 File-I/O errno values
Date: Fri,  6 Feb 2026 18:05:13 +0000
Message-ID: <20260206180517.1335861-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206180517.1335861-1-alex.bennee@linaro.org>
References: <20260206180517.1335861-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yodel Eldar <yodel.eldar@yodel.dev>

This patch adds the EIO and ENOSYS errno values that were missing from
the GDB Manual [1] when the other errno values were defined.

[1] https://sourceware.org/gdb/current/onlinedocs/gdb.html/Errno-Values.html

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260116014612.226183-2-yodel.eldar@yodel.dev>
Message-ID: <20260203115201.2387721-8-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/gdbstub/syscalls.h b/include/gdbstub/syscalls.h
index d63228e96b4..6200416f77a 100644
--- a/include/gdbstub/syscalls.h
+++ b/include/gdbstub/syscalls.h
@@ -22,6 +22,7 @@
 #define GDB_EPERM           1
 #define GDB_ENOENT          2
 #define GDB_EINTR           4
+#define GDB_EIO             5
 #define GDB_EBADF           9
 #define GDB_EACCES         13
 #define GDB_EFAULT         14
@@ -37,6 +38,7 @@
 #define GDB_ENOSPC         28
 #define GDB_ESPIPE         29
 #define GDB_EROFS          30
+#define GDB_ENOSYS         88
 #define GDB_ENAMETOOLONG   91
 #define GDB_EUNKNOWN       9999
 
-- 
2.47.3


