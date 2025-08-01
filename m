Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BEFC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvBc-0002in-W8; Fri, 01 Aug 2025 15:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtbt-0000J0-HW
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:32:04 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtbr-0004GR-WE
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:32:01 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-718409593b9so21104977b3.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754069519; x=1754674319; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AOC6jTpO43SeCWXIltGaGRWolNF/gawhkYbd3ubfzGk=;
 b=iPAigb0dyyZobL0Wuz6mmfXY22W57q5M2EQt18QwnTueTgDEQltuEf2TMGLg8ry/dl
 yfXZu0ISWyyQKpo+vmQOtfPXDJYZysWyefPT3r9p/lksQcrj83h3Vbty/Ps1jcX3eVxj
 +OTsLvcTs33BZ4w+uryRSLD1p3NvYUm1x+kSu4DhFReBqS7wIWoUV7XfnIyktMBfOtwn
 WNIa2QIJfkSHaIosbchgpBerE5WdVs6LuiRLdbluEnx/ynVhlVe9/sIRHAUaoFA7xbBv
 QNBEhjHdXzvFpE+y53Y3pRVvIdjA505Bi+NxjDZrKxodA6V4hUgtxXQF70liZ7rRH62N
 s2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754069519; x=1754674319;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AOC6jTpO43SeCWXIltGaGRWolNF/gawhkYbd3ubfzGk=;
 b=OfqCrLOQioCER40mPPxwdJdFnpfRTxiKyxoSkpeOx+6WzRbA+5wX5Xh25E1o36cyIp
 Oph6+NQ/E94Na/hr+V92tfCeek99g+pwpwPDAgq/Cd/9JPytteuA7IrjGczZxQbw/Xlf
 XFY2IBk91yMxlNwvS0rNHvX7tNRQZ1e0mPpJPMcn35rKHC4vfYpKh6DF/zmkmYllSp1A
 oagfI8acpAEc4y5jKUhgJdgD+B/C5Kg5UwJBblUheSdYeuNsrAq1KjHCPCUodhZ8RRyr
 ust+GRZGZJ6qxz6QCELmz59byNGn1ssPbqD69ucyBvUwhhd99tTXyw9WoH/MsKY054vk
 PcXg==
X-Gm-Message-State: AOJu0Yzo2S2WaqjRYSAZsoIpANH7C79A2qIOMtESxC9a7yOEgHtpRzf9
 bu+EBj/jMC7msm9fM7+nnSd/xDZzoBu9o1l5vqjmCjdvczundmkfNcLkqmzlfvXweM8SFX3HJKX
 5gCC+x1hjaNQe9JIeuYyeL/XHmQIvQ3FSiFTQ22LKnw==
X-Gm-Gg: ASbGncsHekrjzz/u0HTEnWCgnSVXMDiuyiYK//FpPMPS1FnGApN6QtL4rEjTzBhcVli
 DfRtqw6juNtCnJxEneayhQ8zDTRvZd3Hs8uXxvhdDxcSkFrKj4czhvliT3JVfxB2STScrhY2+6J
 PZ46LPlTY5sNM2XcIkAd4iset+NPLSwrX4PFIsTj/QAXJYJzquvAmXcds9mAU59nuyzHo3LnTsI
 MWviiArneZZs9LfX6E=
X-Google-Smtp-Source: AGHT+IECAY2i24CgNHXCSzq6nSIvN1MtbbG+/0U8eWFs6eeh7v4GMRFg1rfmiXogyUBnd+gTUpYULCWAs3FwdmHEbdA=
X-Received: by 2002:a05:690c:6891:b0:71b:6aa6:6031 with SMTP id
 00721157ae682-71b7f85e287mr6068457b3.37.1754069518616; Fri, 01 Aug 2025
 10:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-35-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-35-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:31:46 +0100
X-Gm-Features: Ac12FXwS7T9l-iCfFnz36Y7G2wU7u6OQEWzquXx8l9cPBnsVbezeMZAUjSaP3vw
Message-ID: <CAFEAcA_69zWWBvgVOnR2JtAFFk5tJDa-9m5JBWq0q3_qgaUufQ@mail.gmail.com>
Subject: Re: [PATCH 34/89] linux-user/alpha: Create init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Wed, 30 Jul 2025 at 01:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge init_thread and target_cpu_copy_regs.
> There's no point going through a target_pt_regs intermediate.
>
> Note that init_thread had set ps in target_pt_regs, but
> target_cpu_copy_regs did not copy to env.  This turns out to be
> ok because alpha_cpu_initfn initializes flags properly.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

