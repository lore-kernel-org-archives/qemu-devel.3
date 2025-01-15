Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78006C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCiy-0000Ca-BA; Wed, 15 Jan 2025 18:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCiw-0000CJ-Cx
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:22:58 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCiu-0003o5-ME
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:22:57 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso1499445e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983375; x=1737588175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cKmVNIOgWlXT/e096XKWejYp/y/Q1no7+NWLlivSSq0=;
 b=yeSzF+woKbfp0POCvIeU9aulYFu6uRiJKVqvx5P0ecxaZaLU113SuOM5BRK5ClqDCu
 FvPC31DuHkHbXMmRbOhtY7/5te/6jgf6/51mPWg5C7751adKBSv7ol23gn/BpQdPUx/1
 yXRx5uWBrga1i2qHLAXjaqwvIY5LkM+VviE7z5x3q25JD9hfddz9sKPBY7jJGM5tWmsa
 C8+kvkWrRXvCfOOyrtOyZQ+QwXqst6FaO7pd0T04gUlO4h1PMcMEvHi70qGtNvjCJr0D
 Qn1JjxQw+PKlErYvUyx4g2HgqcOG/w0QlPZ2BuS66yxBpdxCqhu2JjKsWADtsNBL8mld
 0Q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983375; x=1737588175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cKmVNIOgWlXT/e096XKWejYp/y/Q1no7+NWLlivSSq0=;
 b=Y3FDtk5F/JRdP7CoXgPJOgOWK6CwtWavssAyYjjl3dkheqLkJ3tYaZmXcwcAygTxE7
 5yH4F2V3FSS19xPv5As805KW+oXppF283krwaizwOK8YaxUV+pgnmg6jBJTlbRUYMcpK
 83M0JIKkOkIqZYAgz1K3W6iN9TlhG467YJ8cac9qqI7eNU/sOjem2AvsMEzURhs4XEku
 XFJ5wlAgVujB6jiPsOfK5lmMRT1WSo0MjU75j0ekkLNNMUMdqTnGcPOZGblLjaxzQZxy
 XVwYn7H5Xe4KDI5py3FCJw7FCIeiCvSOaBlTWKOC781cXWQQUrEcxWt6ng48ogCGMJWF
 ILjg==
X-Gm-Message-State: AOJu0YxnxRhvQvxCHxOmXKSXec9aIBLf+LbWDYrEBDJrCEgtMlYoDKzF
 AIJ7XOb0h/uABKUZTaZwecKvFUjs3RByHfiwfK0CEzKJ8oekQW+usH7A74xFz8pOXKJfYhi19ed
 uKtk=
X-Gm-Gg: ASbGncvF3GHchyc4cmZahlkF577tFtIEyjIFGyKW6s30RGvpntZFARKEZjPtoRpq8mo
 z1nYU4gaWwAovwFRVYDd/Cl+rBsl5EGHN7H3Wm/8wvSatYCrzutLkE6j5J/nEPC/kEBlmB/7GSe
 1RFKHiEitMOXQbW1ZZDdE4W6zgDr5q184nKLpFv2CC0iEXZ6a6D1CMewS3HOZ6tHQIeI2ro3kkc
 jzvuQ/JdEiPdcVB/xzQOPnzpqDFtZo6YsEt5aPIqhObyp2BS0x8wWNC9iobVhCA/NFxCzfJcXjE
 e4duyDc1ptaoOzPgwHlLXHNON7ZcbCA=
X-Google-Smtp-Source: AGHT+IErE8SySGP0TXR81cK6bY2M7EahM9uwwk1gFCRsBp38iuT9Mnswxmwdk1AVWwi6910RGtch/A==
X-Received: by 2002:a05:600c:4586:b0:431:44fe:fd9f with SMTP id
 5b1f17b1804b1-436e26f041bmr253028015e9.23.1736983374822; 
 Wed, 15 Jan 2025 15:22:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38bf78sm18646504f8f.48.2025.01.15.15.22.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:22:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 01/21] hw/i386/pc: Remove unused pc_compat_2_3 declarations
Date: Thu, 16 Jan 2025 00:22:27 +0100
Message-ID: <20250115232247.30364-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

We removed the implementations in commit 46a2bd52571
("hw/i386/pc: Remove deprecated pc-i440fx-2.3 machine")
but forgot to remove the declarations. Do it now.

Fixes: 46a2bd52571 ("hw/i386/pc: Remove deprecated pc-i440fx-2.3 machine")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index a558705cb9a..103b54301f8 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -302,9 +302,6 @@ extern const size_t pc_compat_2_5_len;
 extern GlobalProperty pc_compat_2_4[];
 extern const size_t pc_compat_2_4_len;
 
-extern GlobalProperty pc_compat_2_3[];
-extern const size_t pc_compat_2_3_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
     { \
-- 
2.47.1


