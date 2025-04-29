Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1CFC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 12:42:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9kGj-0006od-W2; Tue, 29 Apr 2025 08:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kGh-0006nh-I8
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:40:59 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1u9kGf-0003wq-Gz
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 08:40:59 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so5431774b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 05:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1745930456; x=1746535256; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sq50ctwyHptMMLZK82LSC9HXtys8NmboWESfD0xculs=;
 b=YjxSUNs1Y74I/HgsItmtczrGG/4f5p5mkTPTgxrtHkkE7yQtZO0vzhra71B+uOMmDs
 i1xuF1YaoFHE7uk8g2+UThrXzs49bpXKpGtxYLCSPl+ExoxKCTBLuQgRxdoZyLELNsxn
 FtJTsnF7yFKgVa9U1dEiVoDl8p2pDnj+YDt/r1JHrF+20rN/sCwnydp7x6FL+mT0PnWY
 KP+7MM3f7RrXBvxCUpAxIQwSmM1z7Evc7500ZjwOES/LrNreMyqFu87a46GdOucGQMDo
 GsJRSrHkmIS9sXoMAXqZK6Zc8488thookBhAS5nZh5+88sana+qtOsKeSGGgHllaYaRU
 Uxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745930456; x=1746535256;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sq50ctwyHptMMLZK82LSC9HXtys8NmboWESfD0xculs=;
 b=OmDEYNMKsDcFGqblE7cI2ah5zJxAGf40g0ibUMFp4MqjPnyJ6ZX9+vtcMWL33S7d1n
 rrjT07DCneOVL5btSK7SvIq/PNuI4Lettx7XcxO28v7YM9UdqlGHlmCqiyac5YHbaqz7
 RKqWg+hwCKA+r2VVZZkKpW8WyYnqHW4SuNU0QkUF23q0Y9Upd5k5MX2vrLanIxb5g6Mu
 Mkc5fTzYR4HyjD96v/SbyFp/4yJqhtsg1ULUzqirOEDpSXausALIUX7ZOhopAbqeuz6e
 k8Wx8w22R5vy9ri1wFEL3pjFo2NDec9dhfY3NbAcLMFRn+O60y8Oloflz7cbsD62hVv+
 7LQQ==
X-Gm-Message-State: AOJu0YwZuOPsrS7OevHsaPbcfQhvoY6+Th7ec0h7NtNzpiFZqy7OFiPe
 cUkiMiqWdAjfxXq9W4Y1DwQFhlcmDFmOmY05hlekVmylmvjYJIV194QDh5sutAM=
X-Gm-Gg: ASbGncvy6/gKB1hWsgEpzqg+Dd3FlpbsiUhdy2NB9Rp+LcqPi+cmB/61YgE9/U+JXAS
 pKjuimF9mgq4/5btlRfBf1YUKcvp8kqkl4nVVy0lpJRbJf0Vmsq4Qe5r5kpIdt1hSS4nhLOQhyI
 vbY7+nqmsE10NCMyBSlyLl+JvPpF4r7i3EkFMgeQexWdV69PwvMSIcBMhTJcRPQmx2SVhU7E+Rm
 PIFYkJY06g7rhvr4lNbDxKYPcqlo0PJMwQX+E8g2S/yyt3uA0FInsGXPFakUF9FZrye1qp1RSrM
 BdJWFueIhNe4iD1MTt2NHBjEJ7AOn9lApLbaB5VkirM/vwNZdjHMMoM=
X-Google-Smtp-Source: AGHT+IGZ64wZZ8x1oVI5b42HlyTAyAnPJ9FEnoI8EzeKJZ5lBo2YQnFjdgJf0j7VegeZ8P+JFGHz4Q==
X-Received: by 2002:a05:6a21:1645:b0:1fe:90c5:7cfb with SMTP id
 adf61e73a8af0-2095cec9725mr3923141637.27.1745930455636; 
 Tue, 29 Apr 2025 05:40:55 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.125.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25962f61sm9749874b3a.74.2025.04.29.05.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 05:40:55 -0700 (PDT)
Message-ID: <d404d535-fc04-43ac-a7a7-2f216cad993c@ventanamicro.com>
Date: Tue, 29 Apr 2025 09:40:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] hw/riscv/virt.c: remove 'long' casts in fmt strings
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20250423110630.2249904-1-dbarboza@ventanamicro.com>
 <20250423110630.2249904-10-dbarboza@ventanamicro.com>
 <CACPK8Xei9L_82YV7+wPmTacEh2MNLFticOEny_6kSM9miCAt2w@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CACPK8Xei9L_82YV7+wPmTacEh2MNLFticOEny_6kSM9miCAt2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42d.google.com
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

Joel,

I'll make these changes in this patch to be consistent with what we've
been discussing:

- change addr to hwaddr
- use HWADDR_PRIx instead of PRIx64

i.e. this diff:

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 1eae84db15..0020d8f404 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -303,12 +303,13 @@ static void create_fdt_socket_cpus(RISCVVirtState *s, int socket,
  static void create_fdt_socket_memory(RISCVVirtState *s, int socket)
  {
      g_autofree char *mem_name = NULL;
-    uint64_t addr, size;
+    hwaddr addr;
+    uint64_t size;
      MachineState *ms = MACHINE(s);
  
      addr = s->memmap[VIRT_DRAM].base + riscv_socket_mem_offset(ms, socket);
      size = riscv_socket_mem_size(ms, socket);
-    mem_name = g_strdup_printf("/memory@%"PRIx64, addr);
+    mem_name = g_strdup_printf("/memory@%"HWADDR_PRIx, addr);
      qemu_fdt_add_subnode(ms->fdt, mem_name);
      qemu_fdt_setprop_cells(ms->fdt, mem_name, "reg",
          addr >> 32, addr, size >> 32, size);


I did this change and applied your "hw/riscv/virt: device tree reg cleanups" series on top
of it, and there are no conflicts. No change needed in your side.


Thanks,

Daniel



On 4/24/25 6:41 AM, Joel Stanley wrote:
> On Wed, 23 Apr 2025 at 20:39, Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>> We can avoid the 'long' casts by using PRIx64 and HWADDR_PRIx on the fmt
>> strings for uint64_t and hwaddr types.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   hw/riscv/virt.c | 29 +++++++++++++++--------------
>>   1 file changed, 15 insertions(+), 14 deletions(-)
>>
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index 036a0a9bfb..075c035f25 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -309,7 +309,7 @@ static void create_fdt_socket_memory(RISCVVirtState *s, int socket)
>>
>>       addr = s->memmap[VIRT_DRAM].base + riscv_socket_mem_offset(ms, socket);
>>       size = riscv_socket_mem_size(ms, socket);
>> -    mem_name = g_strdup_printf("/memory@%lx", (long)addr);
>> +    mem_name = g_strdup_printf("/memory@%"PRIx64, addr);
> 
> I wondered why this wasn't a HWADDR_PRIx.
> 
> addr (and NodeInfo::node_mem?) could be a hwaddr? That would make
> everything more consistent.
> 
> Cheers,
> 
> Joel


