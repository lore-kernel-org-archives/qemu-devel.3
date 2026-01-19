Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADE0D4A5F4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 07:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhjfi-0001aj-Ix; Mon, 19 Jan 2026 02:27:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vhjfg-0001YK-IW
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 02:27:32 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1vhjff-0005Zn-2R
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 02:27:32 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-81f416c0473so3375503b3a.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 23:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768807649; x=1769412449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yKeLEi0Je2h1ztfLRVsk2xzeEcuQan8/cVyxDzyqXVw=;
 b=OpoU+1anJftj3DQc0uQu/NENUBD6MGtb5oSLwpwXlXOD1fl/AYggi8IksNMbcsrqIw
 ArndgEt2Yax+yZftK+mPXG+wzjDZOxiSMaVdhl/f2fTertz1xgYLVsz2dlyE7jsQlNFg
 0Jk+jZa5pDmgKgcAVp9Xt7ALbkk8xf+vrWjySOr/LeSPhIfr35wkFI9vP8E7jpdynXRW
 p091bDGVSBn7asMpSnWDgECd0N0GXBpHx2pc7AcQKi36fxeGgyUQvLHsf8N3/9N/Litu
 oKgMQUutr/cc6xGElcT1ATzy2aradLa4FTZaKIjltlx4jrYPMLDTga816JPySib8d6vI
 dg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768807649; x=1769412449;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yKeLEi0Je2h1ztfLRVsk2xzeEcuQan8/cVyxDzyqXVw=;
 b=cz/QXym62gxMxdwNOS28QGrSxUigdKt/OpVtLw7syuJYybyBTCvOrrtsUrJ1wqLbgw
 tKB2b3Q5NMR7e8bzKDCDeIaGYZYHP1Tzw6bX47/99zmpeLEu1PWlGzq7pN5jU+BVLxzw
 0v+gtaUaL+njhpjRD7qj8Qgf/33CYyLW+hmaub7efKpGBJEA82rQMMmAmLza9/RZ2EjS
 kHuMS9yGQ9NrX/Qnv5VptBYwSEjIVmYl+Ofjzax+DHkgS3bnaafA6CwJi6jONjcuH4id
 vo1MDdEtvfSvEJpWbLu1qhVFb8oMoUPTEu4AMdci7N1xWG9QaT5xadPjPEQMKc+3Vf9r
 ftqg==
X-Gm-Message-State: AOJu0YyzGxanfrtoIBhWgYjJrulE3wb7GmpGlVj2syjRy9F8wbdD12xC
 CO1bxSetABB12IouGpIOkJ0aIdWd4PMj8czxxTvnzal7hNBUqQeSGJSbwoRy2A==
X-Gm-Gg: AY/fxX6sa1RRF/t9Q1OBT1d0+Uy0EmhypKEOT8U6FfRIw7DOeoS97vv7QH+EFZiqtiC
 62hJGPbl7A9Xy1FRPbGb1GpIirZ7o/KOOPT9XMXiO1WusyjTquV9V1pQaX0WfwtaQBMxIqwUPkB
 BV5s1YdiG0uUIHeOJh9Pro1Hp7KsWTHKBt6GKSlBl1AZpw2FFiPd+1gBA9PMRyUh+OHZnp5nONh
 7KfQQXtZzizRtSMnsNquAesaxwfuWW66fZ/g2iCEL1nC1HYS5kjdS1dv7ImZQOt4vwRSJsmcuJp
 JFteZhL8InWMhvSD+4+HFEcXabE/7GEmcTq/E5Q+DTJF5YTpdfm5mI0VN0+PxbwIgByNhiDPQ1d
 2Ua7L6Mkxr1yYwJ3I6C1DpT/FXRZBkZPMzZH0aNR4rdubxPZ6DEbEJLbLDJNZZn4pvZOEENFHZY
 yWPwG+DYyOaaeuVn/F8gPonjEIaX4=
X-Received: by 2002:a05:6a00:3a0f:b0:81f:45a2:cbe3 with SMTP id
 d2e1a72fcca58-81fa02ff9cdmr10707287b3a.54.1768807648768; 
 Sun, 18 Jan 2026 23:27:28 -0800 (PST)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fddd12fcasm11856b3a.0.2026.01.18.23.27.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 23:27:28 -0800 (PST)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, qemu-block@nongnu.org, j-young.choi@samsung.com,
 Jeuk Kim <jeuk20.kim@gmail.com>
Subject: [PATCH v2] hw/ufs: Ensure DBC of PRDT uses only lower 18 bits
Date: Mon, 19 Jan 2026 16:27:20 +0900
Message-ID: <df800635daeef202fe6b568d9fe6b09d732abb98.1768807286.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x434.google.com
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

From: Jeuk Kim <jeuk20.kim@gmail.com>

The UFS spec defines the PRDT data byte count as an 18-bit field. This
commit masks the value to the lower 18 bits to prevent incorrect
transfer lengths and ensure compliance.

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>

---
v2
  - Fix PRDT DBC masking endianness
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


