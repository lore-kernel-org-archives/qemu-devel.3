Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DDCC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 03:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC8p7-0000eq-76; Mon, 05 May 2025 23:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uC8p4-0000eO-P9
 for qemu-devel@nongnu.org; Mon, 05 May 2025 23:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uC8p2-0002EV-NE
 for qemu-devel@nongnu.org; Mon, 05 May 2025 23:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746501498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8HjInoNNty+KaxWQinveSAE0XPCG/v4uGcIA/IBGmFo=;
 b=ZvMMjtiXuOvDNSDylLu9wzK5jxuG2FLBRNfRq97XRAx13ryy7miGUUih5yej6Pum0zovIF
 6AyCMc2JxLnvYzvSi/cVJ7o1rxrEYzuy6G+LXpyvGY8IejnYFkrzWpkm2/ZhqgBhjhIJeJ
 amuC74ln4cIUkpIE6sRgWLNBT08eFn8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-lY3oATy0PMeVcJJkDSpCaQ-1; Mon, 05 May 2025 23:18:16 -0400
X-MC-Unique: lY3oATy0PMeVcJJkDSpCaQ-1
X-Mimecast-MFC-AGG-ID: lY3oATy0PMeVcJJkDSpCaQ_1746501495
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a0ac55e628so78284f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 20:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746501495; x=1747106295;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8HjInoNNty+KaxWQinveSAE0XPCG/v4uGcIA/IBGmFo=;
 b=NeC9odsRGTEt3Isl3p7zrzlfMQoQ15vplsrdzxWHKzmMgqHfDAL1x9sxlu2meox4Y4
 NUbqAv2xEY9XdCmCRbPDClhqCom1B/YFhmDBMXPBLxK4qzXLuuZHqnBUaygkuvBDkWSw
 ZepjKYMxsxNooTczRWdL7+kwJ0kwSugT1Q8e3mj/rJrlBmrQPNz5zAxtWVSmeOWSgn/3
 YV7uhsm2bpIyCrHxpcF6S/0U8G2ScLo6vfJZcsmV4EgZtdhplvM190exvxi2Rzy2okpf
 u8+fB31oIVnBRNGKI5FtRXNVkXtsJy59iWwq7wcQRlU0QG+40vRIwLFJJ8eqNVl8Vj22
 UgdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAb949W8Lqp0y4CV7XUG6qtfsF6d7RELvfEXiT73sHcMTtxE6KeUv877FUs4UnfEr6QsxDhaO5dAhz@nongnu.org
X-Gm-Message-State: AOJu0Yy2bRn4FmRsPuwBZtkEm2p4nkRo73z3TVfmfHWJGHpiZiL8L3az
 Zo7t3B2o6sBhKE0ayF4f8HIZVb9PopFmY08N/DA6mBmYp2EAJhS+TgKO4V2eeW9PrfGu059E7j5
 3de0UVulWxG8S8pU85o/GRtrSoLh9RJGk7qGAW7dPLX6jGxd4jEAy6r1FB9rXp4mW78QpKnaTGB
 +z1txFfuoKc+uag2BK1oG1Mna5bjc=
X-Gm-Gg: ASbGncvU/SxORljzlvDxh0bYkIFWFsLbMh5HiwbV9St94x+5491xxuoJlRHym3zBteH
 vtKMNhJcKZbKGtUJ+pxaJGPMNqsBYo4f44/b4HmUA97CE75tarpvDtBXRw06Mo2nbXHtW
X-Received: by 2002:a05:6000:3113:b0:390:f9d0:5e3 with SMTP id
 ffacd0b85a97d-3a099ad1aa7mr13343855f8f.1.1746501494949; 
 Mon, 05 May 2025 20:18:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQZq25q1mwYhgK19K2csNoquq8ZTpIIf3maVpnBk1AHU6C96C4XUEupSItBsug9clFmuL0597xxSbps7+LtF4=
