Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C88CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kDh-0004gh-CY; Fri, 17 Oct 2025 09:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kDN-0003oY-Qt
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:51 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kD5-0004ZZ-NC
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:44 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e6a6a5e42so10634875e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706557; x=1761311357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lq7LDwkjqxao8ITMGLgWqIjkDPTusYbwJfW0wNp8hxo=;
 b=Vr3VPOD4epANe3aSrA3oK7hjQ0TMIcjlfm8Ps9OvKLyUJvpqzD3wxc6qGSRZ7Bb3rn
 drrOsEqJhrbBJxSiD/7CqDXCEYj2PgOsJobJ3iZohkbhidXEcpG0jngCmGbkmIB9Jfmh
 pJqIxW7eVZlcgsrJ8EO8W7JS7dJL1D1mqkSgjwGOa1oFXu+FyBD822kkaERydsGvWVt/
 fk6CX3YpdvcTvcuiENcTB40p15dGimFXRCA63mQxmGJsw2TGI85l56C4Ut937dTxMBX0
 enVhmcnLZCxRWIUIUQqwAsnBJQ/prLVjdrAXpwODl0Rri0oEOvtF9x1KnmyjjGgFItkR
 F5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706557; x=1761311357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lq7LDwkjqxao8ITMGLgWqIjkDPTusYbwJfW0wNp8hxo=;
 b=p3oSBEKk0019eXvQOCommeEClAP6ZZ4oA5GkZGJv7zQXBQK8r9KHMIpecCbZVZSOXh
 BUtCgke8OTf1rA1k8sKJSSw4LJBxTo0VseNUdmVWkQ7/P3lbptK54x8A7S1lG0am4VSW
 zYyCjf7Mv9tApvfUqoi+0dQQKGnWvsdq7FosZq4IwX5rog866J2ryWdxKbnDtkzaKJGc
 mVOFitQS72/DbGnOLaOvIe0dumeezyyduh9wEdqjAA/drnYayDk8KswMUrJbDzMi/TCu
 v8HuPe0SI7MdZne+jSSsCyNSL/DF5CMJ6THSRgEk/0PqlZf3GhrClaKD7NYllpK0wopr
 umbg==
X-Gm-Message-State: AOJu0YyqaOGUc2sWdFLJCC1wgt58YZiuIp1Mq4EXUCWeL8FSCqCJm9Y0
 yji9Uz8nlPFfy6akXmjsyKAcbA3gRjdR+yc5Es79QIDcVq+CZPIiCTPH8Cf37q+0dQOq1jeIiBL
 QXfjcYP8=
X-Gm-Gg: ASbGncu8yTI/UcdEpZ4y4s70cJcIPZn7eXhf2e2YGWD/AYrTP1tuQBerqq/tpDDHdQN
 4XM22Pb+LREajzPpuQc/OynFUI80yXlFDDE4ZW1rzmKtbT8A92LTEnxhO+Xc8lbV4fqKzlcj4oe
 0XhxJjuW/p8V9DI9JgdKnqoPd1puWaLwtw1LW8FWnXI1C6TEpM8jcSsqx/aC52nSZSLhSUPdTz3
 03KQVmtzVDr7MQ5T8Z6I+MPxUo9BDWNYNaLpeZsV5rsu01p9HN2MeD7iX8tv2+4T4QpQ5ZDvl9A
 1TL54pLu0+/zhi35AzI3JPuvom0dNcO0scxmDK9a2ItTfPEf9CprYeGdw91BBDbRKpb5Y8mAOYw
 VNRLxjo2zLFchmszEHkxi8EA7CLQD5kt7K8KKlo3tEG2Ni3eVXgR5pBpWWtu/5Ip2prxpyh+1hI
 s4OiSdDLnrgeRJysVclx5qdETJkljwRq0sZYIL2qU+2L7TbLDlSxpaC6c9QrXX
X-Google-Smtp-Source: AGHT+IFk3AEx3NHxOvh51k9ktOiM30L6J7hQQxo8aB6PEFCSCgPN4OKe+EbVwsPBviJiFWwdlbrE9A==
X-Received: by 2002:a05:600c:870b:b0:471:9da:5252 with SMTP id
 5b1f17b1804b1-47117919c1cmr27722865e9.29.1760706556895; 
 Fri, 17 Oct 2025 06:09:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711444c8adsm84728205e9.13.2025.10.17.06.09.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:09:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/20] hw/arm/virt: Remove deprecated virt-6.0 machine
Date: Fri, 17 Oct 2025 15:08:10 +0200
Message-ID: <20251017130821.58388-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
References: <20251017130821.58388-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 33c0034b030..f928a73272d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3641,10 +3641,3 @@ static void virt_machine_6_1_options(MachineClass *mc)
     vmc->no_tcg_its = true;
 }
 DEFINE_VIRT_MACHINE(6, 1)
-
-static void virt_machine_6_0_options(MachineClass *mc)
-{
-    virt_machine_6_1_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_6_0, hw_compat_6_0_len);
-}
-DEFINE_VIRT_MACHINE(6, 0)
-- 
2.51.0


