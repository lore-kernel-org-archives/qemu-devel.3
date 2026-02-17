Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE85E68152
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHHe-0003qo-Fh; Tue, 17 Feb 2026 04:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsHHX-0003qC-H1
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:22:12 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vsHHV-0007JG-Rj
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:22:11 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64adabaafd6so3480703d50.0
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 01:22:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771320126; cv=none;
 d=google.com; s=arc-20240605;
 b=IsWaSccB7Pd2GRkFv1pv/uLxWpaQvnrnYSiCzDZK4xBD2BtI78hT9FiVnMI+FDFd6K
 FAUis+Tzvyl0EiS4lkRcLyRtSHHGrBw3TvcagcOkYHwvtjSRsd3+DQukcnEiTTqmabIB
 qhd72jqfG0UPNnGl6FR5cqC8rI0jmH/ePwODGY1ldOREBjHRetn1sA6F9MOn7sU4FSV3
 Jt9NQfx3VO2iu9dM1k311vvos38eUu1+3ma1LGnX9nLh1MMDVOpOqj5h17qM09Td/OtR
 pHKIQSRWRLG8jPT7/qGmhbg+jBMNxRqse3NnqbuRYc/R78nLIshSgf7n6JfbRCaW4onp
 np4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qPh3kzYXJM2G2gilRWn7JnMO/w6+5Ctn+8fVKoY+iKs=;
 fh=Sft5OdVybouP/Ttny5kOrEeRWrUxDEXfM1bhjHly4H8=;
 b=EByrs5uD8co883CjNcEUO7Rov3V67F+yQSkIyS0QFumzQmOP2IZni3Ah9pq4PUrMpz
 MbkTTXwWJvlwB0HYhU9ucVW/kosxK11Q1WpSL5aXN0j+HZJdtOOAGwu9XegxxRE4Yr8h
 RcA7+hEjJR/s3nZzNnzH1s/R1IFXzGOOUI5ajrYJlxYGaaakQRZ3Pr5ciw2pb0ifRdp8
 uE00ITWYIY3JN81mquQGWn002V/49bVYWc2EdrAtkFZHpN9+v0R9sXQl3DhlyNxW0LrL
 D+suE0Fgzw+PSnwd52+WRLkgMNgPX0HxHyIuQw4o74G2ItBWFwPFmB9wIW8AYdesM/xX
 2gwA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771320126; x=1771924926; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qPh3kzYXJM2G2gilRWn7JnMO/w6+5Ctn+8fVKoY+iKs=;
 b=gkVkocDd6wcAteZw+ppks9XAmDGtfa6mWs2EsFDoDzV7eNZWFZWR/9Ys9f1z6ybY27
 BkBwks6y8bJOrzCbWIKav/4EaGvxzKG21VamN2tFbu75NaKqIiqhDNvF+tVN1RjPi2Z9
 IkDVV8Aem5yLwkQ2mxkZPJT/9gu1YJT15zc324NvKEVcWOQc/18ekdhHF5GL65425Xd0
 +TyMRwIN5FDBodXejNnF+gs3K23XyG8GKmWPjYeUKfIoMbywsX+YKg8+mR/iQNvS8LO+
 fZwznt+7xu3S73NSuswWNxGQxBxjX1YQptdets9SpySPp3sPMX9aF1LCJMC0qRQgXlHL
 9jeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771320126; x=1771924926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qPh3kzYXJM2G2gilRWn7JnMO/w6+5Ctn+8fVKoY+iKs=;
 b=ZhQqYcJkCw8LErNZRpnRhXxpp8vF3use6xm6JWZg14oHIaA+g03qcGrBOVWwFKnW7G
 oLREinBtB5UhdIJujtLpeLS/Ezvn/517/QsYLW6AHuLYL5alF20dDa7vBMNhbMO1A69x
 bzeZTa4thh4aL1hwO1hHTs9XrWskjbzNsf9FVnVc4d3bYz0ymGJCZmZD+cIHhlFp8Tp8
 sJG3ODKoHLODNZcyHQJ24Vjuv8GOYxxZNEocKrPagaOho+ti/i2/QPSugWOq3EcBPTXK
 CIDAZdUW/XdNcMuiuKbiVS5PqKxnmwJ7t4Nee5D/Jg6MyX/ebNjTBY6ACi+AB0+rKlj/
 g23g==
X-Gm-Message-State: AOJu0YxP9h5c/POE9KkbWNTakCsVe4/wHIf4Ddvy6xy0uIcbFnJn8NjG
 Byu8VeVDc7b3H/jLJplAKx5l+th+1fbMR9Um4SUo+IxMouz/bHzu1j4j8VTpDHPiwo6NQV6YJZb
 lBysCA+t+B8TsaFF6VoRf3NASc89jlvLotPmXLuMknQ==
X-Gm-Gg: AZuq6aJVHqFn+vAkbfzCqNY/18o7A5dZjRNaYEXvGpft7mvEW13Rq6Pc+2rrQRwBiJs
 L9hii646s0eioxHv3zjk355fcZe0xQPvnarX7XvUHZIcm22CKuHdHrQDF/UdeTKknIuV0G+BnHw
 qDSULHnO8FQerlB3h+KpJRYO3mphxAvQeVCddvtoP4nUC/LgB14UllwajBqoOSl71dNPp9ZWRJg
 GGVHIAOY7PZUfjtzhWLd6oFGYu//FK+UPzzb5EuXVpDLhTE9E0ZLCPLD1E1L7+Z18Qec4NCpCw1
 JMN9UpCZdoZ+Ew3McaFr3BTsOF6fwNxYQros7vE1TZrWWHLuAWFPB9BMMd/w3emiW8M=
X-Received: by 2002:a05:690e:14c4:b0:64a:f3fa:af5a with SMTP id
 956f58d0204a3-64c19acf043mr10317700d50.40.1771320126253; Tue, 17 Feb 2026
 01:22:06 -0800 (PST)
MIME-Version: 1.0
References: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
 <20260217-alpha-v1-1-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260217-alpha-v1-1-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Feb 2026 09:21:54 +0000
X-Gm-Features: AZwV_QhqCoNuLsaqB5odRRxbcnYUK753NCR6vQyTA3rtETqMPUtNB18XtsmButM
Message-ID: <CAFEAcA_BJdifU=58m7ObeAe_ZByE6M-Zkg0cU70wP10+gpUkNg@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/alpha: Reset CPU
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jim MacArthur <jim.macarthur@linaro.org>, Yodel Eldar <yodel.eldar@yodel.dev>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Tue, 17 Feb 2026 at 06:35, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> alpha_cpu_realizefn() did not properly call cpu_reset(), which
> corrupted icount. Add the missing function call to fix icount.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  target/alpha/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index 1780db7d1e29..74281ebdb367 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -124,6 +124,7 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
>      }
>
>      qemu_init_vcpu(cs);
> +    cpu_reset(cs);
>
>      acc->parent_realize(dev, errp);
>  }

Realize functions shouldn't call reset on themselves.
For CPU objects it is currently the responsibility of the
board code to arrange that the CPU objects get reset.

thanks
-- PMM

