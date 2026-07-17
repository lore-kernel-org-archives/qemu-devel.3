Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE981C4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 15:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkk4H-0001ru-Ri; Fri, 17 Jul 2026 11:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wkk49-0001rZ-Uw
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 11:01:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wkk46-0003Vy-K0
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 11:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784300483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oj7jnYZjDQzdgWIFlUsf3qaKH+xkcSyzJAo15cdMS34=;
 b=UmxwbU+aUpwTHUJP6AjzqyJSTqCGnUC+dUdAT4wNe3ewMIFFd1kNoCJ/7nvfGUcvD4u67B
 MkUrvFRDGq8JMZYB3SYLDZmfCszneOxLLMDIC0LMrOF3AlKOTnxE1QvBaTWDu1cSMy0cNs
 pxm1YvvrI8UOVaUE3S7Alawqxefl9kI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-xQIHkBpVNyaIOA3befIqIw-1; Fri, 17 Jul 2026 11:01:22 -0400
X-MC-Unique: xQIHkBpVNyaIOA3befIqIw-1
X-Mimecast-MFC-AGG-ID: xQIHkBpVNyaIOA3befIqIw_1784300481
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c1630a90890so588724866b.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784300481; x=1784905281; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Oj7jnYZjDQzdgWIFlUsf3qaKH+xkcSyzJAo15cdMS34=;
 b=oAVXrmNZuSUMtTLjig8ZZvYyOv8gMoHhdhcOA4TGRoa+EpikmyIlD3zK2iYp7xcLOW
 wFbpeWPVhz2eg+p0kfKVyqI3soDEXBS6OiptRESbtMBKK1/lTx2CGRoz9SFLKvC5pL1b
 IehhkdEBGiwLt6oz+r32CsGdDpCBwQQpOkZDaHr8+yp6AbpNCs7ioMym2mWkgZBbTIOZ
 NBL2klaDz8+von4zNDSrLfbo78T8IhTdygaokmNoGhNdoDLoUr/t0djVw/jgg5GVjf92
 nUOwNgEQIvjQWX26VK1Vu4yetL0AdLINOM5U9g6xCpEWLlmkbFFWF4lAGju8AEkdKInb
 bLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784300481; x=1784905281;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Oj7jnYZjDQzdgWIFlUsf3qaKH+xkcSyzJAo15cdMS34=;
 b=QXKT3DUf+EKLDbEi/yWTmpZ+MpzRq7hwIRbbj51lvurui6qb/5mJEX8U5gE9IJ8pZk
 pMqbH29TGJPrayhqdhPrY4IBgGYT+nuG3AqJCu3OZ5ruqM4wDvDg1ns3ymXSNC81WcF3
 fpm2ebeYor+WIreumZpq2gnTv6aZV1Ze3wmvcqok1WIbZQQKEXpesSTR28zl2G0+phx6
 1oGyZL4d8zyvqwExqkWXn61eTkaVH7xQ0AUEEb37Sbxw/FLczwP4kLsX4gH0UvXKiUnr
 YAX/ufO5q8IqHQx8338Io4fJBzIi8Qmo316FkgLl6+Y8oEiYwdVR4RPLNkGNyg6ZaGEZ
 PHKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHZRsr4YvqDqskb6ukgkFye2DRC2kULRhn+ADZkC5Aes7zfgWZ+KwBiIhFytz73onKmE9VKwVmGegG@nongnu.org
X-Gm-Message-State: AOJu0YzJjNGyLpLmJBZJMQyXpK+roRM/JUrZTfymsYuH2FJ68caYhWEH
 S+glTEuWvbIt+ykXdxVTzLAx31htlYO/ZV/JGUNktIOvnZicL5QSZ9jZeRgRKPlmXbMgojulLQ/
 wUINwCZXZFHmmN2S+CSRZ2ePMw89JaZiJ/xDMS4sNqGv/UUF40hpva2yG
X-Gm-Gg: AfdE7cnzk4Qv2bFSXJpBz8lw1t6b8aIkpXOgAcxDwtUesUVkK4VwqwUdPYDHeXCsWlX
 ast3UxT//I17Jm9HGrA/PZ/OugIkc/IpvGW97ysBcHLmkt9XX7WJZLQGSGLkxgi1j6hmGCBComT
 Baje+ya+tokLCo0Jtje9vkkyDAfr7wTDlsMJC6daKM4spqzwEx1FXdPzp59FdPiQybzhh9uDHWE
 SbDEPx2K90J+hH9PyySOMP488bvcRUcD+hLR/yeOi+En64wNSCO6LDG2v2VkoXvfLM1zhAwHzSn
 m1A1mVV/gFq/PYHlcOZuxlPcaJ/fIn5Wsc3QgEqzCqJiZqtY5hz4ycMzHFOT+6/CFlqJ
X-Received: by 2002:a17:907:1b13:b0:c12:d971:1c1d with SMTP id
 a640c23a62f3a-c16b4837dc7mr117987066b.45.1784300480699; 
 Fri, 17 Jul 2026 08:01:20 -0700 (PDT)
