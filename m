Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A475CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbwim-0004MA-1l; Tue, 23 Jun 2026 04:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbwik-0004LY-JI
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:43:02 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbwij-0005Nb-67
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:43:02 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-662f479a22bso4960129d50.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 01:43:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782204180; cv=none;
 d=google.com; s=arc-20240605;
 b=EaD82tD1eqL1q6M92dmK7T/J8UMAu0AeNlQh2f+Q5OSI8b52GN+OFhfFGUhqlnhHc7
 xPAb4eysJmgktNdoMMadasKvevk/g6YAT++xQxRSLJ5O7BN8zl+AUrWGiRaI1Oc2C9uX
 Z7UGcs2Zz3WwI3xjJhqblrgPUqTyUxftNCeA6MguJACRPgcWznvB9dpoCodLN5wVMu8L
 2SjvIpA0Nz1hyYCHFJ0chUen46zkgzv0hlaVP/z3dzF4rMbcq905CnupUVtEAdaoNRYt
 DCJ7rHAxM0HYFLYQAvu186nkznrqqUCugvCd7nsrEHu0/DPEwciysTNwredmk/InzZqq
 e0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2zRSd9G2WDJTnbEtZqqhadZIfQ2dChkGojlRazGuCpg=;
 fh=ELCp/US/J0N4TUKT2Ykpa23KoeTXm9bQV85weKq15Bo=;
 b=NjUrKUlvUOZ0dWshqgm+aNI7ikFg4A76y5+mbBkV6ymm47I8upgnpGyc+uZeyCPEgB
 I5UlL2sVyQZAu4OBOLhjALhz8FLYVPjEWUMGNgwPgp5vD7fBKa8iSbwl2wgh6FPR8yrw
 TNNT3RNMqra+9KkP3fN8TwaOBfSlUB0XcFWBjzy84Ai+huKv1/7mgVzU5eKwayA31FLV
 M74RTUnLobG+3n6vGwF1RCqRao9U0gNdx2vAvsdxtu9qbSUytiuxxwTzmd4sG7yfbQt0
 h85Qe46ApYAJnCj5fmSFBjFYgQvdaA/L0XGWIvqRcc/tJyFJlsyZwASZsKWU4Odfxjcn
 4KpQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782204180; x=1782808980; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2zRSd9G2WDJTnbEtZqqhadZIfQ2dChkGojlRazGuCpg=;
 b=InwoQPNXFPNQTIx57XdGn9zmuiS3VgWx2UioQiFBcb8NIS7RcVIynV7u5gRjfyPfXC
 osyrt+eP0+AfrJMGmjJNbFB78TBIVZrXX+YsVzGCVJoliqejslU33nFAd5JyBwyvn/Td
 VcZNaP0FyJAEw6WzfqSir0EaqVzJFTYV420YkQ/zQI+nECqnXuwI1xbgj1ciFkZgho9F
 kocSmQzODcdqTThiABTInRKM7uxLv0aLc7Ygi8kGz/YRRhiHyQHKiJJJL1agDI/ZhBfL
 cfYIFFEBPEeIZj0s7ttzwfWR+91p6xMosUlQ3anMhDHUb+3s+Ra/OqG3C6uPaNUTREZ5
 u/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782204180; x=1782808980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2zRSd9G2WDJTnbEtZqqhadZIfQ2dChkGojlRazGuCpg=;
 b=L226CcjFZaaj+6KuNcCzB15ZJYlLVcDOdYYKtE2QFMb71jLvH9j1O/jmu4RDviLUwN
 rExrjbbz0d6oA+Bt25oXZp5lxEId422M2o8QNJxp5ZEAb+XuJPx7//3UmNvY8hNimKF3
 dGpxzUh4+mtA0nzVxqJKMl5oDjL37ejvhWlr/vHrXzqVZVWtWR1o/OfXy8TOijGegKZq
 RO0qDSXL45cZUEB/b2KCpi3IGqs2ajJ74eBvZO3qYRu1Pt23R3UzZ+GxKss+YgXon03I
 /cBoJTZ/xrsy7fgcvng/3mqAUaeem3+RS5VWbV9A3x7swUZ7D8QQn/xm8MKqJZJyjXrS
 EclA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6C9VUaIZe8tiv85tuDtei7s3eMewBflFhixB7eWuWrNL4m73dHbckQOyJ3CelTJakSyErIgaxOfWH@nongnu.org
