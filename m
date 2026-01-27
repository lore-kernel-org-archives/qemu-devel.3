Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E9ED2FEDD
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 19:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkp14-0003xU-6z; Tue, 27 Jan 2026 14:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkp0m-0003qF-09
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 14:46:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkp0i-0003af-9W
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 14:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769543159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+4Dl9loaEYEyk5xw2Lp8W/H8bU9bg0FE62/QTI+AUXc=;
 b=A3I+GJ60sg7L07IHQAUaGdiBWsbDRlT7W2QjoHsbfcg/ssIorwMJ4Lohnfh1uqhJr65ydH
 4TQStuqf/Q/ewC4klFsDt1q3np2hUU7fHKX/3gXRTT5KX+p/0lP4GJfH0QbuE+ahB2RsoE
 zkhX4SiVJLJFv7RhHdUU1TeXTCtRvAs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-hfgEaAroMEO7N0F7WcqZwA-1; Tue, 27 Jan 2026 14:45:53 -0500
X-MC-Unique: hfgEaAroMEO7N0F7WcqZwA-1
X-Mimecast-MFC-AGG-ID: hfgEaAroMEO7N0F7WcqZwA_1769543153
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4803b4e3b9eso49476145e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 11:45:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769543153; cv=none;
 d=google.com; s=arc-20240605;
 b=Y9aP/J4EGbR5qUdcFssJdmrNXMJwAAgd1cHbJJssGUmN8CYj45U+30aJ3Ivll4vTTk
 myM3tauTJMSqPLny0m2SN/uAnyhgU5dBx9kq1APHmz23KqQRHb9Kdl+saEpYEqQ2+grA
 NdWaOV+TN+HF5zl07QYvh+fvRmKl298A15EU6XFxkcfa/ysK8C0QcNaRo8yJEeK/OW35
 TMcgdFbH3TmhpUdok3e8Q50SMvxuecpUQ+YBRMQqPJdhpsmXrQbU5FX2u1/PN1ydRTaA
 Khab6N3IZS9z6GkLvg9qypRN1a3xhcECufEvr5dqe6NG534DHfdzgjdMB3wRNzebi+h5
 UYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+4Dl9loaEYEyk5xw2Lp8W/H8bU9bg0FE62/QTI+AUXc=;
 fh=gtmQuvX3E7L1K3GnJXF+6bc66BaFoq4X0CZ/HKZxNSo=;
 b=KD0k2pAKZJooD5ElBbAc7TQ2w1RBiAWUIFYzlsF9JLtbsK33YbBd4pbPqKOBDULNrD
 zsvfF3X0YR4BGYglbN149JTXa9pVU9Xw4Cc8ITfm2Xfpdvv/+zr+mFAm9kHxDMi3vwQt
 5VNz0SWvU9k+uwz7yNLZrzx7Oa/xthj+2SaqRQlSuFT1yV/7L3f6g1ErFUvFPLXTuhlm
 HgKSGsKCRKbJze4eqYhI7edtP9TZI44pr8c8tWa7V+bWD3zpiu9wn2HkaWUuRu1DFam6
 fZMH1BDMvm63f0pZ7XAlcogtATVvzAmdEMjUmDR1P1+pFNHwUYrvFELDu6vtCUEiej7R
 75QA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769543153; x=1770147953; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+4Dl9loaEYEyk5xw2Lp8W/H8bU9bg0FE62/QTI+AUXc=;
 b=j3FopBLeqMhrCImhKz437lqHnl/B5P4/Y6C47y4IC58iKvaALiGvuE1h793TkxOpih
 Y0noq1zLKBwtQxktTwQUOAsdhwmg4JLx3rgCw1notAeZIzZ7Tg2YO4UL2J7yNwe42Gpx
 SMjSboVJTz/IJ482aowaZdugerqRfFoMowM/7q7qOlj6L7zL3JT0CDAuMvdW6FFk0H/b
 ojXohHRgQ71sC2Zu+Wpxzzp3ocxQdqpTG7Ck0XBlw/mGaIweSyFLGxuiFiI7gdzEvOMU
 CSDn2TqyrxeE7ni/0ptqio65kbfvpbYUipiokaO5Xy0aE7XgKWEydDQEyBhaspsjjbKv
 E6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769543153; x=1770147953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4Dl9loaEYEyk5xw2Lp8W/H8bU9bg0FE62/QTI+AUXc=;
 b=RM5YfNZtSLHMYxH77AwvvvTYMyUpZfA13UqzhDZVSw+IaFHjXS8x/pmFyX6uySKw2i
 NFn8icE/6PZcjKIrAC1/Ex+1aCFRVuJ5AxgeXNHaGAKrZPC6BVJnxjH5kXOOeMPZonOq
 /1y5hdH8sdZIIbDg7ugJ5/GcEAm6yVQLYV1QiWM4iHhiS+YCidPq3G6xTfQG41T4Qy4m
 bneKh9okvg/TmFv+Dp8QTYKhu49GfEoOWy7Tl8n8LymX9Qq+4aZ7pShC2tpWCEKNFYEv
 nZdJp6jy+QMcLZVyR3D2/c5YsZ/+OXaQq/MSDMn6sj4RYLHH6AhALM1xWitSkXAmvMxB
 wSAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXorsaswsAuz3oSE786YeYsrf4Ea9st/NTg1gDdDSWCSsj5SxKq0pz8bSmKc8xt3LKrPnp6l/IOFk2w@nongnu.org
