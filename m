Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C64FC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 13:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp5YQ-0002gK-Ut; Mon, 03 Mar 2025 08:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tp5Y5-0002cZ-Ei
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 08:09:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tp5Y2-0004nZ-Vr
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 08:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741007367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+kPMvcSdcr4DG2bUPt1Uw2axZD7D5ZJ6c+OiWrTMDyI=;
 b=hvQl+jqIf82PiJqAbBKqH+mAogzpygw5YQQTX0YiyGGHaElOTzRQF6lFsYl9MvhP/e4wbs
 oE/d6X6xhYH6iPI029FOxOuhMZ2gQYyvnD66gsMeihs+USmh1I6ARNPu5ox4TZun+GV1ic
 ZsgfaZ9Jaqw5mhjCciPIZbxY4N/bOgY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-CpbArNVcMRS1Pw4dftgm1A-1; Mon, 03 Mar 2025 08:09:16 -0500
X-MC-Unique: CpbArNVcMRS1Pw4dftgm1A-1
X-Mimecast-MFC-AGG-ID: CpbArNVcMRS1Pw4dftgm1A_1741007355
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab397fff5a3so574747266b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 05:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741007355; x=1741612155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+kPMvcSdcr4DG2bUPt1Uw2axZD7D5ZJ6c+OiWrTMDyI=;
 b=bDofe6hCCofu2LQOS0r+CEFuGk+rYReShqHCVnIdkZqaLbXeH+Rpgy5o6mAA/GT9wt
 0eMDhweZmfOq5WYp+2UcipWOscKZAwhArMJ/aDwqeNqduXG4ACksZeQbUatXvy9Cbswu
 C+iZhLl4rJxEraG+kCqU6KHpMbUhAFALpkv5e2KjKge2LBDhv6Mq7cwN1AAGLNNkWViE
 V9QyUlrhiw5vLaKRJ44ngH5cE7xDXhWZ9/bo0JnBPN1NuhLvxtf6+ypK0INaEfAzKk8i
 eJpee5XHdYXckXztwRWO/90Jn4Nzfm4x5NO1XOQT/U+VeJAd+eukfef3fydHmWwLmDus
 OWXA==
X-Gm-Message-State: AOJu0Yx5LlB8OlzJ16rwpkZex2f5IjOWlg6X678h5LD4IR3MZvM5iV7E
 SKnU5XfQ8ArlmM1hcR7pYGhfeSA7ctKu9Cp0Mvwa27LO29YQ+SRI4h50MuTfQhzxdrPVLHfqER0
 0k61WR9xpPzRKvAkKC5+ssMlG1CoJB2Mvg4vyBF3jyJN5xULpuS+H
X-Gm-Gg: ASbGncsmNHIb6FMkD0WXEP3558BIDHEBBszA+IuiLs/ahsyipqVxcZXJdBLpJ4YYxLG
 oeSk5nhrsifjfLJOC/ghTPiq3or2CsXIHf+/O9x6NF0yRVe+wAM2RHxjkTspbLd9d/EuxnbYV5n
 f9isoeWafGrnye92PUeV0D6md4TlxTGN7Y/l30Kzqy+mgwctnS4/5JMVcfJHGGM1CIR3b+HoG6K
 3SbhPUIadfUZuRyjLvpCvQtA9SfSz7mkRPMWM2O06bc3pWeA9DSmOd66v97P9QnMZJ4lVQYD6fZ
 CNiZHFp5eK/YO/yDJN5VRXTx8e1QdvA5IUw4fEOaI7P/yhnBpWhSNyNrL0w4WSs=
X-Received: by 2002:a17:906:1d0c:b0:abf:767a:f9b with SMTP id
 a640c23a62f3a-abf767a13c5mr325850666b.6.1741007355179; 
 Mon, 03 Mar 2025 05:09:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+7uIxsGQmr/TlPe8SQd5EKi+rlLaFI6810XKe3lqwy/X72528D789YbDpvyIR7S66zmOSoA==
X-Received: by 2002:a17:906:1d0c:b0:abf:767a:f9b with SMTP id
 a640c23a62f3a-abf767a13c5mr325848266b.6.1741007354776; 
 Mon, 03 Mar 2025 05:09:14 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf64165f73sm339594866b.152.2025.03.03.05.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 05:09:14 -0800 (PST)
Date: Mon, 3 Mar 2025 14:09:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Alex =?UTF-8?B?QmVubsOpZQ==?=
 <alex.bennee@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 08/10] cpus: expose only realized vCPUs to global
 &cpus_queue
Message-ID: <20250303140913.364af986@imammedo.users.ipa.redhat.com>
In-Reply-To: <96b40129-072e-46c3-87c5-dd6a51dca1d6@linaro.org>
References: <20250207162048.1890669-1-imammedo@redhat.com>
 <20250207162048.1890669-9-imammedo@redhat.com>
 <96b40129-072e-46c3-87c5-dd6a51dca1d6@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 26 Feb 2025 08:16:52 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> On 7/2/25 17:20, Igor Mammedov wrote:
