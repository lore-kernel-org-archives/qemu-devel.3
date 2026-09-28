Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A8CC9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB78j-00082o-5U; Mon, 28 Sep 2026 04:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoxiaoqiang007@gmail.com>)
 id 1xB78f-0007vq-0T
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 04:55:09 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhaoxiaoqiang007@gmail.com>)
 id 1xB78d-0002ok-Ej
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 04:55:08 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 d2e1a72fcca58-88098dbba5fso430586b3a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 01:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790585706; x=1791190506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=paSQV+Zg9VcVlAOmMaGCNs2XLxayEdh/oSnerb8Y344=;
 b=TXk6hWaI388Yo8J7iwFKcLS3m3remIurAWlrQFMWReAtsGDob8P85se9bZ0trv0B4b
 oyg1qeeW4CRLPXRDe31cPL3IfRLk5lyeqm5nEEaR9ED8Ik8WO9UswQPJqWOgmcwJEuPM
 hhsCZ2PSyJ0eYBQnxrYaK1Y8yi3xcG/fPcyIL9LXfskOBt1/pRAOiydGaOW/vgtfHlWM
 iHQ2h+ouj3fY65ciCo0hWGMwfvwt6+u1EXcrFjBHUaKkYvPK50pjFEnzqO8RrmX+p814
 i5iqwSo/+zBQgdEx6nYItJMyv479+g832WfqVYw/XeJztWX4DFQ1bE4N2hOmWijrN5wc
 B65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790585706; x=1791190506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=paSQV+Zg9VcVlAOmMaGCNs2XLxayEdh/oSnerb8Y344=;
 b=lcyRH4Ol/Y13tnnw0njIOlHc2D7jBbm2s2gZBUzj0lmYeWo27IKJhrfu0gk9qTU6uo
 w46xo7h5H7m0yWM4wJgEkeuCi85F5y4drRFfR/byJUcu4qcmTiAKoTZj5AtNLnhkWtsG
 RExDHi4QRwOl3ZFBoFJui75wfxjPmdVZ58lk0dDvmzIJPMZEsZePGLUdnXzyu+ImQnRp
 iK44oWSEbut/YHQ3vyvRjaJTR1g7SpwRIM5G69TLSPKhd1COJtmYvJD6tlm5CM9AI2ow
 Nq15mmbciKBl0O20f+KPscv/z/5CNaavEnL02MmfLRdfqeDrrrCuQh1kgkt8V2xsdaad
 W1Qg==
X-Gm-Message-State: AFuF++k7gARKXFSVtH/q8lBmjeGThfy5xoXTHnQ+jPuJ0UggQWn96TGi
 HGg6TZX5bs90wBqj13FnQnWEQZKNDRsFhzgmJPEmNqZitMPmLdxGNE7oykh6McnX
X-Gm-Gg: AYBFou2KG0zmMIeDI688H6zFmbtvG+5V1M+l8Um152TGjrZwLU6J1gOpFjI7CsM86ZT
 GKpupJtxg1BQ8bjJ5XDEo4v0j3Csyfk0+RXFvgpAgEcek+foHRfzaEopybb5B6kG3TsvbEVXxYr
 B0O0a7OfuWXlUJ6t0ccVFEn+MM9DeivXiMXlGqnMXtm+n/x0VNc5ogDjR0cmXPSXUBTmkQgQK96
 2ur6bZYYQ0pGJ8miNvGIEHTTJ29VZwsi1tbaaJn06/yaZyeM+fw/EqKfSDTAakAb1cgQzU1dAQy
 +4xVibNfYvzUMNE9oAVYWu8Dzoxx62IyW1I4yXC2t66Ronb5m82quC99Ei2OwgmwXuo3ai8Ylmt
 PWeT8vRix2cvxWunvZnBWsAqL3uT64Rn60xWfEbKqOTdKTEArV46adFr9C/CIcYKDEgz3njckUu
 /sooiok5QtEYwzRh98ufoA5R9jjPEIWwL+/sSmjMDRoBLUSO7p46tQlcWJjglR0zvSu3mp/AU=
X-Received: by 2002:a05:6a00:ab8d:b0:857:72f8:dca7 with SMTP id
 d2e1a72fcca58-87e9e77e9e5mr6851096b3a.13.1790585705844; 
 Mon, 28 Sep 2026 01:55:05 -0700 (PDT)
Received: from debian ([1.203.174.67]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea18ff77sm3849500b3a.14.2026.09.28.01.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 01:55:05 -0700 (PDT)
From: xiaoqiang zhao <zhaoxiaoqiang007@gmail.com>
X-Google-Original-From: xiaoqiang zhao <zxq_yx_007@163.com>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, maobibo@loongson.cn, jiaxun.yang@flygoat.com,
 xiaoqiang zhao <zxq_yx_007@163.com>
Subject: [PATCH v2 2/3] hw/loongarch/virt: fix SPCR bitwidth value
Date: Mon, 28 Sep 2026 16:54:18 +0800
Message-ID: <20260928085419.188886-3-zxq_yx_007@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928085419.188886-1-zxq_yx_007@163.com>
References: <20260928085419.188886-1-zxq_yx_007@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=zhaoxiaoqiang007@gmail.com; helo=mail-pz2-x2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Serial base_addr.width should be 8 instead of 32.
The wrong reported data will cause ADE in FreeBSD console initialize
process and trigger a reset loop.

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 hw/loongarch/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 600ef60fc5..54965f011d 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -268,7 +268,7 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     AcpiSpcrData serial = {
         .interface_type = 0,       /* 16550 compatible */
         .base_addr.id = AML_AS_SYSTEM_MEMORY,
-        .base_addr.width = 32,
+        .base_addr.width = 8,
         .base_addr.offset = 0,
         .base_addr.size = 1,
         .base_addr.addr = VIRT_UART_BASE,
-- 
2.55.0