X-Gm-Message-State: AOJu0YxqrxV7SdMCQOFEcrEBC8zTAXy7WYrm0ajPHt0ELVOtIzpb4ZAu
 fuYxEmD8xBqEtVlIldeimCSkSOU3DutU8eGnAQ9MeS9xlWp/vm+Yak5AOf2Tdd4xulV53+4k+1F
 IkOsqFvkovfhOl4fMpdzW+Y1+uE5lJxh4i0BO2615tQ==
X-Gm-Gg: AfdE7cnEHRHcqlsOiMg9xPzAX6NtxVOiHUpAOhd39Rwmg5/jy7pgBAGIAXCbW11osOm
 qcumEzCXmH7Rhd3lVwhe44Qm8rYi8jEW9kKeJFxYItbcBv5K6Mktd0gTQPZP8fTr9TamxIjuZt3
 xv0AEOFdCI4bZv0y8j35itQ3XBWa7XnMrbFEdkJAhiXghrZ22zOMisf80CWgQOD2yk5WVGIQt1X
 Frw0bTPFdjovQHUcRhd68cz/tbNfM1V2GUOtbWBSJVXj9nT8r6s4F2P2vtmHHq5BwQd4bmQXD+1
 fd3VX+zmowVRek5xue/qSxBj1zuymMvXLTcQ7vFwaBmPej7CbsYAYZmX
X-Received: by 2002:a05:690e:1c1b:b0:660:5df1:f243 with SMTP id
 956f58d0204a3-662ffdcaad5mr15338897d50.50.1782204179568; Tue, 23 Jun 2026
 01:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260529114723.42040-1-peter.maydell@linaro.org>
 <20260529114723.42040-18-peter.maydell@linaro.org>
 <745e66c7-2a9b-4185-bae7-77e10623332b@linux.dev>
 <20260607182221.4357-1-wrigjl@proton.me>
 <CAFEAcA-xEaA2LM=17Q1pKOF6L=rHhaDimXeSmLe=BtDqeaBeFA@mail.gmail.com>
 <aibmIdorcTobj2yo@Jasons-MacBook-Pro.local>
 <CAFEAcA85HahxFXoDVW_xBZEtG2SUd_3PseYLrpUXE6P_Hb_5mA@mail.gmail.com>
 <4e00be29-25b4-479b-ad6f-b79beed78dd1@oss.qualcomm.com>
In-Reply-To: <4e00be29-25b4-479b-ad6f-b79beed78dd1@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2026 09:42:47 +0100
X-Gm-Features: AVVi8CfxDDgkRxCbGJhis44NoGfqlrFVh1PtvWrfL20oQc5Fe9dD8AfhavxS8lE
Message-ID: <CAFEAcA_XPGPLeH6DtcKDv-o7AkrX4dEFwLX4L+tSQ4wJA=Xnhw@mail.gmail.com>
Subject: Re: [PATCH] target/arm/hvf: manually sync ID_AA64ISAR0_EL1 on vCPU
 init
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: "Jason L. Wright'" <wrigjl@proton.me>, agraf@csgraf.de, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, zenghui.yu@linux.dev, richard.henderson@linaro.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Tue, 23 Jun 2026 at 09:27, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi,
>
> On 8/6/26 18:05, Peter Maydell wrote:
> > On Mon, 8 Jun 2026 at 16:56, Jason L. Wright' <wrigjl@proton.me> wrote:
> >> The three methods track different requirements, so I matched
> >> the closest existing pattern for ID_AA64ISAR0_EL1 and left
> >> the others alone.
> >
> > It seems to me that you've added a third thing that's different
> > from either of the ways that we handle existing ID registers
> > with an isar.idregs[] field.
> >
> > I think we need to figure out:
>
> Should we revert the commit until this is figured out

I don't think it's difficult. Somebody who cares about hvf
should just do it, and submit this patch with whatever the right
approach is.

-- PMM

