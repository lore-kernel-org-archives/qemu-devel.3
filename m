Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2350BF8D761
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 16:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDPDK-0007qI-U5; Thu, 16 Apr 2026 12:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wDPDE-0007pz-E4
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 12:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wDPDA-0006WP-Rh
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 12:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776355499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m5H4wjHdofvafk85En5ZmoW54I0Sx/noKO+OR7YIg2c=;
 b=YJ1Ce7OBDNg4Qv3izim1BpaDvIiygsydiOjjUFRhd7nx/VJ1gFQLUQnGuLFVWvel7vaxup
 K/o5D143WnIU6tp3YOIWeTrPXHEjBsHgaLWM9hO/tJgzCwnRwVL71v5yhHWOi6IAwhpFf/
 2DE1hc3VdZ5IB0B7p+UiuIrZNI/lmlg=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-ceLEmI6HOwWug_oMD6Bvvg-1; Thu, 16 Apr 2026 12:04:57 -0400
X-MC-Unique: ceLEmI6HOwWug_oMD6Bvvg-1
X-Mimecast-MFC-AGG-ID: ceLEmI6HOwWug_oMD6Bvvg_1776355497
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82f07078eaaso4488628b3a.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 09:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776355497; cv=none;
 d=google.com; s=arc-20240605;
 b=D3Qz15XhLeCQv4zt401dSxxN/AhTBcwpiVwUMwXeRLBua65xPoXfD1cmIDQJFpqdj4
 QnJEQ+Cu0x5EHaOdqFaaeMTek0BJMhp13GEhzushlrIjIgzFzM1quI3CBiOLAgQtXhat
 DoXRcadxXAtlxFNGXDVf7WL6e8a2Kg5sTU7Tre/C7dr9UYyecX4PSHQt3K7kuRxmB/1H
 WITaq7qxn9G9Hr2EfK1M9X2KhJbIxcdkfICA151LuldWXBmvnODb2E5ErHUyj6lg6Qse
 FwgdfMU9l/bA9XN4Im7S9VnP11kTR5U08hdEbcY/RU6KZYcm0atv+91nIutyLRIz2mhC
 34BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=m5H4wjHdofvafk85En5ZmoW54I0Sx/noKO+OR7YIg2c=;
 fh=3A5P2ffpjyLuLVgpyALQw2sBnuR96KRPDr4Rf3xcZ8g=;
 b=CtyBMEywVyraDOIwJE36odEwGqK4yjRFl3miWjmNcN4ech2IuhH2k85bP966IkWfqn
 DKVCeRKRkccn76OW1gnmYbmvSrSOx7ROKjDchjHu2eJeeeG34sbd3tKAZ4pV1jlWHJST
 JXlphW4WPtX2905DXvY1TRZct/Q4S7JM8+RYfASGCkOinQ8QqEajyhZZEWGzWcJ9/lLB
 jkoIUKPx/SLkkl7XBul1S+n8FNSUEz34RVIO+XnlI1NbhWqd4VzzgisB1521hTIzR3qo
 67oEbi8yjYtdjg7AlZV0ndjLroEIQ4CzmWB95JUo1F0KI1qmTQAS3TySIXZno6Puzf4E
 g0sw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776355497; x=1776960297; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m5H4wjHdofvafk85En5ZmoW54I0Sx/noKO+OR7YIg2c=;
 b=Uj3Izn2/yhdhzdmoaNNRdsH7NqCUb1dbJxRZIBvdh1I2cjLrD2fh4ZrUfhyvmCbk11
 IPgpzF0a81Dl0QV+azulgKuKBM+BPM4CQMW5+RlyXLJCXuw4nxyxZ4vvXWI+RcVFjKqB
 C3k9oM5mbCR6lXVf4vgSwpnt7PIxcg7ZCycfTKKJTAsytmfrOPr/FnNsnu36YmDA5j5o
 Q00eCAdw5w05DpNFKUmZ1N7fM3F3yTTSRa+Xs16SWC3kVbTL2ZFlDMYdiccTd8jcaBC4
 ikUPhra9XJBzTHSqSoots099JSAajTsT+2hcu0U/TuzOGyY9uZLpsJCS9xP+fseeUxOv
 c2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776355497; x=1776960297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m5H4wjHdofvafk85En5ZmoW54I0Sx/noKO+OR7YIg2c=;
 b=r5xWXkGT+TyYlNgERphwDLmGlMJ8sn4f7qX4fHr2fGsklBVSh6McsNJR84fgxHkg1m
 /YbJ2wPa7dRAHyWlIZZOKRE1H7fGgLwuzz2qDndrKcyTp356Iip2P9cE5qmihMi6m9X2
 fao+cHTEmxYbJ/95deJFx1y6kTwgQZOvUAH84JK/cdYz0dC+i4C7yNQKq5dIfmScnL5q
 7h/e6FYZrs30NxqcSgIv4bUawKKUX4aaDdDWKTgOydbPgjKRB6sALjCOWTI/DVUxSg7R
 8lkXTT9HKC6pKiXM2EsL3VIEAW+LBtVGUweeLhLgE1Ae+ohG5YWi+QazB5YosiOCKp0Z
 7wqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4erFfzxTziImRyZjMs9qy5APE52YLw665Kk9Ctm8xPlHWUjvcRKlON5Kb4ciOeaMClJJdgilYVFSP@nongnu.org
