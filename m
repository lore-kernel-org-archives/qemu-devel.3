Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6313FCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIiX-0004uF-K3; Tue, 04 Nov 2025 10:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vGIiV-0004tj-2k
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:13:03 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vGIiT-00011q-Ba
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:13:02 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-44f6c663452so1137552b6e.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 07:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762269180; x=1762873980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wGemEhcrpGKA4eRbEVkDZAuRtZYzqfqUGBeTEb4mjzo=;
 b=mPZHwVk5EXkMRcAEjJfNfqkxQufhGr1t8vtM1ee/W+NroShcy5qNXD7bE0jg7yZldp
 InYkz6SbPPIjBIt4GV37F1iEQgVtrxlcMPjRLJzd/oXAQoaJtUdOntFlUh8hI2XqpsYY
 rHMQeMGp8Tk6CW3YK6rylorqPyiFWrFZHzPxQe5yiAxXq3a2E1YUHZmwhmpFV+U5GCOE
 2I0+rWBPuszAQuGlDBoW4SJymK5Sh4Ad+sBzK4B6PAg8fknNNm22J+o3N/GekXasEkjb
 Rw4V8VDSKtuCKqkri9kXP4YNLQz/m91tSZjTeUpkAmheT09JynAj4opNbtRYKR1Fy64z
 gt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762269180; x=1762873980;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wGemEhcrpGKA4eRbEVkDZAuRtZYzqfqUGBeTEb4mjzo=;
 b=EaXPCa64gzwpWLbYEy9Lpj44qTmfv+M02ODQoPoiszYw5DwDiI7L2fSzts3QQIBZX4
 52A4U6tRgmm951L3KvNEZz873ApfmKPAoITPenxoPyoMdzKVv5AET+roQmxZvRQS9l4F
 SDBhv0z44zZ1GN/GDBIjQHcFV6GPyiN+diGszhsZWIKfwNQGDKuJ5hWTuFf3u9/WsdeK
 5ZXAcbhLVKqEjRSvpQKZ+FcGcsYoC0Gq88Pnq7k6SvScTFR4lL96ahdybOtkqJQPgGrh
 W6BWPP4PBCe56YmVRe9dUS97F90ls9m6J6jPsEFV/jwymmYHLCUUeLGKBNp6MQ0MQCY8
 nGSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUA0uIldj1X0Kmv5ZMa4SUQxrNHAuL8aV8N6k8b2QNOPNbrPQ1XJtw0sBQdm0imKeSVNULSsWf3CPN@nongnu.org
X-Gm-Message-State: AOJu0YyzAR/ex+5baBp3covYVKYcRIbdWclxLErNr6r1+nX6ve7ZnE9X
 lggdN32Vj5rUuQrzLBVWMxTrxCS5qasMcYTOzCNA00WxyMyBwlL60XZorzKXAsrHW9Q=
X-Gm-Gg: ASbGncvmBF/uGvxoeysoMPLZ+MG/FWfNZ3342NR6CM2pAob9gASIQzQtXBIBWQttG5O
 HHvK3Sj/+PaQ/RSb4cidkpjurh3tTnB2UgOre6bmcJZkxU5jwmbqe6+umIVDuxAjveZKMvdm3TH
 ntHtmXKlo5SgerlDtw50uxcxpDY4uEHg0kBGKn5PRSQpN6PLYdGCr4vtoXJf0aOyML2nVEimeya
 gE0nrqealZfe0EwkX3hMwOKejW1GTkt0iyYiIPXKsf0MH072fDpzwS49+O9prqB6HOpi1NlGQDN
 XirEigIKKS3sXtA56CwUCwwnozeh9mINpm6kmMoQ3QP/5/4tTXkRksZjgYJ7RLVpUaIKN3/gNmT
 hoiO/vb1x7AtOJanf5KHEW52DLMltE6byCcGrKDna6G95mMy7I9MufZFmIMbApm659oyoMDMXar
 2uZF3HfE949jhF
X-Google-Smtp-Source: AGHT+IHyVgyl/Q2wJkZ0asHz5cj7xtepVhfOT8TskfTMdzvAaTkZF5OvLdKZvd6tTP8vRlbQB8xjNw==
X-Received: by 2002:a05:6808:23cd:b0:43d:24b7:2b93 with SMTP id
 5614622812f47-44f95eb8411mr7378988b6e.17.1762269179923; 
 Tue, 04 Nov 2025 07:12:59 -0800 (PST)
Received: from [192.168.68.110] ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-44fde2810dcsm469943b6e.4.2025.11.04.07.12.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 07:12:58 -0800 (PST)
Message-ID: <a6e5f685-4bfc-4e13-b0b7-860fc0630b9e@ventanamicro.com>
Date: Tue, 4 Nov 2025 12:12:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] riscv: Update MIPS vendor id
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20251104150708.3345289-1-djordje.todorovic@htecgroup.com>
 <20251104150708.3345289-2-djordje.todorovic@htecgroup.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251104150708.3345289-2-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22b.google.com
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



On 11/4/25 12:07 PM, Djordje Todorovic wrote:
> According to MIPS programming guide, the id is 0x127.
> A patch for this has been sent on Linux mailing list as well.
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> ---
>   target/riscv/cpu_vendorid.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
> index 28f0ce9370..f1ffc66542 100644
> --- a/target/riscv/cpu_vendorid.h
> +++ b/target/riscv/cpu_vendorid.h
> @@ -2,7 +2,7 @@
>   #define TARGET_RISCV_CPU_VENDORID_H
>   
>   #define THEAD_VENDOR_ID         0x5b7
> -#define MIPS_VENDOR_ID          0x722
> +#define MIPS_VENDOR_ID          0x127

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   
>   #define VEYRON_V1_MARCHID       0x8000000000010000
>   #define VEYRON_V1_MIMPID        0x111


