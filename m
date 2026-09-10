Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77205C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ot5-0001Oe-OA; Thu, 10 Sep 2026 20:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lV9-0006I6-BT
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lUq-0003CQ-K2
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+sod/F5ZJD19JAbUugoGre+d4N7kWAhYD4EQjfTMC7Q=;
 b=W0IciWMsDvS9o/KohcBSa79V3Za4jb1X3TOVwrD+5zaG0Qm4SSDXgCm7ZHIO0MRdXPhaX8
 1v5LBid+hSlc8e9bN9UDxJNnZfdZoh/R9GwkSrpMM5J+zmmDFZjebpyCtWFz8b6w0PQsFE
 sfwZWtohfAxVCp3cf8Vf27XnA7o99b8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-r_6EDSupOFSXp1y2BzjkbA-1; Thu, 10 Sep 2026 16:14:00 -0400
X-MC-Unique: r_6EDSupOFSXp1y2BzjkbA-1
X-Mimecast-MFC-AGG-ID: r_6EDSupOFSXp1y2BzjkbA_1789071239
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-482e05af072so99785f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071239; x=1789676039; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+sod/F5ZJD19JAbUugoGre+d4N7kWAhYD4EQjfTMC7Q=;
 b=B6c7jCgHhx054dWaxfTINLJRBW/8Ati7ZosJtMgTU0hoJ+dC5oLnw4Oh3USoCwzNtg
 2ZeVONyqmtYGkccABqh9P6qpBM7bWcbOdP2R8UfZ+pvjS46DlIRd825zDh91UjwAGOEX
 ybe8CSxlCa6BbhRm9xC2ieNbIpN8B1OoknEsDXShn6FeZxgRWfOkcDbYDZwuUVkssC3+
 qkhRTYcQG9dp0P/5mX1intu1Xb4eN/Bvz1E1G9WcH4JRN/5Xcm8b7BAlSD5/t/QfsPJV
 7ZKL4HWp+NJvsUrdlA0FFZYyePG3SKXtlr4CbqTBR2mfYAcmzT0W6+qw9So1UXPZoZcy
 I10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071239; x=1789676039;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+sod/F5ZJD19JAbUugoGre+d4N7kWAhYD4EQjfTMC7Q=;
 b=daU58p9pcCJUqnDoT9IWOmNBSjd8gFWMicqraOpJshPvgsY4/lWMISscUcTc8YLTyD
 SOsLz/0hSXpY1irsKOtaOEh8eyXyw3Jity/pLAHwMIFSn4/NYXK2jWmHzdM1uuSNNmm1
 rS5FSgdmgrUVwpfssgizZzwJlPfETXS4kKfMQobh/pZx7QxauxTpem1MM5dRfoZumJiz
 n8HOztquO5pNeJ2vBC0oMi26k4Q7jmToo5jfiLp7qXrzUxMaUQaG6jOGrd+UhpzmPzBJ
 G81ZRAnYEtgCjPa9JpuVZx8S2j0e4nFV0ItP7Stya6EwhlnhEePH8Fi0PNaVPZWu5dFO
 +Gdw==
X-Gm-Message-State: AFuF++nCF9zWCJYmgE3nlQU8SWT48dZXMzeR2seNuRUrFCUoh2oQo2xY
 OWzxcjHsBhifyGUl6GznTo+81vMrLKVGFuCTTaWZL005EbIF9iCcPavhzwE7njQuWEXq97bj+oo
 fMLDcfjgcs0xEQ28l4INpg3yL+O3GKvAscPIgwvc7f2nzB37T9vBSUR75Y1ZjdObZFilB0e4x9h
 o4WsetYvlPEiDtPInP6HHMR04mXUBJOznJPA==
X-Gm-Gg: AYBFou0eiEq9Y0qYqePyIdEYX53EPq42ZSBZQlCghYN/CpCa4cVLVG8EjwdOcL3UFMV
 rIODkWbi7GM4dETSh/bzCLNlDfCWz1aMGgvhlXedfYD7Zt1dTMAuN8Mtj7EdUvv2mGbFx6OG5Io
 Uj1y5WhaGsotrOI/TYD2WhEI4PXfi+VdPeoAjlEwzkDJWbS9G4LzpP0cUJOgpTw5tGv8wTt88nA
 8PyGoUY6fdk0GHNND2GPSrAEO6U8hmo1SqnevkY+LKW/BRJI+OBHFAKim2dmShYZ5G2+TBezlCL
 0n7SoOjudoLeSZM7GCmAhgmMcD5Bt3EX8i9wtkqC16eD7cW7Pb+fOymjAw5bxzXTkaurvJWzmSB
 ZWohTtyQiI9cYBYz/9jXStb8=
X-Received: by 2002:adf:ee86:0:b0:485:b148:aa0b with SMTP id
 ffacd0b85a97d-486eb300f56mr524341f8f.36.1789071238878; 
 Thu, 10 Sep 2026 13:13:58 -0700 (PDT)
X-Received: by 2002:adf:ee86:0:b0:485:b148:aa0b with SMTP id
 ffacd0b85a97d-486eb300f56mr524312f8f.36.1789071238271; 
 Thu, 10 Sep 2026 13:13:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e6f1sm814687f8f.6.2026.09.10.13.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:57 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 59/90] amd_iommu: Return empty efr for stub call
Message-ID: <374b65875652e44c72e0a3b6120338f79eea58b0.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

From: Sairaj Kodilkar <sarunkod@amd.com>

The stub call should not return normal EFR as it is used as place holder
when actual AMD IOMMU calls are not available. Hence return 0.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260807061250.27739-2-sarunkod@amd.com>
---
 hw/i386/amd_iommu-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu-stub.c b/hw/i386/amd_iommu-stub.c
index d62a3732e6..fb36dee903 100644
--- a/hw/i386/amd_iommu-stub.c
+++ b/hw/i386/amd_iommu-stub.c
@@ -22,5 +22,5 @@
 
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
-    return AMDVI_DEFAULT_EXT_FEATURES;
+    return 0;
 }
-- 
MST


