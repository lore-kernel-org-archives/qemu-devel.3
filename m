Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363B5C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 08:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZRLS-00015m-GX; Mon, 12 Feb 2024 03:07:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rZRLQ-00012q-O9
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:07:16 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rZRLO-00083G-N8
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:07:16 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-219122781a3so1984698fac.0
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 00:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707725233; x=1708330033;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l1NKKNGfyC9jhwfLNisdC89CBMRQ0NqRbOI9aEhnqPw=;
 b=f/veiHX4WKQ/qAreauUZi7Xp58RtQ9v2Ud7BsWMyQPynSbLO8H2OOrt4d4HW5K//Rd
 NPb1K10gvhHjqmO3kNB/PUQsYmD/+VP7hUvxuzO0eR/bLNeyznSQxlX151DVyaxKEHOQ
 aORobqJZtGKVnZodiClc2IuGSRxzm99fA2WIq30u0cuCZUSXNmEHuHxTeKfeJs3jj2Tv
 5F98jAjr27UMoRI12wNSx2Hcdvc5mxce6eAaUGdD3giXIgRlvGcMhgipiYlBeUHzr8gK
 s/mKvmo7UJfV2Fm81MvEZuljGyXEDNLmETTVicGthf5xZUfWX1f6WR8n3MnsGYocLGf2
 UzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707725233; x=1708330033;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l1NKKNGfyC9jhwfLNisdC89CBMRQ0NqRbOI9aEhnqPw=;
 b=VdzEjlp1Bew1elaiIzRvy4Md6N0IxYA4n7LgzaTLdds39czshmTjitgMlSnfXHfxHq
 0eyv8bpr7pJF0dOPSXDhvyBHHgY6qkzMquiFhV1Au223PiwJyN8M9MIxfxD9XMOKDcl2
 ShuBbddJEOabhcjOzKRTM4mwTWb/s4aKwIRM26AMa+U6scuXgg0tryxziVqIeDQaKF/d
 /56UCH7qGVY3nZ61/2SpK/86Qu1rOBcVSVps9iChJIdYXG+m8EB4v1gBEjUkdUOHDfCq
 YQGYlGR7/27oWYUaIDyGEzitOsCUd7jglgczdj13/feU+phIkX4J4NogpsOkJgqJaXxc
 cKUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/w7vDIHhAxgX8pAseBzK9puPSEk/1vhyiC+qpRG1lOVu9ZjR4cu9XdUuWBDrFumdCMQSQC9Ugc72qFat1JEX1dSss34k=
X-Gm-Message-State: AOJu0YygouDltytR1XzXIoSJ+Gg5MEHCZa8gFLF6mUPcCIX1p7r8N3B7
 g7yYOzO8XCgFlvaCscj4jliocLSwM8nIdYRk63H2o8RvcSsVvQ0ymqse3O8xBddTxlAa+6tKhab
 SJM+H7AcQdBhsshpFIyO+P2/LFnFQqs7ursJLIA==
X-Google-Smtp-Source: AGHT+IH/nMv2jVxXt3TwTCZArvk0XWn9UIKJn0x5ufsA+iTTqsoogBHJ2ROHUXaoxSj7LB2F8TgoKYu8dNitTstWe/E=
X-Received: by 2002:a05:6870:15d6:b0:21a:13e8:298c with SMTP id
 k22-20020a05687015d600b0021a13e8298cmr8189250oad.2.1707725233408; Mon, 12 Feb
 2024 00:07:13 -0800 (PST)
MIME-Version: 1.0
References: <20231101131611.775299-1-mnissler@rivosinc.com>
 <20240209173939.0000538f@huawei.com>
In-Reply-To: <20240209173939.0000538f@huawei.com>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Mon, 12 Feb 2024 09:07:02 +0100
Message-ID: <CAGNS4TajL4ambsT=SP9VZEM-k7Us4fj+gvfcEZYw0oVr9HVn4w@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Support message-based DMA in vfio-user server
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: stefanha@redhat.com, jag.raman@oracle.com, qemu-devel@nongnu.org, 
 peterx@redhat.com, john.levon@nutanix.com, 
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000e9622106112ac39f"
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=mnissler@rivosinc.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000e9622106112ac39f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

To the best of my knowledge, all patches in the series have been thoroughly
reviewed. Admittedly, I got a bit distracted with other things though, so
I've been dragging my feet on follow-through. Sorry about that.

