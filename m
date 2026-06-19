Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84222CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waWwI-0001uu-9o; Fri, 19 Jun 2026 06:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1waWwG-0001ul-IW
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:59:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1waWwF-0004T0-3S
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 06:59:08 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4923139e940so11582565e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 03:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781866745; x=1782471545; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0TjBnuCa2FWH4DItOTNXoD1CfKJin2kYETMGPPXd+1E=;
 b=sG1QvbySdxjL4Tzs7Z4qThxRjFMLSXAebDJBvCLYgZlxQzCGva6Z5ZsgOzx+51KKIM
 SLEAl1T30ogyNDgnBDZZqrya1qnNK5B0izK0K29OhKsPSDUZam+Zq8nZ9VtK9sFfloaT
 zLfxqt5fDqhv73ls9ihdkbyeFmpZDsphDopnK3elR7uIldwrVVYKrPchkpLS25aorhg2
 WcGNIgVcFJ//bvwY45woM38Q99/a1o/hpzPYZ9kaSLfMeSKu+VzKOSDuAx+S5An7jTg2
 Sau+PUY1N2K4kPlewhECnfyyHtZRw7BmjMvfwzDK2gdy0Fkv/48kjirtQrPkEbx6tP8q
 8DdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781866745; x=1782471545;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0TjBnuCa2FWH4DItOTNXoD1CfKJin2kYETMGPPXd+1E=;
 b=k3SJghCyK5iAlQlig1hNjkRMgoGoK51ZuqLqkayN2LU6NzJeA8D0A31+fI5YQQXAXC
 fiPRL201vViTW7byiPvWlS+mP0Plvnu1hbGPGWWm378qapuFP/t0PaFypNZkM6oN+Mb1
 ok63G+rl+jJTXJoEp7nlU18oXfKIub+r8kFckg3+VoeBcO1qL6O1LKoeiDu49YjnOejg
 Y/WgqPALyUVsf/RGhThJ4RX07xTCuCDg9Rdew4iVnxTsTdJlZEkg8sKfnQL0juif2gUu
 7fJ7QBy0RILtbaIMNQB2yyezxu8OoI2+iXnPJHGJnz4dZMfzMED0P5RyIEUb4wt3Dfpj
 i+nw==
X-Gm-Message-State: AOJu0YyndJQTrFqIzt5ojurDTpHQv+vN2C8x5wMca1QCvajYp/8Vvtqj
 5TTif4paN3IeUzEUnADBKCPc+tszsEJQKEmOr1Qeqn+KxK6v5UWe4M7wOnxrYowVyA+MkvrnUEX
 XuPPQ7q0=
X-Gm-Gg: AfdE7cn4HRUrr78T7tkNuE3HL5cc74+a7bOGSEPpCnwLQFeygFpcF+1pZQEGtRlJxNA
 aWjOJkzXVEXWVvPRlVh0PZ44yms0H2eX85h04vIUV69SHXRZvJTAM8i4iViNqMUUJb9FLXh0G0L
 GHJG6y7b20zyynuvBHcECZANdpJ0rQrhS6evKajG9czQAbLl9taSw+iUMCGU32HWohSM/OJDWbz
 cnsDUZCyB9ngOvvkHDDvDZ+6F3ncg7zLaxgqQL5MDLeJ0k8RiTJ35r3XLgBxAOyhBmb/VcMR3BD
 qe1/4vF5wasaicvwJ+319Jb5HmdlSZhyYSwqsBXhtoMhb6btcgnm4p0O6Kz1avJlHkLUkDtE7b8
 CK+jQGc/bnJYBWfeaMZQprn6bnRV3OHSrMwFSDU3FtM4lvgracG9SjuSgvZOqDiJjMNBltFcmSY
 hq8TRPVUPbMZ1y
X-Received: by 2002:a05:600c:314f:b0:490:a298:3859 with SMTP id
 5b1f17b1804b1-492425706b9mr29413575e9.24.1781866744547; 
 Fri, 19 Jun 2026 03:59:04 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:b52:6a9:569d:e33e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4650b67a3e8sm6752997f8f.19.2026.06.19.03.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 03:59:04 -0700 (PDT)
Date: Fri, 19 Jun 2026 11:59:02 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org
Subject: Re: [PATCH 2/3] tests/tcg/arm: Tests for new FPRCVT instructions
Message-ID: <ajUg9sIsy9if_JM0@linaro.org>
References: <20260618-jmac-fprcvt-v1-0-1b4475bacf51@linaro.org>
 <20260618-jmac-fprcvt-v1-2-1b4475bacf51@linaro.org>
 <878q8cgeux.fsf@draig.linaro.org>
 <16d97ff2-7e12-49ee-be1f-315f1387ba71@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16d97ff2-7e12-49ee-be1f-315f1387ba71@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32b.google.com
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

On Thu, Jun 18, 2026 at 08:04:27AM -0700, Richard Henderson wrote:
> On 6/18/26 06:25, Alex Bennée wrote:
> > I'm not sure about this as now we have one test with two modes. Can we
> > not just create a new binary (fcvt-fprcvt) and keep running the original
> > test either way.
> > 
> > See how we do that for the sha512 and it's various vector variants.
> 
> You certainly don't want to be duplicating the reference file.
> 
> Perhaps test the v8.0 convert insn output vs the FEAT_FPRCVT insn output directly?
> 
> Also, this patch is ordered incorrectly.  With the instruction feature test
> properly in place, it will fail without the final patch to enable the
> feature.

I would rather not duplicate the reference file, but the other options include significant changes to the existing fcvt.c test.

We could:

1) Make a separate fcvt-fprcvt.c test which compiles with the fcvt.c test, needing a header file for functions - requiring a much smaller separate fcvt-fprcvt.ref file, but information would still be duplicated in it
2) As you suggest, do a direct comparison between the general register and SIMD/FP regs, but since the current tests just output strings, it would require a significant change to how the current fcvt.c works.

I will probably do the second option, but if anyone has any other ideas I'll listen.

Jim

