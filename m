Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF3DF34C5C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCJ9X-0006pN-I3; Mon, 13 Apr 2026 11:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wCJ9S-0006k6-9x
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:24:38 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wCJ9Q-0000aG-0F
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:24:37 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-793fdbb8d3aso49554517b3.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 08:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776093874; cv=none;
 d=google.com; s=arc-20240605;
 b=PLBfL8LhtvLCp8zoSbA/xJNx5Z0xvp9J2QI/LnjOqIUYwcx/H+SCxsjHdESa7h1UAD
 tnNytArtZALp13Oj5FQTDEXMgKy1Th/ZfdXce5tfJO5YD/LsMpzxD21PaXjVy8esAyaR
 bPjzkw4YBVRNugak/j0Qn0cHXE/8jrl/BKGsILQp84VO8u2alGkYHtkfrleaTJhDygUk
 hwwjP6Q16G0Q8YqFparf583XDRQ6BOUZ6paYKq+/ImXLaDPhSlq1KFwrTgKA0/v16Xy0
 ZsMOB5AgsKcgbxOBBpjmtzcLHWaSCDVT/sjBsC9f5DwwinheoQu+T6RZFJJqtCjS1Ys4
 Sbrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=leKoe1zxD0sTN0Fe2mL7153kT+YlstzCjcsiyCaDX84=;
 fh=9APC4TOqqeyK4f+hBMC/WhXBwI4zhfL25tS7yb/7n7s=;
 b=anQovTOwTue94nVockLrTKXf1Xb9l5Zx85bwYksvmZPx2waQWPLzEz88uwCjwhDthM
 WMLThdeRWu7tfUgkISM2qcp1or78LWK3N1kFk8OkGoOCbeiYMSbQt67hu8NbvyIcA8tQ
 RUPS/9brvlQLmQXXHN6s2adVuzGKiJrJAgWDwULtYe9V+0R2blubXTm297Oae2iM/5tR
 cV4Sq8x8xVUZ2nj/n/lXWuUgur+Nez2ZgSJrMoYND7N+948a1auKSHthE/OYBS0LHDej
 7RdquEQzOms4HgVPLOP8DC7qq76IIzB3LbSjx6Ke8r4lz4la10AJO4/DuaCSXPnX3asX
 +J1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1776093874; x=1776698674; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=leKoe1zxD0sTN0Fe2mL7153kT+YlstzCjcsiyCaDX84=;
 b=NcWFV2aSz6aBbi4xEqbwqmMqynYYWTE5F5VJcAB1Pl5Q9jS01l7/+taTCI10plIz5F
 lt/3NDODYVnXEMxB0tTiDW4CglXDrXxnL9dNSeKPn++BjB4/n32CRV/nqwVvF4UDWjsb
 7fOuzN4Rqz3DugBAIos49xq4xrbJtN1tn2QMvxc3ye1ThOHdUatpMviWf8h7ZcV5rtol
 E2BeDBtjd884qQWeqKyotfEvi58XgZThmDT3OWEeLdHDII9E3mT3QMBckGfnCpGHD9mx
 bsujQSp5hlpwKV/hRgMazN9rorJz9bSLcIer3EhV/6ihdNcdHzCz4pHFMidr3E30R7Po
 TSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776093874; x=1776698674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=leKoe1zxD0sTN0Fe2mL7153kT+YlstzCjcsiyCaDX84=;
 b=BHroH4NrSvPea5+kXhHygn9WSOUc/DdDYS2l5+JHFITSLDRrTEOBiSb1j0I+iUhtGb
 Ao9YKLi5Rzf2OVY/BCCI1ai+kQn6DccVK46Khir/DWGuXzVwXDiafooJUnuNvWsbclml
 IWG/hkxljzWjdmiD6tKTYSTGL8YAgDJQKcFjKbuXSyhHlZaLdHm07n3vE2w1dmOETBre
 OJ/avs/aYanKmiZ+9OYSAo0VhJMJmz4Fc7oRqePNKgTRh1KTTbWRvqjX4b5oz5AJdBnY
 193fqzWGw8/3z0VYz6yec7RiC4yR6XX79u4K4wIyUOXyEx1Gh09llOeWz33mJ472fgwn
 PchA==
