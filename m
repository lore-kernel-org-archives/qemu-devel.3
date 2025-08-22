Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3511CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 13:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upSDW-0005vP-J9; Fri, 22 Aug 2025 09:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cjchen@igel.co.jp>) id 1upO1Q-0005cm-1M
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 05:25:20 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cjchen@igel.co.jp>) id 1upO1M-000792-Cj
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 05:25:19 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b49c622e598so137810a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 02:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1755854714; x=1756459514;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlo0VNE2LkX+k6ixV83bmWbI8LIl4VVBBmVNmXeQQcY=;
 b=gHlpWm/esdPlDf6OBTQA7j9IL58URUKNJ0ypl7KeyPyy08LqL136YGcVIR5dnkvhRM
 D31OB5pb2A36D7g9zEb8ePHOJPr7cdsNh17PgXh4SQaLp6GvjkAuKeD1qVoL2XvDPueB
 LmmTrstfjrYf8b+fKHtwP01Ch/obmqPSUI5hebbJ86QYdt0qHVYzHlQsa3u+1z5AiF/k
 nyyE5JhkLvgRS/cOnxTLmoMavA4IARyEM0sbEzJdzHfZqnQwAOXJtF2AvR8QnPmHnpY+
 80ufSJoKrpnPDXps6WynkWrmvAtTbD+qjVzBLInJun54WGVFd8lC2xmW+hhRGTPUaCmq
 fY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755854714; x=1756459514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlo0VNE2LkX+k6ixV83bmWbI8LIl4VVBBmVNmXeQQcY=;
 b=v4TtVMhs1NzXghMduwyd2VdC7j31A0Oi5mAKxA9zvh/Yq9u8tsu5QLDqKuUXkXq7a/
 birS3llMyzz/cTLFPiSIQh06x5QZppScz3Icy2P2ODEhGAI31vjRfzlUUY0+b1nH2788
 HaDnlCu5UybNFxlJj/DiEaeONrpQOyUuF2ELkmK/erBxZuDEC8V79KPZbvaWcXXux1Kh
 VZRMFHz8C58lKMXB+F2/i/eV0kn3/7a6L+ucsZn0L5Sjus50WspNMPpIRXcMymqOYja3
 ofk1ajT3YOBmGD6QZuSbrRoQZG/LIf5hzMNabhIMFPeF7OHLnc1OjRiKezSph5OMD292
 zr2Q==
X-Gm-Message-State: AOJu0YxzE7kRNh+QgXb5W4Wc+rqPlE4UmXN1rJRm8PI8bGXv59Yw7WX9
 EVdm8tspIbXPTsgbnhZO1Epm6/5dWFO1IQKEUliFiHQ1lWSO8/bEEnmO5PRO4AIwUCGTCkA4bpI
 SOX3IkIk=
X-Gm-Gg: ASbGncvlesa3rpUoGqKN1YPQ8ul8yyhFscQ2vmUVY3UBlvsUB2kANyH4PuowY0p3JnS
 Edq2pcXZGFveKrMccyZr/jdIFhRWn8u9rhtH5bsLvRyaNxHgAYCFgoAxVJv1ednOdBHLV6lwAZd
 RYH3VssI1HhnKcvquK1vAlkdZkb26lbDr0MvoWR805vPBWDXEoQ+X8DKg+0SEOU/noA6iIWlHms
 m9r/3fUXtJ6LAR4qcRBgw8Z3YThKE5VqUqv2Eq1wuCrWj1TjLLW7DBHasZfrBB8K63n76Xt1Icg
 aRFOl/2zju5xIx+JsjgpjaPrTWsEnssgVZJ5K8hAtSdhdcjox7tLLwJg5rp2/Va0HYoQgQQ+5pQ
 hVeuhrCVglAa/FQbFcKBLlKpuOQu1IgpZJyb2nk2+EwoSWXicV8dP+l0EXciVbQQ=
X-Google-Smtp-Source: AGHT+IEqxrEnh0zkYioghUeAJylIvzfIK34NEJeRhP+7uR5uCgzNq3nYAwgrwA28HLoaAtq27/RD1g==
X-Received: by 2002:a17:903:2302:b0:240:3b9e:dd4c with SMTP id
 d9443c01a7336-2462ef446b7mr34309165ad.36.1755854714249; 
 Fri, 22 Aug 2025 02:25:14 -0700 (PDT)
Received: from warg.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed4c6fb7sm78560215ad.89.2025.08.22.02.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 02:25:13 -0700 (PDT)
From: CJ Chen <cjchen@igel.co.jp>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Tomoyuki Hirose <hrstmyk811m@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, CJ Chen <cjchen@igel.co.jp>
Subject: [RFC PATCH v2 2/9] hw/riscv: iommu-trap: remove .impl.unaligned = true
Date: Fri, 22 Aug 2025 18:24:03 +0900
Message-Id: <20250822092410.25833-3-cjchen@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250822092410.25833-1-cjchen@igel.co.jp>
References: <20250822092410.25833-1-cjchen@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=cjchen@igel.co.jp; helo=mail-pg1-x535.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 22 Aug 2025 09:53:58 -0400
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

Since riscv-iommu does not support unaligned accesses, drop
`.impl.unaligned = true` to avoid the contradictory pairing with
`.valid.unaligned = false`.  This makes QEMU reject unaligned accesses
for this device and prevents the assertion in memory.c that previously
caused `make check` to fail.

Signed-off-by: CJ Chen <cjchen@igel.co.jp>
Tested-by: CJ Chen <cjchen@igel.co.jp>
Acked-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
Reported-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
---
 hw/riscv/riscv-iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index a877e5da84..277746598a 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2288,7 +2288,6 @@ static const MemoryRegionOps riscv_iommu_trap_ops = {
     .impl = {
         .min_access_size = 4,
         .max_access_size = 8,
-        .unaligned = true,
     },
     .valid = {
         .min_access_size = 4,
-- 
2.25.1


