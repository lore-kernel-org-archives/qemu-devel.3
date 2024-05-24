Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F80DC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 10:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sASX7-0006ik-0k; Fri, 24 May 2024 06:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sASWz-0006Yh-Ad; Fri, 24 May 2024 06:52:13 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sASWx-0007gf-MQ; Fri, 24 May 2024 06:52:13 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2e564cad1f1so98623311fa.0; 
 Fri, 24 May 2024 03:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716547929; x=1717152729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFOOOjt9lX3R5TOZr7m7NgtcNi/9J4Kc7/wWsAI8IDg=;
 b=GAaLE7eboMDtAkdj14C/A0sgKyE8AW39fZH8iiZ9V9Xi5/Lz27tATDcZeRAZOuaFSG
 ddcGhR2qZ4DPC99xKDDQu63Jo1HHxq1jFlsuog7vWb8oX8wODC8DxRUKY/x2OlTWvzMP
 n4Cd0SSmU7yONu27K36MsezCZKWr1UQEGFm9gj6kctQIBVchC4hpFcCII0F72D32y+Uk
 BOKSEOaDmD8rfE2ZJNUcIwjC3jQoZtdeFMnJa7R/Tb3+YeWq9nu5uyVQAAmWniI6rPpG
 YVQ0AEDkHAHh3y9vrQAvOFNCm45Ds23wmGjqqZPi+VG1k4t8uFWMSYgMVeXF8sA0dBZ8
 CjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716547929; x=1717152729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iFOOOjt9lX3R5TOZr7m7NgtcNi/9J4Kc7/wWsAI8IDg=;
 b=lD/zmOXlMGLfk0xPePnyyIN/TFuXkWIROBJLhOhjsxQIbmXu5cuVXlXKgluI6z6x6M
 C112jTihdcQgONYRLCHJrRLHTtZnAJ0CgUqpL8TJSO+NDbbQHiQBChUgWiZSoxfrdccb
 1mQpxoWXizEbADfcVbucaXF/c2M7iwvwRFj2dMp7HHJpEjxd41R//c/O25bJIww7Q4c0
 yqgLCHAf7Ms0uCZP+i2OqjWuanXkLSEsa69HF4cdDE+0SPRFw2/JjQzggN6i4mKBwB08
 ce3pMjVxm44hVUfB4J4mwDtIYvM6HzejA36+duqyV/aY/XZ83+vnqT7EmZO+m6LkVshn
 TK3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2hIOiaFEs0iP+yTvByAqz6Fg9X21EW1qrloScoV9EBceCsfsfG3mg9gBdf1qDqTxSLrCsoR4gMhIhf10T3GqG/y4n
X-Gm-Message-State: AOJu0YwZkY3OP9WD+p3NPtGPFeSQaAo+U2aidawyBXxLJJ0PoLwftl/u
 plntYLh7C40LMaWyDLTpW01Dna8wej1CxN9vuS2zdldwiF7zTRKHfmDuMXto
X-Google-Smtp-Source: AGHT+IHSI9CNPRRu7Ye/VFS79S68fxE0qFl4Z1InLUDdeJoB4YjKFWugYIlOcsTrWaIDEdaNthfHvg==
X-Received: by 2002:a2e:92c3:0:b0:2e6:ed20:9059 with SMTP id
 38308e7fff4ca-2e95b27b213mr11228821fa.48.1716547929075; 
 Fri, 24 May 2024 03:52:09 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2e95bf26002sm1473431fa.136.2024.05.24.03.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 03:52:08 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v7 8/8] hw/arm: xen: Enable use of grant mappings
Date: Fri, 24 May 2024 12:51:52 +0200
Message-Id: <20240524105152.1301842-9-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524105152.1301842-1-edgar.iglesias@gmail.com>
References: <20240524105152.1301842-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x235.google.com
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
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/arm/xen_arm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 15fa7dfa84..6fad829ede 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -125,6 +125,11 @@ static void xen_init_ram(MachineState *machine)
                                  GUEST_RAM1_BASE, ram_size[1]);
         memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
     }
+
+    /* Setup support for grants.  */
+    memory_region_init_ram(&xen_grants, NULL, "xen.grants", block_len,
+                           &error_fatal);
+    memory_region_add_subregion(sysmem, XEN_GRANT_ADDR_OFF, &xen_grants);
 }
 
 void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
-- 
2.40.1