X-Gm-Message-State: AOJu0YzCQydDcQ5LyYeKLLn8b/md4jSR+SGFPg9vUKr3BfM7UxZr0Z5U
 CoP8ySooHPnZWV6Iih6Tn8JOqY7HuViqb0cl8Gun0tQ6UujY+nOxT6pbjGgcZBFhKfAPCdVwmxr
 To98ofTX5Bqn8lQVWKlOGLNIAJmnd2S2znlmX+VIfFQ5Ktc2hDzxseFuYr0sERVRh2pWXQnkM1+
 lP1Y/7Ht1L6pzpkshhWM9dF/O3pf+W30c=
X-Gm-Gg: AeBDietsFtc8yOVJtREATjk3poEle5YHnjMpApEG/itq8hZC2ZB9sA8kKdjkAxNBD6/
 CKlS27XpIfM2ox4YICw/1Bi2QUK1GxqcEarymzINNFBf5cz3rBNnsk/fz9q5sa1OTFrITIJMgp7
 dOPw72/itLQfMEGEF/bYVynHc1CUpYaMh9UQInAPj1UeHovA48GPG39cu3/dj0KCkuQ1Crie5MN
 pe5mHj3qh4n5D5X317k4hk9M903WDBCTsiYLHrpNOHO++/WdJ0BFEhOV2XsWFcKhvYYfJvL3ijx
 tujBaQI6kAeHxj8=
X-Received: by 2002:a05:6a00:3e0a:b0:82f:7252:38cf with SMTP id
 d2e1a72fcca58-82f87e4bc0dmr69492b3a.16.1776355496422; 
 Thu, 16 Apr 2026 09:04:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e0a:b0:82f:7252:38cf with SMTP id
 d2e1a72fcca58-82f87e4bc0dmr69426b3a.16.1776355495687; Thu, 16 Apr 2026
 09:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260112113139.3762156-1-flosch@nutanix.com>
 <20260112113139.3762156-3-flosch@nutanix.com>
 <a28bd807-6e98-4393-a354-b7ed1f7a08ae@redhat.com>
 <f878fd12-17bc-4249-beca-cd134bb93d2c@nutanix.com>
In-Reply-To: <f878fd12-17bc-4249-beca-cd134bb93d2c@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Apr 2026 18:04:41 +0200
X-Gm-Features: AQROBzB5XTEFKzA_2Xf2FtWFtf7TEFq2ZTIrQ9chevnxzVIX8WGNBo9UXJM0Bzw
Message-ID: <CABgObfYYt0CuLzj4kdD13J3+bUqAxNpmKTc4g=LtbojvKAatyQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] Add HvExtCallGetBootZeroedMemory
To: Florian Schmidt <flosch@nutanix.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000050cc3d064f95fe68"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000050cc3d064f95fe68
Content-Type: text/plain; charset="UTF-8"

Il gio 16 apr 2026, 17:33 Florian Schmidt <flosch@nutanix.com> ha scritto:

> Hi Paolo, thank you for your reply!
> I'm not sure we can rely on that. I'd have to double-check. Crucially,
> I'm pretty sure some Windows versions may call this more than once, and
> which of those results it then uses is the big question: if it's always
> the first one, we could stop there, return "nothing" as answer for
> further ones, and be good. If it's not the first one... that's a
> problem, because I don't think we want to do this kind of tracking for
> the whole lifetime of the guest?
>

Indeed absolutely not.

> As an alternative to tracking dirty pages in KVM, it would be possible
> > to ask KVM to build a bitmap of pages that were mapped, even at high
> > granularity (e.g. with 32MB you'd fit the bitmap for 1TB of memory in a
> > single page!).  QEMU could use dirty page tracking, and build a
> > combination (NOR) of the bitmap from KVM and QEMU's dirty page bitmap.
> >
> > QEMU could also do the same high-granularity tracking, but that leaves
> > out other sources of writes like VFIO or vhost, both of which probably
> > matter to Nutanix :) and which would be stuck with 4k-granularity dirty
> > page tracking.
>
> Are you thinking of creating a new KVM ioctl that would do that for us?
> That's possible, but... isn't good old mincore enough in this case,
> since qemu knows the host-virtual addresses of the guest memory?


