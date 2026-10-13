Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA0FCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY8o-0000I4-FK; Tue, 13 Oct 2026 04:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4f-0001o4-03
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:30 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4d-0008K5-1k
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:28 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a02667ccebso18666315e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880886; x=1792485686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FPolPi2JhiZ7Lq5RQip9zpX4wzM5RDqIgiaQzEcR81k=;
 b=ih8Szau5j9BzcU8de1V2Bj5v9QGrsgK3dUXtdAC5vg6aJqt9dN6et4hHZ9dXHoqpmp
 HI7HHFELYz7RexxIoEby3ROnhmW/eO66ylh8LPCuWu4bCTejYgmmXOlrCJKe+XnyN+jI
 7AfYYi0v8Qi1vf3TwBNmoIoKJJzD1pvukCzRivUGLScehEwaCRq69R2cjIvsglg6qGu/
 9RFYm15w4yIDG7FtVpT3NlRROKVmkRFyDdQZ4K5fnTGzpMx8TcsYvZZPKO67ZpVJ1Z0i
 h9UlPo6jvy3fgvMurlSq+p5hPIQ8Sxtprs6YqxXyFJoOO8Z/oQ6quSXTxQrK7rkbw4D0
 w9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880886; x=1792485686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FPolPi2JhiZ7Lq5RQip9zpX4wzM5RDqIgiaQzEcR81k=;
 b=QF1i+b7bp4W+QkGe10nouWgRNyppzfb2Mi7uZkwq/EILZ5g/sZ3TpAQew4S5qMLu+s
 8LKg4fvv2IMnAfUt5TGYkUaPMb1QWX0btgciKwoX6FOuvmVicGWenyzEJFuVPEHPn6mp
 grSDC7r5kdCCzFG0iv1VsveNGmmp2DXHfH8XKVNnKhgHaM8M88819rZTinmFfGACOXL3
 HSDRBR5LkB32+wzHzMIYa10GJ/sZibGztjj0wnKWxBEL+7GCvZbEQuBkFZUw7vEXZTc/
 rO8a++avJPG0eyL0mwBDYZ9F1epW0664FHrrIyhdAZK+ogLSwmj3jW/xaAUCquWhhEvx
 g4+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkTffkiF5yKm97YA2un5I8/HFLIEdfbo1/2ECtdZvCVeKkKUr99SJf5qiGlviBJw7FTqWTLJDEM5AL@nongnu.org
X-Gm-Message-State: AFq9FYIZZVHZwJhT157xmQaYKkuhsRXYO7Ep39Ky+ucoLUXg8+ZeF6Jk
 Jot7Y2y9OxXJvK5vXYKsOK0FEvs6f2hSWVts6jNj/yuHcVBC5f3QH0YdhQ4/4CI9m5edWbM+RBr
 uf7fv+tc=
X-Gm-Gg: AYBFou10rjLKZndH5+dUTlJ9NesJelncLUnw8RBuVBT1nLq+9Oax7tJfi5eyGICSBJy
 BhGE4mCPKwiq5iEWBbT8RMR2aYR1Fbppvd/Q9qkRmgjrts86rd1nXkkxgLJRlDrWfjYSPmy5wJP
 bdvfinUTQEgrTUIMScYApTbIlToyuX/UO46h99GgFAzueg8v6MaS5F1pAwUSwe5ooxdxUvHSSsV
 43nbYBbOlQ4hM8B5bkjOwLM+aIaL9h/qQPM/nm82XpxB77EW4ovZV1dc4vBZfpOctFC0KRpI1U5
 NVyEaV/2RtitblKHuFPYzhtdrhdi+GIG5UBowRwB+Yp9ESFflTv9TUNVP3riXL0nWgj8gY4X1cz
 WUWALbc5ulIqzGOyPekF7VDZ7fJ74eg7+PtvKERHDAsSTBwnKH57q7PDCMbcdXeLHtXXypZJQH9
 sxVZz7EmBvSjQT3ILo36Vo76p/5zdhjtnRNtYdylPobB8OCZ2ristYZS6rFjy7Lw6vQ6si2+Vlz
 Y5n1w2FM9qixWziNGy6A2U1Yie0UhxhRJIXKQZW9vNOlgjchXqvofrYx4kiZJS+xNCWvmAIFYee
 UHrnoum5Ws9Alw==
X-Received: by 2002:a05:600c:6990:b0:4a0:1ea1:477a with SMTP id
 5b1f17b1804b1-4a18e4d8bbamr204086655e9.27.1791880885616; 
 Tue, 13 Oct 2026 01:41:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:41:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 86/86] hw/arm/virt: allow virtualization=on with gicv5
Date: Tue, 13 Oct 2026 09:39:33 +0100
Message-ID: <20261013083933.1024405-87-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Now that the GICv5 implementation supports virtualization, we can
remove the check in the virt board that prevented you from
using 'virtualization=on' with 'gic-version=x-5'.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9d192515d85..51554619fd5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3015,9 +3015,8 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if ((vms->virt || vms->secure) &&
-        vms->gic_version == VIRT_GIC_VERSION_5) {
-        error_report("mach-virt: GICv5 currently supports EL1 only");
+    if (vms->secure && vms->gic_version == VIRT_GIC_VERSION_5) {
+        error_report("mach-virt: GICv5 currently supports EL1 and EL2 only");
         exit(1);
     }
 
-- 
2.43.0


