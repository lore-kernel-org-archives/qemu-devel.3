Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D7FC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 20:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXRqx-0000RP-KA; Fri, 26 Jul 2024 16:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sXRqw-0000Q7-8J
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 16:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sXRqu-0007Pc-5K
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 16:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722026866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4MPYkjQVAfHCFd+5FpTcjfgvkwcFZw8gKiqMKNdAr4M=;
 b=b6eUnYbHSvTenk7/HkN3wQGxW1tKuLhbJbkVwzLIWEQfhAobEC+XUPgWAtOubF7TotM25j
 yaY8hWpvB3aArPW29IIebYbfOJQKoBngN85Ceubme6yEIsN6ffSc0SlFjt6VbDo0kydTOK
 U+P2m0y34AKI0NSvylFZ3jhLPtr/9M0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-f8tiB8B7P4mk8e3Rd863fQ-1; Fri, 26 Jul 2024 16:47:44 -0400
X-MC-Unique: f8tiB8B7P4mk8e3Rd863fQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6ba92dd246fso1599556d6.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 13:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722026864; x=1722631664;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4MPYkjQVAfHCFd+5FpTcjfgvkwcFZw8gKiqMKNdAr4M=;
 b=whMDyFn3HeH8ya84gnpmy68ijb2QawoduDeuj+igei38zU9xvItdbGMUZnzWe1hgEx
 aw4YmTJ32krVLQUGwzzJgIIPZnao3YA14AcDwys5MNH5yYgU4fiqMb8tJMqbixxRXoSl
 PL4renTVxGQpXWjOLNnmAMtrDbK8IQAudw8LkFRCGopQur4GcLgtoSmvgs72CLhfws1c
 Zhsi+UpTYzxuTcYNxPh3ZF+qThOrl+UnDtkOE/XQoqWVmo9xf7Zq2+Z7AnOBwYPPGDLX
 hkAJRnlvFp9qwneHQv2sJmaptvYv2JY/FQJ8MRhsLRMIgTY1uZHsAU0fmxzcwC9j0F8d
 AyAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEo1WSVqGryHohiz3ClzHvh0pnaCs3QPoz7+JL3BOTOkS/gsrk3GfUYKqZa3xRyaqFaFUnVqXgJzp6@nongnu.org
X-Gm-Message-State: AOJu0YzMcSNAdJIAy2Po6yHNCEp8jp9jv2Rf0PrGr8m3gStxbny9ieu5
 APp6R2LjUKSEHI2dqVAyVLFub76eEF9ibqouzREInN0RYAnI9dFzAiyWFL//obMUJafR9jK2ZlN
 VLDxEdTfw5NlweOvsUc7b5GBnylNIzfr0Y0kclmRfQuIe5aFICA07
X-Received: by 2002:a05:6214:501d:b0:6bb:3f69:dd0c with SMTP id
 6a1803df08f44-6bb3f69defdmr43187246d6.9.1722026863918; 
 Fri, 26 Jul 2024 13:47:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGHm4wLRuk17bEqt/rrVt95CKL7dlXG/ki30Ro+/4r2XTXJqyumv1venoWre7wJDzpcyL2Dw==
X-Received: by 2002:a05:6214:501d:b0:6bb:3f69:dd0c with SMTP id
 6a1803df08f44-6bb3f69defdmr43187096d6.9.1722026863421; 
 Fri, 26 Jul 2024 13:47:43 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bb3f9148aesm19701486d6.62.2024.07.26.13.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 13:47:42 -0700 (PDT)
Date: Fri, 26 Jul 2024 16:47:40 -0400
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
Message-ID: <ZqQLbGxEW3XT7qL-@x1n>
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com>
 <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com> <ZqO2HvFJ8v7hZFOd@x1n>
 <ZqO7cR-UiGpX2rk0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqO7cR-UiGpX2rk0@redhat.com>
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