Yes and no respectively. For example if you use preallocation mincore will
return always no, and if you swap it will return yes incorrectly.

One thing I was wondering about was races. Unless we pause the guest
> while we're scanning the tables, the guest could touch pages as we scan.
> But: at the point the hypercall is invoked by the guest, the guest OS is
> up by definition. So at this point, the guest OS must be aware of any
> memory that is put to use, correct?


Yes, it probably would go through its free page pool and decide whether to
move it to the zeroed page pool based on the answer. Though the info in my
copy of Tanenbaum is 25 years old at this point. :)

Even including vfio/vhost stuff,
> since the buffers used to write data into the guest would have been set
> aside for that purpose by the guest. So even if we overestimate and
> announce some pages as pre-zeroed, that shouldn't matter if the guest OS
> already handed them out for some usage (and pre-zeroed them in the
> meantime). What we really care about is not announcing any pages as
> pre-zeroed that are in fact dirty, *and* that the guest OS does not
> realise were ever dirtied.
>

Yes. The risky part is stuff that were written to in the past (such as
while firmware ran) by VFIO and vhost.

Paolo


> ... Famous last words and I'm not 100% sure, I appreciate any thoughts
> on this.
>
> Cheers,
> Florian
>
>

--00000000000050cc3d064f95fe68
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 16 apr 2026, 17:33 Floria=
n Schmidt &lt;<a href=3D"mailto:flosch@nutanix.com">flosch@nutanix.com</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Hi Paolo, thank you for your reply!<br>I&#39;m not sure we can rely on that=
. I&#39;d have to double-check. Crucially, <br>
I&#39;m pretty sure some Windows versions may call this more than once, and=
 <br>
which of those results it then uses is the big question: if it&#39;s always=
 <br>
the first one, we could stop there, return &quot;nothing&quot; as answer fo=
r <br>
further ones, and be good. If it&#39;s not the first one... that&#39;s a <b=
r>
problem, because I don&#39;t think we want to do this kind of tracking for =
<br>
the whole lifetime of the guest?<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Indeed absolutely not.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contai=
ner"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; As an alternati=
ve to tracking dirty pages in KVM, it would be possible <br>
&gt; to ask KVM to build a bitmap of pages that were mapped, even at high <=
br>
&gt; granularity (e.g. with 32MB you&#39;d fit the bitmap for 1TB of memory=
 in a <br>
&gt; single page!).=C2=A0 QEMU could use dirty page tracking, and build a <=
br>
&gt; combination (NOR) of the bitmap from KVM and QEMU&#39;s dirty page bit=
map.<br>
&gt; <br>
&gt; QEMU could also do the same high-granularity tracking, but that leaves=
 <br>
&gt; out other sources of writes like VFIO or vhost, both of which probably=
 <br>
&gt; matter to Nutanix :) and which would be stuck with 4k-granularity dirt=
y <br>
&gt; page tracking.<br>
<br>
Are you thinking of creating a new KVM ioctl that would do that for us? <br=
>
That&#39;s possible, but... isn&#39;t good old mincore enough in this case,=
 <br>
since qemu knows the host-virtual addresses of the guest memory?</blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes and no resp=
ectively. For example if you use preallocation mincore will return always n=
o, and if you swap it will return yes incorrectly.</div><div dir=3D"auto"><=
br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">One thing I was wonderin=
g about was races. Unless we pause the guest <br>
while we&#39;re scanning the tables, the guest could touch pages as we scan=
. <br>
But: at the point the hypercall is invoked by the guest, the guest OS is <b=
r>
up by definition. So at this point, the guest OS must be aware of any <br>
memory that is put to use, correct?</blockquote></div></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Yes, it probably would go through its free p=
age pool and decide whether to move it to the zeroed page pool based on the=
 answer. Though the info in my copy of Tanenbaum is 25 years old at this po=
int. :)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gm=
ail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">Even including vfio/vhost stuff, <br>
since the buffers used to write data into the guest would have been set <br=
>
aside for that purpose by the guest. So even if we overestimate and <br>
announce some pages as pre-zeroed, that shouldn&#39;t matter if the guest O=
S <br>
already handed them out for some usage (and pre-zeroed them in the <br>
meantime). What we really care about is not announcing any pages as <br>
pre-zeroed that are in fact dirty, *and* that the guest OS does not <br>
realise were ever dirtied.<br></blockquote></div></div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">Yes. The risky part is stuff that were written to=
 in the past (such as while firmware ran) by VFIO and vhost.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
... Famous last words and I&#39;m not 100% sure, I appreciate any thoughts =
<br>
on this.<br>
<br>
Cheers,<br>
Florian<br>
<br>
</blockquote></div></div></div>

--00000000000050cc3d064f95fe68--


