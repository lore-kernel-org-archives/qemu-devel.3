Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54ABC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtqS5-0004xY-6o; Tue, 11 Aug 2026 13:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtqRb-0004aQ-Vg
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:39:20 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtqRa-0000U3-Bh
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:39:19 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6a1a546a6bbso116036a12.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786469956; x=1787074756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7jUEWeXkj4wjPOT8hF4Qk94qpOm38rox82f+3EfRHP0=;
 b=YMHfIXrgIhYzRPIaRgXCQLUZxDVN6hxUomHItf8zYcxtaxhi+JR9FPrxxEA53N5FAK
 o6JMcDXhummzhDi6UKm1pbtdlwHUKd1MX2g5DRnsWW0pQFJLSMs0PihSMHuOL+9UFt11
 coJTELPAtPNdzYwVAy+o9NDO88thNy6GrNeYQZGjtT+m0q3dTyVPfbDgXje+aHs12rOA
 hXLbiaKeNDTfbk43MDt8/0dCG79OIpjEI2I5o5Lpa7jJImYyA70+Um+hb3lU6clL0GjW
 ezILQpeRVSj2D+Ah3T10KaeeSwRLnKBxOPCaEv0i6TsZiV32pFh4PBPQ+/6t0hIrl5Y2
 ApSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786469956; x=1787074756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7jUEWeXkj4wjPOT8hF4Qk94qpOm38rox82f+3EfRHP0=;
 b=fWIq7DhETnk5oNjVpYD28RgCUQSXzXo8HXkhuyw2inbRrt/h/8HW+ly8XZe2iqwZeH
 zg0dz7GnhnvXuCqO8GyqldZ6S2mEjAisS/UcCBx5mY3xRT0jvp6SuuL7gN2IfiNflukt
 d/JHP1nHbl636j5k9AFRhycdJ88+xMmhO1tCZM+GDOWPzMpJDr5liHXVDCCRmBsT4532
 iIgaKQvaO8z672OrOwtbwh6ChR4DudpujYSIzK4cDDnIQrLxsgyLMs05jH9jcWvB6suV
 DIPdyNG5l4HX1sP4FMhGthZPBkdfR5/iNC9t5UFtaIfzkTHJTX3QkG/NXM4juhZPNdat
 C8Gg==
X-Gm-Message-State: AOJu0YzmSRjeTxNvl4qtAiBKTPqFALMT58WhZjdZQ37G/vm8grCULJWZ
 CAPJoTbXNTnUNdKu/hruu6aVMQ5YGlR50MBVAqjmgcXPIsAt4U7spFE93IytOzeQ1BrFKaH31Lx
 ND2SC
X-Gm-Gg: AR+sD13XSYEMdfk0Y3ElzRt7vf2YxS+pFnyGYvBcwAXAODTXv1qmJVEmp+bh351Pr/q
 SKGicNgdM+pAdDa3E3xOvL8jalgnsRjPNFY3SvQM/pE7bCC1aVP4a1oWpYX93C9lRQFWY0GmZ8S
 tLvF7Llu6yNmi8M0L/y2FjQI9ekvKrQD427MAy5Z/IqOXRxNlhzNNzKruFWhqC64teQQ1dg3gdu
 TsKeXttfH0NkWGXvbmaBYujJDSdp5otlJrAugYyt5TBAQou7pSPNXBVQJi1xAmT7ql/vjVRKXRP
 xTFNAWetwTRTiJWgLjM8vgYVWxHlly2Nl7wvgvEujGhFHPCDnTZasKC+DqC5X0qgor2ZyAxU65I
 nS+xsSMVTOG3G6FglFNe7LpiCg5ZBB1YZGKEcihX0kjjfp/fbJ92w+BAQz02mAU5llIz8+vOToF
 jjYyZjRhipwI/YEf9BVqkHi+gXRDvcqWVkySnncsWsNw2jJzYzl9EtCVag
X-Received: by 2002:a17:907:998d:b0:c19:6d4a:425b with SMTP id
 a640c23a62f3a-c20e618034emr282425166b.18.1786469956023; 
 Tue, 11 Aug 2026 10:39:16 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c43:d230:7bbc:68d4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a362ef7525sm880945a12.29.2026.08.11.10.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 10:39:14 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 5/8] parallels: reject a Format Extension outside the image
 file
Date: Tue, 11 Aug 2026 19:38:54 +0200
Message-ID: <20260811173857.396571-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811173857.396571-1-den@openvz.org>
References: <20260811173857.396571-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=den@openvz.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Format Extension offset and the cluster size both come from the
image header and neither is checked against the image file. Reject the
image rather than reading a cluster which is not there.

Fixes: baefd977002e ("parallels: support bitmap extension for read-only mode")
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/parallels.c b/block/parallels.c
index 93b5fa9dcd..50748d1415 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1375,6 +1375,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     if (ph.ext_off) {
+        int64_t ext_off = le64_to_cpu(ph.ext_off);
+
         if (flags & BDRV_O_RDWR) {
             /*
              * It's unsafe to open image RW if there is an extension (as we
@@ -1382,9 +1384,14 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
              * ignores the extension, so print warning and don't care.
              */
             warn_report("Format Extension ignored in RW mode");
+        } else if (ext_off + s->tracks > file_nb_sectors) {
+            error_setg(errp, "Invalid image: Format Extension is outside the "
+                       "image file");
+            ret = -EINVAL;
+            goto fail;
         } else {
             ret = parallels_read_format_extension(
-                    bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, errp);
+                    bs, ext_off << BDRV_SECTOR_BITS, errp);
             if (ret < 0) {
                 goto fail;
             }
-- 
2.53.0


