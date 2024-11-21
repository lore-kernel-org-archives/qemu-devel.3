Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742A5D75BCD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 08:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE2PJ-0005OA-3i; Thu, 21 Nov 2024 03:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tE2PH-0005NK-5v
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 03:19:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tE2PF-00088N-Gi
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 03:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732177154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Vt/3vmBvtEtog/W/v4IEPA6VA5iPvE+S08h90aB4/gw=;
 b=K31cBmt/hgG6mdIADfmE7AE5wIS9mjCfFgyLFqlkfSswpXs6Los/ti3ngySrfNeWD/itw5
 0r6AtZ13YhuCb/23iaacpkuRE50bX7pPeECpVugCpOYFqDeqm4kwp2R0R9Jv9EW9q9bW06
 ymJ6aglFCtAZB9xFLOsif3+k4e3YyrI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-_xscDT6mMQmwyGk_ifDcuA-1; Thu, 21 Nov 2024 03:19:12 -0500
X-MC-Unique: _xscDT6mMQmwyGk_ifDcuA-1
X-Mimecast-MFC-AGG-ID: _xscDT6mMQmwyGk_ifDcuA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-382480686f2so351236f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 00:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732177151; x=1732781951;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vt/3vmBvtEtog/W/v4IEPA6VA5iPvE+S08h90aB4/gw=;
 b=s+w1NnsczW7iCkdE94D1lU6+c9LjF6UVQHrzWx1MajPudJAkpscXr3by6k7f7Nyn11
 GzFVyOCDAe/MPdE2y52Urzs/zop5smR3fa0+rz2j7YB6gNPHOg7xBp8+D7Wa6U73LqLO
 KdSVI8CrRWSCEH2LXOf+2hAXL8UPfXkiqU4yenUPtdUV874yOoN762UB/KczNPN2ZOXR
 HXyOWh3t8MrXE9gXoqvy2yrcSFfWPKuRIX3s5EULsOaWxjS0Co1CapoWuhldCKRBrFm8
 pY4J1xhwO0OtBUeTfCoPwWeuiZflYSKeS+1/yWPgccYeG7RBZItbDRj9FBSel2lqz5uW
 GIaw==
X-Gm-Message-State: AOJu0YwpBOHZb6WzWTqTYHd8qUE7jN6ZNWY30FSfzPMzOIxcseMJbztt
 uNtdcnYWZ26w9/OYLNQDNT3AV3SwsQ6x60gsmmHeW+Nmh5HdITGjIudBio/+zo0nUs6hSGUfqsp
 Og5aOw7sz7HUUDUdTKFHAGyau6yKNTHgB6No9LaPSFPNexDVlYUvz41sIUEhkgqd73+al+Hqlyg
 QT1+sGmboi5AXJ5/nUUZcLaAYYMTiQjnIWqJ7J
X-Gm-Gg: ASbGncthsTh87SKUOejuXHcKRK6XBua5Q62xp1oMFCoWimSHS0XB7QcdhDC5TbI/GeT
 VMloF87CyWk++soyCauX2/Z+pZ3arDF0OpHM0AAwSfsPwAhneJgDecuCeDptqiX0VhOSMb9OSzl
 JmOesPLh1lBbqOIztAXlWJziC3HxL82dSPfbHdejzHu+MmasZPM3bJDegOC3yUOhi4J+ITobfiq
 xsiStxwrVY1aHsVwgTwBygf+VDkj4MOhNQ/kHxxRcrIV71WRQCJ
X-Received: by 2002:a5d:64ad:0:b0:382:4eef:270 with SMTP id
 ffacd0b85a97d-38254af6406mr4330504f8f.16.1732177151196; 
 Thu, 21 Nov 2024 00:19:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5xoz1WgMkT5SgiQ/Sog0JaQ2nmoEULe7v7KDwgSionVz5TaJaiiJLNL1zB2drz4puBGYoTw==
X-Received: by 2002:a5d:64ad:0:b0:382:4eef:270 with SMTP id
 ffacd0b85a97d-38254af6406mr4330483f8f.16.1732177150851; 
 Thu, 21 Nov 2024 00:19:10 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825490c29fsm4138333f8f.32.2024.11.21.00.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 00:19:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH for 10.0] tcg/optimize: fold recursively after optimizing
 deposit
Date: Thu, 21 Nov 2024 09:19:09 +0100
Message-ID: <20241121081909.227610-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When generating code for x86 targets, this is able to simplify XOR+SETcc
sequences.  SETcc generates a setcond+deposit pair of TCG opcodes which
used to become setcond+ext32u after optimization; now TCG recognizes
that the output of setcond is itself already zero extended and turns
the deposit into just a mov.

There are similar cases in fold_movcond and fold_setcond_zmask, but I couldn't
trigger them and they require moving around functions to avoid forward
references[1], so I am leaving them aside for now.

[1] I assume the lack of forward references is intentional in order to
avoid possible mutual recursion

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tcg/optimize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index e9ef16b3c6b..e0fdaeb5500 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1620,7 +1620,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
         op->args[1] = op->args[2];
         op->args[2] = arg_new_constant(ctx, mask);
         ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
-        return false;
+        return fold_and(ctx, op);
     }
 
     /* Inserting zero into a value. */
@@ -1630,7 +1630,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
         op->opc = and_opc;
         op->args[2] = arg_new_constant(ctx, mask);
         ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
-        return false;
+        return fold_and(ctx, op);
     }
 
     ctx->z_mask = deposit64(arg_info(op->args[1])->z_mask,
-- 
2.47.0


