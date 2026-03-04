Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4D9EDEC12
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 06:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxfng-0002uP-Dn; Wed, 04 Mar 2026 01:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxfnd-0002tb-T0
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:33:37 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vxfnb-0008RQ-Ef
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 01:33:37 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-480706554beso70169735e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 22:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772606014; x=1773210814; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D1Jdkna8xBKWEFLan2pGv1KxEcd9H//urP3rlR+Qexk=;
 b=gMkkhf4Vd8z0ubYgkmR9Uhq/Itmp3xdOLE7BxJ2xtiHEK7BGj5ZVsbqjcwqjWxkk75
 HqcdGw6sIMgsn+oS98ZQpBdFm1+MXuq18uCiXQuLuNwfhSqrhshZMEqCxhvdyh7BZ15A
 L3+tknJhrlPeTZBhIqd8VDS7mRdeFVrgP+OFgHOSf1IIyV7tx8YkzgX6hxGEBbV7+BqM
 MSn/cPIwkLL4Nifbu3On4lYWj9VX8ZzBG6jYAXHMBv/M/SfGj2nK2JG1gqTJdrTUP90E
 sg7dkXuAly0A98HPZvYOCl6FAGRKnP15+AsgyDZkmn7xG4oDem3reZ3BBf+2ueyp94pS
 Nj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772606014; x=1773210814;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D1Jdkna8xBKWEFLan2pGv1KxEcd9H//urP3rlR+Qexk=;
 b=Z8zXqaoQh0tAfQCTftaeeivFnXrIl+IKbxPc6zcPWTUmyyJ8poE7QfLgoNQ8fwwdKr
 a4FCk78uAeWiOfDLU+cii2sPpKPLQpy5fqMi6RitklrmHOvCplvNam0MkiN4wP6VvMD5
 wMPIp11EN7Sv46YNWJopf4v60r0k3x5MnZPhfcPPMe53hdVEK08QkTxout5IvP5H1MvJ
 Pp7RJWbJCjmNI5/d98iygSoagayh67Ij/LVQ39uCQZkli8BzvWXJ9Lxpp/E4SIKZHUNH
 yNn3cQ2M9APUTKAhYcnIa14y0ZEVV4MlTSMz0hhqSYnLc4lUPjV3nwFppA6X6maBjfOe
 HhBQ==
X-Gm-Message-State: AOJu0YwoZnSKTQ+B4rhZ6yEFtaWjTPWYhdSjhToJSPxafXPSJf3QN9A6
 L8eKtDfDgKNadbvaFLkUW2ZTSgQoPpUtuxL0rKDbnOdFc08hL29PGEp8LBsuJEXVUfWhKhz1nBn
 fYzBmurg=
X-Gm-Gg: ATEYQzxGP97N7SpWhlBqVdcXcnLXBe2jjmnVIHJlz8yuA7mnu0YYmnmaoJ7vMMP5w0a
 lVUpaDjhpX+W/fPy9a+YHZMc6CSAG3ZBBHiLJW2DQCdMqyLdXT8qDMv38h3wuspOaBM04cbNWW1
 fVbcYOlA3lPD2lYt7C1lhDdoiX9pqvVeu5ZVs48C7r5Z5ccjkBYgaXHlKgR8G/IezwcGTvN0Wqs
 XutxJVmMUprCFXPRi0Tg4iJVkBD/mTu9zGO1Zt8B00P0WBd3mATtEangDu28GqzbpwS/PCLGSgS
 CAgKZxhi75TLcQ4SLIPj9wjzo1WNiiDRiOEmV0trvOjHa64bHsXUoPs1GS9vA9e9e4/ALflqP1s
 68DeCjIdSlQIpNjneAe6vmGTcIAOBSRe82IGaqtiRukaoRtEQr7ZHcr/YcXl2G1ujGOngKaQu1u
 gjwj3gxM4YT2nl+9P0QRtzNDFcH91JG0eSE5SuwRRZVIC3l5rd0Y45we4fqXeJH6xdiA==
X-Received: by 2002:a05:600c:870f:b0:483:7432:a761 with SMTP id
 5b1f17b1804b1-485198902e2mr14002055e9.24.1772606013525; 
 Tue, 03 Mar 2026 22:33:33 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851883a007sm31524385e9.2.2026.03.03.22.33.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 22:33:32 -0800 (PST)
