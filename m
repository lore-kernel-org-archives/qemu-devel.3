Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A81C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3Jz-0007xX-VR; Sat, 08 Mar 2025 18:11:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Jp-0007nU-UR
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:59 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Jn-0001Yd-RC
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:10:57 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bcbdf79cdso18044955e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475454; x=1742080254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9I5vCsA50Nsuo6JWWElDKwuAuqANWG3nhtm6Mug0ADk=;
 b=amXC1KqNRcKeCIgQ28QZutnqkU/x+I1OsioQdu1lZhqXRpR6PK1P64TmVR9x+lWFoI
 MpxjoOFrqPZblyUDWXxASkwrwoAUkVLh0k7DlvtRpb+gh+f5OkturzrS0Ilh1aiU0dMl
 mWgY5gW+0PbxQa0K1Wr4oK26CLQiSp2gQ8cAYbe8cdKZTZP4igGanSpaTTYj6Y4E9hRZ
 x3HL9nVjiGGaBnh5sTMuqg+VGyJZqpxiHCNGFa/56fYUCLrXAXjcQm2lab5SlxFDfiZq
 HKmLHJ+xzsKLjQ89KO41NTj6CTTFGsbde9wkTNfCSBGAlU5kfH7BwIclZVV83W3pVXSC
 InfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475454; x=1742080254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9I5vCsA50Nsuo6JWWElDKwuAuqANWG3nhtm6Mug0ADk=;
 b=Hk4JJkQZjYKRLwo7jCX0mnhCCCXD771/WV+kY+jnHG/8lI6aKOn+sXZfQlvgeC53GS
 tKJgFSYn/ZyRZW7WW1v4FerKe7zHDz6PjKRol86w7HihG0AG2RhZpRxzWUMfOk4D+WsF
 Ntww+t9atYRz86PRpnZLIrA+pz90b4PkSWqCUN6kK6fYDJ+eUmxbs/NZQckBzwYa4xJf
 txqBvvS4rYRpLz8bKhBedi89A3CtRptHWOJkp/N2NUMsxrjlX8XkK1KW30djcQXiPiLb
 1NgHF6EfjUvwWe5Hc1Cen9wPlzbGsT5tF5CeV5HozR3xZt8BXXzUiUPOkG/N3jycT5w0
 K7qg==
X-Gm-Message-State: AOJu0YwPhH5Ork52P/aHoEZzdos7JXJuS/HACm0d4iEZMbZR1TRCYxoD
 axLEeHKtuMu2ylo+Qxna/G3H8LMhBX8HYgv1cLS8a+wGvxhuXHFPRL7/azWOmh9aEDD9fbDdNgF
 tsdU=
X-Gm-Gg: ASbGncsiyHIXzs4avleVrtPy60cBTYpFJQdEACCCVmPXpa2EdQ2Zy8hRGm8YuaHfGKD
 p5jeBJEvM4yWRX/HJJ9vgsBtcj9Kq80daUT7XukRO7J09yQAn+0fXRk7Ttee7/Ol7XmphyQKkKy
 c/A/oV0VaYM6lL+R89scTz6ZlI0J2JNEd89bZNzE5pW3QmYMDtnmqKLXXoB/KvTCXgT+dB9c49O
 5sLZLdPJt0NPWSxXx0ReC4DJWhtdsrVTSb58qNemAlFXyAiWTvcn/UWjvSgjgI5H2JRAXO+9MCU
 6UjonBczoSVxHCdURaHY12zyfBEaHRZd3Q/eHauYHcQ40mqMtWai4EVHCxXzMvZF/bsKFQkQ8Cf
 ObIsxfrafR+uRMbbtfYs=
X-Google-Smtp-Source: AGHT+IHD4U1Jg2eYVlde+YIZ+P/aR73Oxp+dN6sVG7EKlH8IIyBuRl1arvaQ7vamgw7TSdQkmdXYog==
X-Received: by 2002:a05:600c:4e8e:b0:43b:cc3c:60bc with SMTP id
 5b1f17b1804b1-43c5a60ed21mr56361295e9.15.1741475454020; 
 Sat, 08 Mar 2025 15:10:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01d2cdsm10234876f8f.57.2025.03.08.15.10.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:10:52 -0800 (PST)
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
Subject: [PATCH v2 16/21] hw/vfio/pci: Compile once
Date: Sun,  9 Mar 2025 00:09:12 +0100
Message-ID: <20250308230917.18907-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
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

Since the files don't use any target-specific knowledge anymore,
move them to system_ss[] to build them once.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/meson.build | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 21c9cd6d2eb..ff9bd4f2e35 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -4,10 +4,6 @@ vfio_ss.add(files(
   'container.c',
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
-vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
-  'pci-quirks.c',
-  'pci.c',
-))
 vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
@@ -33,4 +29,6 @@ system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
 ))
 system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
+  'pci.c',
+  'pci-quirks.c',
 ))
-- 
2.47.1


