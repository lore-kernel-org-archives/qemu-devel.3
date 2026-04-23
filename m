Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5609EF99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKj-0000xf-9m; Thu, 23 Apr 2026 06:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJW-0000Wp-2L
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJT-0005I1-W1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GkiSAJE0vQoiSR4PIKYvL4RDNMj7yYo++qu0kxfwAkc=;
 b=CnV2jSAU/jY7+Eo6zABVlffhV8uILsxFyJAnsm2S3ngU3ojj8R60qXVHY27wj/dm19X1n3
 wG2lC8jrV6ziKVmp1nPjMEX/RDnjd9fB4BFUDYg+NR5Oiub1tZDWasJnPpMHaSXeB+x/UE
 j+OUCqIn1uxHUay8jqQmW58JgFQrkXc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-osxRmsUSMy-Z9fvA87m6TA-1; Thu, 23 Apr 2026 06:29:35 -0400
X-MC-Unique: osxRmsUSMy-Z9fvA87m6TA-1
X-Mimecast-MFC-AGG-ID: osxRmsUSMy-Z9fvA87m6TA_1776940175
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43efc93e4f6so5207748f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940174; x=1777544974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GkiSAJE0vQoiSR4PIKYvL4RDNMj7yYo++qu0kxfwAkc=;
 b=oEPnFAKKRoPBhnWiI6tkq7Q0a1AczImgfqTDqA/HmkSbK4Btth1bIENWioZa66G1WX
 XlhuoHkVNXGLXViBstkuLu5zgTRdMzmpG38mzqZDfePa8fSRSIW8XYX3XE0vGTxa1jEJ
 3VPkJjHsSTs4ozsgkyNc0bAz+tMhBmDDzDHYc9eiB5IFq2TvBitQlPYQvGQvu8vMHIdG
 1Usw/NnkoqJViRdgVc8py5Bo5fwa6I91KeXhAuRlGxIM+CJPHHSVL8utLl2WCc6sLTFQ
 rC2h769K1+ymv9ia1MUAJN56nYCg+/eNsRcEsMmgOzBOLarpBnbTZP5kTZ9mmU96TM7m
 I0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940174; x=1777544974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GkiSAJE0vQoiSR4PIKYvL4RDNMj7yYo++qu0kxfwAkc=;
 b=hms2Mt5LEwlAysdDv3pz5iemcJV3uEKHvwmXaBn7wEWL7ixzY0xViKRotroVnfF+s4
 /17vAepcZWygJvhyl9ptSJk/PiBAgUWTh9yb7WI4TMQdJYLkpTryEnLexeio8JGVQtw2
 iAWQRn17YhvOLWw+FqfPpFl84bLECsAvOgsVfVAGe/IhHg0/pTcTmETQujg5YXdjj0mZ
 ikzg5F3Y3WzB+xZLkHz8TsDteKDtnyctTrcVp7Y9AJ0+yB9+iw2FqmwC3Y/a2QNtizv1
 HfSYCtHDAdMltCNPsKpBQn8oV/Ads85emfjbJKkO1bxmwrCtCL+IMjJv544iusKKF0p0
 9egA==
X-Gm-Message-State: AOJu0YxnWCQV1Mt9V4OdUAjr2ZFM+2CuvMjV5bamUKgebLYxfE6CwKck
 BexvcAefNEPvBPQrOEkelip3Mi8t+Ynw/BSz5GmDZITzx6viNCzm3eqcbERFMnbSl6IPwvz1JiZ
 EZ0V5GBCIUqzfVrRNce9XEEs09mo8FLLHma6oCpewkn5Xyx4deEd/mAv/htuLC8MFS3ihDzOobk
 PFhT2zf/pZiS+b9mRkZ86hVtoBMPFduN6x4zswZV1Y
X-Gm-Gg: AeBDievkkBvYtA46Tarq0OlbIUk0KkS8G5QkoHBViIKi4MlJABZc4bgi0L1zud/optw
 EeJsTETcKfBhzur51p1EJlvSWp7Kc9dhDv46qYh1+M8n/+JUqTzess+wtL+qt6Ng6/dT/3jv/BC
 bPXHYo/CeVGM+VxuWC/VTbY/ysGuuNAdkGhjBY7q5s2VoDTPZDfOwQaxrExD2qWRQqDcBdmAZoh
 yNY84CBqePbeNW40+aQyhTUpfBRPqu3adfFAunSqcKPx8so88nj1Cyy7tcGMGhCezLI2vMdsmj6
 pOnqSK5BkteDSQm9OubxyWUxPahW9M6EslpOpvHZ7WO340bbhbalggm0dqHpUdzqZsL8Z0a3Tgt
 eg+ckJEGvTf9EGkKeL28LdCy3y++n0Ze4O6hp/I53QVEk5AJoVyPxKW0IoBf8kjhyp/uDes+aJX
 +Q9Hj8PKphdVnY7JzYU3X45R9cMSziDXrcY+4=
X-Received: by 2002:a05:600c:c090:b0:488:c744:49b with SMTP id
 5b1f17b1804b1-488fb74a53dmr277736885e9.7.1776940173701; 
 Thu, 23 Apr 2026 03:29:33 -0700 (PDT)
X-Received: by 2002:a05:600c:c090:b0:488:c744:49b with SMTP id
 5b1f17b1804b1-488fb74a53dmr277736625e9.7.1776940173168; 
 Thu, 23 Apr 2026 03:29:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c0354sm478940715e9.11.2026.04.23.03.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:29:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/25] meson: Use stddef.h instead of unistd.h
Date: Thu, 23 Apr 2026 12:29:01 +0200
Message-ID: <20260423102922.443639-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

POSIX says stddef.h provides size_t, which is the only thing
we care about here. unistd.h can be missing in non-POSIX runtimes,
so include stddef.h instead.

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20260327134401.270186-2-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index ab3e97eb9f4..457491c34e2 100644
--- a/meson.build
+++ b/meson.build
@@ -1068,7 +1068,7 @@ endif
 
 if not cc.compiles('''
   #include <glib.h>
-  #include <unistd.h>
+  #include <stddef.h>
 
   #define QEMU_BUILD_BUG_ON(x) \
   typedef char qemu_build_bug_on[(x)?-1:1] __attribute__((unused));
-- 
2.53.0


