Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E09E6BF3C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 02:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vm0Ic-0007Rw-Fw; Fri, 30 Jan 2026 21:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vm0IZ-0007QZ-Sn
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:01:21 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vm0IV-0000Un-Ra
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:01:18 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a1022dda33so17491965ad.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 18:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769824872; x=1770429672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vj+J65/hVHAdLn3TpalL7Huy1Q4mzDUSA7K1x00Tkbg=;
 b=JlVyB11gKQpdcsfXQEUZcCW/UYHnb4wrthit9+I8h17GD2GhbbI4bj9mECXYcpm9pP
 WTQWkuTWZwdte6LvtJKDUNCe1vvFEzS7hZR2WmPuY6Y/EGDoHDPy+xWqo7nU9SQcaSfL
 DuG3KFz3GIW+0rK0y1Uwks1FJqhVwdNyWHjcvDOmQ6u4hoNy4wleeRz+E/3FILdyaczO
 M6HWIXVV+Z51psTcpPf8zrptH5mqxubpKTRfHdsm4DAyZ1kLRoF0JZpyBLbq8b6St/Jk
 IXSfQVFHaqJdTbzJryEbP9ia1qZVkn+xueqGpGpFC72MD8us9//MKncAoZZePqdT6RxV
 W84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769824872; x=1770429672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vj+J65/hVHAdLn3TpalL7Huy1Q4mzDUSA7K1x00Tkbg=;
 b=Vb036ivN6rwFXzYBsiv1kIN+X4cfSHqKSZ7rhOHsiANHOhOzW1FVeyP27NVD1b0lt3
 ZPnR14ihyKbTzQxdrRRHbmhm0Usf39Gvg1TnvA+u7ZQ4CmmMpKNdd4uoLM79rO90jSHH
 CkGviB5i2JADG1vT0F0s+Ad0dQ19OccruuKCm850wAE2eaB9gMIJM7DKeGbzIztACmMg
 qy5ClAssSeznIAiDrMvyK658f1/sTvWMUPcC5T2gVsrmun4dhz0NNWNJBODH6r5lX8m1
 bH205H53JBt2u9h/O6JygroE9JoqgArXpmXqzjRr8xzwuJ4cIU5HdGJw7r7g8jUGr2iW
 ia4g==
X-Gm-Message-State: AOJu0YwP7Zr6K2z/9BkL261VDtuIxZ2mkJLPwQs/X/8ZQOkmoWLvzFFF
 JYe5d7FwRMVO1lu3G73baMeHMpkjFgngDSmwqMIHGyalT3VNYemBDlRzWHK+SSbwr8Drw5Xu7pD
 7gncx
X-Gm-Gg: AZuq6aLTbgQtI0NGvSQqO0wzvPlSi6f3+VhjGu4QIgINyXgzZIPsZzxAhSKAhfXqQAV
 r0NwuZlWdO08/NHRtUBin6mfWtcaOs954uwuEpL1sc+qd2cWctMT2Hj4F1cCTMvqtr8ijYwDb90
 zhm4sn24BGs5oSEx85WUOKcdMYbl7YDCzAL6L/IB/5L25pooyESYE07iIPZvlWixbxgIo6BfAZN
 SJ8pc0TIL+enlrl2Qio8t45zKz184J/x9+n84dG6rTboThci7g0dNGSMmFMJssduGx1FosiRaOq
 kNnMgeqsvTykeQm4jo1p0+c/Tc0BhPJKQwJKhe8xm8vkspVrdX/TwdaJS5Yy9+tk+q7iHj0YVas
 iElvxQ8HY+KIINjJrBhJAsEIOHrNi9B83ndOn5+4QmK3MYIHt5BAM+bg1lZYPMmzdud9bAY91PO
 rrZfrxJOPSRv05V+E/S0iCOydaHDoghwFEMS3WgQ74i+3xb1cPeQ2fNxWokUhWLu0joUS2CrFkk
 /g=
X-Received: by 2002:a17:902:fc8d:b0:2a0:f47c:cfc with SMTP id
 d9443c01a7336-2a8d990b3e5mr43871715ad.34.1769824871803; 
 Fri, 30 Jan 2026 18:01:11 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b41390bsm84697975ad.23.2026.01.30.18.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 18:01:11 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 6/6] hw/virtio/: make all compilation units common
Date: Fri, 30 Jan 2026 18:01:00 -0800
Message-ID: <20260131020100.1115203-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/virtio/meson.build | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index d913b94e1ca..4f308beb961 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -9,8 +9,7 @@ system_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK_COMMON', if_true: files('vhost-vs
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
 system_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
 
-specific_virtio_ss = ss.source_set()
-specific_virtio_ss.add(files('virtio.c'))
+system_virtio_ss.add(files('virtio.c'))
 system_virtio_ss.add(files('virtio-qmp.c'))
 
 if have_vhost
@@ -52,10 +51,10 @@ endif
 system_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
 
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
+system_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
+system_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: files('virtio-nsm.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('cbor-helpers.c'), libcbor])
@@ -97,5 +96,4 @@ system_ss.add(when: ['CONFIG_VIRTIO_MD', 'CONFIG_VIRTIO_PCI'],
 
 system_ss.add(files('virtio-hmp-cmds.c'))
 
-specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: specific_virtio_ss)
 system_ss.add(when: 'CONFIG_ACPI', if_true: files('virtio-acpi.c'))
-- 
2.47.3


