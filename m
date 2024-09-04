Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AD7CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 22:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slyPy-0003la-9A; Wed, 04 Sep 2024 18:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slyPw-0003kf-Fn
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 18:24:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1slyPt-0006a4-PS
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 18:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725488635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sRRfQKr0NVxtEzt5AWKPXiDVVrEgSuHgq20POCABfLU=;
 b=fnfMeJ+jDgvIACQSLVk5D75u4EUFYnAngLRgtlnfXky1yzeSKSSGr3Aa3Ss695KPvWBPM7
 g1CzIl41+kG5gH1HBe+TyMSF/uuGNVLA5EMepIcPj8EJi3emsMaJG5+KlmRRsn77meFSJq
 6GaTSsl7+ihVBp3Nn26ZuEqHOfqN+yQ=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-LR8f8rdtPV-6POXT-lod1A-1; Wed, 04 Sep 2024 18:23:54 -0400
X-MC-Unique: LR8f8rdtPV-6POXT-lod1A-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3df57a518ccso71589b6e.0
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 15:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725488634; x=1726093434;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sRRfQKr0NVxtEzt5AWKPXiDVVrEgSuHgq20POCABfLU=;
 b=YMlqhK7khJpXuDZLVFpR9jFF2F2g1LyBeAZxxpzpDVeoZZ9uqyQJltYK3ebzaJpMgF
 x21Qio8UnNYEXTUZX54bDrINrtAKVoV+cc2TGaptKm/Ttf/DRi7SpPnbPHWKJufgxOBl
 ywpUCz8sefpf3wZRNq+eLjGYEjmi5yvnE3k7jn4RnMkZyaDrOtPCotK/XXExZdNz+NBg
 82+tSjkDtfV30vE2yQcNj1NBqmHbCQeYlpLqNXC+8fwKl/FBMPvf59SQQCXk8vsxBjQA
 LWrAI+3HWW69ooJj5eQi75CubNsvLGiKohV52YflQipMUmzd1JjrfBqcuFboFj51HhBE
 u2Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxoDWcqMCnQN9d7aX1ccpv5Y3zN2Gqc6XKG83dggq51rKmtNWmiC8rGbjEKKoVylP9P3axtjFx9sYc@nongnu.org
X-Gm-Message-State: AOJu0YzJi3hNxUO9s46xOHvW7uxsMsbLwzOQWQ5CbhARuwN0GbOrg541
 rNfIR2aRiukfykIAWUThaClPYVThWuqdoj3Jn9mBg1/XkrCguEGyoRRVFh1B8njGmjfYJhPpGMe
 apkQ/vgXL7XL0BGs5doxi17BPSZt59yfKvGannywFUfM6k45Uql1X
X-Received: by 2002:a05:6808:11c8:b0:3db:5260:a994 with SMTP id
 5614622812f47-3df1b84aa43mr16550224b6e.42.1725488633949; 
 Wed, 04 Sep 2024 15:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoTpmOkBX19zd64RK5Ggs/y8Y3uv6vyZvkfIe78HD6IqPqLzbf2GPRoJgfw2ya1vhKrBpn7w==
X-Received: by 2002:a05:6808:11c8:b0:3db:5260:a994 with SMTP id
 5614622812f47-3df1b84aa43mr16550193b6e.42.1725488633475; 
 Wed, 04 Sep 2024 15:23:53 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45801db2c2bsm2317471cf.70.2024.09.04.15.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 15:23:52 -0700 (PDT)
Date: Wed, 4 Sep 2024 18:23:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
Message-ID: <Ztjd9nsrqgjfYTz1@x1n>
References: <Zru4AaTmBIAGnyDr@x1n>
 <46b63356-9602-4fa2-9d31-186f5f85151f@oracle.com>
 <Zr9q4muKZmYCf9mv@x1n> <Zr9tYsmy8j2t8fq0@redhat.com>
 <Zr9xcmUfkYAWnXH-@x1n> <Zr93oOn9J5JLs2Rn@redhat.com>
 <Zr97ms6Ur9HH_EXG@x1n>
 <d45761d3-6bee-42ac-9752-1192b3bae6ef@oracle.com>
 <ZsYzIN5pM9Ad_DYn@x1n>
 <e1284027-6860-460c-8f3c-5b9c34e2c351@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1284027-6860-460c-8f3c-5b9c34e2c351@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Sep 04, 2024 at 04:58:14PM -0400, Steven Sistare wrote:
