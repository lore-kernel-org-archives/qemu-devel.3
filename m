Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0982FD3779
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 17:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvIcC-0000fE-AG; Wed, 25 Feb 2026 12:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vvIc8-0000eF-MD
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:23:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vvIc6-0008Ma-9b
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:23:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772040233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1B85KZAR9rCu4YRD1DXGSOkXk7cWJfEyK4ulJJtX9Fc=;
 b=K7zV/SPCsC50G0Q1T8gAUZ39Zb/R9qmLu9nTzUs67sdgIxQvQJ5U16MnBnMB8Fm2PQMPDU
 RWFK0LCUJAK4JlzoHOPE3Nh2qUX9DuPi1Q8OsXaU44G6bnEXwY+XGLWTfL7FsUUF1PvEFU
 kYcItwb/DBOcNIPDqZl61diL9hdSAOE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-p6tJS40nNzGTo6_73kPt1Q-1; Wed, 25 Feb 2026 12:23:51 -0500
X-MC-Unique: p6tJS40nNzGTo6_73kPt1Q-1
X-Mimecast-MFC-AGG-ID: p6tJS40nNzGTo6_73kPt1Q_1772040231
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8c70ef98116so6075196685a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 09:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772040231; x=1772645031; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1B85KZAR9rCu4YRD1DXGSOkXk7cWJfEyK4ulJJtX9Fc=;
 b=NIbBvwpMsUGaotzVD2U6T7erVuKYB7nmxlLK38kqER2UTgFqwtw+3O1a8XrhxUdg7z
 AcqfkaJRKw8kOwQVdtcjogu4KcF1sZi7ZLDoYKRoa5kdgGIp8p84reiBcbJixB4j6U2m
 8jMXuxxX/Ae3iy+8VPtOopP5PkXh6UVbFra7OdW/3pUtYxT6Ff1pML6J/0CsHO6XtafG
 wGC8Jw4VA5hI+nkM3Cy1LWB66yn+eiHFex8eviwLfO9jOxTQu+nsGqYHzEnBhcKq/vCB
 ooQt4OnCJDEhJOz0pxM3TpL+9F2mhS7cf82nlSMx1agOUXW1ZUUoa9gDLNUysVV9b+46
 XpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772040231; x=1772645031;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1B85KZAR9rCu4YRD1DXGSOkXk7cWJfEyK4ulJJtX9Fc=;
 b=oiNidS7i1HvTOxPyO3+kIj0Ff1KiYDcGI5NOLf4eQbARfNst4caaRK5fQXfOaYWiXq
 hJSu1yzHy+5DEksJ/DYdJaIBdjq+XZhL/D5tflnSFq0oTDzmV3btHiIdPbPStk5H92q8
 6Ff42XK/SxgHYTyCkOSYee/9q5SFXS1F1XmoOw1OiSYp2/1s52BIXyRrLiZH6O4INiee
 gKB5hvYXMwtuY/2ntvqAa3puUp1WYcpUSsqCsHess3EwEYCwfNd3Mzq4UwxrZkEYkmJz
 atEH8p9lpftEv+TK43ac5rTON1iiHALC+fxV6sSfUvxhObOhSCQRyL5BR1eDgfelgB+n
 N2bA==
X-Gm-Message-State: AOJu0YzL7bS6aVfwOd+2f60dVkePqta6KJjSLJCghjItBx6Yvb/EFHgN
 vDlOZ87Cki3YzIF+CSBvhPJf2equoERLh3KQkcO1aHnDtCAJZ43J+3zPORptDzZnP2aHVLGAJE5
 t/P6aUPJ4JCk4MKYcccZHYzhxX6EiXn3krCU+ivyAq0DNjZqHYZHcLVgx
X-Gm-Gg: ATEYQzztvZQn2yH6mIt4OlMGweVJfzdhMam+bfWGWBLj8UkMNklSlfs3s75gjRvrMRC
 1eoafDNaq1rMBxCIc9ewGNyPXHdOlE0yOLHB5nAbV6Kc7NbS4TuUqZRYOkcDwucptXUEXV8pMFQ
 Y0KEO823PgRXIXRGnqjS96wbUCLJVvjLpDQ1PFW25ixL5ZFnPYS+Gzk0FYikYA5yr0txeHxIVlP
 mwQowVsdvs0eX5qZC58B8nZTYgzUOHi+inWIjCo7+EOvspbya/JvR6KCTHQ+EJbl19A+6e14jZ+
 F7Ixv6Khu3c5GGivkm7adXsmNp0l45UY32I63oWxuDXi/0KUV6c6X070otfrAm2LJU6tCPOH30y
 caw0mXQ/cuxQzqw==
