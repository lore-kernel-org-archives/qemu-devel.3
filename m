Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FF7CCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 20:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDTWC-0000Ov-S4; Mon, 27 Oct 2025 16:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1vDTW8-0000OV-8l
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 16:08:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <csomani@redhat.com>)
 id 1vDTW2-0003RY-Is
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 16:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761595700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KfbE8twWN5mleo6BLszqh3rtiajyRr2Q66zgpuK2Fac=;
 b=LBTpNFPlyf5LNb68udcy36ySzXOFdthl5MY32nikIyFnNb1l/jh9H6gAcmX8ycTRU9TShA
 UaVIj/HUVChjwYg1zQI2DYAdCDUz+UrbC5aYX9nc+ib1GcCwTZBqISyrUSrVUenOevKFuD
 QvgHO4ysM7WMsi9sn32YQG4SNKsiOck=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-KEUXXApYPS648Qjm75wagQ-1; Mon, 27 Oct 2025 16:08:17 -0400
X-MC-Unique: KEUXXApYPS648Qjm75wagQ-1
X-Mimecast-MFC-AGG-ID: KEUXXApYPS648Qjm75wagQ_1761595697
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-5a0d093ceacso1823811137.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 13:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761595697; x=1762200497;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KfbE8twWN5mleo6BLszqh3rtiajyRr2Q66zgpuK2Fac=;
 b=oZJy0RMo8OvoCMikfeB4cwJiMnt9oMjc0hEagOktdclsIZiFs3gIelSDLbs1Ah3e2+
 eT2iQcacr3dufsd387a8kWQXZmsHClnhiKXOoKKZVrsKvmRUWEzN+BFTlwNCG0tPSMX8
 gMomo67MdgVmpjvT1zjJ3jqfg5L+rDeVPZY4Eg0tletIBPj+SIoh4SAE8bPc8TQs+Vfa
 XSkJ0R4TtJL7q8fWzXuDgXMMgDBvUPFac062KsHjitc4V+rs9CpZG9aQqxMmkIFDdyJK
 mDhJ9qfTV2kpAT4xuBF3Rcl24wPRMk3+k73tO4FSptkPU1/DWKPn0CsnxlXlkibqWlTt
 JN0A==
X-Gm-Message-State: AOJu0Yz5pQALzikAA7aJCEhqi2H3mosYLj8Jb3lUncrX/gzhbZKtHqph
 ufLBGK7/GhRNBLuPNewXAjzKY/OMyj9mWYsTajnUplmMNx4ni761dGCXvddqkJowommQazxI49V
 TSvXWs+oCHTJmM+X6hxVeMAZOa/yJJs2PgjcSXaxeOVgJrIN+Xq9l5+uR38lVEzawFsSbgpE6Tj
 kS6rNhkZWghLbL1jjAZ3rpllYbC8q/3P8=
X-Gm-Gg: ASbGncveA4+XmYasZfQ9JoLGFzEnPvlKGwOCfqRsiccbwfKnAw6W6HyBolYjIgQlHc2
 3iZ++Ob6K1gmX3Hjrdh0oyVh5ZeJf0BOizyGym3915ESCajjEgZ51vfxkF5MeIm37aPWc312lJP
 EKdKk5zw7hcmA8D4Hiei/HEVC/eXXwEzyJ/A4ddudzuWfOJTBj+5iSN1ja
X-Received: by 2002:a05:6102:34d5:b0:5db:3cc4:5b60 with SMTP id
 ada2fe7eead31-5db7ca8bbf9mr404389137.15.1761595697074; 
 Mon, 27 Oct 2025 13:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO9q+hsGBjSRbvO9bvh59XWbAAgvELxzObbb7gAH4Snnp1jesAPh7/mkjeCQfw8HIo9/DKJf3R4OkGBIKOrTM=
X-Received: by 2002:a05:6102:34d5:b0:5db:3cc4:5b60 with SMTP id
 ada2fe7eead31-5db7ca8bbf9mr404382137.15.1761595696353; Mon, 27 Oct 2025
 13:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20251003220039.1336663-1-csomani@redhat.com>
 <aPpue5a-uCkdlc9z@redhat.com>
In-Reply-To: <aPpue5a-uCkdlc9z@redhat.com>
From: Chandan Somani <csomani@redhat.com>
Date: Mon, 27 Oct 2025 13:08:04 -0700
X-Gm-Features: AWmQ_bn6KD38Aka6S70Igx8HFpvxOxbrAAfIFRHS4Za8a1VK2SixQZ6rFzYuFQw
Message-ID: <CAHEFcASuJ1paM+4-=DpCtJxXiF2ifZuTYSx7HnR+Y32jQCJH=A@mail.gmail.com>
Subject: Re: [PATCH v2] block: enable stats-intervals for storage devices
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000b827cd0642297579"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=csomani@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000b827cd0642297579
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:05=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrot=
e:

> Am 03.10.2025 um 23:59 hat Chandan Somani geschrieben:
> > This patch allows stats-intervals to be used for storage
> > devices with the -device option. It accepts a list of interval
> > lengths in JSON format.
> >
> > It configures and collects the stats in the BlockBackend layer
> > through the storage device that consumes the BlockBackend.
> >
> > Signed-off-by: Chandan Somani <csomani@redhat.com>
>
> Thanks, applied to the block branch.
>
> Maybe you can add a patch on top that extends tests/qemu-iotests/136 to
> also test the -device based settings (probably in a new child class)
> instead of only -drive?
>
Yes, will work on this

>
> Kevin
>
>

--000000000000b827cd0642297579
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 23,=
 2025 at 11:05=E2=80=AFAM Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com=
">kwolf@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Am 03.10.2025 um 23:59 hat Chandan Somani geschrieben:<br=
>
&gt; This patch allows stats-intervals to be used for storage<br>
&gt; devices with the -device option. It accepts a list of interval<br>
&gt; lengths in JSON format.<br>
&gt; <br>
&gt; It configures and collects the stats in the BlockBackend layer<br>
&gt; through the storage device that consumes the BlockBackend.<br>
&gt; <br>
&gt; Signed-off-by: Chandan Somani &lt;<a href=3D"mailto:csomani@redhat.com=
" target=3D"_blank">csomani@redhat.com</a>&gt;<br>
<br>
Thanks, applied to the block branch.<br>
<br>
Maybe you can add a patch on top that extends tests/qemu-iotests/136 to<br>
also test the -device based settings (probably in a new child class)<br>
instead of only -drive?<br></blockquote><div>Yes, will work on this</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Kevin<br>
<br></blockquote><div>=C2=A0</div></div></div>

--000000000000b827cd0642297579--


