Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A962C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 08:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Ldt-0006zC-AR; Fri, 10 May 2024 04:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s5Ldm-0006yZ-56
 for qemu-devel@nongnu.org; Fri, 10 May 2024 04:30:08 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1s5LdZ-00048D-Vj
 for qemu-devel@nongnu.org; Fri, 10 May 2024 04:30:05 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41ffad2426eso2586625e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 01:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1715329791; x=1715934591; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V6FtQwz2fn5OcDwvvleaqAYhew16SKaZD7a7Orw3Obk=;
 b=pD+rsGXqB5h2UyYjWTeE/5WV3MnXYm2ncD0wlBFoUC9Bnr878e2gtvaD8g5qS/PUak
 XHWK/EeiFn2VoIYUruvUjhYNUjnNgkAFfmyumXsLSsdPeCMRmr3ZmacJkCzwGMyhT2AL
 fytOXm+BgAsL9z8VRVVw7r6QiafhTO4HHtc6j9jBXJLnLT8SLbRoXcuAEVbJ5Az2ldyr
 VouSgK54PnG1Evkr7JTYHkvoxxnq+ISPT4eagVJXWNkkGageTV74CodeiH1EsqB9Uawv
 OrC5bSSf4pSCve/Tp1ht3uD89/RFCfeRoUsstKp4CyzOZDW7hKm1mpKzXCofd+RSJoFN
 ebOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715329791; x=1715934591;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6FtQwz2fn5OcDwvvleaqAYhew16SKaZD7a7Orw3Obk=;
 b=uH0UhlQGN2jWjvPj5zIGSyzyAcMDyTrwPQ2Do+OvGPM8Nr7cOT76YbNhpK+0KfW92c
 qX60MP+KuVTmHhSVPyas+TWPHLaoZ06UUOPsSo8eSLZFSZWd4+aqPK5CJybkz4f1h38Y
 28FFTTabj7PuOzfPdjZ79Q9dZ33E13f0xL0KfrTF5VcGBWYt1uvi3zN6TsW5l/Zcjvz3
 myuPX4nm+1Af5OZ+ZmSwQw7V7Wfe7bEHNv1EcyXKok8+bQ89XD+p2+SrLEWJMDwNzPdU
 vIgpbu4c0N1NeBOqt6PUp01szZkYzH5dPji3+Uv08MlcOfTzXjrw9yXCnHJK+KvSOmYV
 okaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm3B9zoULdV5QEN6APRTLsVz2sZ4V8BY64VtINqW1Df3mC9Xuy3vXWp5HslZL6K/YtFWBS5wm5Vhud7mjC6/zyLmaETQE=
X-Gm-Message-State: AOJu0YyVKRbuLZWUioYW8qz+RuLvSOIB1TwaRJctTIalP6aqOYJwGp1W
 Oic95qTX26LgusQ60pQ6rIldpXsfgKhQduBPZHsi791G8CvoftcBezjjmCjGMXQ=
X-Google-Smtp-Source: AGHT+IHTcrmg2ymf5lQucoZtwQvgz7KACu9cIJ2EsgU8OItVQOcXkj5Ja0gdLt0AnEqa56MYYOi+3Q==
X-Received: by 2002:a05:600c:26cc:b0:418:4aac:a576 with SMTP id
 5b1f17b1804b1-41fead64fdemr18296705e9.39.1715329791401; 
 Fri, 10 May 2024 01:29:51 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41f87c2544esm89783845e9.16.2024.05.10.01.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 01:29:51 -0700 (PDT)
Date: Fri, 10 May 2024 10:29:50 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Rob Bradford <rbradford@rivosinc.com>, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Subject: Re: [PATCH] target/riscv: Remove experimental prefix from "B"
 extension
Message-ID: <20240510-bd3888b24a94d2a7cbbb9b96@orel>
References: <20240507102721.55845-1-rbradford@rivosinc.com>
 <20240508-ff6bfb7f94499a3a8d6382f6@orel>
 <a53ac495-4656-4786-ba90-d83169aaffad@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a53ac495-4656-4786-ba90-d83169aaffad@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, May 09, 2024 at 02:23:42PM GMT, Daniel Henrique Barboza wrote:
> 
> 
> On 5/8/24 08:22, Andrew Jones wrote:
> > On Tue, May 07, 2024 at 11:27:21AM GMT, Rob Bradford wrote:
> > > This extension has now been ratified:
> > > https://jira.riscv.org/browse/RVS-2006 so the "x-" prefix can be
> > > removed.
> > > 
> > > Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> > > ---
> > >   target/riscv/cpu.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > index eb1a2e7d6d..861d9f4350 100644
> > > --- a/target/riscv/cpu.c
> > > +++ b/target/riscv/cpu.c
> > > @@ -1396,7 +1396,7 @@ static const MISAExtInfo misa_ext_info_arr[] = {
> > >       MISA_EXT_INFO(RVJ, "x-j", "Dynamic translated languages"),
> > >       MISA_EXT_INFO(RVV, "v", "Vector operations"),
> > >       MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
> > > -    MISA_EXT_INFO(RVB, "x-b", "Bit manipulation (Zba_Zbb_Zbs)")
> > > +    MISA_EXT_INFO(RVB, "b", "Bit manipulation (Zba_Zbb_Zbs)")
> > >   };
> > >   static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
> > > -- 
> > > 2.44.0
> > > 
> > > 
> > 
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > 
> > I think we should also either change the false to true for RVB in
> > misa_ext_cfgs[] or at least ensure RVB is set for the 'max' cpu
> > type in riscv_init_max_cpu_extensions().
> 
> I prefer if we keep misa_ext_cfgs[] as is. Changing the defaults in this array
> will also change the defaults for rv64. IMO we should enable RVB manually in
> riscv_init_max_cpu_extensions().
> 
> We already have some precedence for it: RVV is enabled in 'max' while is default
> 'false' for rv64.

But do we care if rv64 gets B? rv64 doesn't have any particular set of
extensions, afaik. And B seems like it should be generally adopted enough
to be in a "general" cpu type like rv64. Anyway, either way works for me
as long as 'max' gets B one way or another.

Thanks,
drew

