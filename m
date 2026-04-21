Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA21AF94CB0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFJ17-00051R-Sl; Tue, 21 Apr 2026 17:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJ15-00051J-2k
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 17:52:23 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFJ13-0007pz-9l
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 17:52:22 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43cfd832155so3439175f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 14:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776808339; x=1777413139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0qhOhd1hcPkN6KKsqYrL6Zi4VfIlR1Fv6Mi6c8FscV8=;
 b=OgL3irxCmsODOlF4DSdaPtyYMTqAUKMN/XxSTCbjE9gcqk/qd48Agm2TfCqdBQKtno
 IeMHb+PUNelyedj9gYofMSFFcIb1pmatijZXcu7inpd/nQlZVUJwVjtpLznka7oxjl2H
 84u8KgNqc92hJVueEzTJOzDgwpeGjwEVCEDBTgb/cz+ZYXwVv2kPb3zVt2G1nODxRz1T
 XljfJMydqUzz6cOzEy7SKCGvVuLTKyB9QrIPBTMbuJdERqeDw/DPXep4Jnjh07HOVWiA
 OLDM/KF3gr+1b2MbwbSY5VdVm+xYxZMLJlPx6fhCZr8gBGauczz+9rkJrGmNi2a4CH7t
 SjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776808339; x=1777413139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0qhOhd1hcPkN6KKsqYrL6Zi4VfIlR1Fv6Mi6c8FscV8=;
 b=OIiJ8IL/9BVoIHUnvXW5qwK7WkUlWOcMHU2BUts8iTkl8BAecSpFLeD/igTjF9akaO
 qq9m1//d8fqVxng58UTqZ0/JyXNzBXxAuoUTztbFPFoRfp2XT4nj/HmCy2BddfZeQ77a
 sUbw3Bh1dG67zPC0k5k791TkMT1kMUnUBbramLRC2en8vVWwTRbwIGRqWGU7UkzyG3dx
 m5T0i5n9z3w9yRjZs7wXTmAj7Vu/BspnBFOlS6g884HxNwxW0Cc2KDrMR3yofEDtArqB
 OVOw3Fc5GrsrHR9yMM8yjYtdglBnCvnI+eloXsCHWsCpsyZJhgNkL8oaLubKZ96kQMui
 P9bw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RbomOtW7ek3r29plm6oEifag0fYLM5OUkTr0nWbuUvy/IUw1iFAYvZ74u5EPu2rqEWLsMYs9xOveT@nongnu.org
X-Gm-Message-State: AOJu0YwJupef1Lhd0XRyApbiM4G++iLoljnrjB7J986JeIviBfJaT5k0
 a2+dR+BuPdMu9To9KnD6B2MvoJ+gPwNvuP1qUGBZhBk01h4WmtiAt44VbnVaoLNKImE=
X-Gm-Gg: AeBDietxMJc5EBnGT3K7zQcVpF6e9V/Pvnu+nu4o03iHV6TLlnusjzDawiRVCcTJ73y
 EUkA9LQSj+nGM4gqJK2WstoKWYNeKCTO/rUT79qWEziBOqTpT5J51FkKsbS4WpQvDybphqaNyau
 PHS0ZAqL5ElD7TXswrlnJ408rS3Pv7T9zDexRPg6w4QFV9Qh3dhpdDM8PTyrYCvZgvdRCABcjSG
 EupeQhIm8J8eX8vho09hSgHbiacDXWMnaL0wy26XfyYw9QWev04t+6NvxoHul/01ahMKI8Frvn9
 oodRJ29Xwv4jnm/5QmOJcvbOgdA3ZEUgD1GGmz9EM0cxJ3T/QP5mmzZJE+JKPmw8XmSodc2Ztdx
 ECA5rwVLFk7MpNIBBD3sFPsSaz4jUEaaMMpthqeBVG8L9bNQM/+btot63SbMPDPle2U8gq//o42
 mFV/6ZnxQdVU7sUBA5XuQKTaMiMoxUMmi9Pf9BmIlgtsSmejPyq4iVg3Q+27Ztd/B7RZCyr2aUL
 QtY
X-Received: by 2002:a5d:5889:0:b0:43d:7a97:78b5 with SMTP id
 ffacd0b85a97d-43fe3e0a448mr28912879f8f.33.1776808339524; 
 Tue, 21 Apr 2026 14:52:19 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1365sm42557693f8f.7.2026.04.21.14.52.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 14:52:18 -0700 (PDT)
Message-ID: <cf7e3db0-777a-4dfe-ad41-ac74d992973c@linaro.org>
Date: Tue, 21 Apr 2026 23:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] hw/hexagon: Add support for cfgbase
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 pierrick.bouvier@oss.qualcomm.com, Sid Manning <sidneym@quicinc.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-6-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416210305.2255579-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 16/4/26 23:03, Brian Cain wrote:
> From: Sid Manning <sidneym@quicinc.com>
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Sid Manning <sidneym@quicinc.com>
> ---
>   hw/hexagon/hexagon_dsp.c | 11 +++++++++++
>   target/hexagon/cpu.c     |  1 -
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
> index d5df87605f4..649cafcf8ec 100644
> --- a/hw/hexagon/hexagon_dsp.c
> +++ b/hw/hexagon/hexagon_dsp.c
> @@ -73,6 +73,7 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
>                                   const struct hexagon_machine_config *m_cfg)
>   {
>       MemoryRegion *address_space;
> +    MemoryRegion *config_table_rom;
>       MemoryRegion *sram;
>       DeviceState *glob_regs_dev;
>   
> @@ -86,6 +87,12 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
>   
>       address_space = get_system_memory();
>   
> +    config_table_rom = g_new(MemoryRegion, 1);
> +    memory_region_init_rom(config_table_rom, NULL, "config_table.rom",
> +                           sizeof(m_cfg->cfgtable), &error_fatal);
> +    memory_region_add_subregion(address_space, m_cfg->cfgbase,
> +                                config_table_rom);
> +
>       sram = g_new(MemoryRegion, 1);
>       memory_region_init_ram(sram, NULL, "ddr.ram",

Better if we can keep reference to these things in the machine
state. We can add HexagonMachineState (or HexagonCommonMachineState)
which expands MachineState and have those fields:

#define TYPE_HEXAGON_MACHINE  MACHINE_TYPE_NAME("hexagon-common")
OBJECT_DECLARE_SIMPLE_TYPE(HexagonMachineState, HEXAGON_MACHINE)

struct HexagonMachineState {
     MachineState parent_obj;

     MemoryRegion sram;
     MemoryRegion config_table_rom;
     ...
};

static const TypeInfo hexagon_machine_types[] = {
     {
         .name           = TYPE_HEXAGON_MACHINE,
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(HexagonMachineState),
         .abstract       = true,
     }, {
         .name = MACHINE_TYPE_NAME("V66G_1024"),
         .parent = HEXAGON_MACHINE,
         .class_init = v66g_1024_init,
     },
};

static void hexagon_common_init(MachineState *machine, Rev_t rev,
                                 const struct hexagon_machine_config *m_cfg)
{
     HexagonMachineState *s = HEXAGON_MACHINE(machine);

     ...

     memory_region_init_rom(&s->config_table_rom, NULL,
                            "config_table.rom",
                            sizeof(m_cfg->cfgtable), &error_fatal);
     memory_region_add_subregion(address_space, m_cfg->cfgbase,
                                 &s->config_table_rom);

     ...

This also helps during debugging because you can easily introspect
from the machine to the particular MemoryRegion (in this example).


