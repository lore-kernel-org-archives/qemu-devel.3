Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42EDC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH3s-0004Sm-NT; Mon, 14 Jul 2025 07:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzm-0000yr-7G
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzk-0001s3-73
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d3Zq0CyZlXef+/OkfyoF0P1FjAOrvSnpLIELP6T3/J0=;
 b=FiiQ+CZZO1UXqCKeRYRU6fbZru+R7eFPznK9WnLIaQc9WE44Yx0ZWPb1u7KBT0WreezmVr
 f24w9ufxlgbt5dGVWzC1Ai3buoectydmH+nXwxCdTX2wq9Jr3F91FsVEBsV5IErv0J8P0p
 k6LLPCrDrPqOGVgM+EoFTaiBDq1X1II=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-SMK9wdX2OzaTtt2pi5bcHw-1; Mon, 14 Jul 2025 07:05:14 -0400
X-MC-Unique: SMK9wdX2OzaTtt2pi5bcHw-1
X-Mimecast-MFC-AGG-ID: SMK9wdX2OzaTtt2pi5bcHw_1752491113
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4561c67daebso2040585e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491112; x=1753095912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d3Zq0CyZlXef+/OkfyoF0P1FjAOrvSnpLIELP6T3/J0=;
 b=aUS95E+DfP+2FoF4byNIyBdsfI0G2xYWl16/B+MiMnrMXYtEHvjaHzo5qNXbdW55MV
 5CqbRkex3kvz1t25sMJVlfHIdw+BkiiNYnwwo+8yYUGD1BeRADZqDRHuaP9au7pK1kNS
 yL1nJ4Ioqy8NB+Cmoa7+xrV9AJTT4xN7xIh09JZJcHQylhCSwdVGfFEQdPIE/1rPWHSE
 j6hhe+LHsR5n9SMWTAew5gV/xbZm1uul9EsEgjH8OA4b8/Nj56r9Ar1k4UokRdo0VjzJ
 A+cabOMLejETQs1E9hz+E8CF9Yo9qxzCOT/t3VolqTjOAVA6UEz6vcrgMu2Aw0BpYV1G
 X0nQ==
X-Gm-Message-State: AOJu0YxE7PHUxa5PBcLfZR6YTNt6RFwR3BZ3mlr52hISalITupFGKy41
 GudNW0auYEIhkvsbd6OUx3SS2Pm0Dg0Wio2r0nDJklXQwKMRQKCpgpetrPQlTeXUIVUwUI0ohb5
 9d2SgZd2g5TqwIucEEIR2yl1qOrYO3oawEF1Q84Y4uzGcPd05iXx6dF4Px8Dbtb0xUUyRizWChC
 yKu4jH/8/sYtAPhGpZmgiNqrsB2VIE0ZZL8hVHztNm
X-Gm-Gg: ASbGncuO6Y1cE4i+/96pgxDnWISAoLGTBoOxarOvhzemlB0mWdXVmGp2+tIpxD69WCx
 SRLv+E/9cuRI1szmYCa8v33tS6danYxyWjnjdlUrRsAJ7Z0g2oRVFRcbxiMSVnyZZtyjEdDsgjY
 x8JxBwlmqEz76UozmXLmd776oE4tgziM02Iy00h7O622YgJn8qsJNvKzp02jObs9EEpwchpt2sY
 Rzr1UsvQZQ402+YAOggopBaMv1sSerq+cZRInv1bS6nzTExDZU9SWYsP7v3FOqOVWxIC9b+TeNc
 FtHEGaKq1DxpZT7oBqHI/t36iDwRO6l+NnzwpZdbtyI=
X-Received: by 2002:a05:600c:3e08:b0:456:ed3:a488 with SMTP id
 5b1f17b1804b1-4560ed3a67cmr65381925e9.1.1752491111953; 
 Mon, 14 Jul 2025 04:05:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgA5QGPTwgBWV2PjSQ1oeqr2mH0pkz73s3Xy8sDZQT2r9hiJnEKG1LQ2Yo/m2wUcaW8++xdQ==
X-Received: by 2002:a05:600c:3e08:b0:456:ed3:a488 with SMTP id
 5b1f17b1804b1-4560ed3a67cmr65381575e9.1.1752491111485; 
 Mon, 14 Jul 2025 04:05:11 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561d19a21dsm19852865e9.24.2025.07.14.04.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Gerd Hoffman <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 23/77] target/i386: Allow setting of R_LDTR and R_TR with
 cpu_x86_load_seg_cache()
Date: Mon, 14 Jul 2025 13:03:12 +0200
Message-ID: <20250714110406.117772-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Roy Hopkins <roy.hopkins@randomman.co.uk>

The x86 segment registers are identified by the X86Seg enumeration which
includes LDTR and TR as well as the normal segment registers. The
function 'cpu_x86_load_seg_cache()' uses the enum to determine which
segment to set. However, specifying R_LDTR or R_TR results in an
out-of-bounds access of the segment array.

Possibly by coincidence, the function does correctly set LDTR or TR in
this case as the structures for these registers immediately follow the
array which is accessed out of bounds.

This patch adds correct handling for R_LDTR and R_TR in the function.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/95c69253ea4f91107625872d5e3f0c586376771d.1751554099.git.roy.hopkins@randomman.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index be3ae6d546e..9829824ac89 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2417,7 +2417,14 @@ static inline void cpu_x86_load_seg_cache(CPUX86State *env,
     SegmentCache *sc;
     unsigned int new_hflags;
 
-    sc = &env->segs[seg_reg];
+    if (seg_reg == R_LDTR) {
+        sc = &env->ldt;
+    } else if (seg_reg == R_TR) {
+        sc = &env->tr;
+    } else {
+        sc = &env->segs[seg_reg];
+    }
+
     sc->selector = selector;
     sc->base = base;
     sc->limit = limit;
-- 
2.50.0


