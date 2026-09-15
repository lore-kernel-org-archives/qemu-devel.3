Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13EAC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 09:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6PZF-0004MD-4O; Tue, 15 Sep 2026 05:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x6PZC-0004LX-L8
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 05:35:06 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x6PZA-0001tt-KF
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 05:35:06 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4d2fe205dso34549a12.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 02:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1789464903; x=1790069703; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4zaIBjHcsHYPtkSCBKj3hINiO9QXwOoi4ET+d1skbXI=;
 b=jto6Ky1ztFLVM8KKl5mOwThmeP+S1vBRx2toE700ZeTxqAChe/cVANYXEEAwpke85J
 vWc8XTttOQUxTZvNa4pKLBRuI8F3Obx6FWF9asZfOkpiv9VpHzeVirwRfkLW3lF4S62f
 SrYHiJeJBVUoMKezwPknN3sUxlwxJ016qungv+wTwmw8NldtyZj6ofbHa2dYot/6KURT
 5GaToXZLEgUql5/XIH4yFxbwR8i8Fvs584vASU4rifLsv13vbPNJBL3AhdRkw7OFUfHR
 1ZiKReU5XU1buJPGnbgwsc8Wms5YffyRZKYmX3sscMKyAn+Ztqoh2EVyy27P8xq9+1+N
 SHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789464903; x=1790069703;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4zaIBjHcsHYPtkSCBKj3hINiO9QXwOoi4ET+d1skbXI=;
 b=TCyfAr/RVhv68zh33L9I193yLTpmARiKqNyHdJrbqxn7fSrfhWARZso7F+pRB0kib7
 Olphm4dM+5ayiwnI9pznEicNS4M4bul/v3hRqfe1VyokxYJhj2pkAyaJ7szOjYW2hz9W
 16izSMRgydsmLAbv3DIqeTIUs652g4dfuO10XESyuq1OaQCF1/6Znh1/IKP7tzUVYmhS
 08GV3yUFaR0dlUCCryi9StFgNTOLeZ97m64naOFBoG/yai99nsYjCD+rmBtX/99rQYCx
 O4X7QCBNCjDmmbSJ05hZTiopt1EV+T4a76CFuW45swJo3P064NC8vdC3FBA7jSxyquIn
 1TwQ==
X-Gm-Message-State: AFuF++kHcHnvk/BHklMZV+zHD9MxrGAkvzyoqs0k//LOEXP1orj4KDab
 Uw8kqUiSUkhyeKbeTjU7+LybqabVT/e4cwwR9y7hSX07bDA7sy6eA6FhUk5bN9RU1wg=
X-Gm-Gg: AYBFou2j+ku5PCbX+ekMcuq5wHcZX16NlT9Yw2l7w8zaHOBrcFflx2Df7tKh1GmmB5E
 KGf+cBL1NtrSJTZuvAvdCZNAi9tT0ei2rJ1XnDyeWbJT2fnOHiaCn67WJhL5mVUOsTC2/gn4Thy
 JsGXDeKlG/L89jxHT9bggYOXWWckLR3ifUFzxsDtk3ua5uHW4OxMz7NB/Ft90UCJQUSrqUezM2o
 kcxCHT3+pXdo+kDCeSPQeR4G278d6zWfiQ6BW3DvqMgGTabsJB5B7p5l40+7lt2YuGpXfJStMUZ
 /pb2C/EsA4hu4qx6ZHO7Rq6Zn/6N/pRoS9/8AYsCaBZzSwUdj0EeRt40HYj99m2JgqUkPwATzIA
 k8Ln3qQ2AC3RGx2M+e5pUA5moF6b/CceiGxbiyRhV+PiRHgIj8C0klUaBXlO92RSI4w63JoiUaV
 a4Zf4Z4lhxGiONG68OOdEsIT/2Lez13rCLuWyEa4sBsu1jwxMluxsYl0fBjLvanilhzAwEMM1au
 3hpVpjziUtKBVJMxYcI7dM=
