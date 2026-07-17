Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E12C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkf5v-0002Zj-JV; Fri, 17 Jul 2026 05:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkf5u-0002Z9-7n
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 05:42:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbassey@redhat.com>)
 id 1wkf5s-0002zs-AO
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 05:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784281375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bOzvVqBsArYSVwevHZ8RZuvbXPaXUp2YxTLZoet7hBI=;
 b=bxYIAJEXEpWhj55dIR+/qqJvPGDA9SsslN8x278AymeM3nrHTACZA0r08zmEhRg7k5suki
 3wR0uxYwYiNg69s7g2N6xB0u/yka0iaJgoNtPNRGGacz56NOmSVDoNdWX4RrMNk3jZf3cz
 aDNA+S5qA8RIdMfKbjyBGZpjJ3QA318=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-uETrdkXPO1ynaqI9iA8L9w-1; Fri, 17 Jul 2026 05:42:53 -0400
X-MC-Unique: uETrdkXPO1ynaqI9iA8L9w-1
X-Mimecast-MFC-AGG-ID: uETrdkXPO1ynaqI9iA8L9w_1784281373
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4a41f46d629so6328615b6e.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 02:42:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784281373; cv=none;
 d=google.com; s=arc-20260327;
 b=MeX0OXzwLo4bsjG8gx4e0LUfk/B2u4lACxmiyajLUCPRFWnTyBx/AV7S+jXIVDrIew
 FEWywRt7DP6F8z9GQX7vMLmVRQDg0N6zfzuwuy5KQJvyXKZxwoBXCepwBXdRvM9mOmZd
 RrP843cTtPm99ssPOpuW3Jq2LqUAJlx8lCU2VkTeAC1Pjfo7UUl2RnFnMAS8cr0HifYk
 CIyJTHDAeeJqHZCOkbXM4ZvhJp1kp7sPnh86XebykLSwszLj89aWY1iHLNo+z4G1Prf8
 d04+LaLAvzb/xjyX+BNVp2aM4CUcVZsNxnKA14jjdlJzLBv6cVOkGGFi021/ddIDUCTM
 MJGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bOzvVqBsArYSVwevHZ8RZuvbXPaXUp2YxTLZoet7hBI=;
 fh=R1VrqclvkLCnd3GYDD8ADqjObXIeANPJzeCYtIZN6kk=;
 b=ZUEH+uq5hlef6HgRL/sWxXMKL/R80IUgKUYlvAv+5JV2/YbHWbDQCFaPmBCnXwi80/
 T009YkcmkOxA8qAED8vCOYcEJUUpuM712obIqnR3PUtOJI/tL/c33fr8mrJLqMNkWGJ6
 EhkHlz63ToKjS/pd85j3VB8JuIuuSftVx53G7DoKT0KUhcom60dwpkoozdMLKMpENxWN
 /Y9Ndq3L9dRLTnUavCt5ZzIHzxb+DWBk9F2YuJii0zly78y2gu27ZToveHun10iH9ZgR
 U31yD0jR0LSkPZKS8PkuBLEtwNxXfsFDPRyyywj8nm3R2NAVq29RwRh6IgtYK11zLZue
 xCbA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784281373; x=1784886173; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bOzvVqBsArYSVwevHZ8RZuvbXPaXUp2YxTLZoet7hBI=;
 b=aHDDzkPLyJSq7g+rNddQtFs8Zh1kPUkq1RIKuX9YSTajD5kXW51PKf15jQPkKpeMcm
 0jlGYK1AbLAH8zu4H+3VWR7kIwgJNDCjV4WwqZ3OPau+RMHVyo487PON5zyA8FTdwA2h
 +eUOequPmKxE6nhsUR+HL+WfGcXxLc+bHaO0JuUKI4iMFzXbHtvYVmEediHQUmQXF6Ed
 i9IgwyDYoGQKXRt5UXa97SNzSFeIF3J0fu0TnhdQLGRPUM/asq9XAxS8Hg3m0zGxVnxc
 C0BJzbDQGexxpfEmgh4GvPWylQ5QIHmQLXznKQk6LAB/Uei1l051plAdWAl/IUu3Dbf+
 e/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784281373; x=1784886173;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bOzvVqBsArYSVwevHZ8RZuvbXPaXUp2YxTLZoet7hBI=;
 b=hegn2FFuNwza3XhmXptKxTsUbVJ+mC2HZBKv76vltWYiyMLvrdvtz+pLLkBSiUAf0Q
 14W4TberBYcOyE8o46BN8fbB2nKTCBstHRUdEU3uSary5u4Ep7pqaxadGMLCiM1JzqBc
 +GBv2/UhUm2RK2eFLuBv562kPUrqRNdYCHrp52lJQl0i3kcgJBj+u25P7k8pp7xUAlNl
 RwidePqWdVzlli0Hqn6WbNQS4ejyBF99D9mKiv6Sy5D/34rfQrVGDd0cn83xAHRJOW4O
 7ulYea+UywxQ6AFjDAZ1VQjj/yBXBexhUZpQjAhyLIs8dzviZ51gtzwI6WpTwUHHRUHD
 vQcg==
