Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33683CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 11:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqs82-0004SE-IZ; Tue, 26 Aug 2025 07:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqs7x-0004Px-4d
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:46:13 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqs7m-0002qO-1F
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 07:46:12 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e96df7ff20eso439348276.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 04:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756208755; x=1756813555; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yfaH3eV+Iu+KeK+OzH1k9Ic0AvBJPdL4sj2orXre+YE=;
 b=rbBMIPe9kl2bMQclJKh5Bbs2pYAE4aXD/y3rIz1JPdQa49tOqOgfHzHT/RcpniofXs
 VK79hh8Jx0VtuKnKeuiC7xpDJZZ6JAc199tgTluCPkuhfz25Gq8Ds5aP4oXYNy4DZ4yG
 ArqWpcpqUOiBVii4Bhy4hfXt2Ox+qEoL800jfCG8oSN8RmSsx+J+xHscVyJYb3oOhMsT
 E2P5goujl8ZyfJu4aXFN5LHjQRbm+aDqydEHS1+eaP16SLo7eqCINSUx+gvqMzj41UPT
 7WwxFKIFcU0CDrq/lwj+avc+EEhYRAsdXXhRe9V+qprgI103+QwkhmVA7+hTVlf45Nn7
 nbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756208755; x=1756813555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yfaH3eV+Iu+KeK+OzH1k9Ic0AvBJPdL4sj2orXre+YE=;
 b=YnWHmBhFVj6jSVO1LqToImQceP57f1cWG3lPj66vl37Sn7GG4/jn0w5/morkDyFkyz
 651OUryxAnlKynvgPYYlbfn9L0Ssr72F4UPPAIGUTDJk4NJhSPGa9PzH2yugN27KlUi5
 rg04zdC0yOVU+i153MXLcF/ai+GfpsmzlDHyoEnZ/gu3xdteGyX2jR9EMd2iCjSWqTG5
 fbemrlC9yRomMyg2XCLNQQhDqQb49BGm91Lv+nZnW2x3n2qmK7qWDxD+dVocfS/iWLt4
 edtm5v0WIIPwxexmu5i6tpmEJyc3NCzlXV+4PKZuc/FMkKyq6e99Pu06Xyog8V9hi2aF
 9Dyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcV3iyCEVG1zaQvF6RWTsJN5zUhhW7ZFLKXliBhqC1w+cqojbkafVJiw6WsT4i+0fbKvC/TVdPIBnV@nongnu.org
X-Gm-Message-State: AOJu0YyqNT1HRgynXf+OdzJAPJGXlUTb+LY93lQos6XAYC2PAQOK0n+F
 jWjcZ9ixKn5eFNm94AZFfRFbEvXzVpQbFiuXpWJjXZflnojGZVHbvVySM9BvENyTw9aV10usWYM
 H9KpK/qflQsm/1WaJ1EvVL/E4/t3UzxPDAC5y2YJP84NK9mJPlSh5
X-Gm-Gg: ASbGncv6lEuBOpMUcqruq0Kt5zvkqa8V1J1lzlnPg8NzbpMvh2LUVIoLDLIrY/QuE3G
 UYAB/QIimN2C/ZT9xheakLYyY21EW4iRo39owTfzg+9q+Q0M5ktZVN8QBJKsCBDLxiHZn1Ftm/7
 pdM0l4YlVFU5ZshTCNIFe5/0hB7gyqf/yJTtEPPHV2anHxv0WkKhuGaAA39VC8hxaPPtal/tw7w
 YSCt18nmUcXJ02/LS8=
X-Google-Smtp-Source: AGHT+IFKn+m2hglmd4M90SlKm1CRno0Y6SiriJSy8TOYx6A5PW85jCtIsIl1QFTshcxiQnNFCj8tRa5VnglzqD5DHCc=
X-Received: by 2002:a05:6902:4111:b0:e93:38c1:1fa4 with SMTP id
 3f1490d57ef6-e951c2ca5b7mr15597617276.1.1756208754680; Tue, 26 Aug 2025
 04:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250822122655.1353197-1-pbonzini@redhat.com>
 <20250822122655.1353197-4-pbonzini@redhat.com>
 <aK2dMdD1i88PFn1j@redhat.com>
In-Reply-To: <aK2dMdD1i88PFn1j@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Aug 2025 12:45:42 +0100
X-Gm-Features: Ac12FXy5HWvK5hJD-FPam4H5jz3DGmpC62CKCInvWj8BiPjAaAtWYwkwJk0Oxh8
Message-ID: <CAFEAcA-msigoOs74vNMLBNJgWt9thkpaFEk5amM6ACjpE=6ThA@mail.gmail.com>
Subject: Re: [PATCH 03/14] trace/ftrace: move snprintf+write from tracepoints
 to ftrace.c
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 tanishdesai37@gmail.com, stefanha@redhat.com, mads@ynddal.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 26 Aug 2025 at 12:42, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Fri, Aug 22, 2025 at 02:26:44PM +0200, Paolo Bonzini wrote:
> > This simplifies the Python code and reduces the size of the tracepoints=
.

> > +void ftrace_write(const char *fmt, ...)
> > +{
> > +    char ftrace_buf[MAX_TRACE_STRLEN];
> > +    int unused __attribute__ ((unused));
> > +    int trlen;
> > +    va_list ap;
> > +
> > +    va_start(ap, fmt);
> > +    trlen =3D vsnprintf(ftrace_buf, MAX_TRACE_STRLEN, fmt, ap);
> > +    va_end(ap);
> > +
> > +    trlen =3D MIN(trlen, MAX_TRACE_STRLEN - 1);
> > +    unused =3D write(trace_marker_fd, ftrace_buf, trlen);
>
> You're just copying the existing code pattern which is fine for now so
>
>    Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> More generally though, IMHO, QEMU would be better off bringing in
> gnulib's 'ignore_value' macro, but simplified since we don't care
> about ancient GCC
>
>   #define ignore_value(x) \
>       (__extension__ ({ __typeof__ (x) __x =3D (x); (void) __x; }))
>
> so that we don't need to play games with extra variables. eg
>
>    ignore_value(write(trace_marker_fd, ftrace_buf, trlen));

Isn't there a way to write that that explicitly tells
the compiler "this is unused" (i.e. with the 'unused'
attribute) rather than relying on a particular construct
to not trigger a warning?

-- PMM

