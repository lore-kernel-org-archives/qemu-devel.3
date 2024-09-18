Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2819C3ABDB
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 15:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqwFn-0006Bk-US; Wed, 18 Sep 2024 11:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqwFk-00068v-3f
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 11:06:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqwFZ-0002Rq-F6
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 11:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726671947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u845TG0oJ5Tg+SHZqSUpLYTCEL/8gN99uq/os0RRWDU=;
 b=gkcIutCn6vrX6nfmMXFQe5np42ruTxyRMSknqOdzNDpO/H1WTbFLm0S39Yriij3XKM68C1
 9b0PVmk+Ez4m9t3jOGP3PX0gr8ipS4FkFJ+qOvyfBIG7UaCuM46jeK8qoaDzBfRfvo+tTz
 w+fb2e+F/mjMa5VeLLHTm7yFLlGqPHQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-B53O_rZnPAeYkrm_R0-6DA-1; Wed, 18 Sep 2024 11:05:46 -0400
X-MC-Unique: B53O_rZnPAeYkrm_R0-6DA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374c79bf194so4371031f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 08:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726671945; x=1727276745;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u845TG0oJ5Tg+SHZqSUpLYTCEL/8gN99uq/os0RRWDU=;
 b=t7xatUeZ50j9zl7k1E5e6b5commPWK7c4IFFUeiE+CvJ7Ja9zM93AUVj8RYSUGa4Zr
 oc/OfdDyMpvxMmb2Mfw5iXLTXXiAJPJkzN+CeR1A9HvlL9BFQSynOIJke5Mk45+/609A
 ok7tTLfJ6l7+CMNV6J5cREyJ6pqRFW5+07cMsVssQTDikqMDMfmHjKD4/z1+ArVGI/GY
 aoLnovvz47BFnA+EDIBfhK0OwXRx5wgiEGGH+D4n96aLOTKRr5HYIPIzH+aqtGAuHS4z
 3U2MwP81LRs9gKcIyODVyPGkoJB71QWzCnLEjGZ7tHw/hwJ/VdaGnLzy6Kyf5miCTXMh
 HDiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmk9RSan0QvJYYIqw5R2PA+BhMv6DrsZgR/rdOIDfF8jvvlgzfRsVOoXOP8NIRJEvpyKuec1lVyBeG@nongnu.org
X-Gm-Message-State: AOJu0Yws6kpX+qXblM52j/O6hNCf30g02RvEt0hYWw0/mgmRk7ZJ6TYR
 G2pwtJ20YuJ8dYgfzKIL1oQ5rCteBP+uvQD5Jue6Pt0HEfQGrn4t74cvt5CJc0Svq36wsG8vpCY
 0u0SpXBIkU3Fz/ZgDaFHsF9L/B8d5P0K99MBUkzJyg3SIT3cEMPSW
X-Received: by 2002:adf:ab48:0:b0:371:8f19:bff0 with SMTP id
 ffacd0b85a97d-378c2cf4b74mr11801704f8f.20.1726671944653; 
 Wed, 18 Sep 2024 08:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0Wv7nX+4Xt+Ma9jDloPjMf6Xm+TZPRbUKEHtHgPJsNlrX/hujW/5WK9rzIgTwpu48vWFrOw==
X-Received: by 2002:adf:ab48:0:b0:371:8f19:bff0 with SMTP id
 ffacd0b85a97d-378c2cf4b74mr11801669f8f.20.1726671943971; 
 Wed, 18 Sep 2024 08:05:43 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-42-49-166.web.vodafone.de.
 [109.42.49.166]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e780ddebsm12465993f8f.112.2024.09.18.08.05.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 08:05:43 -0700 (PDT)
