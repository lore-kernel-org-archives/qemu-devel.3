Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FD2F99C73
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 12:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wE58p-0006E5-Or; Sat, 18 Apr 2026 08:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wE58f-0006AJ-KQ
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 08:51:09 -0400
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wE58e-0005tW-8F
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 08:51:09 -0400
Received: by mail-vk1-xa44.google.com with SMTP id
 71dfb90a1353d-56eee0ba462so1012766e0c.1
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2026 05:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776516666; x=1777121466; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QygBdhO79xgysSRFhBuUc1cMhOqmKQkyHrME/aT5wYY=;
 b=iFdlVKLHWzqrXAZwm8Ty8gBtqJXl6pTULl/IBTLlmNjZLItnHnmomMpquUfUYVcir9
 PTCQ59JVbFBcJ474KaoLhbDmTiqEnCjTBGctH1geWQY5uRXlvXbcIkI0Rd3Tlz7mm87i
 Lp/uw3dIPhQQFzoIGvkCtaqtdeE+9S1FZD+VyNtMYflQHkEzqyCr4pSLWESdUGfpDj2a
 9orlPzo9sGIUBlVlElSPvZU6mP50YeRGKmloQAy0U9o8PvyFge/BO31/NHwnKq5g8nUx
 jzYEU8GJwbvC2SjJllMR3cmmSq6/O88dvuQeCWDCUdCgh/zum6Zccdij/DkmoHcTSZAU
 6jYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776516666; x=1777121466;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QygBdhO79xgysSRFhBuUc1cMhOqmKQkyHrME/aT5wYY=;
 b=H8Xe1OBVRPWA0HHUv8TuuMYW5goqFvHwmOpVOG8NlsTdewn6aitw6EC8cFSqyvDI7A
 kn2ePnX8mepxMTxRjmycT4hUg8PqkPjVyMofB3JRn4lnnOABEuPG9ZwVibCX/XEO/iHF
 IyBUuxOEFxDwEY5VcYi9cZF8p4ECtlMJKKHiICorSV5e7eLd17pmQjUzHFexDU/LWatx
 FC7+IDA2QtnSFrKN0eVkoIBkdQpLtWYnMwDWhIyBsDtvdYpEUmuGlXqo3/c0aRdvaT7K
 iBfZoY3VzZnkMfxyd8xdi95H7KotJ9sTC/wCVuF4VYmWtrh9Y9pB0DT9incAeF5abu5E
 c62A==
X-Forwarded-Encrypted: i=1;
 AFNElJ80KkjpR4kJf2VXtCthH88LA5OT1m6metslZux+fAFrTCSCHMdTWgdNd/qrrvXiTC7LcKbJ225tIJbD@nongnu.org
X-Gm-Message-State: AOJu0YyYYMp6ehRKPSeKEHJEyXlaCLALZwDvb6K6WbG4b6eYFRAUVWBs
 V/jayKDBIs68mxx34EMffVqFlfMmIBteZoTUhD3JivWq65I/WYfg38Hy
X-Gm-Gg: AeBDieuRY8vKWlTLrp66E2T1e7+7tcvyhe/VcjwRA1PCoftoTmW5Yf9/XMUl+bESu1E
 zAhdvEg2LJrhFX7LCvyOPtGIlJTVCpuibnyFgg6/RKfGj8eX6D9+C5kExb0IJx89kQdi9yMS0Ia
 zMoiZzbioZg6UFyhP745sUTHEEU0dQx2x/8mrD8ChzYELK1pG1XI/0P2pemNf8uSZdGCMXIBqmX
 u2b2yubXApFOzzMvlZYkSXPgNRorYpKYUjN1kt4pgcwRAbae3b3jy9eSm5gNg3c25uOV3UlW7mJ
 XhCl/5l2yrdPqjaX3gPzga6v9Cn2bjWxMDXVQUKJtfy1zCFM1X1psvniagdhchT6W+fk+27rJhx
 2ujGBncaPKgodMQLOJbl72oZgcxsqoiHcyjxUvp6jDrtSUzyfV+W7K616GalQf2bxCgB8lwGrun
 fkmaO00E3s7JvG1agbTUCQMewMqXsCk+mR/wehW0EC6RY29hwNK7Akz0DUU04xfLAAAKr/tp9wu
 qVhPGm65N8=
X-Received: by 2002:a05:6122:e463:b0:56a:8f7c:49aa with SMTP id
 71dfb90a1353d-56fa6673ee5mr2211316e0c.4.1776516665553; 
 Sat, 18 Apr 2026 05:51:05 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56fa91ed4e1sm2943856e0c.6.2026.04.18.05.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 05:51:04 -0700 (PDT)
Date: Sat, 18 Apr 2026 20:50:46 +0800
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
Message-ID: <aeN8_neNMctXKOgi@ZEVORN-PC.localdomain>
References: <cover.1776438369.git.chao.liu.zevorn@gmail.com>
 <e1a977e38c934a7f383530067230a6201b8ccc60.1776438369.git.chao.liu.zevorn@gmail.com>
 <20260417-glutton-bunny-d378acda90ae@spud>
 <aeK7rD8KAe9nbsFm@ZEVORN-PC.localdomain>
 <20260418-tidal-algorithm-52c79c2d303e@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418-tidal-algorithm-52c79c2d303e@spud>
Received-SPF: pass client-ip=2607:f8b0:4864:20::a44;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-vk1-xa44.google.com
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

On Sat, Apr 18, 2026 at 01:18:54PM +0100, Conor Dooley wrote:
> On Sat, Apr 18, 2026 at 07:02:42AM +0800, Chao Liu wrote:
> > Hi Conor,
> > On Fri, Apr 17, 2026 at 08:15:48PM +0100, Conor Dooley wrote:
> > > On Fri, Apr 17, 2026 at 11:11:25PM +0800, Chao Liu wrote:
> > > > From: Chao Liu <chao.liu@zevorn.cn>
> > > > 
> > > > The C908 processor is based on the RV64GCB[V] instruction
> > > > set, compatible to RVA22 Profile and implements the XIE
> > > > (XuanTie Instruction Extension) technology.
> > > > 
> > > > Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> > > > Suggested-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> > > > Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > > > Reviewed-by: Conor Dooley <conor@kernel.org>
> > > 
> > > Uhh, I don't recall ever giving a r-b tag for this, never mind the fact
> > > that I never provide tags with this email address.
> > > IIRC I just commented about svpbmt being missing or something along
> > > those lines.
> > 
> > Thanks for catching it, that tag shouldn't have been there.
> > I've dropped it locally and will leave it out next version.
> 
> And go double check that the other one is real too.
> This isn't the sort of thing that you can get wrong by accident,
> since you'll only ever be copy-pasting tags from a mail or using
> something like b4 to update them.

Good idea, thanks again for the suggestion, it helped me a lot.
When I first started getting involved with email patch communication,
I often couldn't figure out how to add tags, but now I'm very clear
on it. In my last reply, I already accurately verified the tags
across the entire patch set. Which other one are you referring to?

I now understand how to use b4 to update tags, previously I was
still copying them manually...

Thanks,
Chao