X-Received: by 2002:a17:907:1b13:b0:c12:d971:1c1d with SMTP id
 a640c23a62f3a-c16b4837dc7mr117982866b.45.1784300479895; 
 Fri, 17 Jul 2026 08:01:19 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1712a5fa23sm90828766b.39.2026.07.17.08.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 08:01:18 -0700 (PDT)
Date: Fri, 17 Jul 2026 11:01:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs: outline some guidelines for security classification
Message-ID: <alpDuIEBdwvAWJu5@x1.local>
References: <20260707105927.2776822-1-berrange@redhat.com>
 <CAMxuvazpNiy8iqu76wJwiF3aKEizjgZaQFgF3gtHDXqiGh9Fsw@mail.gmail.com>
 <ak0q0vOeFVJsDBcL@redhat.com> <87jyqv3u32.fsf@suse.de>
 <alj7gF_ayHO7Dvb7@x1.local> <87cxwm4vkc.fsf@suse.de>
 <alk3U6P_W0z-XNF1@x1.local> <87a4rq4g9q.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a4rq4g9q.fsf@suse.de>
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Jul 16, 2026 at 09:21:53PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Jul 16, 2026 at 03:51:31PM -0300, Fabiano Rosas wrote:
> >> > I wonder if we can simply above 5 points into something simpler, or skip
> >> > for now?  To me, what is out of scope is more valuable to be put into doc,
> >> > because I bet 99% if not all of existing "security issues" on migration in
> >> > past few months fall into it.. so it saves huge time already for triaging.
> >> 
> >> I want to reduce the guesswork both when reporting issues and when
> >> triaging. People tend to sit around and imagine infinite scenarios, it's
> >> not productive.
> >> 
> >> This section is so we can point at it and ask for some indication of any
> >> of the points above. Otherwise we'll get the random bug report saying
> >> that weird behavior was achieved, therefore CVE. These are the
> >> situations I could think of that would obviously be worthy of further
> >> consideration.
> >> 
> >> Could you expand on why you think this is not worth having? I don't
> >> think I understand it.
> >
> > I didn't expect to point to a bug report into "IN SCOPE" category.  IMHO,
> > the major use case for the doc is to point a bug report into "OUT OF SCOPE"
> > category.. then we can easily justify an issue to be not a CVE candidate.
> >
> > When it is a real security issue, we likely need to evaluate it case by
> > case, but first it needs to not directly fall int OUT OF SCOPE first.
> >
> > I think it could be that I hardly have any real experience with a legit
> > security report versus migration yet, but we have richer experience on
> > "what we don't think is a security issue, but only a bug" thanks to AI.. so
> > NOT IN SCOPE is easier to list to me than IN SCOPE ones.
> >
> 
> I see.
> 
> > Neither do I have very clear idea after reading the five examples given.
> >
> > To make it clearer on what I meant, I can start by asking some questions on
> > the five examples listed IN SCOPE.  You don't need to answer all, or
> > maybe.. no need to answer any of them, just to show my confusions on
> > reading the examples (hence the request of simplifications, or removal, at
> > first version).
> >
> 
> Thanks, let's see if I can defend myself! =)

When we're on the same side, there isn't much to "defend"! :)

> 
> >> 1) Privilege escalation from the guest operating system into the
> >> destination QEMU process or host.
> >
> > Do you mean any form of guest operation to cause privilege escalation?
> > Obviously, it must be about during a live migration happening, otherwise I
> > don't see how it is relevant to migration, but then is this only talking
> > about a postcopy use case (where dest QEMU has vCPU running)?  After all,
> > precopy migration guest operations all done on source, so if there's any
> > privilege escalation, it needs to happen on source host first.
> >
> > Also, I am a bit lost on why this is special for migration.  Such issue can
> > happen on any host without migration.  It's a bit unclear to me.
> >
> 
> I mean when the guest OS does some trickery that gets propagated to the
> destination machine via migration and the person controlling that guest
> gets privileges on the QEMU process on the destination. Injecting a
> payload of some sort, or setting up a device to allow later
> exploitation.

To me, it's more likely some exploit will work even without migration, than
some exploit only be enabled only after a migration. But I understand now.
Maybe some more description would be nice?

For example, "privilege escalation that can only be enabled by a migration
process (successful or not)", which IMO it doesn't always need to be on the
dest too, if a failed migration can also trigger an exploit.

I think your wording in English is normally better than mine, though..

> 
> >> 
> >> 2) Tampering or exfiltration of migration stream data by a third party
> >> at a lower privilege level than either QEMU processes involved in the
> >> migration.
> >
> > If we have the ASSUMPTION describing migration stream is secure, why do we
> > worry about third party hijacking migration stream?  Someone already
> > breached?
> >
> 
> We assume the stream is secure, but there could still be a bug in the
> migration code that allows a thirdy party to read the stream. As for
> "tampering", you're right that's probably already covered by the
> assumptions we made earlier.

I see.  Can it be put in another (hopefully simpler) way? Like "Exploits
that can cause misfunction / disability of migration channel encryptions".

