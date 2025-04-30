Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EB6C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 09:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA4DD-0005vI-Fl; Wed, 30 Apr 2025 05:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA4DA-0005ux-DL
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 05:58:40 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA4D7-0006gw-Ey
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 05:58:40 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7c5c815f8efso728457985a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 02:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746007116; x=1746611916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zRhF/wd9ISidKShbz5/csM4Mc8Oih4/gaQ9oq52UKW0=;
 b=kKTgKz2mWqUT7OlmgebMcHb0PhU9ijxjDXsZzj2PyaeK13HOb6eMcJuQxVAKRcvhj8
 IPEaToRGOnhfsUKg45KMrpTyroaNPKIt1MgAs0ckHdkNWqEczuqX4CJb849zkCiXhpes
 8ohJRN/BZeb4NjH4Ee0+wHXmrm1/efikIFh/Nr9hK/pHrxGFs3nS2X+vgIURZfj/ESP7
 XjEe/O5nhRbYBX+Im3cyRSmPpiENTSe2LCGsPIK33gMyaizlj/ZHOiEfgp5cDJOciZVr
 jSSL/6UQwoOUPseay7HcYlVWOL38tfI5wAOuelrCUslU2jI0EBXuF5w3XvQaLTm/cuiQ
 94hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746007116; x=1746611916;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zRhF/wd9ISidKShbz5/csM4Mc8Oih4/gaQ9oq52UKW0=;
 b=BLjgRz9/ql5EkOy3Ei64ITTq4lhfqhE5vCYc6eaQKqS3gaqV312I3yBTyZUDV7C2El
 ZGvFCt+jm6h8dRJJoa2OXSvNp0nWwkcT7OEtq33r/SHr5+Ii8Tw4g/LmNlvCoRMNhns5
 +EGS/oGA/uwzlKmD5+8WaZk47xHzj5nSfLY9ccwK4i3tkHV8sGeKL/6QU8bMYSL9kCn7
 hyY6JSsHl2OfECDq107/PgmgoEaeO3VHfph2TZ/knI3ftJFwfnNdEeQD1SrDichy52Kx
 Og7R4DDjMX8bJ7Yd1lebajGV5ezYIRCysbzvri8gfkw2Ia2lQIM4unyMXUB6SjGPJqFN
 AxgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIb+rIZfi767JMvfZ4b2N0PlLp7BC4rHi7OnlScC1K3wPPzD1BpEi/KqaMl+tErgcTqNM5bzDXCAEh@nongnu.org
X-Gm-Message-State: AOJu0Yw6xudTG4uEXNl52BtBNqDQ/oDUME1HiM1VKt4m0RCCbNkWfZ9d
 nl7mvMQPW3/jC8oJn4rtiaJbC8sLCsDaJiRdNRWKug53IYePghc7iS4lL/bTEKY=
X-Gm-Gg: ASbGncu7OK+1+8Y5TJDgvO7PtF1Deos9p+odPHtfu9O1DqrHcANO6jX9Gbtgu9jv28o
 CdnUBdfUJSVCPURlFpYVsGRvqOy8JWJhiCnIo5RvJ8t+F5jwAQQphyeqkHpNeFOf5pAA+easHun
 0Q/fAJpoFEdT8+PiaGcZ/mlpXXQG+bc8B+FM6LE5JBFRXKwc0Gr+8rDw+g8MbOzGzwyyQI9oOHE
 S5LWcONJzsqaW/aiOBEIIrGfE/BrTqhl3SAWWYrT2JIUE2rN9GUeKLmfdbHTCENTTipiTxSmmek
 emrdVxs8TZcxValVlBc59UnsZZ+Ou9nW/fXJBvtbHjDoyP4Z9I1O37Eh1H6bXERwHefkaT5W50F
 P09WR+7JrLCEjUHXqlpnkVXb+
X-Google-Smtp-Source: AGHT+IGtRIv9Ax20qnJDqLo/yYO23bRzXeLS39Tns35yJaQTuK0X7atfbRil13RC+VB2TT0nGLCKNw==
X-Received: by 2002:a05:620a:916a:b0:7ca:ca21:23b8 with SMTP id
 af79cd13be357-7caca21258fmr119876285a.7.1746007115650; 
 Wed, 30 Apr 2025 02:58:35 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c958cadb0asm835595985a.30.2025.04.30.02.58.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 02:58:35 -0700 (PDT)
