Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785B6C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqc3c-0003tz-W9; Fri, 07 Mar 2025 13:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3a-0003pU-0a
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:22 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc3Y-0002Cw-A3
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:04:21 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so18299055e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741370658; x=1741975458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qbL4jYEWkDOTQMFiCDljIBBdBkk1lhILqkIilS+kSdQ=;
 b=HKVoIiIoAJ1gDmGpff2w+WFjxf+iITnwQ6amPSOGbkNwnCInuvmE8kA+zGQyxTuOOx
 f9XjHxD/eSoFEliyozU9urdyM8BMxlSJTjsI/eh4cXYPQGcj/S6fI2jDcCXU3UrHJgMy
 GIepAVnNmOnawNJXawQNLLCywj49zcyJdYipyQVfR63eUvPZs6GTjp1CzxdFINh4RcGa
 srcQK3+qOaRUEBZLNrFU4syMfJYiRM3eqeShGovwM84QaK0oA96ZlRlQPiYVeHeiqEiF
 xQP7BY2skNNlfQoC8xETef61Jm7OwCeUgPiqt0lUVkcoQdbO3fVTWNB3t7L8lgRtHfgy
 TX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741370658; x=1741975458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qbL4jYEWkDOTQMFiCDljIBBdBkk1lhILqkIilS+kSdQ=;
 b=gEOy3aQRdR7hN2wdbFZUEV0USvHhjva5Ycu6vzSs0sp5Uzvn5W7l83aa4joaAvTbKf
 K72H97SBJgPqfx8yacc7wcHl6QohF3wMCKvr6dfr7479Ge9B/7tebgom7Hemv3yW2DQX
 OT2pADo8LANhz+fY7sfBVevvom31oeRNqYF5IW5z98lRoQYi0/DKQkUiS4bnrZhOw67s
 B6pgJ0UMwJx8SUflym/TeicePtF2jW/RF1GlQcZpHqcw0eGS0/t071dXg6iLzfMB9fpV
 pBHtLQ8P1WbggB5yyA3MZWPGjDrojh4ZI9FmP+z0i0cDvqKcCLPx0juuUvoA7rP1c643
 GdFw==
X-Gm-Message-State: AOJu0Yzi00PW87sb08D9u0JyprutBOFLveb5kito8YDLwfJIUMqdlk+F
 WzRama4ZJN/vbtKLSXrAXHL7DSYOpthWLf9G7kUoQrb+lNRizZm7DzDpRHfUoPM6ltPf+ZwoUmk
 TKSs=
X-Gm-Gg: ASbGncubgERqsF3iRe3H0iaX6dAjloXhJUeaVsc9cV7evMUyiEqK5uwpcgDBCIRqC8p
 7Drl70k6Za5898weMtOQjk7Yyzq23KRGr3flaQI4mgG4f/DGpuwmnjnn565F3zzW/R2x24ABlIj
 Ic4cY2uNspXGli7kg8WFlkvnLnw391xJOzL+fZXzNOfGR3XV6xJM4Ne2Z87m8lpXQT/sp+0MTeV
 UPvR3hCZvLmUN+7e5eLEP7H4xMIMH+V6td0q7p0jesmTYw9iHgOOobubtJRRQAExvgj+R8/vzFh
 VT4PlBqZs5GAOf6y7p34melhghTcXYJ7WKr1d0iN5vIMn3KFjHSz/3ulS5UCsdfu9yibA9xW+Ap
 In0CC02t5a762QnPNTSo=
X-Google-Smtp-Source: AGHT+IEc0uflM7XSjD6JKBXbS+veYnGpRErIZqn03oBD1gdH1lamqtUvX68sdYGTF8GJTCscI5i4zw==
X-Received: by 2002:a05:600c:5117:b0:43b:d12a:40e4 with SMTP id
 5b1f17b1804b1-43c601cfd31mr33628725e9.17.1741370658139; 
 Fri, 07 Mar 2025 10:04:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce3d5a0e2sm5945365e9.12.2025.03.07.10.04.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 10:04:17 -0800 (PST)
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
Subject: [PATCH 07/14] hw/vfio: Compile display.c once
Date: Fri,  7 Mar 2025 19:03:30 +0100
Message-ID: <20250307180337.14811-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307180337.14811-1-philmd@linaro.org>
References: <20250307180337.14811-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

display.c doesn't rely on target specific definitions,
move it to system_ss[] to build it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index fea6dbe88cd..96e342aa8cb 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -5,7 +5,6 @@ vfio_ss.add(files(
 ))
 vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
-  'display.c',
   'pci-quirks.c',
   'pci.c',
 ))
@@ -28,3 +27,6 @@ system_ss.add(when: 'CONFIG_VFIO', if_true: files(
 system_ss.add(when: ['CONFIG_VFIO', 'CONFIG_IOMMUFD'], if_true: files(
   'iommufd.c',
 ))
+system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
+  'display.c',
+))
-- 
2.47.1


