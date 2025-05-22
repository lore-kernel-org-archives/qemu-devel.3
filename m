Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02579C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 07:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI0PK-0000Hf-Bl; Thu, 22 May 2025 03:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uI0PH-0000GA-AL
 for qemu-devel@nongnu.org; Thu, 22 May 2025 03:31:59 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uI0PD-0007L9-6Q
 for qemu-devel@nongnu.org; Thu, 22 May 2025 03:31:59 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-601d10de7e1so6948685a12.1
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 00:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747899113; x=1748503913; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gf+h8kkA/3Jln/k6fX0GvPl69knnfjdIaTO1nziewp4=;
 b=GcUq5zMaOvBNT3ZJr0Gm0Vx04f09cHI5LIUmT+bjpfNIoargT316FAE+aJlGmOTzNz
 0JncY4nCfsHiG1JuisAxiTi2ZgoUVvSswhuLioE+PcH+OwI733NYbHYA+9SO2mUnt8/g
 m6Csc/Ltr2YV4pnwcuNKMLBQIRfCE+N8rGiPe5lVuNeLSmHmtskVGSFERkq+KhKHLxsS
 3wVkx523zomaSaG5+MOEmlUBnq59aZK0IrXk6hKquviLyhywVRBLB/LCIHbU6YQIYSqh
 Rph7ONuFCD9JNPtfho1rnKmqQpW1bsmYi0eUUrS2El32WBVNsy5UrQ1aIi6RKd10Yave
 se+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747899113; x=1748503913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gf+h8kkA/3Jln/k6fX0GvPl69knnfjdIaTO1nziewp4=;
 b=dE9xd5ElfI3gtZAU2p4P00x3pwUTHgTKpT0ruYCXgnpFGzkxlrSzosz6Qz7YhA0NSd
 ofb1v4T8D8s/e8Wc2vl5n5sn8YV85Ckx1shQEa9J+33maxpcDc8iFdNfSbcBWsArXWUN
 /T7bQzgnEBKxR8PC8QhZZ565Vwuo0EEy+vEmnacQF4lXqhixvKNlbXCMWC5mym780qQH
 N1QNN39yZH91BTNAzVyHL7lhQQ/UdVEFrOqtkjBeNkAxkQQ57G//j6KGBdD0TdnN5aFj
 /bwY5vr3hLiDZ84S4XYpgpTrM+kR0Hg7aniMNpp3Fcty1CHieAcbfBPRjQbkYJBwAg86
 iX+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXox+VRqd3+zM159GkU0JH+DQ8aIB77ou699aitzyLOKE1juieiX9xF51CwPF5MhVyqpM5OcSHS9GXK@nongnu.org
X-Gm-Message-State: AOJu0YwXNVRTmjYNbil7jrsyw/UOfo/R8J3IunvdM+ylkEQe2MEkF84g
 +IjYWrBV8SNXCRo+0qlUPFetTnflB++EGCF3a+YesVk/V/xiYJuCQFrKXyy8ro4EgAFehWNRNBH
 BCqrvhKhwcuAYSI8ZfhRZCZkYxMcw3kx1+LA8ScG+3g==
X-Gm-Gg: ASbGncuKfzxyu3s4J6ZIesz7Y0/9lTE7Q9PvNYwH5LebgF3FZv6zeE1fLgscwKiVcBh
 cqqEpiY90+R3mBWoFqSX/nGCE4lIKbOFVzqG+by6YNwyIXzRSNGfjmw/i5lwZQ94PGgfeic6bOJ
 JB90Y2cHErgZxNwzHmVSIJ00HiS98H4LGUyGzr/A==
X-Google-Smtp-Source: AGHT+IHiLNIG2oooJW+e/fLeZMXvUUKawGwy9sq6Y/SjyHYujJc5uO0C/CFAz5lSiTr5HVFQJDhNm+npFy7KNpE71P8=
X-Received: by 2002:a05:6402:2810:b0:5fd:ef5d:cfc4 with SMTP id
 4fb4d7f45d1cf-60119ce9672mr19729243a12.32.1747899113224; Thu, 22 May 2025
 00:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-13-alex.bennee@linaro.org>
 <4d300cca-3ac2-4072-a35c-0b6aef970b26@daynix.com>
 <87bjrl87p5.fsf@draig.linaro.org>
 <83945c43-bfb2-4469-90bd-e3a7c2ca5d89@daynix.com>
In-Reply-To: <83945c43-bfb2-4469-90bd-e3a7c2ca5d89@daynix.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 22 May 2025 10:31:26 +0300
X-Gm-Features: AX0GCFvWlyfqpBhjjS_JMNQlBSITFb3sCng89Y2w8AMfyAcq17mJGXV34At8igQ
Message-ID: <CAAjaMXZ8acKBSGHvcQOcOnzBDCjFU1SOjse7pHtHWxNeREc2gg@mail.gmail.com>
Subject: Re: [PATCH v3 12/20] virtio-gpu: fix hang under TCG when unmapping
 blob
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, May 22, 2025 at 10:03=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2025/05/22 15:45, Alex Benn=C3=A9e wrote:
> > Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> >
> >> On 2025/05/22 1:42, Alex Benn=C3=A9e wrote:
> >>> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> >>> This commit fixes an indefinite hang when using VIRTIO GPU blob
> >>> objects
> >>> under TCG in certain conditions.
> >>> The VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB VIRTIO command creates a
> >>> MemoryRegion and attaches it to an offset on a PCI BAR of the
> >>> VirtIOGPUdevice. The VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB command unmap=
s
> >>> it.
> >>> Because virglrenderer commands are not thread-safe they are only
> >>> called on the main context and QEMU performs the cleanup in three ste=
ps
> >>> to prevent a use-after-free scenario where the guest can access the
> >>> region after it=E2=80=99s unmapped:
> >>> 1. From the main context, the region=E2=80=99s field finish_unmapping=
 is
