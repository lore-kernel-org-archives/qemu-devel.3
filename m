Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E50CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENK5-00017G-Uw; Wed, 07 Oct 2026 04:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yundi.eric.xu@gmail.com>)
 id 1xEJ4J-0002JK-S3
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:16:18 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yundi.eric.xu@gmail.com>)
 id 1xEJ4H-0007tT-Hy
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:15:51 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-3515f9a5d25so613747eec.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 21:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791346540; x=1791951340; darn=nongnu.org;
 h=references:to:cc:in-reply-to:date:subject:mime-version:content-type
 :message-id:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a7shD+Of3pCMm3lHwJzX3zAbeCuSad88ZRx98eK575I=;
 b=UvJsOHDoHjkrngoicmmUMy9hIq9ZatOAhuMBq9A5NlrDr8XMDZPXp3Q7GB99wqtq5R
 pvTvQiHdMJRNpUBVsswmB2ItvdLJhGKGltQJ6+v1o1iTFgzTQknWbwARIH5o3Mka3dhD
 2x4AHh9+Dj70oSQbd1WTwep3v4lM1lksiApDrK8btnoHUpB/P9u85ViwO0d+y6ZnsNDn
 xD1hReA0j3lXuFnRaHDeBU0fVjtffYYJPsNLN06ohLzvMUXGssJN3A/5mekEBbGc/Mtg
 XzdoIlIwcrjVul9alOpoxAaPRu+Q+PSG4OnH8SrQIsHCLV+TNzODzLmigGa8SVqe/Nee
 LxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791346540; x=1791951340;
 h=references:to:cc:in-reply-to:date:subject:mime-version:content-type
 :message-id:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a7shD+Of3pCMm3lHwJzX3zAbeCuSad88ZRx98eK575I=;
 b=J8mIEi/Xx2mbsaIYvMcOi3dY8mms+su7ciGqGUcBSl7mF49gV39N5x2o0vk0p1fv+8
 lFt8Kb4D7ipwh44s3Q7K4RhWbcmLk9TJ4J/fjaRjpwztfOfTG+uPbPdnVQDfGI4WAIa4
 2PvRUVSYFteWOA4mVhkbjEX9fjHY5CKIlJ+VIKXYZSvD3LbT5aEyLv6xAJ7NZknTBhWq
 xlGPZ6WbLMx9f4DXFprq+Qba9W20R+0MOzdrEy/1YdEFnvLpRaF9uEYYC5VlK3CwYxS1
 K43191yfAAnsxxjNmqTSOrtz3lQzO0N7dA/0KTOklqRR0wB64jxJKYINlhhq+AZqSzGc
 hq/Q==
X-Gm-Message-State: AFq9FYLwPqH5G4Bhl3sQpU/EsM7u8EW61P6IUV6+WSCGm+j9pPXvWPyL
 c5UzQf7anV5/eKxMV/0eARNcLQ9Ov0RrAFXWv+h3noOaA08kx+0iivnjz9nKi/tq
X-Gm-Gg: AYBFou3eWIaRVMUi2QqgWDxNZdNai+vlzsp1Ev3UT/4TWgx/U8W0QpS+lmrX3TcoYQg
 UxUFY05giKUfO/IaXXpOo77HQ3593iWHl20lPO5iSN/DXyVIpz72HKpkK7S5D2GOOTuNapodVnI
 LLxRJzGacN4UArtXYvnxjvyBI2uZLHmCjyfDJ287zyz5xwQPUgI5yIm/g6FKNYsDiLF5jfah7FN
 OspetfgJ7KU8Ewdd65IqA7w/AFWJPLNOq0zXmWLbsRl8QAQasz2UUujYS+i/f4zESZCvRHK10XT
 X8VlZHn8LA+cF81TXU5I/P6vqvl8Cbx2rYsRcvnju0ramL8kXojCeQBYtBDkk+7UrUsT7eW15E5
 WpwqSeTcrNhiAI1iR8A5Rf8tGygCHImmTabiHZ//VcEjBSlxJTStTIUnxsEWigxxEoJ+/Spfw5W
 OMRq7Ab0KQDqvM0A6y7eqLNLFb3yfAlhKxhf9dQebDUNCrrxXwpfO/jKOV6GsC5YJ0rSUewdcoc
 /hpVkmja9tJCxFKlWu1fmJgyTdEptPEOnLuGot6fU4Dh6RMd2U3iL19yiugXW8AVEzB2MMu31VT
 BbWdteWXgPH4h79JlYk3
