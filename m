Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8323FD006D
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi0A-0000Gt-Hp; Sun, 01 Mar 2026 09:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi08-0000G4-Qy
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi07-0005i5-J0
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OpWcgVQi9FBrxgIwWpWg5Pji47L9rUU5y14c6wCcUdg=;
 b=UdbNgPrB6X1Ramfosh/ebD4E0wJctkFMkxwkOLuo5ROSwhVFj36J2a29FyOHnjtLY45/4y
 Id6bsfCE9Y8wJGkSOO/V/dzsxCUXyIhqpPTeryRZLuI041Cxq6yrimxhTFZB2Rx/1rQqZ3
 /1mcYfWmxJ2nN3JLyy+lwWSqNE4yiiI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-8S9NRaWnMEmrttvBUXRuCQ-1; Sun, 01 Mar 2026 09:42:29 -0500
X-MC-Unique: 8S9NRaWnMEmrttvBUXRuCQ-1
X-Mimecast-MFC-AGG-ID: 8S9NRaWnMEmrttvBUXRuCQ_1772376148
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4832c4621c2so40423015e9.3
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376148; x=1772980948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OpWcgVQi9FBrxgIwWpWg5Pji47L9rUU5y14c6wCcUdg=;
 b=eqJGbgA1x6ygPoZXKsvW1enTVmZinp6yDS1I05fWOeDlulMYiCU8Vj8KRahUMhHoTZ
 95jdMd3F2SHmp0If8SbEvL34df30GrPYERu94B0RVqdA14mO+QYWElcTZS3MdpKzdLxo
 ma5+ljm+vLQtDmYt6Hy5cLxj2ek5Kuh3VGPWjmXPwkTVb68ZlKYj8LWPUvjbYnYcz8xb
 0Kyofc7nhM62Vv4NhjnbKuAegWzACfxgp6a+oukmZwVffPR+f/oDyGrp6GnNbDUKSNE+
 iUrxjEz9+1U9FF0gkRli485n3FJ1oItOHE2ocGo4Mi/hGfp4ZtUQvpnjRS5dTMuEY6MI
 Xwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376148; x=1772980948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OpWcgVQi9FBrxgIwWpWg5Pji47L9rUU5y14c6wCcUdg=;
 b=n74/73QLhwSsyPPEHD8QZ9CXx7pF7HHpBBHfnp1PgKeQiDz3v+xky8OkHkJGcDwk83
 CB/nbej1nto6Pi58vbrdjZ/En9pOmsLrRlx0dEw2s2E2xBiqWDor0Nl9Ek2uYkad8Mh9
 v2dFPNgYCtz6niF5aKTNXYkTAtGZoH6In/EN2X0mlf1XkoFoh1XgoRdKU62P52pN+sYu
 efqwIwPJIRPCL92vByprVa8uN1lWomZCkiOqVnLh5mPktGNfdnqq5O6eJXBk8yZFzrsL
 wH8PZEumcG2o82omDCOH0JV3nq9vARIG09XjlSTOWehJRk/GRt0+y7BnHvRND5FNjWdj
 Wfqg==
X-Gm-Message-State: AOJu0Yy0ESwiyBb+rXqHDIWaumGaY8hkmpb/JA8GIwMii0xPnH1BdCR+
 7o5E+PjP0zugYcQoPRSjcJQ8rZrz28QJ8cA+LHfiBCj17fxGnTse4hK43lL0Z9Qqb3Z87ZOxADo
 E9VWV6LDn3e43pUY+hKFeLxT6lnedh9S6EFhA42oiSfUj1+al3sipGfEUorjDRn0GB08kUhQANu
 YuIoA/tMcoTyvehHN7XfqdBRxsD4w7bE+qDOX/M/ML
X-Gm-Gg: ATEYQzyVDCTTAjFlkSO/UaPybGSqNWgoHa/IH0L2+HdbJY7AOS5keKhL11+a3m7wriJ
 r3kM0ks07LfhCt483eEU+ahdMJRTQJ4AnC/fKBa3dCM0bMI5JZ84qyEABC8vgPYpK7DEZgSOLZ/
 E4wA9O5Y5PiZ222/slu1wGxVnPp0ShJTTNW83wnXvZU3ig1nYTzNmL+WNTyy/ZNYSPsHrjjPgzF
 1AY1TGJh1HnqDSw/yp6WkE1qwAxr3k9dh2Y67aVUmkjDRcS1hfdHFmM518Ff3zekpgwky3HdtMh
 ZyyohTYYxPpDH2ZaHth9kIiGP8odqpDB1sFd8hfKq2JLuPYiDVXn9Rvv3ZtQQQ3k4EhKaxflrRu
 N+TaBYdY4j1k4FYsdCD/HRq0FYZA942AE/Sf50MiR0WnaTWPlSTtokQrM2mgbY5msHX0Qsl8xN5
 1sTKzlfi3/+MTz0gnIh9/bclVeDmc=
X-Received: by 2002:a5d:5f43:0:b0:439:b60a:b419 with SMTP id
 ffacd0b85a97d-439b60ab65dmr2021581f8f.7.1772376147627; 
 Sun, 01 Mar 2026 06:42:27 -0800 (PST)
X-Received: by 2002:a5d:5f43:0:b0:439:b60a:b419 with SMTP id
 ffacd0b85a97d-439b60ab65dmr2021530f8f.7.1772376147060; 
 Sun, 01 Mar 2026 06:42:27 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b41831easm4342900f8f.12.2026.03.01.06.42.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/18] target/i386/tcg: treat VEX as disabling high-byte
 registers
Date: Sun,  1 Mar 2026 15:42:03 +0100
Message-ID: <20260301144218.458140-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301144218.458140-1-pbonzini@redhat.com>
References: <20260301144218.458140-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This does not have any functional effect because the only instruction
where it would make a difference is VPINSRB/VPINSRW, and they disable
high-byte registers even for the non-AVX encoding.  However, with
APX it becomes a general property of the EVEX prefix and it makes sense
to treat VEX the same way since it *does* include REX bits.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 7186517239c..83b250056e1 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -208,7 +208,7 @@ typedef struct DisasContext {
 #endif
 
 #ifdef TARGET_X86_64
-#define REX_PREFIX(S)  (((S)->prefix & PREFIX_REX) != 0)
+#define REX_PREFIX(S)  (((S)->prefix & (PREFIX_REX | PREFIX_VEX)) != 0)
 #define REX_W(S)       ((S)->vex_w)
 #define REX_R(S)       ((S)->rex_r + 0)
 #define REX_X(S)       ((S)->rex_x + 0)
-- 
2.52.0


