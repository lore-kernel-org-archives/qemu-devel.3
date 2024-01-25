Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EF5C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 11:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSy7K-0001do-7w; Thu, 25 Jan 2024 06:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rSy7D-0001cW-Qs
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 06:41:53 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rSy77-0007lL-18
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 06:41:48 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55c1ac8d2f2so5753350a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 03:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706182902; x=1706787702; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tlIg1ioriM7mX8+RYlQYJvoj00rwt6syn72TbvjwLGc=;
 b=mYahnpmF/Ofox04HiDh9fjbm7QexyEDErBbwnrESGZdSPvDbvRvV12T+FlkVJQwEEx
 KP1cCMtJmNxY/ad+lD/jJq4X+Z0TayVuBzogQcBxuOXa+gnRfXyTQugaub4wARgOV1ip
 zilJARHO9aquwXPcMarm6TKXg3v3oMqWjmoIXNcwE/ApSADR6c5WJnbQko2COwsITRzi
 vcWK3jX1KqU8crD1bo+vKTZRTmGXuYrfjQbI5nFTzZfh5PAdp/ZyedOXXrqijCcRugw3
 V87OFyzHTF3TX+OfVnoi+WswMnM1IzyhgPEuztJjo7RvHjS4IT/bWHMfRC0+iFGHSFpm
 k5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706182902; x=1706787702;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tlIg1ioriM7mX8+RYlQYJvoj00rwt6syn72TbvjwLGc=;
 b=aeWmiwsU/+8yhpWjwV4lMPFes8J7cAb7LBbkB+ViIrex2lp6Ok7A//EHsvmuYhTjuR
 ZS1JMJ8/a08cuewvPJq5BVxvOsmyZWzF0yS0zhxDLAD65YXNd4ICgOo3UUrJtw8oZVp2
 sAlq7KgPRQK6MDcbVsiw+flIC6XMJGC9llFJdtaegsrdkwi8BiCLysSDrqafCYk+glRX
 RwOrPfZzhd1vbXnTaUMDxd+1bFkgbLc22wGzE+ZVkEPi/z3tF8EBlDjDK+eBxJKTe5Nz
 nOUSUbKSW9BUdcNgCYTGcA6ylmBRMXT+t35YH/52QHoj97E3VNdfaDX3BB2uW0l9mAmV
 uGqg==
X-Gm-Message-State: AOJu0Yyz/DJgT0TiKU7j1y2bKANz/T9YLCTlsSGP12rvx4Gaargl2R2i
 OvtHfKW5aY/YM1ZIzfqB4PRrG6E6UAHhAsEfhghp70cJKkrpS6ukPc/o//dM/hQ=
X-Google-Smtp-Source: AGHT+IFkyRmD2hzS1gOnNZnLdv8EIZ8KrezT8Nj5/WaffSq6c11w7MGu1/Ch650W9qnJD8fVmx2Rqg==
X-Received: by 2002:a17:906:dd0:b0:a30:ad90:22a with SMTP id
 p16-20020a1709060dd000b00a30ad90022amr536503eji.94.1706182902334; 
 Thu, 25 Jan 2024 03:41:42 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 ep21-20020a1709069b5500b00a2ae7fb3fc6sm956224ejc.93.2024.01.25.03.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 03:41:41 -0800 (PST)
Date: Thu, 25 Jan 2024 12:41:41 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Michael Rolnik <mrolnik@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, kvm@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Laurent Vivier <laurent@vivier.eu>, 
 Yanan Wang <wangyanan55@huawei.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, 
 qemu-s390x@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>, 
 John Snow <jsnow@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 David Woodhouse <dwmw2@infradead.org>, Cleber Rosa <crosa@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 Bin Meng <bin.meng@windriver.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Aurelien Jarno <aurelien@aurel32.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, 
 David Hildenbrand <david@redhat.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>, 
 Eduardo Habkost <eduardo@habkost.net>, Brian Cain <bcain@quicinc.com>,
 Paul Durrant <paul@xen.org>
Subject: Re: Re: [PATCH v3 01/21] hw/riscv: Use misa_mxl instead of
 misa_mxl_max
Message-ID: <20240125-61a7ba58367f81afbe444a50@orel>
References: <20240122145610.413836-1-alex.bennee@linaro.org>
 <20240122145610.413836-2-alex.bennee@linaro.org>
 <20240123-b8d1c55688885bfc9125c42b@orel>
 <15d2f958-a51e-4b87-9a70-28edf3b55491@daynix.com>
 <20240124-3d9bec68bff7ab0057b902b6@orel>
 <246ea370-934e-4666-ba73-b49c3ff6e531@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <246ea370-934e-4666-ba73-b49c3ff6e531@daynix.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=ajones@ventanamicro.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jan 25, 2024 at 05:23:20PM +0900, Akihiko Odaki wrote:
