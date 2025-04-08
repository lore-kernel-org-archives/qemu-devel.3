Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85B7C369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 18:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2E7F-0004b8-A7; Tue, 08 Apr 2025 14:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E7C-0004aG-IQ
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:56:06 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E77-0004Dd-F0
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:56:06 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso16175e9.0
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744138559; x=1744743359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FoWrz4Js4MOELdrFFu3ZPYaMj4eI6d7oY8aA0ah1zNc=;
 b=QVqIcOKTJiI0xjtOEzOcHx20w5N3amC6LdaxXjHCy8D8cDpHL1Nz2SS8Dfuosr3/z2
 QIJGHHN0NAeUwEWevKt/PW2nmirDDMh/JoYDqQFWflTfA1hDI/6yM9axDmKgCIKiR5d5
 st9rYnACAogblj+QzVPdUqUo24HtI6IUuw100r+q7HT8VZSBC8Rx09oisghGTo3D4rqZ
 merefv1PBjHKDOKg8YAr+2T5aX+2eG1ztMsnW5quwE4HBusf7U3+YABGV782U7C92E1L
 mTSq7oAX+k893rVsRgq08TqcE236QlY9O+XQ9TBkKUiqmoCAMQiZBNlih1/2PmChiYx3
 Mh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744138559; x=1744743359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FoWrz4Js4MOELdrFFu3ZPYaMj4eI6d7oY8aA0ah1zNc=;
 b=Vqa4CCL715AHnMQkqmm/d7UtBvpz2GrKTHEaO2ZZ4PXZt9q5QhgIYC2G9gk3Z7cJpl
 0VlUrvtXICXNAI+p7J7nmHH5R7pXPG20nh5oc5SW7Vq/LoiNpu77hVy8X5E16dQlK8Us
 dLDpsmvh8f32mqxsPSZASuRAgn0+VVyFtopqFU4SxllaiPHagcaOsbaphBybLsZQfATg
 bjOIhvzwrXXeqDfvvkGCagRg3OnR3JCG3MZPMHwaynZZga6IppRdrZ3VVyZ73geOREmk
 vZI3LpBhK6QSZskFRkl/tlakLac6w9MUKx8YrBfO5ovRNfwQE3/GVCE2kSSBpiFgEKzp
 r4fA==
X-Gm-Message-State: AOJu0YyaAalAzn7fFAhB5YLvA/z73kHnBlsQFyWWv2bq/GWsmu2lDyqP
 wli4LsYkmMnRVdqRpdjBXQvL/400fcthTa6lu3DeHkH0mtRtO4OkskMtvykJvZiWz1WYEX12xW6
 Hm9A=
X-Gm-Gg: ASbGncuwoFoRoVY/KKB5FK1nbR29cCrbQFgzAN1iQ4eoEzePIW4n/xK4gDMJE5zBAHB
 azBTKJuNhsLVyyJvu7Tv59LdDRt74sAx3P6YW5HMkkVu6IL73RYXASlbpxsmei2SY78XHseCdLW
 4PaAFRLdCWjGwhxAxZHwjfyCNtdaqKl1F+56PDGD8pfL3Hgjmsn8sd0/TgCxF7s35zuatkbZ9ea
 qabnX1ApGGDVv3ZB7Am2i3rbq/TpUkBRkKP2t1GwtNWFn0czftrgwlZ13VYgKRRpFpnlqD4xkIH
 vS7xGlx4EaPcNr87FcNyT0DRiox7Q83cSSFAL4b5YDZRuWsM85woRLJwx7jg9jm9ySA7bI7iBlt
 zzzCeh1PNee5pVzqjQU0=
X-Google-Smtp-Source: AGHT+IE09KrzAfKYY/JBGNSzTg6GyIIcA+v+mUTVgXK/B7ZRRvNHfGGIE0sV04sxI/+M1uIIqeoAxw==
X-Received: by 2002:a05:600c:6a0b:b0:43c:f680:5c2e with SMTP id
 5b1f17b1804b1-43f0e649702mr42361495e9.13.1744138558749; 
 Tue, 08 Apr 2025 11:55:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226ea8sm15608392f8f.81.2025.04.08.11.55.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Apr 2025 11:55:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Keoseong Park <keosung.park@samsung.com>,
 Jeuk Kim <jeuk20.kim@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/8] hw/ufs: Fix incorrect comment for segment_size and
 allocation_unit_size
Date: Tue,  8 Apr 2025 20:55:34 +0200
Message-ID: <20250408185538.85538-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408185538.85538-1-philmd@linaro.org>
References: <20250408185538.85538-1-philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Keoseong Park <keosung.park@samsung.com>

The comments for segment_size and allocation_unit_size incorrectly
described them as 4KB. According to the UFS specification,
segment_size is expressed in units of 512 bytes.
Given segment_size = 0x2000 (8192), the actual size is 4MB.
Similarly, allocation_unit_size = 1 means 1 segment = 4MB.

This patch updates the comments to reflect the correct size.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Message-ID: <20250403092140epcms2p355a7f039871b3e5b409754ef450b9158@epcms2p3>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ufs/ufs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index ee13edacd8f..542f13b10ed 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -1753,8 +1753,8 @@ static void ufs_init_hc(UfsHc *u)
     u->geometry_desc.length = sizeof(GeometryDescriptor);
     u->geometry_desc.descriptor_idn = UFS_QUERY_DESC_IDN_GEOMETRY;
     u->geometry_desc.max_number_lu = (UFS_MAX_LUS == 32) ? 0x1 : 0x0;
-    u->geometry_desc.segment_size = cpu_to_be32(0x2000); /* 4KB */
-    u->geometry_desc.allocation_unit_size = 0x1; /* 4KB */
+    u->geometry_desc.segment_size = cpu_to_be32(0x2000); /* 4MB: 8192 * 512B */
+    u->geometry_desc.allocation_unit_size = 0x1; /* 4MB: 1 segment */
     u->geometry_desc.min_addr_block_size = 0x8; /* 4KB */
     u->geometry_desc.max_in_buffer_size = 0x8;
     u->geometry_desc.max_out_buffer_size = 0x8;
-- 
2.47.1