Message-ID: <15227d0a-c459-4bea-bec7-13dc88d22c3c@linaro.org>
Date: Wed, 30 Apr 2025 11:58:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] system: optimizing info mtree printing for monitors
To: Chao Liu <lc00631@tecorigin.com>, pbonzini@redhat.com, peterx@redhat.com, 
 david@redhat.com
Cc: zhangtj@tecorigin.com, zqz00548@tecorigin.com, qemu-devel@nongnu.org
References: <cover.1746003314.git.lc00631@tecorigin.com>
 <6b3567672da9d5778c18a32ee1306aaed884463c.1746003314.git.lc00631@tecorigin.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6b3567672da9d5778c18a32ee1306aaed884463c.1746003314.git.lc00631@tecorigin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x72f.google.com
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

Hi Chao,

On 30/4/25 11:02, Chao Liu wrote:
> Make the hierarchical relationship between nodes clearer by adding characters

W.r.t. $Subject, it isn't really about "optimization" but making
output clearer, as you describe.

> 
> e.g.
> 
> qemu-system-riscv64 -M virt -monitor stdio -display none
> 
> ```
> (qemu) info mtree
> ...
> memory-region: system
> │  ├── 0000000000000000-ffffffffffffffff (prio 0, i/o): system
> │  │   ├── 0000000003000000-000000000300ffff (prio 0, i/o): gpex_ioport_window
> │  │   │   └── 0000000003000000-000000000300ffff (prio 0, i/o): gpex_ioport
> ...
> │  │   └── 0000000400000000-00000007ffffffff (prio 0, i/o): alias ...
> ```
> 
> Signed-off-by: Chao Liu <lc00631@tecorigin.com>
> Reviewed-by: Qingze Zhao <zqz00548@tecorigin.com>
> Reviewed-by: Tingjian Zhang <zhangtj@tecorigin.com>
> ---
>   system/memory.c | 36 ++++++++++++++++++++++++++++++------
>   1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 71434e7ad0..cf91718bcc 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -3296,6 +3296,21 @@ typedef QTAILQ_HEAD(, MemoryRegionList) MemoryRegionListHead;
>                              int128_sub((size), int128_one())) : 0)
>   #define MTREE_INDENT "  "
>   
> +enum mtree_node_type {
> +    MTREE_NODE_T_INNER,
> +    MTREE_NODE_T_TAIL,
> +};
> +
> +static void mtree_print_node(enum mtree_node_type is_tail)

Either rename 'is_tail' as 'node_type', or really use a boolean
(maybe '[is_]last_node' is clearer?), since the mtree_node_type enum
doesn't bring much (see [*] below).

