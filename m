Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0135CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 22:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5X6w-0003GZ-EZ; Sun, 05 Oct 2025 18:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v5X6u-0003G5-CE
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 18:21:44 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1v5X6s-0001lO-8n
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 18:21:44 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-57933d3e498so5725659e87.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 15:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759702899; x=1760307699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nexgf6hd/Qhctp9El5zgWCdHTRWfKODP1WxaKeNvDkM=;
 b=Mm1vSJ1S/EhB3QKRoGZbz067Ozlsz3sJAlIaNqSUoLRqyH6B5XETWI/Y7/V9EzQFjR
 pfClSuf5/Jsj5NLNq0YC4YvxCHUrTcnOf3xJVeF9LEnzr7ekrQCU10of71pglJLbKPel
 wA62t+aoUgK4RWNmx45p4YDfck+xLgqU2STkJlPNUqaFExSRsMVW9srFr20AyfJj4XuP
 0HNWbXhXI934vH10ACiISQDX2jjTXQ9pnRytIKBsSh0fQBq9prWvbtgrZWSCIttkEEZW
 4fVfUhR+2GUNBoFsNDaUI8Ki1Z6LILdpk4VdYAjjREik0pAmkoUlaYQnO9Dk5QvVAMTB
 fSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759702899; x=1760307699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nexgf6hd/Qhctp9El5zgWCdHTRWfKODP1WxaKeNvDkM=;
 b=b6Lf0Xg6WR6pz65a1mp3huP72Lhop0+umfcrJiA2ZdCUbiILTyYohU/xdBMgG41udz
 rynoQXAU3xY8Y8pR8b8jVOl/SegSUH4vY3S9kbPoXKDoaPr5tEE15GMGptyZ6suj4zSk
 2TX2A09vD2V27SfzGZacZTiomILD79xycGP78G4KBSw59eF2vVOFijPoHj+xWoYB9SG9
 ur5zObKVhPsnXnQ90/aG8TxhaGcyXVEcaV7tdUMGZQ1vySjOmVEp+coQmkr/miT+Zhci
 dkUv+TlA86PbLDIRlNTYFHoqH9h/HtovWM/wO7qFXs2fS9pF+ItLtVtmm/o+g7tRrax1
 rj3w==
X-Gm-Message-State: AOJu0YwPOK9RnZM+LPHaJkcMoUgGnJ1ihUcTm1Z8Gg9ivWTBcO98ITJr
 rXwRHyg7MuJoqsLyGxyLihv6SNsfK2GzKvQXtdQIarZ51IAmuID9gIz62prUvkzYr4I=
X-Gm-Gg: ASbGncsLM/Nh8G9GWKXa+M64wE6EpIvnfOzn7o+5dOeuD/GHj4REMVj8/fEDCQlOG1C
 8QEv+V7wcgyD98vyU9XLb/VCLn1gdzYS/zDh26nWXM7BDS4X25rV6PrtWUGs2WjFdIeTpIWjM0l
 em4D8g9D6grHQwDWRyWs2YF3dhxd5pHFWlqIDzjDIn1aMY2l+wICRnt4SqzNR9G2q64gMwR44YP
 HVyqamM2MXOcfexJXg406MK6meliiRN3C17YbBRpR9kv9VEzlDs4g+8XHpzoXMJnt5XUkiW1NmI
 Y0JT9JJMBfMBBrHav9jH5C92g8eKBIHJxilo29EDxvyQKVSxqfnH40Z8ZdZd97+QjZr/pmeFJ5w
 mOWkhr4bkgo6whYh/iPA0DQz/HOpQPKVMz6g6nrgszxbDMqdaaISA/DN2BJKSPsPLvWpsUw==
X-Google-Smtp-Source: AGHT+IHqiqq1Ga87SCS/M5ccId0NssfRavsYAMm5mFYo/OFF6nsontz+73I9fn0VLmka5OED/6AIsQ==
X-Received: by 2002:a05:6512:3d27:b0:577:285f:32bd with SMTP id
 2adb3069b0e04-58cbbdd81eemr2742917e87.26.1759702898999; 
 Sun, 05 Oct 2025 15:21:38 -0700 (PDT)
Received: from xpahos-osx.yandex.net ([2a02:6bf:8080:c37::1:1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-58b0119ee99sm4351827e87.106.2025.10.05.15.21.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Oct 2025 15:21:37 -0700 (PDT)
From: xpahos@gmail.com
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-trivial@nongnu.org,
 Alexander Gryanko <xpahos@gmail.com>
Subject: [PATCH v2] system/runstate.c: Add a newline character to correctly
 log guest errors
Date: Mon,  6 Oct 2025 01:21:27 +0300
Message-Id: <20251004-add-newline-guest-error-log-v1-1-a61df1599936@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <32D0DF37-A1B3-4532-B350-082E19E4EABB@gmail.com>
References: <32D0DF37-A1B3-4532-B350-082E19E4EABB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251004-add-newline-guest-error-log-62d68638b28c
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759599468; l=1584;
 i=xpahos@gmail.com; s=20251004; h=from:subject:message-id;
 bh=rvwWS/RTpcBRE43Pzrs+MfGd8cC10dbKpihj81a/57o=;
 b=+LjQuITtD0JEG02JJvL+AhM2l1Uq5u9EEFQc1OfrIm1pLBzveSkMxF6uRDo5Gjvprys68NKRZ
 mR8UXF/vEJTCFYsQYKk4oBFYMZV4I03p5jP5mC001Q4Wzc0uGXWbtML
X-Developer-Key: i=xpahos@gmail.com; a=ed25519;
 pk=bsSvP3Tn7PVKgjJT3BMV3jlAwSqreKIM4099C1r51eg=
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=xpahos@gmail.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alexander Gryanko <xpahos@gmail.com>

The pvpanic handler calls the qemu_system_guest_panicked
function with a NULL parameter, which results in the absence
of a newline character in the guest error log.
The qemu_system_guest_crashloaded function has no additional
logic, but also omits the newline character.
The qemu_system_guest_pvshutdown has no reporting in the
guest error log.

Signed-off-by: Alexander Gryanko <xpahos@gmail.com>
---
 system/runstate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/system/runstate.c b/system/runstate.c
index 6178b0091a..8b4bf75cd6 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -674,18 +674,21 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
         }
 
         qapi_free_GuestPanicInformation(info);
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR, "\n");
     }
 }
 
 void qemu_system_guest_crashloaded(GuestPanicInformation *info)
 {
-    qemu_log_mask(LOG_GUEST_ERROR, "Guest crash loaded");
+    qemu_log_mask(LOG_GUEST_ERROR, "Guest crash loaded\n");
     qapi_event_send_guest_crashloaded(GUEST_PANIC_ACTION_RUN, info);
     qapi_free_GuestPanicInformation(info);
 }
 
 void qemu_system_guest_pvshutdown(void)
 {
+    qemu_log_mask(LOG_GUEST_ERROR, "Guest shutdown requested\n");
     qapi_event_send_guest_pvshutdown();
     qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
 }

---
base-commit: 81e3121bef89bcd3ccb261899e5a36246199065d
change-id: 20251004-add-newline-guest-error-log-62d68638b28c

Best regards,
-- 
Alexander Gryanko <xpahos@gmail.com>


