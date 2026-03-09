Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A7EAFCA18C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhPI-0004kn-8b; Mon, 09 Mar 2026 16:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhPF-0004iW-6X
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhPD-0007qB-HO
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0GuAyxRTooT6yfCAc2b/eQlsvt/y6s1ZY45EFsHiNVI=;
 b=Xd+xyRGetJFIKulk6WQq/mVTx1QIR8BJadiZFMvu+EvqY+uNoLVZuyy5uJheI7svljqXQc
 EHmnr2uTTq5NxWbImQCvZIVG2Tzq4bFczafJzWCFT0GloP778Av1ydCkVDo7UZq7/kbaIg
 UsN7wBdHmXUSG3f1WV5kIN+6K4L9UbQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-wWDkmC6qM5mZ3YPRhLYL-g-1; Mon, 09 Mar 2026 16:40:45 -0400
X-MC-Unique: wWDkmC6qM5mZ3YPRhLYL-g-1
X-Mimecast-MFC-AGG-ID: wWDkmC6qM5mZ3YPRhLYL-g_1773088845
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd7d4cc049so2034297485a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088845; x=1773693645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0GuAyxRTooT6yfCAc2b/eQlsvt/y6s1ZY45EFsHiNVI=;
 b=EC3cIso54N+wKiKY4Z0eQZMUKeV+JJqBSI0K0ApkpWLhwS9pGBE9ET/XFDKYEbB3FK
 Yqef6UhZ78d2MD9gfRqS18uBSPZl2RCidH2dnCvgWhirjd0sHRltgC8djmRBvNZgllKJ
 4IxfYYf/6/jjqMx4aREyjCzHl/nxxf7y+GMEXm5d58p7k7fpGA5k0d2APD6dItuF0lAa
 yM0abuV3vJiCMeB5RKej21NEawg+cJ9jtfzPuQk1cB9R7mazCElT/aDMrSjS4Tt+Y+VT
 W4HwSz72AGgvPRTOD+WAsZ8pkvqA2ff1P+HCXCSyFZU3RTi/JVy7AuPf9t8Io4WVzzLs
 gBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088845; x=1773693645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0GuAyxRTooT6yfCAc2b/eQlsvt/y6s1ZY45EFsHiNVI=;
 b=P8tueUOfnnGqhmsb7Pg3nljhdjHNa2dexUohLW1nuCo5eIr2n5vJjXpozb3NLxQuPW
 qNnClOwjlqnrvQmE1dD78/RKGcsw/NDB/yU4FEW/RK5Pcx3KNX8nPAlsqcSla/wYKY7s
 u3+ccKm9xXDFhqy+CPxZi6SiEhVFcF/LOq056SBP7mGMuHYTcr+K21s3LBH8ydanJ5JH
 O9wkfVTPZHRucx2aN3Pv3opVbTyoOWhgAvjef2AZ6drFfu1AJNsrXGpJL0q0VG7n2J0q
 knTe7iLLF0uK+beUT7vODb1GMJdmWx/XJRgmK/Wt/2DtaGsSWchQqlUAWXkF1A1ol68s
 LiGw==
X-Gm-Message-State: AOJu0YyI40ljXV4WRATqKBl317u39rGN3GgNGWTfx2gNYNnTtduyfzsK
 mkABZNRPAWr/2/Ep0+6LzWxuFV4EG5bG4u5GaufaC6YJXVZl22Gi4yNPB9oQZvaKtLePTnGCPVi
 cG8MGgv6/PG2zeDtOoIGguiKq9/Gtb2sCeFo0ZAeI9HYkPcSGoV6ZKQZA5a5+7wkJs93aLSwEFp
 fUGkv6TBgiOAqkjh+ogB5s+h6VW6dmL3xc/cph7Q==
X-Gm-Gg: ATEYQzx0IBjPFi18hi49YfrQwg9YuVvAkd8Z8dSzjSfYNknve1dkJts0ej1bWPAvf1a
 4wUv4LO29PKR/pLZ2/tu92Ohb+snNUGiQn/0rCJ9WTwFZuGWmTRvq2RWRaV/V20tQ1J3KhW23SV
 W5dCpKp4ZMwhpTvVAN4JsKdikb/uoCiQoT3o9dKkDJUfGJBbWz1me6bsWftKscKic3Oq6GuQt09
 wtIcNVHN00rxlplzA6oNqQ4XqsvYl4vrnx0u6gDvh4OUGXO8CsTloDJb5UGXVCEyCqlk3+CyNP5
 gggOKCnJxnoPipQR/T2uEYw6jxoX8a5AdfL6Nr2HD2di+9ze54ktPbHC35AgJBp3zwL1QnUn1mm
 fQfaXGy/vZE7GlvvJoOs20unGaVAeGntf0kWlJOja6RPOpVY0oa2bixzArwMVutFDb/7Dp4qat7
 3rQvtHrA==
X-Received: by 2002:a05:620a:1a19:b0:8b2:767c:31ab with SMTP id
 af79cd13be357-8cd6d503f2cmr1466056185a.60.1773088844602; 
 Mon, 09 Mar 2026 13:40:44 -0700 (PDT)
X-Received: by 2002:a05:620a:1a19:b0:8b2:767c:31ab with SMTP id
 af79cd13be357-8cd6d503f2cmr1466052285a.60.1773088843947; 
 Mon, 09 Mar 2026 13:40:43 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd8576db0esm332951885a.47.2026.03.09.13.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:40:43 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 18/18] system/memory: Have memory_region_type() correctly
 describe containers
Date: Mon,  9 Mar 2026 16:40:07 -0400
Message-ID: <20260309204007.1709441-19-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260309204007.1709441-1-peterx@redhat.com>
References: <20260309204007.1709441-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

MemoryRegion containers are not I/O regions,
describe them as 'container'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260309183536.88976-5-philmd@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/system/memory.c b/system/memory.c
index fca74ee62b..17a7bcd9af 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3234,6 +3234,8 @@ static const char *memory_region_type(const MemoryRegion *mr)
         return "rom";
     } else if (memory_region_is_ram(mr)) {
         return "ram";
+    } else if (!mr->container) {
+        return "container";
     } else {
         return "i/o";
     }
-- 
2.50.1


