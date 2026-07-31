Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B545AC55174
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 20:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wptgs-00016F-Fj; Fri, 31 Jul 2026 16:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wptgq-00015b-VR
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 16:18:44 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wptgp-0007vW-Cf
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 16:18:44 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69ffbd2a277so2761213a12.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 13:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785529121; cv=none;
 d=google.com; s=arc-20260327;
 b=PLamT1ww12MCxT1O01dGjIKj8wnfh36uw95nThfiTRZLWMoSufVIMASbA2jvlTzjV3
 lDOCJGG4tm2gqKLGgigEOJ0WNdtUExp7bRpi3DRxmjFq/HwZVzRMRLUppFmUFY7GiQ9Q
 Xgryr/74FnTo6ysguWHNdx+PE9op5ocjUUpHOQ1vJoJpgtqTSS3okCQ6DlfUOUCoflRs
 ZH3IjtmYU3lwF0pBh67HZ3F2DzhVJUpIziNFPSHM6z2cw2dhpNPE8nxqzbYOjQH+kms6
 itHomB//0dJa/lRRxzJuTZFbXWZrG/1VRyjvcoK5/OUpR5iV9Scp/pUu7KU7XmM9eYsJ
 AgxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hMiByNySD7OJnua4A6/E6gTdcWC6R6ZVtdxghUhcK3c=;
 fh=0xhkqEWYRIWU/jRiLMajPT7ujRnVJIhZhc1d84fhNDk=;
 b=dsjUQxPgeZ8ihdcnODa3FU1WlmVu+CHv+Ya3adfrSwga6txchVxgjvB7KNWXdVJ27Q
 Kiea8fnKirIrVhDlPyQAuya/OQ8jRFTSilC9GaYCS1dwxv8OcZMOM0cXllcKskGaFtwX
 4g0tllBNx9kFPb719ep407CuCKG7fNsyp97XOIBu7CYjKszkvbibODAcQm1stktgtjz3
 oCzvvY3jQG/3yO71OucjFy8GbE0RECLOevjQH8CzOlNLts2xM7pEhi7ber+3PaFotzeq
 S/WZ9LTAAuU18mX+mNTY/znSgysgG4mrrYLdKyJrblvHuHkCbB7gtDYJVLCgCB5A0Iij
 uAeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785529121; x=1786133921; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hMiByNySD7OJnua4A6/E6gTdcWC6R6ZVtdxghUhcK3c=;
 b=D1l7MIVOItlbB/NtonMoT7R1P7TWUdxKILbMKeNjXRBXWVbraUwcSP+K7lGS/klOZ/
 q1MQeNOCHzSvdu2ulBxs1p1HzhaUgPtWn4Y6UN1EgroVs+7dGV/0B8I+wvSVY5YWtwh6
 6Kmcipy/bQjpQACTEDdP00JenaoRuqHtLaSWtENYPmct22sOUemRHGpdGhnkI14BzYqC
 eDnBjBp35BCu+xq3LWEX6Q+ahUcpkLK879+ECfDQ86Ql4Vi8ysEZLxoJekB+uf02SkSJ
 q19KFlpbjw0pCNH76dDnNGITK5xqodWQxQwxVJqY8FqX/ETWxFauCA3Y3WHKbzzvrWXF
 GPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785529121; x=1786133921;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hMiByNySD7OJnua4A6/E6gTdcWC6R6ZVtdxghUhcK3c=;
 b=ZGnYLdy1deFWnfj34hwHSDetaaiD8k5TB/OcRpOBgbaPbtNYhf1VdypL/bTVdcN8YJ
 YcqVKU42BiCFZbHknfZTbKGZOz13kqWYoJySgNUPz782sytaBGDQrylblkhZYyJ9RoL4
 eWQLmjMoOIQ2vVTE5P8RyjyAcE8AXtgI/U83hWvInnxM7q6vvjjKNesz9WZ4OHGWCcjV
 4k+tI41opz9AMi+nMe3Fmi3O4tT+R+wv1HQEMETRsIJUCyHTJISAw7EIYsyJ4QnZ/l2Q
 jTOVYVnN+cTXseCG+2jTWdwHmtcNuTIaY8ALT6Stzxu2JuGADCvb3BuyjVg6ytMX5e9M
 s17Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoWif+TWY3AeexbMAUjpCmaTHo0jF0cq5EsjYixyzYagq+KXgjWgPQNy7smrP7XHR4oMQ8BLH+vV7GZ@nongnu.org
