Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE03C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3ao-0005LL-6q; Thu, 20 Aug 2026 10:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wx3am-0005L8-A3
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:18:04 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wx3ak-0000O5-LK
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:18:04 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so2795579a91.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 07:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787235480; x=1787840280; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tslTarZmJNEF2sR6/SYr9C49KyujJAjRqwwffh5b5Mw=;
 b=tfUofKDo++1xzA+D1JZcHHTENJ1UXAm2oGYdgLzdmxObcNnnKB5rx5Z16wJ2Hxi174
 8kTRmfgvn0dcNIeygzxm/yLAu+1dcGWaLbI9ajwGK6QGc7WfvrEPPTYNUMz4DequtxUb
 JQBTTKxBNcyy0YxXvNC3ANiqCZzqNFWqxvKcMbMEAqLX6qOQHTN4VkxOS/iEFcyr8nVj
 QsBBQqm6Js7NzUxiDvFL2zscWMx2HWF0u/uFuMe2sAtYgwju2zzrCCfXA7v/djJ2Xk5t
 xyK308hYMROCKlk2PsuyrnqVZIsD4gAQe97eY8oYzjZmNoz8njCVATB57ZVZK+LZsYMo
 zaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787235480; x=1787840280;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tslTarZmJNEF2sR6/SYr9C49KyujJAjRqwwffh5b5Mw=;
 b=h8KsDRiqs19Lr8dglBvT7BAFMRRMxxico5XE2Px9Jab1O0Qjpz8Pg/GgHXELG9OAF6
 Zk0TnI+1AH9TN53PG4k1i8teAZ5WZpxU83kuAkoX1sTgFCWHk4e5ErCuA82LPiYYPlEe
 Tl3uAVc56H4tRliuOcs3Rfu62uusoGutcqipZt1k0EPb9lJ9YvyLr1hkWUso9C4U35N7
 P0lGmCvJhwBKwXoePdTWswSv8kN6u4QHIl1b+vikelc0aFOT6za7HcDOnPIaXioklP5R
 T80FOQRa/zTU4+6GnHBVBzeGuTz8g00X4OEKOLCwG52MGa2r4kYr74PbiLjn9QDp5SLF
 fBrA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjRcqgAUyfwRWYv8+ebZuBOhfrzegx7kd4dot9kiN2bgBjzBKnKG767oA0E1e4doy+htpoFfdkwVN1@nongnu.org
X-Gm-Message-State: AFuF++lcjBDoB4GbOJcl7z2+5drfzpKgDvQUMDWlk9i9irexNY9tPwhZ
 uwjCv+HxxmIWJybKcCfDirjjZXmw5TwHT32fqByahkYL+VNfMVq/0SeA2JkkmYtVKRg=
X-Gm-Gg: AR+sD11t7QpMeqUpnMMkEOeu29SINGnFhxtMkhDn6/bjFZBWfCj9LSgvlNfDMau41as
 yYYGoNwR/3EtLUmulS1BdaN5Qzw49rjRhQPNQnkE5ntnWQIIUbVuoOlWTxd+7c9FqvkCmQ/ZefH
 cNmzmiOSFnVAQV5Un4taEPeBJfvxABJogoPpZwge9rOOy9aHhrrojiUU4s5xGpk6ef4NuFxAg8/
 PKlmbtYL9hngGt0KQJlVRCiSjkOC7ZIeqLpr3O9s3zxAaxFYJD0d/7SlOvZzUjQkHj7tSIcgJzM
 4u02ydyI/VRZo/0iASmgUma34qsnHjtcbzNJ9Q57qidylmnWlyPOf4M3/Rfe9hCX7AjG/J7X+Xd
 Gr9PdsxGEPx+erxn/WIl+o9NDwt2+MnHVg8TPqQaRNIqduh3oCY1OWgoViAQ3W7Yg+l/6Ox5+E2
 tok7Q1eKfv3TrB35Ggikd1DRI6iPMGH7BqhODuqiGH0nILogBnODevYYGtdwBjy9WQpg+DVZ6fn
 Pxlwz6W
X-Received: by 2002:a17:90b:510d:b0:38f:18f9:785 with SMTP id
 98e67ed59e1d1-39580f2d498mr26233251a91.8.1787235480243; 
 Thu, 20 Aug 2026 07:18:00 -0700 (PDT)
Received: from [10.213.131.227] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957f9ab8besm6777927a91.6.2026.08.20.07.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 07:17:59 -0700 (PDT)
Message-ID: <c192a3a2-c804-46c2-9603-b88609003c29@linaro.org>
Date: Thu, 20 Aug 2026 07:17:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 25/93] tests/qtest: add RISC-V IOMMU MRIF notice tests
To: alistair23@gmail.com, qemu-devel@nongnu.org
Cc: Flavien Solt <flavien.solt97@gmail.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
 <20260820034430.1186695-26-alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260820034430.1186695-26-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 8/19/26 20:43, alistair23@gmail.com wrote:
> From: Flavien Solt <flavien.solt97@gmail.com>
> 
> Exercise MRIF-mode MSI writes through iommu-testdev with the destination
> interrupt-enable bit both clear and set. Each case requires the pending
> bit to be stored plus the configured notice ID to reach guest memory.
> 
> The enable-clear case regresses the notice suppression fixed by the
> previous patch. The enable-set case provides a control for the existing
> path.
> 
> Signed-off-by: Flavien Solt <flavien.solt97@gmail.com>
> Reviewed-by: Chao Liu <chao.liu@processmission.com>
> Message-ID: <20260727-qemu-mrif-v4-v4-3-73e0890ad395@gmail.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   tests/qtest/iommu-riscv-test.c | 102 +++++++++++++++++++++++++++++++++
>   1 file changed, 102 insertions(+)

Something in here has an endian bug, as this new test fails on s390x:

https://gitlab.com/qemu-project/qemu/-/jobs/16009267995#L5106

▶  694/1142 /riscv64/iommu-testdev/mrif-notice/enable-clear - 
ERROR:../tests/qtest/iommu-riscv-test.c:349:run_riscv_iommu_mrif_notice: assertion failed 
(pending & (1ull << RISCV_MRIF_INTID) != 0): (0 != 0) FAIL

Full output when running manually

# Found PCI device: vendor=0x1b36 device=0x0014 devfn=0x08
# Found riscv-iommu-pci at devfn=0x08
# RISC-V IOMMU MMIO base address: 0x40000000
# Searching for iommu-testdev (vendor=0x1b36, device=0x0005)
# Found PCI device: vendor=0x1b36 device=0x0005 devfn=0x10
# MRIF notice: enable=0 pending=0x2000000000000000 notice=0x2d010000
**
ERROR:../src/tests/qtest/iommu-riscv-test.c:349:run_riscv_iommu_mrif_notice: assertion 
failed (pending & (1ull << RISCV_MRIF_INTID) != 0): (0 != 0)
not ok /riscv64/iommu-testdev/mrif-notice/enable-clear - 
ERROR:../src/tests/qtest/iommu-riscv-test.c:349:run_riscv_iommu_mrif_notice: assertion 
failed (pending & (1ull << RISCV_MRIF_INTID) != 0): (0 != 0)
Bail out!
Aborted (core dumped)

I assume pending was expected to equal 0x20, not the byte-reverse.


r~