> On 2024/01/24 17:16, Andrew Jones wrote:
> > On Wed, Jan 24, 2024 at 12:08:33PM +0900, Akihiko Odaki wrote:
> > > On 2024/01/23 17:20, Andrew Jones wrote:
> > > > On Mon, Jan 22, 2024 at 02:55:50PM +0000, Alex Bennée wrote:
> > > > > From: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > 
> > > > > The effective MXL value matters when booting.
> > > > 
> > > > I'd prefer this commit message get some elaboration. riscv_is_32bit()
> > > > is used in a variety of contexts, some where it should be reporting
> > > > the max misa.mxl. However, when used for booting an S-mode kernel it
> > > > should indeed report the effective mxl. I think we're fine with the
> > > > change, though, because at init and on reset the effective mxl is set
> > > > to the max mxl, so, in those contexts, where riscv_is_32bit() should
> > > > be reporting the max, it does.
> > > > 
> > > > > 
> > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > Message-Id: <20240103173349.398526-23-alex.bennee@linaro.org>
> > > > > Message-Id: <20231213-riscv-v7-1-a760156a337f@daynix.com>
> > > > > Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> > > > > ---
> > > > >    hw/riscv/boot.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > > > > index 0ffca05189f..bc67c0bd189 100644
> > > > > --- a/hw/riscv/boot.c
> > > > > +++ b/hw/riscv/boot.c
> > > > > @@ -36,7 +36,7 @@
> > > > >    bool riscv_is_32bit(RISCVHartArrayState *harts)
> > > > >    {
> > > > > -    return harts->harts[0].env.misa_mxl_max == MXL_RV32;
> > > > > +    return harts->harts[0].env.misa_mxl == MXL_RV32;
> > > > >    }
> > > > 
> > > > Assuming everyone agrees with what I've written above, then maybe we
> > > > should write something similar in a comment above this function.
> > > > 
> > > > Thanks,
> > > > drew
> > > 
> > > The corresponding commit in my series has a more elaborated message:
> > > https://patchew.org/QEMU/20240115-riscv-v9-0-ff171e1aedc8@daynix.com/20240115-riscv-v9-1-ff171e1aedc8@daynix.com/
> > 
> > I've pulled the message from that link and quoted it below
> > 
> > > A later commit requires one extra step to retrieve misa_mxl_max. As
> > > misa_mxl is semantically more correct and does not need such a extra
> > > step, refer to misa_mxl instead. Below is the explanation why misa_mxl
> > > is more semantically correct to refer to than misa_mxl_max in this case.
> > > 
> > > Currently misa_mxl always equals to misa_mxl_max so it does not matter
> > 
> > That's true, but I think that's due to a bug in write_misa(), which
> > shouldn't be masking val with the extension mask until mxl has been
> > extracted.
> 
> misa.MXL writes are not supported since the MISA write code was introduced
> with commit f18637cd611c ("RISC-V: Add misa runtime write support"). It
> doesn't matter if we allow the guest to write MXL; the firmware code is
> emulated by QEMU when QEMU loads a kernel.

Of course it matters. mxl will only change if we allow the guest to write
it. Being aware of when/why mxl changes, i.e. is no longer equal to the
max mxl, is the whole point of this patch.

> 
> > 
> > > which of misa_mxl or misa_mxl_max to refer to. However, it is possible
> > > to have different values for misa_mxl and misa_mxl_max if QEMU gains a
> > > new feature to load a RV32 kernel on a RV64 system, for example. For
> > > such a behavior, the real system will need the firmware to switch MXL to
> > > RV32, and if QEMU implements the same behavior, mxl will represent the
> > > MXL that corresponds to the kernel being loaded. Therefore, it is more
> > > appropriate to refer to mxl instead of misa_mxl_max when
> > > misa_mxl != misa_mxl_max.
> > 
> > Right, but that doesn't say anything more than the original one line,
> > "The effective MXL value matters when booting."
> 
> What do you think is missing?

Um, what I wrote below...

> 
> > 
> > What I'm looking for is a code comment explaining how riscv_is_32bit()
> > is always safe to use. Something like
> > 
> >   /*
> >    * Checking the effective mxl is always correct, because the effective
> >    * mxl will be equal to the max mxl at initialization and also on reset,
> >    * which are the times when it should check the maximum mxl. Later, if
> >    * firmware writes misa with a smaller mxl, then that mxl should be
> >    * used in checks.
> 
> It is misleading to say the maximum MXL should be checked only at
> initialization and on reset. We can refer to the maximum MXL anytime; we
> just don't need it to load a kernel.
>

Of course mxl_max can be checked whenever one wants, but you're changing
a function named riscv_is_32bit(), not
riscv_is_32bit_when_loading_a_kernel(). riscv_is_32bit() is used in
contexts where one should be concerned as to whether mxl == mxl_max
or not, because what they really want is the max. The comment I suggest
will allow them to rest easy.

It's concerning that it doesn't appear you were aware that
riscv_is_32bit() is used outside kernel loading contexts, which means it's
unlikely you knew it was safe to make this change at all... I'm actually
starting to think that maybe we should not make this change.
riscv_is_32bit() should always check mxl_max and something like
riscv_effective_mxl_is_32bit() should check mxl.

drew