X-Gm-Message-State: AOJu0YzIrgyx9oBCUNCb8izu7orD3IKsFgp5GXjRY+MKWVeXYdPP1534
 ldrAPYXMwUeGBQ3PZfLBsgaZoE0+lrstlSwazjOy/ObeNRh3ZIU1Wf0+psohwg9ozJehOex8Acl
 3BsNMNRhHcy5wsf2YXtjQYQ2AXOO3OKZwKZj7vEVlJdTGQX3uTT0F5Jxc3zVLcJFnokQ+Iwgtvt
 5VT59YysTF2IMHqLwChj3kEOGqIfuSfO8=
X-Gm-Gg: AZuq6aKLvsNx/KQPrifyooPpm7TJkz57aSx8+hk3pB+BRUBZosfG34nnw0PNZf4Vg5x
 iHKPYrvpyV0lRkee5LVjUwCg+8WqnbP6KwfHJY1ULGiV1yKL5f9GwWa491zNeVJLjuw2112qfvq
 LZWWRwdn/i0iz72GG/ZG3dPpefQ8v6HDZZk6DP1Rdchu6LjIvwDTAgxsVmatVw5yqKmvHVV6dAP
 vpoE3a0nxi87K2VaiZ3R6daG6ZhAEve6gQu2wTKtkDY9J8g9uSC3RTY6WlZ5uam7oVV4Q==
X-Received: by 2002:a05:600c:1c1c:b0:477:54f9:6ac2 with SMTP id
 5b1f17b1804b1-48069b9d651mr41327735e9.0.1769543152651; 
 Tue, 27 Jan 2026 11:45:52 -0800 (PST)
X-Received: by 2002:a05:600c:1c1c:b0:477:54f9:6ac2 with SMTP id
 5b1f17b1804b1-48069b9d651mr41327415e9.0.1769543152244; Tue, 27 Jan 2026
 11:45:52 -0800 (PST)
MIME-Version: 1.0
References: <20260127184743.GA77765@fedora>
In-Reply-To: <20260127184743.GA77765@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Jan 2026 20:45:39 +0100
X-Gm-Features: AZwV_Qg4Seyi_loJz3-G4yUC0-NFr2jTm6B2ZjER4WVoAI8wylYxjW_SVbC3Clo
Message-ID: <CABgObfZetG0O5oX+pHCAaPXwaPreWn2NSXuWpJUBdaqdL=a4-w@mail.gmail.com>
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Hannes Reinecke <hare@suse.de>, 
 Alberto Faria <afaria@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000012f6a064963df4c"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000012f6a064963df4c
Content-Type: text/plain; charset="UTF-8"

Il mar 27 gen 2026, 19:47 Stefan Hajnoczi <stefanha@redhat.com> ha scritto:

> Several of us have pondered a different approach that I will summarize
> here. The <linux/pr.h> ioctl interface provides an alternative to
> ioctl(SG_IO) without the CAP_SYS_RAWIO requirement. It supports both
> SCSI and NVMe. Since privileges are not required, there would be no need
> for the qemu-pr-helper daemon anymore.
>

Yes, no problem with that. It's easy to extend QEMU with a new pr-manager
subclass that converts SCSI commands to PR ioctls.

My suggestion is to implement <linux/pr.h> via upcalls from DM-Multipath
> to multipathd. That way applications like QEMU can consistently use
> <linux/pr.h> across block device types and no longer have to go through
> the privileged libmpathpersist interface.
>

What do you have in mind for the upcall protocol? Does it need to be done
with multipathd or can it be a separate daemon for privilege separation? I
am not sure if there is any channel between dm-mpath and multipathd that
can be extended (I think it only uses uevent?); maybe it would make sense
to reuse qemu-pr-helper's protocol even.

Paolo

Once DM-Multipath support <linux/pr.h> is functional, the main QEMU
> process can directly invoke the ioctls. qemu-pr-helper will no longer be
> needed, eliminating privileged code and simplifying the setup required
> by management tools such as libvirt and KubeVirt.
>
> The only loss in functionality that I have identified when switching to
> <linux/pr.h> is that qemu-pr-helper supports SCSI TransportIDs for the
> PERSISTENT RESERVATION OUT command. This is not supported by
> <linux/pr.h>, but I'm not sure how this even works today since the guest
> sees a virtual SCSI bus and is unaware of the physical bus or HBA. So
> maybe that was never used in the first place?
>
> Does this plan sound good to you?
>
> Benjamin: I can work on the DM-Multipath upcalls if you are busy.
>
> Thanks,
> Stefan
>

--000000000000012f6a064963df4c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 27 gen 2026, 19:47 Stefan=
 Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a=
>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Several of us have pondered a different approach that I will summarize<br=
>
here. The &lt;linux/pr.h&gt; ioctl interface provides an alternative to<br>
ioctl(SG_IO) without the CAP_SYS_RAWIO requirement. It supports both<br>
SCSI and NVMe. Since privileges are not required, there would be no need<br=
>
for the qemu-pr-helper daemon anymore.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Yes, no problem with that. It&#39;s e=
asy to extend QEMU with a new pr-manager subclass that converts SCSI comman=
ds to PR ioctls.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">My suggestion is to implement &lt;linux/pr.h&gt; via upcal=
ls from DM-Multipath<br>
to multipathd. That way applications like QEMU can consistently use<br>
&lt;linux/pr.h&gt; across block device types and no longer have to go throu=
gh<br>
the privileged libmpathpersist interface.<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">What do you have in mind for the u=
pcall protocol? Does it need to be done with multipathd or can it be a sepa=
rate daemon for privilege separation? I am not sure if there is any channel=
 between dm-mpath and multipathd that can be extended (I think it only uses=
 uevent?); maybe it would make sense to reuse qemu-pr-helper&#39;s protocol=
 even.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gma=
il_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Once DM-Multipath support &lt;linux/pr.h&gt; is functional, the main QEMU<b=
r>
process can directly invoke the ioctls. qemu-pr-helper will no longer be<br=
>
needed, eliminating privileged code and simplifying the setup required<br>
by management tools such as libvirt and KubeVirt.<br>
<br>
The only loss in functionality that I have identified when switching to<br>
&lt;linux/pr.h&gt; is that qemu-pr-helper supports SCSI TransportIDs for th=
e<br>
PERSISTENT RESERVATION OUT command. This is not supported by<br>
&lt;linux/pr.h&gt;, but I&#39;m not sure how this even works today since th=
e guest<br>
sees a virtual SCSI bus and is unaware of the physical bus or HBA. So<br>
maybe that was never used in the first place?<br>
<br>
Does this plan sound good to you?<br>
<br>
Benjamin: I can work on the DM-Multipath upcalls if you are busy.<br>
<br>
Thanks,<br>
Stefan<br>
</blockquote></div></div></div>

--000000000000012f6a064963df4c--


