Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E85C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52DQ-0005wh-FD; Fri, 11 Sep 2026 10:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x52DE-0005qm-Ku
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:26:49 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x52DB-0005dX-Ha
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:26:44 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a60591ae45so1739434a12.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 07:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789136800; cv=none;
 d=google.com; s=arc-20260327;
 b=Ge6cVKkbMEUc5NyORMB0QSqEFDp6dGrVVrA2+9W/gY1eToeELN6bX9Z45aEv5Ekvpp
 Op7EyMEIVzDtSzeZvdKk6O60tPBNUjj8nyfypk8cdsi9CId3wYIjJjDCs7aBUo17EOvl
 GrzR805mBLY3Qjb4/1dlqGQp/hv8X87mlX7U43woH8lKHXnBJC76Hi8VkGwiEDxGKz4R
 QROSECacAqffKfvsi0rx5bD0Wmqo8Zpt7mGmcbDRX/B/wIuScno3mGYw7371h5UrJnPT
 0POkGca0r4t3FVRAnnw2UgU8hGKa2/AghIADwJ2Hu3rc0kJOXNkVCe0AjR81cWmhyula
 UJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CqBv25/VszJVeXdRqa7kmIcL9iM3rsBAHAyVNsn8xhw=;
 fh=wGZeUYt39FdrjiyDvngBMA/6KW8toEkLMWKs7FzaIuY=;
 b=VcYF+NaRrK5CYq4HXsA64YGgDWmre/juTmR4Iq4fFls65k5vVgqCoQNXVXsdFnzTVe
 TC80bbLkh4F/P5/w2ktftucx43Q83XIUetwT4yK/SAuGr1+0Jp8JfXnrOPpimU3bmFP+
 mRANdwPwjxw9uo3n4ygCkDGCHwtVQ7u36ECF80c5dbsPDerxn/gpKBnr0INEZV4lt7G8
 qzmIcVyBi5mWL274Mb43yfScTDvZ07TDHMvRB5yf4gLxVyZyE0IJ74Mk0flBi3BcZpFY
 tWyzdVaYBS56JSFyVGr/qIdIoezPurEOzO02pIul9BIwLRylclGPMXouQbc4uWeSGihg
 MSgg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789136800; x=1789741600; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CqBv25/VszJVeXdRqa7kmIcL9iM3rsBAHAyVNsn8xhw=;
 b=Tk3rBGr+idTpzek4Kn8Q7wvOYplHMrvDpkszAPL/3R4W9MLNPmbOS7FuEqPxPXiZBD
 uZOmufmkJgzBfQNJj5S7WBih/X5nQPCtC8B0cbsP81D9AYEqSER+71a2gAWzAGvH05i6
 KNH/wruIkFwBojRK/bfWC2k5tgGdSrtj+VUbiBrsW1ieiuVvqoM3VQPgp+wMaFQl9Dqo
 65l0Hv41HTAkG3ooZ3H96W17pPW6TCadYXN6VE9eSPj7cJanTNgXwWc+5JUOE+ut4xf5
 3GHXsLVWPV6ItP8Dluct/hNfQBldQ3SlsPEAnaOLLVt8o8JPoIW9B/iMJ1DFYogWAYq7
 ncKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789136800; x=1789741600;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CqBv25/VszJVeXdRqa7kmIcL9iM3rsBAHAyVNsn8xhw=;
 b=F3xLwhVn0RDnkML436dmZoHaxfUqD5JjAWblZSdI34p0hKoYZ5ymu3VObrxQDLerG9
 EagNQZ75s9Ddhswac79QHyI4ZLrRPnyVXabYFqQCZE9is+NQrycAOzD2ck9IkT4xB6nb
 3KNOi52EsAKF6+IO78G5NwVcvfIGSk/+E93tjQXTFf+H+KZfuc/HT5PLebc6NbO3rQiE
 TD+P6hn0XB618LaKqeIE/kO0YYweQVjfZGhJg7H3CKGBQWpJrd4dQTyf2arDGXfgd6g3
 uA1RN0+sILnOSKmv+ofGh7CI7vpa6lLzLNdpMIl4PJB+fCTYadksSrQQ4cl8+wyvk5Uh
 ++Pw==
X-Gm-Message-State: AFuF++lCgMznaXxiB1EBiF10inbQDeauFptITdc5ryzjTTTb0q1pDIbY
 vOKIvbsBbrHYXnF+oNM87lmZeLdWtqL+y8zAMa6illsibYnJnqm/n4ZDllCdA1zjx+LV9eRm+se
 zEd2C3I0Ho6OPeGH2U5FxwnNTWaj+OT8=
