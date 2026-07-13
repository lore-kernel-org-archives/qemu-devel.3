Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21AFC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 09:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjCqP-0004y9-AE; Mon, 13 Jul 2026 05:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjCqN-0004xj-9G
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:20:55 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjCqL-0000L0-Q4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:20:55 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-66628618509so3498265d50.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 02:20:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783934452; cv=none;
 d=google.com; s=arc-20260327;
 b=TuMpbcHWirYxG6njLtpnOCl8Daf/9SFiwrfWm7zhNTlNfgOKfNVliDT5FMg2i3E9ro
 ZYMMtVz4Mbz9mwVSoFoLblIxZowwm1jgqrB2KMBfy8OdlS+dWEsEdW/nkM4EdTerczbj
 afkKX7MVC9H60zfGZnXn4nPdCyCXmAt9rhE8t5BQ2r2lQ5eKk/uzxtCjSX1y6TdKM3N0
 elVrrgYuyUegDF+ZNI+0FEFyTQUKKYxVH/V9ShxtnPvWAlfDjmcQ1CkajBB6FkCmLQmN
 zPG++zogkKU9jDLWMdCiuX8fWQ9oNIK0JrrxhE9TpYsEzDOU5Syhj7jGTp6SLNK/2ATg
 Ma8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MrpU22+X0ZaKyu9LA7o6w1HLaM63b0FI1gvr9ub0fTQ=;
 fh=x5V56jo04uIqRpOR/5L3UkEWCSGDLHlXRI3yMztjVno=;
 b=DBcw5ZaMOJUzAujw9Vq4iHE4cQrmirP4eAOT8MWksskfnz8h6KZsj4E8LXGRBUi/nZ
 7UhgzbPU+GQ0Bn1iaph3U8L4INMO4+X5kgd0e5YJSyAUSTcnbVvtqKPEBII3kZYuREyo
 YcaeV55V9JY+dQH5v5VhXE9ylt7HV+4f89FtO6Qg2fB4rkjDmOcMl9Cj89QpsmuBs5BI
 SCV0JZ2Jnk+cKzBRQpkw83othkcelvWxdqAFKVP1bLmm0RU+X7uyPuTZqJu3gGWsJef6
 cnXM+hDpPeEnmWdbtR8t39g6+bebw8QURcLx9U+Ypb3TEH9sWF3TBK9VwRZcQzbW07Pl
 dFoA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783934452; x=1784539252; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MrpU22+X0ZaKyu9LA7o6w1HLaM63b0FI1gvr9ub0fTQ=;
 b=bNa88/9mmYaNMoFCCTdWkbm9OQ6RZhqEFtUKw6cxZDeb8YOVUMPLveUgWOI+z+NaU2
 t9tivRvI8J0i/oPjfcDEVA1fMP7Mrkx4+Ag6tTTDrFpAQrsebnhUsHfEZZpUHLlrhI6Q
 dGya4UQQw3tio4+UWSPxRkNAYTsVnlQzp9erSs7Bf1s0oz4HtQOb2oFRNxuJKgjURTNJ
 RI2f7yu19r6W5jpeqpV1L0VXSNb97k3807NtnV//b1ZBGdLdnBTAMOLpY/XhF5rJXnLT
 V8ETNZS6rywgsx8sOKdF3I++1TRBvFPL4gG3Agf+557uJgiZNwKEtv/Y724Bu2dUUIML
 JrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783934452; x=1784539252;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MrpU22+X0ZaKyu9LA7o6w1HLaM63b0FI1gvr9ub0fTQ=;
 b=m2QtK8T3ZolY34IxGB+pl9xHRQPIqmHStyOOhsHeh48yFF14Z13SqfoETrclFGOpoZ
 mXNRg64y3j42LINBu2cy/xzxt93wCMAuqaSW6TrcE4ZXqUGAXpEkSZ/9oeZCGxiDso8M
 gUwN4S8TIiTTQd8qvkBGiij/4fuhlWlZOZB6uQyhn85ZwqT7+eFPymMKoS86/2OlQIYv
 3fRZoITtsekbqexUyE9tEfsnN58IOO7nAMVvKHwA85l4NFVuemywdIEP1JFwf+m4TF36
 TrftkETFaRsLJ2M5jtlw4Eh8HUB/5MVOQixeEX2m4S0uwDWAlvYS0oKVJP0dshhXShOa
 VZeQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRr9AaRoTU3LMzUM0q1tKp2dJudntEINuB2bPvBsJBwgw+fC7IE2zNEB2VjGicZk1GKUTaQxU0MHtI@nongnu.org
