Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226C2C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4Qg-00016t-4e; Fri, 10 Jul 2026 02:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wi4QZ-00013a-Rn
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:09:35 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wi4QX-0001sr-F0
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:09:34 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cace7da66eso5672495ad.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783663772; x=1784268572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9Gykh+5P8EC5j4uZxNdjyOMe+zEXw26y8NMVO5QDhqI=;
 b=XGA7lzMNiYE8g01AQjE3iUjEtTLpC1mZ0V4/zmcm3jhJPmx4UK4Sb7fxDmJkmMw6Vo
 I+SpKDNWb00+AXIWIukwb7fAYm2OyuxgD7nApenavbGI7x4YhaMQKD+0XFbkIql6/8el
 24+p3kXpTvtoKZH8W2tegmPKc2Nuw3FSJ8Wuxd1aoNGxdGGM8CaLjvyFdaBEXK14Kyje
 mG1DSYdRqTEgmkuEQNNvWxf+yJi+ud4VAQDlx07nRmnIr7jNspYW1vDeIPWlwpcBIgtR
 NsACCK76SSCAEMNxOa1kW7S/eWnW9U+WwcNfFqJEyMEK+IbcTG1bXgbMolqtewoHI8eq
 DxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783663772; x=1784268572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9Gykh+5P8EC5j4uZxNdjyOMe+zEXw26y8NMVO5QDhqI=;
 b=GuG++mAI6P+0LXW3jqJUO+tFRIxkrAYRxo7XmBPT1JH1Ata9YRWeGwq8uvQHtowU6z
 WKOSnFlsN57si0wP96CR+CbA7Av76tPp9aDBSZldJk/aLwVFd2kyAC+rkzRpkS/jKAgP
 +kT8Ybu2NzrQKR3IO1Ur79IGvbHZIgg/gUrwofrmY9E5SnIHS9b/LfE0baAnzb7k7FZp
 F827LjzrzkoH8X51A3nVd7+6+nKzj6okl9oP/0ppK3jAUz4011hy40gUYwGhQEgqDld/
 AhQbBEAmlqX+rkE3XgGATD6ZFsxF7F+4lqoKXE85wh5ZOJ0ucyANH8Jw74LOF7A8z4Wm
 nZyw==
X-Gm-Message-State: AOJu0YxiCZtoqZtdkEKo38cqaYFOl2R14bElJevyOsveeDoFob++RjxJ
 gF/Baxh3bNZBEo/5YDkMHuuG/eW7LLTKWP1QVaPXRFAfDBB9OQHdCT8+5SFa0CfWGt3yltgxM7V
 MVDA2IPhvxT/EpTtsr7XZ3WACgMWLmlMOAZ/9kveMcqr+/t/G/Gza9MlxmEpu7Qcpw6obdqc5Zh
 JF19DMgUHWBp6kqGOCL4JQp24KYRbGh8eySpzDma2/B4uLu1Xx
X-Gm-Gg: AfdE7cll9QQbYNCKiIxFodJDyIgkAsIy7+tRH6qrQAGWVg9yhzH2GIuVdkC2VaO68ll
 D3hOIqlQy2FM/g3kL6NPTKf2rZcCzePcLeXnch1Dzo3i1m6q6gvbonUMG1XybsqdzjaP6eVzKHq
 byKK0wJi1lD66TJiSCXvROY8fL2Rgw31Wo/6qNP18VAOb8BGC8x6s5Jvk0CtxFrOQE7ePB5hvGe
 3wtu80ZkTpqZhNp285/p+SAf48L8FYan9I0bgqxnWB+IJSzbjwI0qrVkwQgEMRb+mPpbw5dgJh/
 IH92C66a/PTMeLNdLLl+fSOM+DMC0skhbmFWeZ5kfJfpdk4Hg5qCfl4OEc0cVWELOkLAzEXVwkY
 USPykYYC930ZveoG3k06G0WL4VQQHiHg6OyB29znkarm7bwvlElgtl6fOLXLfQG1oX2OXe+ogzZ
 0f3MMldPbNwg2zuUZIJhUWmqKOVI2CRvqHjGwtx5E=
X-Received: by 2002:a17:902:c408:b0:2ca:d172:7228 with SMTP id
 d9443c01a7336-2ccea38767dmr114367875ad.11.1783663771850; 
 Thu, 09 Jul 2026 23:09:31 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d59e33sm53344255ad.74.2026.07.09.23.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:09:31 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 1/7] target/riscv: Add Zicclsm CPU option
Date: Fri, 10 Jul 2026 14:09:08 +0800
Message-ID: <20260710060914.1227027-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710060914.1227027-1-frank.chang@sifive.com>
References: <20260710060914.1227027-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x62d.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Add Zicclsm CPU option so that user can turn on/off misaligned loads
and stores support.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg_fields.h.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 9eb47af0a76..f8c27a574f8 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -139,6 +139,8 @@ BOOL_FIELD(has_priv_1_11)
 /* Always enabled for TCG if has_priv_1_11 */
 BOOL_FIELD(ext_ziccrse)
 
+BOOL_FIELD(ext_zicclsm)
+
 /* Vendor-specific custom extensions */
 BOOL_FIELD(ext_xtheadba)
 BOOL_FIELD(ext_xtheadbb)
-- 
2.43.0


