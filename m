Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4F9E77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfGX-0003Ug-9f; Thu, 12 Dec 2024 04:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGU-0003TP-Sw
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:13:46 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGT-0008Pj-Bt
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:13:46 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ee9a780de4so230498a91.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733994823; x=1734599623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULR1MOYYwr9yyGYfXLKVNEWBcuu6r/97Xn5RLFPLZiU=;
 b=Z9FajGgF2An6Xz8gs8ivsuJUzjD2J8DLU8SV8VivWXaxKC5Sb6t5CFHjKeJkbBrQz8
 av+j/Oamc+GsNLkQ3LX9987l9sQOLzu6JzAjE6mVlaOTQBfxNf318q+X4oQIY6t6VNpP
 rZHPPjKJ4ZEcNuR7TI0eATZNoqZkjp/jDPfjgA/vmw42EHLtfE/l7ZlUJ3/q1rPD528T
 ukv6JIm59FonXCxOo3OL8e5qwR1T36XiBbobOYSOgy3cUCCxfRUrSEAadtGBQpSTs2VF
 rnVSE5CtFLc3kCap3a0AtBrbH6WNidWAkhcDgN14fW97ww8ho0vQQyLzjryWupD1tywh
 dB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733994823; x=1734599623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULR1MOYYwr9yyGYfXLKVNEWBcuu6r/97Xn5RLFPLZiU=;
 b=NIhO4biYqNL3z2oyk51vxdbZdqnOD6Sr63euY8DdHuaxwOlDNVf7l1CrGPGvuLVBwt
 wmfPNPsg1bp2+hvZnOgG2OXqrb7ZUwcUWAyu8ApnEAAAPKzngcVLww3vxW24uqYG/FDB
 8oNa9Dd3owZqO+9X17r3Lvch6ZHKvxKvNMnQNAtrM0GcrTD/dMSrpjZjTj2ldygvDyBo
 VedHVZoyc4Ryd9cEeuiHNzZ0Wo+gJbzTPQUt30rKqX7IGNdIxle68WJVL98l0+J+Hyxy
 ZE/xCAEr/iqH9aRM84kjYcJ7VfqlVdcXgonGJo6RmemM5mvQ2iayNWcblP1q+X7X70co
 i0eQ==
X-Gm-Message-State: AOJu0YxznPioK31Qzzw0IK/m9WsO0isU+uQmyiawDVsmFtD8qWGiyNCy
 beuwJWHKxw+LAVk/m7g30ZJClF1bOB5zRGzn6ZVrYZXV+UI2YRineWZkIg==
X-Gm-Gg: ASbGnct3jQbZuShGG64eybggsnszOaWVWWCvfrrn/RwVvcWcOfI3ifCWpoYI3UP8X0t
 v1gVNx1haWkEWDHaqN+cx8X5CBq+Szp4xyLaKBA/gdvOdtwTN1/mODeMZPNaD/1Qb5OZehjXlbk
 khPJ96Dwh+L13ROOpLXocf+HZYdOOTI95JdSXvrATyGQWgFF3uz2zjzuX6krpJlaLX7MMNssu9P
 dc0iZ4xSMkXFuJtrr0WuTVB//NO3crRihrCa672wyf2+5iUzsdnxo+xArw=
X-Google-Smtp-Source: AGHT+IGvLUkOVAVtOjJpi8pvPdgsZ4JY+K6gBQ/YqsTjZ5g39Y9YLHrEQ1LrywEc/Xr7gU5yy732Kw==
X-Received: by 2002:a17:90b:4b04:b0:2ee:d824:b594 with SMTP id
 98e67ed59e1d1-2f1393264c0mr4236965a91.31.1733994823468; 
 Thu, 12 Dec 2024 01:13:43 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142d92e2csm787021a91.9.2024.12.12.01.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 01:13:43 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 03/11] usb/msd: Ensure packet structure layout is correct
Date: Thu, 12 Dec 2024 19:13:14 +1000
Message-ID: <20241212091323.1442995-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212091323.1442995-1-npiggin@gmail.com>
References: <20241212091323.1442995-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

These structures are hardware interfaces, ensure the layout is
correct.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/dev-storage.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 2d7306b0572..87c22476f6b 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -27,7 +27,7 @@
 #define MassStorageReset  0xff
 #define GetMaxLun         0xfe
 
-struct usb_msd_cbw {
+struct QEMU_PACKED usb_msd_cbw {
     uint32_t sig;
     uint32_t tag;
     uint32_t data_len;
@@ -636,6 +636,9 @@ static const TypeInfo usb_storage_dev_type_info = {
 
 static void usb_msd_register_types(void)
 {
+    qemu_build_assert(sizeof(struct usb_msd_cbw) == 31);
+    qemu_build_assert(sizeof(struct usb_msd_csw) == 13);
+
     type_register_static(&usb_storage_dev_type_info);
 }
 
-- 
2.45.2


