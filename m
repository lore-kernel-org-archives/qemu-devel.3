Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CD9E81BAC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 12:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpQDX-0000nA-Ee; Mon, 09 Feb 2026 07:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1vpQDT-0000kz-Ta
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 07:18:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1vpQDR-00075B-LW
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 07:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770639487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4G03RwruaJpC8C//dCO5kMbn1YmSORTeLSZuOr0flFM=;
 b=Nw14Zn9c58UII1i67QZsdcQORTvylVf+0z/dgmD95XYBB3WvBQ3iXp/DZuUXOwiIXALOf/
 EPmRGvP8F5sV8WKYFkeytGcrG8o/9Xfyti6PREzA0wrDsL83q/WzYvD7cDavLjJ/jqFQuu
 HkfGa25s1aW/KeHBbA8XoXd+fi+Yja0=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-fhduEK-eO8Cv08n3Qnd1Eg-1; Mon, 09 Feb 2026 07:18:06 -0500
X-MC-Unique: fhduEK-eO8Cv08n3Qnd1Eg-1
X-Mimecast-MFC-AGG-ID: fhduEK-eO8Cv08n3Qnd1Eg_1770639485
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7d192f35a9dso9053492a34.3
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 04:18:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770639485; cv=none;
 d=google.com; s=arc-20240605;
 b=eZfB1O/gZ0mrZbQSEwrcWiIBz2XMA046fsdCwIzBofbrcZeZ2HC9/pMMGV37UAjC2l
 kaHe992bSomvZ2TIrB4mQdTHE3P6vH/R1BaIQmagbTXfgbQXJoLr4SjxPUZFGYIKvUer
 nXbykTt1fu9KcyhLdQK7Yw2L+MMpC9Rn3bSjJQVOekzjblOk/ihj1RZklMBi6ngNhKe2
 EhraHXhznEzLWqC6U5ZCE3EuDZosUxAz6F7XDvQJuj2AzoLTILdDdkaWJ3aoo/e9Bnge
 yHZbhVvzc/r7bEeTU5TB1mhyusF8OguEYs+ayvZIdSsNpTh5b8EHo8H8Iuo4krWOaRxp
 QSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4G03RwruaJpC8C//dCO5kMbn1YmSORTeLSZuOr0flFM=;
 fh=EEtxChGaFcTfTb38qUA0grwEmjx5/YNfQlaMFIcCndg=;
 b=MGVeVfV68UQPbvEgT9G7bGtD/CQjRLGzW+UCURz88hG8a6apt7XMApbp5Z3HMisRKF
 bRqzkr8b2gjg+pmDlNO0vs6S38mvOnH7F64UTG9KjDG8tP4G9uC0PBx8TN+o5axK/dCm
 59QKLNjD4hIs73YdLRBgjIKYLSyNUbPgHBOhjp38xc0wZvux3Fzs4StGkEj4nCb0yH/2
 tsUnp7IrN8Qi5gDvkQw8g+C4/rXwpc0KNc4anVTuD9hEs6LjEoRy/nojuauFfdk3kEbx
 FskbRjYLtCJAjOSMS82Gan6t4q9nTTJwZYrJZ24myjPMJ0xjxOdmBQ9ObbjllHEgGoE8
 jnYw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770639485; x=1771244285; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4G03RwruaJpC8C//dCO5kMbn1YmSORTeLSZuOr0flFM=;
 b=QhaqHYeHYUcyjnCovqJpwaSn0NUj9pHdBvb9TNxoBtFM5VmoX+1wgovMV6q/IEoicZ
 WeXrOEJPyYXIp0WntyahhkIex9l7qc/F1TF916a5VugCIS/9X8XLBBhuZHxaHko2TSj8
 tXA6qQrsA60yccPSVoIW5Njq+LP7wpNgTfTnJCwrtQpJn7D+wqjfD3UFzX7VGMAKrFqi
 MA1tELEqIimOKBLggRE3hUMEXKVDcpZ2nEXRZHPpnJ3ZRSwGup1+JYq1CurKl1KXJZm4
 8DVIUOwBR9Ju2+YgZoDiE9NmGYyTNmmoRflv7wPbidFaYAzp/WtlbHkCBA3OWpWZu9oY
 GmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770639485; x=1771244285;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4G03RwruaJpC8C//dCO5kMbn1YmSORTeLSZuOr0flFM=;
 b=lIr9BPP9RQIHc2BZhnmeHD2RQADXIl3BTYHn/acwO0lDAiwvcwa4tyAs8cLPhqR6b/
 Pd0JQ6uErjQ7d0r+L95KEzAgoW75GD53PjENIi3sAVhXx8sHhDx3b+ie4touQR0SKeR+
 020cvDbvRg7+rNRWRA7fi5qKPQgQy4TDivCocmWSyzEZnNqaekHWrvzqSDYri4itgLDh
 3knk65GPljdp2Cvhizf4f7mLtBkTjd0G2M3ql4OqI4mnWeb5M3TxFv/rL3EEJd46UT43
 IPpSmk6+en7OBcKVXxwSLpStgjykyi3ZKGPmMIzPCKGAUXWYjhG7mhFaOxUW7Gg5HrU4
 AmBg==
