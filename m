Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCBEC61CE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 22:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyd0w-0004Bw-G7; Mon, 24 Aug 2026 18:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1wyd0v-0004Bg-8Z
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 18:19:33 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1wyd0t-0000SO-DT
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 18:19:33 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-384422b05b5so398445a91.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1787609970; x=1788214770; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8LR/AzYacYUAVCZRRgXI27j9+RnZQ7HCQTn2EGohg8M=;
 b=eIGY7TMgZR9Dy9AamYXfIp3Odf7gTPy++dPQpczfSXWoR0wAdYwloLZvTyf6zg805q
 6u9Ln6t7oU/5GCF4H0I9dTiI8I0dRT3Q9BqDTlwzRlQ9TpVT3YJ25sQXq0hZ8dGri4o8
 ZR0ZowU1TbfD5sOqKP/g65aOHGGIFk+HwvgigUi8UYh8RpfracZu03dpX8sI+PD/0CCb
 k+2M4je2N+++f7QWq6V1stUk+B0THSmtCavfdCjEEeME5stDFbol6Eyn8g/DP/0T8FDe
 60IgIiCvKhSJhNtvipxlIZ2/p3/ymz/TQiV4pHDvWWCyDu8RaeDIjaFsskDBj7kRLdY9
 SH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787609970; x=1788214770;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8LR/AzYacYUAVCZRRgXI27j9+RnZQ7HCQTn2EGohg8M=;
 b=igoTbk2c45/Bv0w5Igl+fpSi/2T5LFDsmiaDdnKfl0zZnINK6SY3s8HK4cctknMBZk
 tzrdGcK82okKYy9kzciYRdgTnr0YcpyIFR4XwhI98ds6sjuKz8VhBrdd1JWIlw+EP28a
 37aGIrbj4r9hr/aZQXl18j/ifFoxpVZ38WxQFb3DDuF3utkWeVv4R0XKAuDehdofQNWV
 I/5nH2pQR7MBJK+DvBvmTU2YoeWIEyASI+sNJfGkTznglJciIBoa3keNEZVfDuWi2b8K
 p2yaWqv8bRks9OhyjOXc+lH7zRuR5emI2xBMG/I4c25coH4CrqtW9T7CdqtW89tEMLyG
 zN3A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpdb0eeqD73kzzg9vH2cGiNr3x61y1q4TRQIUYlzDaqzeNAQTbACUgSG7iKcVaMkACU3EV/qg9xau44@nongnu.org
X-Gm-Message-State: AFuF++kKFzgXTtsbmys0ZpWCKbuR13fdZIK5EQ2rSVEgPnTHZ8CbAjzw
 H4kCyWQ05WvEjos3yTTsbdwKFeek3DUNUJigw03xSwpAZ0XFaGKwAbeI2fL9wOmzGgE=
X-Gm-Gg: AR+sD10b+u6SEL/+/3SMAwTxuIWn90k2q+BpVSDH0sq43WwB4NQvsPqsmBKrZtC0MWs
 VAw9p7eT9Tvamjyvx6kcwzmpgkfdOvqkQpbOr3+p8rHFVRlKBR3st45C960YlDF0w4igMesMK79
 KToUu/1Lg8TniwYrBRSjvUqFwYbRxdbfC1VocJ10ABlRnLLLivEpMPRSBhyCujuudDM77u1h5FM
 ehEXax6qy7hv6Hp5+14kqHGHlLpU4HRMW4/pjmLWyv9qs5AxS1wHT8bxM9+Z4rQZXLD85bpbeXK
 jCkoQY2hCOqnjdeRK9IVIPBqYoLfUcbMQmvXGVUDdg60KyBF2RXbRO4iLPGTqHk3KLVAakImheb
 KsA2yUe3vZcX0SY0iIQMzEUYPTrjDzn7N7kOrhIYQ3Cu+9lwTsyzj2ndTOCQjiBwViVbRK6FENy
 YQWpxJq5KJDz32ysBvZmpzZ/RHXqWSnwNSIOAofoi8ECSt8TLwq3XO0n+0PwzmamPy+dqCupzJy
 H3nU4ezeXctwKIK
X-Received: by 2002:a17:90b:2648:b0:38e:6a7c:abbc with SMTP id
 98e67ed59e1d1-39647bfad3emr1127785a91.3.1787609969703; 
 Mon, 24 Aug 2026 15:19:29 -0700 (PDT)
Received: from [172.16.1.33] ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645b3ab63sm1137844a91.7.2026.08.24.15.19.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 15:19:29 -0700 (PDT)
Message-ID: <ab3dba22-8ba4-479e-ad4a-1877335bb2dd@oss.tenstorrent.com>
Date: Tue, 25 Aug 2026 08:19:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/riscv/virt: Use hwaddr for IMSIC device tree
 address
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>, Niek Linnenbank
 <nieklinnenbank@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260824055642.41098-1-joel@jms.id.au>
 <20260824055642.41098-3-joel@jms.id.au>
Content-Language: en-US
From: Portia Stephens <portias@oss.tenstorrent.com>
In-Reply-To: <20260824055642.41098-3-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 24/8/2026 3:56 PM, Joel Stanley wrote:
> create_fdt_one_imsic() hard codes the top 32 bits to zero. Instead take
> a hwaddr and populate both the high and low cell.
>
> Suggested-by: Philippe Mathieu-Daudé <philmd@mailo.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   hw/riscv/virt.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Portia Stephens <portias@oss.tenstorrent.com>


>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d58656f70d1b..b91d5066d8ad 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -383,7 +383,8 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
>       g_autofree char *imsic_name = NULL;
>       MachineState *ms = MACHINE(s);
>       int socket_count = riscv_socket_count(ms);
> -    uint32_t imsic_max_hart_per_socket, imsic_addr, imsic_size;
> +    uint32_t imsic_max_hart_per_socket, imsic_size;
> +    hwaddr imsic_addr;
>       g_autofree uint32_t *imsic_cells = NULL;
>       g_autofree uint32_t *imsic_regs = NULL;
>       static const char * const imsic_compat[2] = {
> @@ -403,7 +404,7 @@ static void create_fdt_one_imsic(RISCVVirtState *s, hwaddr base_addr,
>           imsic_addr = base_addr + socket * VIRT_IMSIC_GROUP_MAX_SIZE;
>           imsic_size = IMSIC_HART_SIZE(imsic_guest_bits) *
>                        s->soc[socket].num_harts;
> -        imsic_regs[socket * 4 + 0] = 0;
> +        imsic_regs[socket * 4 + 0] = cpu_to_be32(imsic_addr >> 32);
>           imsic_regs[socket * 4 + 1] = cpu_to_be32(imsic_addr);
>           imsic_regs[socket * 4 + 2] = 0;


I assume the imsic size cannot be greater than 32-bits.


>           imsic_regs[socket * 4 + 3] = cpu_to_be32(imsic_size);