X-Received: by 2002:a05:620a:19a4:b0:8cb:4ad6:6aa0 with SMTP id
 af79cd13be357-8cb8ca8dc10mr1999991485a.68.1772040231001; 
 Wed, 25 Feb 2026 09:23:51 -0800 (PST)
X-Received: by 2002:a05:620a:19a4:b0:8cb:4ad6:6aa0 with SMTP id
 af79cd13be357-8cb8ca8dc10mr1999984785a.68.1772040230196; 
 Wed, 25 Feb 2026 09:23:50 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb8d05c89asm1234172185a.16.2026.02.25.09.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 09:23:49 -0800 (PST)
Date: Wed, 25 Feb 2026 12:23:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Subject: Re: [PATCH v1] vmstate: fix subsection load name check
Message-ID: <aZ8wGsxhkD76LRBD@x1.local>
References: <20260220102628.459681-1-dtalexundeer@yandex-team.ru>
 <aZyjaw8Pz-xvZ3AZ@x1.local>
 <f4e728fc-40a7-4c25-8681-ca64eb1657f2@yandex-team.ru>
 <aZ3OQLHuYy0zEK76@x1.local>
 <819b9493-327b-4765-bbd9-c592cd3cfcdd@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <819b9493-327b-4765-bbd9-c592cd3cfcdd@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

On Wed, Feb 25, 2026 at 11:04:40AM +0500, Alexandr Moshkov wrote:
> 
> On 2/24/26 21:13, Peter Xu wrote:
> > On Tue, Feb 24, 2026 at 12:10:20PM +0500, Alexandr Moshkov wrote:
> > > On 2/23/26 23:58, Peter Xu wrote:
> > > > On Fri, Feb 20, 2026 at 03:26:29PM +0500, Alexandr Moshkov wrote:
> > > > > When loading a subset, its name is checked for the parent prefix. The
> > > > > following bug may occur here:
> > > > > 
> > > > > Let's say there is a vmstate named "virtio-blk", it has a subsection
> > > > > named "virtio-blk/subsection", and it also has another vmstate named
> > > > > "virtio" in the fields.
> > > > > Then, during the migration, when trying to load this subsection for
> > > > > "virtio", the prefix condition will pass for "virtio-blk/subsection" and
> > > > > then the migration will break, because this vmstate does not have such a
> > > > > subsection.
> > > > > 
> > > > > In other words, if a field inside vmstate1 is set via vmstate2 with a
> > > > > name that is a prefix of the parent vmstate, then the field can "steal"
> > > > > a subsection belonging to the parent state.
> > > > > 
> > > > > Fix it by checking `/` at the end of idstr.
> > > > Checking versus '\' looks reasonable, however I'm still confused on the
> > > > example given, and what problem you hit.
> > > > 
> > > > Here, your concern seems to be that vmstate_subsection_load() can
> > > > accidentally load a FIELD of the parent VMSD whose name is exactly the name
> > > > of the parent VMSD (which will be the prefix of all subsections).
> > > Thanks for reply,
> > > 
> > > vmstate_subsection_load() while trying to load a FIELD (whose name is prefix
> > > of parent name) of the parent VMSD will try to load parent subsection.
> > > 
> > > > Now my question is, when reaching the line you modified below, it needs to
> > > > be prefixed with QEMU_VM_SUBSECTION.  It means the src QEMU is dumping a
> > > > subsection rather than a field.  OTOH, when dumping a field, we never dump
> > > > any name; I don't think we name FIELD at all..
> > > > 
> > > > Could you share the failure you hit in real life?  That might help to
> > > > understand the problem on its own.
> > > Here is code example:
> > > 
> > > ```
> > > 
> > > static const VMStateDescription vmstate_vhost_user_virtio_blk_inflight = {
> > > .name = "virtio-blk/inflight",
> > > .version_id = 2,
> > > .needed = vhost_user_blk_inflight_needed,
> > > .fields = (const VMStateField[]) {
> > > VMSTATE_VHOST_INFLIGHT_REGION(inflight, VHostUserBlk),
> > > VMSTATE_END_OF_LIST()
> > > }
> > > };
> > > 
> > > 
> > > static const VMStateDescription vmstate_vhost_user_virtio_blk = {
> > > .name = "virtio-blk",
> > > .minimum_version_id = 2,
> > > .version_id = 2,
> > > .fields = (VMStateField[]) {
> > > VMSTATE_VIRTIO_DEVICE,
> > > VMSTATE_END_OF_LIST()
> > > },
> > > .subsections = (const VMStateDescription * []) {
> > > &vmstate_vhost_user_virtio_blk_inflight,
> > > NULL
> > > }
> > > };
> > > 
> > > ```
> > > 
> > > VMSTATE_VIRTIO_DEVICE is
> > > 
> > > ```
> > > 
> > > #define VMSTATE_VIRTIO_DEVICE \
> > > { \
> > > .name = "virtio", \
> > > .info = &virtio_vmstate_info, \
> > > .flags = VMS_SINGLE, \
> > > }
> > > ```
> > > So here is "virtio-blk" vmsd that have "virtio" vmsd field and
> > > "virtio-blk/inflight" subsection. This configuration will result in the fact
> > > that inflight vmsd will not be loaded at all (assuming that it met all the
> > > requirements). Qemu logs will contain trace_vmstate_subsection_load_bad
> > > (lookup) error for "virtio" vmstate when loading "virtio-blk/inflight"
> > > subsection.
> > Thanks for the details.  However it didn't resolve my confusion.  Let me
> > ask more explicitly.
> > 
> > In this case, VMSTATE_VIRTIO_DEVICE will be a single field in the parent
> > vmsd of "virtio-blk".  Meanwhile, "virtio-blk/inflight" will be the only
> > subsection.
> > 
> > Now, if you hit a LOOKUP error of trace_vmstate_subsection_load_bad(), it
> > means the dst QEMU hits this:
> > 
> > vmstate_subsection_load():
> >          sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
> >          if (sub_vmsd == NULL) {
> >              trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
> >              error_setg(errp, "VM subsection '%s' in '%s' does not exist",
> >                         idstr, vmsd->name);
> >              return -ENOENT;
> >          }
> 
> Yes, and it will return -ENOENT. This causes an error in upper function.
> Error in destination qemu logs will looks like this:
> 
> [... load virtio field ...]
> vmstate_subsection_load_bad virtio: virtio-blk/inflight/(lookup)