On Fri, Jul 26, 2024 at 04:17:12PM +0100, Daniel P. Berrangé wrote:
> On Fri, Jul 26, 2024 at 10:43:42AM -0400, Peter Xu wrote:
> > On Fri, Jul 26, 2024 at 09:48:02AM +0100, Daniel P. Berrangé wrote:
> > > On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wrote:
> > > > On 26/07/2024 08.08, Michael S. Tsirkin wrote:
> > > > > On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
> > > > > > On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
> > > > > > > USO features of virtio-net device depend on kernel ability
> > > > > > > to support them, for backward compatibility by default the
> > > > > > > features are disabled on 8.0 and earlier.
> > > > > > > 
> > > > > > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > > > > > Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
> > > > > > 
> > > > > > Looks like this patch broke migration when the VM starts on a host that has
> > > > > > USO supported, to another host that doesn't..
> > > > > 
> > > > > This was always the case with all offloads. The answer at the moment is,
> > > > > don't do this.
> > > > 
> > > > May I ask for my understanding:
> > > > "don't do this" = don't automatically enable/disable virtio features in QEMU
> > > > depending on host kernel features, or "don't do this" = don't try to migrate
> > > > between machines that have different host kernel features?
> > > > 
> > > > > Long term, we need to start exposing management APIs
> > > > > to discover this, and management has to disable unsupported features.
> > > > 
> > > > Ack, this likely needs some treatments from the libvirt side, too.
> > > 
> > > When QEMU automatically toggles machine type featuers based on host
> > > kernel, relying on libvirt to then disable them again is impractical,
> > > as we cannot assume that the libvirt people are using knows about
> > > newly introduced features. Even if libvirt is updated to know about
> > > it, people can easily be using a previous libvirt release.
> > > 
> > > QEMU itself needs to make the machine types do that they are there
> > > todo, which is to define a stable machine ABI. 
> > > 
> > > What QEMU is missing here is a "platform ABI" concept, to encode
> > > sets of features which are tied to specific platform generations.
> > > As long as we don't have that we'll keep having these broken
> > > migration problems from machine types dynamically changing instead
> > > of providing a stable guest ABI.
> > 
> > Any more elaboration on this idea?  Would it be easily feasible in
> > implementation?
> 
> In terms of launching QEMU I'd imagine:
> 
>   $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...args...
> 
> Any virtual machine HW features which are tied to host kernel features
> would have their defaults set based on the requested -platform. The
> -machine will be fully invariant wrt the host kernel.
> 
> You would have -platform hlep to list available platforms, and
> corresonding QMP "query-platforms" command to list what platforms
> are supported on a given host OS.
> 
> Downstream distros can provide their own platforms definitions
> (eg "linux-rhel-9.5") if they have kernels whose feature set
> diverges from upstream due to backports.
> 
> Mgmt apps won't need to be taught about every single little QEMU
> setting whose default is derived from the kernel. Individual
> defaults are opaque and controlled by the requested platform.
> 
> Live migration has clearly defined semantics, and mgmt app can
> use query-platforms to validate two hosts are compatible.
> 
> Omitting -platform should pick the very latest platform that is
> cmpatible with the current host (not neccessarily the latest
> platform built-in to QEMU).

This seems to add one more layer to maintain, and so far I don't know
whether it's a must.

To put it simple, can we simply rely on qemu cmdline as "the guest ABI"?  I
thought it was mostly the case already, except some extremely rare
outliers.

When we have one host that boots up a VM using:

  $QEMU1 $cmdline

Then another host boots up:

  $QEMU2 $cmdline -incoming XXX

Then migration should succeed if $cmdline is exactly the same, and the VM
can boot up all fine without errors on both sides.

AFAICT this has nothing to do with what kernel is underneath, even not
Linux?  I think either QEMU1 / QEMU2 has the option to fail.  But if it
didn't, I thought the ABI should be guaranteed.

That's why I think this is a migration violation, as 99.99% of other device
properties should be following this rule.  The issue here is, we have the
same virtio-net-pci cmdline on both sides in this case, but the ABI got
break.

That's also why I was suggesting if the property contributes to the guest
ABI, then AFAIU QEMU needs to:

  - Firstly, never quietly flipping any bit that affects the ABI...

  - Have a default value of off, then QEMU will always allow the VM to boot
    by default, while advanced users can opt-in on new features.  We can't
    make this ON by default otherwise some VMs can already fail to boot,

  - If the host doesn't support the feature while the cmdline enabled it,
    it needs to fail QEMU boot rather than flipping, so that it says "hey,
    this host does not support running such VM specified, due to XXX
    feature missing".

That's the only way an user could understand what happened, and IMHO that's
a clean way that we stick with QEMU cmdline on defining the guest ABI,
while in which the machine type is the fundation of such definition, as the
machine type can decides many of the rest compat properties.  And that's
the whole point of the compat properties too (to make sure the guest ABI is
stable).

If kernel breaks it easily, all compat property things that we maintain can
already stop making sense in general, because it didn't define the whole
guest ABI..

So AFAIU that's really what we used for years, I hope I didn't overlook
somehting.  And maybe we don't yet need the "-platform" layer if we can
keep up with this rule?

Thanks,

-- 
Peter Xu


