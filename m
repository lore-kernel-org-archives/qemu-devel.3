Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFA6F43688
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDft1-00013G-EK; Fri, 17 Apr 2026 05:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wDfsz-00012s-Oz
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:53:17 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wDfsy-0000iB-0w
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:53:17 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso15387555e9.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 02:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776419594; x=1777024394; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Sx4whYh0mPRZITS9VYtylGknT7f1uL4QP0rIfJIttHU=;
 b=bBASfh4XgqHPq1REH54/EM5nSj1FhzfkK8BptYMNWCbBvOzOxzRlxr4xfR0lsGBsSG
 /PvM5XyboaeplXSSEG3znMjq37CV5/M+YYAeZ/JVZ5dhCTpKxLph4fw0qVNvwhTEpluC
 EYIIXItXpLddnxB9GNeO3/O+V3C6xEc5o2/nsblSgdPLD42e8QykSwxw5HPpKm2RrUYF
 pg713/5sE8UqlZ5zyG0JGOosH1LcFMxRbzM9Sg3EITQXKKPfGrX97M285B1pazPvVaMj
 AM9v3s41E+8/MK2ALgq4yJ19/0aYeeK11/BSAhbduZPUw0250tZPLc0WAsa+jhcBvP3J
 2MUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776419594; x=1777024394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sx4whYh0mPRZITS9VYtylGknT7f1uL4QP0rIfJIttHU=;
 b=sndD2aJhF58Ci4G1SvMdHPQcRdOlJkXUrDxnJOwGoGuSHZbOhtSsYC3hQ/6UrX4GVb
 6g4mRJnxvAqgDzyc8ywa2Owx3/1HkmieGq8/xeHSwCFassZyQk4KIC45JUJaUs6p/dZj
 zrm1g4kYIybl3khtWRNxWoqtNifh/21ZsUpYAZrubtb+LpfDQCgeViKSBR9+d8QBikae
 R8PXBUf9N/+QFzAur5DRN2liWmwVCTeymLPzON6UcvPFQiEWzfFq8xlLwYM9IFf51FOF
 zDHaDWJIv2JllwIzwxT+wKr9QW0gwwABeNq/kOh7t6UPUuIZqEx6OK/qS0lODI8FB8uK
 k0DQ==
X-Gm-Message-State: AOJu0YwkR9ZSyjXryGMhLK4xGWBceCRi0DfIkckWDnDljoDTukGNntMN
 iQGQQNOFsZOznw1877TIzJJ7p2HfVonOe8l9zlJkzeWIFKWTxnytLpmBLWRA6rAIxnq5aisTOms
 VaIZu
X-Gm-Gg: AeBDiet+RFCmh3xq0+H2fOkTGVfIDrlFJ2Ic+RRF4ABCAfhLtCOdrIZLPvIUHeXdrj9
 5FRZ+buadL7aPoqm0fXCc9FE1qTLaIDgKzptI6I+KjwN9sq///HMuba81Bs/uyXQKUVC7UTLjgX
 ZnJiNOxYlIJVjbZ1952GEb1tBPsI06Q/QOoBssILbW7/YJR+btKpxBjmAl17MuET9YQaMD0jEka
 boqQqJ7bWFaxcgVYrtKlDZqkIS+gRFj+/oPdRV+sVNAVa0qUktypIHAno1DulYGjSXlHyXvTOKo
 yIgI/1F5Pv9aHTgAEOQ3++XsovZonlrlPAzr1+fo8SGhVtBC0ZCwhTtBeZHp/chFZM3Btr9R/se
 rTZ7/mb+mqhVxARnly9wTVD2/LUeM0kUiwtl2jouFMECaRkZHDVVMdxrrwbK3vqm5M1DFEaN4/0
 MKnj6/zVGPpiwfxBTOm+sAus4jUhzHqcWbE/E=
X-Received: by 2002:a05:600c:6089:b0:487:22ad:403e with SMTP id
 5b1f17b1804b1-488fb8ba594mr24729015e9.14.1776419593839; 
 Fri, 17 Apr 2026 02:53:13 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:d023:c0db:d3ea:590d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c96b4sm52427845e9.13.2026.04.17.02.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 02:53:13 -0700 (PDT)
Date: Fri, 17 Apr 2026 10:53:12 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: Re: [PATCH 2/3] target/arm/ptw.c: Add two new spaces to the granule
 protection case
Message-ID: <aeIDCF8FO8T9FEl1@linaro.org>
References: <20260416-jmac-feat_rme_gdi-v1-0-d9fa0781ed58@linaro.org>
 <20260416-jmac-feat_rme_gdi-v1-2-d9fa0781ed58@linaro.org>
 <5fb0432b-6c1c-40bc-b022-939d73f2115d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fb0432b-6c1c-40bc-b022-939d73f2115d@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32c.google.com
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

On Fri, Apr 17, 2026 at 08:36:52AM +1000, Richard Henderson wrote:
> On 4/16/26 21:12, Jim MacArthur wrote:
> > This makes no functional difference, it just marks out two cases for
> > future use.
> > 
> > Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> > ---
> >   target/arm/ptw.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> > index 7b993bb5b3..d4b63a365a 100644
> > --- a/target/arm/ptw.c
> > +++ b/target/arm/ptw.c
> > @@ -510,6 +510,11 @@ bool arm_granule_protection_check(ARMGranuleProtectionConfig config,
> >           break;
> >       case 0b1111: /* all access */
> >           return true;
> > +    case 0b0100: /* system agent only */
> > +    case 0b0101: /* non-secure protected */
> > +        /* System Agent and Non-secure Protected are GDI extensions. */
> > +        /* No processing element should have access to these. */
> > +        goto fault_walk;
> >       case 0b1000: /* secure */
> >           if (!config.support_sel2) {
> >               goto fault_walk;
> > 
> 
> There's no real point to this patch, since we get the same effect from the default case.
> 
> It should be trivial to "properly" implement these two cases for the CPU, since
> 
>     R_QCLPTA:  PE is not permitted to access memory within the NSP
>     or the SA PA spaces, from any Security state.
> 
> Access to these spaces is only allowed from external devices via the SMMU.
> 
> The only effect on the PE is to check the various GPCCR fields (SA, NSP,
> NA6, NA7) to transform them from one type of fault to another: fault_walk ->
> fault_fail (i.e. break).

The thing that held me back here was the mapping from 'Reserved' in the table in D9.6.5 to fault_walk, which wasn't clear in the documentation, and hence leaving the behaviour unchanged. However, I would agree that we can map (GPCCR.SA=1, gpi=0x0x100) to fault_fail and so on and leave the (SA=0, 0b0100) case to what it would have been before (fault_walk).

Thanks for your feedback,

Jim

