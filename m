Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52965C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 07:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJRvH-0001Jd-QN; Mon, 26 May 2025 03:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1uJRvG-0001JS-9M
 for qemu-devel@nongnu.org; Mon, 26 May 2025 03:06:58 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1uJRvD-0004fk-Mw
 for qemu-devel@nongnu.org; Mon, 26 May 2025 03:06:57 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-604e2a2f200so115793a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 00:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1748243213; x=1748848013;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t7NxLrH7LU/BhDKOSXXB/7Yi4gQXmqVqgThfJtIIiUA=;
 b=ZXZJIjmyHJuzakZAZnn1hKuoMJW6u7vWFAV23fGqdMS/9pm/4wtVeZrSTVj8ONpebZ
 hQtArS2Z/AKr7QqmQ6VyrsYH944pewomujky43k+i9XBPT6XKI6G1bDImWzgSJlLWmPO
 V1kRznCebdysWRCthpbdHnvOsdKwXfBfAxTIjlIPOX0N6kdWtNY88o//PtDV6orEHY0e
 Bjub2i3rwbgbQGOg/pzVZAM05q5EcnhI3VY/DMdmKwXiRiHbxCkE96u0LBTN/89sEtMN
 TP4qXQP0rNDvbQbjuG3qbTQ0td9R0IQLaq3pGQoDG3OTquAuYLSpOJlJ5AOSxk0oBvj4
 CpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748243213; x=1748848013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t7NxLrH7LU/BhDKOSXXB/7Yi4gQXmqVqgThfJtIIiUA=;
 b=uhsDJ0XJiZVRycFg4alMzAK0PxMv+O/vec7t94e3TNPooPCT91m9RBSEbRcu+EjoXL
 L1OHQcExxQzTPokNr6J7mI5x5Q322UZTbxdLUzxOHU6b0/Ziw+kyS2yKwYGUcBp9UZay
 mbNG/cE1OhTJ4onV9i/EAaeqfQAEBRejitW4Jy4OQXvqjEKgO3yRo25n3Ps6mLBmI2do
 hkFPIMSuhVydExlt6IML737HtR8uvVNwkp9ZKHnq8BHqiZDB2OduDcJ+gDyWpm4Gx2z/
 k74O5bmJYGMvVDJpFXZZSCu+bbwMH/4lOsrpVyYpqzJdnCw3GncHrhfZRGCvP0dChrIx
 XMCA==
X-Gm-Message-State: AOJu0YwvN4bk+4uJRoznOFrAa0rBNVV7WzJ1dnQ1OuiUWebYtMSPoevH
 27xHA7ArMMJx1swFCRuLXqbIolJFF/q2oYKjpB9X2OBK6gn8f70aiAos0ecGwV/vvy+jf2sdWuy
 ANXuqwEtTim5FwwIlP4ZQcWn97zTaOU68yiF0UG0+9w==
X-Gm-Gg: ASbGnct/l5n0aSNDFDQe5Y4r7TtS+Oim2f/WB7tS+vUaPMmAjH2OUc4jSKjYFJ+t5Rv
 AUXVaWmYLhwuDJvHQj5/OUm+IiEWXLAROwR7kOedfONeRemy7MsSbSmlI7t5kLQH5IDkZxPaEWf
 3Ep/zpZj9cpYwjV+iasV4wutNizrkyr3yC8MZDQ1o5feDOJzpKpDXjMum4taaFS2rGRQ==
X-Google-Smtp-Source: AGHT+IHaZdQjA3KNBmn1Okk0OjZGqn1r342Ug1xibJElP1HRQluPOkvnd8UIYok+JU+E71IWwzeTOtqa4RTFvkGO8Q8=
X-Received: by 2002:a05:6402:2713:b0:5f7:f55a:e5c8 with SMTP id
 4fb4d7f45d1cf-602da305242mr5032204a12.21.1748243212689; Mon, 26 May 2025
 00:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250522162521.000077d9@huawei.com>
