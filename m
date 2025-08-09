Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E80CC87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 12:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukj29-0001NT-Oh; Sat, 09 Aug 2025 08:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukj1p-00017N-Co
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 08:50:31 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ukj1m-0007OY-Tc
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 08:50:28 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-23fc5aedaf0so20688595ad.2
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1754743824; x=1755348624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LrF1sr/Za9VEJARSC9I1I1CqztQa+L7FqZNozf1lj3Q=;
 b=Uak1ZnsrVujKLCKXf7D/qHMGt8IJYkz93g6GSRU2Uan+5qDxdeAsea1C/oqJUu9VC4
 eQ74To3RSI3nHkihh4XukB5ZCBp2bkJhw1sutleIJy15M+4Ywbf9DZtzmHupHT3gpvCN
 BpRjomv21vL5lEMf7oSU+qRkD281jjvNRYJb9+1ZkUVOF0IO3qmmvcey6UcNdSyuKBzE
 7aeDxaGZ7YJ+lS4F/XaooEvT+Bco9niFRMZHBj3YY4z5SQVETTd/XSGVLXPRnW3+I9hz
 JI9SaIqE/0ge6Q28Rqv4WOrQ1Vwco08QmPg0N/zFNYAa2bjYEwncQxZpktP5rYbFyNBT
 5EPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754743824; x=1755348624;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LrF1sr/Za9VEJARSC9I1I1CqztQa+L7FqZNozf1lj3Q=;
 b=W0zYSv8RuHC58Rjy8jvWjdbGVu2eq/gEHBB3mH0IFgVRtOaMQRSPb8u8pV4Ski7XIq
 Ijay378y4G2u2LdriXJUCH5Rk78kaWtWEI/C9NZcbj3UVwOsQZupid/vYDj+5w3LhkOa
 1GJV2A/0MTyGFK88FTTEkUbzUJHeNZcft2dePmSC788ThFWLf+ymwn6tb/vHKE9xJ/1M
 TEIhyro7Q1hw0QicRZTHeRm+3eoTa8A0XrWOQsEufIZdwoDxLSBrp9U5B7xcFWsxpUoU
 LpG4mF0BvUI0SCEWpb6lF3A38jyXtKA0Lygektk4ciOzKc7++5R4Y26C7d+lfYalJPnA
 cxqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH+8Ev0ScTN4vPzgse+i7hJ3Rkj+CbUkqnbPU0CY9zrbMp/5ulzpmlnD6avT97XFXN10jXzWib8s0C@nongnu.org
X-Gm-Message-State: AOJu0YxImL/INkugNu0yTJ6gpTBm2uNItCR/g6FXq7SqIs2zn0OvrrDn
 yiu+gDY/CLatrzLk9Heq+3wLfJ3zKsty2w5wXmZxU9rDaKRSmqjC8V10fTiVTJ/NCsk=
X-Gm-Gg: ASbGnctZS9txqObtI+SLSgtwnfY0NGY9gxd9uXJ9dFxGYgWwkBqzOj30eJ+czmYAmJ7
 Bi7jWmZpebbYx+ss0oZzGlVmZiwnpHD49k+/U53JnCIYPzWlGy5RQOiv6THy+hzbBdXquM71hs4
 lwVfKTUoM2Fo3slktcXPP0tEFuQTLq+h3MwVXwvzmiaDxgaCFxiirguOAiNJSAKEiNTMzVgxgH2
 NyMlHhNHZGtaTzfbBRENZuf+Jg6tQXmrbOvh1SlRnjOinWJl5n+goSRsumuM4rFCbjTOsYv2lg2
 vAdaCj505QjlsE3xFJhomE/R/pJt6LZt4ovxdvFKLROQZB3BoXZQo4CWtZNvM4CmTlhPgng5hBU
 Rww5dS1Xz397gelbKa6yPO2AjbnuCy2wRoPXvYw==
X-Google-Smtp-Source: AGHT+IHbdpKchpoYibitLmv0ytfiPjgAFA28HUk5Rcv0vg/Gr387kb/QWpnLzlZK9Rsat3Whs+ZNcw==
X-Received: by 2002:a17:902:dac8:b0:240:3915:99ba with SMTP id
 d9443c01a7336-242c1ff405dmr87922715ad.5.1754743824378; 
 Sat, 09 Aug 2025 05:50:24 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.127.110])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32102b9022fsm10828167a91.4.2025.08.09.05.50.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 05:50:23 -0700 (PDT)
Message-ID: <bdd56f8e-af0f-4ffe-bed3-d5acf5c42adb@ventanamicro.com>
Date: Sat, 9 Aug 2025 09:50:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/18] target/riscv: Allow global WG config to set WG
 CPU callbacks
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20250417105249.18232-1-jim.shu@sifive.com>
 <20250417105249.18232-10-jim.shu@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250417105249.18232-10-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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



On 4/17/25 7:52 AM, Jim Shu wrote:
> Some WG CPU functions depend on global WG config (like num-of-world), so
> we let the global WG config device to set callbacks of a RISC-V HART.
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index ac50928b57..6dfc260a07 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -500,6 +500,10 @@ struct CPUArchState {
>       target_ulong rnmip;
>       uint64_t rnmi_irqvec;
>       uint64_t rnmi_excpvec;
> +
> +    /* machine specific WorldGuard callback */
> +    void (*wg_reset)(CPURISCVState *env);
> +    void (*wid_to_mem_attrs)(MemTxAttrs *attrs, uint32_t wid);
>   };
>   
>   /*


