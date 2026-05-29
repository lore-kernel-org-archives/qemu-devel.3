Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA7ECD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 04:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpIz-0006sT-93; Fri, 29 May 2026 00:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIw-0006fO-Dp
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIu-0008GV-Rt
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780030720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zp5LvdVtoFOJ0xQQHzcR7UQuvdngw5szwUJi+GkhgiE=;
 b=S4j6eY/dUUFtAHtAfCvIJiLCv2XOmU6PCziAQiz1n60Za3/xVVogaKvpBq+64lO3sGxmYl
 8g5/1GbdqKHj7vwm64CKUmesfSK03mp0tboYhiW//PdB1ypRkuBKUJOQUMYQ6z+9iY7+55
 86aaFYBAJCOCVo4kKJ4W2xHp/dUqgoQ=
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com
 [74.125.82.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-Mql47QBuPySZLvZHrKBEYQ-1; Fri, 29 May 2026 00:58:37 -0400
X-MC-Unique: Mql47QBuPySZLvZHrKBEYQ-1
X-Mimecast-MFC-AGG-ID: Mql47QBuPySZLvZHrKBEYQ_1780030716
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1361d52b3a0so13224704c88.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 21:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780030716; x=1780635516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zp5LvdVtoFOJ0xQQHzcR7UQuvdngw5szwUJi+GkhgiE=;
 b=nlWAjvbyPxfCqj1mt8deCKh/nXrFvqNihwAEBtNE5NmZYYgbmr/xE8cM6nff7fH4q+
 wkIBLsM4t0OrJd3kgvZbr+VXMYipkyl/7XBmziNZeOs5v/XdKnuLHjxW2zfq/SQbwASo
 jZU7GImhlsLNF8N8S0OcQbicB9mKzYx3KSnweVkplmgzOVGO0kr0yQx8ex5jEaRug8QR
 ZBswsDA0q2hzBqCTXYqIlGxoXS9KM8O0skyZrrTM9f9a256/VpmpnoeMKY0KSOhfzo0Y
 du7KTPJdMf/Mxdv1AJhAK1GX5IOPyXYRzUQcMK4/Quh7xmxZx1beGiEhFfOuTEnIlh8l
 uN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780030716; x=1780635516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zp5LvdVtoFOJ0xQQHzcR7UQuvdngw5szwUJi+GkhgiE=;
 b=TF41ulXvJZsXehTt6Xq/4Dp2yV8Q91NvLz15XrcjEzgJOqaFIEqejZ91zaNRwfADmZ
 f9fYqoCxLPtdbTBqCxvBjHh7PBoFYk2yTsjcLYJMv8ynRfZoO2brq0aMtngKR6mO7tnO
 OrBuziT1yFTRNzzMNU8DruvPt+LVJZ4LBP7lDszgPqpgMwbJ8C/V3bS8m9hS+nU1P+E3
 oWPOqVAugrgMUf6ok7+Jvync/9qxap+BuIoClMggwxmYpSGKCQLoBYithLwLDkYmxYwd
 +ZEvOrpkIKCqHHdNPDHOeN64Cjpx9s+kaiMb0/ERks2etl78JUjo1RndJmInmktf7pMD
 Y25g==
X-Gm-Message-State: AOJu0Yyi9hOtmK4T9qzqPUgnstEalaP6gtO0lirQ59fr+ctuX9eimq7X
 8aKy1ych+0EZjhLbJPrKFXJnAoJlISbuaCtrnvpiOu4JDY0RC8ZKP5DhEj6phpox9ShodH+MGjA
 IyvF2+7+R0e+0dMdz6LI1sA7twTj9S0pyX5Q7Td8yZhD8rRLJIiV3W7J6cvD0eCq5ZGUWSD81YD
 XaBpWRxtOufDXNTyXT6mCY0PHMJQivgoVkqrJAdCxiRtk=
X-Gm-Gg: Acq92OHXz93GXATh1uMBge22pLslUL3EuHXY+++PB1yafQ35Mc/Xoivu5g7LK2EIdAA
 nQhZ1lOY8isFZDiiGvIjld4XPCMTgo8S63Q8sNeeuVoKgD0Gt2ehz2rUI3oX/SaFfQglissY+lh
 Ku9iKktT8Jl7dceo9okRsxfiqrsqBQhtYyxvzBSfTPsli+3WmPvilxpB1bt/ciZm0xh5pc+waQv
 xZZjaUOGjp7SzAW8MKHTWYHv3HS9k6LUDOy+5xxNCuM6tKJ0KzvPkjasDZUhglt9xb74j+2OLre
 Yuw0jTcvooxIdbwuYsJn2nfjdB4WuQhZHj+HQfmHtK8jLvMlOMRuCYgGQO/TBvKVsNQfDuiGhrY
 HqYRiQ93FVMv+JCxNni/OGKUSHK3CRITe681w+xl5AiEb6Qa/PIaxE4sBa4vY3o6qHEz2FsYB
X-Received: by 2002:a05:7022:4590:b0:12d:ea6a:1d33 with SMTP id
 a92af1059eb24-137aedd0859mr503942c88.33.1780030716392; 
 Thu, 28 May 2026 21:58:36 -0700 (PDT)
X-Received: by 2002:a05:7022:4590:b0:12d:ea6a:1d33 with SMTP id
 a92af1059eb24-137aedd0859mr503928c88.33.1780030715639; 
 Thu, 28 May 2026 21:58:35 -0700 (PDT)
Received: from localhost.localdomain ([107.172.97.67])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed3358b1sm562865eec.13.2026.05.28.21.58.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 21:58:34 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 15/15] hw/net/rocker_of_dpa: Avoid unaligned accesses in
 _of_dpa_flow_match()
