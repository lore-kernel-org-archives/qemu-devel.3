Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3161CF53D71
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2AjN-0006Jh-As; Mon, 16 Mar 2026 12:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2AjE-0006Il-UV
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:23:41 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1w2AjC-00048U-BG
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:23:40 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-829abaaa92bso3109543b3a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 09:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773678213; cv=none;
 d=google.com; s=arc-20240605;
 b=CPFu0N1lO4daLSlK/klUJ758Ijww4xDb/mj3wySUy4f5pEP5SyFzK0YEfBbdVqXYDB
 ytMEEPLzwaHXFP7KfqTSZJ81fnF2LIdgVNhAEtRDEBgLjPMXlNRlgAp4mROouMciO0Gz
 ZCdecI3zFFjiG1OlxGG65vDaIzviJpdydHCvWBC5hd3DLVd55d3ne6IPPv5iHCq0iIex
 pI91x13c5XVGiJZAyof9hu5C90/AgM0SyZAJHyp1myNARX+JbX2HE69p+VxPZ0GCBaz4
 7l2vjZTDJF7D4Kq8PO72hx/asmCkGv3sacn/cp4481Rq1OVdcwxpx9LhJGcDs86fIvOJ
 pSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E1ZgZl+8hbVx13v6jsbNIy5UFzdyqa17491D93l1AXU=;
 fh=yiUwoBOEypY2fM3mHrz5u4mbHkIidyv/b4UPGcEpz+k=;
 b=EpCV7g1vQMK1TY99BHvBFsWI2UMqFQybJ1uHANXkMwXsY0yUvtD95RKuwCLcmkF++6
 4Ufpv0ut9L/F+xo9RFhi1EmtfOJk2o9EBDORGHn0No2jOzf+j9+De5dLiCc0v/Kh9w0w
 cP9//N5bPmn/ojN3p5+ZKGo44oiLQjH2idckAuvdl4r6lrN0oZFqmEpNn5z/WiCoDx8X
 s4iudxUxms+32QTWOLwFsdA7DXzh8gvm02Y43SyDXnsXVHbvcNPLzvA1U/CiuthG0zrE
 I8B2P4hxXn9nbDJwc1GTXKjK4Wvbh3paLdb1kX2T0pVSVrqJKejWUMKKELnwwMuFvnCj
 vcLA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773678213; x=1774283013; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E1ZgZl+8hbVx13v6jsbNIy5UFzdyqa17491D93l1AXU=;
 b=O5W9UrsfRWau+yAkQjsx4DN895jYKpC3lt3X8nMj8d+Q2sWwK5+aayE45jzgUcp012
 H0bqSSZ/zFjcm92+u6J65M894PvA/2rce6+OuLk2nyzDjiCEw5orgSJICvDErVbf/6tN
 Pe/WhdbtFSqgZzuddV8DE4r9vRSk2KDGn+8L/FEdJ6YGiky8oxmClW1o+mp0bp4mh6bU
 QPohxwBJxZbQosa4LCF7v5seiJ9gPHDkZistLAX7uaEKhoBALfwXhPB4S9E4dUcGmJJn
 l88AudbyonZ6YBgskfn0EqffJdu/GSt6Zq/vnVSM4YChofY3h4z92tF+RtKfT8b7sTXg
 +Geg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773678213; x=1774283013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1ZgZl+8hbVx13v6jsbNIy5UFzdyqa17491D93l1AXU=;
 b=SZgt88yxRNSGVevYTr31ig0P784hTeishsYu9eiaSryU7fLp91jYlRyRHSh6Xzd2y+
 TeZeaNreHdLq4WdNi4axIV6Mz48+n6wGYL+/qAlAE9GbUj7OO0iQNNeKK3RvOaA3QjqB
 iCm2LKAEdo8kgcMJ7EeXzW/8iYOdpez2jkCCYVKxfDgDcfPynPADQmVsMP4ukogsMArB
 F5kY1E5FHkt5kBPJRhyvM5H+WAHAHvt0SBQHjPM/RwgrefomAEtqKPBd4HpBVvoTkcl+
 MfLojxqBbWRYWtnM1P2nkoNxClVsL3792Zy0VWSVkecEaxjLs3KOM3EUEiTujokBxrU9
 6AWQ==
X-Gm-Message-State: AOJu0YyYL2ZrLtE/emmbsX6t880YAM9eHhJfVLutA/M2Zhzr0hP8ltXL
 5fJaqCeEOwN0/e1i93I1sqL6Bb+QZYQHpDVhBGOrfon5YD1MdMS97GmAc+pRraKX1/TrQO9EDbn
 9Hf88nUNv6caT/NWwNmVHle+UjUUfj9c=
