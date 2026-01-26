Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC652D19502
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 17:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkQd2-0001Xr-Cx; Mon, 26 Jan 2026 12:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQcj-0001Lt-UY
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:40 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vkQch-00004r-Sv
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 12:43:37 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so4213773f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 09:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769449414; x=1770054214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xooLCZtH0ZC3/iJjGv3DYg/vTW0gVjlRUxdeK15JZ+0=;
 b=cV58PGDpO4wvlGzywNssRzq6xRQ4jTWTXQfAanxzjRO0AP8YxcdCjrsh/QMELiZ9ZJ
 ZeRwrkcewRV0u0r4KmcfsVVJjxyEiAjsOVaaSt40KCNfLeg1tgF58yIoLtX+1zGdixJe
 hO5hA5matTA7UUXFEW8P1WK/njddnYHGtHyiTWFCSJ4sEZEO6V4P1b+6qaTyjkFFwtp9
 XYYUwGIvyULckfRX6m8qXqTF7SnrZtEHp9g1STQQ/ajaoe9TDfHw1eft3fCX04Q0XeYQ
 pLuJMxiWA5lB/2LpfLow9jd5daHEJWUTmxwpF2p59hgk1acwayY7Yp5WtYOeaZiQKfQY
 7tzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769449414; x=1770054214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xooLCZtH0ZC3/iJjGv3DYg/vTW0gVjlRUxdeK15JZ+0=;
 b=dleH31tID5x1sdYzcXN0eHBA3K0TUCTNpMRK+RVUc0YIL3EA+Yq+tkrKMv9AeOk++4
 dqr8MHpNZQRDWr3wXxoQVCE3tvjUaNlMH/h2LMK2B2Z1kYnaIGFQueI3eYZ8HXq3rIwX
 anr0yHzT5winDpAf4DPIG4pKvNH3ZOn5E4kzHHWRvkCzG0U2JWUNGaBfBBJTRpfPuU8z
 zySTQi+yj0ePTL4BUVZxO67Y5jHnE5gf9BbcSilNvfMxJualFaAy0fSCiGABH14Kvg9l
 sCmYj9pWEeBqVro8bPYCK1hAtkJ+NsRLxRQmEUJhaJDlxCfFWu3AsL91PytXNEIgopah
 9vPw==
X-Gm-Message-State: AOJu0YyvbchLdZKdzsxWXRZ+ibsn4hF6uK2C8SXrjAqE9ftXM/VSgrE4
 ZH1cNKFaLtkkaQ3esMevYwPwD33p9DDULTWUVhMvFxLHa4Tw4QwonKC0SFL2yw6j
X-Gm-Gg: AZuq6aI4kn/Wm/XW6+hjfMLOx40TNawMx6EH4O2bI2HXbLTGCufUq9wd+qcZnJXHKLE
 SLo++cNxrc9B+VGNxnVt73lUkB1ksev86clnHBg6NZqPpa++lnp61CTAkmoNFvcXC/Hlz5KUkFc
 KNn8vFqMM6dyzUCTlhkQS+sC7zQ2bQ54tuqGz1dV+bo1kynENb/qsXCEJgZNwyzrvMywlLIBwrq
 PhAHY+Ke8IOVn3y20WpDwPDAz4GQf5kzP5Y5rBc31ms6scY6zzkOwHmcnr75GVhJ1H0Rz0PM/u2
 d3iwSZdfcPcLautcHdGxPopzGLBz4TfMg4I/Q/T35H1//IAxZ6LCcIjBGNTbvAmVRmIuIG9uZ6T
 VTutowP5BDMYYdEtdQMFyo9oYEbutbwFW4OQw1fEkWhIACjcNj5h857FMQOiItOyMAyEC8S2JkJ
 6KE2+EZ6ZDFTanFCXgtEbtfUqFa4wajcnosYr8p6OOw+fskvakGi/jHdfjIfj1dTNH
X-Received: by 2002:a5d:64e3:0:b0:430:fdb8:8510 with SMTP id
 ffacd0b85a97d-435ca071e29mr8186664f8f.24.1769449414157; 
 Mon, 26 Jan 2026 09:43:34 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-71-105.adsl.net.t-com.hr.
 [93.143.71.105]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71730sm34199603f8f.26.2026.01.26.09.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:43:33 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com
Subject: [PATCH 10/27] hw/core/fdt_generic_util: actually realize device
Date: Mon, 26 Jan 2026 18:42:56 +0100
Message-ID: <20260126174313.1418150-11-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
References: <20260126174313.1418150-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Actually realize objects with TYPE_DEVICE after main
allocations done and properties set for qdev.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index c1d6ed9105..2c3f4d6b09 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -741,6 +741,26 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
         fdt_init_qdev_scalar_prop(OBJECT(dev), p, fdti, node_path, prop);
     }
 
+    if (object_dynamic_cast(dev, TYPE_DEVICE)) {
+        const char *short_name = qemu_devtree_get_node_name(fdti->fdt,
+                                                            node_path);
+
+        /* Regular TYPE_DEVICE houskeeping */
+        DB_PRINT_NP(0, "Short naming node: %s\n", short_name);
+        (DEVICE(dev))->id = g_strdup(short_name);
+
+        if (object_dynamic_cast(dev, TYPE_CPU_CLUSTER)) {
+            /*
+             * CPU clusters must be realized at the end to make sure all child
+             * CPUs are parented.
+             */
+            fdt_init_register_user_cpu_cluster(fdti, OBJECT(dev));
+        } else {
+            object_property_set_bool(OBJECT(dev), "realized", true,
+                                     &error_fatal);
+        }
+    }
+
     g_free(dev_type);
 
     return 0;
-- 
2.43.0


