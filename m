Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190F1CD3441
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMMO-0004cZ-JP; Tue, 05 May 2026 16:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMML-0004Z0-Dd
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMMI-0002fP-D2
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JccatWTm97VV50DRacC5l35//16UROxbyfZ0bobIw3M=;
 b=S/JkmYycS5WB+85yZ9qEyaT1dH1dYyqAbAKOjl4IrJMX9ve4GRgunNRWDkfPf7KCWHgfy3
 96hTwk3oN/E0rQ7LSvk8lrptoklDoLpOHoyQIwydn47oveNV0lT1LjF9qUw9KDD1sGgKy8
 VEFr3XJ0JcXOrbtDymXMVgov913Srfs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-H_E3Q3HKMW2gMp-KGqmKkA-1; Tue, 05 May 2026 16:27:08 -0400
X-MC-Unique: H_E3Q3HKMW2gMp-KGqmKkA-1
X-Mimecast-MFC-AGG-ID: H_E3Q3HKMW2gMp-KGqmKkA_1778012828
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8acb85a973cso83859056d6.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012828; x=1778617628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JccatWTm97VV50DRacC5l35//16UROxbyfZ0bobIw3M=;
 b=L6OXOoWJ5jx6AYkEQfWGDyf13QtT1VSgF37LVPw36z0jN/35a5KhL3yJa8lQRbt+Fz
 XMLCeFezdx3Ic5iHT/sGRr8HWWPtY3k2V51O2EQ0patMzOA6rFVG5C4dtWkCVwJNxkt0
 QlwHtJffrW0AaTcWNYSVl5QsyfCuRsSc1N6/NmHYNs/4CT7ihR5WjcvOeZiP1YR/dQ2q
 u+iqNBJqtLX9k3TGlXZOtjbcrqO8Fj4W2hzFnQt90sSeVL6N+BMFMtWWPUlHQS0uyMiW
 Y05MdIgSEhfI8MV6JRPPQdI/yTDTACZT93ghfQIwqS5NGhuPHZuRjTX388u7HShMUD9m
 rSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012828; x=1778617628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JccatWTm97VV50DRacC5l35//16UROxbyfZ0bobIw3M=;
 b=rgeTJEHXmlTzLYkNgr0lh1D4siD1rieLcbGPTTDTTFVaxVEJALrSYnwq0wWjPtc8ub
 ZFq2V6DvDCJhmsp3cz9/X/J56TQQy1OxMX3wS30f1iEhbujNV73ny27DJIQSJpiN98eN
 mBqPMgySss0uhkgFP496uaRliJdSLbZQAR3t1SQr390byX+Rx8a+vZGFhQ/lDuJG8bN2
 XBN/dYkO4x7uFA9Wz6d7OyfANTb+dGxtOpCp4KhAE371Zf0tnsPMoEhoc1ZmbLA0GyL5
 GKE52vb0gCjTw/3cFEHQj1/MvaFEOjpmojd84/L1lX22W6T9yI/7raglK0dflVOGBp0M
 da8w==
X-Gm-Message-State: AOJu0YynuieYRhyX72ED1poiRYgtf8AVgDza+gFh2BmgJJvzFi0yZ30g
 Wud2n8RYjt1vpj2xeeIh3U3CdAvGNxKm2vTpvI92d5ZeJGhJPybxPYiWydC2CHcmPuk91jw0ylD
 NbzboS5zGPkBKrY3pMBor7tHYPV1/RX5hmrxOTc5cZihNtozVdpaHb9/aLHc6pnWu1fB8B9LUar
 6kSs7PoXOBjOeLozLK+dqSwb3pCysySjmdurcY7Q==
X-Gm-Gg: AeBDietBZhg/bo0G/y+Dss1PEIB6g+4gU0u1taf3jV9mN4DqNBgvjNTp9OZvdzmVfnZ
 2lDeopOAtJmLKg2EV90qfalKGIg4h1V0dG46JyJxMAvIhpTumiQGLHD2DIk23NEv9xc6Z1yAItK
 MAISsUFmgrEP99wXW8kQhSkmXMk2X3nVif2TNypE5hkmh8P+vGlTYoYP1Tx5wOZ3iirgB6UC+wE
 yAmIbEvglm85IGsc38FCT8GopCIjgReZnPoFCmDWp0B6fuDD4DY/AaLFhkxf4Z9SJk7kTP0MG3D
 niNFRWbefm+4PesApNJehPQVDYwh4cram9F3MTggkN8pXMoIJk+fx5WKFRK0Jpv/kFbD3WV5J4U
 OLpCkACiNybHJoO8LKuWfMtvsKms55klefJNeLJfPnb/gIdyWKd5tekk=
X-Received: by 2002:a05:6214:19ea:b0:8ac:a553:528c with SMTP id
 6a1803df08f44-8bc45f1aee3mr3796726d6.42.1778012827587; 
 Tue, 05 May 2026 13:27:07 -0700 (PDT)
X-Received: by 2002:a05:6214:19ea:b0:8ac:a553:528c with SMTP id
 6a1803df08f44-8bc45f1aee3mr3795886d6.42.1778012826872; 
 Tue, 05 May 2026 13:27:06 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:27:06 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 CJ Chen <cjchen@igel.co.jp>
Subject: [PULL 20/23] hw/npcm7xx_fiu: Specify .impl for npcm7xx_fiu_flash_ops
Date: Tue,  5 May 2026 16:26:37 -0400
Message-ID: <20260505202640.1011006-21-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently npcm7xx_fiu_flash_ops provides no .impl substruct; this
means that it gets the default of "implements 1, 2 and 4 byte aligned
accesses".  This is more constrained than the device permits in its
.valid substruct, and also narrower than the functions are written to
handle.

Add a .impl substruct matching the .valid substruct; this means that
all guest accesses are handled directly by the read and write
functions, and are never synthesized by the memory subsystem
performing multiple accesses to the device (which would not behave
correctly, as these read and write fucntions have side effects).

Based-on-a-patch-by: CJ Chen <cjchen@igel.co.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20260428093339.2087081-3-peter.maydell@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/ssi/npcm7xx_fiu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
index 02707de350..2d5bed005a 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -250,6 +250,11 @@ static const MemoryRegionOps npcm7xx_fiu_flash_ops = {
     .read = npcm7xx_fiu_flash_read,
     .write = npcm7xx_fiu_flash_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = true,
+    },
     .valid = {
         .min_access_size = 1,
         .max_access_size = 8,
-- 
2.53.0