Message-ID: <475a7b69-d0ee-4acf-88c9-64ac03864fe5@redhat.com>
Date: Wed, 18 Sep 2024 17:05:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: Add XIVE tests for the powernv10 machine
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20240916182311.30522-1-kowal@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240916182311.30522-1-kowal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 16/09/2024 20.23, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
> 
> These XIVE tests include:
> - General interrupt IRQ tests that:
>    - enable and trigger an interrupt
>    - acknowledge the interrupt
>    - end of interrupt processing
> - Test the Pull Thread Context to Odd Thread Reporting Line
> - Test the different cache flush inject and queue sync inject operations
> 
> Co-authored-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Co-authored-by: Glenn Miles <milesg@linux.ibm.com>
> Co-authored-by: Michael Kowal <kowal@linux.ibm.com>
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>   MAINTAINERS                        |   3 +-
>   tests/qtest/pnv-xive2-common.h     | 246 ++++++++++++++++++++
>   tests/qtest/pnv-xive2-flush-sync.h | 194 ++++++++++++++++
>   tests/qtest/pnv-xive2-test.c       | 351 +++++++++++++++++++++++++++++
>   tests/qtest/meson.build            |   1 +
>   5 files changed, 794 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qtest/pnv-xive2-common.h
>   create mode 100644 tests/qtest/pnv-xive2-flush-sync.h
>   create mode 100644 tests/qtest/pnv-xive2-test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ffacd60f40..f410dc1714 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2660,6 +2660,7 @@ L: qemu-ppc@nongnu.org
>   S: Odd Fixes
>   F: hw/*/*xive*
>   F: include/hw/*/*xive*
> +F: tests/qtest/*xive*
>   F: docs/*/*xive*
>   
>   Renesas peripherals
> @@ -3326,7 +3327,7 @@ R: Paolo Bonzini <pbonzini@redhat.com>
>   R: Bandan Das <bsd@redhat.com>
>   R: Stefan Hajnoczi <stefanha@redhat.com>
>   R: Thomas Huth <thuth@redhat.com>
> -R: Darren Kenny <darren.kenny@oracle.com>
> +R: Darren Kenny <darren.kenny@oracle.com>

Please drop this hunk.

>   R: Qiuhao Li <Qiuhao.Li@outlook.com>
>   S: Maintained
>   F: tests/qtest/fuzz/
> diff --git a/tests/qtest/pnv-xive2-common.h b/tests/qtest/pnv-xive2-common.h
> new file mode 100644
> index 0000000000..66647686ee
> --- /dev/null
> +++ b/tests/qtest/pnv-xive2-common.h
> @@ -0,0 +1,246 @@

Please add at least a SPDX-License line with the license information.

