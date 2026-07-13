Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950D1C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIee-0000Sm-G0; Mon, 13 Jul 2026 11:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeQ-0008Ui-QJ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:33:06 -0400
Received: from mail-wm2-x08.google.com ([2a00:1450:4864:31::8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeO-0001C2-Fx
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:58 -0400
Received: by mail-wm2-x08.google.com with SMTP id
 5b1f17b1804b1-493e63f4ef6so11485715e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956774; x=1784561574; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mWc7rsld2U2uyI88Tyd1TA6QGlFezkeW+Ay+JQzr2Ig=;
 b=xsilXu9Zuv0rkTCAa1zOEDdZispio5OGDEZMOtBv0XDC1WHb335qaSfLtAckGoOebT
 NAAP2fLCgLNvXpSCxcJ91T6i6ymNYwnM12Bm/p3g3s3sXtuJql3s1pPfvU/KMGLJ0APa
 mQb4pu1u15NPYbQnrRYHMxl/tsT3rKDDGfRKuNguyIRLk+SlGZ0h4W1xnXXZDZKdAGfP
 VbnTojstoRPuVlAyKCav+Zi4bvuSvvWCgmldzq5My+H2/PzjiRG1WY5e7+QeOu+udjo0
 eApysIsLkyGuRlE9lMK0uzo70vYa9pk6koasdi/wpuB21jgDEJJmzPJoNtKVH4DKFRCD
 55nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956774; x=1784561574;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mWc7rsld2U2uyI88Tyd1TA6QGlFezkeW+Ay+JQzr2Ig=;
 b=YKYkT56nYuhYzBuI4DA/nfsTKEjDQkt5A9ZNmQCsy/88SFu/ofqHnf1Kvww1xg5fez
 rQuHdyYNsbzsaE3OMC++J2SDo0VWgQsPP5LyuOd5UseWVCdVXagiMpcGWcBl7zMKwTkc
 IR2eJCMMP8mibEVNuNcjVhixQ02S98uPLqY3ZYE+N9yE8jv839Ag0X5uMKBvWFpegUfp
 6UED2vMwckU7hzyoxNc11hu56G5HrBMmDvPE4A04vES5eE3DbJwmL4bHMBeYksZjA79s
 xdCM7Dga2xtKh6ipwZQxgOiJQEszcZv/+PHuq+RJBHynnAqr2BDkmVkO/uq9d+1U26RX
 LDFQ==
X-Gm-Message-State: AOJu0Yy+NAZUviac6pOq0TKTICWhdpDXCd9p60q96m9KO8DxlFf+BZel
 GCbYV14j8TpSblM70L2GFFzwFpmihUhSzRy+xunFuf33VHYcgJbNIlhqiW+3ryn0hE6huAGpUNb
 78FhtEb/6QTkt
X-Gm-Gg: AfdE7cmdcP5R4JQbqohjuYATX1sLB3BwYw4WZgOR/TFDOyuh6pxRcj4PKiyFdsgddL4
 afISQlwK9aBT7vuzAoS9KdGkbqBHNe9ZCGs+9UatNqGm1jta9yPC8M8Pzxowy5RizP6c3CfB18v
 jqXRVjPbl0nwfXuO1CwJ2xH5r7QNVf2s+MiU6itiQ6lMiClqSqdZ+EqUr99c0d5h8cZsfC+Ig8t
 bExw3xZK6Bdll4loWRtGttZ5HX8u1OpkFJGSfeY6X64noop3xdnrZby6Ip934c3L2CKBxjIcpZz
 tV57EI9ACCTFZmiyOLbneicGCu9H0Gwdw9YsiCMUu3MB7Uk3GnGiChEwp3haVyzFeApFvsStVQb
 8ZVf7rhE6X3FtF/r04rQo64iL/QXegrn7YuJMZGaTzx+WxtjX5v8ykvSuCLfx60HFgXihOmRFGa
 45XuYExN59w+8X6c0gei/92CypzGbbNuKNqupWnadOJe58Q26QUVBqvl32Pt2dvw9M4NveXuWT6
 uwhSty2O/H6WVKDX87GykomgfdoZD/d
X-Received: by 2002:a7b:ce97:0:b0:493:c2cc:aecb with SMTP id
 5b1f17b1804b1-493f8839b4bmr76651895e9.38.1783956774444; 
 Mon, 13 Jul 2026 08:32:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/26] hw/usb/dev-wacom: Don't write off end of buffer
Date: Mon, 13 Jul 2026 16:32:28 +0100
Message-ID: <20260713153233.3391818-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::8;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x08.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

In usb_wacom_handle_data() we allocate a buffer with a size
determined by the transfer size requested by the guest.  We then fill
it in by calling either usb_mouse_poll() or usb_wacom_poll(), both of
which functions take a length and return an actual length, which we
pass to usb_packet_copy().  However, usb_mouse_poll() doesn't check
the buffer size as it fills in the buffer, so if the guest passes an
overly short transfer size then it will write off the end of the
allocated buffer.

Check the length is at least big enough for the minimum 3 byte
packet and return nothing if it is not, as usb_wacom_poll() does.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3672
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260706182034.1003176-1-peter.maydell@linaro.org
---
 hw/usb/dev-wacom.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index c69e247f7b7..895edcc17e7 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -285,6 +285,10 @@ static int usb_mouse_poll(USBWacomState *s, uint8_t *buf, int len)
         b |= 0x04;
     }
 
+    if (len < 3) {
+        return 0;
+    }
+
     buf[0] = b;
     buf[1] = dx;
     buf[2] = dy;
-- 
2.43.0


