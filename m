Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5F4C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:07:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqc3g-000447-Jm; Fri, 07 Mar 2025 13:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3Y-0003pC-IG
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:22 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3S-0002C5-Vp
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:16 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso13550675e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741370653; x=1741975453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MrW4KPeEMsJGAah1rF/LLgEoRbvBGZD/GNv5niDZ+2Y=;
 b=slcup8ATBtXMjaMZKZunoCV9PcZRR83l4OITejKb0GtynPUukaY9c0DaWS/Gpk0fRc
 TAUG2EUSHzRzoij/DCSkBqGyjqwdv31FXaLBGjBXm5nROjrKf3dvVaz4/TcSWBAkVbNo
 lGBuBrzFz2k8dqEZTTMGjlJU93njeprZ9MXDP035DteSHUGD2EAfxUMw5P8ypubEhEic
 hRbvbaMoxUUljSa/HPjNQiOOUFdqyoHhdaINmfNQj+0TLduVJX7SpH6YTfQyK0PVIhqE
 tINgySvpxMXbMlT8Gs4cAFDnJzL36tqIpgkl6QJJvGwsBRFX+q5BECNjDak33UEvBlb5
 TJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741370653; x=1741975453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MrW4KPeEMsJGAah1rF/LLgEoRbvBGZD/GNv5niDZ+2Y=;
 b=nAIvov7HYmuau4gUgEzJKiaXOQQYL1iHyDvw5R30b6J5ItiraSUEXw/FdegC2YWCXA
 UNTuFTezAIJVIPoX6elV2Fn7gUHH3fArBeUXouTRRLkHGuqwfxMVHfmzwd9sQ77IKeDy
 7Y9CrseiEkQO5dR0hIbKFlYoKQOnuDcFXk4mJlfJNQqc6pa3zAVPXL62Bq7oL3bf6NNs
 hY3QwDADkpb4+LrryUcFX8dbHthz2ep/L2Su7aKpRC65dyfyPP76WPTECFVHffAXwPZW
 8aeyMfKJiADsCYWPeU4pUQlqbJLSrR3ztUD/qFXGEUsqNcwsH36suzTNlNUBVBUyQp2X
 2U7w==
X-Gm-Message-State: AOJu0YyeYjiZ5EtVR+ON+8n+imHcV+RZwwuQOW/KsTFKxFgvQmE3hnEj
 QEjgAtLo4DxdJdeylJAdzYtFLUsm3PVXBj6/VzW3ZfE8y6IdExFETNH4LpIfx4rOVe0515p4FLh
 TDSY=
X-Gm-Gg: ASbGncvuBsBiJKA/mBX+9I7Ypo+KjwIm4q+eoZv38iRHjQo2NApINwHLq9pbsrHg0J2
 vMK35HsttVwHLdw0sIUAceAY4kUncI642OaThsFuFP0CJf4Xpkfkp/fWzp6fe7xow8XXH6XdLQV
 ErgF3p1gcJuH/vHFvvT1yEMReFOfkTFNtRjQarO/CQkSAF1fKexnkxYWbRB9a843aUMwZRNP/pZ
 rpYAA9RHzFHHaOMpbfOg8tOIW+OxBWKYQO64+665YW3Wg5OTBhwo7c0Pxu9UsVsPUqf5Ei+RUhS
 jhkPkpP4eLBUwjI/s9yY/LBz1+j2zFTxICVqtWNarR+QcPdcgwgkb5oWTcqD2JXNj+gqkrTNlPz
 5QHUW8cxTz2JURXqY1QY=
X-Google-Smtp-Source: AGHT+IGFTJtAtCuhG8E9BzVu/Ipl6XSR97mVKepvf/WN8vp2isiEEQxnLWYj7XYHqmF1ObgwOUeF7w==
X-Received: by 2002:a05:600c:4f87:b0:439:9828:c425 with SMTP id
 5b1f17b1804b1-43c601d9508mr32710975e9.7.1741370652735; 
 Fri, 07 Mar 2025 10:04:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8b046dsm58400885e9.5.2025.03.07.10.04.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 10:04:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 06/14] system: Declare qemu_[min/max]rampagesize() in
 'system/hostmem.h'
Date: Fri,  7 Mar 2025 19:03:29 +0100
Message-ID: <20250307180337.14811-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307180337.14811-1-philmd@linaro.org>
References: <20250307180337.14811-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Both qemu_minrampagesize() and qemu_maxrampagesize() are
related to host memory backends. Move their prototype
declaration to "system/hostmem.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/ram_addr.h    | 3 ---
 include/system/hostmem.h   | 3 +++
 hw/ppc/spapr_caps.c        | 1 +
 hw/s390x/s390-virtio-ccw.c | 1 +
 hw/vfio/spapr.c            | 1 +
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 94bb3ccbe42..ccc8df561af 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -101,9 +101,6 @@ static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
 
 bool ramblock_is_pmem(RAMBlock *rb);
 
-long qemu_minrampagesize(void);
-long qemu_maxrampagesize(void);
-
 /**
  * qemu_ram_alloc_from_file,
  * qemu_ram_alloc_from_fd:  Allocate a ram block from the specified backing
diff --git a/include/system/hostmem.h b/include/system/hostmem.h
index 5c21ca55c01..62642e602ca 100644
--- a/include/system/hostmem.h
+++ b/include/system/hostmem.h
@@ -93,4 +93,7 @@ bool host_memory_backend_is_mapped(HostMemoryBackend *backend);
 size_t host_memory_backend_pagesize(HostMemoryBackend *memdev);
 char *host_memory_backend_get_name(HostMemoryBackend *backend);
 
+long qemu_minrampagesize(void);
+long qemu_maxrampagesize(void);
+
 #endif
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 904bff87ce1..9e53d0c1fd1 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -34,6 +34,7 @@
 #include "kvm_ppc.h"
 #include "migration/vmstate.h"
 #include "system/tcg.h"
+#include "system/hostmem.h"
 
 #include "hw/ppc/spapr.h"
 
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 51ae0c133d8..1261d93b7ce 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -41,6 +41,7 @@
 #include "hw/s390x/tod.h"
 #include "system/system.h"
 #include "system/cpus.h"
+#include "system/hostmem.h"
 #include "target/s390x/kvm/pv.h"
 #include "migration/blocker.h"
 #include "qapi/visitor.h"
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 9b5ad05bb1c..1a5d1611f2c 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -12,6 +12,7 @@
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
 #include "system/kvm.h"
+#include "system/hostmem.h"
 #include "exec/address-spaces.h"
 
 #include "hw/vfio/vfio-common.h"
-- 
2.47.1