> +#ifndef TEST_PNV_XIVE2_COMMON_H
> +#define TEST_PNV_XIVE2_COMMON_H
> +
> +/*
> + * sizing:
> + * 128 interrupts
> + *   => ESB BAR range: 16M
> + * 256 ENDs
> + *   => END BAR range: 16M
> + * 256 VPs
> + *   => NVPG,NVC BAR range: 32M
> + */
> +#define MAX_IRQS                128
> +#define MAX_ENDS                256
> +#define MAX_VPS                 256
...
> +static void get_struct(QTestState *qts, uint64_t src, void *dest, size_t size)
> +{
> +    uint8_t *destination = (uint8_t *)dest;
> +    size_t i;
> +
> +    for (i = 0; i < size; i++) {
> +        *(destination + i) = qtest_readb(qts, src + i);
> +    }
> +}
> +
> +static void copy_struct(QTestState *qts, void *src, uint64_t dest, size_t size)
> +{
> +    uint8_t *source = (uint8_t *)src;
> +    size_t i;
> +
> +    for (i = 0; i < size; i++) {
> +        qtest_writeb(qts, dest + i, *(source + i));
> +    }
> +}
> +
> +static uint64_t get_queue_addr(uint32_t end_index)
> +{
> +    return XIVE_QUEUE_MEM + end_index * XIVE_QUEUE_SIZE;
> +}
> +
> +static uint8_t get_esb(QTestState *qts, uint32_t index, uint8_t page,
> +                       uint32_t offset)
> +{
> +    uint64_t addr;
> +
> +    addr = XIVE_ESB_ADDR + (index << (XIVE_PAGE_SHIFT + 1));
> +    if (page == 1) {
> +        addr += 1 << XIVE_PAGE_SHIFT;
> +    }
> +    return qtest_readb(qts, addr + offset);
> +}
> +
> +static void set_esb(QTestState *qts, uint32_t index, uint8_t page,
> +                    uint32_t offset, uint32_t val)
> +{
> +    uint64_t addr;
> +
> +    addr = XIVE_ESB_ADDR + (index << (XIVE_PAGE_SHIFT + 1));
> +    if (page == 1) {
> +        addr += 1 << XIVE_PAGE_SHIFT;
> +    }
> +    return qtest_writel(qts, addr + offset, cpu_to_be32(val));
> +}
> +
> +static void get_nvp(QTestState *qts, uint32_t index, Xive2Nvp* nvp)
> +{
> +    uint64_t addr = XIVE_NVP_MEM + index * sizeof(Xive2Nvp);
> +    get_struct(qts, addr, nvp, sizeof(Xive2Nvp));
> +}
> +
> +static uint64_t get_cl_pair_addr(Xive2Nvp *nvp)
> +{
> +    uint64_t upper = xive_get_field32(0x0fffffff, nvp->w6);
> +    uint64_t lower = xive_get_field32(0xffffff00, nvp->w7);
> +    return (upper << 32) | (lower << 8);
> +}
> +
> +static void set_cl_pair(QTestState *qts, Xive2Nvp *nvp, uint8_t *cl_pair)
> +{
> +    uint64_t addr = get_cl_pair_addr(nvp);
> +    copy_struct(qts, cl_pair, addr, XIVE_REPORT_SIZE);
> +}
> +
> +static void get_cl_pair(QTestState *qts, Xive2Nvp *nvp, uint8_t *cl_pair)
> +{
> +    uint64_t addr = get_cl_pair_addr(nvp);
> +    get_struct(qts, addr, cl_pair, XIVE_REPORT_SIZE);
> +}
> +
> +static void set_nvp(QTestState *qts, uint32_t index, uint8_t first)
> +{
> +    uint64_t nvp_addr;
> +    Xive2Nvp nvp;
> +    uint64_t report_addr;
> +
> +    nvp_addr = XIVE_NVP_MEM + index * sizeof(Xive2Nvp);
> +    report_addr = (XIVE_REPORT_MEM + index * XIVE_REPORT_SIZE) >> 8;
> +
> +    memset(&nvp, 0, sizeof(nvp));
> +    nvp.w0 = xive_set_field32(NVP2_W0_VALID, 0, 1);
> +    nvp.w0 = xive_set_field32(NVP2_W0_PGOFIRST, nvp.w0, first);
> +    nvp.w6 = xive_set_field32(NVP2_W6_REPORTING_LINE, nvp.w6,
> +                              (report_addr >> 24) & 0xfffffff);
> +    nvp.w7 = xive_set_field32(NVP2_W7_REPORTING_LINE, nvp.w7,
> +                              report_addr & 0xffffff);
> +    copy_struct(qts, &nvp, nvp_addr, sizeof(nvp));
> +}
> +
> +static void set_nvg(QTestState *qts, uint32_t index, uint8_t next)
> +{
> +    uint64_t nvg_addr;
> +    Xive2Nvgc nvg;
> +
> +    nvg_addr = XIVE_NVG_MEM + index * sizeof(Xive2Nvgc);
> +
> +    memset(&nvg, 0, sizeof(nvg));
> +    nvg.w0 = xive_set_field32(NVGC2_W0_VALID, 0, 1);
> +    nvg.w0 = xive_set_field32(NVGC2_W0_PGONEXT, nvg.w0, next);
> +    copy_struct(qts, &nvg, nvg_addr, sizeof(nvg));
> +}
> +
> +static void set_eas(QTestState *qts, uint32_t index, uint32_t end_index,
> +                    uint32_t data)
> +{
> +    uint64_t eas_addr;
> +    Xive2Eas eas;
> +
> +    eas_addr = XIVE_EAS_MEM + index * sizeof(Xive2Eas);
> +
> +    memset(&eas, 0, sizeof(eas));
> +    eas.w = xive_set_field64(EAS2_VALID, 0, 1);
> +    eas.w = xive_set_field64(EAS2_END_INDEX, eas.w, end_index);
> +    eas.w = xive_set_field64(EAS2_END_DATA, eas.w, data);
> +    copy_struct(qts, &eas, eas_addr, sizeof(eas));
> +}
> +
> +static void set_end(QTestState *qts, uint32_t index, uint32_t nvp_index,
> +                    uint8_t priority, bool i)
> +{
> +    uint64_t end_addr, queue_addr, queue_hi, queue_lo;
> +    uint8_t queue_size;
> +    Xive2End end;
> +
> +    end_addr = XIVE_END_MEM + index * sizeof(Xive2End);
> +    queue_addr = get_queue_addr(index);
> +    queue_hi = (queue_addr >> 32) & END2_W2_EQ_ADDR_HI;
> +    queue_lo = queue_addr & END2_W3_EQ_ADDR_LO;
> +    queue_size = __builtin_ctz(XIVE_QUEUE_SIZE) - 12;
> +
> +    memset(&end, 0, sizeof(end));
> +    end.w0 = xive_set_field32(END2_W0_VALID, 0, 1);
> +    end.w0 = xive_set_field32(END2_W0_ENQUEUE, end.w0, 1);
> +    end.w0 = xive_set_field32(END2_W0_UCOND_NOTIFY, end.w0, 1);
> +    end.w0 = xive_set_field32(END2_W0_BACKLOG, end.w0, 1);
> +
> +    end.w1 = xive_set_field32(END2_W1_GENERATION, 0, 1);
> +
> +    end.w2 = cpu_to_be32(queue_hi);
> +
> +    end.w3 = cpu_to_be32(queue_lo);
> +    end.w3 = xive_set_field32(END2_W3_QSIZE, end.w3, queue_size);
> +
> +    end.w6 = xive_set_field32(END2_W6_IGNORE, 0, i);
> +    end.w6 = xive_set_field32(END2_W6_VP_OFFSET, end.w6, nvp_index);
> +
> +    end.w7 = xive_set_field32(END2_W7_F0_PRIORITY, 0, priority);
> +    copy_struct(qts, &end, end_addr, sizeof(end));
> +}