> +{
> +    qemu_printf((is_tail == MTREE_NODE_T_TAIL) ? "└── " : "├── ");
> +}
> +
> +static void mtree_print_col(unsigned level)
> +{
> +    qemu_printf(level ? "│   " : "│  ");
> +}
> +
>   static void mtree_expand_owner(const char *label, Object *obj)
>   {
>       DeviceState *dev = (DeviceState *) object_dynamic_cast(obj, TYPE_DEVICE);
> @@ -3335,7 +3350,8 @@ static void mtree_print_mr_owner(const MemoryRegion *mr)
>   static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
>                              hwaddr base,
>                              MemoryRegionListHead *alias_print_queue,
> -                           bool owner, bool display_disabled)
> +                           bool owner, bool display_disabled,
> +                           enum mtree_node_type node_type)
 >   {>       MemoryRegionList *new_ml, *ml, *next_ml;
>       MemoryRegionListHead submr_print_queue;
> @@ -3376,8 +3392,9 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
>           }
>           if (mr->enabled || display_disabled) {
>               for (i = 0; i < level; i++) {
> -                qemu_printf(MTREE_INDENT);
> +                mtree_print_col(i);
>               }
> +            mtree_print_node(node_type);
>               qemu_printf(HWADDR_FMT_plx "-" HWADDR_FMT_plx
>                           " (prio %d, %s%s): alias %s @%s " HWADDR_FMT_plx
>                           "-" HWADDR_FMT_plx "%s",
> @@ -3398,8 +3415,9 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
>       } else {
>           if (mr->enabled || display_disabled) {
>               for (i = 0; i < level; i++) {
> -                qemu_printf(MTREE_INDENT);
> +                mtree_print_col(i);
>               }
> +            mtree_print_node(node_type);
>               qemu_printf(HWADDR_FMT_plx "-" HWADDR_FMT_plx
>                           " (prio %d, %s%s): %s%s",
>                           cur_start, cur_end,
> @@ -3435,8 +3453,12 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
>       }
>   
>       QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
> +        if (ml == QTAILQ_LAST(&submr_print_queue)) {
> +            node_type = MTREE_NODE_T_TAIL;
> +        }
>           mtree_print_mr(ml->mr, level + 1, cur_start,
> -                       alias_print_queue, owner, display_disabled);
> +                       alias_print_queue, owner,
> +                       display_disabled, node_type);
>       }
>   
>       QTAILQ_FOREACH_SAFE(ml, &submr_print_queue, mrqueue, next_ml) {
> @@ -3614,7 +3636,8 @@ static void mtree_print_as(gpointer key, gpointer value, gpointer user_data)
>       struct AddressSpaceInfo *asi = user_data;
>   
>       g_slist_foreach(as_same_root_mr_list, mtree_print_as_name, NULL);
> -    mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled);
> +    mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled,
> +                   MTREE_NODE_T_INNER);
>       qemu_printf("\n");
>   }
>   
> @@ -3659,7 +3682,8 @@ static void mtree_info_as(bool dispatch_tree, bool owner, bool disabled)
>       /* print aliased regions */
>       QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
>           qemu_printf("memory-region: %s\n", memory_region_name(ml->mr));
> -        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled);
> +        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled,
> +                       MTREE_NODE_T_INNER);
>           qemu_printf("\n");
>       }
>   

Trying this patch:

