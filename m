Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23252D172D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 05:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmmgy-0003th-CQ; Mon, 02 Feb 2026 00:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vmmgs-0003sV-Oy
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:41:38 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vmmgr-0003xy-Bn
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:41:38 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-350fe1f8ea3so1894857a91.2
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 21:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770010896; x=1770615696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fTh1EKb0IBz/fDEzbfv1i9pC1PLYHmeeUaI6qDJBskE=;
 b=avZ4wYhiLTmUVBNJzXALxtJoO70W1v+eTkygxKCYTkhvKuSXOQcKpV0r2LNdkH/CcG
 KyECqz43RyTnQwiOKqxYkSldnh/I63Ngm2unayP67ushiv7XTMSna4kzYs4QGAiTaBLJ
 r4ic5utLsmdHg8Q8Iu0Z/TI0O78tfkubH0ngy6BLtfHPabqlRknFQuijg14MiamSSYUF
 E1QdLMZNngJU2ZT6welQDstIS5Fja66qR1eX5YM9iFSRAuA6Kzp8QWnuWe6tZaSpU9+S
 bGl/RR/5jxxn4f+6QBIEfcklWO/OpwUi7qwR2MjeesFdm+I920RLOHaKd3YpTXa3RIOy
 VsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770010896; x=1770615696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fTh1EKb0IBz/fDEzbfv1i9pC1PLYHmeeUaI6qDJBskE=;
 b=C8/eZsxkO4eHKHNecu3eWU/kPvoquBWm+WQti4vF73wrgJZOKvwNxPIUT8yu6b1mEw
 /JTEHj/M0mXzO5azobiBh+1xZOsTZkyyPrzzRXBsEYhu087Ts29QlaHqh6viQWcKPWHK
 mWQd1W7t1++awJSsj5PcIPV369pCaMQnN1ntv5IrYUX5grfAu72JQE0kVoZk3yg3qG2Q
 H+yWwFWQug3y86zb04orDTCZ+BYUpwAqcUwbnWy8LkOaFLgZOj7ImHeNagib5ZvaNS2j
 Cmx70yotQgI08g4IIMyiaW2mErhjF2DYFxmS7Du72MSUrrPcz6jddI6wf6hhW43F4E8t
 aILA==
X-Gm-Message-State: AOJu0YwBQo11BCxmfWq0hQAVFmFfXZy8BuZsRD1fLfu8BPncBlxeitKl
 mahJt+dVnBiXV9Qq0iaMkHU32smvwqtbVv8D5+ggBj1w+80gDVQXtTQGGy8/dw==
X-Gm-Gg: AZuq6aKxvDrkxxT78OAe8G4wqQCbF1m6lyZjDgIPSeJw6S0ALnbxVa+tjUOp+7mqoPr
 39tKnWfbDN5Gxzm8ChQ/NZ7rWMD7dD5/xCtzPj3XTmGWL25aE6YWuvawfmncuriPNqyiwQdoUp9
 ufbjYRiJtlD4fDReA2ezLiRnSCH9k347A/QdcbMf3O9E2UumfAMM44yzGYWz335IYRMPWmH6JUi
 kb3NOvOYDbk7/YakLyzyHDvrCmXlsR2uJZfAWe+kAlVs/gOMpxOKVBxWb+DLpKEFFsFg0aN+tE8
 g4OKrm7MywZJXAXz9oTHraR4azDGZqp+/rK3JTv75Dpy+McOixWsLdVcqjvAwDA7z0xWkYpFVEy
 j1IVBaqFZ5JRqWcSLVHAb/j2gZBuDG8S17nA/UUxMF1OW493RlLtEMW8uN1bZRXJ/frvrvwboBK
 njQgVeDpLlfzedQw==
X-Received: by 2002:a17:90b:2e41:b0:340:bb51:17eb with SMTP id
 98e67ed59e1d1-3543b34fcbcmr10638503a91.15.1770010895561; 
 Sun, 01 Feb 2026 21:41:35 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f610266esm17804018a91.4.2026.02.01.21.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 21:41:35 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, jeuk20.kim@samsung.com,
 qemu-block@nongnu.org, j-young.choi@samsung.com
Subject: [PULL v2 1/4] hw/ufs: Ensure DBC of PRDT uses only lower 18 bits
Date: Mon,  2 Feb 2026 14:41:11 +0900
Message-ID: <289e6a3edf5041a9f96c3fb792845b94b5b3c666.1770010668.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770010668.git.jeuk20.kim@samsung.com>
References: <cover.1770010668.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The UFS spec defines the PRDT data byte count as an 18-bit field. This
commit masks the value to the lower 18 bits to prevent incorrect
transfer lengths and ensure compliance.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/ufs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index cab42ae7b6..d3f08f2ba9 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -224,7 +224,8 @@ static MemTxResult ufs_dma_read_prdt(UfsRequest *req)
 
     for (uint16_t i = 0; i < prdt_len; ++i) {
         hwaddr data_dma_addr = le64_to_cpu(prd_entries[i].addr);
-        uint32_t data_byte_count = le32_to_cpu(prd_entries[i].size) + 1;
+        uint32_t data_byte_count =
+            (le32_to_cpu(prd_entries[i].size) & 0x3ffff) + 1;
         qemu_sglist_add(req->sg, data_dma_addr, data_byte_count);
         req->data_len += data_byte_count;
     }
-- 
2.43.0