X-Gm-Message-State: AOJu0YxISb2M9wn0cM2t9ME4TNnfV0ghISS/hP0EJnubcMOOGXA1tZDe
 au5wfkQvRxUwQ9OW87tfdSC1TDTcMUCtIhWK4+q4jap6wB3lYMa/8Mz2DUSYkXUSgT4tCHVpfWq
 4MbFmKVwgg11apjZPh+tslBruYBsYv9W6K6roDNUNdj23/NS+rDboe9JX59xHquzev4a50IyBhY
 feOC7lCCbRJlcaT+5Wu8PXvPEHLUArS0Y=
X-Gm-Gg: AZuq6aLR/acpAy/6MSCeXK4iBDW+DqO6VwECkQU4gvxgPaySC79hrDVnYBSbp4of5ZY
 8KkLJStLmnHnec1/P+etd+ogu5gUrEandjNZ+71davuxoagLWl32MKvd720b5PbxwzBbzSKZ7/w
 sH/K77xxYVMgWQt5bKvV2mWP/xN6cSi8wGh3e2UFnvhyyhyNN40R9vy923UsTbWmHX+LVQ
X-Received: by 2002:a05:6820:1952:b0:66e:398:fdd6 with SMTP id
 006d021491bc7-66e0398ff5bmr3262257eaf.34.1770639485557; 
 Mon, 09 Feb 2026 04:18:05 -0800 (PST)
X-Received: by 2002:a05:6820:1952:b0:66e:398:fdd6 with SMTP id
 006d021491bc7-66e0398ff5bmr3262245eaf.34.1770639485206; Mon, 09 Feb 2026
 04:18:05 -0800 (PST)
MIME-Version: 1.0
References: <20251204162129.262745-1-dbassey@redhat.com>
 <55f06323-a0f6-40f0-9f37-743245203c77@tls.msk.ru>
 <CACzuRyxeeATksqQQGfGkKVnCP7QMwTaKy_q+dioEPwPka9xzbw@mail.gmail.com>
 <28baf1fa-1e25-4381-9c52-7c0cdd4cb641@tls.msk.ru>
In-Reply-To: <28baf1fa-1e25-4381-9c52-7c0cdd4cb641@tls.msk.ru>
From: Dorinda Bassey <dbassey@redhat.com>
Date: Mon, 9 Feb 2026 13:17:53 +0100
X-Gm-Features: AZwV_Qg5vTbipxFFdSX27Mvdpi16zVOZUWqcExCJJBwtoIWq3z7AjmkzhS0bH6w
Message-ID: <CACzuRyzFypPD=M2cVM+=zGNuwtLhz96RMbEBg_thuExngG9nmQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio-dmabuf: Ensure UUID persistence for hash table
 insertion
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, mst@redhat.com, sgarzare@redhat.com, 
 aesteve@redhat.com, marcandre.lureau@redhat.com, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000008b6ceb064a632163"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dbassey@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000008b6ceb064a632163
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> Again, this feels like a qemu-stable material.  However, I'm not
> sure under which circumstances the uuid key can be freed before
> referencing.

To clarify the circumstances: in a cross-device sharing scenario like
vhost-device-gpu to vhost-device-video if the GPU side UUID is not
duplicated, the lookup will fail when the Video device later tries to
reference that UUID.


