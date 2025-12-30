Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08102EE0203
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagxS-0004wm-UV; Tue, 30 Dec 2025 16:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagxO-0004pv-Fr
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:08:43 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagxM-0002Ff-Qn
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:08:42 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-430fbb6012bso8572882f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128919; x=1767733719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dq6gDL+VvfsJgspbVgIcSIatyQ9ZwkoXNNTZK0OwJ2Y=;
 b=nOSYvE14j1JQo7oEsjzulP0fd1vOeBl8elMXh+Sj+lEr1njJvpMaNCW1jEgtdMz7LX
 eGKbWuej2IsvEuL843vBVEmBhOrzBr4i5ve23h8ATZcbLYEjpCq1eWQyymFJaSdcZvTT
 GI883dGiDkcCrE/p+weecyzeQpNJr2l4TOf0bR6VzDVDa41ZW5LcgMLLsvbs9bZKpDEe
 ivClzYYJnBdeVbxKEug98XRvIQpe2D1kETC8fptyRZfSzIb63B8aSijaq07AkO2YmRsk
 YoxezBpFReWrrRmYCmFDLCg8ZE83x3yPtFS1VXalgM5tKDhB3caKbawbaLDWCE1yoUgk
 TPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128919; x=1767733719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dq6gDL+VvfsJgspbVgIcSIatyQ9ZwkoXNNTZK0OwJ2Y=;
 b=WF9n2foE1CRg4Xrx+5mS1V3wuVIGXPEADblv54oNkt1kT7r655SWawtxoYhuH9DlyJ
 vZM31pFWpeNpYkJVY5iagCC0HFJh5t6AF6VX30X9JXdxYQuOB+87LnOMhdxRTdzMVyfr
 9S0L4q3zEGWKDzQlL2hGVH+PwKtO+W8fieGwN/rwN9m5fXEbwCC78R4dgBAF0aD7/kdV
 lZkcX+BZHGGqBJ7PCuT4vCPPnm0rXYjJ9egik/rsWj0icFEmZWKsoEpHiOIF5jYQTD/2
 hr46kDDJwjnw4upUCVcKluFBtPuGywCgPFAcqnwV6u7uU6R1f3LAYRTgoMehF9y2tGhs
 p/fQ==
X-Gm-Message-State: AOJu0YyXbMvaOhhTHOp8RhyYsMRacTDp4TnOECIwEjKycURpwSexuoPN
 pXWjHWNREg2iKUFHwebwBBqN7l5vwoJ4LtJUBZneIltbkyOlaRG1PvsrTYP5AmIPOx/PWqKufCo
 fbCwNNvk=
X-Gm-Gg: AY/fxX71Vbu8Ox3ESEtm3RWK2CmqAhQ69xxSfe456nTiwBUjtGoS8am1CC8EhyS7n7q
 2uN2TTqvrb9lKmm5DAQX5i1hVGw1kj9zv7Kq5+3kvG19uAmWQaghj9wvaomrZUQv6EAS1m2g2Zs
 i4F+HHYIqafmQaajvi9StOKi0o8zp67NMvPt3WoR/UQqeiKG9FIQZnt49xcSDKnaP3H9JnC6ztc
 88aW70VERwRQ5dFMi/lOCXmsUYNI3ZoI/T/FOxJwpH0M2B8sLRfgEPxXsm0XBokXRUkFdeu/LZW
 pZ0rK4C9Q8S3Cib3fcGJtfPwxLuA8NvaF+f64uFxT6j8CFXH0oaF/Vf+pYEjvarFR0QtaLGpRW+
 dDfyUe5UMWOd5r3VTgg0UxCw9nZe8poTiA+uPVhopv5RpCFvc9y/+nb9B5rK4GGaN+pddBU2r1l
 aSpN78Swwu5ZFp0zTKJlOCGe0u0X16VgikZFd0zaP2RX6ROvplsA6OEQqQo2Hh
X-Google-Smtp-Source: AGHT+IEtlzQySgxjCQZCN/743cdzfbyg0bK42e6Plmkm5pEsW9B3rapzsVviqnsu30LtJBq6Y5WK6Q==
X-Received: by 2002:a5d:5d0d:0:b0:431:3a5:d9b8 with SMTP id
 ffacd0b85a97d-4324e510810mr41922457f8f.52.1767128918791; 
 Tue, 30 Dec 2025 13:08:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa46c0sm70687019f8f.34.2025.12.30.13.08.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:08:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/34] monitor/hmp: Make memory_dump() @is_physical argument a
 boolean
Date: Tue, 30 Dec 2025 22:07:28 +0100
Message-ID: <20251230210757.13803-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Suggested-by: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20251229231546.50604-3-philmd@linaro.org>
---
 monitor/hmp-cmds-target.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 2976f986d35..51dcb9e314c 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -122,7 +122,7 @@ void hmp_info_registers(Monitor *mon, const QDict *qdict)
 }
 
 static void memory_dump(Monitor *mon, int count, int format, int wsize,
-                        hwaddr addr, int is_physical)
+                        hwaddr addr, bool is_physical)
 {
     int l, line_size, i, max_digits, len;
     uint8_t buf[16];
@@ -237,7 +237,7 @@ void hmp_memory_dump(Monitor *mon, const QDict *qdict)
     int size = qdict_get_int(qdict, "size");
     target_long addr = qdict_get_int(qdict, "addr");
 
-    memory_dump(mon, count, format, size, addr, 0);
+    memory_dump(mon, count, format, size, addr, false);
 }
 
 void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
@@ -247,7 +247,7 @@ void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
     int size = qdict_get_int(qdict, "size");
     hwaddr addr = qdict_get_int(qdict, "addr");
 
-    memory_dump(mon, count, format, size, addr, 1);
+    memory_dump(mon, count, format, size, addr, true);
 }
 
 void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
-- 
2.52.0


