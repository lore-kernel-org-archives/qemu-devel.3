Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4165DCA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 11:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqUvG-0008Rv-VE; Mon, 25 Aug 2025 06:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqUvC-0008R6-QG
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 06:59:33 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqUv9-00017r-HC
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 06:59:30 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-3367144d35cso7003321fa.0
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 03:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756119564; x=1756724364; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IKpkCXSMMvrYSK0FB3XakUiVDOVF1I6yNKLmtcEh5Oo=;
 b=ZP4/C4d/5EUmQi02S/gq/eblNGZfkmcdTxA2Mk/5D5UGJSnVmKf8LNUe3UN5Srl65P
 MdD8rq7vXVt538CLKweUFd43sS3gpjYIHNnDmd7cWtiC+1K9nea5NTsSIU9FmSTUaguI
 kTvV0H6PFogPN+VtIsQBHmgEAi6oCO1/NsnNNgIwx9rv+GkNao09gsniBm8f3bTQmXND
 lfahurxvT2rTY0eESCH+aQN4cqcIxF7LzTbVJq7a6GrxzDbALsmkRXRq5Yz38AJhOaWq
 bxClyvnDMgFiZuUBoQ79SpGSL77ArEwf5jZspC6XzyqmqUQ61W2J2D25cBttCScW3TsZ
 Aa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756119564; x=1756724364;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IKpkCXSMMvrYSK0FB3XakUiVDOVF1I6yNKLmtcEh5Oo=;
 b=XW9gmX5QBrbaiFq0kvwlvvSyp0L8aEnyyFqcvGR2zaLXL+ko1vu2yZKATcyPdXh00M
 O31lMcDr6X9oXh7gEUa/3+Wxm05PjMTVGKExD2MyNxTsVEyFXah/JmN2rOa2socS4j5O
 KnfuTvrU+d5Ap3t+jvqP62lIG6O3zR6P+mteWTwL6hofjRy+mFXR0XnwQwcfh6HVuNte
 FgnHS4gZUWJcTpuFsJgtcxMdwPjxXMfDCbGWnYP4rPJjXUVnCS4/wtYYp5VtEojyj3fr
 e6P/v3XDYd6NT7gjJNoG4Z/6bMWhSgCWl42aDv9Y6YHS4obZKJgLp6ymVc0l7IXVLTHi
 4lGg==
X-Gm-Message-State: AOJu0Yyyv49CV3jAupafW2NvVFE/vXN6uv7Ewl2nQZfvfnafjYqiFIth
 904VmTEa+tZ9dzGTgfWrbdlj335U1+7+T06g6V8nn//TjLad1hDr/wOE
X-Gm-Gg: ASbGncvfpHiJgBhPHGMFWcvu8pyMAfy2y0LFe1tPHIqCAd0ikaOFW8BK3HcKt/sWbTe
 W0UcRYkAxDMuM8mUydisuldq85Z2y8ZSM0H8juAMcsYbD2gRePjaiQvSsNIH9RJq+DiLHZQGoQc
 XhtJKGhiqEMgzsbjBoEVVUBe0XehUpafvXTvjbt2vOrX5Dzb5Aejsm2bHbWva+tswECSCWmyBhP
 bx0xtZ86LipfFkYGDJxYK2WLpAXldznsI0bJmPx61OxWQQV8dDwvpUcJf4/d11aOhZiNgS2j6nc
 NRqgpab0T9an9/bwewm+YC+kUWhsvRq0+FV7VwIRfTBuEx0ulCbiV8W1P9l8B4xNRE68emaRUVp
 rMyGEHzroLf/383iGDJ5DOFfJXeTp2tBNbHedTr0/Nm/7aILsozHY+S9qMD1BKNVRFIxxlp5uZ9
 mhis5/
X-Google-Smtp-Source: AGHT+IGuS0/T+EqpktZCx5DICf5BWIC1cukJs+F3ticGlyuov/LGe/ocYU94mp1cKaNWM3Y/JHboKw==
X-Received: by 2002:a05:651c:2115:b0:336:7bcc:a939 with SMTP id
 38308e7fff4ca-3367bdbf7fdmr5248951fa.19.1756119564096; 
 Mon, 25 Aug 2025 03:59:24 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3367f2cd3cfsm1408211fa.64.2025.08.25.03.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 03:59:23 -0700 (PDT)
Date: Mon, 25 Aug 2025 12:59:23 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, edgar.iglesias@amd.com
Subject: Re: [PATCH v1 4/4] target/microblaze: Handle signed division overflows
Message-ID: <aKxCC1FI5jaVAl4d@zapote>
References: <20250824222734.4151956-1-edgar.iglesias@gmail.com>
 <20250824222734.4151956-5-edgar.iglesias@gmail.com>
 <764b48a4-6cf7-408d-afb7-503348906789@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <764b48a4-6cf7-408d-afb7-503348906789@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x235.google.com
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

On Mon, Aug 25, 2025 at 09:44:34AM +1000, Richard Henderson wrote:
> On 8/25/25 08:27, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> > 
> > Handle signed division overflows as specified in UG984:
> > https://docs.amd.com/r/en-US/ug984-vivado-microblaze-ref/idiv
> > 
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> > ---
> >   target/microblaze/cpu.h       |  1 +
> >   target/microblaze/op_helper.c | 15 +++++++++++++++
> >   2 files changed, 16 insertions(+)
> > 
> > diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> > index 3ce28b302f..7dd86653f0 100644
> > --- a/target/microblaze/cpu.h
> > +++ b/target/microblaze/cpu.h
> > @@ -87,6 +87,7 @@ typedef struct CPUArchState CPUMBState;
> >   #define          ESR_ESS_FSL_OFFSET     5
> >   #define          ESR_ESS_MASK  (0x7f << 5)
> > +#define          ESR_ESS_DEC_OF  (1 << 20) /* DEC: 0=DBZ, 1=OF */
> 
> That's bit 20 big-endian, so bit (1 << 11).

Fixed for v2, thanks!

> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~

