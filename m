Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FA5D31A08
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 16:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgQUL-0005NU-4u; Thu, 15 Jan 2026 11:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vgQSx-0004mV-02
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:45:02 -0500
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vgQSt-0001sK-Qr
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:44:58 -0500
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-501c6665144so11042701cf.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 08:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1768495494; x=1769100294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2ux+VE/+K2Vucfmlu4qwytpG/PYt/dUmyBefIeBanvM=;
 b=e7HcBJCNZAIKL20euqLNjkM0e24eLyY29xc6qk4XvcT1h14NY8boUZqXE9cOQTpXmI
 0WsUyUREMvzTH2TemxmG49RSxFE7S84CwUYqvHey7ylRMQwWSEVwi8gt+JylQJtKeWFe
 ASBnxh3XUIXoJWcQ+KUDu8ngTxel1UTSRuuwRoRLdc7ia4pjWeO7wJxjJeITWq9dXZje
 ua8y2DEh/yHCS9sZ0NrM3i0VM2oqhKBu+y6058AlCvjaWnTgrRt776MaFPCO8C1o88AA
 cxBhehmSXe4jpqY/KHKoFMpoNa8iNlohoxtuhtko6vF+mnEVUfha2oCw9Ay19it0LSnj
 B+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768495494; x=1769100294;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ux+VE/+K2Vucfmlu4qwytpG/PYt/dUmyBefIeBanvM=;
 b=di9fOweOM+ksVJmTc54c1KxOUFvxZikJh0BSdhlCfkti5EFPn8VLHnBpMOfmHP4lAb
 IEOPTzYdLItSKZaSLNBIc/TAXzNRvuH+sa2DP8bZt+rXEbrznIC5v79BGIb+EJDstRFv
 6yt6apP6FrbOM/fQTzCvIUUlBOmxPzyVL2L42umO85oom5o3xrX2bh7jdeP59LY7Catp
 YKVOopn5/ipslj5P7kwRr4X8sP+4mMCDqYjrd/Tt7xUcULiRty3sHCXuxKQu/lAmXCs1
 m7BOg1488eOtStR5QBvhdqGRhiVMrBisbfI81gPeSgdviRvndnqB1BMRBhwoAEifdMvn
 0rOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj9yB3niddJeuSiWP5LSZRrVEfgOnDAe4yE5gTjUk09T5K358gZTEK86gziK1drwhlmJg9ldMV8aEk@nongnu.org
X-Gm-Message-State: AOJu0Yy0pLcK/mYIf5u101GjLP1EHraR/aWULqB8mys5nSYe1LmnAIVA
 3G/ea7BUXbmocEuBgvLEDV5SOl1W9XANS1rePYFor4XHl+Oqp5yjo0pz4Dx10fUg1w4=
X-Gm-Gg: AY/fxX6ER+GAvhRJybt/1+Zd/hxXeVBp6ErB/xAnK+WC7XKcq+6Hb50nlQbcSSh39HG
 6qMGK+PnzC0pk1P9qiIgBqH9TiU/ldV3/i0zahnKPfinWgn8Et4T1FFX4hAnd5s87/E3QA4WSRw
 CCessDYZPY9F86TGiUpcbvekcgmheVxGftGxMSsHn8RoG4Q6P8nFrs8G3y2f3pAFzqCn+MqhpWe
 yDqk81qx7pFh3GsSM/13zDhtkmuLq22X1PwdJynNSyHnnZ1+5p1VD2YXtaewl2UNDlpvI1AexrV
 rQC05GOtQdD0maigEvd8bSSAs9k6aTYd+6YnJFJDGY4sDEyQyB2Oot8DOIN3Z6KydD0esefvxYJ
 o6GAF73sSKnkmJG2c2MSXnq365mefUGzVo8Diar5/ZwQTuwfh6vvIFxOntPVOLZikVb9Q9HmkRH
 Ur1wv1J2IkFb5E+eyjgVen4eX0n9njnWDoce02uJQR
X-Received: by 2002:ac8:5d48:0:b0:4f3:5889:2a79 with SMTP id
 d75a77b69052e-502a17e09d7mr805881cf.81.1768495494296; 
 Thu, 15 Jan 2026 08:44:54 -0800 (PST)
Received: from [192.168.68.103] ([152.234.121.223])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50148dd75d4sm40466851cf.2.2026.01.15.08.44.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 08:44:53 -0800 (PST)
Message-ID: <9b4c0055-bc09-44d3-a1ac-2817e1182b3b@ventanamicro.com>
Date: Thu, 15 Jan 2026 13:44:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/riscv/boot: Warn if a ELF format file is loaded as
 a binary
To: Joel Stanley <joel@jms.id.au>, Alistair Francis
 <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Vijai Kumar K <vijai@behindbytes.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
References: <20260109131657.396794-1-joel@jms.id.au>
 <20260109131657.396794-4-joel@jms.id.au>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20260109131657.396794-4-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 1/9/2026 10:16 AM, Joel Stanley wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> It is possible that an ELF file can not be loaded, in that
> case the loader falls back to loading the file as a binary
> blob. Print a warning in this case because it is likely that
> it is not intended.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/boot.c | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index f3857e984240..3ea95c175c14 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -179,13 +179,27 @@ hwaddr riscv_load_firmware(MachineState *machine,
>   
>       g_assert(firmware_filename != NULL);
>   
> -    if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
> -                         &firmware_entry, NULL, &firmware_end, NULL,
> -                         0, EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
> +    firmware_size = load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
> +                                     &firmware_entry, NULL, &firmware_end,
> +                                     NULL, 0, EM_RISCV, 1, 0, NULL, false,
> +                                     sym_cb);
> +    if (firmware_size > 0) {
>           *firmware_load_addr = firmware_entry;
>           return firmware_end;
>       }
>   
> +    if (firmware_size != ELF_LOAD_NOT_ELF) {
> +        /*
> +         * If the user specified an ELF format firmware that could not be
> +         * loaded as an ELF, it's possible that loading it as a binary is
> +         * not what was intended.
> +         */
> +        warn_report("could not load ELF format firmware '%s' (%s). "
> +                    "Attempting to load as binary.",
> +                    firmware_filename,
> +                    load_elf_strerror(firmware_size));
> +    }
> +
>       firmware_size = load_image_targphys_as(firmware_filename,
>                                              *firmware_load_addr,
>                                              mem_size, NULL,
> @@ -195,7 +209,8 @@ hwaddr riscv_load_firmware(MachineState *machine,
>           return *firmware_load_addr + firmware_size;
>       }
>   
> -    error_report("could not load firmware '%s'", firmware_filename);
> +    error_report("could not load firmware '%s': %s", firmware_filename,
> +                 load_elf_strerror(firmware_size));
>       exit(1);
>   }
>   


