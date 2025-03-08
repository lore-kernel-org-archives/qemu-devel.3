Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB5BC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3Ir-0004Y9-NZ; Sat, 08 Mar 2025 18:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Ik-0004TS-LQ
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:09:52 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Ii-00019K-3x
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:09:49 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so1622901f8f.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475385; x=1742080185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FKsUbwnAskeU+PqgxhKuYVFxrph8Le8+j4owi767as=;
 b=ywijZJQKh24DAzgCtrd3i1yiX91OF8diK8ty2h8092NcfKuc3WdBAR11pU3a0mq9B+
 B8SkaGDXt2TtvvsSNd2XQjJcXsei4R17GaBkbZTdTMe3wgn2fkIFCt69q+t/yDT5pG1C
 XC32ycLmSJFHelvi3PEDSDTNpI3shtbA2hHoKxUTP6LsCyo9fATBYEoKtsBUCVupkcA5
 +3dJRkWaiX/L0Pwr57jmCxxDCmnC3YzYXFQdhduP28pQGwdl3kPdt3FAbBYMJ0fGKYpY
 toU8+Mq3W4+QC58Z6zEaz6amj0qHWGhcNIA5Xo3iS+LdpY4Veky0oC/Od9zfCffOJZD0
 oHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475385; x=1742080185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+FKsUbwnAskeU+PqgxhKuYVFxrph8Le8+j4owi767as=;
 b=A8cHc7KmSYQjDOG4ELfPjPmPpk2GXD4lWmOCjm17SaSBirTC4mq18mTfz10fXXQhyh
 6lHti9egofvIBd/ihMCb6tFKwKYT12iuiC4caTlVUMPjTEgmk1EXJ9IC+Eax+2lUGaSs
 S0gWQJYxZ4goGTFfhpSMP2t0FIoUspssC/uFO79298ivbNF5iUxw1drznlEbMsdaUqsC
 I8q2htMJi/AtSutEYsmhIisJ6TD2zlEf5CM2GDlFNahJ9pdb1LpEvH0mrUtlouvb7yvL
 Gq1HK+qABygH8X40aMePcpztFtA6N8nV8NwBq1rj3cTbudGSfJDfQrR+dn+EzlMy+mUn
 0s3g==
X-Gm-Message-State: AOJu0YzgtImZ5Q0CRY060Kg+FWI3QDK4FEwcqyiekm4pFFLsekHZGxmU
 E6MJo3aAMmYrV26vbNqPXMLfzfZMk7N+b3E/UqHPARABZ3kVllUV/58vwysyxy9472t9OEYVMF+
 tNyg=
X-Gm-Gg: ASbGnctwht5YaRDcPmRdvOJp3T8jm7gpKsf1jJsqVPuconfqv+496Dhs9yxBR/3bMPc
 LydMYiniR/rj0zV3LORRGD/njSzBlggyPQK7sqXuSVYpHnLZ/OLXbE/N3O3L90MU7xbl9IR9uP0
 ujyGGQTflP2RYHs1aqCgCN9lIxWfWqXIbYJ8sssI2CV34ULIb44gc93a0qWAyVcaxDZb3UgqPcH
 I0vEapyCma5aFWR7mxtMt6uchUbWX0FxS8ndz1H44IxbD7vUrzMvB8RglG6zg4xK44s8oHkCyIq
 NPdWKr6nxrqDy36YOvRqJvji4mLMzDO63TQsY5ylW4b9hMqBZNA7B8YazHkCgYf/nKmHmt85qRD
 69TPBdM7QW+OwxF7uGRU=
X-Google-Smtp-Source: AGHT+IHZofeaDr/4fSpqwbHx3ixE1QtBXdjQPdOMSMcK4b64SZHfONsqYlwQPdKO1yfi+jQf0ZSJlA==
X-Received: by 2002:a05:6000:144d:b0:391:2e58:f085 with SMTP id
 ffacd0b85a97d-39132dab192mr5125015f8f.54.1741475385293; 
 Sat, 08 Mar 2025 15:09:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfde7sm10273156f8f.32.2025.03.08.15.09.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:09:44 -0800 (PST)
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
Subject: [PATCH v2 04/21] hw/vfio: Compile more objects once
Date: Sun,  9 Mar 2025 00:09:00 +0100
Message-ID: <20250308230917.18907-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

These files depend on the VFIO symbol in their Kconfig
definition. They don't rely on target specific definitions,
move them to system_ss[] to build them once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 8e376cfcbf8..784eae4b559 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -14,13 +14,13 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
 ))
 vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
-vfio_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
-vfio_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
 
 specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
+system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
+system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'helpers.c',
   'container-base.c',
-- 
2.47.1


