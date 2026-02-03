Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490DCE7FDCF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 11:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnExR-0008G3-1t; Tue, 03 Feb 2026 06:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEx3-0007wo-Cq
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:13 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vnEx0-00059T-8N
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:52:13 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-658cc45847cso8434269a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 03:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770119528; x=1770724328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XSrliXOCATefwQIn64R/qg8IArPF/GMhbm/SYSQ7GEc=;
 b=tzrpDTIh4P5p9GJ5JX4dHf0q5vkIxo3w354uoJ9adIX/lh7vrDVxtP1Q6+hLcdaCpC
 0IzVV8H1aNgUuBYAhydm97zeMqTzVwddrNQIKeT9RpsIOEPxOYW+lFuJJGSg+FqDHqdW
 n9VBIpQ0IHYV9T3K4Lk+NZ7pxi63j0z9KbFT+Xr1lUvRvxm08YACPszMNwAf/VL25C/S
 dUhgXWp0jfEMIkaa3zUelnJHmOK+Qz8bHbVx1Fno6Q8pgtX+drd/oIowrs0DbxcUJnTb
 sob6HsQ4NpjgYz0YgFjEF3mi6wICz0W3LI3YKKY8PV3Q3l6T3BzfCPkyKiEkZTmto1/b
 vJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770119528; x=1770724328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XSrliXOCATefwQIn64R/qg8IArPF/GMhbm/SYSQ7GEc=;
 b=OZh2/XdcuC24ag9M6z5rtuX7QvM/ma7LNIjfzp6LmAJYCeE7KXm9MCay+axBex6qs+
 8oAEAsuunqHHqDYmuMeFia9bRum7Hmi6rCo/kanwyzLm6iBz6MghLE/yDcMn/xVyzj+y
 V0fZ32G65/a919HBCmmhAE9fG/zS1KY0gItCJf67Do2XylD/S/4DyQBBbpKph1urhHzi
 +pEqVOQ7LyZIrFqglHYgyWufnsFQEzs2TnJwAUfFImBTediQdVkxjq+t+d205gtqg3eh
 sZfwOKsUMiUDcvcmBqoT+I7QAKX5jsRQB6KN2gD707a4nIXkH4Lg8aWd6nvzX9eDyHGm
 7ROA==
X-Gm-Message-State: AOJu0YzpZTZxl2IaIyVtv5YaxjSCQM7536YAoTUP7G6jLR0cnuO/nsfW
 X2O8pIzKgOuvkyM5l5fVKczL3y4TaVnq2lmYNjuQRLAgNpfFrxonG6uoEoCdMQGBl1Q=
X-Gm-Gg: AZuq6aLazLHa0qh8SEW/HqT8x9njN4RtbIZqW9hPk0QJiKekpQZgBJOCp60Z1pbVmpv
 ZqSXh34AK1W2luQCbE8yqBFzMfqfEpQLE3T7ec3BhmtLlLnCjl4omcTHyXKVaoXgA53EoLVLWS9
 JreWGORpPBTk90K0hzDvOvCJDMnu10lbEi1WJejK36kcM7h2kVSPm5C0Xsptm0sdGgH+WnSvwqM
 OT//hJjjiSUegocjxQgMKOJ+Pk0IoVvIdXY58SV9tOY7/xRUYfpiDmwKiQKajmJlZws28Rc4Nlv
 rr9RAGjRDUnIDxPUkaDauPYRRDJj40bdaj7ykmJkfaqz4YIiCLAdYbXDZWjJW9R9LheuRRludi0
 bzq89l3OQnTuGlUjF3vlrZ9rWMB1ZfOiN03YLfjXlWdn9kbKhUbPAgRtqzMnk6ilZks7D3U7EwM
 QKUJ/MR7EUur57NADoUb/LRA==
X-Received: by 2002:a17:907:70c:b0:b8a:fa35:989f with SMTP id
 a640c23a62f3a-b8dff696c1amr916446166b.38.1770119527895; 
 Tue, 03 Feb 2026 03:52:07 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8dbf184e5dsm1040894866b.43.2026.02.03.03.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 03:52:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8407060072;
 Tue, 03 Feb 2026 11:52:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 05/11] gdbstub/user: localise variables for reading gdb socket
Date: Tue,  3 Feb 2026 11:51:55 +0000
Message-ID: <20260203115201.2387721-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203115201.2387721-1-alex.bennee@linaro.org>
References: <20260203115201.2387721-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Keep things tidy by moving the declarations to the block where they
are used.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/user.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index cc71cda3e33..c7a3ef947ed 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -198,9 +198,6 @@ void gdb_qemu_exit(int code)
 int gdb_handlesig(CPUState *cpu, int sig, const char *reason, void *siginfo,
                   int siginfo_len)
 {
-    char buf[256];
-    int n;
-
     if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
         return sig;
     }
@@ -246,11 +243,10 @@ int gdb_handlesig(CPUState *cpu, int sig, const char *reason, void *siginfo,
     gdbserver_state.state = RS_IDLE;
     gdbserver_user_state.running_state = 0;
     while (gdbserver_user_state.running_state == 0) {
-        n = read(gdbserver_user_state.fd, buf, 256);
+        char buf[256];
+        int n = read(gdbserver_user_state.fd, buf, 256);
         if (n > 0) {
-            int i;
-
-            for (i = 0; i < n; i++) {
+            for (int i = 0; i < n; i++) {
                 gdb_read_byte(buf[i]);
             }
         } else {
-- 
2.47.3


