Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CB2F54ACD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53Pk-0000k4-36; Tue, 24 Mar 2026 11:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pe-0000ff-Sq
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:23 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w53Pc-0005CV-R3
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:11:22 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43b3d9d0695so5025437f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 08:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774365079; x=1774969879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X/T6NKMBBCp43C4zrqXDY7PYiA/ptjcwEOPnc9umZvk=;
 b=neJ27DWVaK4PjWIEQpN1VX7z7m6/vgICxHUgYFW7QjZgWYSkDp8CmaR6DLBunuCxcL
 DzyYfgLwdSSh5kz4+N6q3VAh7japAKvxfebz/lmmcmuegz6OgLKmz+5HC632IZWnOmVq
 OTjr14jzGWTI3g5PL8fJtRsmiCktvGZH5QEW+GiwJiQlqFdfTJkK/oe/BNvcM+0TBRye
 nt4viAgBH4OlJPbTgTH9AoKRqnc9mpwqsWhQmurCeTAciL8q7nYOQVdqyMsXjURhYbcC
 VFmfCFvvfCOJU7maDHAI9zmhKn/kIax5Pyee7sHP7mzgf9NAvnVRLyK0k/dnLC9cn8y3
 hFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774365079; x=1774969879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X/T6NKMBBCp43C4zrqXDY7PYiA/ptjcwEOPnc9umZvk=;
 b=df3u4TTNUjiFKZzl4ymlpp8Q5APotjONLDBE9bF4lOIYc+cY/ObmP0S41SdGS6ns3v
 +ytRUs6mWYDLrW9c9wXXeqWBEZPFmg1EsXLHz9lHbNNTOG0Gm9ozd17JTiTsXNG/eLN5
 QxoRT0q7gkpVCadiIjrvwITDs/1MmsW4naoK9NZ88fmKuYCcTx/BJIap81suUamdFf+b
 FwtWzZh/ium1JjuZMFjEHjipTYosy5NdvMEFTqQankl6ulPFxmsCCMJgWNqYK0Y1nABW
 AJ8aIu6BkrtzbbKpY1jiBhWsGxEs3rvV20uu/HysQegYZ+26FeHkd5QzmXEBc5PsGiD9
 31zA==
X-Gm-Message-State: AOJu0YyirB2D/Opo3SPvwf+CCQT3Pn1wckUdhmmT5LW0xGGmPJY+AcOg
 DwYcUI/16rxXXJN2QHWGgfOw6ID0fSW+eACsiUh5BoOJ23gog0Nfz+QqmBKRxNXitr6mBtuvmGh
 dEawO/yc=
X-Gm-Gg: ATEYQzy1RAHxS8B4ZvOZDMUZc/ZFff2m0FLepro+zFJuRSygHcT+VkZMBQ4H0XUirvW
 2DY/5ab3lQ5DlRZEMPqn2JuyMTEPkxpHqt6XQ7HBZl+LuZjKGtoxYQTyWd7YBVOF/74rAl3Ar4Z
 UNwZth6nTCMB9yxQKxA3kT6i18dNTRTVz7dPU2ItbOaMw461SpMrs962XDSbDHTmb9vOFRUnBLr
 6I6R7sc2dej2RfUjSAQFyZpZapRV9zXVyD311zlEi+foDniT0iGnClVBF7Q6DSIJzcz3VREwXG2
 tcMpRd/5No0eufo4Y6jUpvXgu3eBdejUyz3tu7/3yqfpxd8ROqw5ofGMDkhdPlB1S9CyZv56oue
 Jw3UpsVFgPT4hFHgyyBYSQiOsbk18o0pOqU4m3vKx4l4SMVsONeAb3V6SZLyZkrtmaL7Lh4alJ0
 bRz0d7yjj7S5JtlVgkWR3n7SQzZW+cHAtsS2SGlg8JEwdRszq/bRmHlinGtVVzHcIYKJku5cKKb
 8U7TAhWYyEUj212mwo7UVd4wte3zy0=
X-Received: by 2002:a05:6000:4012:b0:437:7719:ca82 with SMTP id
 ffacd0b85a97d-43b88362a5dmr270000f8f.3.1774365079050; 
 Tue, 24 Mar 2026 08:11:19 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64717e97sm40781916f8f.35.2026.03.24.08.11.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 08:11:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/11] hw/arm/smmuv3-accel: Check ATS compatibility between
 host and guest
Date: Tue, 24 Mar 2026 15:11:04 +0000
Message-ID: <20260324151111.237411-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324151111.237411-1-peter.maydell@linaro.org>
References: <20260324151111.237411-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Nathan Chen <nathanc@nvidia.com>

Compare the host SMMUv3 ATS support bit with the guest SMMUv3 ATS support
bit in IDR0 and fail the compatibility check if ATS support is opted as
enabled on the guest SMMUv3 when it is not supported on host SMMUv3.

Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Message-id: 20260323182454.1416110-2-nathanc@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 17306cd04b..2bb142c47f 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -101,6 +101,12 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
                    smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
         return false;
     }
+    /* Check ATS value opted is compatible with Host SMMUv3 */
+    if (FIELD_EX32(info->idr[0], IDR0, ATS) <
+                FIELD_EX32(s->idr[0], IDR0, ATS)) {
+        error_setg(errp, "Host SMMUv3 doesn't support Address Translation Services");
+        return false;
+    }
 
     /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
     if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
-- 
2.43.0