X-Gm-Message-State: AOJu0YwlAlryPNvVPngChdI7kOrAJUSpIDzLUNbAC38/2bJF/RuSkHbf
 wcP2t9nXrTVo25i7IWPuQXqetUzayD+/IXk4ajz/A4g7qdc1GgwWoPuUXvyTrblJFS0H4KE6uep
 8uruj0LH14JgUFtfZzyTfUvyTMGAaWug=
X-Gm-Gg: AR+sD12zoAHa6R2iCnskWBs5qjUX7Q/HznFlghbuYdVQqRFkPRqIML3M/oBKAUrZZ0w
 5dMEBuoXqNQxL3uLgkdr4SeDLC0Va40Y67BIpa92SbtmRQ7KaC9xWjYkSfbicm4R5EE3I9CBo/z
 miPbU5zlqBz+eW90+jgemoYQHXPBb7bNZ418k75mRyxLYKcm+IX3cspDKLIWeJsFNITKY39jImC
 4Uhprg+FIUyJXhf1Vo1fcf5q8g1on+id3BT//R70WDc+iKrvE9wFT7X0Ond23EdcGO/HeevrM01
 fgqE53XyxHzOzX8WBnvTtZB4IYP9oHV6aN4DSqE6NRZDc79Fu5BRwbVGWQrQWbuBa1Pu21v1WY7
 EVw==
X-Received: by 2002:a05:6402:11d3:b0:69c:7985:5aa0 with SMTP id
 4fb4d7f45d1cf-6a0a7ca7ad4mr579651a12.16.1785529121143; Fri, 31 Jul 2026
 13:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260730081325.1816193-1-den@openvz.org>
 <20260730081325.1816193-2-den@openvz.org>
 <CAJSP0QUnp4=pPYQvGvTEoBCndvJb0o=Z0RzehP30KKK_svyXCA@mail.gmail.com>
 <f271fcff-4428-421b-b2b7-472cd8bf3cba@virtuozzo.com>
In-Reply-To: <f271fcff-4428-421b-b2b7-472cd8bf3cba@virtuozzo.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 31 Jul 2026 16:18:28 -0400
X-Gm-Features: AUfX_mxBpvh9GgE7PSyb3Voy41uuTBYjNm7nnsqLxO6grM4cURbwlYwUAR8ptDA
Message-ID: <CAJSP0QX8JnTSWHQeQrH5dKHeC4oA9CMTzHAZNhzt_8gKorJ9Gw@mail.gmail.com>
Subject: Re: [PULL 1/8] MAINTAINERS: add myself to IDE maintainers
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 "Denis V. Lunev" <den@openvz.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x530.google.com
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

On Fri, Jul 31, 2026 at 9:45=E2=80=AFAM Denis V. Lunev <den@virtuozzo.com> =
wrote:
> On 7/30/26 16:55, Stefan Hajnoczi wrote:
> > On Thu, Jul 30, 2026 at 4:14=E2=80=AFAM Denis V. Lunev <den@openvz.org>=
 wrote:
> >> Signed-off-by: Denis V. Lunev <den@openvz.org>
> >> CC: Stefan Hajnoczi <stefanha@redhat.com>
> >> CC: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> >> ---
> >>  MAINTAINERS | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 902db77218..4628793dde 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -2160,6 +2160,7 @@ F: docs/specs/edu.rst
> >>
> >>  IDE
> >>  M: John Snow <jsnow@redhat.com>
> >> +M: Denis V. Lunev <den@openvz.org>
> > Waiting for acknowledgement from John.
> >
> > Stefan
>
> The situation is not changed in general from yesterday.
>
> I can drop this patch from the submission, that is not
> a problem. The problem is that IDE changes are not
> moving, f.e. there is another stuck item for
>
> https://gitlab.com/qemu-project/qemu/-/work_items/2399
>
> floating in the list for month.

It would be great to have you as an active IDE maintainer, Denis. I
would like to see John Snow acknowledge the MAINTAINERS change on
qemu-devel before we merge it.

Please resend the pull request without the MAINTAINERS change for the
time being. Feel free to include Peter Maydell's divide-by-zero fix
too if you are happy with it. I'll merge the v2 pull request for
v11.1.0-rc3 and we can independently allow John time officially
confirm that MAINTAINERS change.

Thanks,
Stefan