Are you going to re-use all these functions in other .c files later? If yes, 
please don't use such generic names like "copy_struct()" for functions in 
header files. Otherwise, please put this stuff into the .c file instead (at 
least the last functions are rather big already, so they don't look like 
good candidate for inlineable functions from a header anyway).

> +#endif /* TEST_PNV_XIVE2_COMMON_H */
> diff --git a/tests/qtest/pnv-xive2-flush-sync.h b/tests/qtest/pnv-xive2-flush-sync.h
> new file mode 100644
> index 0000000000..21d18ad9a7
> --- /dev/null
> +++ b/tests/qtest/pnv-xive2-flush-sync.h

Please add at least a short license statement here, too.

> @@ -0,0 +1,194 @@
> +#ifndef TEST_PNV_XIVE2_FLUSH_SYNC_H
> +#define TEST_PNV_XIVE2_FLUSH_SYNC_H
> +
> +#include "pnv-xive2-common.h"
> +
> +#define PNV_XIVE2_QUEUE_IPI              0x00
> +#define PNV_XIVE2_QUEUE_HW               0x01
> +#define PNV_XIVE2_QUEUE_NXC              0x02
> +#define PNV_XIVE2_QUEUE_INT              0x03
> +#define PNV_XIVE2_QUEUE_OS               0x04
> +#define PNV_XIVE2_QUEUE_POOL             0x05
> +#define PNV_XIVE2_QUEUE_HARD             0x06
> +#define PNV_XIVE2_CACHE_ENDC             0x08
> +#define PNV_XIVE2_CACHE_ESBC             0x09
> +#define PNV_XIVE2_CACHE_EASC             0x0a
> +#define PNV_XIVE2_QUEUE_NXC_LD_LCL_NCO   0x10
> +#define PNV_XIVE2_QUEUE_NXC_LD_LCL_CO    0x11
> +#define PNV_XIVE2_QUEUE_NXC_ST_LCL_NCI   0x12
> +#define PNV_XIVE2_QUEUE_NXC_ST_LCL_CI    0x13
> +#define PNV_XIVE2_QUEUE_NXC_ST_RMT_NCI   0x14
> +#define PNV_XIVE2_QUEUE_NXC_ST_RMT_CI    0x15
> +#define PNV_XIVE2_CACHE_NXC              0x18
> +
> +#define PNV_XIVE2_SYNC_IPI              0x000
> +#define PNV_XIVE2_SYNC_HW               0x080
> +#define PNV_XIVE2_SYNC_NxC              0x100
> +#define PNV_XIVE2_SYNC_INT              0x180
> +#define PNV_XIVE2_SYNC_OS_ESC           0x200
> +#define PNV_XIVE2_SYNC_POOL_ESC         0x280
> +#define PNV_XIVE2_SYNC_HARD_ESC         0x300
> +#define PNV_XIVE2_SYNC_NXC_LD_LCL_NCO   0x800
> +#define PNV_XIVE2_SYNC_NXC_LD_LCL_CO    0x880
> +#define PNV_XIVE2_SYNC_NXC_ST_LCL_NCI   0x900
> +#define PNV_XIVE2_SYNC_NXC_ST_LCL_CI    0x980
> +#define PNV_XIVE2_SYNC_NXC_ST_RMT_NCI   0xA00
> +#define PNV_XIVE2_SYNC_NXC_ST_RMT_CI    0xA80
> +
> +static uint64_t get_sync_addr(uint32_t src_pir, int ic_topo_id, int type)
> +{
> +    int thread_nr = src_pir & 0x7f;
> +    uint64_t addr = XIVE_SYNC_MEM +  thread_nr * 512 + ic_topo_id * 32 + type;
> +    return addr;
> +}
> +
> +static uint8_t get_sync(QTestState *qts, uint32_t src_pir, int ic_topo_id,
> +                        int type)
> +{
> +    uint64_t addr = get_sync_addr(src_pir, ic_topo_id, type);
> +    return qtest_readb(qts, addr);
> +}
> +
> +static void clr_sync(QTestState *qts, uint32_t src_pir, int ic_topo_id,
> +                        int type)
> +{
> +    uint64_t addr = get_sync_addr(src_pir, ic_topo_id, type);
> +    qtest_writeb(qts, addr, 0x0);
> +}
> +
> +static void inject_cache_flush(QTestState *qts, int ic_topo_id,
> +                               uint64_t scom_addr)
> +{
> +    (void)ic_topo_id;
> +    pnv_xive_xscom_write(qts, scom_addr, 0);
> +}
> +
> +static void inject_queue_sync(QTestState *qts, int ic_topo_id, uint64_t offset)
> +{
> +    (void)ic_topo_id;
> +    uint64_t addr = XIVE_IC_ADDR + (VST_SYNC << XIVE_PAGE_SHIFT) + offset;
> +    qtest_writeq(qts, addr, 0);
> +}
> +
> +static void inject_op(QTestState *qts, int ic_topo_id, int type)
> +{
> +    switch (type) {
> +    case PNV_XIVE2_QUEUE_IPI:
> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_IPI);
> +        break;
> +    case PNV_XIVE2_QUEUE_HW:
> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_HW);
> +        break;
> +    case PNV_XIVE2_QUEUE_NXC:
> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_NxC);
> +        break;
> +    case PNV_XIVE2_QUEUE_INT:
> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_INT);
> +        break;
> +    case PNV_XIVE2_QUEUE_OS:
> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_OS_ESC);
> +        break;
> +    case PNV_XIVE2_QUEUE_POOL:
> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_POOL_ESC);
> +        break;
> +    case PNV_XIVE2_QUEUE_HARD:
> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_HARD_ESC);
> +        break;
> +    case PNV_XIVE2_CACHE_ENDC:
> +        inject_cache_flush(qts, ic_topo_id, X_VC_ENDC_FLUSH_INJECT);
> +        break;
> +    case PNV_XIVE2_CACHE_ESBC:
> +        inject_cache_flush(qts, ic_topo_id, X_VC_ESBC_FLUSH_INJECT);
> +        break;
> +    case PNV_XIVE2_CACHE_EASC:
> +        inject_cache_flush(qts, ic_topo_id, X_VC_EASC_FLUSH_INJECT);
> +        break;
> +    case PNV_XIVE2_QUEUE_NXC_LD_LCL_NCO:
> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_NXC_LD_LCL_NCO);
> +        break;
> +    case PNV_XIVE2_QUEUE_NXC_LD_LCL_CO:
> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_NXC_LD_LCL_CO);
> +        break;
> +    case PNV_XIVE2_QUEUE_NXC_ST_LCL_NCI:
> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_NXC_ST_LCL_NCI);
> +        break;
> +    case PNV_XIVE2_QUEUE_NXC_ST_LCL_CI:
> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_NXC_ST_LCL_CI);
> +        break;
> +    case PNV_XIVE2_QUEUE_NXC_ST_RMT_NCI:
> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_NXC_ST_RMT_NCI);
> +        break;
> +    case PNV_XIVE2_QUEUE_NXC_ST_RMT_CI:
> +        inject_queue_sync(qts, ic_topo_id, PNV_XIVE2_SYNC_NXC_ST_RMT_CI);
> +        break;
> +    case PNV_XIVE2_CACHE_NXC:
> +        inject_cache_flush(qts, ic_topo_id, X_PC_NXC_FLUSH_INJECT);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +        break;
> +    }
> +}
> +
> +const uint8_t xive_inject_tests[] = {
> +    PNV_XIVE2_QUEUE_IPI,
> +    PNV_XIVE2_QUEUE_HW,
> +    PNV_XIVE2_QUEUE_NXC,
> +    PNV_XIVE2_QUEUE_INT,
> +    PNV_XIVE2_QUEUE_OS,
> +    PNV_XIVE2_QUEUE_POOL,
> +    PNV_XIVE2_QUEUE_HARD,
> +    PNV_XIVE2_CACHE_ENDC,
> +    PNV_XIVE2_CACHE_ESBC,
> +    PNV_XIVE2_CACHE_EASC,
> +    PNV_XIVE2_QUEUE_NXC_LD_LCL_NCO,
> +    PNV_XIVE2_QUEUE_NXC_LD_LCL_CO,
> +    PNV_XIVE2_QUEUE_NXC_ST_LCL_NCI,
> +    PNV_XIVE2_QUEUE_NXC_ST_LCL_CI,
> +    PNV_XIVE2_QUEUE_NXC_ST_RMT_NCI,
> +    PNV_XIVE2_QUEUE_NXC_ST_RMT_CI,
> +    PNV_XIVE2_CACHE_NXC,
> +};
> +
> +static void test_flush_sync_inject(QTestState *qts)
> +{
> +    int ic_topo_id = 0;
> +
> +    /*
> +     * Writes performed by qtest are not done in the context of a thread.
> +     * This means that QEMU XIVE code doesn't have a way to determine what
> +     * thread is originating the write.  In order to allow for some testing,
> +     * QEMU XIVE code will assume a PIR of 0 when unable to determine the
> +     * source thread for cache flush and queue sync inject operations.
> +     * See hw/intc/pnv_xive2.c: pnv_xive2_inject_notify() for details.
> +     */
> +    int src_pir = 0;
> +    int test_nr;
> +    uint8_t byte;
> +
> +    printf("# ============================================================\n");
> +    printf("# Starting cache flush/queue sync injection tests...\n");
> +
> +    for (test_nr = 0; test_nr < sizeof(xive_inject_tests);
> +         test_nr++) {
> +        int op_type = xive_inject_tests[test_nr];
> +
> +        printf("# Running test %d\n", test_nr);
> +
> +        /* start with status byte set to 0 */
> +        clr_sync(qts, src_pir, ic_topo_id, op_type);
> +        byte = get_sync(qts, src_pir, ic_topo_id, op_type);
> +        g_assert_cmphex(byte, ==, 0);
> +
> +        /* request cache flush or queue sync operation */
> +        inject_op(qts, ic_topo_id, op_type);
> +
> +        /* verify that status byte was written to 0xff */
> +        byte = get_sync(qts, src_pir, ic_topo_id, op_type);
> +        g_assert_cmphex(byte, ==, 0xff);
> +
> +        clr_sync(qts, src_pir, ic_topo_id, op_type);
> +    }
> +}

That also does not look like proper content for a header file. Please put it 
into a .c file instead.

> +#endif /* TEST_PNV_XIVE2_FLUSH_SYNC_H */
> diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
> new file mode 100644
> index 0000000000..471512dccd
> --- /dev/null
> +++ b/tests/qtest/pnv-xive2-test.c
> @@ -0,0 +1,351 @@
> +/*
> + * QTest testcase for PowerNV 10 interrupt controller (xive2)
> + *
> + * Copyright (c) 2023, IBM Corporation.

Maybe update to 2024 ?

> + * This work is licensed under the terms of the GNU GPL, version 2 or
> +A * later. See the COPYING file in the top-level directory.

Misplaced "A" at the beginning of the line.

  Thomas


