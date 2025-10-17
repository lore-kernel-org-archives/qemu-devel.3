Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A79DCCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 16:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9n0l-0001CF-P3; Fri, 17 Oct 2025 12:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9n0j-0001Bg-Vc
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 12:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v9n0c-0006ZC-Nv
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 12:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760717327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3CZk/Z85oyKWZoXJhb88UKg3smC0UOmYOtpI0u2G7/U=;
 b=Vwvui/QVc7rD787okK2J5mgOw9JdhsDUobfyCnYabim7UvKRhUcWIg32XkXM2mJW+VdDkL
 Rd2D16Dy+W6VMCy7XiBdHaV24dG2B51R1LNVWLnZMOt5FJkK5j1u3QskHmhubsvLwsePtr
 pF3Oyz73Cjtddx5OrrLtIsebbZt4KU4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-Wsp9m5EiOSuU8aIC66eJiw-1; Fri, 17 Oct 2025 12:08:46 -0400
X-MC-Unique: Wsp9m5EiOSuU8aIC66eJiw-1
X-Mimecast-MFC-AGG-ID: Wsp9m5EiOSuU8aIC66eJiw_1760717326
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-88f7eff9d5fso798163285a.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 09:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760717326; x=1761322126;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3CZk/Z85oyKWZoXJhb88UKg3smC0UOmYOtpI0u2G7/U=;
 b=eu486ugl4A7YZ/YCuXDbHc4uY5PzF9LBjpSu0Xf5z0nNaVHjKW5jKwkdRDP5u4JdAo
 tKX61YH2XV6Nm6U7AX4BM4Nu1KC9fhYa+i3BfbH0zkh/HjXPsk1n58XfaD/T8jknxl3V
 3CRfdXGOHv/4yKdhOzt+lX8tkYDs0bKt/CwCxHnxkGZwiIqfuyOB8BJ/t1igeuFupZNr
 cgsOXYW4XQ1Jj5DqYizAsFnp+/lj/jGUlORlgRwvrpbxaKtRwUBEa2LaxWpYgCBk4OiW
 Fc9lICcBsXUKx1l6+3R6V3apFgryuBAxSBP0TvbcyWAPDMd/3enZOBZJQYCxdTGC3s8R
 3wyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmt+g85Oo4Ib/DH2VAhfLJoEZWCn+E2gAFjgh13gU4WcojDY3+jlkWQ1FT18vYljQbBQrFeUBaLKTR@nongnu.org
X-Gm-Message-State: AOJu0YwEC04mE8jHbSdfGdXyTmulpB2cyLlKEtuu7PL2q4IVV9M6eM53
 DmrJ85haRAiM/7ivgQOh1RFUOVTOtfdlnLcAhoAw//BAtF1vd60teuGaeZ9MbSNINcbtffhzs7F
 +brc/vgKgaFcoK2jfyXsxBPRezLUJAU+eJldQ/ebdEjqi0vsCacHJqmtS
X-Gm-Gg: ASbGncsj0bJs6JxhzqjnLVMRcSkMFliMe5CpPvwLqcfmV1udfLC4TCImfK3ZO88wjUd
 5/w8meuC2jwCkjbsQEVc4BJgmMLzsBghbhOjBTZPEfYU2OyCQpZb8Abb+f1yGxLUce3RLTqRrPL
 u9kwzsV4CT5gHKhUkq0b6g51nt8y1TFCy7ZAdkXMjymK1Pa72WBHxLQpSFFOD856T3byakK1g32
 HTFE+5zp5X/epSPKTb9KFrRqnywGSTCf6ANd1kkZD7ArnKKUkpvyshNLkvCqDWV0sPiY2Xsl21W
 LCxMlHY99KuRSTVPE7X4nky8nY+/n8tqrpSiVF1HTbuVHs5Stz/cvtcT8GvzrhnpkcA=
X-Received: by 2002:a05:622a:130c:b0:4e8:a9bf:9d2b with SMTP id
 d75a77b69052e-4e8a9bfa45fmr11969461cf.84.1760717325388; 
 Fri, 17 Oct 2025 09:08:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl85QDL/dRrE64/p7N8v72U5I/lfPW4e0+nQBydFtddU5hL9r7S4uBnFBhcpoW1IOUP7vpVA==
X-Received: by 2002:a05:622a:130c:b0:4e8:a9bf:9d2b with SMTP id
 d75a77b69052e-4e8a9bfa45fmr11968481cf.84.1760717324758; 
 Fri, 17 Oct 2025 09:08:44 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8aaf87ecdsm1356701cf.16.2025.10.17.09.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 09:08:44 -0700 (PDT)
