Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D51CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:15:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDZ-0000xI-45; Sun, 14 Jun 2026 15:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDX-0000m5-4n
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDV-0002lh-Jk
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OdLmIBYj2TX81sVsFxeL3brQiveCFghfyugzGHZB+Qw=;
 b=B9mx61+BYJ4D8uJcK6LRWqydftOjEot4lu3VJu2ALkwhht1iT/3+uJkxsQvWIsosypwUpM
 OYAYa7dyX55Aj9Mj84dcTYoBIgZHWp94w/HwyT959CQ6icubk0mVVQdJkYgjlMj3JgaLrm
 zdR9GQxAZQZ+TTRfmHAGVXEmUPx+DyI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-S5YVO2ChMH65DXRZyh_Fjg-1; Sun, 14 Jun 2026 15:09:55 -0400
X-MC-Unique: S5YVO2ChMH65DXRZyh_Fjg-1
X-Mimecast-MFC-AGG-ID: S5YVO2ChMH65DXRZyh_Fjg_1781464194
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-46067399d5dso1145096f8f.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464194; x=1782068994; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OdLmIBYj2TX81sVsFxeL3brQiveCFghfyugzGHZB+Qw=;
 b=M91crpalHVz6VZk2NDQnmWEA3ot0SO+Be5udSRphhiJ3iHanCxDEXDQ3IH2f0Fyas/
 lZzeTVfkWj+ttEC2K/GOoaRyWSIvLyCwkrdhC8t7XZyp3cynNZaxOimL/ySHjlf5kVFG
 ZdsWzGtRvKD+Xscj4CKLnctxiRddSR6JWJPjiXTc17zbCp2l/zudJXlqtdpDIaTuRtqS
 nEUcgwtEKpXDEXq1DRXYXpsclqzf1RVqmswEpUAPpwrfZZZ5HyheKuWR18pMCDPxQhPh
 MY0fPpcOB7whcqGr88MKEUAMx+6mCcozyA+G7kbZUqnOz3Bd1BW4CLkN4fDYvYBVfkJe
 tE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464194; x=1782068994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OdLmIBYj2TX81sVsFxeL3brQiveCFghfyugzGHZB+Qw=;
 b=LcTMS5TIuQwbMLhsbuTCK4nGes7haT53rZaYynTLKMtBp+siSVyLXDJgDGJvjmpvnm
 EI4rfCWpMICeK17sHtDh+Zz781+rmSekNFnbW4yxNKRp+GplWlmGVkvM3S1Vt6uJ3ZpE
 CDC/fdqj3HqxHyMDeFaY7SVMBL17J21ors2uoVJkkwHTWh+mZmXWWKLd6taYvDPKsDvw
 cN3cs+S12BVmAOhQfO8qk4m23iXry+DJbtNTPYI0x2m5hNqacTMLeK61HtpG7an2xtzs
 kJl4P2Hnmox6gqPbz79/KjJpQ4x7amGIS1Z+qSi4jOOugrhH0NuuDJ47tEG3QCAq+wLn
 ChWQ==
X-Gm-Message-State: AOJu0YxYwWWW4/aloPyLVoUjmuPFKIrmx2xzzg+ZI9cfoD9EPzoEHAbD
 dzLyATQxDlTph04NpnUjiOZWGhwo1nkEi1eqTqmiiIypxpKC72bSf844vsfIuFLrq+Twpa8swPc
 JiIdulNTiGaMLjO5jrjhOgOTHiVjbZkCR0uXXXjQMO3H3RDdgDeJLMba/hGJ5iekxsXbAl/C9PY
 /M3H1T4Nqh+7siB0ktjTZzvOZ+C7K4jkwwjQ==
X-Gm-Gg: Acq92OHF69arAnnhO6454h9HgtOb1tZ2rmY+7Q/+fcW2dq3qdUdjET2Yf0/LxBTjJhx
 Q+B/WdF/RQlYPtDAZn5NVr/1upC/jFpp+DjKsclsmeaPNfGf3fPpdJVnUiD8jzQx+e6h2F+zBte
 wLZkQS7XZPR0v2FXHEVrWvBXvb3RHONPCTrrKIUS93e9sPkowgbfIUjWJkKqn8+kdZtzoIQP3Hc
 bXhVSP9WSFBY3hPjavUZlkwbxNe+c+g8MSFLpiPFaOtiAXrFRmuEXJKSWLR7JkYql28VCKAusTW
 zIj+YCQUHz3KW7Kn53pNJ4EbqKVlIs4/nV3eTGxHa60OrQs4aj0TQi1I87m8rCbke2DsQvBpIt+
 q/492QiIu71AijmCmu2dP0gaF0b1jJL5JdwNGquaLh7A=
X-Received: by 2002:a05:600c:5487:b0:490:ea8a:32da with SMTP id
 5b1f17b1804b1-490ec509524mr135639905e9.26.1781464194231; 
 Sun, 14 Jun 2026 12:09:54 -0700 (PDT)
X-Received: by 2002:a05:600c:5487:b0:490:ea8a:32da with SMTP id
 5b1f17b1804b1-490ec509524mr135639665e9.26.1781464193707; 
 Sun, 14 Jun 2026 12:09:53 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0c10sm27660598f8f.21.2026.06.14.12.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:53 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shiju Jose <shiju.jose@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
Subject: [PULL 100/106] hw/cxl: Add fixes in Post Package Repair (PPR)
Message-ID: <37185e2cf15adfb36ddcee20c444ecccbe26be4d.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Shiju Jose <shiju.jose@huawei.com>

Add following fixes to the commit: hw/cxl: Add support for Maintenance
command and Post Package Repair (PPR).

In cxl_perform_ppr(), remove and free the maintenance entry from QLIST
if match is found and PPR operation is performed.

Fixes: 5e5a86bab830("hw/cxl: Add support for Maintenance command and Post Package Repair (PPR)")
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260306101423.986-3-shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6b16cc206f..20e0b7e476 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2068,6 +2068,8 @@ static void cxl_perform_ppr(CXLType3Dev *ct3d, uint64_t dpa)
                                 CXL_MEMDEV_MAINT_SUBCLASS_CACHELINE_SPARING,
                                 ent, NULL);
             }
+            QLIST_REMOVE(ent, node);
+            g_free(ent);
             break;
         }
     }
-- 
MST


