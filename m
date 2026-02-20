Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7BDC55176
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 09:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtN0z-0007rI-Ja; Fri, 20 Feb 2026 04:41:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vtN0P-0007gu-Oy
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 04:41:03 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vtN0N-0006LX-Hv
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 04:41:01 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso15682665e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 01:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771580458; x=1772185258; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SlpIs7HxvpNUl6SGlFxac68GQUrChL5tt4rCQDRBkQw=;
 b=r/Kq//95bu0wOM5QnA4R8NyX3nhpr2/RaMUedvnXU5vL0v0E83l3ypjiyEEcXUcDr2
 0SHtsQCIpLBYZaNa5iqEAxD9gbGV4U1AcWG200xz+JO5Z4cmk9GgDXZRzhoqPu0srgrB
 gdNKmxImHVk0Ks7zfKsk7mS0iyICbTykfSKJIa2afwaT0TimSOLyy9ljG+a7s5cyJHYo
 ggI5jZRu1+FL2oe2pPTETYDAPcd+r4QiwsaIwKlP5OBqjH6NjXXv4cCxB/NV4zPGdj43
 i6ABcB0q8WGIcjzbP9fRSPQv0+U2x1vChrwV/qvLJXAPD9YM0EcT7nnZi/LLkrLznqCO
 d+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771580458; x=1772185258;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SlpIs7HxvpNUl6SGlFxac68GQUrChL5tt4rCQDRBkQw=;
 b=LPwmw0vOjossJbI5dHMUk5iDZOC1+tfavJvIIb22xqM3PukjfypoFCAkZIdrlOWyik
 EwM9/rpm8g5kt+icg+MWZBTuMUo9hNOplpCjOYi669gcD8cghvb30W1TuRfaQNOb4OyR
 UU+4cD6/gQ3tdCWkS4GhufinIqXOZX362QZZMQy67Ab03kZhbxqXHyHPx8avVTIkZlJi
 rNsRBkBguBhTA1vwcTnVl68ljDB6nIbmv5eul+KFwPG7VWhPBR4AuguAjG0ssEdDiDoY
 eca8HXyL4HfzU0l2hkXqQKQwpO19beOFpegCGZnfi/fpXsCUr//KlhRudY+L8aSBe+qW
 rLVw==
X-Gm-Message-State: AOJu0YyUmVYAQ4hZkuFo6jF/ZOQUiQVKjqPK7NTQRG28JKIw/u0R/eXu
 +EqiUJaijA45gzumEyHle0zT/Y0n8ycAlheKYMPKOCNsacQzR3bMgzkPO11n09JGbX8=
X-Gm-Gg: AZuq6aLDN6Ubuss2Jq0IedKmEkrG14az1eeXrlFr0TnsUMjNj6AzFaD268H3ZOLQl7q
 Dn47MCdcQSu6ngapoMC21TSd6sby24zPJkQawyiAvX58RLu7KYACTNZBFots2KqWExLwaaPlupf
 DjFX4WOZDM5Du+vHhKOCrrCtpi9IOXXeAcP6eHGqG54ez8z+SiV53WgE9a7wj2GldbRKbXKGrHr
 zLZzANqSaskLVJr+LiWJWJdjShL5YQz6ohUdtrA66o1KA8L38HnTAtUnxn24Smix5SSQIH/SocT
 N4jaaDKDSQLh+1l8f8rGG0H9qxW6H9RNlP4lQVVDIhQmz44XSyFLw6rZGl9HVGsxKJWcyCC+7Ha
 NS83obkuA6x/oDuQIzWpcdXyrMEzVKqemgOniLcyMFRxPaAfonNPR/aRKZReIw7a5X4zZlqdSWj
 wPQH/w3iSrWsIArSU8LrvbzRXBpxFKvMZJzxlJYV13iW+kzuIpDrnQGu2tOvsZ2KgfoW8SWeI7s
 XCJ86ug2riqLGuXfBlNMKdcIp9BzOJpHvCk0s0=
