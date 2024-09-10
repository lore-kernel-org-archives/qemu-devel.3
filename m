Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339EBEDE99A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 15:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so2qW-0007qC-Ui; Tue, 10 Sep 2024 11:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so2qV-0007k9-DI
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1so2qT-0007YT-Ub
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725982316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RsuH1VOGmNMtU05AFsSg0wYX3E5lFuAYaleeKgZJu0E=;
 b=SC92U8AZd6XgDdBwHvyPdRdOsPOvy/eO7xcbtEfD01dH/LrlPVBuPHffOBuWX/z2Vp3tIN
 wi6HRSmfc2XjKEuu2/ybR/wb+A9KUZhatAkI52yencPqvhSuD9V0YilexGDVQW5difypDV
 xhLiGsS6Yg9j9ycEcZU0HET2W3yIMJE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-B1rTo3THNWCWbKH7kZ1JlA-1; Tue, 10 Sep 2024 11:31:55 -0400
X-MC-Unique: B1rTo3THNWCWbKH7kZ1JlA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-374b981dd62so502010f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 08:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725982314; x=1726587114;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RsuH1VOGmNMtU05AFsSg0wYX3E5lFuAYaleeKgZJu0E=;
 b=jvoI1ul1g/dCw73jeCP4PaMW+kTx/4dPq0UoDhLUZr1FgpA6Ks7KPVS74RLcAwahub
 vyzUAn7t6xFkJoY34K5AObqpfD0qpajcoBvI1neCIjKfpTKV+QxE0PuQFGXzv9SZdPCk
 qT0gwe2He9MI/2XNarXJHFLBBvHpkvpUH8GWwU00R5Kv4vD0iqYFqDaZznJtJr5Us2cd
 6aTHl7lHYAMd+GVtYGaOwYfOQklQHc5y2F6TW39kuvRQtn4BUXvQB8Qz6CiFuzPMeimY
 Yu2yDlgMjz+XYbT8+REeSgmnb4Vxu0Qb+4f1OU4SpKCy532WCfz93/BgfLNxcIB41ive
 c1gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnHmCJXLNELwA+yX4hhlZc5P2mm1V2m2QqBIYQKy3Jqv8gf0Vv3PrwQ6wfOdMNlMYWDcqx++6rJfUs@nongnu.org
X-Gm-Message-State: AOJu0YzzhdzX0GXH1czd9gprB8QFBueJtdh1zuOJnd5CzFvbUTr0gl70
 sB5oHx03az8oI+1CVMZ9HaoyjRD205HAfobTI7MdJXAIHypyqDBRO4ANhhM7uwUiBXOv4Db6pge
 8u/JNQraNZ387LV5zy2Rw7tqNpvv5nGmWnyyO4jMV0OprhNhG/3L5
X-Received: by 2002:a5d:4309:0:b0:368:48e6:5056 with SMTP id
 ffacd0b85a97d-378b07a4f33mr41624f8f.22.1725982314103; 
 Tue, 10 Sep 2024 08:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+dqD2XgjKEXoJbvavR4fQPHUrPU6k1P9Xd6ObgjxPJnzW7OAjK45K9hwg8oQguRA9U8UG0w==
X-Received: by 2002:a5d:4309:0:b0:368:48e6:5056 with SMTP id
 ffacd0b85a97d-378b07a4f33mr41587f8f.22.1725982313432; 
 Tue, 10 Sep 2024 08:31:53 -0700 (PDT)
Received: from redhat.com ([31.187.78.63]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956dddacsm9155172f8f.107.2024.09.10.08.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 08:31:52 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:31:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH for-9.2] hw: add compat machines for 9.2
Message-ID: <20240910113131-mutt-send-email-mst@kernel.org>
References: <20240816103723.2325982-1-cohuck@redhat.com>
 <Zr8uNB8gaJTroMBU@redhat.com> <Ztn21z0ZR3_MiVQJ@redhat.com>
 <CAFEAcA9ToJuZwGkJr2gCRf63uJom0b0QpdVv-OrAVVUGwB_2wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9ToJuZwGkJr2gCRf63uJom0b0QpdVv-OrAVVUGwB_2wQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 05, 2024 at 08:05:14PM +0100, Peter Maydell wrote:
> On Thu, 5 Sept 2024 at 19:22, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Fri, Aug 16, 2024 at 11:47:16AM +0100, Daniel P. Berrangé wrote:
> > > On Fri, Aug 16, 2024 at 12:37:23PM +0200, Cornelia Huck wrote:
> > > > Add 9.2 machine types for arm/i440fx/m68k/q35/s390x/spapr.
> > > >
> > > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > > ---
> > > >  hw/arm/virt.c              |  9 ++++++++-
> > > >  hw/core/machine.c          |  3 +++
> > > >  hw/i386/pc.c               |  3 +++
> > > >  hw/i386/pc_piix.c          | 15 ++++++++++++---
> > > >  hw/i386/pc_q35.c           | 13 +++++++++++--
> > > >  hw/m68k/virt.c             |  9 ++++++++-
> > > >  hw/ppc/spapr.c             | 15 +++++++++++++--
> > > >  hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
> > > >  include/hw/boards.h        |  3 +++
> > > >  include/hw/i386/pc.h       |  3 +++
> > > >  10 files changed, 77 insertions(+), 10 deletions(-)
> > >
> > > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > >
> > >
> > > > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > > > index d9e69243b4a7..746bfe05d386 100644
> > > > --- a/hw/i386/pc_piix.c
> > > > +++ b/hw/i386/pc_piix.c
> > > > @@ -479,13 +479,24 @@ static void pc_i440fx_machine_options(MachineClass *m)
> > > >                                       "Use a different south bridge than PIIX3");
> > > >  }
> > > >
> > > > -static void pc_i440fx_machine_9_1_options(MachineClass *m)
> > > > +static void pc_i440fx_machine_9_2_options(MachineClass *m)
> > > >  {
> > > >      pc_i440fx_machine_options(m);
> > > >      m->alias = "pc";
> > > >      m->is_default = true;
> > > >  }
> > > >
> > > > +DEFINE_I440FX_MACHINE(9, 2);
> > > > +
> > > > +static void pc_i440fx_machine_9_1_options(MachineClass *m)
> > > > +{
> > > > +    pc_i440fx_machine_9_2_options(m);
> > > > +    m->alias = NULL;
> > > > +    m->is_default = false;
> > > > +    compat_props_add(m->compat_props, hw_compat_9_1, hw_compat_9_1_len);
> > > > +    compat_props_add(m->compat_props, pc_compat_9_1, pc_compat_9_1_len);
> > > > +}
> > > > +
> > > >  DEFINE_I440FX_MACHINE(9, 1);
> > > >
> > > >  static void pc_i440fx_machine_9_0_options(MachineClass *m)
> > > > @@ -493,8 +504,6 @@ static void pc_i440fx_machine_9_0_options(MachineClass *m)
> > > >      PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
> > > >
> > > >      pc_i440fx_machine_9_1_options(m);
> > > > -    m->alias = NULL;
> > > > -    m->is_default = false;
> > > >      m->smbios_memory_device_size = 16 * GiB;
> > >
> > > Feels like we should be adding an "_AS_LATEST" macro
> > > variant for piix/q35 too, so it matches the pattern
> > > in other targets for handling alias & is_default.
> > >
> > > Not a thing your patch needs todo though.
> >
> > I've just a patch that does that now. If it looks good & you want to include
> > it as a pre-requisite for your patch here feel free to grab, otherwise I can
> > rebase it after your patch merges.
> 
> I have this patch in my target-arm pullreq that's currently posted
> and pending merge, by the way.
> 
> -- PMM

Ok feel free to tack on

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>