X-Received: by 2002:a05:6a21:112:b0:3da:f32e:b3bf with SMTP id
 adf61e73a8af0-3dd528504a7mr878719637.17.1789464903109; 
 Tue, 15 Sep 2026 02:35:03 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc4c6549d95sm6303718a12.12.2026.09.15.02.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 02:35:02 -0700 (PDT)
Date: Tue, 15 Sep 2026 17:34:58 +0800
From: Max Chou <max.chou@sifive.com>
To: Chao Liu <chao.liu@processmission.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 richard.henderson@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 3/6] tests/tcg/riscv64: Add vector masked
 fault-only-first PMP test
Message-ID: <aqkQqxqtRc0ypdbd@sifive.com>
References: <20260909084154.223529-1-max.chou@sifive.com>
 <20260909084154.223529-4-max.chou@sifive.com>
 <aqOSwMCX5UsGJA79@MacBook-Pro-4.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aqOSwMCX5UsGJA79@MacBook-Pro-4.local>
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=max.chou@sifive.com; helo=mail-pz2-x10.google.com
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

On 2026-09-11 13:49, Chao Liu wrote:
> Hi Max,
> 
> On Wed, Sep 09, 2026 at 04:41:50PM +0800, Max Chou wrote:
> > Add a bare-metal test for masked vector fault-only-first loads across
> > locked NA4 PMP regions inside one page. The test covers masked-off
> > elements, a faulting active element 0, and later active faults that
> > shorten vl.
> > 
> > Signed-off-by: Max Chou <max.chou@sifive.com>
> > ---
> >  tests/tcg/riscv64/Makefile.softmmu-target |  13 ++
> >  tests/tcg/riscv64/rvv-ldst.inc            |  91 ++++++++
> >  tests/tcg/riscv64/test-rvv-ldst-ff-pmp.S  | 259 ++++++++++++++++++++++
> >  3 files changed, 363 insertions(+)
> >  create mode 100644 tests/tcg/riscv64/rvv-ldst.inc
> >  create mode 100644 tests/tcg/riscv64/test-rvv-ldst-ff-pmp.S
> > 
> > diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
> > index f2c75abd57a..0fdf242f735 100644
> > --- a/tests/tcg/riscv64/Makefile.softmmu-target
> > +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> > @@ -85,5 +85,18 @@ run-test-vle32ff: test-vle32ff
> >  	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true $(QEMU_OPTS)$<)
> >  test-vle32ff: CFLAGS += -march=rv64gcv
> >  
> > +RVV_LDST_MARCH = -march=rv64gcv
> > +RVV_LDST_TESTS = test-rvv-ldst-ff-pmp
> > +CLEANFILES += $(RVV_LDST_TESTS)
> > +
> > +$(RVV_LDST_TESTS): %: %.S rvv-ldst.inc $(LINK_SCRIPT)
> > +	$(CC) $(CFLAGS) $(RVV_LDST_MARCH) $< -Wa,--noexecstack -c -o $@.o
> > +	$(LD) $(LDFLAGS) $@.o -o $@
> > +
> > +EXTRA_RUNS += run-test-rvv-ldst-ff-pmp
> > +
> > +run-test-rvv-ldst-ff-pmp: test-rvv-ldst-ff-pmp
> > +	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true$(comma)vlen=128$(comma)elen=64$(comma)vext_spec=v1.0$(comma)rvv_ta_all_1s=true$(comma)rvv_ma_all_1s=true $(QEMU_OPTS)$<)
> > +
> Just a heads-up, TCG tests are moving to Meson build, so this needs to be
> based on:
> 
> https://lore.kernel.org/qemu-devel/20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com/
> 
> Thanks,
> Chao

Hi Chao,

Thanks for the information. Daniel also shared the same information to
me.I will send v2 for this TCG test build flow.

Thanks,
rnax