> 
> >> 
> >> 3) Termination of the source QEMU process by source virtual machine
> >> guest userspace, including by forcing host OS resource constraints to
> >> be reached.
> >
> > This is also not clear on how it correlates to migration, because IIUC this
> > can also happen without migration.  Maybe it's trying to catch the cases
> > where it only can be attacked during migration?
> >
> 
> Yes, say the userspace inside the guest does something that causes the
> migration code to crash when qmp_migrate is issued, for instance. I'm
> not saying it's a simple thing to happen, just that IF it happens, then
> we have already reasoned about it and agreed that it has the potential
> to become a CVE.

If any guest behavior can either crash QEMU or causing monitor commands to
further crash QEMU, then I think it deserves a CVE.

But then here it's about when migration is involved.  It's again a niche
context to think about IMHO, but yes I get what you mean now.

> 
> > What is "guest userspace"?  Is that the userspace of the guest OS?
> >
> 
> Yes, assuming the OS itself already has ways to shoot itself in the foot
> by tampering with devices. But the userspace is in another layer, it
> could attempt to do bad things to the OS.

IIUC, from QEMU security pov, guest userspace or kernel shouldn't make much
difference.  Guest userspace messing up with guest kernel is the same as
when happening on bare metal in most cases?

There might be something more to exploit when hypervisor bug helps an
attacker, but again if we furtheradd migration into picture, that becomes:

  Guest userspace exploits that explicitly leverage a hypervisor bug
  _during_ migration to attach the guest OS

I agree if there is such a case it might be CVE candidate, but it's a bit
too detailed in my flavor to be put into a doc for demostration purpose..
Basically since migration is fully transparent we can add "during
migration" into all the hypervisor related scenarios..

Maybe we can simplify this to below?

  Guest crash or misbehave that can only be exploited during migration
  process

But this looks like what 1) was talking about, so maybe we can merge them
too?

> >> 
> >> 4) Other tampering or exfiltration of data from the source QEMU process
> >> if reached from migration code or migration stream manipulation.
> >
> > This is a very generic statement to me, even though I think it's correct..
> > Say, how stream can be manipulated with TLS encryption?  If it's
> > manipulated from the guest, is the guest data being tampered on its own or
> > some other data?
> >
> 
> Right, this is a catchall meaning: even with all of the above, if
> someone finds a way to do this, the previous points do not invalidate
> this find.
> 
> I guess I wrote all of these with a sense of providing some assurance
> that even though we'll possibly be rejecting various bugs as
> non-security related, there are still clear situations where there's a
> security implication and we're aware of it.

Yes, I think from that POV maybe you're right we should still attach IN
SCOPE examples, but just to use some simpler wording and obvious examples
in the description.

For this one, it's about "data breach".  Can merge with 1) too?

> 
> >> 
> >> 5) Causing source QEMU process to enter a state from which migration is
> >> not possible permanently.
> >
> > This is a very valid one and clear to understand.  However I don't know if
> > any of such would really happen, though.
> 
> I don't think it matters if it would happen. If it ever does, we think
> it's bad enough that it will be considered for a CVE. "Considered", as
> opposed to just filing it as a normal bug. But the analysis could still
> result in nothing and we'd treat it as just a bug anyway.
> 
> > It's easier to happen to me when e.g. we leaked memory in QMP handlers
> > which may cause DoS rather than "cannot migrate anymore"..
> >
> 
> What I'm talking about in this particular point is about putting an
> admin in a situation where they can only resort to shutting down the
> virtual machine. This is a counterpart to the "failed migrations are
> normal" assumption up above; failed migrations can be easily worked
> around, but permanent failure cannot.

Yeah, that's OK.

> 
> > Also, if it's only the VM itself got affected (say, attacker from guest
> > within causing its VM not migratable), then the damage it can cause is very
> > limited too.  I'm not 100% sure I know how severe is such, and whether it's
> > CVE.
> 
> Fair point, maybe it's not super relevant indeed. Note I'm not trying to
> say that these items will become CVEs, just that if someone can put an
> argument that they can happen, then it's something we'll gladly look
> into.

IMHO if we want to have IN SCOPE, we should put whatever we're 100% sure is
CVE into IN SCOPE, and avoid mention things in-between.  Otherwise it may
make the document less clear, then less helpful in general.

It's the same to OUT OF SCOPE: when we see anything falls into that, we
should be confident to say "This is not a CVE candidate, please refer to
document XXX".

I used to suggest removal of IN SCOPE was only trying to make the first
version easier.  I agree having some would make sense even in the first
version, but maybe some rewording would be nice to make it very clear on
what it describes.

IMO it can still be as generic as this in one bullet covering a lot of
cases, meanwhile hopefully clear on what it describes:

  Any form of privilege escalation, data breach, guest crash [1] or
  hypervisor misbehave that requires migration process to trigger,
  successful or not.

  [1] guest crash only matters on whichever side is live.  For example, in
  a precopy setup, destination QEMU crash is normally benign and can easily
  fallback to source by a migration failure.  The guest crash described
  here should only include where it causes real damage to the guest VM by
  enforced shutdown or misbehave.

I'll leave decision to you on what you prefer as long as no objections
elsewhere; you have kudos drafting this, you deserve it.

Thanks!

-- 
Peter Xu


