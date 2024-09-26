Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59977CDE02B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 18:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stt0O-0006Q6-T1; Thu, 26 Sep 2024 14:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1stt0I-0006PH-Or
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 14:14:14 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1stt0C-0004LJ-A4
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 14:14:13 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3e26d148991so969263b6e.3
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1727374444; x=1727979244;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h0DsepUoTAiGLH6A6eNgDVOIYlb7tg17xM0xSkP/cA8=;
 b=o044GvakYempOYISFKi5rbsw6dmgUMcf03e1pWQr/a1d34GQrp3iG1InjKJXxJ3/w+
 4ErcGWyLCD50A2t8VSWQjgU/dXE7s8tI9puRotw1jM2CzPSJEDxSBSEvvB+0ydYLcOuo
 EytEeRgonuhCRlbJusyOaRud5uCpHe9eGRjtYW0k6I3NB+Asvrh+hjkzH2aOFb8cfcLH
 GUc9wrikH93EdzW2DevDSsQx7fVRaXITLwp1MG0hq4tOk/+oO3RKKMZEVMb8ZiJGmc0c
 cpf9OvOfg7lNE2YhrPMXVXgIUmDUZMqPn8E9uECIqQ59zWc/9AZN27sY44WbBIo5cCmf
 9JfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727374444; x=1727979244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h0DsepUoTAiGLH6A6eNgDVOIYlb7tg17xM0xSkP/cA8=;
 b=lr+xaFw7svEk6R8ANCHmzw0gyxAYk7IiauMFc/MHNSwHHP6/hbkYnaIjqsyOLSIu2v
 834yY1QZ+n/ArHUpJl1H2NNoIeroDtmibWaaX5WeYINJKmsK4+XojBmIi1tfIDoXJkb5
 0lnrJdYFVpRYLh/hATHU0M2+jBVA7UE9zsa9g76As6ZFvtV3YF2Aj/HCqYQNft8DFiUC
 IufZWFzkPXt32vZrxIj4/gpL4M3QjVmHdV6+s+yPol9lfoggASwW6FE8IMMdBMKTfAr6
 TgQ2wvO+0wWDGc724gJcep6GQMW71TgeNAHh1WkfTaZDlBVMPkMMcfA+zQ9nBJ7MtIVB
 v6Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUewips53jQW49plUc/TSeWhWTPsvC5NQhwLUpKpE967AqkikObvnTJeBdtbP/Zb+g03Ctme92LlB7o@nongnu.org
X-Gm-Message-State: AOJu0YzmfO70/WAZcOg3xlxEAIKOn6H++tUUj5R8X9GOi4Btl/2V7Qcm
 kcPTYxI1s+zuSwu5b5ozvkw5B5nxK1Zu3R7OBBROe3yHODNtYu416Gv1weI2qb6Y9n+m5YTANSw
 kdwYvb+gyiR6DVwDtYoTC3T4lBCWRL7ARWduRfA==
X-Google-Smtp-Source: AGHT+IGnJwWoh46JdfYpEiGSRX1yZz3HMl8iWaWIza3mmn/t6SvKacPmsFIP341D0ouQLPhxFYlRBvlmya3QTw/6Wkg=
X-Received: by 2002:a05:6870:808c:b0:278:22d3:53 with SMTP id
 586e51a60fabf-28710a50878mr947674fac.12.1727374443698; Thu, 26 Sep 2024
 11:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1726390098.git.yong.huang@smartx.com>
 <531750c8d7b6c09f877b5f335a60fab402c168be.1726390098.git.yong.huang@smartx.com>
 <87msk7z4l3.fsf@suse.de>
 <CAK9dgmb_rK5HJOGTG=KXKgH=e2e8JV8aqoOWUHBEyjnc-+kiqg@mail.gmail.com>
 <ZuxxOObKqS_G0Ela@x1n>
 <CAK9dgmYaE=poiwLQqD6qbjJQdgPLMn8cW8VO47xYFTBkNiUVLA@mail.gmail.com>
 <ZvRh0RhkUC-eLbjo@x1n>
In-Reply-To: <ZvRh0RhkUC-eLbjo@x1n>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 27 Sep 2024 02:13:47 +0800
Message-ID: <CAK9dgmbi1VSXvxFjziH5PjaoiaQwBJ3z4ff1BAojtm26VTThUQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] migration: Introduce structs for background sync
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001c795e062309b479"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