X-Gm-Message-State: AOJu0Yyi+Ho4zO6LKDDTiPcC71aNfv//6NuZJwrlKW7nROmNf3YO94P2
 Vi6Z+QmVbAgJGacI0tViVd7mqRBko1Q9BqpOAMf6PFwiqWSxRrdWp4xusnDfsa63tNVzwN8U8iN
 HF8KGwn2AuGUTHcV+Fu899dK2kBSudGQcvdjPEuAvmQ==
X-Gm-Gg: AfdE7ck/v14Zq5a+g5l6ySONGdgyo9T0ASsohfG9hOH48Ql0jfKxUFoiH+6oRUqIPO2
 Hjaw1coKdofXndHghdPFlmyHqioEDEUMDiTBSaDXBCk8YFuuVhyXFELFGPxatytlXO93c1cPkVa
 1xlv1SRS8c93U98OpRvfK1iqL7/wbr5VjqXrDey0m+83U4UjkTiVqlmnNm/j7UgLhunYKMm0Mzr
 hjLbZhlRpCy/ugqWyE8+zyqLJz/DEZNShaJ8yk6O61rqSkN66y+KoOg4PYtXTWTGSBjjj1Fd4fW
 tnVcue92P2dKUFMDrN5a0gWemrT8cUzuiyrFcDMZojEQWoH0kYr9kCOA
X-Received: by 2002:a53:acc1:0:10b0:667:8b90:2e5a with SMTP id
 956f58d0204a3-667d7f073bfmr4784101d50.102.1783934451570; Mon, 13 Jul 2026
 02:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260627063208.33642-1-bin.meng@processmission.com>
 <CAEUhbmV_BfLT9_F9OPH8VvwCZ_8Th+swHu833E0sjYCkj-k_=w@mail.gmail.com>
In-Reply-To: <CAEUhbmV_BfLT9_F9OPH8VvwCZ_8Th+swHu833E0sjYCkj-k_=w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 10:20:40 +0100
X-Gm-Features: AVVi8CcJd17Hnsj7pHZCeFcZ9uEzSvrA86fZ62vPIR6lfjWCt7z2ZfzRyt9bUr4
Message-ID: <CAFEAcA_or9830t85sHAq-PJegJ4OQ1ef=1wGpfcmiHFmVO0Jkw@mail.gmail.com>
Subject: Re: [PATCH] docs/system/arm: Update Nuvoton OpenBMC image guidance
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Bin Meng <bin.meng@processmission.com>, qemu-devel@nongnu.org, 
 Hao Wu <wuhaotsh@google.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Wed, 8 Jul 2026 at 16:50, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Sat, Jun 27, 2026 at 8:12=E2=80=AFPM Bin Meng <bin.meng@processmission=
.com> wrote:
> >
> > Describe the current OpenBMC target naming and release status for
> > Nuvoton machines. The latest 2.18.0 release no longer includes GSJ,
> > so point users at older 2.14.0 sources and explain how to find
> > Jenkins MTD artifacts.
> >
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> >
> > ---
> >
> >  docs/system/arm/nuvoton.rst | 54 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 49 insertions(+), 5 deletions(-)
> >
>
> Ping?

The docs change looks OK to me as far as formatting goes, but
could a Nuvoton maintainer review it, please?

PS: if quanta-gsj is no longer supported by OpenBMC should we
consider deprecating (and eventually dropping) it in QEMU ?

thanks
-- PMM

