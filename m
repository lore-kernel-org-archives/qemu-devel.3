Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C20C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 17:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ridqO-0006qY-Pm; Fri, 08 Mar 2024 12:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1ridqH-0006mc-9K
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:17:09 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1ridqD-0003tL-H0
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:17:08 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5134d7e16a8so2121864e87.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 09:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1709918223; x=1710523023; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pHT22q20LOhDsFUsysvtbs6WGw7zAZt1pm32ji4d6KY=;
 b=FO5GDozTYeO5yn3L3OAcC2sUmg/9uN3+BUuxg+THFf25XALNxtqOSz2/8Dx1BP7Oz6
 TWcIv0QWkjiYhQVyT3G42PvcKsUTCZrvJMYdwnLFgkCrR39TS0wDrFOWhTRKWs6BQ8zs
 /t5bmjKTZNVu+DQie17Db6kUQb12IleXjV2I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709918223; x=1710523023;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pHT22q20LOhDsFUsysvtbs6WGw7zAZt1pm32ji4d6KY=;
 b=DPvMGBa7zqwMAYJfvdDiW+fjkMr4EQTq2RNHxvCeZwmf3A2crCQaBgCvcDWWLNLMl/
 oMMu7f+LALiCrLYe0GAePlirGwZ+TFcUAMgYw/vJqawaAsa1aBsLF7ZSG0sXJ2pave8m
 aNSqSFF++Eh9Er+6zCufWjrYVp1SmCt7Gha2XMeVdGL1c8d8nZbBRUg9YgRCQGnnxLCY
 +h7RomKx1/vPAkSgPm70aen+TQPWIU1eICbP38UF4a39HLKbRC+JwZQSzv985OfqUJ+E
 /RjwMsNc21DJ+n/KVU0BZPb1ZDYLTRpC9MB2lO3tDDPnz2SDjaswzcGLU7PLvVo7EdPJ
 7ymA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4L1jaIO7pPn75wvSwt8fbxsLb4Hp+2ewEHtn4/J2ItkWMI1Wj5HwlMIH6sKPCLpW+tR9pVr45WlTV6eXDRhOu1Yw1KT4=
X-Gm-Message-State: AOJu0YwMg511riurtFiiqaSypKW0Xkndmuu9JAvqPCg5K7DssKiD1CYv
 J7/To9KL8D7FghlDhNjSlC0BQd63HQ34GnXqPjGpcFrD1qf2iTDhZ0FwIFD+zKU=
X-Google-Smtp-Source: AGHT+IEU7Rdcx8SJgoLNA+lYk/KOZq6CeemPaCgTAadtIVoFsRgKcJ27c8QiP6HFeGa6On80nI0ddA==
X-Received: by 2002:a19:6904:0:b0:513:3106:ac63 with SMTP id
 e4-20020a196904000000b005133106ac63mr3497403lfc.17.1709918223066; 
 Fri, 08 Mar 2024 09:17:03 -0800 (PST)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 p19-20020a05600c419300b0041294d015fbsm6272422wmh.40.2024.03.08.09.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 09:17:02 -0800 (PST)
Date: Fri, 8 Mar 2024 17:17:02 +0000
From: Anthony PERARD <anthony.perard@cloud.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?=
 <marmarek@invisiblethingslab.com>, 
 xen-devel@lists.xenproject.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] i386: load kernel on xen using DMA
Message-ID: <5975d575-d800-4520-a1b9-278cf51d108c@perard>
References: <20210426034709.595432-1-marmarek@invisiblethingslab.com>
 <87sg1feemf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sg1feemf.fsf@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=anthony.perard@cloud.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Jun 18, 2021 at 09:54:14AM +0100, Alex Bennée wrote:
> 
> Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com> writes:
> 
> > Kernel on Xen is loaded via fw_cfg. Previously it used non-DMA version,
> > which loaded the kernel (and initramfs) byte by byte. Change this
> > to DMA, to load in bigger chunks.
> > This change alone reduces load time of a (big) kernel+initramfs from
> > ~10s down to below 1s.
> >
> > This change was suggested initially here:
> > https://lore.kernel.org/xen-devel/20180216204031.000052e9@gmail.com/
> > Apparently this alone is already enough to get massive speedup.
> >
> > Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> > ---
> >  hw/i386/pc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 8a84b25a03..14e43d4da4 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -839,7 +839,8 @@ void xen_load_linux(PCMachineState *pcms)
> >  
> >      assert(MACHINE(pcms)->kernel_filename != NULL);
> >  
> > -    fw_cfg = fw_cfg_init_io(FW_CFG_IO_BASE);
> > +    fw_cfg = fw_cfg_init_io_dma(FW_CFG_IO_BASE, FW_CFG_IO_BASE + 4,
> > +                                &address_space_memory);
> >      fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
> >      rom_set_fw(fw_cfg);
> 
> Gentle ping. The fix looks perfectly sane to me but I don't have any x86
> Xen HW to test this one. Are the x86 maintainers happy to take this on?

Yes. It looks like it works well with both SeaBIOS and OVMF, so the
patch is good.

> FWIW:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

