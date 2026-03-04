Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390C1EF8FEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmTz-00089G-1f; Wed, 04 Mar 2026 08:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmTH-0007Dj-QM
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:41:05 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmT9-0005Kq-MM
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:40:58 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-827390e8a3cso4441766b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772631653; x=1773236453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wr5CT5vP/Vp9qJmexNS3gJQeYThCQKgfTAbAdSmKjY4=;
 b=UBsvxm054iWQunmVrkyxteO4zc4UZRmH7k6uoV9uw7PidpAz+hICBQ+FeoyyrN39/f
 9Qme3e1WhLAl3FADTC0b1Fyh7QJJi3Rill0j/MnKS2xgrErhDioIwFcTG01VU4IY+nO9
 aOaXdMolPgM0skuH1kBILMylOzPVWbO/nN9YguzU4hT5kQixhDibNPCc6CrB57+cpo03
 3PoRLoeesSok9IlMPFlWybD1G6U5sE/b9jKRJYe0RKo38lfmUcsGFA8t4Dy6TP0OoXud
 esNH9EMUPEGLtKcUfVaqT3OIwz2DFowBFrYLW+JBpDyQXyyW+pTQOyFHHMh2OWO0z5tj
 XyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772631653; x=1773236453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wr5CT5vP/Vp9qJmexNS3gJQeYThCQKgfTAbAdSmKjY4=;
 b=Nk9CCIb56SHax62zrUxAfZfY5eIgba+Dt2UZhsXL8PjRAVBg5f7ssrtodj+71m4Sh+
 kUIukOMc2hH6WqBHRM2OM8hZvyJIyfxgK4FdRvUslJC5tFjV4X19eGyBcHrXMRd4cjlb
 pPeqIxzehZXaFk6FVdatqxDiWNVumxD1LNITV/kExBNEAbCxKLmawKiIMMP/vnXrhRxd
 EdNZ/8SMBGrJLg36xbAcSfcXZfDvTOGU969EkIqIOQ0dVlM5+mfG2DFCYUXYF0mMiemu
 DYkplyvb1XOwHwgHTJ6x6123ruWBnKPfaZtCjzmSpu01jR57OhZuwv8dLnKoIAtwjOfD
 gg2A==
X-Gm-Message-State: AOJu0Yw+CnKZ022zw5mWFjRA8U3HWuIzGjZL7hXZEd25/oHbHOdS8J2E
 +NuPf8iU0tYOdWCARa+esh1IkCEujbPNvwBA1j9RlKESv7GlgIyP6OR9cVN01xI7mxR3lyE/AWG
 13Y72DfgW9CWI1bcWho//fhPIImD22Yp4aY+gDSUqtAhec6ltiYk+LZ/Z84tFthO8WDqU/wtGd4
 RTqnLBCgLd8fzx4oHOyvS8IFMW4z4dX27ISygKe+otbg==
X-Gm-Gg: ATEYQzxYs0wAvnQRYd/S0/NpjbRZxmNjEWBuTvnhMqSeG+kw5OEmJdpNpRACZGbSRv3
 j9e3y086ZA0w6dZhigkNCFPsgacjugMa7VXcxTFa7WtfIrbbQtQST2Lzu+rIanjMNGYFczyl36l
 W/Bd2m1e4y6BZto872Lv4DuH9V4/rIrNQKKsqDb8i+8SrUrHwn+Iz/mIeq/B9drAFSKzbCugygn
 kDk2HaTxaTbNj983wFFB1ydJLwCbejNd1JeNdGQNOgn0Hg9qo9EhOIFPh4VlkIC2iVWzM17Dqq9
 D5j7gks15k+yp+4gKgkMnBTV37eC3xRP3ThujwPd1DPqza7P6hk15i53aF6PpPD2ylE9qddcT5s
 XNQzWLAbx/HjxVR1MPvQQAF6+qfCodQc7jA46isWUVaPUN8CLekjRclJRcPbBwgBAHLZAvLXtNX
 VYPyc/6ssoMXwfJpvC2ufQ2J/+ys3JCGagElAzqM44P3lKU2Oo+nK31vwnBt7/hQOcAqaK8pFlS
 OnvLTJ3QbG9UzQO6rl73ZbX4GM=
X-Received: by 2002:a05:6a00:988:b0:81f:be27:8d16 with SMTP id
 d2e1a72fcca58-829726a10c7mr1959183b3a.21.1772631653418; 
 Wed, 04 Mar 2026 05:40:53 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297e11bf5dsm251921b3a.28.2026.03.04.05.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:40:53 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 13/14] target/riscv: Expose Zvfofp4min properity
Date: Wed,  4 Mar 2026 21:40:05 +0800
Message-ID: <20260304134006.2908449-14-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304134006.2908449-1-max.chou@sifive.com>
References: <20260304134006.2908449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42f.google.com
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

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3e655ab43d..8966beed38 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1385,6 +1385,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
 
     /* Zvfofp8min extension for OFP8 conversion */
     MULTI_EXT_CFG_BOOL("x-zvfofp8min", ext_zvfofp8min, false),
+    /* Zvfofp4min extension for OFP4 conversion */
+    MULTI_EXT_CFG_BOOL("x-zvfofp4min", ext_zvfofp4min, false),
 
     { },
 };
-- 
2.52.0