$ ./qemu-system-aarch64 -S -monitor stdio -M raspi4b
QEMU 10.0.50 monitor - type 'help' for more information
(qemu) info mtree
address-space: cpu-memory-0
address-space: cpu-memory-1
address-space: cpu-memory-2
address-space: cpu-memory-3
address-space: cpu-secure-memory-0
address-space: cpu-secure-memory-1
address-space: cpu-secure-memory-2
address-space: cpu-secure-memory-3
address-space: memory
│  ├── 0000000000000000-ffffffffffffffff (prio 0, i/o): system
│  │   ├── 0000000000000000-000000007fffffff (prio 0, ram): ram
│  │   ├── 00000000fc000000-00000000fdffffff (prio 1, i/o): 
bcm2838-peripherals
│  │   ├── 00000000fe000000-00000000ff7fffff (prio 1, i/o): 
bcm2835-peripherals
│  │   │   ├── 00000000fe003000-00000000fe00301f (prio 0, i/o): 
bcm2835-sys-timer
│  │   │   ├── 00000000fe004000-00000000fe004fff (prio -1000, i/o): 
bcm2835-txp
│  │   │   ├── 00000000fe007000-00000000fe007fff (prio 0, i/o): bcm2835-dma
│  │   │   ├── 00000000fe00a000-00000000fe00a023 (prio -1000, i/o): 
bcm2838-asb
│  │   │   ├── 00000000fe00b200-00000000fe00b3ff (prio 0, i/o): alias 
mphi @mphi 0000000000000000-00000000000001ff
│  │   │   ├── 00000000fe00b200-00000000fe00b3ff (prio 0, i/o): bcm2835-ic
│  │   │   ├── 00000000fe00b400-00000000fe00b43f (prio -1000, i/o): 
bcm2835-sp804
│  │   │   ├── 00000000fe00b800-00000000fe00bbff (prio 0, i/o): bcm2835-mbox
│  │   │   ├── 00000000fe100000-00000000fe1001ff (prio 0, i/o): 
bcm2835-powermgt
│  │   │   ├── 00000000fe101000-00000000fe102fff (prio 0, i/o): 
bcm2835-cprman
│  │   │   ├── 00000000fe200000-00000000fe200fff (prio 0, i/o): bcm2838_gpio
│  │   │   ├── 00000000fe201000-00000000fe201fff (prio 0, i/o): pl011
│  │   │   ├── 00000000fe202000-00000000fe202fff (prio 0, i/o): 
bcm2835-sdhost
│  │   │   ├── 00000000fe203000-00000000fe2030ff (prio -1000, i/o): 
bcm2835-i2s
│  │   │   ├── 00000000fe204000-00000000fe204017 (prio 0, i/o): bcm2835-spi
│  │   │   ├── 00000000fe205000-00000000fe205023 (prio 0, i/o): bcm2835-i2c
│  │   │   ├── 00000000fe20f000-00000000fe20f07f (prio 0, i/o): bcm2835-otp
│  │   │   ├── 00000000fe214000-00000000fe2140ff (prio -1000, i/o): 
bcm2835-spis
│  │   │   ├── 00000000fe215000-00000000fe2150ff (prio 0, i/o): bcm2835-aux
│  │   │   ├── 00000000fe300000-00000000fe3000ff (prio 0, i/o): sdhci
│  │   │   ├── 00000000fe340000-00000000fe3400ff (prio 0, i/o): sdhci
│  │   │   ├── 00000000fe600000-00000000fe6000ff (prio -1000, i/o): 
bcm2835-smi
│  │   │   ├── 00000000fe804000-00000000fe804023 (prio 0, i/o): bcm2835-i2c
│  │   │   ├── 00000000fe805000-00000000fe805023 (prio 0, i/o): bcm2835-i2c
│  │   │   ├── 00000000fe900000-00000000fe907fff (prio -1000, i/o): 
bcm2835-dbus
│  │   │   ├── 00000000fe910000-00000000fe917fff (prio -1000, i/o): 
bcm2835-ave0
│  │   │   ├── 00000000fe980000-00000000fe990fff (prio 0, i/o): dwc2
│  │   │   │   ├── 00000000fe980000-00000000fe980fff (prio 0, i/o): dwc2-io
│  │   │   │   └── 00000000fe981000-00000000fe990fff (prio 0, i/o): 
dwc2-fifo
│  │   │   ├── 00000000fec00000-00000000fec00fff (prio -1000, i/o): 
bcm2835-v3d
│  │   │   ├── 00000000fec11000-00000000fec110ff (prio -1000, i/o): 
bcm2835-clkisp
│  │   │   ├── 00000000fee00000-00000000fee000ff (prio -1000, i/o): 
bcm2835-sdramc
│  │   │   └── 00000000fee05000-00000000fee050ff (prio 0, i/o): 
bcm2835-dma-chan15
│  │   ├── 00000000ff800000-00000000ff8000ff (prio 0, i/o): bcm2836-control
│  │   ├── 00000000ff841000-00000000ff841fff (prio 0, i/o): gic_dist
│  │   ├── 00000000ff842000-00000000ff843fff (prio 0, i/o): gic_cpu
│  │   ├── 00000000ff844000-00000000ff844fff (prio 0, i/o): gic_viface
│  │   ├── 00000000ff845000-00000000ff8450ff (prio 0, i/o): gic_cpu
│  │   ├── 00000000ff845200-00000000ff8452ff (prio 0, i/o): gic_cpu
│  │   ├── 00000000ff845400-00000000ff8454ff (prio 0, i/o): gic_cpu
│  │   ├── 00000000ff845600-00000000ff8456ff (prio 0, i/o): gic_cpu
│  │   └── 00000000ff846000-00000000ff847fff (prio 0, i/o): gic_vcpu

address-space: bcm2835-mbox-memory
│  ├── 0000000000000000-000000000000008f (prio 0, i/o): bcm2835-mbox
│  │   ├── 0000000000000010-000000000000001f (prio 0, i/o): bcm2835-fb
│  │   └── 0000000000000080-000000000000008f (prio 0, i/o): bcm2835-property

address-space: I/O
│  ├── 0000000000000000-000000000000ffff (prio 0, i/o): io

