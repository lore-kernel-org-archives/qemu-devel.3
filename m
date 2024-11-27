Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36BBD609A0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 05:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGAqu-0004ln-Dc; Wed, 27 Nov 2024 00:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zzhangphd@gmail.com>)
 id 1tG7Mb-0002xH-E1
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 21:01:09 -0500
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zzhangphd@gmail.com>)
 id 1tG7MY-0007WQ-AX
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 21:01:09 -0500
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e388d8850d3so6108232276.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 18:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732672864; x=1733277664; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/OzBLSo0MUco3fGE9PH+FLy8BRllJZbdcHycBNjbBjs=;
 b=aWOqaZoktq+HocgJZ9MhNCnlLE2gdLW6boJMcxnCqRFf7IhLKYeEVOrJyHT116j2r7
 EpQi9RFj+IEX/TOZLA7ZFh0jgEKCmLc5tJkKBwNY0wQkrRv5+WH1+e5p5eufFWIVbiw6
 GH1+mnYlEDf5PUOsoLf3yeW5v/3WYGCPZwr2/hGXT+xB3jMedPHPlJhTBEEq6j/OeUnz
 kE28srlXNW4LSZ5GrfJQg9OXWwcje8OHPifS9RZUTGvjInMGE8rI29gA7tkdKCZGYo8W
 HlcXVV5/ZruXoSNapPQDXgFix/kep+pwzRQCs7rrN9OJLduKwgTSSKRxKdLg+fsgThS/
 AVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732672864; x=1733277664;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/OzBLSo0MUco3fGE9PH+FLy8BRllJZbdcHycBNjbBjs=;
 b=Ds9mV9WbwuG0wvYC5f5PdbYGCK5CzO6DONouhpV0czWLxIwzj2/2zPzMckiCWijrXb
 XDvr5Mf8cvnQ00CO5lAmk8sd+XPaEw95g99EZPG311x7Qw6Z2TKk98RY6tiLGopZhLvN
 y/2xIN3sc5v4q/PwcZPuHo/haEbIQA72B1Z06CAyVvOtWlOngW9ORDGHBT/jrW0sp1tu
 1bgcnzMaGCGOwSVadg4Xg7r1hR7d1oNsc4/zMs7WFWq9Qnx6vq2uuNPXVvaPV49tmx4k
 M/4aev1hbUx2W/NPQ/2Ual1o8HH9nYivprbYkxbzF+rzvgOhjBModNVvux63+PWFW1TO
 HdmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ3ys2Q/YxYhXfrpmtT+p2Qz4EFmisNZsccYhi3xWYHdy8Phul0V0AjWNYNF3G8eU3C+6ck+D1zyn+@nongnu.org
X-Gm-Message-State: AOJu0YxSGKti8QEmL9Z+n6h0a8eoJPfifPYwqIbMGJ8xyPSujyGv/vuJ
 G1akP3Ym/XtGbbjA19UMa7o9vmRsM3EKnq2wF6EVxs3i/GxnQlFoi+IdgCrUlyMusrkxdHvtI8a
 sTh09yuxvmgvdLSQmx2Q/No0jZko=
X-Gm-Gg: ASbGncsUxWlFF13W2hKqk2mW7+nMoAlySbAfxfTSVy3eZVvXNsaOqA/Xhj+4gs5CxGM
 +OYWo9JfP/bgMydCQ7Z2oUhr5y8OvD1m4
X-Google-Smtp-Source: AGHT+IFLuZ8SEqPD5TAyCWwxG4wuFF50ExupWvdz4itzWz3fiYX7E16Pir1L0yRAis68PSbQvp9THncme/PWEHSvu1Y=
X-Received: by 2002:a05:6902:2487:b0:e38:a34f:ff7b with SMTP id
 3f1490d57ef6-e395b8eb4d2mr1336695276.30.1732672864370; Tue, 26 Nov 2024
 18:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20241126080213.248-1-weichenforschung@gmail.com>
 <2ac194a7-9790-4aa7-bb41-65f8bb21f616@redhat.com>
 <f02565f6-c584-44d0-944f-26c062cc2be9@gmail.com>
 <553cf07a-a603-402d-8e86-b4ada42a2dcd@redhat.com>
 <93616a1e-3614-49ca-9515-697f1c9205b6@gmail.com>
 <9eafe8fa-de09-40e3-9687-573255ce37de@redhat.com>
