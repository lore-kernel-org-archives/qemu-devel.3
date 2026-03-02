Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4826FC624C2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:46:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwytw-0003jX-OT; Mon, 02 Mar 2026 03:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyti-0002PD-Vj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytf-0001dj-4y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2UvLV7T/c28934ZMwgd4/IpvmnYLu4+9i+MWfbEHqmc=;
 b=KniX8n0HF+jVP1jzlQ8N4dCktqSODMeiwPpCbqr8gT5zxFIOd+VtcFd/2X7b776jn0Gkbg
 /pe50qlrTl1S5yhG0mhj2Ze+KVa2Lx7mUcDkxRCYOLCqr19W+o54Rm8flP8mkTp4SeUKJZ
 KRMO1E4jZqgv0OrHDeTBSsKk3CNudV8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-kdTDtD9hMNGRZFIRrycjRw-1; Mon, 02 Mar 2026 03:44:57 -0500
X-MC-Unique: kdTDtD9hMNGRZFIRrycjRw-1
X-Mimecast-MFC-AGG-ID: kdTDtD9hMNGRZFIRrycjRw_1772441096
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4836bf1a920so44009525e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441096; x=1773045896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2UvLV7T/c28934ZMwgd4/IpvmnYLu4+9i+MWfbEHqmc=;
 b=VHcMiTxToTOZm+HSqbhJVND6GfoPgdVyLZYkWBXaedHJH2p6fd885214H9uKxKFaIj
 Lw3mIJj1OXjSE/x+FwRrfWI7U3tjUVkaI3D2aaUZnv8eGi7jXopivktVy3IWqvZiXMaW
 BfLM1i5j1zRA5Qbyulbb5phewCnQTU8cE4VNyPryEVv+XeKKYYndGeb9Ni/aChFbqlDB
 VwSMC0HcjkEqNkPDSv9fHvpCOr3woAIvSk4GOur/sFotVMuTbWy+l3hWTGplfmcbCVkI
 ffxNuIXI1pIHnil64dNm92e21+CpvcNmDFOQ2MMGGyHuGneQXvxiAdYuvJvklFHTzZdm
 JJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441096; x=1773045896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2UvLV7T/c28934ZMwgd4/IpvmnYLu4+9i+MWfbEHqmc=;
 b=qEbrGTuXwmAo2hbmeGos1acMkbql0Ij7It3iq+ovnGf+AY8kF/lDbhtOi5qczy12K/
 phObefDSDR6XCUlSUtSRjm9+dTOWiuoBwfCjEry2t9qdwDUgg9vB3+io/rtyqbfqPWcB
 bARVl3tIykelCB+fJt/qCyvoA7WbbWOf7bcxyw3LpW+/wEkYXHM6Z29Ny9oj0AO+Asvw
 /T2330Hmcvmb/YO4a8SVSzzVdtGT9NF24QgwiDpkL95VvXePoxME5qcQi80t1iGu7Wdd
 /CYkHzJiVZtK2vu1SEUKKYR7fNYkWmcvnBOEYPyatBdCtD2PlKBI7AB8T5X48x6BeaN7
 VFWg==
X-Gm-Message-State: AOJu0Ywgg4ovZXqS+D5wQCY69AvYnlNFQaz5TQGhv0JsiRantAJ+bSh7
 GhgmQGsq1CGJKwz62I8Spgc4vBZCE6GGUiy1Mnkw4512QPsvSgRmxPp8cFhaorpi+4MrxAF2/uE
 7ZkrZO80Vd5oDq2QD2njA3msbRi1+8yMD1ujJcdELz5OaQZmyepN7MbYOnIhAvFPvMF0TeabioV
 43wW9f7o/cHM+61x+1+Fa2PevFTk3ubwRd3gILfHMU
X-Gm-Gg: ATEYQzxyXqaL0t+FxpRDrzYp5mnNvErJciDdnZ6041dtKAqK7QhrIi+gfrtoqhoW7tf
 X7Zu4KOqYNiN9700SdDtF/b/v2HwC+SH9eWvD4rhWUobr+bzY0rfBVoma0AOkRHhDlAuIpPjO1t
 uIe3nBCY3VAr9IOel4e8231LrpSMLuab7HlQwZq9fphS77sVI/8d6/qD5xVCWbD1JoN0YZH6uYt
 73yP8bJdUxmFkpKG2fmoPwX0I1HAZrdw2SUy54WDq6chr6QlITfJdOxQZLSXEp64umQ5HNlg5Y6
 IZdjiweHTsBLJiRUB+1X8kcj5kjzIw9zdWL2itTbsSyr9L4vaXKuB8ufD0ORqJBAJYTXFkNWtDQ
 O0KfVFr2g4ogwy6Gtbn15OPFO5ERajsFj5q4/GcCbbD/DGNpsmW/jkgeQoL5OXrump1osb7ObOs
 Z/RUq9wdoTuGcSdOTumuMBrHH8ypY=
X-Received: by 2002:a05:600c:5395:b0:483:bcff:7948 with SMTP id
 5b1f17b1804b1-483c9b9eaf4mr197679425e9.10.1772441095844; 
 Mon, 02 Mar 2026 00:44:55 -0800 (PST)
X-Received: by 2002:a05:600c:5395:b0:483:bcff:7948 with SMTP id
 5b1f17b1804b1-483c9b9eaf4mr197678975e9.10.1772441095314; 
 Mon, 02 Mar 2026 00:44:55 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd70e692sm413520345e9.7.2026.03.02.00.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 028/102] whpx: i386: ignore send_msi to interrupt vector 0
Date: Mon,  2 Mar 2026 09:42:23 +0100
Message-ID: <20260302084338.473368-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260223233950.96076-28-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-apic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index b934fdcbe19..f26ecaf6e83 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -192,6 +192,11 @@ static void whpx_send_msi(MSIMessage *msg)
     uint8_t trigger_mode = (data >> MSI_DATA_TRIGGER_SHIFT) & 0x1;
     uint8_t delivery = (data >> MSI_DATA_DELIVERY_MODE_SHIFT) & 0x7;
 
+    if (vector == 0) {
+        warn_report("Ignoring request for interrupt vector 0");
+        return;
+    }
+
     WHV_INTERRUPT_CONTROL interrupt = {
         /* Values correspond to delivery modes */
         .Type = delivery,
-- 
2.53.0