--0000000000001c795e062309b479
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 3:17=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:

> On Fri, Sep 20, 2024 at 10:43:31AM +0800, Yong Huang wrote:
> > Yes, invoke migration_bitmap_sync_precopy more frequently is also my
> > first idea but it involves bitmap updating and interfere with the
> behavior
> > of page sending, it also affects the migration information stats and
> > interfere other migration logic such as migration_update_rates().
>
> Could you elaborate?
>
> For example, what happens if we start to sync in ram_save_iterate() for
> some time intervals (e.g. 5 seconds)?
>

I didn't try to sync in ram_save_iterate but in the
migration_bitmap_sync_precopy.

If we use the migration_bitmap_sync_precopy in the ram_save_iterate
function,
This approach seems to be correct. However, the bitmap will be updated as
the
migration thread iterates through each dirty page in the RAMBlock list.
Compared
to the existing implementation, this is different but still straightforward=
;
I'll give it a shot soon to see if it works.


> Btw, we shouldn't have this extra sync exist if auto converge is disabled
> no matter which way we use, because it's pure overhead when auto converge
> is not in use.
>

Ok, I'll add the check in the next versioni.


>
> Thanks,
>
> --
> Peter Xu
>
>
Thanks for the comment.

Yong

--=20
Best regards

--0000000000001c795e062309b479
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 26, 20=
24 at 3:17=E2=80=AFAM Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" tar=
get=3D"_blank">peterx@redhat.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">=
On Fri, Sep 20, 2024 at 10:43:31AM +0800, Yong Huang wrote:<br>
&gt; Yes, invoke migration_bitmap_sync_precopy more frequently is also my<b=
r>
&gt; first idea but it involves bitmap updating and interfere with the beha=
vior<br>
&gt; of page sending, it also affects the migration information stats and<b=
r>
&gt; interfere other migration logic such as migration_update_rates().<br>
<br>
Could you elaborate?<br>
<br>
For example, what happens if we start to sync in ram_save_iterate() for<br>
some time intervals (e.g. 5 seconds)?<br></blockquote><div><br></div><div><=
div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">I didn=
&#39;t try to sync in ram_save_iterate but in the=C2=A0</font><span style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">migration_bitmap_sync=
_precopy.</span></div><div class=3D"gmail_default"><span style=3D"font-fami=
ly:&quot;comic sans ms&quot;,sans-serif"><br></span></div><div class=3D"gma=
il_default"><font face=3D"comic sans ms, sans-serif">If we use the migratio=
n_bitmap_sync_precopy in the ram_save_iterate function,</font></div><div cl=
ass=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">This=C2=A0ap=
proach seems to be correct. However, the bitmap will be updated as the</fon=
t></div><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-seri=
f">migration thread iterates through each dirty page in the RAMBlock list. =
Compared</font></div><div class=3D"gmail_default"><font face=3D"comic sans =
ms, sans-serif">to the existing implementation, this is different but still=
 straightforward;</font></div><div class=3D"gmail_default"><font face=3D"co=
mic sans ms, sans-serif">I&#39;ll give it a shot soon to see if it works.</=
font><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br><=
/span></div><div class=3D"gmail_default"><br></div></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
Btw, we shouldn&#39;t have this extra sync exist if auto converge is disabl=
ed<br>
no matter which way we use, because it&#39;s pure overhead when auto conver=
ge<br>
is not in use.<br></blockquote><div><br></div><div><div style=3D"font-famil=
y:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Ok, I&#39;l=
l add the check in the next versioni.</div></div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-widt=
h:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padding-le=
ft:1ex">
<br>
Thanks,<br>
<br>
-- <br>
Peter Xu<br>
<br>
</blockquote></div><br clear=3D"all"><div><div style=3D"font-family:&quot;c=
omic sans ms&quot;,sans-serif" class=3D"gmail_default">Thanks for the comme=
nt.</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" cl=
ass=3D"gmail_default"><br></div><div style=3D"font-family:&quot;comic sans =
ms&quot;,sans-serif" class=3D"gmail_default">Yong</div><br></div><span clas=
s=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_=
signature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best r=
egards</font></div></div></div>

--0000000000001c795e062309b479--

