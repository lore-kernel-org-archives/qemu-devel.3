Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8FCCD5BBD
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 10:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJUWL-0007je-NU; Thu, 13 Nov 2025 05:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWI-0007fH-TO
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:39 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUWC-0007Hp-Dp
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:25:38 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b725ead5800so74706866b.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 02:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763029531; x=1763634331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPG0MGsfnUcpaMTtgjJ6a7rIIqT0WPSEG9giTwKtIeU=;
 b=PWoEmK6Q7GY3pjKCF0rdWq7TBnkTW1G2CC1URWOfLUrNq1GLU6yD2kMN5iO7pEWFsL
 DRPW14W0iflzvPLq5XV+J4vcWM26KdeSS79cs/5E0DhHCs0IIgcZFlkiZJ6Jt1uGQLaF
 k/wDgOEAqgmnVEak84W62V1E0Dh04djSKGnSoy+etSGxBSU4roUed+bVE2t2GvL6eJDi
 BKfFh0dXL7N2w+ISbD3akMM84pC7iNZ7w55VA/T4x++eq9hxlMAHDfv7urpVHl3n/8k9
 mS7RO6kTWGqKpNcVHTax7hMhuK/ZsS+E5v6hoPMldCPY+z0bP5Yuy/mgH75n2BzYkFOG
 IwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763029531; x=1763634331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nPG0MGsfnUcpaMTtgjJ6a7rIIqT0WPSEG9giTwKtIeU=;
 b=EFhw0bzo8WKvHd/mbSST9eToMLuGv7OLmzlrgceskoM3smCXBpjPvxkovACDhWE1+E
 Rd1Kc3YIrt1VEotDArT2h61g6dsJYXl6Hmuw8HV6olgVbj7dZEaa7OAwyGoLh6mUiQSr
 ufXErZDPQeFIGP+o/0rg6FAcNmzT1KTzIzTPnOOq8OXrFQK6kTBslR62BXPuri4EkdiM
 DuRIhstwB90nDOYiUBaTn3bBkBDP6/rmlhGQD7wYN511H6YdrWOIE27h6NnwNmZupa6c
 u0PufI4+hcPK/egzeTHMLVAJUt7NtLdBnLi+Ng9a9S8KWKwRNV0kI2Unz/5p3Zh1kEpd
 AVcA==
X-Gm-Message-State: AOJu0YzDydto4NGMotgOL+bjkGg5MDtdpjPDPAeOqNPLUnYNfQc3xrSE
 RJ/H4u2IeYTjPfFMpmB3jslQ0UFZrkQbOlb9/Ilejb+rWEThB8iGTr+Tny7Ax3szh8k=
X-Gm-Gg: ASbGncvu49H3tguvdqvxSK/pZGTTGo3irzxAjNdYlCmoJTZg1sNByile1790UTD2h5T
 t9aRX0aFUheMxfnawphj6awPGUhMEIYZLHFIj+M0ITX8n1F0RBSNkI0dr+vG6bNHUe/yL+DlbvK
 2FVzjx2nmz3v161YSZwy9vrlyHwsX5YoePHcXOWUYI3R5bsxC0EUXPvWwx7uO4mYLeFFKLcZNrY
 kvIrrpPkjuZkJkwK9IE/OwuZHUyx8jVkaYzE0DInUGdcN0jM3zjc22yJbx6YpR9n+X7SuFW56lv
 jm5QuHNm4hatxThH3no01/gzc0E97Yla7kU0qzaw3KnvvAeQ2JA81iayG+WNGPsf5PXryWwwP1e
 j2c5yq/WlLi8bzMfVv/oDKP54YzYGUYtKyrBXWloO2BqzvhoY687eCA9qm+NmgXK98EPs9BExBC
 pY
X-Google-Smtp-Source: AGHT+IGSXTItwIrG+cAuhs+hozlHj1Szrr39FUVETfzjEv7QI9K23HrmrewJmJgiQvt7U1uP8UsPgw==
X-Received: by 2002:a17:907:da6:b0:b70:7d61:b8a5 with SMTP id
 a640c23a62f3a-b7331b331f7mr717266066b.62.1763029530800; 
 Thu, 13 Nov 2025 02:25:30 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b734fa811c1sm134440866b.10.2025.11.13.02.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 02:25:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB5D45FCBD;
 Thu, 13 Nov 2025 10:25:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>,
 David Woodhouse <dwmw2@infradead.org>, Ed Maste <emaste@freebsd.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 10/18] tests: move test_kvm_xen to share.linaro.org
Date: Thu, 13 Nov 2025 10:25:16 +0000
Message-ID: <20251113102525.1255370-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113102525.1255370-1-alex.bennee@linaro.org>
References: <20251113102525.1255370-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Linaro are migrating file-hosting from the old NextCloud instance to
another sharing site.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
---
 tests/functional/x86_64/test_kvm_xen.py | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/tests/functional/x86_64/test_kvm_xen.py b/tests/functional/x86_64/test_kvm_xen.py
index a5d445023c9..424d4b20010 100755
--- a/tests/functional/x86_64/test_kvm_xen.py
+++ b/tests/functional/x86_64/test_kvm_xen.py
@@ -23,18 +23,11 @@ class KVMXenGuest(QemuSystemTest):
     kernel_path = None
     kernel_params = None
 
-    # Fetch assets from the kvm-xen-guest subdir of my shared test
-    # images directory on fileserver.linaro.org where you can find
-    # build instructions for how they where assembled.
-    ASSET_KERNEL = Asset(
-        ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?'
-         'path=%2Fkvm-xen-guest&files=bzImage'),
-        'ec0ad7bb8c33c5982baee0a75505fe7dbf29d3ff5d44258204d6307c6fe0132a')
-
-    ASSET_ROOTFS = Asset(
-        ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?'
-         'path=%2Fkvm-xen-guest&files=rootfs.ext4'),
-        'b11045d649006c649c184e93339aaa41a8fe20a1a86620af70323252eb29e40b')
+    ASSET_KERNEL = Asset('https://share.linaro.org/downloadFile?id=UG0V8dzzHrrHb9X',
+                         'ec0ad7bb8c33c5982baee0a75505fe7dbf29d3ff5d44258204d6307c6fe0132a')
+
+    ASSET_ROOTFS = Asset('https://share.linaro.org/downloadFile?id=VwLRKDXKFl6oKti',
+                         'b11045d649006c649c184e93339aaa41a8fe20a1a86620af70323252eb29e40b')
 
     def common_vm_setup(self):
         # We also catch lack of KVM_XEN support if we fail to launch
-- 
2.47.3