I've just taken another look and found it no longer applies cleanly to
master due to a minor merge conflict. I've just sent a rebased version to
address that.

Stefan, are you OK to pick this up for merging at your next convenience?

Thanks,
Mattias



On Fri, Feb 9, 2024 at 6:39=E2=80=AFPM Jonathan Cameron <Jonathan.Cameron@h=
uawei.com>
wrote:

> On Wed,  1 Nov 2023 06:16:06 -0700
> Mattias Nissler <mnissler@rivosinc.com> wrote:
>
> > This series adds basic support for message-based DMA in qemu's vfio-use=
r
> > server. This is useful for cases where the client does not provide file
> > descriptors for accessing system memory via memory mappings. My
> motivating use
> > case is to hook up device models as PCIe endpoints to a hardware design=
.
> This
> > works by bridging the PCIe transaction layer to vfio-user, and the
> endpoint
> > does not access memory directly, but sends memory requests TLPs to the
> hardware
> > design in order to perform DMA.
> >
> > Note that more work is needed to make message-based DMA work well: qemu
> > currently breaks down DMA accesses into chunks of size 8 bytes at
> maximum, each
> > of which will be handled in a separate vfio-user DMA request message.
> This is
> > quite terrible for large DMA accesses, such as when nvme reads and writ=
es
> > page-sized blocks for example. Thus, I would like to improve qemu to be
> able to
> > perform larger accesses, at least for indirect memory regions. I have
> something
> > working locally, but since this will likely result in more involved
> surgery and
> > discussion, I am leaving this to be addressed in a separate patch.
> >
> Hi Mattias,
>
> I was wondering what the status of this patch set is - seems no
> outstanding issues
> have been raised?
>
> I'd run into a similar problem with multiple DMA mappings using the bounc=
e
> buffer
> when using the emulated CXL memory with virtio-blk-pci accessing it.
>
> In that particular case virtio-blk is using the "memory" address space, b=
ut
> otherwise your first 2 patches work for me as well so I'd definitely like
> to see those get merged!
>
> Thanks,
>
> Jonathan
>
> > Changes from v1:
> >
> > * Address Stefan's review comments. In particular, enforce an allocatio=
n
> limit
> >   and don't drop the map client callbacks given that map requests can
> fail when
> >   hitting size limits.
> >
> > * libvfio-user version bump now included in the series.
> >
> > * Tested as well on big-endian s390x. This uncovered another byte order
> issue
> >   in vfio-user server code that I've included a fix for.
> >
> > Changes from v2:
> >
> > * Add a preparatory patch to make bounce buffering an
> AddressSpace-specific
> >   concept.
> >
> > * The total buffer size limit parameter is now per AdressSpace and can =
be
> >   configured for PCIDevice via a property.
> >
> > * Store a magic value in first bytes of bounce buffer struct as a best
> effort
> >   measure to detect invalid pointers in address_space_unmap.
> >
> > Changes from v3:
> >
> > * libvfio-user now supports twin-socket mode which uses separate socket=
s
> for
> >   client->server and server->client commands, respectively. This
> addresses the
> >   concurrent command bug triggered by server->client DMA access
> commands. See
> >   https://github.com/nutanix/libvfio-user/issues/279 for details.
> >
> > * Add missing teardown code in do_address_space_destroy.
> >
> > * Fix bounce buffer size bookkeeping race condition.
> >
> > * Generate unmap notification callbacks unconditionally.
> >
> > * Some cosmetic fixes.
> >
> > Changes from v4:
> >
> > * Fix accidentally dropped memory_region_unref, control flow restored t=
o
> match
> >   previous code to simplify review.
> >
> > * Some cosmetic fixes.
> >
> > Changes from v5:
> >
> > * Unregister indirect memory region in libvfio-user dma_unregister
> callback.
> >
> > I believe all patches in the series have been reviewed appropriately, s=
o
> my
> > hope is that this will be the final iteration. Stefan, Peter, Jag,
> thanks for
> > your feedback, let me know if there's anything else needed from my side
> before
> > this can get merged.
> >
> > Mattias Nissler (5):
> >   softmmu: Per-AddressSpace bounce buffering
> >   softmmu: Support concurrent bounce buffers
> >   Update subprojects/libvfio-user
> >   vfio-user: Message-based DMA support
> >   vfio-user: Fix config space access byte order
> >
> >  hw/pci/pci.c                  |   8 ++
> >  hw/remote/trace-events        |   2 +
> >  hw/remote/vfio-user-obj.c     | 104 +++++++++++++++++++++----
> >  include/exec/cpu-common.h     |   2 -
> >  include/exec/memory.h         |  41 +++++++++-
> >  include/hw/pci/pci_device.h   |   3 +
> >  subprojects/libvfio-user.wrap |   2 +-
> >  system/dma-helpers.c          |   4 +-
> >  system/memory.c               |   8 ++
> >  system/physmem.c              | 141 ++++++++++++++++++----------------
> >  10 files changed, 226 insertions(+), 89 deletions(-)
> >
>
>

