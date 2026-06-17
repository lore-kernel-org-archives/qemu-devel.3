Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73698CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrIi-0006mL-Mo; Wed, 17 Jun 2026 10:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIg-0006lk-Ne
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIf-0007qm-6t
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781706688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dDZ1OdkIiyHF5KZgWfQEW3DvNfJw9/KjqZP8Dvi8i6o=;
 b=EVBgR0S6ZReMKFKuTrA+ubnxViB1y/Qn2b5AF73c3udrOpqEqu1rd9NCxRMSEd1mgl8tZL
 B1Ulo7O5K7wB7cxlbrX/K7qteBaAHLZ5U8ItLGj9P2SrGmRvWoYYn/R0n9RfzPKKX+xOLm
 w2CdAzVpTidiAD18fvmcNU8yiN7n8Pc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-zMVv5aVmOGSQI81ky-bwog-1; Wed, 17 Jun 2026 10:31:27 -0400
X-MC-Unique: zMVv5aVmOGSQI81ky-bwog-1
X-Mimecast-MFC-AGG-ID: zMVv5aVmOGSQI81ky-bwog_1781706686
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c04a3ebafd2so226925566b.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781706686; x=1782311486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDZ1OdkIiyHF5KZgWfQEW3DvNfJw9/KjqZP8Dvi8i6o=;
 b=HgwBKDqbns5djTF8Colwsl5INI6R6315uzLKtZo471CmZN79jtb0ae+DA8ehm06FBv
 JIp+rDxMb71MKtMRHOCHH0yJMkR9ZkWxjsAzytj24g/t+nXVfOz5u/xnUBWis+likBUG
 fDr7Sg4CMykrFKtmOmg1NO/FQYI2LwS2nuk3ODG3ul1MwYBMOI5/tCyVGjUT+n9YHx2x
 s2POTi2vxovd6+eMv9Zh9zJLzDlGalMa2jnBiVu02PhzP8wPOeGPrU2izyeu45TABziT
 NIgktGqLmexclRx88G7l9n96SiOt5mlcOYuI9cAiUALLUmNmmvwxLO9VbD70zidnSwby
 g0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706686; x=1782311486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dDZ1OdkIiyHF5KZgWfQEW3DvNfJw9/KjqZP8Dvi8i6o=;
 b=TQYbghkFL/+JdpcMrlFV5NI6yFEVoXmG/Srr2WMWqnug9XCwMSMcUtOIiSH75nwyua
 taslZ5eQYbsuXwMnUuIycnI7fcxKgD9e7hYR9zpL2dd8VXKcCF7Bh5Z1wzcejBdKMZ3Z
 wtviW6bEkiW0upjAItbx3W90n/IsLSr1DHKmFBuAqhcE2slbEvM6r76gX+OnjwLFlY6a
 +Q+I8iITnyv0L9XbeI8JPvSk61gkzzOJdkbHkzCGohiAPftbjQGNgU8ptP3rSh0T/m2W
 J15lHHgzZ5kWbnNFFUXl5qDyCaCiemZFODp5RlspDBi4gvyh2M4Wy/T6LxyINxcmAiYX
 L9TA==
X-Gm-Message-State: AOJu0Yz+tz2DrxtD5I3dBmsfCBRDYf4rdgqi5JyhHaN4bCLLmY2oujoE
 S9T6vqKbDSj9PYb4Kk2yUHS9yeZuIm72rm9e+c1eGl7iM06nvhidq/l7tdEla+WX4Dlf5quTsPM
 AfDUFyKbzRfXF/YAwYTWYVcN8jZ2UsH+76ExfsATAotaqK8A+9DE3g0RyNO3HjFW2hKAxbktFHs
 D/XnrCnNcRPR088/e/vIavHSwQa7Hr7RBFb8TyvCiG
X-Gm-Gg: Acq92OFq6Tr2NZat+4Y82xI/rBy87GZ9iJq3tWFhY+614vF5ZcdGTE7xFnPa8O2jJKw
 A7UsRiaskRZZnrStof5mBCkkkHYHrM2NosTKmpd+wGZCicmRLeIAtdxQ1dRuPAz5mXpaS489XC5
 QrZfR8MVEBRN2KM6+wTMHTzF/R3RsBoV3kavz7SjhSfd3hTyP+8PsH0PpZivLhH93S6kJUfvYB2
 5qglSJlKElJNT8kUp9kJql9Le5TLREAZelHaAcsp7PBfaZVUybA6qtay1/BZvXbSKDKJicWbQ7Y
 FzuUtm+BxoqRc3Vm5II0ljsmP1KLaUAdpbgK4SN57seibYqtqVQ5YSxwdDvO24vkLShzNO5PeFT
 e37cbpmY+pi22vKfTkNMIvKcjmB4SpFVOszkJPAmXyL/omAu/9hh9AkTo2TtwhFAH/dlj56ePwS
 woN3qjQUh7hpLYXqEj
X-Received: by 2002:a17:906:ef0e:b0:bec:ab0c:243c with SMTP id
 a640c23a62f3a-c05a2d38dd1mr272074866b.21.1781706685800; 
 Wed, 17 Jun 2026 07:31:25 -0700 (PDT)
X-Received: by 2002:a17:906:ef0e:b0:bec:ab0c:243c with SMTP id
 a640c23a62f3a-c05a2d38dd1mr272070466b.21.1781706685117; 
 Wed, 17 Jun 2026 07:31:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-462e7fc53fasm4335146f8f.33.2026.06.17.07.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:31:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 14/16] qga/vss: Use MAX_PATH instead of PATH_MAX
Date: Wed, 17 Jun 2026 16:30:44 +0200
Message-ID: <20260617143046.445322-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617143046.445322-1-pbonzini@redhat.com>
References: <20260617143046.445322-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

MAX_PATH defined in windows.h
This is more correct way for Windows.

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20260330113906.168002-6-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qga/vss-win32/requester.cpp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 626d6ab1ff4..493ecd57172 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -444,7 +444,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
                 hr = vss_ctx.pVssbc->AddToSnapshotSet(short_volume_name,
                                                       g_gProviderId, &pid);
                 if (FAILED(hr)) {
-                    WCHAR volume_path_name[PATH_MAX];
+                    WCHAR volume_path_name[MAX_PATH];
                     if (GetVolumePathNamesForVolumeNameW(
                             short_volume_name, volume_path_name,
                             sizeof(volume_path_name), NULL) &&
-- 
2.54.0