Message-ID: <80410890-1418-43b4-9265-184fb1910257@linaro.org>
Date: Wed, 4 Mar 2026 07:33:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] gdbstub: Remove @g_pos argument in
 gdb_register_coprocessor()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Florian Hofhammer
 <florian.hofhammer@fhofhammer.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 qemu-ppc@nongnu.org
References: <20260227213958.21170-1-philmd@linaro.org>
 <20260227213958.21170-5-philmd@linaro.org>
In-Reply-To: <20260227213958.21170-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 27/2/26 22:39, Philippe Mathieu-Daudé wrote:
> gdb_register_coprocessor()'s @g_pos argument is always '0',
> meaning it is inferred from cpu->gdb_num_regs. Use instead
> feature->base_reg, but check we don't overwrite other indexed
> registers.
> 
> This fixes a bug with the "power-fpu.xml" file [*] which was
> loaded at index 70 while the base register is 71. This latent
> bug was exposed by commit 1ec0fbe2dda ("target/ppc: Fix
> CPUClass::gdb_num_core_regs value").
> 
> [*] https://lore.kernel.org/qemu-devel/e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/
> 
> Reported-by: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/gdbstub.h     |  3 +--
>   gdbstub/gdbstub.c          | 16 +++++-----------
>   target/arm/gdbstub.c       | 21 ++++++++-------------
>   target/arm/gdbstub64.c     | 19 +++++++------------
>   target/hexagon/cpu.c       |  2 +-
>   target/i386/gdbstub.c      |  8 +++-----
>   target/loongarch/gdbstub.c |  6 +++---
>   target/m68k/helper.c       |  4 ++--
>   target/microblaze/cpu.c    |  3 +--
>   target/ppc/gdbstub.c       | 11 +++++------
>   target/riscv/gdbstub.c     | 18 ++++++------------
>   target/s390x/gdbstub.c     | 15 +++++++--------
>   target/sparc/gdbstub.c     | 12 ++++--------
>   13 files changed, 53 insertions(+), 85 deletions(-)
> 
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 12e7b5b7282..75eb4d9c365 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -35,11 +35,10 @@ void gdb_init_cpu(CPUState *cpu);
>    * @set_reg - set function (gdb modifying)
>    * @num_regs - number of registers in set
>    * @xml - xml name of set
> - * @gpos - non-zero to append to "general" register set at @gpos
>    */
>   void gdb_register_coprocessor(CPUState *cpu,
>                                 gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
> -                              const GDBFeature *feature, int g_pos);
> +                              const GDBFeature *feature);
>   
>   /**
>    * gdb_unregister_coprocessor_all() - unregisters supplemental set of registers
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 6eadae3804e..882bc67e182 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -604,13 +604,14 @@ void gdb_init_cpu(CPUState *cpu)
>   
>   void gdb_register_coprocessor(CPUState *cpu,
>                                 gdb_get_reg_cb get_reg, gdb_set_reg_cb set_reg,
> -                              const GDBFeature *feature, int g_pos)
> +                              const GDBFeature *feature)
>   {
>       GDBRegisterState *s;
>       guint i;
> -    int base_reg = cpu->gdb_num_regs;
> +    int base_reg;
>   
> -    assert(!g_pos || g_pos == feature->base_reg);
> +    assert(feature->base_reg >= cpu->gdb_num_regs);

This should be:

   +    assert(!feature->base_reg || feature->base_reg >= 
cpu->gdb_num_regs);

> +    base_reg = feature->base_reg;
>   
>       for (i = 0; i < cpu->gdb_regs->len; i++) {
>           /* Check for duplicates.  */
> @@ -624,14 +625,7 @@ void gdb_register_coprocessor(CPUState *cpu,
>   
>       /* Add to end of list.  */
>       cpu->gdb_num_regs += feature->num_regs;
> -    if (g_pos) {
> -        if (g_pos != base_reg) {
> -            error_report("Error: Bad gdb register numbering for '%s', "
> -                         "expected %d got %d", feature->xml, g_pos, base_reg);
> -        } else {
> -            cpu->gdb_num_g_regs = cpu->gdb_num_regs;
> -        }
> -    }
> +    cpu->gdb_num_g_regs = cpu->gdb_num_regs;
>   }
>   