address-space: bcm2835-dma-memory
address-space: bcm2835-fb-memory
address-space: bcm2835-property-memory
address-space: dwc2
│  ├── 0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
│  │   ├── 0000000000000000-000000007fffffff (prio 0, ram): alias 
bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000007fffffff
│  │   ├── 0000000040000000-00000000bfffffff (prio 0, ram): alias 
bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000007fffffff
│  │   ├── 000000007c000000-000000007dffffff (prio 1, i/o): alias 
bcm2838-peripherals @bcm2838-peripherals 0000000000000000-0000000001ffffff
│  │   ├── 000000007e000000-000000007f7fffff (prio 1, i/o): alias 
bcm2835-peripherals @bcm2835-peripherals 0000000000000000-00000000017fffff
│  │   ├── 0000000080000000-00000000ffffffff (prio 0, ram): alias 
bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000007fffffff
│  │   └── 00000000c0000000-000000013fffffff (prio 0, ram): alias 
bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000007fffffff

memory-region: mphi
│  ├── 0000000000000000-0000000000000fff (prio 0, i/o): mphi

memory-region: ram
│  ├── 0000000000000000-000000007fffffff (prio 0, ram): ram

memory-region: bcm2838-peripherals
│  ├── 00000000fc000000-00000000fdffffff (prio 1, i/o): bcm2838-peripherals

memory-region: bcm2835-peripherals
│  ├── 00000000fe000000-00000000ff7fffff (prio 1, i/o): bcm2835-peripherals
│  │   ├── 00000000fe003000-00000000fe00301f (prio 0, i/o): 
bcm2835-sys-timer
│  │   ├── 00000000fe004000-00000000fe004fff (prio -1000, i/o): bcm2835-txp
│  │   ├── 00000000fe007000-00000000fe007fff (prio 0, i/o): bcm2835-dma
│  │   ├── 00000000fe00a000-00000000fe00a023 (prio -1000, i/o): bcm2838-asb
│  │   ├── 00000000fe00b200-00000000fe00b3ff (prio 0, i/o): alias mphi 
@mphi 0000000000000000-00000000000001ff
│  │   ├── 00000000fe00b200-00000000fe00b3ff (prio 0, i/o): bcm2835-ic
│  │   ├── 00000000fe00b400-00000000fe00b43f (prio -1000, i/o): 
bcm2835-sp804
│  │   ├── 00000000fe00b800-00000000fe00bbff (prio 0, i/o): bcm2835-mbox
│  │   ├── 00000000fe100000-00000000fe1001ff (prio 0, i/o): bcm2835-powermgt
│  │   ├── 00000000fe101000-00000000fe102fff (prio 0, i/o): bcm2835-cprman
│  │   ├── 00000000fe200000-00000000fe200fff (prio 0, i/o): bcm2838_gpio
│  │   ├── 00000000fe201000-00000000fe201fff (prio 0, i/o): pl011
│  │   ├── 00000000fe202000-00000000fe202fff (prio 0, i/o): bcm2835-sdhost
│  │   ├── 00000000fe203000-00000000fe2030ff (prio -1000, i/o): bcm2835-i2s
│  │   ├── 00000000fe204000-00000000fe204017 (prio 0, i/o): bcm2835-spi
│  │   ├── 00000000fe205000-00000000fe205023 (prio 0, i/o): bcm2835-i2c
│  │   ├── 00000000fe20f000-00000000fe20f07f (prio 0, i/o): bcm2835-otp
│  │   ├── 00000000fe214000-00000000fe2140ff (prio -1000, i/o): bcm2835-spis
│  │   ├── 00000000fe215000-00000000fe2150ff (prio 0, i/o): bcm2835-aux
│  │   ├── 00000000fe300000-00000000fe3000ff (prio 0, i/o): sdhci
│  │   ├── 00000000fe340000-00000000fe3400ff (prio 0, i/o): sdhci
│  │   ├── 00000000fe600000-00000000fe6000ff (prio -1000, i/o): bcm2835-smi
│  │   ├── 00000000fe804000-00000000fe804023 (prio 0, i/o): bcm2835-i2c
│  │   ├── 00000000fe805000-00000000fe805023 (prio 0, i/o): bcm2835-i2c
│  │   ├── 00000000fe900000-00000000fe907fff (prio -1000, i/o): bcm2835-dbus
│  │   ├── 00000000fe910000-00000000fe917fff (prio -1000, i/o): bcm2835-ave0
│  │   ├── 00000000fe980000-00000000fe990fff (prio 0, i/o): dwc2
│  │   │   ├── 00000000fe980000-00000000fe980fff (prio 0, i/o): dwc2-io
│  │   │   └── 00000000fe981000-00000000fe990fff (prio 0, i/o): dwc2-fifo
│  │   ├── 00000000fec00000-00000000fec00fff (prio -1000, i/o): bcm2835-v3d
│  │   ├── 00000000fec11000-00000000fec110ff (prio -1000, i/o): 
bcm2835-clkisp
│  │   ├── 00000000fee00000-00000000fee000ff (prio -1000, i/o): 
bcm2835-sdramc
│  │   └── 00000000fee05000-00000000fee050ff (prio 0, i/o): 
bcm2835-dma-chan15

