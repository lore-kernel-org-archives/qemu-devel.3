Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF1DD4977C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 16:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHmer-0006Fc-Tw; Sun, 01 Dec 2024 11:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tHmWG-0004gK-3f
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:10:01 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tHmWE-0000NF-Of
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 11:09:59 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-724d57a9f7cso2779275b3a.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 08:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733069397; x=1733674197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2dZjlop092atRpGDfrU0RR8pyuyR4PiiokKniietfo=;
 b=iFLdVaY7LhzRb4VwIIPKxBELX39xdOeaU4Vv5MNDrRoQCVtlqmHZZe0vxCgVQFnpIB
 nE1+iZhNDEToLNhfz3wyjUFSj+L7oDti5O3rpfB0D6nsGHtn/vwRksrHY9G9jaKLk2f1
 tg8OqDH854wDRXlDlofMJVQrpVu3Elz8bBRVATflieidnWrS5VkrDEFxKDpYxhJdbccb
 klEInBdeQ9ng8b7jgyfAmh6beb8QYn0o55d0oLV7O4KKs+BPknkNDy52gxCRlG4SQ+Hz
 ZM4eETsfPTlJ3dehbuOvnDlaJJciYaFvHSUhq3RQ6pl9A1FjYajwmTK3RIcn3o1a9MqH
 9UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069397; x=1733674197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q2dZjlop092atRpGDfrU0RR8pyuyR4PiiokKniietfo=;
 b=s3cclQVUgKybB7KSTesHxIWXnhM900ex7MbjKefQDbHeLjSueitmb4sVCIQ59fBbZ4
 qNOY6GAODFTCnrZwGGs+5XhatWIM1R3nV4CazbTf7SI/YaH6IUiGzS2RvssT7BExLFk5
 tsOs3fdox0WX4G0j15e1UNkNocAbeGhn5k2FYOx7klcB8MI2/kd7fEXTTC4bMujqk/ca
 Pwqxzw5H7ZofMBo/jG4Vi5tdHPFnQHQfVpXYIpTYmz9jt9oLnPfQsdRDjlEB14e5iwvW
 qKJvBL0/GjNrRRbbI+WsR2f/CT2rCKybpxbKwf3Rrd4+5V7aUXQ12idxk7lZS88kFAY3
 W/aw==
X-Gm-Message-State: AOJu0YyvVvNpXewep/JiGZKffIZmj9kU2ki1VJdB0KpBF+ej6ZdvJwQP
 nANIDxjh0HvO2erHuSRyTV1g3QwxtZgLvnjUIIBUFXcDSufQoyH88YLFyEE9nVJf
X-Gm-Gg: ASbGncuiGPYQwrSgKqQOkVytoSy1fs7GppthmB/Iaktc/6pF5/0gF6Sj8XveRHRTeih
 PFLC7Jk79jqUmV6+2KzBrdlNOXHwjpAISZTaGhTFkvPtWRAnN/Jla1hBLeq5ZvOymOOxHxJqPWn
 6U9jTNk0PlOiDCt883c4NkaDzzymu1Ae2iX4801blvjLSEVhCQWd0O5aidrfYSYDKbEGWVL62ji
 ZmK8I/H2wOPrvEzg0QH0TMtLdmb6NgF6V5vwIM5ygJlhTc1U5zKvYZ2n9k=
X-Google-Smtp-Source: AGHT+IG452zMVKZIO3JhaB+2/7X5rlwOuiMkKQ6H+q1jxZno+K/QpqPdfr01iOeUNuq2z50XNZc0lQ==
X-Received: by 2002:a05:6a00:4f93:b0:71e:4786:98ee with SMTP id
 d2e1a72fcca58-7253015eecdmr27963431b3a.21.1733069397149; 
 Sun, 01 Dec 2024 08:09:57 -0800 (PST)
Received: from kotori-desktop.lan ([116.231.112.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7254176f47asm6785783b3a.43.2024.12.01.08.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 08:09:56 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 5/8] vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake device
 ids
Date: Mon,  2 Dec 2024 00:09:35 +0800
Message-ID: <20241201160938.44355-6-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201160938.44355-1-tomitamoeko@gmail.com>
References: <20241201160938.44355-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x443.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 01 Dec 2024 11:18:42 -0500
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

All gen 11 and 12 igd devices have 64 bit BDSM register at 0xC0 in its
config space, add them to the list to support igd passthrough on Alder/
Raptor/Rocket/Ice/Jasper Lake platforms.

Tested legacy mode of igd passthrough works properly on both linux and
windows guests with AlderLake-S GT1 (8086:4680).

Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 71342863d6..a86faf2fa9 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -79,9 +79,14 @@ static int igd_gen(VFIOPCIDevice *vdev)
     case 0x5900:    /* Kaby Lake */
     case 0x3e00:    /* Coffee Lake */
         return 9;
+    case 0x8A00:    /* Ice Lake */
     case 0x4500:    /* Elkhart Lake */
+    case 0x4E00:    /* Jasper Lake */
         return 11;
     case 0x9A00:    /* Tiger Lake */
+    case 0x4C00:    /* Rocket Lake */
+    case 0x4600:    /* Alder Lake */
+    case 0xA700:    /* Raptor Lake */
         return 12;
     }
 
-- 
2.45.2