> > cpu_list_add() was doing 2 distinct things:
> > - assign some index to vCPU
> > - add unrealized (thus in inconsistent state) vCPU to &cpus_queue
> >=20
> > Code using CPU_FOREACH() macro would iterate over possibly
> > unrealized vCPUs, often dealt with special casing.
> >=20
> > Instead of working around of vCPU existence in cpus_queue,
> > split out cpu_index assignment from cpu_list_add(), =20
>=20
> Better split 2 distinct changes in 2 patches for clarity.


Will do it later, once folks decide how to fix broken TCG reset path.

do you mean:
 #1 - introduce  cpu_auto_assign_cpu_index()
 #2 - move cpu_list_add() to later stage but keep cpu_auto_assign_cpu_index=
()
      where it's now?


>=20
> > and move the later to the end of realize stage,
> > right before vCPU is let run.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > CC: Yanan Wang <wangyanan55@huawei.com>
> > CC: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   include/hw/core/cpu.h |  6 ++++++
> >   cpu-common.c          | 23 ++++++++++++++---------
> >   cpu-target.c          |  2 +-
> >   hw/core/cpu-common.c  |  2 ++
> >   4 files changed, 23 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index fb397cdfc5..c338fd31bd 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -750,6 +750,12 @@ bool cpu_virtio_is_big_endian(CPUState *cpu);
> >  =20
> >   #endif /* CONFIG_USER_ONLY */
> >  =20
> > +/**
> > + * cpu_auto_assign_cpu_index:
> > + * @cpu: The CPU to be assigned a cpu_index
> > + */
> > +void cpu_auto_assign_cpu_index(CPUState *cpu);
> > +
> >   /**
> >    * cpu_list_add:
> >    * @cpu: The CPU to be added to the list of CPUs.
> > diff --git a/cpu-common.c b/cpu-common.c
> > index 4248b2d727..92f3d00e56 100644
> > --- a/cpu-common.c
> > +++ b/cpu-common.c
> > @@ -71,15 +71,7 @@ int cpu_get_free_index(void)
> >       return max_cpu_index;
> >   }
> >  =20
> > -CPUTailQ cpus_queue =3D QTAILQ_HEAD_INITIALIZER(cpus_queue);
> > -static unsigned int cpu_list_generation_id;
> > -
> > -unsigned int cpu_list_generation_id_get(void)
> > -{
> > -    return cpu_list_generation_id;
> > -}
> > -
> > -void cpu_list_add(CPUState *cpu)
> > +void cpu_auto_assign_cpu_index(CPUState *cpu)
> >   {
> >       static bool cpu_index_auto_assigned;
> >  =20
> > @@ -91,6 +83,19 @@ void cpu_list_add(CPUState *cpu)
> >       } else {
> >           assert(!cpu_index_auto_assigned);
> >       }
> > +}
> > +
> > +CPUTailQ cpus_queue =3D QTAILQ_HEAD_INITIALIZER(cpus_queue);
> > +static unsigned int cpu_list_generation_id;
> > +
> > +unsigned int cpu_list_generation_id_get(void)
> > +{
> > +    return cpu_list_generation_id;
> > +}
> > +
> > +void cpu_list_add(CPUState *cpu)
> > +{
> > +    QEMU_LOCK_GUARD(&qemu_cpu_list_lock);
> >       QTAILQ_INSERT_TAIL_RCU(&cpus_queue, cpu, node);
> >       cpu_list_generation_id++;
> >   }
> > diff --git a/cpu-target.c b/cpu-target.c
> > index 667688332c..0c86c18a50 100644
> > --- a/cpu-target.c
> > +++ b/cpu-target.c
> > @@ -142,7 +142,7 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
> >       }
> >  =20
> >       /* Wait until cpu initialization complete before exposing cpu. */
> > -    cpu_list_add(cpu);
> > +    cpu_auto_assign_cpu_index(cpu);
> >  =20
> >   #ifdef CONFIG_USER_ONLY
> >       assert(qdev_get_vmsd(DEVICE(cpu)) =3D=3D NULL ||
> > diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> > index cb79566cc5..c29737e5e3 100644
> > --- a/hw/core/cpu-common.c
> > +++ b/hw/core/cpu-common.c
> > @@ -211,6 +211,8 @@ static void cpu_common_realizefn(DeviceState *dev, =
Error **errp)
> >           }
> >       }
> >  =20
> > +    cpu_list_add(cpu);
> > +
> >       if (dev->hotplugged) {
> >           cpu_synchronize_post_init(cpu);
> >           cpu_resume(cpu); =20
>=20