X-Received: by 2002:ad4:5c46:0:b0:919:5c8f:8fc0 with SMTP id
 6a1803df08f44-919978297b2mr3026456d6.37.1791320581770; 
 Tue, 06 Oct 2026 14:03:01 -0700 (PDT)
Received: from smtpclient.apple
 (host-183-232.ilcmi2.champaign.il.us.clients.pavlovmedia.net.
 [66.253.183.232]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91996bad504sm3355766d6.1.2026.10.06.14.02.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 06 Oct 2026 14:03:01 -0700 (PDT)
From: Yundi Xu <yundi.eric.xu@gmail.com>
Message-Id: <FA33E2E2-28EB-4AA9-A069-9B70D292929B@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_569CBFC4-46BC-4270-A161-A6500595CE56"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH] hw/display/apple: Fix obsolete PGDevice function
Date: Tue, 6 Oct 2026 16:02:48 -0500
In-Reply-To: <CAFEAcA_pVpXW+8g1tTY0dyJdXXzffO7sn0gqMZMBsc+SgbPu4Q@mail.gmail.com>
Cc: qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 qemu-trivial@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>
To: Peter Maydell <peter.maydell@linaro.org>
References: <1e5b1f1f-1d7f-43cf-8883-0e0ab2ec88ce@gmail.com>
 <CAFEAcA_pVpXW+8g1tTY0dyJdXXzffO7sn0gqMZMBsc+SgbPu4Q@mail.gmail.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=yundi.eric.xu@gmail.com; helo=mail-dy1-x1332.google.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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


--Apple-Mail=_569CBFC4-46BC-4270-A161-A6500595CE56
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Thanks, I hadn't spotted that series. Please disregard this patch.

Yundi Xu

> On Oct 6, 2026, at 4:06=E2=80=AFAM, Peter Maydell =
<peter.maydell@linaro.org> wrote:
>=20
> On Mon, 5 Oct 2026 at 22:52, Yundi Xu <yundi.eric.xu@gmail.com> wrote:
>>=20
>> PGNewDeviceWithDescriptor is obsolete. Replace with
>> PGCreateDeviceWIthDescriptor.
>>=20
>> Signed-off-by: Yundi Xu<yundi.eric.xu@gmail.com>
>> ---
>>  hw/display/apple-gfx.m | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>=20
> There's a somewhat more comprehensive set of changes to this
> device that include something like this one already on the list:
>=20
> =
https://patchew.org/QEMU/20260916100021.73825-1-mohamed@unpredictable.fr/2=
0260916100021.73825-6-mohamed@unpredictable.fr/
>=20
> thanks
> -- PMM


--Apple-Mail=_569CBFC4-46BC-4270-A161-A6500595CE56
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><code style=3D"white-space: pre-wrap; =
color: rgb(20, 24, 31); background-image: none; background-position: 0% =
0%; background-size: auto; background-repeat: repeat; =
background-attachment: scroll; background-origin: padding-box; =
background-clip: border-box; font-family: var(--font-mono);">Thanks, I =
hadn't spotted that series. Please disregard this =
patch.</code><div><font color=3D"#14181f"><span style=3D"caret-color: =
rgb(20, 24, 31); white-space-collapse: =
preserve;"><br></span></font></div><div><span style=3D"caret-color: =
rgb(20, 24, 31); white-space-collapse: preserve; color: rgb(20, 24, =
31);">Yundi Xu</span></div><div><div><br><blockquote type=3D"cite"><div>On=
 Oct 6, 2026, at 4:06=E2=80=AFAM, Peter Maydell =
&lt;peter.maydell@linaro.org&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><div>On Mon, 5 Oct 2026 at =
22:52, Yundi Xu &lt;yundi.eric.xu@gmail.com&gt; wrote:<br><blockquote =
type=3D"cite"><br>PGNewDeviceWithDescriptor is obsolete. Replace =
with<br>PGCreateDeviceWIthDescriptor.<br><br>Signed-off-by: Yundi =
Xu&lt;yundi.eric.xu@gmail.com&gt;<br>---<br> =
&nbsp;hw/display/apple-gfx.m | 17 +++++++++++++++++<br> &nbsp;1 file =
changed, 17 insertions(+)<br></blockquote><br>There's a somewhat more =
comprehensive set of changes to this<br>device that include something =
like this one already on the =
list:<br><br>https://patchew.org/QEMU/20260916100021.73825-1-mohamed@unpre=
dictable.fr/20260916100021.73825-6-mohamed@unpredictable.fr/<br><br>thanks=
<br>-- PMM<br></div></div></blockquote></div><br></div></body></html>=

--Apple-Mail=_569CBFC4-46BC-4270-A161-A6500595CE56--