X-Gm-Message-State: AOJu0Yzo1JxiQJyeYF9XDAo2/0n0i+WSr+xaVhjxrzTJ5ryiR6H5x88b
 L8SM/79tKyR9BswXaEgpOGL2a2m6z/xZ59ogZV875upNPL1qOdXp7sNFoy1tW/OUnXoTmaxlbh+
 metCiZSSSMTG1/z51OgfwjTO2VnoD9+vOj8LpIhuHFcEzoYMoZ0LnWFpia1rFT8eT7zwnpSmeg4
 VEYiJLDqapP7ZaNfvcnBOvcRDePAnD54g=
X-Gm-Gg: AfdE7clop+n9rpuQBJIe99TLqi9C7YRYaOQS/gs0Ti8/837Ydq6O8sXOeoMl+v+OPWG
 M9QM1FFPyr0Hu3Yw1J8TYNZjt7KwZSbe4TKC3QjB2HdC1qjNBb3uJiu9SKiNIbtIgNe9XsDoPDq
 H80tB4AB2jQ+8r0d/yII31jYfzKFJLmAPXSJLBf3HhGJtbxs313U9Q7Sw=
X-Received: by 2002:a05:6808:181f:b0:496:9b2:d95d with SMTP id
 5614622812f47-4a4d0563b78mr724958b6e.30.1784281372666; 
 Fri, 17 Jul 2026 02:42:52 -0700 (PDT)
X-Received: by 2002:a05:6808:181f:b0:496:9b2:d95d with SMTP id
 5614622812f47-4a4d0563b78mr724943b6e.30.1784281372268; Fri, 17 Jul 2026
 02:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260716132359.96785-1-dbassey@redhat.com>
 <20260716132359.96785-3-dbassey@redhat.com>
 <CADSE00+o6Ut78pTUUBFRXtnF5+UEtj0Ckm20KSszCLTGuRZMyg@mail.gmail.com>
In-Reply-To: <CADSE00+o6Ut78pTUUBFRXtnF5+UEtj0Ckm20KSszCLTGuRZMyg@mail.gmail.com>
From: Dorinda Bassey <dbassey@redhat.com>
Date: Fri, 17 Jul 2026 11:42:41 +0200
X-Gm-Features: AUfX_myxqfrtl9361tbhwVapOUg2lZBA1bjs_MbYcl4QIv7Og_FVVvwoWA09biQ
Message-ID: <CACzuRyw12PQPOiUfXDvpDiLuHtoyryZN3XnQ3ZW3JFESiCtWYw@mail.gmail.com>
Subject: Re: [PATCH 2/3] vhost-user-gpu: Add shared memory region support
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, mhrica@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, manos.pitsidianakis@linaro.org, 
 marcandre.lureau@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Content-Type: multipart/alternative; boundary="000000000000601a260656cb6162"
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=dbassey@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000601a260656cb6162
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I used it now, Thanks!

On Fri, Jul 17, 2026 at 10:39=E2=80=AFAM Albert Esteve <aesteve@redhat.com>=
 wrote:

> On Thu, Jul 16, 2026 at 3:25=E2=80=AFPM Dorinda Bassey <dbassey@redhat.co=
m> wrote:
> >
> > From: Matej Hrica <mhrica@redhat.com>
> >
> > Add a 'hostmem' property to the vhost-user-gpu which enables the shared
> > memory in the parent object.
> >
> > Register a container MR in the shmem_list for SHMEM_MAP/UNMAP
> > operations. A container MR is used so that SHMEM_MAP FD-backed
> > subregions each get their own KVM memory slot with the correct
> > backing fd.
> >
> > Signed-off-by: Matej Hrica <mhrica@redhat.com>
> > Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> > ---
> >  hw/display/vhost-user-gpu.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> > index 06549c98e07..7e4580aa895 100644
> > --- a/hw/display/vhost-user-gpu.c
> > +++ b/hw/display/vhost-user-gpu.c
> > @@ -655,6 +655,21 @@ vhost_user_gpu_device_realize(DeviceState *qdev,
> Error **errp)
> >      }
> >
> >      g->vhost_gpu_fd =3D -1;
> > +
> > +    /*
> > +     * If shared memory is enabled, register the hostmem region for
> > +     * SHMEM_MAP/UNMAP operations.
> > +     */
> > +    if (virtio_gpu_hostmem_enabled(g->parent_obj.conf)) {
> > +        VirtioSharedMemory *shmem =3D g_new0(VirtioSharedMemory, 1);
> > +        shmem->shmid =3D VIRTIO_GPU_SHM_ID_HOST_VISIBLE;
> > +        memory_region_init(&shmem->mr, OBJECT(vdev),
> > +                           "vhost-user-gpu-shmem",
> > +                           g->parent_obj.conf.hostmem);
> > +        memory_region_add_subregion(&g->parent_obj.hostmem, 0,
> &shmem->mr);
> > +        QTAILQ_INIT(&shmem->mmaps);
> > +        QSIMPLEQ_INSERT_TAIL(&vdev->shmem_list, shmem, entry);
> > +    }
>
> Why not just use virtio_new_shmem_region()?
>
> >  }
> >
> >  static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
> > @@ -665,6 +680,7 @@ static struct vhost_dev
> *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
> >
> >  static const Property vhost_user_gpu_properties[] =3D {
> >      VIRTIO_GPU_BASE_PROPERTIES(VhostUserGPU, parent_obj.conf),
> > +    DEFINE_PROP_SIZE("hostmem", VhostUserGPU, parent_obj.conf.hostmem,
> 0),
> >  };
> >
> >  static void
> > --
> > 2.52.0
> >
>
>

