Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679ABE8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQvl-0006wi-5T; Sat, 27 Dec 2025 04:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvj-0006pF-IM
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvh-00073o-VN
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c6horWdf4WOLTTFYACcVVUN9syUzKw8SDpdBCerOzuM=;
 b=Vf4qRBfFBH+rsouKlMatZcAyxGqa8V3IIBivWapOrzj2NNmSFRDmonMz/PCGLzPsQARd5U
 WJ0fBn2l9k5fULxFOVf4Ll2BgyHQuK+zOxEzxiyMbcSLiBYb3eHNjL33elYeEy+HgcEd/W
 Xx4bV0pfoC3w5BIwKOpn24DqCBshJHE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-wjBOOtO6OMaABeu34GKOWA-1; Sat, 27 Dec 2025 04:49:44 -0500
X-MC-Unique: wjBOOtO6OMaABeu34GKOWA-1
X-Mimecast-MFC-AGG-ID: wjBOOtO6OMaABeu34GKOWA_1766828983
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-431026b6252so7793599f8f.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828982; x=1767433782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c6horWdf4WOLTTFYACcVVUN9syUzKw8SDpdBCerOzuM=;
 b=G2+LxT4y4bHNRdNGABLXETE9SlYfJRU9D8IAHzB3of1yjZs4AQIV8bFwEsrVVob6yd
 B9KN3AQjxZIghjAmL90qMtHN8hWmlElXp0Y7vgIZlF07hXhHZ5HLNaw1TjyuEiqsx+zl
 xALprHlsNLHkzc4K2l37p6/lRMNj6gC7FFVS9A4NlkDzD9K/gQr7DAsgN8q1X4bHtZpI
 IVnRJv8aKE3HPAHyY8dQ5QP71gZvziR6fJNQGKyS10VMK+gHx32i+r6jEJBT3cLNjD/h
 OO0OGfSnb5Ok+Z2NcMJxXun1KN60RXqW/6JcOd7rroAMCeP9NF1TFxl4drRuR8Pmj2sz
 xoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828982; x=1767433782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c6horWdf4WOLTTFYACcVVUN9syUzKw8SDpdBCerOzuM=;
 b=nXcuuQHq1dWTG70SXe92hq+d99jKn56ARTujOZATHDRzcQV3NhkmEarKwLgUT23F2t
 PWVbyQt1kEOAqwEnIyJyogGymlqPsjxnUtYDVK1p7FKgLl9t0iVIHSSViHKYD2UDjeAa
 ne/p3LVHZz/d4LFu7q6cRCDTxkQ8QQoVWMspUSJRy/zt3bUe7K3Vv7Q0LTQShoeoLjLL
 QinKS7jVOVi0pXXi8+e6l3FxfWPU837N9ScaFKxLO+nvdN7zfwnpKOTolucqD0QOZdk4
 HBWdkevly2tk8QC41X9meC/EfWyvOJKVNZ71HCya+Wy34hZQ1Oa8EJCJ6KyT753KWzQQ
 VznQ==
X-Gm-Message-State: AOJu0Yzj9EsQ7T2dxP2pQdCVWyBrjN3GJb6lwn7S5aNf0FaING9CtPXy
 649iCke7y67KQQnBjQmANbOXSjqYPaLVCLW3b7wgW67neRB0heOXdzbc8VFw7BIPJO/gGRp9Jm2
 vOJYtV0wyc7ug8biPNhoB8vusw8WMAB8DWwsxsGV/OvVusMPzb2AfUcL3pC9vIsVYYfslTAIfTK
 aZwKPkkl+HlNjOAlanZsRpgN1q/4UsnHZXOJHPPsqO
X-Gm-Gg: AY/fxX7tds6zmuHnSt0PQRkEWMbGDpx7oH+z3d8IGSTDLL+m0sUOYsgx+gjHNyXhJxN
 2ug8TOPzLMthOShRctW9jPCBZfQjq+HiMgAxQNlXbcfWcLfN+xD79I9HzCf3UFUqsM1dgpn3Ypj
 StDlTv5qoKpXt2rhuqJiPtbSjGvikdZl5lDL9rTdOstR9zJw8Wbo8CKVZbhFQZHtCt432AHwYsA
 OcXTAIN/Lyq6pr9oJ0EL4e7vZemcuOKDmj9Y9iArj3sxIzUnp5r0HXzGr5QyBV/JkzySmS/f30g
 aDQTmzKMUG0aHdfLBDOCiJCJEBknpocFhWxWCEF0XIaKBRc81Fvo3T3Ln7dw/cuzwo8WwdKv9Rf
 HOCQXVAss0aRNYmgBZ3uOQdy+ZKCr0ndW2vZQWRSkveyBuHvzvihHx7g5mSQVbsAEJKdjvly293
 OWmnV3HB5787yJ3Ho=
X-Received: by 2002:a5d:51cc:0:b0:430:f7bc:4d0c with SMTP id
 ffacd0b85a97d-4324e4d5102mr22441229f8f.28.1766828981977; 
 Sat, 27 Dec 2025 01:49:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHp0v+nlh2bn/w80acaEiwFahOktKmyib5jKkUZLpWcs1nnXwpzsWgyqyVv32cWYRHEpjJcg==
X-Received: by 2002:a5d:51cc:0:b0:430:f7bc:4d0c with SMTP id
 ffacd0b85a97d-4324e4d5102mr22441214f8f.28.1766828981456; 
 Sat, 27 Dec 2025 01:49:41 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2bdfsm51169621f8f.32.2025.12.27.01.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 113/153] i386/cpu: Drop incorrect comment for CPUID 0x1D
Date: Sat, 27 Dec 2025 10:47:18 +0100
Message-ID: <20251227094759.35658-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

The information in CPUID 0x1D.0x1 is for tile palette 1, and is not
SPR-specific.

This is to say, these "hardcoded" values won't change in future. If
the palette needs to be extended, a new tile palette (maybe in a new
subleaf) will be introduced instead of changing current information of
tile palette 1.

Furthermore, the previous attempt [*] to make the 0x1D.0x1 fields
user-configurable is incorrect and unnecessary.

Therefore, drop the incorrect and misleading comment.

[*]: https://lore.kernel.org/qemu-devel/20230106083826.5384-2-lei4.wang@intel.com/

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20251118080837.837505-2-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0f618ffb03d..4421c458498 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8381,7 +8381,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *edx = 0; /* EDX is reserved. */
         break;
     case 0x1D: {
-        /* AMX TILE, for now hardcoded for Sapphire Rapids*/
+        /* AMX TILE */
         *eax = 0;
         *ebx = 0;
         *ecx = 0;
@@ -8394,6 +8394,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             /* Highest numbered palette subleaf */
             *eax = INTEL_AMX_TILE_MAX_SUBLEAF;
         } else if (count == 1) {
+            /* Tile palette 1 */
             *eax = INTEL_AMX_TOTAL_TILE_BYTES |
                    (INTEL_AMX_BYTES_PER_TILE << 16);
             *ebx = INTEL_AMX_BYTES_PER_ROW | (INTEL_AMX_TILE_MAX_NAMES << 16);
-- 
2.52.0