Date: Fri, 17 Oct 2025 12:08:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 mst@redhat.com, jasowang@redhat.com, farosas@suse.de,
 sw@weilnetz.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org,
 michael.roth@amd.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v8 16/19] qapi: introduce backend-transfer migration
 parameter
Message-ID: <aPJqCqYF32-RKMbC@x1.local>
References: <aO_--QWDJO7iOhR4@x1.local>
 <8c575b3a-7d1f-446d-8f6d-4b2e4b851731@yandex-team.ru>
 <aPCtkB-GvFNuqlHn@redhat.com>
 <29aa1d66-9fa7-4e44-b0e3-2ca26e77accf@yandex-team.ru>
 <aPE8Oo5D3oesB7sV@x1.local> <aPE-vmyg1mLDO4pf@redhat.com>
 <aPFHl3VWV0pCmzd1@x1.local> <aPFOHjl5BoWEMqSL@redhat.com>
 <aPFVWi1pwxS8yGay@x1.local> <aPH557l6YnXT-3r8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPH557l6YnXT-3r8@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 17, 2025 at 09:10:38AM +0100, Daniel P. Berrangé wrote:
> On Thu, Oct 16, 2025 at 04:28:10PM -0400, Peter Xu wrote:
> > On Thu, Oct 16, 2025 at 08:57:18PM +0100, Daniel P. Berrangé wrote:
> > > Errm, machine types apply to devices, but this is about transferring
> > > backends which are outside the scope of machine types. 
> > 
> > Ah.. I didn't notice that net backends are not inherited by default from
> > qdev, hence not applicable to machine type properties.
> > 
> > Is it possible we enable it somehow, so that backends can have compat
> > properties similarly to frontends?
> 
> That is a technical limitation, but the problem here is bigger than
> just the lack of qdev. It is a conceptual one - where a device is
> implemented, its behaviour is determined exclusively by the QEMU
> code. There are some rare exceptions, like host PCI device assignment
> where functionality is partly in the host hardware, or external
> device backends where impl is offloaded to an external process, but
> most pure QEMU impls are able to be made always migratable and compat
> can be easily ensured long term via machine types props.
> 
> With backends, alot of behaviour is offloaded to either the host
> OS, or to external libraries or services. Certain narrow configs
> may be able to transfer state, but there will always be configs
> were state transfer is impossible. There can be no coarse rule
> that a backend is migratable or not - it will usually be highly
> dependent on the particular configuration choices of the backend
> in use.  Machine types props can't magically make all backend
> config scenarios migratable. We need to be able to interrogate
> backends at the time migration is required.

I believe we have similar things already, like USO, which relies on the
kernel feature set that QEMU runs on.  What we do right now, afaiu, is we
make it a per-device property ON/OFF.  Then when unknown remote information
is required, we make it ON/OFF/AUTO.  When it's AUTO, it may prefer ON and
probe the kernel, dynamically decide the value on realize.

I didn't check the code if it's explicitly done like that, but I think
that's doable at least when a backend relies on such remote information.

> 
> > If we go with a list of devices in the migration parameters, to me it'll
> > only be a way to workaround the missing of such capability of net backends.
> > Meanwhile, the admin will need to manage the list of devices even if the
> > admin doesn't really needed to, IMHO.
> 
> We shouldn't need to list devices in every scenario. We need to focus on
> the internal API design. We need to have suitable APIs exposed by backends
> to allow us to query migratability and process vmstate a mere property
> 'backend-transfer' is insufficient, whether set by QEMU code, or set by
> the mgmt app.
> 
> If we have proper APIs each device should be able to query whether its
> backend can be transferred, and so "do the right thing" if backend
> transfer is requested by migration. The ability to list devices in the
> migrate command is only needed to be able to exclude some backends if
> the purpose of migration is to change a backend

IIUC, it is a proposal of using exclude-list, which should in most cases be
empty.

Yes, I agree it's at least better than query all the devices and having
mgmt specify each backend to enable backend-transfer.

However IIUC it also means the query API will be internal, so that
migration will need to be able to query that from device.

Then we have similar issue on what happens if we migrate from a new QEMU to
an old QEMU, that new QEMU (when migration module queries TAP) reports
per-device ON, however it won't actually work because dest QEMU is OFF.
IOW, we're still missing the functionality that we leverage from machine
type properties..

Or if we make the query to be visible to QMP / mgmt, then it'll at least
need to be a include-list, not exclude-list.

Then, we're literally bypassing the machine type versioning mechanism,
offloading all these to mgmt.

It should work, which I agree. But it also means we're reinventing the
wheel of what machine type properties were designed for... because if we
expose all these caps on all devices (as long as mutable after device
realize), we do not need machine type properties anymore.  They're
fundamentally solving the same problem, IMHO, on providing a working value
for migration no matter what the dest QEMU binary is.

Thanks,

-- 
Peter Xu