--000000000000e9622106112ac39f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Jonathan,</div><div><br></div><div>To the best of =
my knowledge, all patches in the series have been thoroughly reviewed. Admi=
ttedly, I got a bit distracted with other things though, so I&#39;ve been d=
ragging my feet on follow-through. Sorry about that.<br></div><div><br></di=
v><div>I&#39;ve just taken another look and found it no longer applies clea=
nly to master due to a minor merge conflict. I&#39;ve just sent a rebased v=
ersion to address that.</div><div><br></div><div>Stefan, are you OK to pick=
 this up for merging at your next convenience?</div><div><br></div><div>Tha=
nks,</div><div>Mattias<br></div><div><br></div><div><br></div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 9=
, 2024 at 6:39=E2=80=AFPM Jonathan Cameron &lt;<a href=3D"mailto:Jonathan.C=
ameron@huawei.com" target=3D"_blank">Jonathan.Cameron@huawei.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed,=C2=
=A0 1 Nov 2023 06:16:06 -0700<br>
Mattias Nissler &lt;<a href=3D"mailto:mnissler@rivosinc.com" target=3D"_bla=
nk">mnissler@rivosinc.com</a>&gt; wrote:<br>
<br>
&gt; This series adds basic support for message-based DMA in qemu&#39;s vfi=
o-user<br>
&gt; server. This is useful for cases where the client does not provide fil=
e<br>
&gt; descriptors for accessing system memory via memory mappings. My motiva=
ting use<br>
&gt; case is to hook up device models as PCIe endpoints to a hardware desig=
n. This<br>
&gt; works by bridging the PCIe transaction layer to vfio-user, and the end=
point<br>
&gt; does not access memory directly, but sends memory requests TLPs to the=
 hardware<br>
&gt; design in order to perform DMA.<br>
&gt; <br>
&gt; Note that more work is needed to make message-based DMA work well: qem=
u<br>
&gt; currently breaks down DMA accesses into chunks of size 8 bytes at maxi=
mum, each<br>
&gt; of which will be handled in a separate vfio-user DMA request message. =
This is<br>
&gt; quite terrible for large DMA accesses, such as when nvme reads and wri=
tes<br>
&gt; page-sized blocks for example. Thus, I would like to improve qemu to b=
e able to<br>
&gt; perform larger accesses, at least for indirect memory regions. I have =
something<br>
&gt; working locally, but since this will likely result in more involved su=
rgery and<br>
&gt; discussion, I am leaving this to be addressed in a separate patch.<br>
&gt; <br>
Hi Mattias,<br>
<br>
I was wondering what the status of this patch set is - seems no outstanding=
 issues<br>
have been raised?<br>
<br>
I&#39;d run into a similar problem with multiple DMA mappings using the bou=
nce buffer<br>
when using the emulated CXL memory with virtio-blk-pci accessing it.<br>
<br>
In that particular case virtio-blk is using the &quot;memory&quot; address =
space, but<br>
otherwise your first 2 patches work for me as well so I&#39;d definitely li=
ke<br>
to see those get merged!<br>
<br>
Thanks,<br>
<br>
Jonathan<br>
<br>
&gt; Changes from v1:<br>
&gt; <br>
&gt; * Address Stefan&#39;s review comments. In particular, enforce an allo=
cation limit<br>
&gt;=C2=A0 =C2=A0and don&#39;t drop the map client callbacks given that map=
 requests can fail when<br>
