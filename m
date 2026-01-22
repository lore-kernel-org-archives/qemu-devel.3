Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32F8C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 09:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vir5X-000878-Tr; Thu, 22 Jan 2026 04:34:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vir5V-00086V-Qe
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:34:49 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vir5U-0003rv-D5
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:34:49 -0500
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-823075fed75so314354b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 01:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769074486; x=1769679286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmpkKNXFsi/JNiNEI4JwRCKu7E90Bq7GpVrJkexggcU=;
 b=jflWqPqWVjOaJScU2DD5j/OITCZhlED+IO5S7kvlsXiURb1kxiImYn1s+i/Fmaz++7
 PFv/VXMIATpGYmIOuEjhsoHMrVkJhrV1vRaSPdcbyQAgcuE76RuZpagd/9vbsGGQg0aa
 VrfZeL8WSw/2OxHs47kPF0N3KIqaGy1WBjHC01b1RVZGhoD5A+8qnORORIc4taHJAG0J
 Y7YM+AaAZXSnnI45wYbT8Mwx/MU2ChxRsE+APZr0rUI2Fmk4Bms75Q6fY9i3vbePenal
 8qyAj+PKVuqANTL5fUgftuFaP191AY9WULL/O7HXil49xBsfxLiPgXpZiBOUuYuJQWll
 gOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769074486; x=1769679286;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bmpkKNXFsi/JNiNEI4JwRCKu7E90Bq7GpVrJkexggcU=;
 b=wu4RztWaKOUKuXQh2ohn0Kx+6q9vkKnnjYShda35So681VjbvW9u0mYl76scp5h9pj
 J8SThGzx0lpCKrqwdNgly3CtB6YDNlef23rXqEisqaqKEMvB/8STnlvVH5ZkofeODsAb
 27g/ajZA9e5fI6x7/Y/3ZPr3cQqzY3JSBhmAt4f/Lzjrb3ZL6mGBR8Og81keoI3Gtleg
 uZVNFw8XHim4HVFeym/LtKl/skcJyQHRO3PawZF7aQJBcwWNCN/1UYMxtOYcZGjnFY5n
 NCPVT57MWNS1Apxj6xlfmWH2FOyyHdctPzkl6DTmej97fz3AgwgppGPovCV0rdiai9A/
 qcPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl23wTiGQX9jZvQTEbiIqztgU93WdMY0smwsgXJe+gcSNeR8bud6MGeOKG0Gktx8NKF3Bzt55N5cH6@nongnu.org
X-Gm-Message-State: AOJu0Yxv+n+CgKF7QAVThi0IKUyzEPsh0Zic/40B869XQMU+puBlLW8Z
 R9Ak8fw/YoXjZEU4HDSHMVgPbnyPLsbufwswtD6CxsdABK5hDQfs5SbH
X-Gm-Gg: AZuq6aJgmBZtkUmmA2L0IlstGPYf38efQqeWKCGNdFwjbcAt/SP8GvCzIR+UWudYGaG
 Elr3M26HRScvdZPvdnLIaT6+1XdqdrhlLgAXn4lAGbJRonJgJhsJZtKBrqkOdXCMz960bpVGMBr
 c/W/4ITdvf7u3CLDAVkRAXiMQCfqo6JjosVBiG67TqRk8TGB+tiTfj19PToRe51f+Pk6p9Kx54d
 CdeFOqPQR9GWjZoa509lOVAOc0nhnEkuHxqfxPQD6A4r/k6iakW3t+6JtzHTb09/lHvzlVFjNU/
 +8BiFf8brHtkFRgwHvFKFEf+5j+uXYHj4o37v1Op3I/w0qdkhU4LpC5Wkxbpe73Tixv3H8yxOO1
 iOOC1nhntmtE53ZdmbYDMdl5jvKIp37fWKMe83j53dONTZGzH6d4ZltoQmTrgEW/PC+pE+V1oUJ
 59ZjsjMgQNUITXZc8H05giQnNnWukeSXy02uUmKppjMCord8o13V/ETkJQ+Wk=
X-Received: by 2002:a05:6a00:2192:b0:81e:7734:9e85 with SMTP id
 d2e1a72fcca58-8219ede8a64mr1837819b3a.20.1769074486487; 
 Thu, 22 Jan 2026 01:34:46 -0800 (PST)
Received: from [127.0.0.1] ([61.173.116.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823098cb1basm1296587b3a.32.2026.01.22.01.34.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 01:34:46 -0800 (PST)
Message-ID: <2f0a2b88-445a-4b73-bf91-df7fa83d9e47@gmail.com>
Date: Thu, 22 Jan 2026 17:34:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] hw/riscv: add k230 board initial support
To: Peng Jiang <3160104094@zju.edu.cn>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn, Chao Liu <chao.liu@zevorn.cn>
References: <cover.1768884546.git.chao.liu.zevorn@gmail.com>
 <ad3c378976034be5cf80282048aafd002e725105.1768884546.git.chao.liu.zevorn@gmail.com>
 <651b1d38.63ab7.19be50b4721.Coremail.3160104094@zju.edu.cn>
From: Chao Liu <chao.liu.zevorn@gmail.com>
In-Reply-To: <651b1d38.63ab7.19be50b4721.Coremail.3160104094@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x441.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


Hi Peng:
On 1/22/2026 5:31 PM, Peng Jiang wrote:
> Hi Chao,
> 
> I found a small issue in the reset_rom implementation in hw/riscv/k230.c.
> 
>> +static void k230_machine_done(Notifier *notifier, void *data)
>> +{
>> +    ...
>> +    /* Mask ROM reset vector */
>> +    uint32_t reset_vec[] = {
>> +        /* 0x91200000: auipc  t0, 0x0              */ 0x00000297,
>> +        /* 0x91200004: addi   t0, t0, 36 # <trap>  */ 0x02428293,
>> +        /* 0x91200008: csrw   mtvec, t0            */ 0x30529073,
>> +        ...
>> +        /* trap:                                   */
>> +        /* 0x91200030: j      0x91200030 # <trap>  */ 0x0000006f,
>> +    };
>> +
>> +    /* copy in the reset vector in little_endian byte order */
>> +    for (int i = 0; i < sizeof(reset_vec) >> 2; i++) {
>> +        reset_vec[i] = cpu_to_le32(reset_vec[i]);
>> +    }
>> +    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
>> +                          memmap[K230_DEV_BOOTROM].base, &address_space_memory);
>> ...
>> +}
> 
> It seems the offset for the trap handler is incorrect.
> 
> The instruction at 0x91200004 is addi t0, t0, 36. After the auipc at 0x91200000, this sets the value of t0 to 0x91200000 + 36 (0x91200024), which is then written to the mtvec register.
> 
> However, the actual trap: label is located at offset 0x30 (0x91200030).
> 
> The immediate value in the addi instruction should probably be 48 (0x30) instead of 36 (0x24) to point to the correct trap handler address.
> 
> Best regards,
> Panda Jiang
Thank you for reporting this bug. I will fix it in v5. :)

Thanks,
Chao