In-Reply-To: <20250522162521.000077d9@huawei.com>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Mon, 26 May 2025 09:06:41 +0200
X-Gm-Features: AX0GCFtqydq5QUO6gTQjXAYdfj8SmXlOkDl7RGmbpAdxPBw8U2VjudWKAa88mgc
Message-ID: <CAGNS4TaUGyzi9gj8zvR252AP3hAvws_uYV+S-0rb0XO=emgajQ@mail.gmail.com>
Subject: Re: RFC: How to make max_bounce_buffer_size configurable for
 address_space_memory
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, linuxarm@huawei.com
Content-Type: multipart/alternative; boundary="000000000000ac76d60636049742"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=mnissler@rivosinc.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000ac76d60636049742
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

In previous conversations in the context of the bounce buffering changes I
did, we ended up turning my first straw-man proposal of a global parameter
into a per-device parameter, with the argument that devices are best
positioned to "know" how much concurrent DMA they will be performing. This
does not make much sense for the CXL case, because the bounce buffering
happens on the receiving end of the DMA operation if I understand
correctly. Of course, the memory side can't really know what size is
appropriate because the access patterns are controlled by the initiators.
In the previous line of thought, it would have to be the sum of the max
bounce buffer size across all devices?

Still, if you wanted to put a limit on the memory side of things, I reckon
in principle you could implement a max size parameter on the memory region,
supplied by whoever creates the I/O region (CXL in your case). Then, adjust
the size limit accounting logic to optionally use capacity from that.

Recall that the original motivation for putting a limit is to prevent
malicious guests from allocating unlimited bounce buffer memory and in the
extreme perform a denial-of-service attack against the host. So, thinking
outside the box, maybe there could be a way for the guest to donate its own
memory to be used for bounce buffering?

Anyhow, just some context/thoughts in case they are useful, I can't think
of a silver bullet. Perhaps it's time to give up and do the global
parameter after all...

Cheers,
Mattias

On Thu, May 22, 2025 at 5:25=E2=80=AFPM Jonathan Cameron <
Jonathan.Cameron@huawei.com> wrote:

> Hi All,
>
> This closely related to Mattias' work to resolve bounce buffer limitation=
s
> for
> PCI memory spaces.
>
> https://lore.kernel.org/qemu-devel/20240819135455.2957406-1-mnissler@rivo=
sinc.com/
>
> For CXL memory, due to the way interleave memory is emulated we end
> up with the same problem with concurrent virtio mappings into IOMEM but
> in this case they are in the address_space_memory.  In my tests
> virtio-blk tends to fail as a result.  Note whilst QEMU sees this as
> IOMEM, in the host it's just 'normal RAM' (be it with terrible performanc=
e
> :)
>
> Currently I'm carrying the hack (obviously I never checked how much
> space I actually needed as it's unlikely to be that much :)
>
> diff --git a/system/physmem.c b/system/physmem.c
> index
> e97de3ef65cf8105b030a44e7a481b1679f86b53..fd0848c1d5b982c3255a7c6c8c1f22b=
32c86b85a
> 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2787,6 +2787,7 @@ static void memory_map_init(void)
>      memory_region_init(system_memory, NULL, "system", UINT64_MAX);
>      address_space_init(&address_space_memory, system_memory, "memory");
>
> +    address_space_memory.max_bounce_buffer_size =3D 1024 * 1024 * 1024;
>      system_io =3D g_malloc(sizeof(*system_io));
>      memory_region_init_io(system_io, NULL, &unassigned_io_ops, NULL, "io=
",
>                            65536);
>
>
> Assuming people are amenable to making this configurable with a parameter
> like x-max-bounce-buffer-size (from Mattias' set) how would people like
> that to be configured?  The address_space_init() call is
> fairly early but I think we can modify the max_bounce_buffer_size later
> potentially directly from machine_set_mem() if the parameter is set.
>
> I'm also interested if anyone has another suggestion for how to solve thi=
s
> problem more generally.
>
> Thanks,
>
> Jonathan
>

--000000000000ac76d60636049742
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Jonathan,</div><div><br></div><div>In previous con=
versations in the context of the bounce buffering changes I did, we ended u=
p turning my first straw-man proposal of a global parameter into a per-devi=
ce parameter, with the argument that devices are best positioned to &quot;k=
now&quot; how much concurrent DMA they will be performing. This does not ma=
ke much sense for the CXL case, because the bounce buffering happens on the=
 receiving end of the DMA operation if I understand correctly. Of course, t=
he memory side can&#39;t really know what size is appropriate because the a=
ccess patterns are controlled by the initiators. In the previous line of th=
ought, it would have to be the sum of the max bounce buffer size across all=
 devices?</div><br><div>Still, if you wanted to put a limit on the memory s=
ide of things, I reckon in principle you could implement a max size paramet=
er on the memory region, supplied by whoever creates the I/O region (CXL in=
 your case). Then, adjust the size limit accounting logic to optionally use=
 capacity from that.</div><div><br></div><div>Recall that the original moti=
vation for putting a limit is to prevent malicious guests from allocating u=
nlimited bounce buffer memory and in the extreme perform a denial-of-servic=
e attack against the host. So, thinking outside the box, maybe there could =
be a way for the guest to donate its own memory to be used for bounce buffe=
ring? <br></div><div><br></div><div>Anyhow, just some context/thoughts in c=
ase they are useful, I can&#39;t think of a silver bullet. Perhaps it&#39;s=
 time to give up and do the global parameter after all...</div><div><br></d=
iv><div>Cheers,</div><div>Mattias</div></div><br><div class=3D"gmail_quote =
gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, May 22=
, 2025 at 5:25=E2=80=AFPM Jonathan Cameron &lt;<a href=3D"mailto:Jonathan.C=
ameron@huawei.com">Jonathan.Cameron@huawei.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">Hi All,<br>
<br>
This closely related to Mattias&#39; work to resolve bounce buffer limitati=
ons for<br>
PCI memory spaces.<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20240819135455.2957406-1-mnis=
sler@rivosinc.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kerne=
l.org/qemu-devel/20240819135455.2957406-1-mnissler@rivosinc.com/</a><br>
<br>
For CXL memory, due to the way interleave memory is emulated we end<br>
up with the same problem with concurrent virtio mappings into IOMEM but<br>
in this case they are in the address_space_memory.=C2=A0 In my tests<br>
virtio-blk tends to fail as a result.=C2=A0 Note whilst QEMU sees this as<b=
r>
IOMEM, in the host it&#39;s just &#39;normal RAM&#39; (be it with terrible =
performance :)<br>
<br>
Currently I&#39;m carrying the hack (obviously I never checked how much<br>
space I actually needed as it&#39;s unlikely to be that much :)<br>
<br>
diff --git a/system/physmem.c b/system/physmem.c<br>
index e97de3ef65cf8105b030a44e7a481b1679f86b53..fd0848c1d5b982c3255a7c6c8c1=
f22b32c86b85a 100644<br>
--- a/system/physmem.c<br>
+++ b/system/physmem.c<br>
@@ -2787,6 +2787,7 @@ static void memory_map_init(void)<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init(system_memory, NULL, &quot;system&qu=
ot;, UINT64_MAX);<br>
=C2=A0 =C2=A0 =C2=A0address_space_init(&amp;address_space_memory, system_me=
mory, &quot;memory&quot;);<br>
<br>
+=C2=A0 =C2=A0 address_space_memory.max_bounce_buffer_size =3D 1024 * 1024 =
* 1024;<br>
=C2=A0 =C2=A0 =C2=A0system_io =3D g_malloc(sizeof(*system_io));<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init_io(system_io, NULL, &amp;unassigned_=
io_ops, NULL, &quot;io&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A065536);<br>
<br>
<br>
Assuming people are amenable to making this configurable with a parameter<b=
r>
like x-max-bounce-buffer-size (from Mattias&#39; set) how would people like=
<br>
that to be configured?=C2=A0 The address_space_init() call is<br>
fairly early but I think we can modify the max_bounce_buffer_size later<br>
potentially directly from machine_set_mem() if the parameter is set.<br>
<br>
I&#39;m also interested if anyone has another suggestion for how to solve t=
his<br>
problem more generally.<br>
<br>
Thanks,<br>
<br>
Jonathan<br>
</blockquote></div>

--000000000000ac76d60636049742--

