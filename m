Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A956FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 14:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXMAl-0005Pz-IT; Fri, 26 Jul 2024 10:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sXMAi-0005PA-00
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 10:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sXMAg-0002ya-0u
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 10:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722005028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/Bl0ChjTZe0cGE0iHSDzWaLO1Ced74wjBR5iLfTTSQ=;
 b=jMduf6Bx6O1h/lL3BiaL0HofC15ABmLsD5TR7aO9UjPqBnq+slKvyb0T9E2HDp+wumvyAv
 5xD5aQy7cFGLrL5ykuyIF1FCrGXX/QyH6vXVonq6EPE5A5VzdMwsbSNPjnCK5EcuXawkTr
 toMj1YhbFJ1HuAwjXD5/lN6+OHQrcxw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-yo6LlgvxO3-ZXELb5wvYdw-1; Fri, 26 Jul 2024 10:43:47 -0400
X-MC-Unique: yo6LlgvxO3-ZXELb5wvYdw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-44fee12c33bso1228401cf.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 07:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722005026; x=1722609826;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9/Bl0ChjTZe0cGE0iHSDzWaLO1Ced74wjBR5iLfTTSQ=;
 b=ObwUzK0JZZuC/UBthJChLob5RcBQeMBl7rXigkrXLIt7nCiFISErDxYPmr4l7rurzR
 xQXShPoye867gxRSeAo4s0SAtATV86AixnP12KQBk5QoBIQjCv8SAHlOMmx0oIwCaQej
 ru/ZIdP3n1OLOEWa0l9Vh7UC2W/1ayIc5YHSaa8tg4iUfAf1/S3mrv+IXcRD4Yz3f1xn
 QtvoMz8ZS3uzWlUtfzIvlXmkUTalwf2tpzaGZdnB1BrPiJMdgohlY0CZRqXhjLvBj0AC
 YykMgIJ9pCvDVZRjT6ySGbKakDDBIMGkLBPBkrMGp+K3mUDfqKm2naybHtxH0SIJRftx
 EA8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVguzZHirHNjy0CXzLV945mkLSD6+fdW8pAcPq+wveg02vEvU19rtWK9DwD3bXylOPEcULv8wpzYcNj@nongnu.org
X-Gm-Message-State: AOJu0YzQsDMF6m1hfqFveeKkpfcN2kVkhKCYRDNFlOL7dUHjA5otWYa6
 SS/wfSMjO/SZGid/SDgK6dZGHIF/9GEBxvdOKxvmZs66LKWv9qsjw/ckSOvdfljh2KfuPmOzRnZ
 KWZZyEtC+6I0bCgDOW1hwLJxt9rzZNpawMnjLIERFFO2n6fvb5vtz
X-Received: by 2002:a05:622a:1903:b0:44f:89e3:e8d0 with SMTP id
 d75a77b69052e-44fe5b703e0mr37442771cf.10.1722005026657; 
 Fri, 26 Jul 2024 07:43:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMY72Dyx4jLp+DiG0our8IZAuybUwQbre/pnTTjeu75WIsCEgNbVm6pvxacTBnv3Fk3FrNzQ==
X-Received: by 2002:a05:622a:1903:b0:44f:89e3:e8d0 with SMTP id
 d75a77b69052e-44fe5b703e0mr37442561cf.10.1722005026166; 
 Fri, 26 Jul 2024 07:43:46 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44fe840e8eesm14117331cf.85.2024.07.26.07.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 07:43:45 -0700 (PDT)
Date: Fri, 26 Jul 2024 10:43:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <ZqO2HvFJ8v7hZFOd@x1n>
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com>
 <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqNiwmy29dxdyMA0@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 26, 2024 at 09:48:02AM +0100, Daniel P. Berrangé wrote:
> On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wrote:
> > On 26/07/2024 08.08, Michael S. Tsirkin wrote:
> > > On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
> > > > On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
> > > > > USO features of virtio-net device depend on kernel ability
> > > > > to support them, for backward compatibility by default the
> > > > > features are disabled on 8.0 and earlier.
> > > > > 
> > > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > > > Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
> > > > 
> > > > Looks like this patch broke migration when the VM starts on a host that has
> > > > USO supported, to another host that doesn't..
> > > 
> > > This was always the case with all offloads. The answer at the moment is,
> > > don't do this.
> > 
> > May I ask for my understanding:
> > "don't do this" = don't automatically enable/disable virtio features in QEMU
> > depending on host kernel features, or "don't do this" = don't try to migrate
> > between machines that have different host kernel features?
> > 
> > > Long term, we need to start exposing management APIs
> > > to discover this, and management has to disable unsupported features.
> > 
> > Ack, this likely needs some treatments from the libvirt side, too.
> 
> When QEMU automatically toggles machine type featuers based on host
> kernel, relying on libvirt to then disable them again is impractical,
> as we cannot assume that the libvirt people are using knows about
> newly introduced features. Even if libvirt is updated to know about
> it, people can easily be using a previous libvirt release.
> 
> QEMU itself needs to make the machine types do that they are there
> todo, which is to define a stable machine ABI. 
> 
> What QEMU is missing here is a "platform ABI" concept, to encode
> sets of features which are tied to specific platform generations.
> As long as we don't have that we'll keep having these broken
> migration problems from machine types dynamically changing instead
> of providing a stable guest ABI.

Any more elaboration on this idea?  Would it be easily feasible in
implementation?

I'd second any sane solution that we can avoid happening similar breakages
in the future.

I also wonder what else might be easily affected like this too when
migration can break with changed kernel or changed HW.  I suppose the CPU
model is well covered by Libvirt so we're fine at least on x86 etc.  While
IIUC KVM always have such thoughts in mind, so that KVM will make sure to
not break an userspace in such way or it'll simply be a KVM bug and fixed.

Thanks,

-- 
Peter Xu


