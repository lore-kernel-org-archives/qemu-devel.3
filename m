Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F1CCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNWr-0005NI-5J; Mon, 11 May 2026 06:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMNWp-0005N1-Uf
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:06:23 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMNWo-0000KO-4c
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:06:23 -0400
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-82faf871346so2938771b3a.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 03:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778493980; x=1779098780; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wTJc7UA2V8JMzRXLaaedBFFLjVXzLaGIYPymhUPPix0=;
 b=C+EoLFuJvDEd3NHz4YScyWK08JmfMCaua+VTVHZdl94XdhiUUuJqRrVHEO9GdkahYI
 Swo7ODUmrQ8SkCWu5vxK4AKgnNcg8boigc1Mi4rExB/TCkVFv+4/majBisZ+qZCQBVdd
 MJFY95fGkp4HTbWGfLdwtDKMwnOHYVNuBtFGBt/5cW2OWmzIw2g2eYHKeIVl0krgHCnu
 8IZeGxyxE9YjX4Aabr3bYnBQ1jtzjYnn7ICDjI74MiEKvUOvm9FhaSUhtOF0sU96mAOt
 6sSaMITML+Dy8dveGY6OMwvwDSCe/ydjQY+CFgPkvk3z7lCP8nJPX2O5RvV6BbGTqNr0
 DXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778493980; x=1779098780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wTJc7UA2V8JMzRXLaaedBFFLjVXzLaGIYPymhUPPix0=;
 b=Vtn3tZty9YkJqNy+mFvktapIN2ZdUfXRCF7qT+5fXIi7qgv7+qdwxVPl6Zvrqh4uSr
 Lqx60tZT+s5eW9ylqBeMXOo/FeQ256vXg6L0hZMyW6ubwTttpAKwSZgVwUx1zq79Q4A1
 aTQ5NioStFDJJG04eIKHmkn4j5g+o2OQOpybZdze+PvdW9B4aFaGk67ECwe3/a6PlnGk
 427MpUw00BvvVjtUEYh6rppUukIXmenyeWSH21q3bNk5gwFgWmaOiED87fvoEIWbzByp
 j6ozhBQ2ABkCkITRi8cM6/P0xE9j+s9SE4Ggp+EjtpCk49EBPlw/aaMaiLW28T6MbOGD
 fhJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/F8MykaNZNICtw79kOf8kAXKpRttrm+JzGE8iVndnxUTXeSBx88GAu/qYjiTGAgh8o0MdkrRWIDBu/@nongnu.org
X-Gm-Message-State: AOJu0YxF/ZnJPTRiTcIldBokwz1P6D6hLYmcNKPcPFlGnZv/hjuwwiSk
 6opHe6LGHU5g55i6XweKoMWVbSHuct5GBEihY2zBpElJjVgU5mSbeRo7Jb7Ab1gTRNyRJw==
X-Gm-Gg: Acq92OEf19uqtwM1UdB5em8BxM+fn49bOiTnTqjzY9HRESS86qdSlnWn9VtjCyukgLj
 nh+XSQL8W2KW7iRC5clktUtYmb4f8hMNrDu1xUD+/KejnBu3h6OIa1NT48SivchT5nTmEDxRmdk
 lQ3okldy+Ltt5eOvYDIgQGLkb2tMoQApDukz8w6NEQboDicC27kV3Ngvs66BmE4xeV1rLj96AkV
 8LaesafvlKkYPEHbxqRGgDmxRiPUJWEWo/eOdcOf16j1SaiZFv7rlqwjUffIpr/hFpdE3RIv2wy
 H81aWImoGJUZhAnqTg51j+BEZ8nX/Z3yE8bcL52VBvB4L+3iYRstNCDIGvHWYlqJYr2Qjsl/vKK
 eROIbYDIkPOJA679HBIQetAZG/hwUVf5LaNsLMS0fKrL6Ldh0+6vnMSIwEKCbPnUzRyQ3ImZ09G
 Wyp7V+ijiE8CUX74xfFOEoHKpiM0b9RRCVxHznSvyMPr75+oal/U+MrzMW4BHT3/4RgZNwEpOdI
 ZaS5boJTUI=
X-Received: by 2002:a05:6102:5816:b0:634:92df:4dc3 with SMTP id
 ada2fe7eead31-63492df5c9bmr436739137.16.1778482368304; 
 Sun, 10 May 2026 23:52:48 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-95f219c6d64sm4809127241.3.2026.05.10.23.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 23:52:46 -0700 (PDT)
Date: Mon, 11 May 2026 14:52:31 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Zishun Yi <vulab@iscas.ac.cn>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] target/riscv: Allow mseccfg access based on ext_zicfilp
Message-ID: <agF8MNb9aKbqsniz@ZEVORN-PC.localdomain>
References: <20260511031719.2826247-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511031719.2826247-1-vulab@iscas.ac.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pf1-x442.google.com
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

On Mon, May 11, 2026 at 11:17:19AM +0800, Zishun Yi wrote:
> The Zicfilp extension adds the MLPE field to the mseccfg CSR. According
> to the RISC-V Privileged Specification, mseccfg exists if any extension
> that adds a field to it is implemented.
> 
> Currently, the `have_mseccfg()` predicate function checks for Smepmp,
> Zkr, and Smmpm, but misses Zicfilp. As a result, if a CPU is configured
> with `zicfilp=true` but without the other extensions, accessing the
> mseccfg CSR will incorrectly raise an illegal instruction exception.
> 
> This patch adds the missing check for `ext_zicfilp` to ensure the CSR
> is properly accessible when the Zicfilp extension is enabled.
> 
> This issue was discovered and reported by SpecHunter, an AI-driven
> architecture specification analysis tool.
> 
> Link:https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2561/qemu.txt
The `Link:` tag is missing a space after the colon.

> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
> v2: Removed mistakenly added #include "cpu_bits.h".
> 
>  target/riscv/csr.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index da366cf56271..e1cd4a299cb0 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -783,6 +783,9 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
>      if (riscv_cpu_cfg(env)->ext_smmpm) {
>          return RISCV_EXCP_NONE;
>      }
> +    if (riscv_cpu_cfg(env)->ext_zicfilp) {
> +        return RISCV_EXCP_NONE;
> +    }
>  
>      return RISCV_EXCP_ILLEGAL_INST;
>  }
> -- 
> 2.51.2
> 