> On 8/21/2024 2:34 PM, Peter Xu wrote:
> > On Fri, Aug 16, 2024 at 01:09:23PM -0400, Steven Sistare wrote:
> > > On 8/16/2024 12:17 PM, Peter Xu wrote:
> > > > On Fri, Aug 16, 2024 at 05:00:32PM +0100, Daniel P. Berrangé wrote:
> > > > > On Fri, Aug 16, 2024 at 11:34:10AM -0400, Peter Xu wrote:
> > > > > > On Fri, Aug 16, 2024 at 04:16:50PM +0100, Daniel P. Berrangé wrote:
> > > > > > > On Fri, Aug 16, 2024 at 11:06:10AM -0400, Peter Xu wrote:
> > > > > > > > On Thu, Aug 15, 2024 at 04:55:20PM -0400, Steven Sistare wrote:
> > > > > > > > > On 8/13/2024 3:46 PM, Peter Xu wrote:
> > > > > > > > > > On Tue, Aug 06, 2024 at 04:56:18PM -0400, Steven Sistare wrote:
> > > > > > > > > > > > The flipside, however, is that localhost migration via 2 separate QEMU
> > > > > > > > > > > > processes has issues where both QEMUs want to be opening the very same
> > > > > > > > > > > > file, and only 1 of them can ever have them open.
> > > > > > > > > > 
> > > > > > > > > > I thought we used to have similar issue with block devices, but I assume
> > > > > > > > > > it's solved for years (and whoever owns it will take proper file lock,
> > > > > > > > > > IIRC, and QEMU migration should properly serialize the time window on who's
> > > > > > > > > > going to take the file lock).
> > > > > > > > > > 
> > > > > > > > > > Maybe this is about something else?
> > > > > > > > > 
> > > > > > > > > I don't have an example where this fails.
> > > > > > > > > 
> > > > > > > > > I can cause "Failed to get "write" lock" errors if two qemu instances open
> > > > > > > > > the same block device, but the error is suppressed if you add the -incoming
> > > > > > > > > argument, due to this code:
> > > > > > > > > 
> > > > > > > > >     blk_attach_dev()
> > > > > > > > >       if (runstate_check(RUN_STATE_INMIGRATE))
> > > > > > > > >         blk->disable_perm = true;
> > > > > > > > 
> > > > > > > > Yep, this one is pretty much expected.
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > > > Indeed, and "files" includes unix domain sockets.
> > > > > > > > > 
> > > > > > > > > More on this -- the second qemu to bind a unix domain socket for listening
> > > > > > > > > wins, and the first qemu loses it (because second qemu unlinks and recreates
> > > > > > > > > the socket path before binding on the assumption that it is stale).
> > > > > > > > > 
> > > > > > > > > One must use a different name for the socket for second qemu, and clients
> > > > > > > > > that wish to connect must be aware of the new port.
> > > > > > > > > 
> > > > > > > > > > > Network ports also conflict.
> > > > > > > > > > > cpr-exec avoids such problems, and is one of the advantages of the method that
> > > > > > > > > > > I forgot to promote.
> > > > > > > > > > 
> > > > > > > > > > I was thinking that's fine, as the host ports should be the backend of the
> > > > > > > > > > VM ports only anyway so they don't need to be identical on both sides?
> > > > > > > > > > 
> > > > > > > > > > IOW, my understanding is it's the guest IP/ports/... which should still be
> > > > > > > > > > stable across migrations, where the host ports can be different as long as
> > > > > > > > > > the host ports can forward guest port messages correctly?
> > > > > > > > > 
> > > > > > > > > Yes, one must use a different host port number for the second qemu, and clients
> > > > > > > > > that wish to connect must be aware of the new port.
> > > > > > > > > 
> > > > > > > > > That is my point -- cpr-transfer requires fiddling with such things.
> > > > > > > > > cpr-exec does not.
> > > > > > > > 
> > > > > > > > Right, and my understanding is all these facilities are already there, so
> > > > > > > > no new code should be needed on reconnect issues if to support cpr-transfer
> > > > > > > > in Libvirt or similar management layers that supports migrations.
> > > > > > > 
> > > > > > > Note Libvirt explicitly blocks localhost migration today because
> > > > > > > solving all these clashing resource problems is a huge can of worms
> > > > > > > and it can't be made invisible to the user of libvirt in any practical
> > > > > > > way.
> > > > > > 
> > > > > > Ahhh, OK.  I'm pretty surprised by this, as I thought at least kubevirt
> > > > > > supported local migration somehow on top of libvirt.
> > > > > 
> > > > > Since kubevirt runs inside a container, "localhost" migration
> > > > > is effectively migrating between 2 completely separate OS installs
> > > > > (containers), that happen to be on the same physical host. IOW, it
> > > > > is a cross-host migration from Libvirt & QEMU's POV, and there are
> > > > > no clashing resources to worry about.
> > > > 
> > > > OK, makes sense.
> > > > 
> > > > Then do you think it's possible to support cpr-transfer in that scenario
> > > > from Libvirt POV?
> > > > 
> > > > > 
> > > > > > Does it mean that cpr-transfer is a no-go in this case at least for Libvirt
> > > > > > to consume it (as cpr-* is only for local host migrations so far)?  Even if
> > > > > > all the rest issues we're discussing with cpr-exec, is that the only way to
> > > > > > go for Libvirt, then?
> > > > > 
> > > > > cpr-exec is certainly appealing from the POV of avoiding the clashing
> > > > > resources problem in libvirt.
> > > > > 
> > > > > It has own issues though, because libvirt runs all QEMU processes with
> > > > > seccomp filters that block 'execve', as we consider QEMU to be untrustworthy
> > > > > and thus don't want to allow it to exec anything !
> > > > > 
> > > > > I don't know which is the lesser evil from libvirt's POV.
> > > > > 
> > > > > Personally I see security controls as an overriding requirement for
> > > > > everything.
> > > > 
> > > > One thing I am aware of is cpr-exec is not the only one who might start to
> > > > use exec() in QEMU. TDX fundamentally will need to create another key VM to
> > > > deliver the keys and the plan seems to be using exec() too.  However in
> > > > that case per my understanding the exec() is optional - the key VM can also
> > > > be created by Libvirt.
> > > > 
> > > > IOW, it looks like we can still stick with execve() being blocked yet so
> > > > far except cpr-exec().
> > > > 
> > > > Hmm, this makes the decision harder to make.  We need to figure out a way
> > > > on knowing how to consume this feature for at least open source virt
> > > > stack..  So far it looks like it's only possible (if we take seccomp high
> > > > priority) we use cpr-transfer but only in a container.
> > > 
> > > libvirt starts qemu with the -sandbox spawn=deny option which blocks fork, exec,
> > > and change namespace operations.  I have a patch in my workspace to be submitted
> > > later called "seccomp: fine-grained control of fork, exec, and namespace" that allows
> > > libvirt to block fork and namespace but allow exec.
> > 
> > The question is whether that would be accepted, and it also gives me the
> > feeling that even if it's accepted, it might limit the use cases that cpr
> > can apply to.
> 
> This is more acceptable for libvirt running in a container (such as under kubevirt)
> with a limited set of binaries in /bin that could be exec'd.  In that case allowing
> exec is more reasonable.
> 
> > What I read so far from Dan is that cpr-transfer seems to be also preferred
> > from Libvirt POV:
> > 
> >    https://lore.kernel.org/r/Zr9-IvoRkGjre4CI@redhat.com
> > 
> > Did I read it right?
> 
> I read that as: cpr-transfer is a viable option for libvirt.  I don't hear him
> excluding the possibility of cpr-exec.

