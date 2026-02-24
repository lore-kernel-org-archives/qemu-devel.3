Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9938AF3C9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuv3b-0008CQ-97; Tue, 24 Feb 2026 11:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vuv3Q-0008BL-8k
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:14:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vuv3L-0004Aq-3g
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771949647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6sqZD2vdxCrLNXIIlwNiVUG7wmOMqkwMVvr8a527eUM=;
 b=fvI/B+kKdKWGUm67Dn8RIodcIWVr8DaCa7w69qMo59KxoC3ipTYQVm55d8Ia4a1dixGW0A
 hA/yCm+FUp+SYYtAKYG2GhW4Nmbp7zpU1l/OcT5/xiqMY6Em6T2M9AK2wbk6oiL5VRcjmo
 eyIlLxz8iZ8RykfB8iu1xoGqCh9nleY=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-qrbLPNYvPBKRBmmgkM1W7A-1; Tue, 24 Feb 2026 11:14:06 -0500
X-MC-Unique: qrbLPNYvPBKRBmmgkM1W7A-1
X-Mimecast-MFC-AGG-ID: qrbLPNYvPBKRBmmgkM1W7A_1771949645
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-948e77990c7so7827808241.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 08:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771949645; x=1772554445; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6sqZD2vdxCrLNXIIlwNiVUG7wmOMqkwMVvr8a527eUM=;
 b=jEofJ4AA7aQyCoYS/gaxBM+XRV/UP3LtSs7GN6z27eaP6Nyko2wTm5Nqvt3YKZfWzd
 OGpz8aALQ7VGWXUIAnZhgoZZwrQg04UAvKQPqsPX5ElH4kQuoHSgkCkAGAjHSVEGvNE8
 bYSKV9AVlqC8+uZmfKosOiK5BBvXgPkk7pPl4hEGuBc8GlF0tiRgM2H/iHHDgLF7L4yX
 FTkCc5jD+/TvsgMukomU8mG6jm/AMWFKou70Wgg/NpUSC/pV9MhsF/abZCQ1XSrzC2cd
 HDOdayCquXJzXv9NeWfUS3nKybAS7jgz6KTqziY0SU6i9EW/aiHWPY4JlmrukLOxJOmh
 gI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771949645; x=1772554445;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6sqZD2vdxCrLNXIIlwNiVUG7wmOMqkwMVvr8a527eUM=;
 b=rFZZbI9ObM2qwkv1Kb4Lcw1BjnyEy5+d5igNr3T6yuYWZxaNXL2BCHrcavbBnyRRfI
 poOXQmZLzdX7uhfMemXEPvHtg8Ui0guDXiytgTZR2SlYJ72GiR+1ULPDo44ug/+Evakl
 Vc2J+4blzTJom5Y3d9Egzp0PcCSZxCsE6PQStfHCKgHCyHrxNcli3B1cfFu3+3LqZUmT
 ADGRpXx1K6AsLM+HxWicdbdupcdJv86q3xegUbBcqU30rTg5P6RT2z/BOPUdPXngQEpB
 3JeY/WH+DsJJ769aR/MmgMwLlw5jtxdw2pH0VGbFbdDfV0xX23HOyv93TUdPRW63Jpc+
 8VZg==
X-Gm-Message-State: AOJu0YzK0IkgcB/LLgZ40ot7tGrx3ucQrII0KSFjIfHrVs19QGNzGWOg
 gTt6MUrkRZKvM3S4Qtr/0VspGp7TXvCErNojYbrbe4s6Bbh0LpIim68D8ZxW9ReY6BGJD7CMOv6
 /97F3gs3Xd1wRdlsWwefnU0iFTrxtf5IgmpQBe3FTW4Qr66WLhghnLZXA
X-Gm-Gg: ATEYQzy65LVBlOhQXM+8JCuuOjWQOkaLHgJd5DyDMDYWgtAOUOXo4s/1rqdujLFzhLH
 zzNHBEOQhByimWe4fkTob42KDNmcrqNVmuAWggrOv8QieRVKQTTyLdYP7nx/JZMhPtGOOX4TYQV
 OPUCW+EcDa7JgpwiUvksqurG1M1KmxAx3ZjHK8L0mSLGNhX7PwIultB8Rj/qncAJqFamUS7U/wP
 O2hn5nfROoIBpcax7q1ppxyRvO+l6PUR9JsWsuilsoC6mWjVB0oyRUxXAeFR+kbAqPSAXuOuo4t
 /XJ7TzJUPPauJ1hrk4oSfPldvyPbwaNxtJCpiS30gSfTIOsricVDwh9JZhC3/eLNnZtXYl9tw6r
 HtKJXFl+hTI4I1A==
X-Received: by 2002:a05:6122:1d53:b0:55f:c41f:e841 with SMTP id
 71dfb90a1353d-568e4904ef1mr4861999e0c.19.1771949645294; 
 Tue, 24 Feb 2026 08:14:05 -0800 (PST)
X-Received: by 2002:a05:6122:1d53:b0:55f:c41f:e841 with SMTP id
 71dfb90a1353d-568e4904ef1mr4861980e0c.19.1771949644674; 
 Tue, 24 Feb 2026 08:14:04 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-568e58080d6sm12768735e0c.9.2026.02.24.08.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 08:14:04 -0800 (PST)
