Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A94CA9EBE
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 22:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFImy-0000Nn-1L; Fri, 09 Oct 2026 18:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xFImG-0000Li-5r
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:09:22 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xFImC-0007HR-Dk
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 18:09:18 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6ac76a02368so171495a12.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 15:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791583752; cv=none;
 d=google.com; s=arc-20260327;
 b=eY4MORFSmL0/zfLG+2iNcmRlxqTxe4IZWCmqAyBp/6BArXpJ5Lihs/DZkPA23wPkNH
 1n1TJZrsfezMuD7n2TVx4GRK9fmxFGrhqYC11NfejdcKtHlDwnUgQKs6oIUP0UpQguXb
 fPT/zpp9P9S9itN/4h/xd2Gt2ygOi1meJtP1aVAL/tqxpjDh9n7KGUqVa0z8QVd0HG4X
 7knivr/ufAEMEFJGwnttAIVflq6DFm5GNpy6E1Qxejs7T5yjvovzGHSbFBhpzQgPoMJX
 vqzhW8ut56/Jw1YlPRvECkwUOouKX+Diq2iWk0poRZLABXAQGZVm+EhSqv/wxQnsvUvt
 zUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=J+S78Kjyra0pvWTejyWpSKIHbExHG/f3ZbwVnekTvZg=;
 fh=4/wcS88II3VX6Ye4PZnRAhk86dIgygccFhqjRWP+6KY=;
 b=b8L2g2HBmzVi2HqgpT8Aab+/RGsSbSGKn4zG8harq+UfHK8LPbb+vgiw1vjum9wym+
 djWd/R1+1s02FQCLf63HXcpfOFlACAyQC27dxxNMaB0Dkv8MC3OPtlHtY7xeb0P3A/Ha
 qrDFHopTuU066fYsOP4QGgEFl3o4BgoO6rh9rb5sdRYLb+HBcsuH1NcUNEqydpEMH+RM
 j64nS49Tr02xiGUmaE8Y+rPyWB40sYamOEzMvBk1SGoUWWQ8fcau9gQ/WTd6iLjWzZhT
 XLvsKIMQu0CV9zkslZAA07zdq8j+7qbHfUjbhIZS1bkydx9a3TWDtOOTMOrGGBkJLIrk
 XkPA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791583752; x=1792188552; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=J+S78Kjyra0pvWTejyWpSKIHbExHG/f3ZbwVnekTvZg=;
 b=i/BdhnsVy3VKyaOypYeRjfwDycSrWhIntv6l66Pj1biOUJbXPQzV/+YS5vXXUbL0wY
 zIw+gq/GFV/SIUDhtR3HYXHoU2mRUHZ6hLNjprBe3r8PMuUoqOYmhUEBGH5cPxYqe9nS
 zJndOJ2zHgG+6aNhmtluPKJk12AQz+WccB6gPO+6iA4KwntvJ7WSRy3Wkc8GalBwOHeS
 yUT0IN5BcaRe6hyXj9mlU2Z+vQGZOo7Wu2+NUQsYpe7tOX7pStndBd/bjpVA6DXmoTTN
 2t4IBVivy199dw/N6fZgrOhCjM4ZKqkz7s8rKbhFwcYX/Hp/z2+W7oqhqORKxGL96yr1
 3qkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791583752; x=1792188552;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J+S78Kjyra0pvWTejyWpSKIHbExHG/f3ZbwVnekTvZg=;
 b=FesXSfP6pYFwGJUEPXFNta0DhMzXVTVUZ2sJJo/Qex1QPZkshoWuwMESWc66oIGzbU
 E9uH8DaIgSQQ2T9TQzAc54YID09G2CA7S7ZCJG5hCi+MNWr9SAFElOe1OTPOBf8YIVzT
 kF+w8cD8ZsCvmvTaovIclKZyxR0tuk4Hv+wLVDUU8HdJoZpczxZ7nl1g4cEtxZ9shZGX
 nCMFweSDEC2F6H0hCAFq3xNbiHFozoSlvb8sVMEcqCwkzqm4VUG2FU7+EQHyso5wIine
 fT9TzE2/XnvUNKuc/gDIgK2JBJ4wXr8Jt2ljT2fi3Chcsk86JvYvtmdjtVSpJMa3+eEb
 D59A==
X-Gm-Message-State: AFq9FYIXFdmgpW6p5rNpvFuTUmHOZuFzqMwCwiWe7b0zOQ1H01QbqfBk
 4m/E8dUoXTbgMz3UJiK01WUZOO2iBe6HSnro9bsAlhzJsFjNJpuZYIuMUcnVGBk+CRhjXyNKzU8
 1d9IrpOrRSg7RoHtmGy8kOD/p52VBG3w=
X-Gm-Gg: AYBFou143Bi9iwigC3ogsIa53sl+byxRHem5FCbeH+FzCP/ImO58LsyyIC37EfRrbGC
 JoZXoHWJh8xgnDapH1pkSIKyHAcbsrWhhHDTXfUXZMwyUZwi180dLQ8MMMC6+jjFiNW6VaHr5Jb
 u5Wd1gPtBqj2ya0BclI0NEjGU4t2FIEOmyGn9VGZzC5HRKMIZ23lnvxW/WlEEtIIKJV5NOelQGw
 hj89LBkFlz6JwBgkB+788MMILeAy3WG7oHYBBaezIvG7DXZ85ad6KtJmemrB3ZcVn4CAj7IJYNV
 4ueCIKnmxle4qGieCHuSfQhYvs+9FKgxFDH99+/glBq9AeZp6DedoXg=
X-Received: by 2002:a05:6402:450e:b0:6ac:9a44:d409 with SMTP id
 4fb4d7f45d1cf-6b17c1dec0cmr3075874a12.4.1791583752003; Fri, 09 Oct 2026
 15:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <3631c54a-5ad7-4037-a21b-37c3c61d712d@oss.qualcomm.com>
 <9ee6fad5-4117-42f2-95da-818d5b4e0aa9@oss.qualcomm.com>
In-Reply-To: <9ee6fad5-4117-42f2-95da-818d5b4e0aa9@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 10 Oct 2026 06:08:59 +0800
X-Gm-Features: AclHuK_cvxi646yeVzZLiozOdpnp9huFOGL5MpdHk1rUuPJWd9KqDO6kZS0J6jA
Message-ID: <CAE2XoE91jjqtF_gW27tQUMiWoJi-pfYQwxWGe75+DFpYmY2iHg@mail.gmail.com>
Subject: Re: [PATCH 0/8] qom: pass TargetInfo to the is_available callback
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Stafford Horne <shorne@gmail.com>,
 qemu-arm@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Steven Lee <steven_lee@aspeedtech.com>, Alexander Bulekov <alxndr@bu.edu>, 
 Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Oct 10, 2026 at 5:58=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 10/7/2026 1:46 PM, Pierrick Bouvier wrote:
> >
> > I'll pull the first three patches.
> >
>
> Now merged upstream (40ba85501c0b6ac2a7319d3804dab072edf67564)
>

Hi Pierrick
Seems you post to the wrong place.

> Thanks,
> Pierrick



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

