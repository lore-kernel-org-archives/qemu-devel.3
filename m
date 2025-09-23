Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F158ACAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v10JB-0006Rb-Oj; Tue, 23 Sep 2025 06:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1v10J9-0006R8-56
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:31:39 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1v10J2-0004LG-R3
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:31:38 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 95FA23F427
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 10:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1758623489;
 bh=R0dSgg9gNbkZoEWYs8UKWG3atFXWPq8JAvE3sZbfjRM=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=RSuJcF/ag7IDWQn4ejDICUTM+XhbEUyhrwtzLqu7iuh4e5l5GXQyTKiC4j0f2tP8g
 rBHIP4GfHYCp0CLTPTeNIaMizW/sEDqzU9tfJyFuX2YZpydc167jl/rThm6ffoNqsI
 V9VTiPiQR2XE5SLatPP/1r9ZcFOwCRw6S4WChccnKuVYWT5jNhlXuGRugVHqLDAQcW
 qFZ0dtcT9V6aT6ROiJsPRmV1idO88cIDof3oKtOymqQNANhMYMabFxITduynL5MRS1
 N0Ig0oCmCZGstGmVoJoJkHZVKM1j8cEWfeab5uAtR6bxWpO5xbHPJyv9FWwiLtS4QI
 grE1CP0EKtMPQ==
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-631845b4998so3503011a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 03:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758623488; x=1759228288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R0dSgg9gNbkZoEWYs8UKWG3atFXWPq8JAvE3sZbfjRM=;
 b=GDAVjRbQTfkMYg5kbIA8lfvbobZwt4dXEW0ZhgJOWn4/dMXkCCSB4eStaw70xoDX+F
 EvOQ89tHeX1wdPQg6CSsoCJROG3FachoBsTTBkwbdt97PnELBPHqvOzXyY5dKEedAFhB
 59DjyLOUW7LIMsWKfe4lU9LdRVgKnfc78ejf+88a5cdAvv0ofNbeeNo65ZdNzdqVFPtu
 L35mEHfQRAIZVCKpIBN+gHaO2arYeAYPr2dfJErRdTFNRQlyR3pNKvlqC45Ccw93EsW7
 7leIB8qgTjdTALMwDxoLfRsYoaJN8RGnXQ3ffnf1KvB5w7uzzFf5+FFMheicAZT5RqU4
 sSlw==
X-Gm-Message-State: AOJu0YzG6UzSR9InrmHS7rXXyVUVaskLLAVciLTVta3DM+5nrLQl6RxA
 Sp1J/Hsp98tM77Qyesm9onqVUVYANa8kmx9bcHt9p0Ge5aWPR0hQzNwbEEl/bAPSILN12PR+3UB
 SDZBCNAu+l1i9BPSn2nFWaO2qzPmg9xGqcE9qoy/TQ40xit6cERO5p8q+kxWzDR/XXmWtnzNjmq
 KOGF+fwBmKSftpbkmOcy9Yf2AYXk7AXQbT3wDI00YYu9Tj6xC2WzlIPYg=
X-Gm-Gg: ASbGncuJpa64omMwl7QHuoR0D7kM0JGWmWm+ZS0NTUyc18TYiYYxkZqh1SB98YNTVew
 VjuCFk1d2Ja4Xd7d80GcAMFizk07s3JH4UrdOntvFf92F3InEic40Zb0vhdNnyvLMVn4QA67o8o
 iziUW3eARbjhsNnE1POHxx2r8ygjCRuOCYzov0iycvjxv3SKfM6LbL+1Tdg4s0KWVlDLy7dpe+3
 9k=
X-Received: by 2002:a05:6402:13cc:b0:633:7017:fcc1 with SMTP id
 4fb4d7f45d1cf-634677bcd1amr1740036a12.14.1758623488325; 
 Tue, 23 Sep 2025 03:31:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVlsfleA+/DjG0DYZBr7jsIHL5XidOEikZPhExfIv8q1yEpnlN38SZMXDRlfN5sORftGT6IIiaQkYtd2nzxxs=
