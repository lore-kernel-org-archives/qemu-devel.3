Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00887CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmmi-000255-KS; Tue, 28 Oct 2025 12:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vDmme-00021D-Qi
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vDmmT-0005AS-N1
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761669755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HcalplgSeKV2OamP4TyiJ4HiFFDYwp/149LnsX9znYM=;
 b=Tool2MB0Gi2TuAD0jfV/6J+beNlFMSyN3XtaC6gN8bchIkGPW5wrJzNLi2KvQxPcSJo4Mr
 kyCDTdfp3tVxmDs3gTfmm6X4e4UmliQELuGOJtnDbzgl9d5MEQ46fZ9xjavXDCQJnhYGVe
 QXyqzLLEqmDgJj3ob1ADyYXjq8/m910=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-Z4mq2nzzOI-fVaCSR8jUvg-1; Tue, 28 Oct 2025 12:42:31 -0400
X-MC-Unique: Z4mq2nzzOI-fVaCSR8jUvg-1
X-Mimecast-MFC-AGG-ID: Z4mq2nzzOI-fVaCSR8jUvg_1761669751
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-86b8db0e70dso1621776d6.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761669751; x=1762274551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcalplgSeKV2OamP4TyiJ4HiFFDYwp/149LnsX9znYM=;
 b=MTBFAhS1AvxllRdO7oMiXjLkB/2GND25/ipdVn6kQpAWX9VDeNjakhmkYm5WpN/rYP
 hGIhXMG4oRzSu3ht3ibtVDuI0wUHK600xKt7XoYEbc29uEz5/+0ZC8p7i98TK+F8lZC8
 ACnMuiqSB/an7GkSAA88vNic/vkia6gB0htPiWLlZmmBjw28kMQMq/ClT0aQSJDLJZgO
 EyvoZw8BT+hqpR5kISfW00qbLJCd6fAhwrVHu0A4ZPHAFDaO6Rzsc1aj8EZALrr+Suip
 gWp3+WePDCv3mY2w/eHNUdBHjC/MEx4yRmYWfHP7J560qXbiRhAlo72qG4XvYcSguNb+
 CNqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjG1fg23IVjqgrrV7htKOhEkg0dYIsLuZedwV39PuzJ3ZN4YsJ5z5Rjbiv1m6rTRjtJz9T2bV0w4wa@nongnu.org
X-Gm-Message-State: AOJu0YyvugMeyeZVax6WScNPOfk1mygvVgBQ92Gn4rI9jdvs55svQnGT
 i3EmaDm6J4NvPHs2gyROzXI/vOVBjuCjbg5I12mHHBhAQkEU0j1sxN6Cn6E5CvvgrtWsuzqjRBU
 f2JKhZFpUoPegOkkIqTeDW35jegrq8Ytp7DJhDcHxqqgyL4wTojjU6K50
X-Gm-Gg: ASbGnctKWIuy8omcnEbTja09REdAwHm4EPqK/H0bU5hr9VXj/vnvHdbuwNzz7yEXnZr
 CyWsuWggMfluTZnQaoxy4Rsby0ktfA0pUbbIoba9P4Eoo7OLdNOmb/z3yhD5pH/2sNJ+Cf35weU
 lb8Di9mBB3urSVShxLkuejxlmEIvvHZU/lVJ+oNN5kZLpfjQlSPf4u9oSl1G0vyoKsRp2hZUKqT
 P4WRGnCsTZClwD2Ciu4vZn66mNkCvw6+uIZg2RUPaQFHpVGXWBk5kObUw11IBVn1trCetlw8BJv
 rREACy7l5B208raK6jvfis9vqVXu5aeOKb27OTnmWE9PBmTcoH83o9eikeMganhHQQY=
X-Received: by 2002:a05:6214:2b0d:b0:87f:fffb:b7af with SMTP id
 6a1803df08f44-87ffffbb8bfmr25708216d6.1.1761669751052; 
 Tue, 28 Oct 2025 09:42:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXU3HPigvmB86eqfGOkHEflqn5dtNAIh7YUF7tF7OTaBtF3FrQhoTvgyIwugql9U0Qgk8gPA==
X-Received: by 2002:a05:6214:2b0d:b0:87f:fffb:b7af with SMTP id
 6a1803df08f44-87ffffbb8bfmr25707916d6.1.1761669750492; 
 Tue, 28 Oct 2025 09:42:30 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87ffde9c5e9sm16890196d6.56.2025.10.28.09.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:42:29 -0700 (PDT)
Date: Tue, 28 Oct 2025 12:42:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: armenon@redhat.com, Markus Armbruster <armbru@redhat.com>,
 stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 berrange@redhat.com
Subject: Re: [PATCH v3 4/4] migration: vmsd errp handlers: return bool
Message-ID: <aQDydMVrkbL4Mamv@x1.local>
References: <20251025202649.1122420-1-vsementsov@yandex-team.ru>
 <20251025202649.1122420-5-vsementsov@yandex-team.ru>
 <87o6psocib.fsf@pond.sub.org>
 <9f5ba3d7-3103-4d2a-b50f-f8883a18c812@yandex-team.ru>
 <aP-eHzbAtvNp3N3d@armenon-kvm.bengluru.csb>
 <591eebe5-0445-4b16-8f2e-280602ab480b@yandex-team.ru>
 <aQDdRn8t0B8oE3gf@x1.local>
 <25bfee38-9119-4512-9288-08c46a59acdc@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25bfee38-9119-4512-9288-08c46a59acdc@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Oct 28, 2025 at 07:26:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 28.10.25 18:12, Peter Xu wrote:
> > On Mon, Oct 27, 2025 at 08:06:04PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Understand.. So we don't know, does any caller use this ENOMEM, or not. And want to save
> > > a chance for bulk conversion.
> > > 
> > > And blind bulk conversion of all -errno to simple true/false may break something, we
> > > don't know.
> > > 
> > > Reasonable. Thanks for the explanation.
> > 
> > Taking vmstate_load_state() as example: most of its callers should
> > ultimately route back to the top of vmstate_load_state() that migration
> > code invokes.
> > 
> > AFAIU, migration itself doesn't care much so far on the retval, but only
> > succeeded or not, plus the errp as a bonus.  There's one thing exception
> > that I remember but it was removed in commit fd037a656aca..  So now I
> > cannot find anything relies on that.
> > 
> > Here's a list of all current vmstate_load_state() callers:
> > 
> > *** hw/display/virtio-gpu.c:
> > virtio_gpu_load[1358]          ret = vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &err);
> > 
> > *** hw/pci/pci.c:
> > pci_device_load[943]           ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id,
> > 
> > *** hw/s390x/virtio-ccw.c:
> > virtio_ccw_load_config[1146]   ret = vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &local_err);
> > 
> > *** hw/scsi/spapr_vscsi.c:
> > vscsi_load_request[657]        rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1, &local_err);
> > 
> > Until here, it's invoked in a get() callback of VMStateInfo.  Ultimately,
> > it goes back to migration's vmstate_load_state() invokation.
> > 
> > *** hw/vfio/pci.c:
> > vfio_pci_load_config[2840]     ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1,
> > 
> > This is special as it's part of load_state().  However it's the same, it
> > routes back to vmstate_load() instead (where vmstate_load_state()
> > ultimately also routes there).  So looks safe too.
> > 
> > *** hw/virtio/virtio-mmio.c:
> > virtio_mmio_load_extra_state[630] ret = vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, &local_err);
> > 
> > *** hw/virtio/virtio-pci.c:
> > virtio_pci_load_extra_state[205] ret = vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, &local_err);
> > 
> > *** hw/virtio/virtio.c:
> > virtio_load[3394]              ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id, &local_err);
> > virtio_load[3402]              ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1, &local_err);
> > 
> > More get() users.  Same.
> > 
> > *** migration/cpr.c:
> > cpr_state_load[266]            ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1, errp);
> > 
> > This is special, ignoring retval but using error_abort.  New one, safe.
> > 
> > *** migration/savevm.c:
> > vmstate_load[978]              return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
> > qemu_loadvm_state_header[2885] ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
> > 
> > This is the migration core invokations.  Safe.
> > 
> > *** migration/vmstate-types.c:
> > get_tmp[562]                   ret = vmstate_load_state(f, vmsd, tmp, version_id, &local_err);
> > get_qtailq[670]                ret = vmstate_load_state(f, vmsd, elm, version_id, &local_err);
> > get_gtree[833]                 ret = vmstate_load_state(f, key_vmsd, key, version_id, &local_err);
> > get_gtree[840]                 ret = vmstate_load_state(f, val_vmsd, val, version_id, &local_err);
> > get_qlist[921]                 ret = vmstate_load_state(f, vmsd, elm, version_id, &local_err);
> > 
> > These are special get() for special VMSD fields.  Safe.
> > 
> > *** migration/vmstate.c:
> > vmstate_load_state[208]        ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
> > vmstate_load_state[212]        ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
> > vmstate_subsection_load[652]   ret = vmstate_load_state(f, sub_vmsd, opaque, version_id, errp);
> > 
> > Same migration core invokations. Safe.
> > 
> > *** tests/unit/test-vmstate.c:
> > load_vmstate_one[123]          ret = vmstate_load_state(f, desc, obj, version, &local_err);
> > test_load_v1[377]              ret = vmstate_load_state(loading, &vmstate_versioned, &obj, 1, &local_err);
> > test_load_v2[408]              ret = vmstate_load_state(loading, &vmstate_versioned, &obj, 2, &local_err);
> > test_load_noskip[512]          ret = vmstate_load_state(loading, &vmstate_skipping, &obj, 2, &local_err);
> > test_load_skip[541]            ret = vmstate_load_state(loading, &vmstate_skipping, &obj, 2, &local_err);
> > test_load_q[815]               ret = vmstate_load_state(fload, &vmstate_q, &tgt, 1, &local_err);
> > test_gtree_load_domain[1174]   ret = vmstate_load_state(fload, &vmstate_domain, dest_domain, 1,
> > test_gtree_load_iommu[1294]    ret = vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1, &local_err);
> > test_load_qlist[1434]          ret = vmstate_load_state(fload, &vmstate_container, dest_container, 1,
> > 
> > Test code only.  Safe.
> > 
> > *** ui/vdagent.c:
> > get_cbinfo[1013]               ret = vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0,
> > 
> > Yet another get().  Safe.
> > 
> > So.. even if I'm not sure if a bulk conversion could happen or not (the
> > get() users above would be very tricky because get() doesn't allow errp so
> > far.. unless we introduce that too), but other than that, afaict,
> > vmstate_load_state() callers do not yet care about retvals.
> > 
> 
> Uhh, great analysis! With it, we can proceed with my patch. And may be, just change return value of vmstate_load_state to bool? To avoid analyzing it again in future.

It'll be some more code churns.. so some more work for downstream
maintenances.  But yeah, I agree that should follow what we suggest to do
in qemu in general.

I also didn't check the save side.  I would expect to be similar, but worth
some double checks.

Thanks,

-- 
Peter Xu


