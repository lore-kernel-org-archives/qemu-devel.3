Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECD41062880
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 12:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0IUr-00026O-UW; Wed, 11 Mar 2026 08:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0IUa-00023m-D1
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:16:54 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0IUY-0000O7-74
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 08:16:48 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439baf33150so819615f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 05:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773231403; x=1773836203; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/lDF0m0/Enh3zynLCArYk1i2HjYkkraUo/2aYEgOJR8=;
 b=f+7aXwh1PnJ8WpGgUwOMIGku8F2BUFZTPRXag5+fU3Ag5goMygjZHhIO0FJZQaAW04
 3evVSQelR5fhowP2001vioAb1u4XydfLsC6FhBsX9MYxvn/2qFdu7KzulBjrAKFIqShL
 0x/ouiiWW/VzuUHpsyJomkEsIXSOg7j4AV3XPDMNYnfbiRGBvC0YraFbt4Ctic3D8Tm4
 iOV1q6zfXQTgQoIl5lNh8bbU3ptqxvC6qgSc+3tW8M9MKoz34cMJWXk2eKrmpj+bo/he
 Nageza/W3jqdQ25CDLgLIcAAxlRrocNpbAXLpKhU3cWqPyCFum9IAu1cdgsWNG9LG+yf
 +E5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773231403; x=1773836203;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/lDF0m0/Enh3zynLCArYk1i2HjYkkraUo/2aYEgOJR8=;
 b=vMzhmzW4Peq4y7eApybbSq6s17VNYBuNrkD1xu5vBLETZfymgt90rIU68RmNOral0O
 TOF9+YQjh8szLNyfB2m8EHx+YzAeBT+khmXTzWBgZvgJAit4ouFqxLY7obnQhkwujLQJ
 zrNt3vpoKmfglYCTEunVclbc6Q9PKOukcK5aa6STYH40ztu0FxDMw7/lmka736yKolMH
 H77h4pUo4+s1mT4VMrjSUpgVHtpDKh6lLPtF/SuSc47U+RQNTD+9eVJM6ZovxRZpx4wD
 oMERtdkY7Q2JXx/Y90dg3SHMgjHMaVFHMUSzEKMo6S1D9XRmdnB1S8dZUW8ON4xneg3O
 UBbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx0C/cvD7GKkPwtI481CjdiuxfGCEmQDQ+HIQ8z+Cd+f6TsXZv5ViPGia3AxoUa3txt/WYbagB51HT@nongnu.org
X-Gm-Message-State: AOJu0Yz/g7b89ONUB1tT4GZ7CRqKpmojD+4pT6m7R9upf/JN2MlN5oKO
 GcO3rfPNeA+1ApnJqBcx3iUyeDeNJapzP51LHbCfFPE6Zs9ygns7vv9veakjVX24Zgs=
X-Gm-Gg: ATEYQzzd/mL1sgZKG8QTcRfWwOxgZuFDsVu7I3zIGEz3wgdpCNXE9aBtzVtkpTsAQGR
 V8m2B9vf/F1vXzUYED7atjZz6GK6r/6FLi9ZV3Ob8KneSYaXhvCYcnUmm5/W0xKYNlUvsIs6F9k
 Qqkw0GjsdaIE2ZBXbzyyLBrG5h6kYQtiB+Qqhy5gaqOpOQTgRT2nnB9jsL5//UqmH21wTTn0Jrv
 smImeYV6X8Y3T3tGUR/BtfJOGTFsYus3kmCCTH26EbHuIm0w5Yb9AfP3zngsGe3B/p1iMtYrWlQ
 GlOZC3oJ2ys3Xno39GzvffOmpqbvl73cM8Wd9DBLQIK/nvr1f5PevVRu+XulDETAO+jlRhobcv9
 uyFWwq3BFM1zrrrRWJ95aqbUr0NDdnclQXHtZjTe7GkKqNoCQzCHzW+3dWPLii/L60MCgivHUE3
 V9sFa8WBcbJOy3fuv9xz6yCGAIaiAroHtGVTDX3xhP7Hkvs0BTYWu4i/135/GOwR4Wvg==
X-Received: by 2002:a05:6000:2893:b0:439:be8d:2e44 with SMTP id
 ffacd0b85a97d-439eff516bdmr12892323f8f.19.1773231403104; 
 Wed, 11 Mar 2026 05:16:43 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f81a3b91sm6857552f8f.13.2026.03.11.05.16.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 05:16:42 -0700 (PDT)
Message-ID: <3d470609-2770-4cf6-aaf5-d9ffbf31c8d3@linaro.org>
Date: Wed, 11 Mar 2026 13:16:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] hw/riscv: Make boot code endianness-aware at
 runtime
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20260311115910.564481-1-djordje.todorovic@htecgroup.com>
 <20260311115910.564481-7-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260311115910.564481-7-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 11/3/26 12:59, Djordje Todorovic wrote:
> Add riscv_is_big_endian() helper that checks the hart's big-endian CPU
> property and use it throughout the boot code:
> 
> - ELF loading: pass ELFDATA2MSB or ELFDATA2LSB based on endianness
> - Firmware dynamic info: use cpu_to_be* or cpu_to_le* based on endianness
> - Reset vector: instructions (entries 0-5) remain always little-endian,
>    data words (entries 6-9) use target data endianness. For RV64 BE, the
>    hi/lo word pairs within each dword are swapped since LD reads as BE.
> 
> This is part of the runtime big-endian support series which avoids
> separate BE binaries by handling endianness as a CPU property.
> ---
>   hw/riscv/boot.c         | 68 +++++++++++++++++++++++++++++++++--------
>   include/hw/riscv/boot.h |  2 ++
>   2 files changed, 58 insertions(+), 12 deletions(-)


> @@ -474,10 +493,35 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
>           reset_vec[2] = 0x00000013;   /*     addi   x0, x0, 0 */
>       }
>   
> -    /* copy in the reset vector in little_endian byte order */
> -    for (i = 0; i < ARRAY_SIZE(reset_vec); i++) {
> +    /* RISC-V instructions are always little-endian */
> +    for (i = 0; i < 6; i++) {
>           reset_vec[i] = cpu_to_le32(reset_vec[i]);
>       }
> +
> +    /*
> +     * Data words (addresses at entries 6-9) must match the firmware's data
> +     * endianness. For 64-bit big-endian, the high/low word order within
> +     * each dword must also be swapped since LD interprets bytes as BE.
> +     */
> +    if (riscv_is_big_endian(harts)) {

Do not consider endianness as an exceptional case. Please re-order
as:

        for(...) {
           if (32bit) {
               if (big_endian) {

Even clearer if you add a riscv_boot_swap_data64() helper:

       for(...) {
           riscv_boot_swap_data64();
       }

> +        if (!riscv_is_32bit(harts)) {
> +            uint32_t tmp;
> +            tmp = reset_vec[6];
> +            reset_vec[6] = cpu_to_be32(reset_vec[7]);
> +            reset_vec[7] = cpu_to_be32(tmp);
> +            tmp = reset_vec[8];
> +            reset_vec[8] = cpu_to_be32(reset_vec[9]);
> +            reset_vec[9] = cpu_to_be32(tmp);
> +        } else {
> +            for (i = 6; i < ARRAY_SIZE(reset_vec); i++) {
> +                reset_vec[i] = cpu_to_be32(reset_vec[i]);
> +            }
> +        }
> +    } else {
> +        for (i = 6; i < ARRAY_SIZE(reset_vec); i++) {
> +            reset_vec[i] = cpu_to_le32(reset_vec[i]);
> +        }
> +    }

