Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38240F99C63
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 23:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDsDI-0007vX-CT; Fri, 17 Apr 2026 19:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDsDG-0007uz-Mm
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 19:03:02 -0400
Received: from mail-vk1-xa42.google.com ([2607:f8b0:4864:20::a42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDsDF-0005FE-Ba
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 19:03:02 -0400
Received: by mail-vk1-xa42.google.com with SMTP id
 71dfb90a1353d-56e91f17a99so806725e0c.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 16:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776466980; x=1777071780; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Yhj++mJHFlEmgTuyfcUaHZvCWYXAcFKcrC24ksM8zHc=;
 b=FJ6AJ4HlCCu1SXWkBFrSSPZeAuEeL66Tike+iUB0Opbd3ZHUFPA6Wx/IlVAiF0xQoc
 HWhU0mE568hDTbUlf9yE52Glb8kQGamoXLud/wFvZSnG4II6o+kO8SkwSvg/eKd2Va5W
 zXwHyuqKLSzdm0i4NaBkhVPaddrSWQa3Hy6n+ilXXNYEwlB3005CI1ZCX19J3w/ZOSZQ
 OwzQWh1N0UMmZ3Tp3RRRveAEOABBH3FdtNVdYj3t3+dMZhzKMXFZTTywXiWJRaX78XC9
 ShQ7OfdOdzeImwoEGzqvwCABnZGpivPs8wPh4k+2emIBzzMyrhDHCRsRHSOyp0Uk4avv
 FMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776466980; x=1777071780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yhj++mJHFlEmgTuyfcUaHZvCWYXAcFKcrC24ksM8zHc=;
 b=a28WEpbiiTXbWkCZr+dbejTw7xelShvysLU8T1yzNt4QmJl1mV3nF+xioa7thBtb7P
 LlOVDxa80RMdUbUaMYf12WJ2aNffn9CVDLMPIqPnuuiZkWfr0yBVcIV7iKjqn2INRLeu
 6umugrnTmViof42wXfYpmNP/2yrzAnuLXBm7lyWPTGuVtV+Im1YBpliMMmFeTFlNnaLA
 ZapmZkxjAIfXoEPgCFuv8KWkrapWwNbQierLtg2PwZF5l1urhEBYU0c4d2z22Fez3CGw
 k5MbkzdwBl6y8CSpHeF4t4dG5NSjxoUf6kaNb8jWXDtLqYNoK37Yk7LkTSJDeStPEVTz
 cKKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gpe0QAjVUp+V2l+nFNyAwV/lhan8/ilTwV/GIHgTVDESYCTBju3z1cu6J/T3LWRmM0tKDi/cpUXSX@nongnu.org
X-Gm-Message-State: AOJu0YyIavK6MTmznRR1EZdb4UOg0c4HkW+0pG2SeSNqOhDBiB3Yf3tK
 JXEkNkXHhW8TzMjUr3g/W9Bo/Y60BzFJgUvUT7zeBKkXI4+OdvbGO22d
X-Gm-Gg: AeBDiev6frDJjZ7lQmyu5iXG9drc9OioH76WlED8i3uC1HTzv+Vt+QhGTp81eUH2aJL
 PdM36LB6m6dqdEopN4ALxQYSBo0OmcrOapi/pkQuEVjUlW/PHDeraYwTYc3nkc75EONQVXXXH1f
 awggnAPExINIg1+PyBYGp4IgatakdoE8llskw0v5eViPDQB/zuESf2QgTBtdRCc0J3FIsnjW5RR
 xdkdfVLGg5FLT+PKUeteBdm04G35mGvmpw/ZyRM8RMi1y2fJm8qJxx3f0n5Cngp5446i9yBXYIl
 p7Zc+SCltD2dBLykZuD5Nlh3bcNHIMUvJy+dhCOLcP46Kj6OgmEkGplJF5VWWHTJLwcmDoW3XrB
 hZSutF8toEHYTilSds4z1WQ0+j6Y8NEphV5bgteSUpCsQLXmvjcxSeA2lonRDEML4M8ypaNDfxS
 ZE283CplhMm2SECy37kIezhDvcUs0Xerw8uMbg3pJMrgsVGvqDe36rtCFLXNTTaBjcVLIcW7Ynm
 k+0F4vQCsg=
X-Received: by 2002:a05:6122:8898:b0:567:44ba:bd8a with SMTP id
 71dfb90a1353d-56fa59daac2mr2191725e0c.9.1776466979460; 
 Fri, 17 Apr 2026 16:02:59 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56fa91bf90fsm1777898e0c.1.2026.04.17.16.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 16:02:58 -0700 (PDT)
Date: Sat, 18 Apr 2026 07:02:42 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Chao Liu <chao.liu@zevorn.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Peng Jiang <3160104094@zju.edu.cn>
Subject: Re: [PATCH v6 1/5] target/riscv: add thead-c908 cpu support
Message-ID: <aeK7rD8KAe9nbsFm@ZEVORN-PC.localdomain>
References: <cover.1776438369.git.chao.liu.zevorn@gmail.com>
 <e1a977e38c934a7f383530067230a6201b8ccc60.1776438369.git.chao.liu.zevorn@gmail.com>
 <20260417-glutton-bunny-d378acda90ae@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417-glutton-bunny-d378acda90ae@spud>
Received-SPF: pass client-ip=2607:f8b0:4864:20::a42;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-vk1-xa42.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Conor,
On Fri, Apr 17, 2026 at 08:15:48PM +0100, Conor Dooley wrote:
> On Fri, Apr 17, 2026 at 11:11:25PM +0800, Chao Liu wrote:
> > From: Chao Liu <chao.liu@zevorn.cn>
> > 
> > The C908 processor is based on the RV64GCB[V] instruction
> > set, compatible to RVA22 Profile and implements the XIE
> > (XuanTie Instruction Extension) technology.
> > 
> > Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> > Suggested-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > Reviewed-by: Conor Dooley <conor@kernel.org>
> 
> Uhh, I don't recall ever giving a r-b tag for this, never mind the fact
> that I never provide tags with this email address.
> IIRC I just commented about svpbmt being missing or something along
> those lines.

Thanks for catching it, that tag shouldn't have been there.
I've dropped it locally and will leave it out next version.

Thanks,
Chao


