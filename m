Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1735CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 15:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDlYg-0007YR-IT; Tue, 28 Oct 2025 11:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vDlYd-0007X6-Ps
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:24:24 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vDlYS-0001Mx-GO
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:24:23 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-378d61ce75aso56258521fa.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 08:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761665044; x=1762269844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptuQ40T8A5qNQ6R3Uee5nOxcUTyPqUa19KlSXchxpcE=;
 b=f0B6g+8iLGxWo/4JMOSCvx+fz9hcPLZSHCmVxJpRYUmPbiziihEnfx+hJVotm/Pzmc
 yoaivzpIx+TX5AY+GUb3GeFAREUV/uwRXJ1ICRuIuoOf/D0kyr/fmIhrLnfWuexAKdei
 7flzmXmK7i+imOeidkvgVgL/c08HJXg+AS7bpppvhesoDgRPdAx+FuFI3S9rvQ48BtKb
 mWYKI+Cb2Od43p/HwmOohc1KqTEjJP3WSB4R1UgOcRnjAARhfrkOqbhJDqcSd9ig21SB
 wSXj0PO4iYFhdL57xqtZ2xVJAAJ6OoIqTihb3d3F5FsAX6ubOoGjBQCi8lnQhMZjj+H9
 Gmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761665044; x=1762269844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ptuQ40T8A5qNQ6R3Uee5nOxcUTyPqUa19KlSXchxpcE=;
 b=ma3mcaSaQKHC5SzEGjVcJAyPUA4E68nK+aytEkMRX5Va5OuIGRRHZh7xv0EBU+JUjZ
 CLfIk0vInIKbOpSXNaKP4EDhOEyR6Cb2V7pCORIB6ZdA2zw6FBC7FCiWYMIAlzawg/Ca
 lVJZzvz4v38i9AQTWrJPseFGuwPw/d1qFeS5o4yJClWobn9MAxKhyEj3WQAJghFLwJvL
 OSpDy2sxjLBOzALZxkI/bD1+V+rHawILyK6KkYTZGIBo+GHfWTLgsA9h2Mu9YxbO8Ksb
 xLAHXX9EAqVg5H5N83N27l///ALtW48jafr2fHI0q1wyxVpGyS0EsMk7bkpnie84/s+l
 xpEg==
X-Gm-Message-State: AOJu0YyCSgnh8b3LdbOPlApIP3O5xx9q7gasatm3o82mvxoMj8nCDge1
 o0NETtzoN7gtNFzA1GUg9ChljeRgbcQ+gx+S7u1pvQ5LHQtjqccnANIyAC1aIcY92kxZJQ==
X-Gm-Gg: ASbGnct0dfHL7WqUEhoNTO7OKrjkhtoWTz50lYQsndM/T8thVc6DEfOxdnIFckQwQ5z
 kqQz2DAqVe3PKDJyjdl92izTGmYFnzRKwe6m8JHeMcdvNM3oHrfxLsH2pazmc0r7wKdyw+Dxm8D
 n/jkuk4LHE9ftO6dwW3wHbkA03I98SCS/gfB0cHO1TmzcRsuX3onu0esE6C2C40dLCaHEioRZ0a
 SVNymZZrVkxhC8sCdZIKqlSL4+ZCvOSLmmJHs29rJQoayq+OWeosj+U24Hsv/1k/x48bA67MxEO
 lYNyGrE6tSaEqPC0UAbJKx4HoNBw4uWwrT/7CjJCr5JuM/+9vblVc8EKLGmiHAGdjsYCPmEcOZ8
 2Tm41CCzPLbHFPX5FceLarMZm++9eSr8UHlywWalauHzlMDbHWAS9/5nWpyZPdhZrbLBQiPt4qb
 Cenknj6CNcxCegLIE9HM98AUCfjTgcsBol9t8/
X-Google-Smtp-Source: AGHT+IEKS8n26APkvHWTqIFdTjkhqSVWXc7IMJv5y2NEDFMZsgSJEEv0e4HOJAQzTE2HZetz7foyMA==
X-Received: by 2002:a05:651c:30e2:b0:376:3a83:4296 with SMTP id
 38308e7fff4ca-37907cacd94mr8081551fa.14.1761665043802; 
 Tue, 28 Oct 2025 08:24:03 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-378ee0a56d7sm26973091fa.23.2025.10.28.08.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 08:24:02 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: alex.bennee@linaro.org,
	bill.mills@linaro.org,
	edgar.iglesias@amd.com
Subject: [PATCH v1 2/5] virtio: Add virtio_queue_get_rings
Date: Tue, 28 Oct 2025 16:23:47 +0100
Message-ID: <20251028152351.1247812-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
References: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/virtio/virtio.c         | 16 ++++++++++++++++
 include/hw/virtio/virtio.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 8a53fb5f93..fe7c635390 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2379,6 +2379,22 @@ void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
     virtio_init_region_cache(vdev, n);
 }
 
+void virtio_queue_get_rings(VirtIODevice *vdev, int n, hwaddr *desc,
+                            hwaddr *avail, hwaddr *used)
+{
+    assert(vdev->vq[n].vring.num);
+
+    if (desc) {
+        *desc = vdev->vq[n].vring.desc;
+    }
+    if (avail) {
+        *avail = vdev->vq[n].vring.avail;
+    }
+    if (used) {
+        *used = vdev->vq[n].vring.used;
+    }
+}
+
 void virtio_queue_set_num(VirtIODevice *vdev, int n, int num)
 {
     /* Don't allow guest to flip queue between existent and
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index d97529c3f1..8bceb115a3 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -361,6 +361,8 @@ int virtio_queue_get_max_num(VirtIODevice *vdev, int n);
 int virtio_get_num_queues(VirtIODevice *vdev);
 void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
                             hwaddr avail, hwaddr used);
+void virtio_queue_get_rings(VirtIODevice *vdev, int n, hwaddr *desc,
+                            hwaddr *avail, hwaddr *used);
 void virtio_queue_update_rings(VirtIODevice *vdev, int n);
 void virtio_init_region_cache(VirtIODevice *vdev, int n);
 void virtio_queue_set_align(VirtIODevice *vdev, int n, int align);
-- 
2.43.0


