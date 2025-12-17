Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00834D64077
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 06:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVkaW-0007qq-L3; Wed, 17 Dec 2025 01:00:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ftyghome@gmail.com>)
 id 1vViiM-0006eK-2a
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 23:00:38 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ftyghome@gmail.com>)
 id 1vViiJ-0006A9-Te
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 23:00:37 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7acd9a03ba9so6092136b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 20:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765944033; x=1766548833; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cnjuNhU4n5ECdj+GuIOGfvhkG5QgNt4AjGkGGZYjyac=;
 b=IYz7dmKwm2BxJN0yRcfy9f9Rk86eTxwSJF9pdOXPVjMSaSepzvph2r6AnLO1wxHDk1
 FmZL03dJA0BWbUHuc2fdsOdeb6s4BBHtIvbhwOWFyN1D7SmzTujZ9InqeMiIWrB42A5E
 lT/Luii/6TnxddtVlHY+iWyQ2/TmhPPYuhZDmM5qH2Rh6PfIggWzcbRR0hCjFWrhMrsY
 EwtS6Gtu0v3b23u8Vx3QaxB8KoZLfMukmHDurvoeXdJ4Al7lByLliY0FIjQnBFlkxMq3
 ytqo3ok1vEJOtfq+hO5O30lG3Lst2T4JcJMG8qwNNu+kIJLgF2nBr4MKc101NIu0K7dO
 yX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765944033; x=1766548833;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cnjuNhU4n5ECdj+GuIOGfvhkG5QgNt4AjGkGGZYjyac=;
 b=njuRGaQ0lGxLwiQWQnDF+0A0mJ+PFBzht+ogsNSJLqWdcfq5zuHdGB0k7XDxWTuC+w
 PwMuimJaDFNy/pB5g830FNxYSfG0KvweO/NAZrcJjOMp3eepxM9jjxqwG3zJ4vyh47+D
 B+7Y/GNf2pQh1TrE6r20aF6FtGZBKzGGy8p4RQfGi86DMUgPTw80nY876ME+XNVzustX
 c5lKgX77em2sXCO/FZ69QOEmO0NrFa9tTTYrD7oMdfF3htatQdENsBhZvlH6zj75F+ID
 06bIbYUUXWUSbwGaCJexZzMWpmkFhO6jNkk2oRRC3J8Om4JfecUc2JbKUSVRTSPwWbDc
 IYxg==
X-Gm-Message-State: AOJu0Ywv8aqMxvN8veFZKKX5js5tyqu422SErmk8kmSPpDLSteP/OPbA
 6hk9lwqafoov5/98CSwNFWK/JpCpwiFRS2geST142Zkob9ln6Wx6UtSBPRZ3r+ANf90=
X-Gm-Gg: AY/fxX6knNXPnpfJbprDxyaSDUW9fMRBc9mEJ8kGeV9RN2Iu0yDMP5N2c+qngZat421
 aea52rzBPJG1n7/2YUtUfyO1Idt4vI7c5PQSqyGrCX1c37lFD0OzjYzJNKGM6UHD59vlCejpSv5
 laOX9CPP8pPxCStQmlB6xXzwlu6PfWiYn177DhpO+hMc0p16BxGnrbULPwJ+biYUGhucGXyfZ7w
 BIepOIui8IuFRc4S2eKOx4Y2XxWWF9RkeFfiYzKH/98FnaYvKlQ31NBUpo+Vj6PCgEH6xjd4T/2
 1XdvVpy6mdikchS4VqZ2bpJVfzO/Ok53htGV71tRYNBrFb+nHjGJ+iqIl6QPSLJHiHvBfWnQdQJ
 79KW3+we/8zca7zpjVjmOVOsNWm1lG9sNtI/8pfT+Ib94XH8/TaUDEIS1STKmlNzMskJRzHmBAp
 utcnN8UqhnqDE=
X-Google-Smtp-Source: AGHT+IGTWUiC/1SKzPlNK0GBji8kTc+08RKPwnZlOKNzPSEHx+hZjYTO5SaoGdm5CrP3M0AnK1khfQ==
X-Received: by 2002:a05:6a00:299b:b0:7e8:4398:b351 with SMTP id
 d2e1a72fcca58-7f6691b2aacmr16214537b3a.36.1765944032821; 
 Tue, 16 Dec 2025 20:00:32 -0800 (PST)
Received: from [127.0.0.1] ([188.253.121.152])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fcbb6fa347sm1089305b3a.45.2025.12.16.20.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 20:00:32 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Date: Wed, 17 Dec 2025 11:59:52 +0800
Subject: [PATCH] qdev: fix error handling in set_uint64_checkmask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-qdev-fix-v1-1-bd33ea463220@gmail.com>
X-B4-Tracking: v=1; b=H4sIALcqQmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0Nz3cKU1DLdtMwKXSMD86TURKMki0RDEyWg8oKiVKAw2Kjo2NpaAJZ
 0CIlaAAAA
X-Change-ID: 20251217-qdev-fix-207bea2b8a14
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Zesen Liu <ftyghome@gmail.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=ftyghome@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Dec 2025 01:00:39 -0500
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

When specifying lbr_fmt=VALUE in cpu options with an invalid VALUE, error_setg() gets triggered twice, causing an assertion failure in error_setv() which requires *errp to be NULL, preventing meaningful error messages from being displayed.

Fix this by checking visit_type_uint64()'s return value and returning early on failure, consistent with other property setters like set_string().

Signed-off-by: Zesen Liu <ftyghome@gmail.com>
---
 hw/core/qdev-properties.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 422a486969..0930d64252 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -494,7 +494,9 @@ static void set_uint64_checkmask(Object *obj, Visitor *v, const char *name,
     const Property *prop = opaque;
     uint64_t *ptr = object_field_prop_ptr(obj, prop);
 
-    visit_type_uint64(v, name, ptr, errp);
+    if (!visit_type_uint64(v, name, ptr, errp)) {
+        return;
+    }
     if (*ptr & ~prop->bitmask) {
         error_setg(errp, "Property value for '%s' has bits outside mask '0x%" PRIx64 "'",
                    name, prop->bitmask);

---
base-commit: 7154e4df40468012fccb6687ecd2b288c56a4a2d
change-id: 20251217-qdev-fix-207bea2b8a14

Best regards,
-- 
Zesen Liu <ftyghome@gmail.com>


