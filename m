Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CCFC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhb9A-0001Cq-DF; Thu, 31 Jul 2025 17:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhapf-0002Ch-Om
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:29:04 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhapc-0007z1-6H
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:28:58 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b7892609a5so1060359f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753997334; x=1754602134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sBV+uzJ1KXdLFqT+HlvZO+Zs0JU9P9tlvSCNA6c7IfA=;
 b=PlfSriAvvRpSbuh5wpaUfY+9+u3z/JpKwLB5379d/w4fvdEmfF34RaMPsAZ1CufcES
 loY2vSXsxJD446nev10I7bAXSkkBzLefRezyY3gWePZf7jUS7DQ80mYFvmcslCSCCWYf
 N+BUVPJNHBpmSIO75ZhQj1+ssQAjY5I3/Vn9ejLCAtS0SeASIodNX0gni/RaPLZq1O54
 b/M4gmfKHE9hffoCri6wQftZZPAfWUE+EngkGVfsq8ofsLkXFgOZVpU85c6hTojrbyH+
 747uT8l5JnnUNWudNyrp9hgmABBPbfpVedLHYiwV0VQVFSebaDzkgZLm5Y9t2V9I1PTO
 4T0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753997334; x=1754602134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sBV+uzJ1KXdLFqT+HlvZO+Zs0JU9P9tlvSCNA6c7IfA=;
 b=hTrzuRrwogEA9hDboW0BjO3RQGsxsbVZNZEkwdg9qvIkRGwX/YaKnbQbwHnI7DeKa1
 72XC7fnG/IMzQIO6sXvDJQNU1m7UmsZTwZ8UwPLCHP6hsJ4f5ox6WewtRZ2u7Sci268T
 BaWsLdoyBnloFwTnsWP5osW+XQRKWbja4P+W7Ff7gWWEfW/k8ZLnmQqS/qvnKtzt9v9f
 0HegfgDahN6LryXxvPaJY9WuMNF+xxqwCFRc4MMmBxgT21rJh1OgKvqF6rcbZySZIjBr
 /s2DrVQfGjr7xlMaBUiBV0aBY8XWuhoidpp9UJB9T7vCvgr1wYd2ywyqPuHzxLsxrQqw
 DpqA==
X-Gm-Message-State: AOJu0YzJQLch5yyy9+cKF1Wi+1hhqwOQrobigH01eCT0qKObsZpb9rMf
 xUSVPrZi9BHqwlNSpXBjCfTCOHr4Ukgz2cm1uxu7yYOcxH5Bea84ycfGzSbJ4A/nFwOP8ACcNmJ
 /0gl3
X-Gm-Gg: ASbGnctYP4dFbpDz4apkqd6/ShIuQkSuDz3LfhVcFNDmu7l6GnSVf4pyLJjjDccHYyF
 TEV/r02Ixc2bcTbB7HUbbDF+V7mwVOXqnkZHli3/6rok8NqwRUX82e7f0cGGuS3FBc6hgkfqHi0
 U18OMUn4hpya8NYd72KLCq5SlZ04OZvrvShiWVulcWegwLN+YSeJZt7xuxhXU/rrVtjlxqMrjNz
 Bq1tBP/aZvmX3fMVI0TCN+XKdw/460EsPJ1khH++0/1yPMvKWm3YzxbUAegES/JjtLtGIm+o3Sk
 gayeqZn4JcUFx6lnCRdO6HsDB5P7Qt980H3wnc0p1NBqM06fuhAPNj924H5EKIf5GCv+xODRelM
 5EVsrEngvQaNQFJWPFbvs2P7F+QymuHVweWI1NFG2S5yzlHG5g08qFCF10xtm9ONFrEU8jMyX4d
 T4ZXY2b38=
X-Google-Smtp-Source: AGHT+IHO4HikjPZVpifbu6NuUKtGd2+RYTWDmPJ0XDxxx1BabiJc8mK25TDq7amE/f6P8BgxOR5Exw==
X-Received: by 2002:a05:6000:2289:b0:3b7:89a3:80a5 with SMTP id
 ffacd0b85a97d-3b795029a90mr7217951f8f.45.1753997334344; 
 Thu, 31 Jul 2025 14:28:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abec8sm3743136f8f.8.2025.07.31.14.28.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Jul 2025 14:28:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Weiwei Li <liwei1518@gmail.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 08/11] hw/sd/sdcard: Factor spi_cmd_SEND_CxD() out
Date: Thu, 31 Jul 2025 23:28:03 +0200
Message-ID: <20250731212807.2706-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250731212807.2706-1-philmd@linaro.org>
References: <20250731212807.2706-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

spi_cmd_SEND_CSD() and spi_cmd_SEND_CID() are very
similar. Factor the common code as spi_cmd_SEND_CxD().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 04b3a1651c0..ef72ce717b8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1576,14 +1576,19 @@ static sd_rsp_type_t emmc_cmd_SEND_EXT_CSD(SDState *sd, SDRequest req)
                                  sd->ext_csd, sizeof(sd->ext_csd));
 }
 
-/* CMD9 */
-static sd_rsp_type_t spi_cmd_SEND_CSD(SDState *sd, SDRequest req)
+static sd_rsp_type_t spi_cmd_SEND_CxD(SDState *sd, SDRequest req,
+                                      const void *data, size_t size)
 {
     if (sd->state != sd_standby_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
-    return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
-                                 sd->csd, 16);
+    return sd_cmd_to_sendingdata(sd, req, 0, data, size);
+}
+
+/* CMD9 */
+static sd_rsp_type_t spi_cmd_SEND_CSD(SDState *sd, SDRequest req)
+{
+    return spi_cmd_SEND_CxD(sd, req, sd->csd, sizeof(sd->csd));
 }
 
 static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
@@ -1598,11 +1603,7 @@ static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
 /* CMD10 */
 static sd_rsp_type_t spi_cmd_SEND_CID(SDState *sd, SDRequest req)
 {
-    if (sd->state != sd_standby_state) {
-        return sd_invalid_state_for_cmd(sd, req);
-    }
-    return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
-                                 sd->cid, 16);
+    return spi_cmd_SEND_CxD(sd, req, sd->cid, sizeof(sd->cid));
 }
 
 static sd_rsp_type_t sd_cmd_SEND_CID(SDState *sd, SDRequest req)
-- 
2.49.0