X-Gm-Gg: AYBFou2ADKTrdsNFvobfnozDrWJ5oM/oBPEH8P/Q2jcKj0jMQ7S9KCFI96k0FdbW1Wt
 oI8SZWkPzqlTYccVW5h5Td1RLgPXCA9iuOR5qDgnT7pvkTSBaakedn5CXrQgcCsYJezpGoKFR60
 TXWtQaSk0rroKjv1u1Tnhpa1U09neVUkl5oo3QndLVbHzsycnwZ+A9kZo68vO4BM8qO/Bb2s3Dx
 M8OnPkyTtQgT2asYnSFQAYMnvnD9aMXSlInl4iRTC2idoxUOoc8a5eQJOrPfoUAuStVyOdxc4Mc
 +SKUU8Vz1dpKm8b0rsRtctyPV4q8vZ20q74Ks/hhRZTt8pz/oFNX3sc=
X-Received: by 2002:a05:6402:3604:b0:6a5:f44e:a009 with SMTP id
 4fb4d7f45d1cf-6a9b5640367mr4207496a12.7.1789136799548; Fri, 11 Sep 2026
 07:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260911100709.726366-1-zhangckid@gmail.com>
 <87wlss6owr.fsf@pond.sub.org>
 <CAK3tnvKXv+HdK4d5KXXNagUCODj68A1XRuP7VTpZNyUFoMTQnw@mail.gmail.com>
 <87fqzf6har.fsf@pond.sub.org>
In-Reply-To: <87fqzf6har.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 11 Sep 2026 22:26:27 +0800
X-Gm-Features: AcwNN1UHF2Wh4MHw1bTn4caHxo1i5xMMTJLk19YNSTnTWs1XB8CEPKmYVQFlbog
Message-ID: <CAK3tnvKgEXGDiieBgRb6+oh594jYvb-a+19wbRh9CNmRLKEM8g@mail.gmail.com>
Subject: Re: [PATCH V16 00/13] iothread: Support tracking and querying
 IOThread holder
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000644807065b35df39"
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=zhangckid@gmail.com; helo=mail-ed2-x10.google.com
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

--000000000000644807065b35df39
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026, 9:36=E2=80=AFPM Markus Armbruster <armbru@redhat.com>=
 wrote:

> Zhang Chen <zhangckid@gmail.com> writes:
>
> > On Fri, Sep 11, 2026 at 6:52=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >>
> >> Doesn't apply to current master.
> >>
> >> https://patchew.org/QEMU/20260911100709.726366-1-zhangckid@gmail.com/
> >
> > This issue caused by the dropped patch 1 from V15.
> > https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg02947.html
> >
> > I assume that patch will be merged before this series.
> > I forgot to mention this earlier, I double confirmed no other problem
> here.
> > please continue reviewing.=EF=BC=9A=EF=BC=89
>
> The machine-readable way to mention this is
>
> Based-on: <20260907063725.626685-2-zhangckid@gmail.com>
>
> Next time :)
>

Acquire a new skill like AI~


Thanks

Chen



>

--000000000000644807065b35df39
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 11, 2026, 9:36=E2=80=
=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Zhang Chen &=
lt;<a href=3D"mailto:zhangckid@gmail.com" target=3D"_blank" rel=3D"noreferr=
er">zhangckid@gmail.com</a>&gt; writes:<br>
<br>
&gt; On Fri, Sep 11, 2026 at 6:52=E2=80=AFPM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@r=
edhat.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Doesn&#39;t apply to current master.<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://patchew.org/QEMU/20260911100709.726366-1-zhangc=
kid@gmail.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://pat=
chew.org/QEMU/20260911100709.726366-1-zhangckid@gmail.com/</a><br>
&gt;<br>
&gt; This issue caused by the dropped patch 1 from V15.<br>
&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg02=
947.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu=
.org/archive/html/qemu-devel/2026-09/msg02947.html</a><br>
&gt;<br>
&gt; I assume that patch will be merged before this series.<br>
&gt; I forgot to mention this earlier, I double confirmed no other problem =
here.<br>
&gt; please continue reviewing.=EF=BC=9A=EF=BC=89<br>
<br>
The machine-readable way to mention this is<br>
<br>
Based-on: &lt;<a href=3D"mailto:20260907063725.626685-2-zhangckid@gmail.com=
" target=3D"_blank" rel=3D"noreferrer">20260907063725.626685-2-zhangckid@gm=
ail.com</a>&gt;<br>
<br>
Next time :)<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><p dir=3D"ltr">Acquire a new skill like AI~</p><p dir=3D"ltr"><=
br></p><p dir=3D"ltr">Thanks</p><p dir=3D"ltr">Chen</p></div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"g=
mail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
</blockquote></div></div></div>

--000000000000644807065b35df39--

