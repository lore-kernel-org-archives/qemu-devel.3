Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3189DC28B25
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3Jj-0007Nn-9b; Sat, 08 Mar 2025 18:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Jf-00079W-4F
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:47 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Jc-0001WK-0d
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:46 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so2003196f8f.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475442; x=1742080242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e994k6DJ1GVQfS1v420FHs4KoJEVg7ohUIOs13xGxIQ=;
 b=ag9/oAZNpmWFIS6hGYEJWYuOf9g1jKLokS4k3ZrNKGwAb+aKNbcH5Sh6OTpQIXsHAK
 f6axH0rYpWb/m10OBfZlErYG9FqSu8nccpmm4zrgkzE5ebMpNKSkwWGuPk5D3SogIBor
 VJEBSQxx0I9nHJzFuSnQmMU+fszS2QhNV0+EFjIzOh0sd5lXnOZYCtfjqtIrZ2gP4IWl
 BH/dZ2xuHftH0xHSmjY0s3CZfTnCKpkM4z4IAzrhhBCdG3osgF6xksc3uWrlQStWP06M
 Bd8EvtjykslPYkAMi1WyLiaG+YU4He7Q/0JEm5sJWpTeuvm1SbUGFj/mqyYJVowvC/pv
 ieQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475442; x=1742080242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e994k6DJ1GVQfS1v420FHs4KoJEVg7ohUIOs13xGxIQ=;
 b=ixItOShcil6eeKFIdSQsbBnx1Qlv1nc95dNic39h259Dhp/BVip5jvfO4RFG3RGkdp
 nPP7txaYJOdwDKcLdTwXwcWuoTtw3qNV8gZ/E+qRm69nl5B/5SONyZ29S9nsoTHNtYV8
 Vju+yT9ycJp+sIU4XCzaCy4HPTR5NwIbjG2xm1PFNKEG/2OpCj2vQRje1WUVF3lkNVv3
 0VlKzMLzpheF/uM62AV2xFzsi4xUK0rRdtez7iLV3TIvOzbUkfHnoNBCTT4ktYmctxKr
 zaa9Yb/ThGQiIc/x4mE8LTkGPZlqRBAm0AA2zAfGH0xQRuADAmGYeLce0SZBcu6LSott
 QgyA==
X-Gm-Message-State: AOJu0Yzlh2eRmSw6niSqMb8YcHBO3wzbDQ4IJvUuZDfk+SAsg1Mcrbvz
 LJDitpCEXs/VPssHFyUC5ntsvJiIALg5qUCk5uLC521tBVIt3FT3/QHtIwbUSLT9uXnoclRm9cm
 n2PY=
X-Gm-Gg: ASbGncvOq0SiWSvLoxKHGaMBnHHZJFcIqCGKJ9RpElzjhUKx1C1j3oWKDDg7SH1Pq3K
 cbLLGO3HTU6ZZaf5nV1p8gz2sWApIEexKTXy34wy6a3DAdtf8aVZSxg8pLZTmTR6HXOc6Ycs8XP
 pNNVvYD+hQBuY2sZ0d87FLDv75Ih+WR6PlzdOL3INJAUPUgCSV23J49jkd3iKHA7CRZlNHd2w2F
 8Z/wmJu62suSYLZO/wZWu2ejmXO1/DBZe0dk2+i9Jg+ENrjn9rbgqgEA0zsVVEDqAKiZtAtcRo3
 imI1lzP/sPYvu3xaEiNhdrz7Sp3a9z2LqBwGVJuuut8buVBThow/RRfeWsgnvwJ58krK3lE82Pk
 1Ih8xGH2r5lRRgUXjB38=
X-Google-Smtp-Source: AGHT+IGanFAG++lqDWp4faa7iGXFNwWsx6KoPF+8GUYwA8SvvtEs71rNKQ7140I7e3KcmDtaGGxtiw==
X-Received: by 2002:a5d:64c3:0:b0:391:2932:e67b with SMTP id
 ffacd0b85a97d-39132dacfdbmr7249820f8f.35.1741475442093; 
 Sat, 08 Mar 2025 15:10:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cec28e1c4sm12949955e9.1.2025.03.08.15.10.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:10:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 14/21] system/iommufd: Introduce iommufd_builtin() helper
Date: Sun,  9 Mar 2025 00:09:10 +0100
Message-ID: <20250308230917.18907-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

iommufd_builtin() can be used to check at runtime whether
the IOMMUFD feature is built in a qemu-system binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/vfio-iommufd.rst | 2 +-
 include/system/iommufd.h    | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
index 3d1c11f175e..08882094eee 100644
--- a/docs/devel/vfio-iommufd.rst
+++ b/docs/devel/vfio-iommufd.rst
@@ -88,7 +88,7 @@ Step 2: configure QEMU
 ----------------------
 
 Interactions with the ``/dev/iommu`` are abstracted by a new iommufd
-object (compiled in with the ``CONFIG_IOMMUFD`` option).
+object (which availability can be checked at runtime using ``iommufd_builtin()``).
 
 Any QEMU device (e.g. VFIO device) wishing to use ``/dev/iommu`` must
 be linked with an iommufd object. It gets a new optional property
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index cbab75bfbf6..3fedf8cfb63 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -63,4 +63,10 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
                                       Error **errp);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
+
+static inline bool iommufd_builtin(void)
+{
+    return type_is_registered(TYPE_IOMMUFD_BACKEND);
+}
+
 #endif
-- 
2.47.1