> >>> false
> >>>      by default, so it sets a variable cmd_suspended, increases the
> >>>      renderer_blocked variable, deletes the blob subregion, and unpar=
ents
> >>>      the blob subregion causing its reference count to decrement.
> >>> 2. From an RCU context, the MemoryView gets freed, the FlatView gets
> >>>      recalculated, the free callback of the blob region
> >>>      virtio_gpu_virgl_hostmem_region_free is called which sets the
> >>>      region=E2=80=99s field finish_unmapping to true, allowing the ma=
in thread
> >>>      context to finish replying to the command
> >>> 3. From the main context, the command is processed again, but this
> >>> time
> >>>      finish_unmapping is true, so virgl_renderer_resource_unmap can b=
e
> >>>      called and a response is sent to the guest.
> >>> It happens so that under TCG, if the guest has no timers configured
> >>> (and
> >>> thus no interrupt will cause the CPU to exit), the RCU thread does no=
t
> >>> have enough time to grab the locks and recalculate the FlatView.
> >>> That=E2=80=99s not a big problem in practice since most guests will a=
ssume a
> >>> response will happen later in time and go on to do different things,
> >>> potentially triggering interrupts and allowing the RCU context to run=
.
> >>> If the guest waits for the unmap command to complete though, it block=
s
> >>> indefinitely. Attaching to the QEMU monitor and force quitting the gu=
est
> >>> allows the cleanup to continue.
> >>> There's no reason why the FlatView recalculation can't occur right
> >>> away
> >>> when we delete the blob subregion, however. It does not, because when=
 we
> >>> create the subregion we set the object as its own parent:
> >>>       memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> >>> The extra reference is what prevents freeing the memory region
> >>> object in
> >>> the memory transaction of deleting the subregion.
> >>> This commit changes the owner object to the device, which removes
> >>> the
> >>> extra owner reference in the memory region and causes the MR to be
> >>> freed right away in the main context.
> >>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> >>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >>> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >>> Message-Id: <20250410122643.1747913-3-manos.pitsidianakis@linaro.org>
> >>> Cc: qemu-stable@nongnu.org
> >>> ---
> >>>    hw/display/virtio-gpu-virgl.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>> diff --git a/hw/display/virtio-gpu-virgl.c
> >>> b/hw/display/virtio-gpu-virgl.c
> >>> index 71a7500de9..8fbe4e70cc 100644
> >>> --- a/hw/display/virtio-gpu-virgl.c
> >>> +++ b/hw/display/virtio-gpu-virgl.c
> >>> @@ -112,7 +112,7 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
> >>>        vmr->g =3D g;
> >>>        mr =3D g_new0(MemoryRegion, 1);
> >>>    -    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size,
> >>> data);
> >>> +    memory_region_init_ram_ptr(mr, OBJECT(g), "blob", size, data);
> >>>        memory_region_add_subregion(&b->hostmem, offset, mr);
> >>>        memory_region_set_enabled(mr, true);
> >>>
> >>
> >> I suggest dropping this patch for now due to the reason I pointed out
> >> for the first version of this series.
> >
> > This fixes an actual bug - without it we get a hang.
> >
>
> I understand that but it also introduces a regression; "[PATCH v3 14/20]
> ui/gtk-gl-area: Remove extra draw call in refresh" is also a similar case=
.
>
> Ideally such a bug should be fixed without regression, but I understand
> it is sometimes difficult to do that and postponing the bug resolution
> until figuring out the correct way does not make sense.
>
> In such a case, a bug should be fixed minimizing the regression and the
> documentation of the regression should be left in the code.
>
> In particular, this patch can cause use-after-free whether TCG is used
> or not. Instead, I suggest to avoid freeing memory regions at all on
> TCG. It will surely leak memory, but won't result in use-after-free at
> least and the other accelerators will be unaffected.
>
> Regards,
> Akihiko Odaki

We tested this fix with ASAN and didn't see anything. Do you have a
test case in mind that can reproduce this use-after-free? It'd help
make a certain decision on whether to drop this patch or not. I'm not
doubting that this can cause a use-after-free by the way, it's just
that it is hypothetical only. If it causes a use-after-free for sure
we should definitely drop it.

> Instead, I suggest to avoid freeing memory regions at all on
> TCG. It will surely leak memory, but won't result in use-after-free at
> least and the other accelerators will be unaffected.

Leaking memory for blob objects is also not ideal, since they are
frequently allocated. It's memory-safe but the leak can accumulate
over time.

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