Yes, this implies vmstate_get_subsection() failure.

> qemu-system-x86_64: Failed to load virtio-blk:virtio

This implies the above failure happened in a nested load of
"virtio-blk:virtio", rather than the top "virtio-blk".

Here virtio_load invokes two vmstate_load_state on vdc->vmsd,
vmstate_virtio.

If the loader side was trying to lookup the "/inflight" subsection within
e.g. vmstate_virtio then it will fail indeed, but I don't understand why it
sees the "/inflight" subsection.  Can you help explain?

Are you using different versions of QEMU on src/dst when testing?  If
they're different (or with different patches applied), please spell them
out.

Or if you could help me to answer what is missing that I stated below it
might also help me to figure out what I missed.  So far I'm still a bit
lost and not yet understand why this patch helps..

Thanks,

> vmstate_load_field_error field "virtio" load failed, ret = -2
> qemu-system-x86_64: error while loading state for instance 0x0 of device
> '0000:80:03.0:00.0:00.0/virtio-blk'
> qemu-system-x86_64: load of migration failed: No such file or directory
> 
> > IIUC, when reaching here, the load of VMSTATE_VIRTIO_DEVICE should have
> > been completed, because we always load fields before subsections.
> > 
> > Meanwhile, when reaching here, "idstr" should be "virtio-blk/inflight",
> > because that's essentailly the only subsection this parent VMSD has.
> > 
> > vmstate_get_subsection() should try to lookup all subsections matching it,
> > and it should find it.
> > 
> > I do not yet get why the VMSTATE_VIRTIO_DEVICE can get involved in the
> > lookup (e.g. it is not on vmsd->subsections), and why it caused failure.
> > 
> > Could you help me to find where I missed?
> > 
> > Thanks,
> > 
> 

-- 
Peter Xu