X-Received: by 2002:a05:600c:6389:b0:477:7af8:c8ad with SMTP id
 5b1f17b1804b1-48379c1f4d3mr396805725e9.31.1771580457961; 
 Fri, 20 Feb 2026 01:40:57 -0800 (PST)
Received: from [127.0.1.1] (ppp-2-86-215-248.home.otenet.gr. [2.86.215.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac87sm58432818f8f.3.2026.02.20.01.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 01:40:57 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 20 Feb 2026 11:40:12 +0200
Subject: [PATCH 1/5] MAINTAINERS: add me as maintainer to virtio-snd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-virtio-snd-series-v1-1-207c4f7200a2@linaro.org>
References: <20260220-virtio-snd-series-v1-0-207c4f7200a2@linaro.org>
In-Reply-To: <20260220-virtio-snd-series-v1-0-207c4f7200a2@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=679;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=IWq8DZoGv+eVxDl5bZ7ougnypMGJjby3X1fmxpbt+B8=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQnBtQ3duUFQ2NWF3RGVOK0FCejVhTDRNMXhxK3p1CnE5RWtGSmxBeE5lbXhLa3or
 NXFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYVpnc0p3QUt
 DUkIzS2Nkd2YzNEowRnVVRUFDVHo3NVRyRjdocmFqMWlrSlhhZitTOWd5TEIvN3RPVis4LytKSQ
 phQU9hV0l4c3ZVVjJxQUpNbUFyR0kzNjVPMzFJdU0vOUFaa0IyMnhMM3VJdFlmWTA5eVFZbVNJO
 DFXVERsczdiCnJHVDlRUWNtY1k3LzhOUDIwWFYzaFZHSGdCbUt0c1ZxR2hRczVieW1uVFlQVUVo
 dHA4cnh6bUE2SXhiRUhiSksKMUR3cUlnYWltd1lGdEF0TFQzY0djZlhGTmdsYjQveW5qcXR6Sjh
 uUUtyRTNxbm1YQWppUjJPelBqOEdOTmFudgpUNTdPTG5QUHB2R3RKU1pJOE5nTnpteVFjQ3pXbn
 NJNlpGS0R5ZFUwNHVHYUE2THNBUm82ODJZVVU3RG1GbXIxCm8wM290WFRvRzlIak9kdzRaWER6R
 GlPV2J4UGJ4KzFXdFJPUFRqWFBlY010cEdlYmpHUTErNWZvT3dYWVBNZFEKTnpvOCtLbUV4d01x
 K2ZEVkNQTTlLQklteG5oZ3QySWdzNnBla2Rjd2c4WVgyYWRXamViKzhPQ3B6eTVNV3ZHTApOb2M
 2ZGVDUkVqTVFFT3ZPN1ErYkRZOHVld29WQUd3MzdITUdtVjNHREowV0tFcEdVSVBLMTE0d3FIYW
 YwT1EvCkxvU2IxYmN3Njdta001ekNzSEZxbWxMWjJIYWF1ZTZIN0J1TzBpVUMvempJTm1CT1RRK
 0tUWU9SMHNFNTdiNkgKQ0pnMy8wbVl5b1EyWDFXOUlsZVdXQldkZmN6UGtwbE93Sk83MDk1aVlS
 SzVPcWl6QzNsS05Nc29OTWRqcDdsZQpuc2tSSjlkblZkK0VaNmVIZkJ2a2JxU1hxZjlQWlk4YWZ
 jUi9ERjhhbHVnWTJ0MVBNN25kRVY2NEplaDZqcEZ5Cmt5QUNKQT09Cj16SE83Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0c481e2125d81298a52caf7f7b51c3e4f026d85..63231747b0692f764b51bf36797cff3e9849e1a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2601,7 +2601,7 @@ F: include/hw/virtio/virtio-mem.h
 
 virtio-snd
 M: Gerd Hoffmann <kraxel@redhat.com>
-R: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Supported
 F: hw/audio/virtio-snd.c
 F: hw/audio/virtio-snd-pci.c

-- 
2.47.3