&gt;=C2=A0 =C2=A0hitting size limits.<br>
&gt; <br>
&gt; * libvfio-user version bump now included in the series.<br>
&gt; <br>
&gt; * Tested as well on big-endian s390x. This uncovered another byte orde=
r issue<br>
&gt;=C2=A0 =C2=A0in vfio-user server code that I&#39;ve included a fix for.=
<br>
&gt; <br>
&gt; Changes from v2:<br>
&gt; <br>
&gt; * Add a preparatory patch to make bounce buffering an AddressSpace-spe=
cific<br>
&gt;=C2=A0 =C2=A0concept.<br>
&gt; <br>
&gt; * The total buffer size limit parameter is now per AdressSpace and can=
 be<br>
&gt;=C2=A0 =C2=A0configured for PCIDevice via a property.<br>
&gt; <br>
&gt; * Store a magic value in first bytes of bounce buffer struct as a best=
 effort<br>
&gt;=C2=A0 =C2=A0measure to detect invalid pointers in address_space_unmap.=
<br>
&gt; <br>
&gt; Changes from v3:<br>
&gt; <br>
&gt; * libvfio-user now supports twin-socket mode which uses separate socke=
ts for<br>
&gt;=C2=A0 =C2=A0client-&gt;server and server-&gt;client commands, respecti=
vely. This addresses the<br>
&gt;=C2=A0 =C2=A0concurrent command bug triggered by server-&gt;client DMA =
access commands. See<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://github.com/nutanix/libvfio-user/issues/=
279" rel=3D"noreferrer" target=3D"_blank">https://github.com/nutanix/libvfi=
o-user/issues/279</a> for details.<br>
&gt; <br>
&gt; * Add missing teardown code in do_address_space_destroy.<br>
&gt; <br>
&gt; * Fix bounce buffer size bookkeeping race condition.<br>
&gt; <br>
&gt; * Generate unmap notification callbacks unconditionally.<br>
&gt; <br>
&gt; * Some cosmetic fixes.<br>
&gt; <br>
&gt; Changes from v4:<br>
&gt; <br>
&gt; * Fix accidentally dropped memory_region_unref, control flow restored =
to match<br>
&gt;=C2=A0 =C2=A0previous code to simplify review.<br>
&gt; <br>
&gt; * Some cosmetic fixes.<br>
&gt; <br>
&gt; Changes from v5:<br>
&gt; <br>
&gt; * Unregister indirect memory region in libvfio-user dma_unregister cal=
lback.<br>
&gt; <br>
&gt; I believe all patches in the series have been reviewed appropriately, =
so my<br>
&gt; hope is that this will be the final iteration. Stefan, Peter, Jag, tha=
nks for<br>
&gt; your feedback, let me know if there&#39;s anything else needed from my=
 side before<br>
&gt; this can get merged.<br>
&gt; <br>
&gt; Mattias Nissler (5):<br>
&gt;=C2=A0 =C2=A0softmmu: Per-AddressSpace bounce buffering<br>
&gt;=C2=A0 =C2=A0softmmu: Support concurrent bounce buffers<br>
&gt;=C2=A0 =C2=A0Update subprojects/libvfio-user<br>
&gt;=C2=A0 =C2=A0vfio-user: Message-based DMA support<br>
&gt;=C2=A0 =C2=A0vfio-user: Fix config space access byte order<br>
&gt; <br>
&gt;=C2=A0 hw/pci/pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A08 ++<br>
&gt;=C2=A0 hw/remote/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0=
2 +<br>
&gt;=C2=A0 hw/remote/vfio-user-obj.c=C2=A0 =C2=A0 =C2=A0| 104 +++++++++++++=
++++++++----<br>
&gt;=C2=A0 include/exec/cpu-common.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 -<b=
r>
&gt;=C2=A0 include/exec/memory.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4=
1 +++++++++-<br>
&gt;=C2=A0 include/hw/pci/pci_device.h=C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
&gt;=C2=A0 subprojects/libvfio-user.wrap |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 system/dma-helpers.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A04 +-<br>
&gt;=C2=A0 system/memory.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A08 ++<br>
&gt;=C2=A0 system/physmem.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 | 141 ++++++++++++++++++----------------<br>
&gt;=C2=A0 10 files changed, 226 insertions(+), 89 deletions(-)<br>
&gt; <br>
<br>
</blockquote></div>

--000000000000e9622106112ac39f--