X-Received: by 2002:a05:6000:3113:b0:390:f9d0:5e3 with SMTP id
 ffacd0b85a97d-3a099ad1aa7mr13343844f8f.1.1746501494672; Mon, 05 May 2025
 20:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250505-sphinx82-v1-0-85f2418b33b1@daynix.com>
 <881635e2-8b95-4e3f-9ef0-e8cccf675436@redhat.com>
 <CAFn=p-YeHAKcSBNeKeAKdVYc_6y72tko+W1ZaQnt3pKGaYTNUQ@mail.gmail.com>
In-Reply-To: <CAFn=p-YeHAKcSBNeKeAKdVYc_6y72tko+W1ZaQnt3pKGaYTNUQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 6 May 2025 05:18:02 +0200
X-Gm-Features: ATxdqUH6e-WOSQI2Zz1p7R3e3DWASVGsed36uKQW22ypWFdW9v8TnZRfVRrvg_M
Message-ID: <CABgObfb3_yaETfJxUJpObvCuL0c-pkvJ=jiGHKN92ZaL3zrZsg@mail.gmail.com>
Subject: Re: [PATCH 0/2] docs: Bump sphinx to 8.2.3
To: John Snow <jsnow@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, devel@daynix.com
Content-Type: multipart/alternative; boundary="00000000000030acca06346f1173"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000030acca06346f1173
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 6 mag 2025, 01:06 John Snow <jsnow@redhat.com> ha scritto:

>
>
> On Mon, May 5, 2025 at 11:36=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
>
>> On 5/5/25 14:19, Akihiko Odaki wrote:
>> > Supersedes: <20250120-sphinx-v1-0-65151b4441ac@daynix.com>
>> > ("[PATCH 0/2] docs: Bump sphinx to 8.1.3")
>>
>> Sphinx 8 requires Python 3.11 on the other hand; not an objection, just
>> a reminder for myself to add a note to the Changelog if this patch is
>> merged.
>>
>
> What happens if you are using Python 3.9/3.10 but don't have a suitable
> version of Sphinx on hand? I assume it will fail.
>

Yes, you have to install it yourself (which is what has to be documented in
the release notes).

It does suck that Sphinx doesn't support a version that is perfectly
supported until October 2026, but at least the workaround is simple.

Paolo


>

--00000000000030acca06346f1173
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=
=3D"ltr" class=3D"gmail_attr">Il mar 6 mag 2025, 01:06 John Snow &lt;<a hre=
f=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@re=
dhat.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 5, 2025 at 1=
1:36=E2=80=AFAM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" re=
l=3D"noreferrer noreferrer" target=3D"_blank">pbonzini@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 5/5/25 =
14:19, Akihiko Odaki wrote:<br>
&gt; Supersedes: &lt;<a href=3D"mailto:20250120-sphinx-v1-0-65151b4441ac@da=
ynix.com" rel=3D"noreferrer noreferrer" target=3D"_blank">20250120-sphinx-v=
1-0-65151b4441ac@daynix.com</a>&gt;<br>
&gt; (&quot;[PATCH 0/2] docs: Bump sphinx to 8.1.3&quot;)<br>
<br>
Sphinx 8 requires Python 3.11 on the other hand; not an objection, just <br=
>
a reminder for myself to add a note to the Changelog if this patch is <br>
merged.<br></blockquote><div><br></div><div>What happens if you are using P=
ython 3.9/3.10 but don&#39;t have a suitable version of Sphinx on hand? I a=
ssume it will fail.</div><div></div></div></div></blockquote></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Yes, you have to install it yourself =
(which is what has to be documented in the release notes).</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">It does suck that Sphinx doesn&#39;t sup=
port a version that is perfectly supported until October 2026, but at least=
 the workaround is simple.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Paolo</div><div dir=3D"auto"><br></div><div class=3D"gmail_quote" dir=3D=
"auto"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><=
div class=3D"gmail_quote"><div><br></div></div></div>
</blockquote></div></div>

--00000000000030acca06346f1173--


