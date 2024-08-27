Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD35DC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 03:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sinEN-00052c-Li; Mon, 26 Aug 2024 23:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sinEJ-0004vw-24
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 23:50:51 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sinEG-0003pq-Hz
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 23:50:49 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-201df0b2df4so40715555ad.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 20:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schmorgal.com; s=google; t=1724730647; x=1725335447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OPbVwUKXCH/ZUut8ds9FLbfn3e0300EaiaFIsbv4pw=;
 b=Noe43Pkj15yEUxwo040PnZkPKPzU9BSx2UrOCTG7CsPIGR5mW5E9E34wp4jiNNWVaS
 kPj8AdYgnXkvoB5opf2zx3GDb9HJl79UF6rdu9PKOekIHCiKVm/GS1wolXHQRFonHZI4
 oqCT8EOqCgkeNyP00TVd28Utyf1JkO9vAEEZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724730647; x=1725335447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6OPbVwUKXCH/ZUut8ds9FLbfn3e0300EaiaFIsbv4pw=;
 b=gB4iGc1ZU2tZmZCDQDs+C2cAtFx+dEowf2GD7dbd7L+2tunLJIgeNvf2ndEDFQBco/
 cV1KmmX6J0LDgXncNStrdkULeuYsGzWfJqCW7q+OikHO7xsVCifb4Yi5rdCY4LHc6eJE
 xxacsAAKKUGiwsYxmUlTHCkzZPEVicvLBSMoBzAaWb9K2v82p4BpkPwxuUbZBV/Vf3QV
 k6H2Ffmioba+rimCemx6ZusIszBYkT3ziHBYY0seElfarF8prl8dDIu4kdhzaAB/XDOG
 OE73ZFpw6mcsYw23DdNsN4hXJS8w/V95wrFoVoIeSKxFllZme00icOVjgtNgfFggMInD
 /ymw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUUblLKkppcVgsQGuI4p6fsXwfPSG+dvWcRA3qguAj9XqNGjraX2ebcgbITiMxY244ar9/+oVJg/qh@nongnu.org
X-Gm-Message-State: AOJu0YydOP1Bnl+cNPLPU8rq3+AFPicYkHw20vpqTzz6s6Gs374OK/BY
 QVBwipilWi2W9v2cCQbEzB+LniEW3teCbBxjyohCLndaEFMyBKWM1OYCJ2fi6n4=
X-Google-Smtp-Source: AGHT+IFOf+n6n/YjXR/TV5GKVYumayLespLoZ2LxMmi9p2CuaAcA3k6mzi0PIJDRJr23ukZymeHtiA==
X-Received: by 2002:a17:902:d503:b0:202:3430:654e with SMTP id
 d9443c01a7336-2039e4f2573mr175015125ad.42.1724730647210; 
 Mon, 26 Aug 2024 20:50:47 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.200.153])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203855dd269sm74503625ad.135.2024.08.26.20.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 20:50:46 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Francisco Iglesias <francisco.iglesias@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <bonzini@gnu.org>,
 qemu-devel@nongnu.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 2/7] hw/net/can/xlnx-versal-canfd: Fix CAN FD flag check
Date: Mon, 26 Aug 2024 20:49:22 -0700
Message-Id: <20240827034927.66659-3-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827034927.66659-1-doug@schmorgal.com>
References: <20240827034927.66659-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=doug@schmorgal.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When checking the QEMU_CAN_FRMF_TYPE_FD flag, we need to ignore other
potentially set flags. Before this change, received CAN FD frames from
SocketCAN weren't being recognized as CAN FD.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Reviewed-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/net/can/xlnx-versal-canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index ad0c4da3c8..8968672b84 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1003,7 +1003,7 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
 
         dlc = frame->can_dlc;
 
-        if (frame->flags == QEMU_CAN_FRMF_TYPE_FD) {
+        if (frame->flags & QEMU_CAN_FRMF_TYPE_FD) {
             is_canfd_frame = true;
 
             /* Store dlc value in Xilinx specific format. */
-- 
2.34.1