In-Reply-To: <9eafe8fa-de09-40e3-9687-573255ce37de@redhat.com>
From: zhi zhang <zzhangphd@gmail.com>
Date: Wed, 27 Nov 2024 10:00:53 +0800
Message-ID: <CAD-9bcdm+gupZQ91Q-JMjuPikVmfVhCdJuwq=ptfaipL7Peevg@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/virtio-mem: Prohibit unplugging when size <=
 requested_size
To: David Hildenbrand <david@redhat.com>
Cc: Wei Chen <weichenforschung@gmail.com>, qemu-devel@nongnu.org,
 mst@redhat.com, yuval.yarom@rub.de, genkin@gatech.edu
Content-Type: multipart/alternative; boundary="00000000000097ced30627db563b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=zzhangphd@gmail.com; helo=mail-yb1-xb2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 27 Nov 2024 00:44:38 -0500
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

--00000000000097ced30627db563b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 11:52=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:

> On 26.11.24 16:31, Wei Chen wrote:
> >   > How can you be sure (IOW trigger) that the system will store
> >   > "important data" like EPTs?
> >
> > We cannot, but we have designed the attack (see below) to improve the
> > possibility.
> >
> >   > So is one magic bit really that for your experiments, one needs a
> >   > viommu?
> >
> > Admittedly the way we accomplish a VM escape is a bit arcane.
>
> That's what I imagined :)
>
> >
> > We require device passthrough because it pins the VM's memory down and
> > converts them to MIGRATE_UNMOVABLE.
>
> Interesting, that's news to me. Can you share where GUP in the kernel
> would do that?
>

In /drivers/vfio/vfio_iommu_type1.c, there is a function called
vfio_iommu_type1_pin_pages where VM's memory is pinned down.


>
> > Hotplugged memory will also be
> > converted to MIGRATE_UNMOVABLE.
>
> But that's in the VM? Because we don't hotplug memory in the hypervisor.
>

Yes, the virtio-mem driver in the VM is modified to actively release memory
vulnerable to Rowhammer.

For more details, would you be interested in reading our paper? It was
recently submitted to ASPLOS for publication and we are happy to share it
with you.

Regards,
Zhi Zhang

--00000000000097ced30627db563b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Nov 26, 2024 at 11:52=E2=80=
=AFPM David Hildenbrand &lt;<a href=3D"mailto:david@redhat.com">david@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On 26.11.24 16:31, Wei Chen wrote:<br>
&gt;=C2=A0 =C2=A0&gt; How can you be sure (IOW trigger) that the system wil=
l store<br>
&gt;=C2=A0 =C2=A0&gt; &quot;important data&quot; like EPTs?<br>
&gt; <br>
&gt; We cannot, but we have designed the attack (see below) to improve the<=
br>
&gt; possibility.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0&gt; So is one magic bit really that for your experiments,=
 one needs a<br>
&gt;=C2=A0 =C2=A0&gt; viommu?<br>
&gt; <br>
&gt; Admittedly the way we accomplish a VM escape is a bit arcane.<br>
<br>
That&#39;s what I imagined :)<br>
<br>
&gt; <br>
&gt; We require device passthrough because it pins the VM&#39;s memory down=
 and<br>
&gt; converts them to MIGRATE_UNMOVABLE. <br>
<br>
Interesting, that&#39;s news to me. Can you share where GUP in the kernel <=
br>
would do that?<br></blockquote><div><br></div><div>In /drivers/vfio/vfio_io=
mmu_type1.c, there is a function called vfio_iommu_type1_pin_pages where VM=
&#39;s memory is pinned down.</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
&gt; Hotplugged memory will also be<br>
&gt; converted to MIGRATE_UNMOVABLE. <br>
<br>
But that&#39;s in the VM? Because we don&#39;t hotplug memory in the hyperv=
isor.<br></blockquote><div><br></div><div>Yes, the virtio-mem driver in the=
 VM is modified to actively release memory vulnerable to Rowhammer.</div><d=
iv>=C2=A0</div><div>

For more details, would you be interested in reading our paper? It was rece=
ntly submitted to ASPLOS for publication and we are happy to share it with =
you.

</div><div><br></div><div>Regards,</div><div>Zhi Zhang</div><div><br></div>=
</div></div>

--00000000000097ced30627db563b--

