Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED070E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQvs-0007kx-HV; Sat, 27 Dec 2025 04:49:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvp-0007Tb-Rs
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvn-00074i-UT
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3jOxG/lOFaEuwFZnYy+B7I3hVFT1ihE0fudAiQRzeD0=;
 b=CTQ9Uwc+K+hi+aNK+Zwb7F5odCi+RCabOdbUmdw5cr5xrEKc2vKT+xqHX0JH0PFDrIVvew
 okqCxorLdIVHJ2/rP0h0ey1MAQw4YVgeV19dcm1vnd4s+fyIlEh3jnQRZd+a9fmXvhpcEU
 XHL3Fo1YuZ+xmPqJWT7GsaIF/5VleGA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-ZdBaFzp1NiOPMGRBeRrw0A-1; Sat, 27 Dec 2025 04:49:49 -0500
X-MC-Unique: ZdBaFzp1NiOPMGRBeRrw0A-1
X-Mimecast-MFC-AGG-ID: ZdBaFzp1NiOPMGRBeRrw0A_1766828988
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47918084ac1so65317465e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828987; x=1767433787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jOxG/lOFaEuwFZnYy+B7I3hVFT1ihE0fudAiQRzeD0=;
 b=WvTYXNnEaHTlYnUlJY3Vue+5d56CM8OzBQ0u4xS+Nr4zqlJ9KO1/25by5oJCQ4n0Dr
 wcvkEtGeMVMlSlO7MBKKMbONJus7oSwWQYwDR/wkvcRo9rE9w8fRCKdTkVuz2IIa+jgb
 HUNf8sK1cKNT0RzzQtyciICpKZsLgD0hsDr+B9K9evFRwuplIMMmUXALjpUFs+LKZ9ty
 DdkInGPqE1s0eFjy8mXBJgmmN95K7YjgDTluBH20o9XpQk1pMwy5KFm6IWoVUiTeoo6l
 REpC60FUSn60hqf49ZyAJCN7KGC21sWAWpnS36CLVLstrI48Cc2ibg2ALjZoXyzVuTmi
 24XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828987; x=1767433787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3jOxG/lOFaEuwFZnYy+B7I3hVFT1ihE0fudAiQRzeD0=;
 b=ATvjY4HJOErvRNuC2BxYJAX3VMEUmOewV1ElLcjyZ27HqNMlR6iOAQDv83ZZkFnn+b
 RLQM6IdMKFoMDkaxJ8dYS4/oKlVjTYXab9efiY908hNsjb9LCs1kL4kFAVFhH4uDSPq5
 hzWfkQMqCtcpJ52BDa5JLZquDgFOGRKtYBGQgqdGTEAhWilJZRPKeI/HYIfTQ817Chzs
 /iRT6EiVa5czPeV5+shfHSLPuVHBi8P/CUtLM3K3Yf14Cm/mDsFKbNRZg3amHq0giRBR
 P5cznR1BQvkF9jn5JSz4jmZuQ+ccotDVXTN8JE73B+6Ox0sWWEqOSoW4PMYwaAn3I+j6
 8gPw==
X-Gm-Message-State: AOJu0YxRBnZ7r1ntGHuTA10QIQaxbeZDYhSOweTN+s5MfITJTh3EIo0o
 gmLeEC4x3ulAp2xPp+/M23Q1qP+M/G52+3/ZNdA48nx9wzkBw4B1AtPx3XEvzQi70Y3Got8qewK
 jdbM1c4EDouyaQuvq0v/zK5Cb6ON4fCdMhP0OHuD3jr0eo+wHOQJNxDxW0E8jaypdg2FJ0e+kge
 aXFluz//OBdGvuJnyYRZAAa753kIFmNn6dcs83W0r3
X-Gm-Gg: AY/fxX4XDgzrAOVfSIu35tMHCPw61wp9sRRN+82+IP3ssMylyjXaOZIcpBIatvtnrCm
 jEN5fJHvikWTMqsj3h7FLgKnExjYv7HAL3RbgUTFxr2xLqwOnyuYiozN680w9aApBVBfz2bpnjo
 yPvqwv5UFPuAA1FjiINWn/sCRiprdwlPR02FQzOi6epR/wSeIvR16LdirIgDxYcm+KDUQiBtGv0
 3GpZ4f+z1CmGN793gt1yzsZffsH+SLssWfg3fD4LJnQHdsx7sY0QODuk4D2luiO/PK+DlRtSTry
 bbV4oLCK7zcmSDk3Tqj8ksG7oiHGlK6YzmXZgy1c4xUx29SVskPX4opinGifPeQC7dF22ySzrUf
 hG0BTZUo08ulzMJb63iiwkrLSsW68eUV9Q3yJkbkjqJ7fwP4YpIfUmoP47hkCAI8bdTvpS3djVd
 OKEDX0BzZPfiyDvwc=
X-Received: by 2002:a05:600c:4fd4:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-47d1958a43fmr253930975e9.19.1766828987102; 
 Sat, 27 Dec 2025 01:49:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlUtzGZB/fDzWHiJRtNB3M/iBhV0vvxyMtNC+pvM4WjUprd3LC0IhCS4uq9OAf6Qc6vBgz4w==
X-Received: by 2002:a05:600c:4fd4:b0:46e:4a13:e6c6 with SMTP id
 5b1f17b1804b1-47d1958a43fmr253930645e9.19.1766828986651; 
 Sat, 27 Dec 2025 01:49:46 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab257asm50748292f8f.38.2025.12.27.01.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>, qemu-stable@nongnu.org
Subject: [PULL 115/153] target/i386: Fix #GP error code for INT instructions
Date: Sat, 27 Dec 2025 10:47:20 +0100
Message-ID: <20251227094759.35658-41-pbonzini@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Andrew Cooper <andrew.cooper3@citrix.com>

While the (intno << shift) expression is correct for indexing the IDT based on
whether Long Mode is active, the error code itself was unchanged with AMD64,
and is still the index with 3 bits of metadata in the bottom.

Found when running a Xen unit test, all under QEMU.  The unit test objected to
being told there was an error with IDT index 256 when INT $0x80 (128) was the
problem instruction:

  ...
  Error: Unexpected fault 0x800d0802, #GP[IDT[256]]
  ...

Fixes: d2fd1af76777 ("x86_64 linux user emulation")
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Link: https://lore.kernel.org/r/20250312000603.3666083-1-andrew.cooper3@citrix.com
Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3160
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/user/seg_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/user/seg_helper.c b/target/i386/tcg/user/seg_helper.c
index 263f59937fe..28bbef1bbae 100644
--- a/target/i386/tcg/user/seg_helper.c
+++ b/target/i386/tcg/user/seg_helper.c
@@ -63,7 +63,7 @@ static void do_interrupt_user(CPUX86State *env, int intno, int is_int,
         cpl = env->hflags & HF_CPL_MASK;
         /* check privilege if software int */
         if (dpl < cpl) {
-            raise_exception_err(env, EXCP0D_GPF, (intno << shift) + 2);
+            raise_exception_err(env, EXCP0D_GPF, intno * 8 + 2);
         }
     }
 
-- 
2.52.0


