Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A91C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqc4f-00052v-9h; Fri, 07 Mar 2025 13:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3s-0004FE-83
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:40 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3p-0002GQ-7h
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:39 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394a823036so18351005e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741370675; x=1741975475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jwX1K0+iQl31BRmPX8xi9KD5c4T56nkQjSQYXLzdF0A=;
 b=FsaGK+bYWMrrh1VO/iXLetGyjlNAB0rEFx8h9NyObQsRr6MS2DfTywFCRUkVvOIcGt
 +DIs3wJQTNioNiisTopZ+5iyTWkIoRsUZ+ALNIVb8Ec20ZD5W1vRxz850koLIAoYd4y6
 o1Z58s/32fdXayGgmPpS4np3kTxQiRlAY5AvkulUGiEx+aSaiHAserAAlqo1BAI/UpL7
 4vvZVnG9k2Ik0QVWLvBbnhJ7GTx75sjSiHm0xGdW1jTYeO5/I+lkLBgVjOiH7H/WXEKC
 +lgPvcxwERvxAH4GPZpprbgP7WThhj9+pJ4g4GR8QyTafwzDDz7pfQzEIl9MKqbBVdJn
 AKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741370675; x=1741975475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jwX1K0+iQl31BRmPX8xi9KD5c4T56nkQjSQYXLzdF0A=;
 b=sSR/rFklsuREpW9wiTEsfEgX46fFQunSiGXJUZK5RoD44OT+DVXmQh2Jgk4RIkgtjC
 8OOGElHrG9q+KAV6lc8vsURlkyIviuIlpJEJ7OAfG82a+idsyCovkXBm6HmRwtrGXVqS
 G89VzbYzeRm44yVavP59msIE4Io5G4Wyk/DnmLEBsEITXZuyPec6fuezB+d0nByOCNx5
 U+AOMVQBOY768QqhIAqgI3e5ponWOBX7wYkNojPMRq0I8PV2qvg85CzQIXC8M+6KqExx
 BoKW1Hz/B6Juy2/PDt22gLsJu7nIO4ca1+kUcz4hzvvAH9adpgI+/JQUUpF1jHh/Z+f+
 YlMg==
X-Gm-Message-State: AOJu0YzgQFDehffAtH4O1+wOksbWmkXTxq6iIM38qtxwQcDfpVFyxURY
 lg7SMwqHLtp+icyErwgKVpifhs4+vKSASTc4ZEeJjVCqyTl/uuD7jSx7uepRBPXwNTNUtReCED3
 iAe0=
X-Gm-Gg: ASbGncsEXp3Ypc6kfrm/kYA2vOFm6HMvyM3ys9zL/j9Ld24ZO5Lq0X5Ejoc2zlPBGr4
 Al1NaQm5zvNhcJbK4CFZ4yu9GClv2cC9lLqCo4KRNGAG+9Qgjs+uk2gZ8n3JT811udcwHegipxI
 +Au08cB2vkuJbYWAdOKPXWMOGGlYhQdJSMC+CGKWYBVpBVp5bH8pAo/iAxNiiqxJ/c6QpEwv3xB
 ZfC+H4RNoHLgnqHEyQxkOY+7NDXaSkEn5urncb6LyWu9buJagvngIPejNbhJNmAqTDV8yqTBW7j
 Y/5fuWL1PIHabNBynka6D9mC+o3Gbrzdv22pveKw52ON2u5IRDx7eick+Bs4NDshOFxsGaoFrxZ
 KsZKieqO5dVG4v9iwXBY=
X-Google-Smtp-Source: AGHT+IFd2dAhiRB8kpwGRBj8I24YTq49QXdG4iwSMQDOtTBB781rulRfrC60gif1x5YVtYtrXppgDw==
X-Received: by 2002:a05:600c:350a:b0:439:86fb:7326 with SMTP id
 5b1f17b1804b1-43c602082a0mr29865065e9.22.1741370675155; 
 Fri, 07 Mar 2025 10:04:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8db6c7sm58089865e9.22.2025.03.07.10.04.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 10:04:34 -0800 (PST)
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
Subject: [PATCH 10/14] system/iommufd: Introduce iommufd_builtin() helper
Date: Fri,  7 Mar 2025 19:03:33 +0100
Message-ID: <20250307180337.14811-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307180337.14811-1-philmd@linaro.org>
References: <20250307180337.14811-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
 include/system/iommufd.h    | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

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
index cbab75bfbf6..ce459254025 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -63,4 +63,12 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
                                       Error **errp);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
+
+static inline bool iommufd_builtin(void)
+{
+    bool ambig = false;
+
+    return object_resolve_path_type("", TYPE_IOMMUFD_BACKEND, &ambig) || ambig;
+}
+
 #endif
-- 
2.47.1


