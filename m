Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF89C4829E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 02:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZima-0002HP-8x; Mon, 12 Feb 2024 21:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rZimW-0002Gg-5v; Mon, 12 Feb 2024 21:44:24 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rZimU-0003IU-NQ; Mon, 12 Feb 2024 21:44:23 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d7858a469aso25066475ad.2; 
 Mon, 12 Feb 2024 18:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707792261; x=1708397061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oO1eGS8vQqb3cNVWcWEItaqKYVE/z0nIVNxgdlxi/zc=;
 b=hkL0Obxaf2AWMjqX178LJeOmCBkKKSPoRcrMSWXYCg6WBc+EOmqZsvDvpU22YwFvZX
 KgXZHNVTu+iOGfA7z6pa0hmYmj+ZZ/iaCXsiHpbj6nN1TNSI0J6DvbflcvNnhDGoeH7v
 KSDkLLTf/ph5SmGa+eHN8tC/rPWhlJN4nZoQ6WyEH852K7Vik8QQZ7UUPH7cljnQYsdn
 iFU2aEXmbkMwco9SFF8gSaTiaI4C6Zm1qSSZPS0rFTJVjezkjYBsIq+CVhHwegrYumwk
 X7VPTqclnKCgTqpftKUxnG8tbm5MmQgi6SGNkt6y3W+rIvhiGBNltLkIGmpmmHZXK+jc
 5q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707792261; x=1708397061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oO1eGS8vQqb3cNVWcWEItaqKYVE/z0nIVNxgdlxi/zc=;
 b=r+6VAmYzH+KdgleVViMYt7FaMb7yZtu3C1EE2tfw4RDo1ZVrAXgHnlbURl51lFgmvi
 e8np5JCPDLsaei7neTau5jxrdF5medl7snoHBSTMtnrSOUA9uDl+Lnx/UaLQ9TkGSfU2
 QfWJkFZVsSJO3N/2itO9CJlP0eyeQSLau59m1CPQzacmG8hKyHfeUx9ZRG7TSmmz2JmH
 qSNEYcyVPt3Qp0FbEKjIEPeFELK1735hZdqS9Ckjf9QiOtWE5mrCN/0Pkfzxh6anoDJV
 Cn9R18YX8nu25cDGCKw2IXK82sJPKrWp2g8urz408+/vfT5InqHMSDehepDdb7h9Skzp
 1ZpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdefeJMngaGsVt7jkoAPvOP0d0dZXfkjzns7K9wWHuJyWn6XspRjPxwKn/YBI3E6/8GWKbBYzjdYQXTDGgqLwhH2dJbGbDHvGHq4IZs3rjJOhJ5d2kMH5D/BwOjQ==
X-Gm-Message-State: AOJu0Yyb45RLV3PLx2DRh5mVxfqyuJ2FcYOCmOXgqh+E/UGrK/Zmw0/E
 jfiXGsgTGRvJihVYZTZHl3WyjPUIUFfwR/rdVhux64muo4uAwWdF
X-Google-Smtp-Source: AGHT+IE60bpGjDk7roFnhjuVigsjAxbtK7hwB71OscIM/rjU9BHlub4g5w4DbnHtXRJIOkz5SQbWeQ==
X-Received: by 2002:a17:902:7ed0:b0:1da:23bb:3728 with SMTP id
 p16-20020a1709027ed000b001da23bb3728mr5201922plb.48.1707792261110; 
 Mon, 12 Feb 2024 18:44:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV5ygFKkep1jyjoXuyBwaUgJChDFXUC1qAwtB5icRC6IzR6bkC0u4oe48xRvCsVKduVaPE7K5zrQnITunHY3iIjLgGjyauBnBuOg1Bp5VSIGiAD5mTdXq+HKcBq/NQRupa/5jR2xAKb5yGzXX1hmBiFOVKwJojoPSylna7VbT1b7Xmoxi3OY9Ofwszg20pa05XbieJF7/E5RvT2Qqo4JES8s2Sn5dLoMUKk13qIXED6I+y/2reS/pzyZpY7UvLfEawEJy4jCRteBszEn76tsRnspTnqAPGdnHygVih70aAnXKZEcdHlouM6h0XooIcolT5rk3hvxBS0DciAzFMerlgat6hRxzlpaOI7e/R/vWCYBve+oEGLhOnqxcwmaNjLR4QDNhpLyRZizEEW6WkA2szqbXAACvrQ/qkCoUkhWupsm7Te4KDAvlMA++IFLZYdALzjdpq5
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a170902f2cc00b001da0a698095sm22852plc.282.2024.02.12.18.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 18:44:20 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: hchkuo@avery-design.com.tw, kbusch@kernel.org, lukas@wunner.de,
 Jonathan.Cameron@Huawei.com, its@irrelevant.dk, marcel.apfelbaum@gmail.com,
 wilfred.mallawa@wdc.com, cbrowy@avery-design.com, mst@redhat.com,
 qemu-devel@nongnu.org, jiewen.yao@intel.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 1/3] hw/pci: Add all Data Object Types defined in PCIe r6.0
Date: Tue, 13 Feb 2024 12:44:01 +1000
Message-ID: <20240213024403.1060188-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213024403.1060188-1-alistair.francis@wdc.com>
References: <20240213024403.1060188-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add all of the defined protocols/features from the PCIe-SIG r6.0
"Table 6-32 PCI-SIG defined Data Object Types (Vendor ID = 0001h)"
table.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/pci/pcie_doe.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
index 87dc17dcef..15d94661f9 100644
--- a/include/hw/pci/pcie_doe.h
+++ b/include/hw/pci/pcie_doe.h
@@ -46,6 +46,8 @@ REG32(PCI_DOE_CAP_STATUS, 0)
 
 /* PCI-SIG defined Data Object Types - r6.0 Table 6-32 */
 #define PCI_SIG_DOE_DISCOVERY       0x00
+#define PCI_SIG_DOE_CMA             0x01
+#define PCI_SIG_DOE_SECURED_CMA     0x02
 
 #define PCI_DOE_DW_SIZE_MAX         (1 << 18)
 #define PCI_DOE_PROTOCOL_NUM_MAX    256
-- 
2.43.0