X-Gm-Message-State: AOJu0YzLdY6gZWsHEG2iRCNNXiPms+FWkEYL1qP9L1l91n7FB71frDfL
 zvpObAfn49tovngcsrMUhGCkNGG4ELekaE3TmDkcECvm+HTnrur0s7DLLQe3eBFjAFpQYz8znyx
 +NLTvPnWbKONVqCtJ7oidVY3lcIMShL3EBwJ3R/WIYg==
X-Gm-Gg: AeBDiesNpNZ7boH7T1duFcyvnY08BXnAA7IsNgI4DGniM5waOgeiA4Y/8W+n6Wl2eXC
 63FbGEv+gViAZ9zcN29HQVtniD/iC3HN89GKYlnltRT5OY65mA+KAMetlatPCotGX9UIuG7zgjK
 0jrDCvGGkhTqXWEAZc48kDkvAGBn0/fs33uEr4Xm6/nf2oWlWWo3H8HQ1EDXWHlD0UyaPFRMzhD
 wpPM+e0z+pY5k6/u6XG16TRZ4kJfOvIxVknosZ+iJzr4kcEPHpbUIpONMWKOXSM/Ku/05k2/4YL
 Jp25D/7sXJHsDMAGEzpaS9qoiszHuEvw73TefVOBcLVdPOa5rPvw9BWTrFxkpo/TKHXU6eueBQ=
 =
X-Received: by 2002:a05:690c:6b01:b0:7b2:1bf1:7ff2 with SMTP id
 00721157ae682-7b21bf18391mr62871777b3.7.1776093874192; Mon, 13 Apr 2026
 08:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260409060155.94704-1-matthieu@min.io>
 <20260410143000.86708-1-matthieu@min.io>
 <CAPSO8Mx2pXp1UGvrsqTL86b=920os62MYSGn-ryv-YV4kRN4NA@mail.gmail.com>
 <20260410201401.GA501153@fedora>
In-Reply-To: <20260410201401.GA501153@fedora>
From: Matthieu Rolla <matthieu@minio.io>
Date: Mon, 13 Apr 2026 17:24:34 +0200
X-Gm-Features: AQROBzDd0FdWvsP_NpSC7SZQS7XNeh_o5B4KnBJarZdCuvymbhybyDKS5Y8xKKE
Message-ID: <CAPSO8MwiXZJ0z7N-uS5Vm3znRXUddWqNCe98Fg--4AumpLCDXA@mail.gmail.com>
Subject: Re: [PATCH v3] hw/nvme: add namespace hotplug support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, its@irrelevant.dk, 
 kbusch@kernel.org, mr-083 <matthieu@min.io>
Content-Type: multipart/alternative; boundary="0000000000007592f3064f5914ae"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=matthieu@minio.io; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000007592f3064f5914ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I tested further more the device_del + device_add and the AEN works
correctly, causing the guest to rescan namespaces.

However, when XFS filesystems are mounted on the namespace (via
DirectPV/CSI in our case), the kernel doesn't reuse the block device number
after re-add.

For example, nvme2n1 becomes nvme2n2 because the stale XFS mount holds a
reference to the old nvme_ns_head, preventing ida_free() in
nvme_free_ns_head() from releasing the instance number before the new
namespace is allocated.

This causes XFS "duplicate UUID" errors since the same filesystem appears
under a different device name while the old stale mount still exists.

This is a Linux kernel behavior (ida_alloc in nvme_alloc_ns_head), not a
QEMU issue. The namespace hotplug patch itself is correct. But for
practical use with mounted filesystems, I found that the drive_del +
drive_insert approach (keeping the namespace device alive) avoids the
rename entirely since no ida allocation/free cycle occurs.

Would it make sense to include drive_insert as a companion patch, or is
that better handled separately ?

Thanks

On Fri, Apr 10, 2026 at 10:14=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om>
wrote:

> On Fri, Apr 10, 2026 at 04:33:47PM +0200, Matthieu Rolla wrote:
> > Hello @Stefan Hajnoczi <stefanha@redhat.com> ,
> >
> >
> > Thanks for the review! v3 sent.
> >
> >
> > Wording: Fixed in v3, no more "physical PCIe slot" claim. Now describes
> it
> > as NVMe namespace-level hotplug.
> >
> >
> > I/O drain: Moved nvme_ns_drain() to the start of the unplug handler so
> > in-flight I/O completes before detach. Tested under warp load (16
> > concurrent 1MiB uploads via MinIO/DirectPV)  device_del returns in ~400=
ms
> > with clean removal, no use-after-free.
> >
> >
> > Symmetry:  moved subsys->namespaces[nsid] =3D NULL into nvme_ns_unreali=
ze()
> > so the namespace lifecycle is complete (mirrors what nvme_ns_realize()
> sets
> > up).
> >
> >
> > I don't have a working Windows test setup, I'd really appreciate if you
> > could test it next week as you offered.
> >
> > Thanks again for your time
>
> Awesome, thanks!
>
> I will give Windows Server a spin next week. I'm not an expert in
> hw/nvme/ but the patch looks good to me:
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>

--0000000000007592f3064f5914ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>I tested further more the device_del + devic=
e_add and the AEN works correctly, causing the guest to rescan namespaces.<=
br><br>However, when XFS filesystems are mounted on the namespace (via Dire=
ctPV/CSI in our case), the kernel doesn&#39;t reuse the block device number=
 after re-add. <br><br>For example, nvme2n1 becomes nvme2n2 because the sta=
le XFS mount holds a reference to the old nvme_ns_head, preventing ida_free=
() in nvme_free_ns_head() from releasing the instance number before the new=
 namespace is allocated.<br><br>This causes XFS &quot;duplicate UUID&quot; =
errors since the same filesystem appears under a different device name whil=
e the old stale mount still exists.<br><br>This is a Linux kernel behavior =
(ida_alloc in nvme_alloc_ns_head), not a QEMU issue. The namespace hotplug =
patch itself is correct. But for practical use with mounted filesystems, I =
found that the drive_del + drive_insert approach (keeping the namespace dev=
ice alive) avoids the rename entirely since no ida allocation/free cycle oc=
curs.<br><br>Would it make sense to include drive_insert as a companion pat=
ch, or is that better handled separately ?<br><br>Thanks</div><br><div clas=
s=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_att=
r">On Fri, Apr 10, 2026 at 10:14=E2=80=AFPM Stefan Hajnoczi &lt;<a href=3D"=
mailto:stefanha@redhat.com">stefanha@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">On Fri, Apr 10, 2026 at 04:3=
3:47PM +0200, Matthieu Rolla wrote:<br>
&gt; Hello @Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" targ=
et=3D"_blank">stefanha@redhat.com</a>&gt; ,<br>
&gt; <br>
&gt; <br>
&gt; Thanks for the review! v3 sent.<br>
&gt; <br>
&gt; <br>
&gt; Wording: Fixed in v3, no more &quot;physical PCIe slot&quot; claim. No=
w describes it<br>
&gt; as NVMe namespace-level hotplug.<br>
&gt; <br>
&gt; <br>
&gt; I/O drain: Moved nvme_ns_drain() to the start of the unplug handler so=
<br>
&gt; in-flight I/O completes before detach. Tested under warp load (16<br>
&gt; concurrent 1MiB uploads via MinIO/DirectPV)=C2=A0 device_del returns i=
n ~400ms<br>
&gt; with clean removal, no use-after-free.<br>
&gt; <br>
&gt; <br>
&gt; Symmetry:=C2=A0 moved subsys-&gt;namespaces[nsid] =3D NULL into nvme_n=
s_unrealize()<br>
&gt; so the namespace lifecycle is complete (mirrors what nvme_ns_realize()=
 sets<br>
&gt; up).<br>
&gt; <br>
&gt; <br>
&gt; I don&#39;t have a working Windows test setup, I&#39;d really apprecia=
te if you<br>
&gt; could test it next week as you offered.<br>
&gt; <br>
&gt; Thanks again for your time<br>
<br>
Awesome, thanks!<br>
<br>
I will give Windows Server a spin next week. I&#39;m not an expert in<br>
hw/nvme/ but the patch looks good to me:<br>
<br>
Reviewed-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" tar=
get=3D"_blank">stefanha@redhat.com</a>&gt;<br>
</blockquote></div>

--0000000000007592f3064f5914ae--

