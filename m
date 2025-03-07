Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFD7C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqc3S-0003iD-8T; Fri, 07 Mar 2025 13:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3K-0003cW-FY
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:06 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3I-0001v3-3A
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:06 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso12784405e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741370642; x=1741975442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjnP6suRKIDIvCyvQUHjHOPyIvdZR5e5AjhnJZaY/H8=;
 b=ADQqm29yKQCszVkFXGO4CXbkM13hzo02mvojcPZ3OVPbTyTJVG9TZJrm+MaBXz6tqU
 7dAXnijShDffsBscQRCRpX3X1VR9o2GnT3JU0J9KlU7ceBYb+rGMIT9Xm41Jrbx/CYQ+
 pRNbP3uksmNHjMB72SXbF9W31mLdwO97dW7A7qYYsSD686NSlztD/P6iNGSEn96u3qqK
 OyGQG3Q2D2gOnDGaov1scoM6GyO6Ybbvvjx9hIbzPspyRzRSfQ8yIGRdyZVbmFPFc/8f
 Lc3Rf2jsVO49Rodq8WRkAxnwLEaBbTU49DKZfbtR3WXlFNR2JO9LmQvTsIIB880tlsTg
 HN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741370642; x=1741975442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XjnP6suRKIDIvCyvQUHjHOPyIvdZR5e5AjhnJZaY/H8=;
 b=dQYAp17Spmy/7275zbBjnnDqGvZvdHSrrE7lsSjYo0KgLjFuHDI0CGyUJCMPcCxaT3
 AkgitiIAR8Hozcv+6pS8dWRPwM1uN6wnCC/LS8L7Pyr1/ffASOrn4KaJsIqScBujNjzy
 FDskTMBYlUi++AHMyhpvhg6dR+mw1yz2aeXn9i0STDXVnM9gAyoeikGQbthxeR0SngUa
 D1FL9XoLPanJMvuvgoaSMmjRHS+bOeZsbtuSKUFpYGA1OusYI0WeSaI/Aeir8bRl6vXX
 rJwYmSYhv7FBFeBTCsADwQW9yf3LQG/FA4XqjPHIK2rxZV0gS7YjGWusXrk7RtoZj+kn
 MrcA==
X-Gm-Message-State: AOJu0YxNSBj9PU1o8xB+9+xdWYulcIzmstRnL2VxqkSvy8s1Mx69jYPb
 bIaEJgG2YDKwwcNXa9d3g3xd/tSzfBn4XFAqVtzDzFFgx3ZfW2s0EjZi7dBJXZkrZwp1g0j/0Eg
 pzPE=
X-Gm-Gg: ASbGncue1uLM6NOCAASsFIm9FOAS+ynvDdYKox7OGBONdMnQKsQ1IVfMJxFFkYr2oWV
 K/8q4P9SXHcGVmYGjWg1Mql1/4UalnoeSrjiqpBOYg8NHiFBaEp2Hxqv4MAOZp4OnSKkNHU21lD
 xCxqlq8KJCBBVkUQb9hRB7gCxHd1eD9tTkX7e3G2kWR5mF/p+IbvxCAbMgdUfUT9/vYHYi9SbK9
 PPTFHHuSFWmfs8EFwRMEi5sEZkyKoGFwsOsyg7k7YSm0Gq8zB/xqRxqy61qU1QEvEP0NXpCyp87
 L1LEOrEkADpqAjf7XkQWusrJyHnIn643Qe9ieZEkr0eb00PqbosaqqX82bvyM2xfUjyHjbesWH1
 dWwmKkaHKx+pedHpbceA=
X-Google-Smtp-Source: AGHT+IH3pBJfwJ8GeERs7TfdjebZ04J4hRz/gHgLpXVYv4THdONSI3tncV7atbL9lWwA6lGOlofjPw==
X-Received: by 2002:a05:600c:4683:b0:439:9f42:8652 with SMTP id
 5b1f17b1804b1-43c601e1201mr33989135e9.17.1741370642093; 
 Fri, 07 Mar 2025 10:04:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfba679sm6002314f8f.8.2025.03.07.10.04.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 10:04:01 -0800 (PST)
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
Subject: [PATCH 04/14] hw/vfio: Compile more objects once
Date: Fri,  7 Mar 2025 19:03:27 +0100
Message-ID: <20250307180337.14811-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307180337.14811-1-philmd@linaro.org>
References: <20250307180337.14811-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
---
 hw/vfio/meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 8e376cfcbf8..2972c6ff8de 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -14,13 +14,13 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
 ))
 vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
-vfio_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
-vfio_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
-vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
 
 specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
 
+system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
+system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
+system_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'helpers.c',
   'container-base.c',
-- 
2.47.1