> But I wonder - for example, 10.0.x is currently a long-term stable
> release.  If rust-vmm changes and implements this feature, won't we
> hit this issue there?  But this time, with a painful debugging session
> because the current context is forgotten already? :)

Hmm, you're right, Better to be safe than sorry, given it's a small fix
let's keep it in stable then. Thanks for catching that!

Br,
Dorinda.

On Sun, Feb 8, 2026 at 8:18=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wro=
te:

> On 2/6/26 18:00, Dorinda Bassey wrote:
> > Hi,
> >
> >     Again, this feels like a qemu-stable material.  However, I'm not
> >     sure under which circumstances the uuid key can be freed before
> >     referencing.
> >
> >     Please let me know if I shouldn't pick this up for qemu stable
> >     releases.
> >
> > I don't think there's a need to pick this up for stable, I found this
> > issue when testing the `resource_assign_uuid` feature, which is not yet
> > fully implemented in rust-vmm vhost-device-gpu backend that uses it. So
> > safe to say no existing users are hitting this code path in the current
> > stable.
>
> This makes sense.  I'm dropping this one from the stable series.
>
> But I wonder - for example, 10.0.x is currently a long-term stable
> release.  If rust-vmm changes and implements this feature, won't we
> hit this issue there?  But this time, with a painful debugging session
> because the current context is forgotten already? :)
>
> Thank you
>
>

--0000000000008b6ceb064a632163
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Again, t=
his feels like a qemu-stable material.=C2=A0 However, I&#39;m not<br>
sure under which circumstances the uuid key can be freed before<br>
referencing.</blockquote><div>To clarify the circumstances: in a cross-devi=
ce sharing scenario like</div><div>vhost-device-gpu to vhost-device-video i=
f the GPU side UUID is not</div><div>duplicated, the lookup will fail when =
the Video device=C2=A0later tries to</div><div>reference that UUID.=C2=A0</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">But =
I wonder - for example, 10.0.x is currently a long-term stable<br>
release.=C2=A0 If rust-vmm changes and implements this feature, won&#39;t w=
e<br>
hit this issue there?=C2=A0 But this time, with a painful debugging session=
<br>
because the current context is forgotten already? :)</blockquote><div>Hmm, =
you&#39;re right, Better to be safe than sorry, given it&#39;s a small fix<=
/div><div>let&#39;s keep it in stable then. Thanks for catching that!</div>=
<div><br></div><div>Br,</div><div>Dorinda.</div></div><br><div class=3D"gma=
il_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Su=
n, Feb 8, 2026 at 8:18=E2=80=AFAM Michael Tokarev &lt;<a href=3D"mailto:mjt=
@tls.msk.ru">mjt@tls.msk.ru</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">On 2/6/26 18:00, Dorinda Bassey wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Again, this feels like a qemu-stable material.=C2=
=A0 However, I&#39;m not<br>
&gt;=C2=A0 =C2=A0 =C2=A0sure under which circumstances the uuid key can be =
freed before<br>
&gt;=C2=A0 =C2=A0 =C2=A0referencing.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Please let me know if I shouldn&#39;t pick this up =
for qemu stable<br>
&gt;=C2=A0 =C2=A0 =C2=A0releases.<br>
&gt; <br>
&gt; I don&#39;t think there&#39;s a need to pick this up for stable, I fou=
nd this <br>
&gt; issue when testing the `resource_assign_uuid` feature, which is not ye=
t <br>
&gt; fully implemented in rust-vmm vhost-device-gpu backend that uses it. S=
o <br>
&gt; safe to say no existing users are hitting this code path in the curren=
t <br>
&gt; stable.<br>
<br>
This makes sense.=C2=A0 I&#39;m dropping this one from the stable series.<b=
r>
<br>
But I wonder - for example, 10.0.x is currently a long-term stable<br>
release.=C2=A0 If rust-vmm changes and implements this feature, won&#39;t w=
e<br>
hit this issue there?=C2=A0 But this time, with a painful debugging session=
<br>
because the current context is forgotten already? :)<br>
<br>
Thank you<br>
<br>
</blockquote></div>

--0000000000008b6ceb064a632163--