Date: Tue, 24 Feb 2026 11:13:52 -0500
From: Peter Xu <peterx@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Subject: Re: [PATCH v1] vmstate: fix subsection load name check
Message-ID: <aZ3OQLHuYy0zEK76@x1.local>
References: <20260220102628.459681-1-dtalexundeer@yandex-team.ru>
 <aZyjaw8Pz-xvZ3AZ@x1.local>
 <f4e728fc-40a7-4c25-8681-ca64eb1657f2@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4e728fc-40a7-4c25-8681-ca64eb1657f2@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Feb 24, 2026 at 12:10:20PM +0500, Alexandr Moshkov wrote:
> 
> On 2/23/26 23:58, Peter Xu wrote:
> > On Fri, Feb 20, 2026 at 03:26:29PM +0500, Alexandr Moshkov wrote:
> > > When loading a subset, its name is checked for the parent prefix. The
> > > following bug may occur here:
> > > 
> > > Let's say there is a vmstate named "virtio-blk", it has a subsection
> > > named "virtio-blk/subsection", and it also has another vmstate named
> > > "virtio" in the fields.
> > > Then, during the migration, when trying to load this subsection for
> > > "virtio", the prefix condition will pass for "virtio-blk/subsection" and
> > > then the migration will break, because this vmstate does not have such a
> > > subsection.
> > > 
> > > In other words, if a field inside vmstate1 is set via vmstate2 with a
> > > name that is a prefix of the parent vmstate, then the field can "steal"
> > > a subsection belonging to the parent state.
> > > 
> > > Fix it by checking `/` at the end of idstr.
> > Checking versus '\' looks reasonable, however I'm still confused on the
> > example given, and what problem you hit.
> > 
> > Here, your concern seems to be that vmstate_subsection_load() can
> > accidentally load a FIELD of the parent VMSD whose name is exactly the name
> > of the parent VMSD (which will be the prefix of all subsections).
> 
> Thanks for reply,
> 
> vmstate_subsection_load() while trying to load a FIELD (whose name is prefix
> of parent name) of the parent VMSD will try to load parent subsection.
> 
> > 
> > Now my question is, when reaching the line you modified below, it needs to
> > be prefixed with QEMU_VM_SUBSECTION.  It means the src QEMU is dumping a
> > subsection rather than a field.  OTOH, when dumping a field, we never dump
> > any name; I don't think we name FIELD at all..
> > 
> > Could you share the failure you hit in real life?  That might help to
> > understand the problem on its own.
> 
> Here is code example:
> 
> ```
> 
> static const VMStateDescription vmstate_vhost_user_virtio_blk_inflight = {
> .name = "virtio-blk/inflight",
> .version_id = 2,
> .needed = vhost_user_blk_inflight_needed,
> .fields = (const VMStateField[]) {
> VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
> VMSTATE_END_OF_LIST()
> }
> };
> 
> 
> static const VMStateDescription vmstate_vhost_user_virtio_blk = {
> .name = "virtio-blk",
> .minimum_version_id = 2,
> .version_id = 2,
> .fields = (VMStateField[]) {
> VMSTATE_VIRTIO_DEVICE,
> VMSTATE_END_OF_LIST()
> },
> .subsections = (const VMStateDescription * []) {
> &vmstate_vhost_user_virtio_blk_inflight,
> NULL
> }
> };
> 
> ```
> 
> VMSTATE_VIRTIO_DEVICE is
> 
> ```
> 
> #define VMSTATE_VIRTIO_DEVICE \
> { \
> .name = "virtio", \
> .info = &virtio_vmstate_info, \
> .flags = VMS_SINGLE, \
> }
> ```
> So here is "virtio-blk" vmsd that have "virtio" vmsd field and
> "virtio-blk/inflight" subsection. This configuration will result in the fact
> that inflight vmsd will not be loaded at all (assuming that it met all the
> requirements). Qemu logs will contain trace_vmstate_subsection_load_bad
> (lookup) error for "virtio" vmstate when loading "virtio-blk/inflight"
> subsection.

Thanks for the details.  However it didn't resolve my confusion.  Let me
ask more explicitly.

In this case, VMSTATE_VIRTIO_DEVICE will be a single field in the parent
vmsd of "virtio-blk".  Meanwhile, "virtio-blk/inflight" will be the only
subsection.

Now, if you hit a LOOKUP error of trace_vmstate_subsection_load_bad(), it
means the dst QEMU hits this:

vmstate_subsection_load():
        sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
        if (sub_vmsd == NULL) {
            trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
            error_setg(errp, "VM subsection '%s' in '%s' does not exist",
                       idstr, vmsd->name);
            return -ENOENT;
        }

IIUC, when reaching here, the load of VMSTATE_VIRTIO_DEVICE should have
been completed, because we always load fields before subsections.

Meanwhile, when reaching here, "idstr" should be "virtio-blk/inflight",
because that's essentailly the only subsection this parent VMSD has.

vmstate_get_subsection() should try to lookup all subsections matching it,
and it should find it.

I do not yet get why the VMSTATE_VIRTIO_DEVICE can get involved in the
lookup (e.g. it is not on vmsd->subsections), and why it caused failure.

Could you help me to find where I missed?

Thanks,

-- 
Peter Xu


