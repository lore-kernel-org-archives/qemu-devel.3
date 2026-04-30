Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C08CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7j-0007NV-WE; Thu, 30 Apr 2026 13:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7O-0005oB-Fq
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7M-0004mp-V4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tY4A6gtU1kLTb5kI23uPtWDAJSjcR+ARQMDmMJNviY8=;
 b=RANhaLnFDZZ6GHdHtiOm8++fJTkRRWbj9umRUhPSQqr6HHHX58Fbz+MKVifUOUVxS7uQmU
 ZU46onbsg1T1+3Zh3ZNWi/zVXRHOGlgSncWmyCXjQSokgp68Y+VykUTsRHW7pYYxO0wVA+
 78gK5aKEXxtHfHI8l+OJ4K43HG0D7PE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-DoihL3FdNAuKanjDErt3xw-1; Thu, 30 Apr 2026 13:24:02 -0400
X-MC-Unique: DoihL3FdNAuKanjDErt3xw-1
X-Mimecast-MFC-AGG-ID: DoihL3FdNAuKanjDErt3xw_1777569842
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8ead5ab474bso232399085a.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569841; x=1778174641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tY4A6gtU1kLTb5kI23uPtWDAJSjcR+ARQMDmMJNviY8=;
 b=XiehgeFGlpwMXfOEuMQIgT13+QmN6Z4WlPq3iC6QkAHZ/BUEcYqJ4ckynNlXAtWDJc
 Q0uDuNhuY1UsHh+LLDztqVuXNS2nMRF9OhWFHmmuFX9XMkfbajLtOcpM1HsY+JRxQeqB
 SvKfRoCA6qhqOJgxPSxo1tG8uyy5NUu/4jeKPi5SA6Vx2NgYDKUi7zcR28d/wu3c9zvL
 G0/n1Q/IOLhsU/BhYORCBb3ZlEzG4k1kKjFrlsj77/3Ken9TiTB7vw073HWWBmpksN7d
 ygtH5Jg2AlXp7gF2UFNGz6d0C/2CYUhJoOcKt2hvTWQ8mLNMGivNRO2JjY6njS+P9D/M
 ykVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569841; x=1778174641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tY4A6gtU1kLTb5kI23uPtWDAJSjcR+ARQMDmMJNviY8=;
 b=cmLVEmR6LoeTwiUZNqneB9/xlRVHFm5Ji4sv7O4HYjEkeBf3t7E2OrZeGIRpclNh59
 BgSzY6H8SjI+NQZlkpCfnA+/gVvoEvwUZbuvpE09DHIoAuoNnd2iGFaFej7vDQiAkTL5
 5CT8sjvEDdoDJwKTX3cJRTz5WHDqjSU3X24V2Nah6Z4zG6Hh0dsvWqZa8Q9OAk2I/wVe
 sdcxORQOpC2cLRJ9URgLGNK9YiNsfyrQ06tM9V/y5OPibPXKykdy8iOObfZNKCKovhWV
 4EqZY2kbdBvU5K8r5wmaRWvenSqKpYCznXjrztAxmLVKOBzGk2L3Wt3lO3iZIKrB6wKG
 KZVg==
X-Gm-Message-State: AOJu0Yxq2kr0cqA+GhkpC0zGHLlT4FY4eB7s1Udurgrny7pM2Z2qiPKL
 OemaSxR6OGgMWGnD4QiUK8XSx4/SuuvbDJnX7S9k8J2EwzDMWljuXzh1hPEre0CB1tHvzXsADg8
 tsA0X4LtkaBaRXHoEQMdqsx2DBpMQESI+FcpIQ4bUFWDDuwa/mK2j705UEv3yHtVdMyQ5y2YnNC
 lkoHAm5oRfxKDs4kaRaX2QMLftB3YoHBCjNOc9q+yS
X-Gm-Gg: AeBDietTOOB7qofJ+YEMmiP2qhOAgNcqE8iZiN/u8SrFL+qSYNveSNniEteTrZ74Gew
 dPtJT41nYMeX07s3zIWW9R4wXA5u8NAtjpa96L2tteyweIkjfi8mNFrdLqphdBLAVJsuSCwioYV
 yeRduKwM5zsJ83ioBAjVctWUuD4PzNIN6jldT5rthSvkBIfsKyFxW80lS5NlFsbYXUxiNWX6gOo
 Q4hZlNOkvdu01CcLHziIszFmxPinEcbfmVxnt4zFP4AbLO1VR0rM89xfq+Uq76oFkV7YLoOY8U0
 xvLJaVskBIk4d3ISlO2K2aVLcStwLDmVqH2YezUlGtXhHAKAZQRmS7shrKL5riLIpyuG8YUNVUj
 4EjPSA6wkWf8iOxYhhzovBxAmZPEUoQYB7PgPwYtM1nW1s+3yl4wNFdckxEhNzcsRxPcEKzvoP1
 BbYG+9c69lV8cSb5PESZhF5oz16M7EJDK082I=
X-Received: by 2002:a05:620a:2951:b0:8cf:e32e:8a0a with SMTP id
 af79cd13be357-8fa86fa6745mr611551085a.18.1777569841024; 
 Thu, 30 Apr 2026 10:24:01 -0700 (PDT)
X-Received: by 2002:a05:620a:2951:b0:8cf:e32e:8a0a with SMTP id
 af79cd13be357-8fa86fa6745mr611544685a.18.1777569840349; 
 Thu, 30 Apr 2026 10:24:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb09fc9e7sm26513885a.1.2026.04.30.10.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 36/58] hw/intc: apic: disallow APIC reads when disabled
Date: Thu, 30 Apr 2026 19:21:42 +0200
Message-ID: <20260430172204.1006673-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

!APICBASE_ENABLE + attempting to read xAPIC registers is not an allowed combination.

And neither is x2APIC enabled + attempting to read xAPIC registers

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-15-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/intc/apic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 8766ed00b92..e5ea8312617 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -875,6 +875,15 @@ static uint64_t apic_mem_read(void *opaque, hwaddr addr, unsigned size)
         return -1;
     }
 
+    /* if the xAPIC is disabled, return early. */
+    if (!(s->apicbase & MSR_IA32_APICBASE_ENABLE)) {
+        return 0xffffffff;
+    }
+
+    if (is_x2apic_mode(s)) {
+        return 0xffffffff;
+    }
+
     index = (addr >> 4) & 0xff;
     apic_register_read(s, index, &val);
 
-- 
2.54.0


