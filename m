Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C795C10F1A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 07:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s24on-0000QB-VO; Wed, 01 May 2024 03:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s24og-0000Pm-AB
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:55:51 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s24oe-0005Y6-Dx
 for qemu-devel@nongnu.org; Wed, 01 May 2024 03:55:50 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5d3907ff128so5182720a12.3
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 00:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714550147; x=1715154947;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KGbPlSfAvDM/uzK/W9updmSoT79Wi4JkaJZn2a5TBmw=;
 b=wCOB2VZcrg07csgFaMxN/NFi3NoQgHK+cjDR9pBqU0YcUBfTH3sQyBUCDWG78PTTzD
 2B09PJvrhj0wQM+aRpwqwW2TF7i0YqPXygCsW2T7pG7lJDUPKCm9nXmlKMtVH84NpwH2
 0EiMEjSHgchEeINWnUWBZpNgftrFUTKYxMtQ6cyFp027YEl+rRvJ/RdM4p3KvBm61ZpT
 005FyzFdTEbrfAI7GMnryltXpByY0OZoRQO6V6eKOiEWo6k46pLhERLPDGc9b/KbZQJc
 dCy491+PGURz2O+TShKWtUib2k2lmMr7bb/1H6ZaZ0vWknglVjE7wUa/xIxBb/ZuKFr8
 PfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714550147; x=1715154947;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KGbPlSfAvDM/uzK/W9updmSoT79Wi4JkaJZn2a5TBmw=;
 b=eZYZm4uTst4soW8HTI50WDyFSWjzRj90MSZ03NMimCCeU4c8f1V0PG2cJYK/aw1OkL
 wH+pYgiJk/tfl7NK6tN0pf1bkSwzs7Bk/JuCp7VS79/XQpWEh1h5F6wPwM0jfJflVPvA
 A6I1JlZpynNUOmQb2QjLr//NwCkMwFsrBPOeCqkqb5ztkafNTCnztivudbIedQETY2bc
 93VAI3NL0snwEPNBM13yNAXkedJVyUURmJqHroOjSohzhmKt2VA0w6cnN0vvSOOwQB8K
 qX/abIt7FAa4OYmBaEEKQRGBV351bkr19jRlspRQhBe7fLdTz3mXZ5zwS/hM65VZBjFh
 70VQ==
X-Gm-Message-State: AOJu0Yw9X/9S7Cp8F/Br3li3NKkhA7viTSgn13dqzvNIHss6BMMusM86
 6cbUzhRXKlPioubwea7W1oAVEDtcghFtdzW100WtfbJnK7dgNN0FF/dMK9tCrBdGlL/9+l894Q7
 0OzY=
X-Google-Smtp-Source: AGHT+IGRejFEz+VeOxUnVpEyT3h8lBbsSTbslIt2ts7WwKciphro39oC49YlnF+cM6qolhogYnyDyQ==
X-Received: by 2002:a05:6a20:4a99:b0:1a9:5963:e58b with SMTP id
 fn25-20020a056a204a9900b001a95963e58bmr2385652pzb.35.1714550146789; 
 Wed, 01 May 2024 00:55:46 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 e4-20020aa79804000000b006ecc858b67fsm22961367pfl.175.2024.05.01.00.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 May 2024 00:55:46 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 01 May 2024 16:55:37 +0900
Subject: [PATCH] qemu-keymap: Free xkb allocations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240501-xkb-v1-1-f046d8e11a2b@daynix.com>
X-B4-Tracking: v=1; b=H4sIAHj1MWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwND3YrsJF0jUwsTC+Pk5GTTFAsloMqCotS0zAqwKdGxtbUACFLsOFU
 AAAA=
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-01a33
Received-SPF: none client-ip=2607:f8b0:4864:20::534;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This fixes LeakSanitizer complaints with xkbcommon 1.6.0.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 qemu-keymap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qemu-keymap.c b/qemu-keymap.c
index 8c80f7a4ed65..7a9f38cf9863 100644
--- a/qemu-keymap.c
+++ b/qemu-keymap.c
@@ -237,6 +237,9 @@ int main(int argc, char *argv[])
     xkb_state_unref(state);
     state = NULL;
 
+    xkb_keymap_unref(map);
+    xkb_context_unref(ctx);
+
     /* add quirks */
     fprintf(outfile,
             "\n"

---
base-commit: c25df57ae8f9fe1c72eee2dab37d76d904ac382e
change-id: 20240501-xkb-258483ccc5d8

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