X-Gm-Gg: ATEYQzyWxJEQ4tVgqXSFRlDjuzkZl78TwiNrCUP0gl0R4b9qDhbO+aEFMHIAkny42mu
 XOicfD+eMFYrZPSBjPvRSxFFaYLlrC8bqYvW5sEMhAya6Li7hf/IgrigU5pksO7BJSenXIUeyJj
 XKfLuIv3RZeetzCK3OzvQnvdHz3glMEx3ti5Roh0Im9aSZbp3j5UbIgkvO5SJ67QqCOys1UoBuZ
 2+9ZDfKylThPDLpxCds300qIf5OxF6+wcvpKOI6WHuXnBxgfXSIm+zBAGYcKqRIzlaOwxhbcNhi
 vVpnh/D11QQLbczhIOiqok5Mf9eqonFNifdOoXOwe9h4N4ho
X-Received: by 2002:a05:6a00:3c92:b0:824:9451:c1e2 with SMTP id
 d2e1a72fcca58-82a19937ad3mr12881730b3a.59.1773678213347; Mon, 16 Mar 2026
 09:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
 <20260311040758.1068731-13-brian.cain@oss.qualcomm.com>
 <CAATN3NoaPgo6gKHfnFgs71QgZgZK7j+fsPKRWd4a=dSesZJmbw@mail.gmail.com>
In-Reply-To: <CAATN3NoaPgo6gKHfnFgs71QgZgZK7j+fsPKRWd4a=dSesZJmbw@mail.gmail.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Mon, 16 Mar 2026 10:23:21 -0600
X-Gm-Features: AaiRm50Z9TUGvF7ViIRlFWCbHYRCH4QrPYEVvxjzUjX_bZ8ZXEOr96NBPIz7-KM
Message-ID: <CAATN3NrDs0TOshuD+ZEL4Y9D9qRDsT9mKyNaPvTpOB2KTTcpHA@mail.gmail.com>
Subject: Re: [PATCH v3 12/32] target/hexagon: Implement stack overflow
 exception
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng, 
 anjo@rev.ng
Content-Type: multipart/alternative; boundary="000000000000da3de8064d26a332"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000da3de8064d26a332
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 6:02=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com>
wrote:

>
>
> On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain <brian.cain@oss.qualc=
omm.com>
> wrote:
>
>> Implement the frame limit check for system emulation mode.  When
>> allocframe computes a new stack pointer below FRAMELIMIT, raise a
>> precise exception (HEX_CAUSE_STACK_LIMIT).  The check is skipped in
>> monitor mode.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>  target/hexagon/helper.h     |  1 +
>>  target/hexagon/macros.h     |  3 ---
>>  target/hexagon/sys_macros.h |  4 ++++
>>  target/hexagon/translate.h  |  2 ++
>>  target/hexagon/genptr.c     | 18 +++++++++++-------
>>  target/hexagon/op_helper.c  | 34 ++++++++++++++++++++++++++++++++++
>>  6 files changed, 52 insertions(+), 10 deletions(-)
>>
>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>

Looked at this again and wondering where is the implementation when
idef-parser is enabled.

Thanks,
Taylor

--000000000000da3de8064d26a332
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar 14,=
 2026 at 6:02=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpso=
n@gmail.com">ltaylorsimpson@gmail.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br>=
</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
On Tue, Mar 10, 2026 at 10:08=E2=80=AFPM Brian Cain &lt;<a href=3D"mailto:b=
rian.cain@oss.qualcomm.com" target=3D"_blank">brian.cain@oss.qualcomm.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Im=
plement the frame limit check for system emulation mode.=C2=A0 When<br>
allocframe computes a new stack pointer below FRAMELIMIT, raise a<br>
precise exception (HEX_CAUSE_STACK_LIMIT).=C2=A0 The check is skipped in<br=
>
monitor mode.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/helper.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0target/hexagon/macros.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ---<br>
=C2=A0target/hexagon/sys_macros.h |=C2=A0 4 ++++<br>
=C2=A0target/hexagon/translate.h=C2=A0 |=C2=A0 2 ++<br>
=C2=A0target/hexagon/genptr.c=C2=A0 =C2=A0 =C2=A0| 18 +++++++++++-------<br=
>
=C2=A0target/hexagon/op_helper.c=C2=A0 | 34 +++++++++++++++++++++++++++++++=
+++<br>
=C2=A06 files changed, 52 insertions(+), 10 deletions(-)<br></blockquote><d=
iv><br></div><div>Reviewed-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylor=
simpson@gmail.com" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;</div>=
</div></div></blockquote><div><br></div><div>Looked at this again and wonde=
ring where is the implementation when idef-parser is enabled.</div><div><br=
></div><div>Thanks,</div><div>Taylor</div><div>=C2=A0</div></div></div>

--000000000000da3de8064d26a332--

