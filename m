Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A7BC7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeoD-0006cM-UJ; Fri, 20 Jun 2025 12:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeoA-0006be-Ka
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeo8-0000Ie-Us
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xj0lRSY0/RSQgCPx1FZDgyFJc1m6/HOI+FjSa4wjsdw=;
 b=EUf476X+9/HSAhDXqh22lI3bV/jUFRHHeh/JT5g0rKYY6DT2Tm22gkqiIrOMO88fgbFZ37
 DWf0G/HBl2BasqLFC3+uNZ3Dl46ULwsB3MwK4aHOyhzkBXRaRYnuWLAVvkBgM6aKsqWC+i
 0ZcdTHhH5osv+MJg+mNVVvCDKHAQqVo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-Zn3nKUuSOhyJHbjsj0nEOA-1; Fri, 20 Jun 2025 12:41:38 -0400
X-MC-Unique: Zn3nKUuSOhyJHbjsj0nEOA-1
X-Mimecast-MFC-AGG-ID: Zn3nKUuSOhyJHbjsj0nEOA_1750437697
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acb8f9f58ebso164357866b.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437697; x=1751042497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xj0lRSY0/RSQgCPx1FZDgyFJc1m6/HOI+FjSa4wjsdw=;
 b=UAQ/fX8oByvNoTSASy2yowXMq0o8NbonOmoLFNu/x0ieQingKrtO8Y3rUyZh2xQV3l
 Cq4GFW7jFIj1H4+upTOUo6y+vRXVvkGMZyudoGp9K2UclZSvIAAxZ6Nj/dsgMkNlFohE
 9L0zpWKr/xG6EAgOlTgOzQJzKSx3b/h+wql1evjvioMHW3UyNM/aJp0Eg3aTahN16Ylv
 fYYB9h0GZWBKJ9kRaDUWSlI6xpVTeKkoVSQ2eulpJBWf5pJFDC5a69uMoDYyR1oQSHKX
 DZHSv0qW0i6BN9dmTxCKn++qoLOSqPubgpa8ovdFKepwNDG6AkmBLVlEs3IA20VzCcvo
 mJUA==
X-Gm-Message-State: AOJu0Yz9ZnFIKkDdFHfjuvUNhTi4URTVbMvoTgzTUfN2W00ZjlBmI6oN
 mqSGefe1dQdz0rUEuD2+/gEwPTUZ/H2E1f8feSt7L7HmbObSbUd8MThDhuNW8EaIe9XVmqs/8qo
 fPL8NTHTAopf/Mb8IzJVMCxIJYzvcRoEbLkTW4AtQHFJJGHuZDRHM4SyqsmdQ0prdTwVCwPlr2/
 GWLgqIRUnG21qaKKUM+q9wJDZSwJkGTFyRYKfPqf6c
X-Gm-Gg: ASbGncsSlFihy1+1X+vaIDO4ICPkGwjaQe7+nVPhFxizgB336CY0OrbCyPalgoeEpfU
 KewbQSfcLh2i0iO/lHmvbS7SUGzfbV4N+P9BgyQbg8+a45dERpLTwNMqaqBnwq33Zp5kZ+yRoBL
 Hbhwb7jJDId5780LxmILsMgbB2Dix76rsnMVHyhc+JSWNaXTj7r9dFixAVAcoqRQNbVf83/25aJ
 4eJX23DReVjD8rX2e5NVGnNKKXUTp8Ls59jDlyV6BpOZm+53Hvt0bgy0WYAuxRIjl/f1Hn8LUra
 0sM/VCoPuva1Lxckq4HP4VbCOw==
X-Received: by 2002:a17:907:3d51:b0:ae0:628a:5093 with SMTP id
 a640c23a62f3a-ae0628a61ccmr223496366b.3.1750437696652; 
 Fri, 20 Jun 2025 09:41:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUh7cEAihUDK1wggEwKVGhZcOd3ATAZGEk/YBcmxMqJ/WV3Ot32X0qcj05SxIHXKLGolhnNw==
X-Received: by 2002:a17:907:3d51:b0:ae0:628a:5093 with SMTP id
 a640c23a62f3a-ae0628a61ccmr223493966b.3.1750437696218; 
 Fri, 20 Jun 2025 09:41:36 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae0540815c2sm190252966b.94.2025.06.20.09.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:41:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 15/24] rust: hpet: fix new warning
Date: Fri, 20 Jun 2025 18:40:43 +0200
Message-ID: <20250620164053.579416-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Nightly rustc complains that HPETAddrDecode has a lifetime but it is not
clearly noted that it comes from &self.  Apply the compiler's suggestion
to shut it up.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index a281927781e..acf7251029e 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -771,7 +771,7 @@ fn reset_hold(&self, _type: ResetType) {
         self.rtc_irq_level.set(0);
     }
 
-    fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode {
+    fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode<'_> {
         let shift = ((addr & 4) * 8) as u32;
         let len = std::cmp::min(size * 8, 64 - shift);
 
-- 
2.49.0


