Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EE0E8B363
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnNSD-0006cI-O7; Tue, 03 Feb 2026 15:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNSA-0006aV-Q3
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:56:54 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNS8-0003TR-Fy
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:56:54 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a7bced39cfso63782795ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 12:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770152211; x=1770757011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7ciAN7O7/i54gZ3kSipLEjZsOBJSGqwrAABTmho6QI=;
 b=waWCQMFZtB0SHeoGOubXP+kRWw//01R6YTcKyfVDzQdqkPDLfZavjCe8o639IxHwvd
 0B+XeU4HPmnNabQ4EMdRum8i9k6JGDZb2Fl1rRN3aRBWQ8ihHd943++e1sUbKuWIOfSy
 H1Yjf19q+abRDAiU5FS33Sx8I4rVfg2qNAiIvKvnCLb3ctF16ov0u+aZc6eCGCafAznc
 KIdaQHfT9J1YneMjnHqd+dTrLyBjTLyhGcmmf9oHadewkYgtbL4aEIDCn08ruWo5BuTC
 pMNSumWcpUjQFR1KnKH/IPPM6mbzTTYFec7cAXoMHluOX9NhySGejw0wBaOIAbsQuqnT
 1tJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770152211; x=1770757011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w7ciAN7O7/i54gZ3kSipLEjZsOBJSGqwrAABTmho6QI=;
 b=SXN3IJmMT9BfhwNdnwIbmos5ZOfg60R+FbDPZ2q9dkyUSJXfumYdM+KnC3Nt6IkPRU
 W0P9cZjYLeN7Vh3ykQRRyh6C3tsjGRjMkPjz+CHq/l0Pt+wE8kiMcQumMFOklEqNKlHJ
 n6vDAvHFjQn7OK6R1t3mD2K43IOA9g0wYqcWCoZZd0IFr48MP79s/mH0Q4yqpS2B0YZ4
 MTDPjbjTn+k5dEUbxesLEEhIZTPEA/wXB3/aneGlV+Yq5UZTJba8nbsUplo+e4r2RZv/
 VXcogxxU04lvCRDoNofMDdhdTbl26H29HE0IELVOX1H9MW0c0p5lZd/y0jsaz6BoYtOL
 H9tw==
X-Gm-Message-State: AOJu0Yy7LpMzqPnlHnAzkm16sDh/rsBGgYXHNB0McxgLUvijyIBY68gu
 VV3srBwiO+wygFDIZe6kr2TY7N0k9kAIQ7PSFz6aztiZ5LaudgHyWQpjdFXFMfjRib4n7JgBzNk
 lxceqfEI=
X-Gm-Gg: AZuq6aIiGT0O4Gj2QZmUtvaPfzZ3rt2ze7zL2c8oSY07nPfOHWRxkUrEXEqCUhWHaVB
 4KWJ2p0Wi9BcvDxZonXLp8H6hCFH+g9Os9cR73lSL5kaKSXj4L7YHOVHo2h5CiT7Cy9QjW5x5zF
 TAMT/7NHJw6Xa56F7wOFg+ZXBNZx60VyA6NE5mYgi0+/yQBIbKOlCS7pWPVnG6DRsIr43EKa5SQ
 k/8+mmgUzKINiotV6+DWGvpzzihglbMWaHErfPCbr/Ms/Ok6vEA3la+IuMTtkozvzneH/rdCAPO
 1Mg31EPx7rfHWKA4bM6jMTKwdoSlP5Bw5Kaz1jEBzebFvZLtsPzqR9uPfI3pUZ5LXEdj/QRCGS/
 TmTjoLj1pUAb6VHOO/kIaEeaB1QynA07+FQTJga3CC04K2WcVaNyYq3x6jk/I693MyssiMZK/5q
 AI84VmaiFKgCtU/j1Zy8vzYb3VGHiOk5sdPQjx5dx/SYXp4yBZcTQAQNF+YLL65K/+LD5hQ4IIY
 do=
X-Received: by 2002:a17:902:ffcf:b0:2a1:5785:4417 with SMTP id
 d9443c01a7336-2a933e95351mr6077805ad.34.1770152211054; 
 Tue, 03 Feb 2026 12:56:51 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9338512f4sm3612875ad.9.2026.02.03.12.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 12:56:50 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v4 1/9] hw/virtio: Constify virtio_is_big_endian() argument
Date: Tue,  3 Feb 2026 12:56:29 -0800
Message-ID: <20260203205637.3109749-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

VirtIODevice argument is accessed read-only, make it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/virtio/virtio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 27cd98d2fe1..65872f2c54c 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -468,7 +468,7 @@ static inline bool virtio_host_has_feature(VirtIODevice *vdev,
     return virtio_has_feature(vdev->host_features, fbit);
 }
 
-static inline bool virtio_is_big_endian(VirtIODevice *vdev)
+static inline bool virtio_is_big_endian(const VirtIODevice *vdev)
 {
     if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
-- 
2.47.3