X-Received: by 2002:a05:6402:13cc:b0:633:7017:fcc1 with SMTP id
 4fb4d7f45d1cf-634677bcd1amr1740006a12.14.1758623487926; Tue, 23 Sep 2025
 03:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <CABjvBV7wgfSv-OjGf_L2t9ranXfzTQTSBdRAFODpHH-nFcLFig@mail.gmail.com>
 <20250910115733.21149-1-hector.cao@canonical.com>
 <b2fb1e8c-4b30-4bde-9b16-b9a0cd314b70@redhat.com>
 <CABjvBV6YZvufYXcUeBjY3Av=_VALWy2Dw9o6jGeL2FQTf1CgOA@mail.gmail.com>
 <CABgObfaSrMHT4JjBSdoRvXWcMwQ7EcJJ9e===b45U=10ybncXQ@mail.gmail.com>
In-Reply-To: <CABgObfaSrMHT4JjBSdoRvXWcMwQ7EcJJ9e===b45U=10ybncXQ@mail.gmail.com>
From: Hector Cao <hector.cao@canonical.com>
Date: Tue, 23 Sep 2025 12:31:08 +0200
X-Gm-Features: AS18NWAtJjFGG1PxpSHjfxm2AT7eZSdwD2ayB6NfbElltJ-aRHdQfpobc1AT6qc
Message-ID: <CABjvBV57sVD019CtCJzLG1tSCrCW2gkbgBHxbNrhEpnx4BB+gg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Fix cross migration issue with missing features:
 pdcm, arch-capabilities
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000004abe15063f757085"
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=hector.cao@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_IMAGE_ONLY_20=1.546, HTML_MESSAGE=0.001, HTML_SHORT_LINK_IMG_3=0.148,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_REMOTE_IMAGE=0.01 autolearn=ham autolearn_force=no
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

--0000000000004abe15063f757085
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<https://launchpad.net/~hectorcao>

Le mar. 23 sept. 2025, 12:15, Paolo Bonzini <pbonzini@redhat.com> a =C3=A9c=
rit :

> On Tue, Sep 23, 2025 at 12:08=E2=80=AFPM Hector Cao <hector.cao@canonical=
.com>
> wrote:
> >
> > Thanks Paolo,
> >
> > Is it still time for me to submit the v2 of this patch ? I would like d=
o
> add 2 changes:
> > - add fixes:xxx line suggested by Daniel
> > - fix link error for qemu-user build (since it has no access to
> migration code)
>
> I have since noticed the link error indeed, and I'll post a v2 myself
> with the fix.
>
> Next time, if you notice a problem with the patch you should post the
> fixed version without waiting for input.
>

Lesson learnt, thanks !

Hector

>
> Paolo
>
>

--0000000000004abe15063f757085
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div><br></div><div></div><div data-smartmail=3D"gma=
il_signature"><div dir=3D"ltr"><div style=3D"text-align:left">
<p style=3D"line-height:100%;margin-bottom:0in"> =20
<a href=3D"https://launchpad.net/~hectorcao" target=3D"_blank"><img width=
=3D"96" height=3D"81" src=3D"https://ci3.googleusercontent.com/mail-sig/AIo=
rK4z5yECcB4DOFqFQjPXjogBAVC5Vv1klgihEnAZXkqybF5lNxe9SeDqtm-9dmSwj3Sbw2kDL58=
U"></a></p>

</div></div></div><br><div class=3D"gmail_quote gmail_quote_container"><div=
 dir=3D"ltr" class=3D"gmail_attr">Le mar. 23 sept. 2025, 12:15, Paolo Bonzi=
ni &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; a=
 =C3=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Tue, Sep 23, =
2025 at 12:08=E2=80=AFPM Hector Cao &lt;<a href=3D"mailto:hector.cao@canoni=
cal.com" target=3D"_blank" rel=3D"noreferrer">hector.cao@canonical.com</a>&=
gt; wrote:<br>
&gt;<br>
&gt; Thanks Paolo,<br>
&gt;<br>
&gt; Is it still time for me to submit the v2 of this patch ? I would like =
do add 2 changes:<br>
&gt; - add fixes:xxx line suggested by Daniel<br>
&gt; - fix link error for qemu-user build (since it has no access to migrat=
ion code)<br>
<br>
I have since noticed the link error indeed, and I&#39;ll post a v2 myself<b=
r>
with the fix.<br>
<br>
Next time, if you notice a problem with the patch you should post the<br>
fixed version without waiting for input.<br></blockquote></div></div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Lesson learnt, thanks !</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Hector</div><div dir=3D"auto"><div =
class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Paolo<br>
<br>
</blockquote></div></div></div>

--0000000000004abe15063f757085--