--000000000000601a260656cb6162
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I used it now, Thanks!</div><br><div class=3D"gmail_quote =
gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 17=
, 2026 at 10:39=E2=80=AFAM Albert Esteve &lt;<a href=3D"mailto:aesteve@redh=
at.com">aesteve@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On Thu, Jul 16, 2026 at 3:25=E2=80=AFPM Dorinda B=
assey &lt;<a href=3D"mailto:dbassey@redhat.com" target=3D"_blank">dbassey@r=
edhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Matej Hrica &lt;<a href=3D"mailto:mhrica@redhat.com" target=3D"_=
blank">mhrica@redhat.com</a>&gt;<br>
&gt;<br>
&gt; Add a &#39;hostmem&#39; property to the vhost-user-gpu which enables t=
he shared<br>
&gt; memory in the parent object.<br>
&gt;<br>
&gt; Register a container MR in the shmem_list for SHMEM_MAP/UNMAP<br>
&gt; operations. A container MR is used so that SHMEM_MAP FD-backed<br>
&gt; subregions each get their own KVM memory slot with the correct<br>
&gt; backing fd.<br>
&gt;<br>
&gt; Signed-off-by: Matej Hrica &lt;<a href=3D"mailto:mhrica@redhat.com" ta=
rget=3D"_blank">mhrica@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Dorinda Bassey &lt;<a href=3D"mailto:dbassey@redhat.com=
" target=3D"_blank">dbassey@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 hw/display/vhost-user-gpu.c | 16 ++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 16 insertions(+)<br>
&gt;<br>
&gt; diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c=
<br>
&gt; index 06549c98e07..7e4580aa895 100644<br>
&gt; --- a/hw/display/vhost-user-gpu.c<br>
&gt; +++ b/hw/display/vhost-user-gpu.c<br>
&gt; @@ -655,6 +655,21 @@ vhost_user_gpu_device_realize(DeviceState *qdev, =
Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g-&gt;vhost_gpu_fd =3D -1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* If shared memory is enabled, register the hostm=
em region for<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* SHMEM_MAP/UNMAP operations.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (virtio_gpu_hostmem_enabled(g-&gt;parent_obj.conf)) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VirtioSharedMemory *shmem =3D g_new0(Virt=
ioSharedMemory, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 shmem-&gt;shmid =3D VIRTIO_GPU_SHM_ID_HOS=
T_VISIBLE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_init(&amp;shmem-&gt;mr, OBJ=
ECT(vdev),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;vhost-user-gpu-shmem&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0g-&gt;parent_obj.conf.hostmem);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_add_subregion(&amp;g-&gt;pa=
rent_obj.hostmem, 0, &amp;shmem-&gt;mr);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 QTAILQ_INIT(&amp;shmem-&gt;mmaps);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 QSIMPLEQ_INSERT_TAIL(&amp;vdev-&gt;shmem_=
list, shmem, entry);<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Why not just use virtio_new_shmem_region()?<br>
<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *=
vdev)<br>
&gt; @@ -665,6 +680,7 @@ static struct vhost_dev *vhost_user_gpu_get_vhost(=
VirtIODevice *vdev)<br>
&gt;<br>
&gt;=C2=A0 static const Property vhost_user_gpu_properties[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 VIRTIO_GPU_BASE_PROPERTIES(VhostUserGPU, parent_ob=
j.conf),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_SIZE(&quot;hostmem&quot;, VhostUserGPU, par=
ent_obj.conf.hostmem, 0),<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 static void<br>
&gt; --<br>
&gt; 2.52.0<br>
&gt;<br>
<br>
</blockquote></div>

--000000000000601a260656cb6162--