I preferred not having two solution because if they work the same problem
out, then it potentially means one of them might be leftover at some point,
unless they suite different needs.  But I don't feel strongly, especially
if cpr-exec is light if cpr-transfer is there.

> 
> I agree that "Dan the libvirt expert prefers cpr-transfer" is a good reason to
> provide cpr-transfer.  Which I will do.
> 
> So does "Steve the OCI expert prefers cpr-exec" carry equal weight, for also
> providing cpr-exec?

As an open source project, Libvirt using it means the feature can be
actively used and tested.  When e.g. there's a new feature replacing CPR we
know when we can obsolete the old CPR, no matter -exec or -transfer.

Close sourced projects can also be great itself but naturally are less
important in open source communities IMHO due to not accessible to anyone
in the community.  E.g., we never know when an close sourced project
abandoned a feature, then QEMU can carry over that feature forever without
knowing who's using it.

It's the same as when Linux doesn't maintain kabi on out-of-tree drivers to
me.  It's just that here the open source virt stack is a huge project and
QEMU plays its role within.

> 
> We are at an impasse on this series.  To make forward progress, I am willing to
> reorder the patches, and re-submit cpr-transfer as the first mode, so we can
> review and pull that.  I will submit cpr-exec as a follow on and we can resume
> our arguments then.

Yes this could be better to justify how small change cpr-exec would need on
top of cpr-transfer, but I'd still wait for some comments from Dan or
others in case they'll chime in, just to avoid sinking your time with
rebases.

Thanks,

-- 
Peter Xu


