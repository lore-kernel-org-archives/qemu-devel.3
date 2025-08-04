Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23842C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uizva-0004Ej-Bp; Mon, 04 Aug 2025 14:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiyNJ-0006Yt-W1
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:49:26 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiyNG-0006bL-Q2
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:49:24 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-71a27d982f1so41412307b3.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 09:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754326160; x=1754930960; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHMbwbeqIzxTyN7shnF13cJi5T+fpLlIgLnsBA8bwtw=;
 b=epzH7tG0rkXW25Fdl4/X14DB6Xwo5yJiTSyQ2IwCc0wxkIAzVqa+1LXJZOMUwEBP1Y
 Q7L5wgwY6pnsRvnfCvpw3OVMTIwZFNmabnN0kZLrubCDStgF7kPUU/3BLl0xOtdJJ9bG
 B1k9xAJUQ3i59Zvy4PyNVFZW7C8AFNp/sG27eNUaiOGWl2wpOUTPsmRs9Ek6ygrdq49b
 45AYkfZs4TW/qcBnVBrMQoyTTq5dxdHIN5uiWuz9VMOn1K4ls94WPEHolWQEIXdD9rfF
 RWbOGXqRMOJmhlmZcTl2RP2GZLtqtVsnPnthCtJe/uNsnnY2r6FuB8HXSJWM9mxx+wMA
 Sf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754326160; x=1754930960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHMbwbeqIzxTyN7shnF13cJi5T+fpLlIgLnsBA8bwtw=;
 b=SOducJMOnLI+dTdlYSbUtzMrRXcLT2Sc4aF4YJ9ZThCgQlhwFyv6emVCi6c6Med+vo
 4epTTEkHUTqGfg1CB5zftxH0Yfp6VqMubwdf9SwAF1gSU/eseyBAOGjWvmFOti3UUSHa
 XIv6olJZ7cnCZIyuoLOxefcpoguFEgMWGTO6FKJ0gwbUnitk1wyI2jMonLro6Og6oarM
 eQvzN7lluwHhWr9qgSjD+XFKah7QYSgBXXt6L9nTuop0vuN3RaOFsA1f359xi82Wn+GG
 Asq1bXfzaIbjJCnoerJlITFIS4jp46h/mINT/TqJ/+gPYm3baWHKYF/4vlhTCnPfxbNk
 WrNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnwQTABufhbKG9EWURhyQ2c38dX67+3sNC7KeaIP//hgbxNyo7/qYEY/RFIrlAJ+Ki/xuiqphP6gia@nongnu.org
X-Gm-Message-State: AOJu0YxtkCkbARgANq69Pav/ujtqwyj4y6+iluZL+zRkob/kS8y9Uzgc
 qeyQc1xTH9femjwmjuOQH1jRbZ9cdkGhqkAD8qNRY3kvr8WM1iUCUJMr92Tq5zvgbMoGFFDWZMm
 HTus9rkmEx6kp1VeKOuROOKe1iNEwM/FoNnPo1oqPuQ==
X-Gm-Gg: ASbGncvmLrCC7b5PG28PAcr7PEJlf/KULoyCXA5ipUCe/lqfUQD3C5oZ68WX2g9KLSl
 myWjXt/RQLBlEbukCFYbo07fY3LeekUV0Wrkiw7mAxfWkOzFvRLz58jB1c5M9iU2BFQBHvmibGt
 E+61r78WEf0/l1UFkQ9upnc7Ad35Du+WPvRjSD57ShjarOmf+8EySlaUFT3XSvNNxf3hOQnjhLy
 RUOI9Ut
X-Google-Smtp-Source: AGHT+IEytZrLcNOb629dFgWQFPhTpDboow//5emefKHC9esAVBQKb9nj54USy/fb8uEX0f5NCsBKIzzY0mA4g+rQ6fs=
X-Received: by 2002:a05:690c:6085:b0:712:d54e:2209 with SMTP id
 00721157ae682-71b7f5f743fmr126036997b3.14.1754326160642; Mon, 04 Aug 2025
 09:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250722201404.2368507-1-vacha.bhavsar@oss.qualcomm.com>
 <20250722201404.2368507-2-vacha.bhavsar@oss.qualcomm.com>
 <875xf36qyk.fsf@draig.linaro.org>
In-Reply-To: <875xf36qyk.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Aug 2025 17:49:09 +0100
X-Gm-Features: Ac12FXxLH5JBEv4mi3jhv3N-qKFHNnhDB6EHmh_9YCNACtpaF8Y4Q-e_FdO_qIU
Message-ID: <CAFEAcA8o4wEHHDXVj0Fcc3i8g+49psY7YSf1AqGiGe9vNuXiQA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] target/arm: Increase MAX_PACKET_LENGTH for SME ZA
 remote gdb debugging
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Mon, 4 Aug 2025 at 16:34, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com> writes:
>
> > This patch increases the value of the MAX_PACKET_LEGNTH to
> > 131100 from 4096 to allow the GDBState.line_buf to be large enough
> > to accommodate the full contents of the SME ZA storage when the
> > vector length is maximal. This is in preparation for a related
> > patch that allows SME register visibility through remote GDB
> > debugging.
> >
> > Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
> > ---
> > Changes since v3:
> > - this patch was not present in version 3
> >
> >  gdbstub/internals.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/gdbstub/internals.h b/gdbstub/internals.h
> > index bf5a5c6302..b58a66c201 100644
> > --- a/gdbstub/internals.h
> > +++ b/gdbstub/internals.h
> > @@ -11,7 +11,7 @@
> >
> >  #include "exec/cpu-common.h"
> >
> > -#define MAX_PACKET_LENGTH 4096
> > +#define MAX_PACKET_LENGTH 131100
>
> This is a rather large expansion for something that ends up in a static a=
t:
>
>     char line_buf[MAX_PACKET_LENGTH];
>
> I think maybe its time to get rid of this hardcoded define and make line_=
buf a
> dynamically re-sizeable buffer along the lines of str_buf and mem_buf.
> In fact make it a GString and we can get rid of line_buf_index as well.

What exactly is the packet/response where MAX_PACKET_LENGTH is
causing problems? The commit message doesn't say.

In general I thought the gdbstub protocol was supposed to handle a
fixed packet length (e.g. in handle_query_xfer_features() the response
packet indicates truncation via "l" vs "m" so the gdb end knows it needs
to send another request to get the rest of the data). So if we run
into something which seems to be fixed by raising MAX_PACKET_LENGTH
I would first want to look at whether the underlying problem is
that we're not indicating to gdb "this data is incomplete, you'll
need to ask for more of it" or something of that nature.

thanks
-- PMM

