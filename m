Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF18F99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKl-00012B-GD; Thu, 23 Apr 2026 06:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJi-0000Yz-GP
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJg-0005MM-U8
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wwkW5JCG7FWgbyoekfLFNx81cj7HS6BDKB+OcGK2C+Q=;
 b=ePMbu0WsPClW6dtdsUmDgKCKNITCNhBelnw1ks1Yk64WU8ygSch1oFCqmivVkFD+X8/de0
 Wm0OcriYhzqIEYDL77wdaJqDlmjcn6g92dNVAtH2kVbC6trT3/xMWs7VYHTyBAnifJLOEg
 JB4sGqbiDgl1XFKS/UE78/l74VIydC4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-qFUH6toCP_C6XLWj7LBwxg-1; Thu, 23 Apr 2026 06:29:49 -0400
X-MC-Unique: qFUH6toCP_C6XLWj7LBwxg-1
X-Mimecast-MFC-AGG-ID: qFUH6toCP_C6XLWj7LBwxg_1776940188
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4411a215f17so3385348f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940188; x=1777544988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwkW5JCG7FWgbyoekfLFNx81cj7HS6BDKB+OcGK2C+Q=;
 b=JH8AVdsVbTgdE6zGX3t4fDESVRMzrPEEsUenhchfZGFdrNr5r3ip7rNjqvtWri+QZH
 yOKxTt6nH0fvKzRtEGcIufMI4aH+lSSf0Q6TbY8qg3dmfD8VYTOYMIaOwDrTMF+Tg+64
 Sg1Hd8Zg/23DrxwVGTVq5Q8PyesJ14XZenEFf3xsYkLjeqFlY/juN+MsgdXHJ3ShPVub
 dB4uwVIJ4/3K+NGbSjU84Yp9ngLrFzN4db3h0fAG8lHgif7/+LUtL+qN9Vxn0nTfkN0q
 Pgz1m7aadNpv7eT7YLsenqTL+1JClzS5vCWGGg3K2FD0L7P7iOKeR0JKBGQJKV6plgi5
 p/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940188; x=1777544988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wwkW5JCG7FWgbyoekfLFNx81cj7HS6BDKB+OcGK2C+Q=;
 b=okwvvQzUspfLOj0nj04IG+XmC96cLfwKekDLBeu1yS+FJz3YEkn3YYL4Yc0KubyuzZ
 30TppzzbDX93fMtmRklrUtrjsP7RPaaYDeXLdC/e7Gx0zl5ee2rHcIdC+iMVFP49Q0vV
 IoDbuhuyuzU/mEWsy/VVycVRTYaglCSoxcVT8pk9IUTJWwK63u8ko5Pwz5Jo1A+mKwHe
 cHDxuT2Tv6hIw6z3B46ckayRMUqkp6SKok81IVp+S28VecfJd0FfWABRyPGYSDAaU+s9
 6qR2axiJe1TDf9O3bXbtTQ/C5oCrnL5FOWF1jaT9O2nMOf0lAcDAaO5j5egQ4dkUmB7Q
 kJBQ==
X-Gm-Message-State: AOJu0YzWuiaO5zf4qCe8b7izFtl422eJjzUVB//AAFxJi80c3PeDOQoc
 hXWQxAK050O5lWWjKJ5Ow33gkDOvO/u3M7eYDoJHZtbOKHVczGVZH6gg88jDSCSMcWlrLnW64I9
 UOV8fMAtRQYLJEHi3jH0NjgHwfqYChmmZhHcrPf/HccqOVS8O7XiSeS4JlX95Po/l0Z88qVN6iP
 7BGC+IlJcLljAs/W9CDOVJ8kWwOUmoGt3UvJizR7nF
X-Gm-Gg: AeBDiesee6VmdpLGZ4mbo2Jc6bIwKCK7sbiaV8N6f9lArJYZotKglnATcGKlsqx4qZ5
 wJlLwfR75w88j3T7ibaMRzoWviDR3C2W/XlEXkvGfMaHKyhAKfKdDE7U6crNtSDPQFqGSgyV9r9
 eHO6hFAj47aORPldwNPNdTc2JvxRfgAN1sRZuh1A5DOCtOckgUBRn/wWFfmDu9CSeCkZV9wvwCs
 8BLN//LKkaYqJfRv29Q2CKurnO3mbnZyUVxsFFkmscngcsMrVy9zC5uDKkJ421mhT5ndEvmExxh
 MDI8DZg6BXYyHFktUVBeT7wfEbrBiBbdbLErFVJECvuXjB8Ysk2vxNQk2XRlq/ZCKaiYzhc69Xf
 FtIYuP7wiD/8MTGk7u09nbbqheCv3PP7egtZZaLpJZ3bN7BKuQ4AuX282cfLRtLK8IhKdeaAn65
 ne1OFk4DsWvfKUg9hCqqrbJGH2Jelp8e49IjQ=
X-Received: by 2002:a05:6000:2503:b0:43c:fde7:f1 with SMTP id
 ffacd0b85a97d-43fe3dd3a84mr41721130f8f.18.1776940187972; 
 Thu, 23 Apr 2026 03:29:47 -0700 (PDT)
X-Received: by 2002:a05:6000:2503:b0:43c:fde7:f1 with SMTP id
 ffacd0b85a97d-43fe3dd3a84mr41721083f8f.18.1776940187446; 
 Thu, 23 Apr 2026 03:29:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb11b4sm53159726f8f.2.2026.04.23.03.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:29:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/25] target/riscv: Use glib2 instead of strcasecmp/strncasecmp
Date: Thu, 23 Apr 2026 12:29:06 +0200
Message-ID: <20260423102922.443639-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

This is a change in semantics. g_ascii_strcasecmp() doesn't honour
locale but strcasecmp() does. But this is OK for at least one reason:
 (1) QEMU always runs with the C locale so there's not an actual
     behaviour change here

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20260327134401.270186-8-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/monitor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index a9d31114442..bca04a7580c 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -303,7 +303,7 @@ static bool reg_is_vreg(const char *name)
     }
 
     for (int i = 0; i < 32; i++) {
-        if (strcasecmp(name, riscv_rvv_regnames[i]) == 0) {
+        if (g_ascii_strcasecmp(name, riscv_rvv_regnames[i]) == 0) {
             return true;
         }
     }
@@ -358,7 +358,7 @@ int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
             continue;
         }
 
-        if (strcasecmp(csr_ops[csrno].name, name) != 0) {
+        if (g_ascii_strcasecmp(csr_ops[csrno].name, name) != 0) {
             continue;
         }
 
-- 
2.53.0


