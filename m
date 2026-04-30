Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD26CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7p-0008MZ-OA; Thu, 30 Apr 2026 13:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7V-0005x3-Lu
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7U-0004oV-3a
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7W/td9WC7oKoDNYDbvCT7O24njWTCLlpWgd2uxsklc=;
 b=WZNfONA5pSQsSxva1kRg/IpwTzqh0zLjVfpIHe7JTLSz8cqb/Lo4xDravWOY9hOm0t98Cq
 Zkf2LGwjaTammuMxZnTHaWid4Xf3c2cEUqfJ+d+Kzoi6XtvjdWYz24SVzHqghZJShMbke7
 YrUey0P8yweLPbtGGAWLEF2QMG8xx6I=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-SU2nW3NoNbGyXKtcGzzOoQ-1; Thu, 30 Apr 2026 13:24:10 -0400
X-MC-Unique: SU2nW3NoNbGyXKtcGzzOoQ-1
X-Mimecast-MFC-AGG-ID: SU2nW3NoNbGyXKtcGzzOoQ_1777569850
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8aca29dcd69so31074346d6.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569849; x=1778174649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7W/td9WC7oKoDNYDbvCT7O24njWTCLlpWgd2uxsklc=;
 b=mIp2J+s8VqiSGUyrZiT2fG++fMSdLhhHIHPLEpGAtByGghrE6zpyZYzcP+GQuSL6dN
 LfNksNQeF188Y9a6PufOF71j8j2KaMlWrZgZqamOOJ9ArWMB1ERaA4DqjLVukMGyjWvB
 olAXLYmQ309exjgP6VIeM1amDYIAzvDQEYTfc0byRwRtIIEWjfbJ+P2j+yS6Cp/O5Y+Z
 dHUN2Lg3rHaMhjHZ6cTv7A4rDeSGEd91CjeO6gdZmvuGv9e1yeRE8sJ31duINM/bAwMr
 V96PUzcAleBbK5rZLIO8NcyYaN2LC2aoz+TFOpWFrk+tXKBrBWkpFD+6qFuPOqVWJQDS
 yQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569849; x=1778174649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c7W/td9WC7oKoDNYDbvCT7O24njWTCLlpWgd2uxsklc=;
 b=IDeRk0JT7t0HbAnMViEeRmcbT5/EATexQT6cynEeJV6AdPki62Tj+m/MPL9svsWUbX
 UIt/H8np55bJIfh7xytM/XzJV/pVbA/Mxc5tvLwYoe1WXvbtKFsgCOoFnTGHdX9qV1pJ
 iHH7CtMrWjOLDMazuRaQodFehaG/A1ywCmzvISFBCz6PIe0Taz1ZcSGfEEtdTIzpihwL
 nkYZAXkvkDfFsHcCXMlXYanPcZW5yKu7Mzqkppv1+paE74hAamkacMB/n0kkqLnDCB+0
 i5+m6bbpOedD6v0a1s2tQq8hbn9fO8/NYqk1UnKA7IfGsvxORNRjdi8kVMQA2yuUawz5
 Lo2A==
X-Gm-Message-State: AOJu0YwZuSJ9PUtKR30otK8U2zOZwVGu7J1NuQwGE9hAFAgie/0RhdaN
 PhPheUi9RPg4t/pZxdGj9Ugc1f+HVru4SoCI2sxtxqX3gNXYRo9FQbc/dkCI0q96oSqS5VGfGuJ
 6CMiZkFruOsP4qd2xzc6Wh3NxDTC3yOPuUgT7saDV20+9OxY9I0XmXpzMFCdl87uKaxD+RtBK5R
 kx/JN6RRXxSqTb+9kWlRXMU9XYY/ddAijro1f2ncK1
X-Gm-Gg: AeBDievMeddrNhjUggTdVA4NR1kxZy9jDM0zYA2dNDoul+zQN5WPx2iDHcZVGXja3We
 c40T6UNiNHN2CW8UbbeX3p6ghYjwZBrlfSJeqIbpnAPi0HGBTO9hFhadUGyOjDnSzZREzd4Ur6b
 jIpFSbzpPky2NaPtHBZN7lAtD6+HDfvZSRoPM2y4SPXLC4745j77894GmEH62PviaXbk5j9eByh
 DIbcCLHAmufQ/bAtYWh9MKayTss24Vv1dSn08/EJKG1PHQVGQoZfOzVS4rnOfwG7J5IQ7Hv/lgA
 PSvwqK2xoUkuQqtjmxfFl9klTSooIhvM6Ixr5WbhsBU1rQnjMz68AvriZDLNvjuu2IU8p2GsDwG
 +L3kkTnAaTz3MJ8QiwJQDYyBHkYztKREfpTotNdSvugNsbbflJN3d2uqPdcLX9q9id0QjtIVHIi
 tyeEy0FE6rHvK22JxUB0g5Cc3nGYn6GC2d8+4=
X-Received: by 2002:a05:6214:262d:b0:8ac:b24a:f543 with SMTP id
 6a1803df08f44-8b3fece0147mr52755136d6.50.1777569849177; 
 Thu, 30 Apr 2026 10:24:09 -0700 (PDT)
X-Received: by 2002:a05:6214:262d:b0:8ac:b24a:f543 with SMTP id
 6a1803df08f44-8b3fece0147mr52754366d6.50.1777569848556; 
 Thu, 30 Apr 2026 10:24:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff328884sm22928646d6.14.2026.04.30.10.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 39/58] whpx: i386: enable GuestIdleReg enlightenment
Date: Thu, 30 Apr 2026 19:21:45 +0200
Message-ID: <20260430172204.1006673-40-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This corresponds to HV_X64_MSR_GUEST_IDLE (0x400000f0).

This enlightenment is only available by the HV when using the Hyper-V LAPIC.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-19-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 3426811c482..9fc44f8a67e 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2761,6 +2761,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         synthetic_features.Bank0.AccessIntrCtrlRegs = 1;
         synthetic_features.Bank0.SyntheticClusterIpi = 1;
         synthetic_features.Bank0.DirectSyntheticTimers = 1;
+        synthetic_features.Bank0.AccessGuestIdleReg = 1;
         /*
          * These technically work without the Hyper-V LAPIC
          * but behave oddly for multi-core VMs.
-- 
2.54.0