Date: Fri, 29 May 2026 12:57:30 +0800
Message-ID: <20260529045730.90322-16-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529045730.90322-1-jasowang@redhat.com>
References: <20260529045730.90322-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

_of_dpa_flow_match() tries to do masked comparisons of OfDpaFlowkey
structs by casting pointers to them to uint64_t* and then doing the
memory accesses as 64-bit. This is undefined behaviour because the
pointers might not be 64-bit aligned, and the UB sanitizer spots this:

../../hw/net/rocker/rocker_of_dpa.c:321:20: runtime error: load of misaligned address 0x512000164044 for type 'uint64_t' (aka 'unsigned long'), which requires 8 byte alignment
0x512000164044: note: pointer points here
  02 00 00 00 00 00 ff ff  00 00 00 00 ff ff ff ff  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
              ^

We do know that OfDpaFlowKey structs must be at least aligned enough
for uint32_t accesses, because that's the type of the first field.
Switch to using uint32_t accesses in the loop.

Because the "width" field is always set via the FLOW_KEY_WIDTH macro
and not exposed to the guest, we can adjust the macro to store the
number of uint32_t to be checked rather than needing to change the
loop boundary in the match function.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/rocker/rocker_of_dpa.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index 958f3006c1..3d6f55b512 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -99,13 +99,13 @@ typedef struct of_dpa_flow_key {
             } nd;
         } ipv6;
     };
-    int width;                       /* how many uint64_t's in key? */
+    int width;                       /* how many uint32_t's in key? */
 } OfDpaFlowKey;
 
-/* Width of key which includes field 'f' in u64s, rounded up */
+/* Width of key which includes field 'f' in u32s, rounded up */
 #define FLOW_KEY_WIDTH(f) \
     DIV_ROUND_UP(offsetof(OfDpaFlowKey, f) + sizeof_field(OfDpaFlowKey, f), \
-    sizeof(uint64_t))
+    sizeof(uint32_t))
 
 typedef struct of_dpa_flow_action {
     uint32_t goto_tbl;
@@ -304,9 +304,9 @@ static void _of_dpa_flow_match(void *key, void *value, void *user_data)
 {
     OfDpaFlow *flow = value;
     OfDpaFlowMatch *match = user_data;
-    uint64_t *k = (uint64_t *)&flow->key;
-    uint64_t *m = (uint64_t *)&flow->mask;
-    uint64_t *v = (uint64_t *)&match->value;
+    uint32_t *k = (uint32_t *)&flow->key;
+    uint32_t *m = (uint32_t *)&flow->mask;
+    uint32_t *v = (uint32_t *)&match->value;
     int i;
 
     if (flow->key.tbl_id == match->value.tbl_id) {
-- 
2.54.0


