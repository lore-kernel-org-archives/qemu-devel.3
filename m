Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0927C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nzV-000234-R1; Thu, 10 Sep 2026 19:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lV7-0006Hi-AK
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lUn-0003gS-0B
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mDN0pKO3NI28SBsIJ08S3mFqoBiJB+cbySC7sAon6z4=;
 b=SZqlDmeRjdkiu5BgyDjGtC7v04ByjucgLYr8htr9KI83sOO07Ved4cNlFaRhJsxM2JEqXk
 ASFrTnTdUXTKQ5lz9pW+5HcNxc4hCRaz6n2bEgr/zzs5UWZE3B5df3qU+XuuPnl2yWRQLT
 MMHYp0evREtN1zRLNohx84visErhCM8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-nscHisKWM8KDrpcLSie0gg-1; Thu, 10 Sep 2026 16:14:33 -0400
X-MC-Unique: nscHisKWM8KDrpcLSie0gg-1
X-Mimecast-MFC-AGG-ID: nscHisKWM8KDrpcLSie0gg_1789071273
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4994aebe932so2236745e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071272; x=1789676072; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mDN0pKO3NI28SBsIJ08S3mFqoBiJB+cbySC7sAon6z4=;
 b=k9gnDePZNrGsoZDgjbFG41OgxvlyBKVwjuXbCQm/bTgN9kz4hi4uAFAogw3xXPMOEX
 j17oczpc/uNxM8QlbTuAQUI42gTVnzcYRgdgY+g1mThKTeV0ac+aUQN3VhNCcto7rATC
 +1bzHzNTS2+XVSRrFY7DAUWALAjHT6NbVuslz3C9nTt8q7EtSrenAqrVXII69pSJfgr4
 xbR0L8gvCpuwr532nRyErzjoZz7a925GzcbGzIllUke3kcdBcNoxO4upoKqtAMQUknRP
 rt0CVxS1L/C3GUeoyjD2Eol/q9BTUPCY5cDgFqjcJcgMyqkwjlNQgalAAfG19S/SqJCl
 g88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071272; x=1789676072;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mDN0pKO3NI28SBsIJ08S3mFqoBiJB+cbySC7sAon6z4=;
 b=oLGGRlIo71PkB1pGfB3KSM4dSpxUV7TO65n9+nlutHn+v3yaZv7I7ROvXF6nYb7pBT
 Jh3p8jb8TcXBci1iQbIY+RgLSISvZtlPIews0Lpyk5GtSD7L3LeKz7rBke10GSRupFKs
 3WyLWpY/QS5hSf1zzxpZPpDnX6mdaOJhPbSqXzlO7nHW5XsXMf/8AkSlCa/kNbcC/vV8
 O/FdyvGjyxzL84zxCTkpUvTlin0aBdL8wHWeX2hr17Ay8+C8uSl6UjKhpklXQrcvVYQ9
 ntYK3ZImBfArOW0A8YweuK5imnniVkbadu4SWHAHcGsEoO7Bbl1KASvE6p3srGvqhMd7
 WLIQ==
X-Gm-Message-State: AFuF++lKu7YuW74aOAWESTwECdi6n5xK+EEq3Yy8bySvWUu1sSw9z8XH
 SmMiMmCyhwKgTavqgWWn2rxD7CjvlprdW2azkWhgY6XQAqtNjCkjCAFA001WhOeNQCtqueay2I6
 I8UQulDZ0C70BtLLlbsKnvXSEBVENpdROrZw6fHpt7kAZP3pM4cBeVfdXCC22C3yQkocsOtVSQh
 odZYRvSb/LM2pztVVmVq6sLu31UjAxcNHVcg==
X-Gm-Gg: AYBFou0WbOuCGuxbr71VMJJMq7Sn4ImiXlNlHBmm0haVmBPJ3/43Hs/ta9ObxgyZOVY
 0X0kRVqBoshkRX+pS6///kxQvGgCzeO8+E+/c0i2PEqddVF5y99Fwz4rsQCvs/nY7PwZGRgYW39
 m5E5+oL7igJPVZkvBcVh9/8Ws/k/DmrgHtBGXUF0SE96QDB/C6Xw0rqnZpRDtg92MXKV6xLnKUv
 Z7iil4p4CfUVBoojmfyl8s8N79z31hm1D4m3sAlg9TCN8K++YWsxwJ+2WX9vwcey+aAmYocj42l
 emgq1kc3UGlc/Wh5ICmuUx6d2kK2EFFM+S/Z7ULk3S1sSo3vG9/7C0daTVW6ErRnOYuTBgfdXvu
 XNhTWqU1xzTwng0Ofq/g1Usg=
X-Received: by 2002:a05:600c:8b38:b0:49d:272d:74b4 with SMTP id
 5b1f17b1804b1-49e619a1e56mr16639725e9.2.1789071272493; 
 Thu, 10 Sep 2026 13:14:32 -0700 (PDT)
X-Received: by 2002:a05:600c:8b38:b0:49d:272d:74b4 with SMTP id
 5b1f17b1804b1-49e619a1e56mr16638985e9.2.1789071271984; 
 Thu, 10 Sep 2026 13:14:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60ae55f8sm19687265e9.15.2026.09.10.13.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:14:31 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:14:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowangio@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 73/90] intel_iommu: Only set dirty bit when PTE exposes write
 permission
Message-ID: <349aac91a1cafad9688451aa937543cad68f7ac5.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Clément MATHIEU--DRIF <clement.mathieu--drif@bull.com>

Setting the dirty bit without the write bit in vIOMMU creates a spoofed
shadow stack PTE that misleads the guest OS. This results in infinite
PRI requests from the device, as no actual write permission is ever
granted - the guest OS treats the PTE as a legitimate shadow stack entry
and considers the permissions already correct.

Fixes: 65c4f0999991 ("intel_iommu: Set accessed and dirty bits during stage-1 translation")
Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260903150649.2281104-2-clement.mathieu--drif@bull.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 7c442a86ca..eccb16346c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2039,7 +2039,7 @@ static int vtd_iova_to_fspte(IntelIOMMUState *s, VTDContextEntry *ce,
             return -VTD_FR_FS_PAGING_ENTRY_RSVD;
         }
 
-        if (vtd_is_last_pte(fspte, *fspte_level) && is_write) {
+        if (vtd_is_last_pte(fspte, *fspte_level) && *writes && is_write) {
             flag_ad |= VTD_FS_D;
         }
 
-- 
MST


