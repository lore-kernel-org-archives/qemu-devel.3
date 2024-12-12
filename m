Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4EAE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 09:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLfGZ-0003ad-H5; Thu, 12 Dec 2024 04:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGX-0003Xt-QP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:13:49 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLfGW-0008QJ-9A
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 04:13:49 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ee50ffcf14so1312990a91.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 01:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733994827; x=1734599627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ucwi6GLl0n1B3UVmS7TAz0uWRjmTT8zXFyAAzX+VsQg=;
 b=DvjWIJJih+tY9UwffiHrHRzk6/DhIoq4mGiFsKurrsNDvHuRTH93wpSFSPEjdzHplP
 EwUPAKnIDTv1SoS7E0lM2ajBRWkFgNri+K4r49X9RCdhLvvsPmdW764a3zqrVqljQZGZ
 Fo5hc7wCBVJP57B5ZFsvZafcExgCe9dLcDc2hgC9FIZxAeGCWqFDJBRGDpw3GxB+5C9W
 q9iPayxvXnecQ0RNjhsQ7u93wah48ezNqmNhPX/xo/CZ76ij+zvGu+lrvYJT/cECnR/s
 9L2U41IgsxjPYRHvlKJU8NlBhQtuzIozIkpxaiP3YxFz4kRPszcGPSaTUnApjgCUjgKv
 l42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733994827; x=1734599627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ucwi6GLl0n1B3UVmS7TAz0uWRjmTT8zXFyAAzX+VsQg=;
 b=uGJkIMXObQooFqDQnLH6q73V4Tx+mRhUkm5O3qJD+9LP/ehyI7jHy4A+Nnyj7kkGLU
 olQ61GcwnGPkqJDw9StMFkRsb/eCVFt280Kf7BC0kYLYGKy6Gd9aVmaEriHoswN0vVlZ
 wiKzsXLN7KyRXff9FQxXK/nrmhzJGnLK+gNSGJGyWXvz9xrfxrzRrG3MXCMUhQUp26ux
 SIKmNLhzLRvNbBFDkFwRftFl5TtuNWeoX13dm7vpA/CbRxeZbDZx8P7MGVJ0FuTf9lbr
 b6jr/lRAmm8lrHE4PqSkQbzlXbL13Bm9QIrWrYPMbK18IVM6debpLpkMhiCD5yrsRepK
 hb5A==
X-Gm-Message-State: AOJu0YwaERJ46xC+0bflN2fFG9gLu54fE59lyI7rTzz/G2GyRpZ8jI0j
 t9Jx5ngigp5a8D1Gy+jChyFtyKRw/2qE+b+k89DNzZXUvbLFWKtMmrTpYQ==
X-Gm-Gg: ASbGncvuLX30YuqH0mvR4qVmb/CkANy7IRzR9KgPFWf4Gnt3hPzvfoB2TcGFzRazDEW
 UZ5KVWnR6SgKzJih76XcQq1ZA8iI9QVrDDjseB3CLffjflXPlCeD6jig95c+0NdkDaV8DplFLai
 Etd2Drt5FAeZdJkM7R6ygiyL/gT/ST0DURSnwtyBnN0FW7X//Rl2+7KMImEWdbpvlRU2majYnBb
 43fon/B+FkcB8jl+8IrqBYEu0f+8pVW6ZPv2EpcZTiABd6zv1UHOj0TqaI=
X-Google-Smtp-Source: AGHT+IEx6rq8Abxx5Wz1SytB24rBtT1pu0kxc+lCl/qHXCieTOHz/HwmOcAweE21/r3EOJu6O72xwA==
X-Received: by 2002:a17:90b:1f81:b0:2e2:c2b0:d03e with SMTP id
 98e67ed59e1d1-2f13abc6e43mr3677301a91.5.1733994826672; 
 Thu, 12 Dec 2024 01:13:46 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142d92e2csm787021a91.9.2024.12.12.01.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 01:13:46 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 04/11] usb/msd: Improved handling of mass storage reset
Date: Thu, 12 Dec 2024 19:13:15 +1000
Message-ID: <20241212091323.1442995-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212091323.1442995-1-npiggin@gmail.com>
References: <20241212091323.1442995-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
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

The mass storage reset request handling does not reset in-flight
SCSI requests or USB MSD packets. Implement this by calling the
device reset handler which should take care of everything.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/usb/dev-storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 87c22476f6b..c7c36ac80fa 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -359,7 +359,7 @@ static void usb_msd_handle_control(USBDevice *dev, USBPacket *p,
         /* Class specific requests.  */
     case ClassInterfaceOutRequest | MassStorageReset:
         /* Reset state ready for the next CBW.  */
-        s->mode = USB_MSDM_CBW;
+        usb_msd_handle_reset(dev);
         break;
     case ClassInterfaceRequest | GetMaxLun:
         maxlun = 0;
-- 
2.45.2


