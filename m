Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52F0E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 09:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMOHk-0006Uo-8i; Sat, 14 Dec 2024 04:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tMOHi-0006UX-Eo
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 04:18:02 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tMOHc-0004kP-1y
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 04:18:02 -0500
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-5d3d14336f0so4500863a12.3
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2024 01:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734167874; x=1734772674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qszqZMQ0FHL2LU/f/AHoxskxZJYUgdn2A4lJkbne9X4=;
 b=tWiWeNgCh5f58izlorx843iqCTR7a7CVyC8gseLEwi/GKfBp+h19SL7EENXpHfIr6b
 HITQKdcsAwZgg3UtNqSUK3aa++kUtZGvLvSuZ603jeYqtPQLFCyz43oLYERCRIf1VnOq
 kGNPETWVBvg1UbAkRTlREp4iIUOK13bYkolY/YsqPktQ9aCZ3YR8Ydf24v7hnL+Vdiyk
 eR9VEIW4IdreIY+JG2QaEZnf1VFrgxqJth0f7oM3BR7pwYYFMzFgdiFcfWNk+W4mBQ0R
 cST+W7nNupegmNk9SbQgDm346HmIyiF2f3RAwvGyC083ib7y9CTS8CdPFHJ+xltQ02vC
 n2dw==
X-Gm-Message-State: AOJu0Ywr0XE+PxP4kEEjFAsWzgNtOsjgE/7KfYLd0RslVLbo/rQEohm0
 QYC7DO01kFStmtr6uNMqGKWIAE7o8ySUvz7GUT8lTbJ9JyzrqeDRBNPdAg==
X-Gm-Gg: ASbGnctodHIbyruBwOZZg7JWpcrJPdSUTUHtAau8nNUYsyZ4RdUaSBm726oNJI3rt+K
 WsWXybe9DkU2ZMIVIq7znj1r2xwWw6oXEc3aRQh1JreAK/J5j1Xntedy1j36dygBNsrAEIOq06Q
 ttx3NYCJDT9gLgHhhjQDe1wkpxc7kk4HZhUTyFWDSGjndodu9+oDBf+BQxgWdJyF3v09yuIViZ6
 R1z3GSslraGF/YwbQJ3oysiem9TbhidM6D34M6WGg2p5r5OUcOctfcx0kK3l93VJcILiFnvTXKl
 9fw=
X-Google-Smtp-Source: AGHT+IFL4s3W6g7wu8hOqu2zg+iu0lCo3bzRrudQEU2Zf/HzSqORU7hzaHEoz9iWwFaSsZ8xOGpnXQ==
X-Received: by 2002:a17:906:7953:b0:aa6:8676:3b3d with SMTP id
 a640c23a62f3a-aab779b051amr682636266b.29.1734167873822; 
 Sat, 14 Dec 2024 01:17:53 -0800 (PST)
Received: from tpx1.. (ip-109-42-51-17.web.vodafone.de. [109.42.51.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab9638ad42sm70147766b.135.2024.12.14.01.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Dec 2024 01:17:53 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH] hw/m68k/next-cube: Disable the default CD-ROM drive
Date: Sat, 14 Dec 2024 10:17:20 +0100
Message-ID: <20241214091720.49779-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.49; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f49.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The NeXT-Cube does not have a CD-ROM drive by default, and the
kernel does not seem to deal with the empty drive very well, so
let's disable the CD-ROM drive for this machine.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index f576452fc3..de7ce13762 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1052,6 +1052,7 @@ static void next_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = RAM_SIZE;
     mc->default_ram_id = "next.ram";
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
+    mc->no_cdrom = true;
 }
 
 static const TypeInfo next_typeinfo = {
-- 
2.47.1