(qemu)

1/ For leaves it is OK, but root branch looks odd being displayed all
    along without leaf.

2/ Why single region is displayed unfinished (├)? We shouldn't display
    any prefix at all, see:

address-space: I/O
│  ├── 0000000000000000-000000000000ffff (prio 0, i/o): io


[*] removing enum mtree_node_type:

-- >8 --
diff --git a/system/memory.c b/system/memory.c
index cf91718bcc1..20aa4a8e008 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3298,10 +3298,5 @@ typedef QTAILQ_HEAD(, MemoryRegionList) 
MemoryRegionListHead;

-enum mtree_node_type {
-    MTREE_NODE_T_INNER,
-    MTREE_NODE_T_TAIL,
-};
-
-static void mtree_print_node(enum mtree_node_type is_tail)
+static void mtree_print_node(bool last_node)
  {
-    qemu_printf((is_tail == MTREE_NODE_T_TAIL) ? "└── " : "├── ");
+    qemu_printf(last_node ? "└── " : "├── ");
  }
@@ -3353,3 +3348,3 @@ static void mtree_print_mr(const MemoryRegion *mr, 
unsigned int level,
                             bool owner, bool display_disabled,
-                           enum mtree_node_type node_type)
+                           bool last_node)
  {
@@ -3396,3 +3391,3 @@ static void mtree_print_mr(const MemoryRegion *mr, 
unsigned int level,
              }
-            mtree_print_node(node_type);
+            mtree_print_node(last_node);
              qemu_printf(HWADDR_FMT_plx "-" HWADDR_FMT_plx
@@ -3419,3 +3414,3 @@ static void mtree_print_mr(const MemoryRegion *mr, 
unsigned int level,
              }
-            mtree_print_node(node_type);
+            mtree_print_node(last_node);
              qemu_printf(HWADDR_FMT_plx "-" HWADDR_FMT_plx
@@ -3456,3 +3451,3 @@ static void mtree_print_mr(const MemoryRegion *mr, 
unsigned int level,
          if (ml == QTAILQ_LAST(&submr_print_queue)) {
-            node_type = MTREE_NODE_T_TAIL;
+            last_node = true;
          }
@@ -3460,3 +3455,3 @@ static void mtree_print_mr(const MemoryRegion *mr, 
unsigned int level,
                         alias_print_queue, owner,
-                       display_disabled, node_type);
+                       display_disabled, last_node);
      }
@@ -3638,4 +3633,3 @@ static void mtree_print_as(gpointer key, gpointer 
value, gpointer user_data)
      g_slist_foreach(as_same_root_mr_list, mtree_print_as_name, NULL);
-    mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled,
-                   MTREE_NODE_T_INNER);
+    mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled, 
false);
      qemu_printf("\n");
@@ -3684,4 +3678,3 @@ static void mtree_info_as(bool dispatch_tree, bool 
owner, bool disabled)
          qemu_printf("memory-region: %s\n", memory_region_name(ml->mr));
-        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled,
-                       MTREE_NODE_T_INNER);
+        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled, false);
          qemu_printf("\n");
---

