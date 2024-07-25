Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B89BC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 15:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX0Ae-0000RZ-UD; Thu, 25 Jul 2024 11:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sX0Aa-0000Qs-SQ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 11:14:16 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sX0AX-0008MU-AF
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 11:14:15 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-36868fcb919so612146f8f.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721920441; x=1722525241; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fe1amgnhWvlLP1YiN+wka9VI4IrjmndpGfS0vL8OlfA=;
 b=zAmwptGYmGIjF/JgqUCiT3hdZDBJI9KexuGIcXz5n+Me4iYMNc/NmgkR5+so3wbbbU
 FVGVtlH6bGTIrnZElSOIf3MzyA7/vU5WWUvAN7abAseRPRAeoQXiMWxy8XGRQw/5Ocva
 57uedUEKy1KZ3Eszv1WymbpcPooxmbmCkRKURTBwq3l3gpN6c4cnTOGSh9C8XSQn73/I
 WKLRtqp7+GZR7VzivPmyhlSao5wLK9A+x15GQCnVbAoykR1RHnR10Ru5OThuS3X2fuzn
 W49hNvzhxWxCBbg+OJ4rmHS+ODaQWf/gnCxmTxefbHbj0FZElPoYFsZwdfxkgGb2A/kq
 UgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721920441; x=1722525241;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fe1amgnhWvlLP1YiN+wka9VI4IrjmndpGfS0vL8OlfA=;
 b=WCsTuvJX9/GxxuZwVC8KvGcd5auIoLpFaXEUINPnWB2oC4b4Tpr+Z/89hDiC/ATDmW
 Uu8raL7b2wL7t8nmd8YWZmgAhNbZtYJ8ACz4Rp5ZfQDZP0q6qhVWfr4cP8OvIIuqaSSp
 YxAbxUTXzLlE/SbMYltASXDe6LR87LX4FfkomydkFQR2ezwLmdtxHDeXSIfSMwVpDEpn
 llO2cd8bnuhys2ijX7rh4IiXR/YC4WGGEvPKpxK4NpAOi8FnM93t8scUbU3wmFVwt+D3
 7uCEhfEJra4iRSRllNoWrjbwHoozN3/ltjJQn9mX68l4e34c/UnQZFpBZE5KOmAUxZt6
 vtyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1zItUCbOv2v2QYEakxlSJTC06Sg6RIp0gKbAsQoGVdbK+1m5bnxZa0rV8oqRknlRaguC+FGINSg8i4ipNQNj9Anf9YBU=
X-Gm-Message-State: AOJu0YzEFsw5zBBvqNQkiLDZ7wj28UN+QkPIe9fkkxyHWbtC8flafZVb
 OKajZHHTsLNz9iP+N+0hSIPjY5BrDVaCnk9MxE1mQpOYLp6UbDVAcjOqRtBNkxlMa+m8soHXG8v
 g+a+bxsWxgBSI+RH1xKe1tVSd9yI7f+LH179Q+Q==
X-Google-Smtp-Source: AGHT+IHl24kBeUzMPL2/cjxCdgMoCpcBZ3QDwKIkFsLN1XXg9D1K3+rRZg391QVeJmIGm1iBrwlZ0TZ/R540RsIDwlE=
X-Received: by 2002:a5d:40cb:0:b0:368:3789:1a2 with SMTP id
 ffacd0b85a97d-36b31add956mr2073916f8f.21.1721920441605; Thu, 25 Jul 2024
 08:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
 <897365b8-03b9-49d1-9822-3c99e146c670@linaro.org>
 <OSZPR01MB64531A7E8576610BDD603D3A8DA82@OSZPR01MB6453.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB64531A7E8576610BDD603D3A8DA82@OSZPR01MB6453.jpnprd01.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2024 16:13:43 +0100
Message-ID: <CAFEAcA_rBrA=Fy_m+U_OZaznbBn3wykTCyUf3S5aMA36YHXNkg@mail.gmail.com>
Subject: Re: [PATCH 00/13] make range overlap check more readable
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

On Mon, 22 Jul 2024 at 08:00, Xingtao Yao (Fujitsu) via
<qemu-devel@nongnu.org> wrote:
>
>
>
> > -----Original Message-----
> > From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Sent: Monday, July 22, 2024 2:43 PM
> > To: Yao, Xingtao/=E5=A7=9A =E5=B9=B8=E6=B6=9B <yaoxt.fnst@fujitsu.com>;=
 qemu-devel@nongnu.org
> > Subject: Re: [PATCH 00/13] make range overlap check more readable
> >
> > Hi Yao,
> >
> > On 22/7/24 06:07, Yao Xingtao via wrote:
> > > Currently, some components still open-coding the range overlap check.
> > > Sometimes this check may be fail because some patterns are missed.
> >
> > How did you catch all these use cases?
> I used the Coccinelle to match these use cases, the pattern is below
> range_overlap.cocci:
>
> // use ranges_overlap() instead of open-coding the overlap check
> @@
> expression E1, E2, E3, E4;
> @@
> (
> - E2 <=3D E3 || E1 >=3D E4
> + !ranges_overlap(E1, E2, E3, E4)
> |

Maybe I'm misunderstanding the coccinelle patch here, but
I don't see how it produces the results in the patchset.
ranges_overlap() takes arguments (start1, len1, start2, len2),
but an expression like "E2 <=3D E3 || E1 >=3D E4" is working
with start,end pairs to indicate the ranges. And looking
at e.g. patch 9:

- if (cur->phys_addr >=3D begin + length ||
- cur->phys_addr + cur->length <=3D begin) {
+ if (!ranges_overlap(cur->phys_addr, cur->length, begin, length)) {

the kind of if() check you get for start, length pairs
has an addition in it, which I don't see in any of these
coccinelle script fragments.

thanks
-- PMM

