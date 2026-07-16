Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB95C44514
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 19:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkSC0-0007lr-Bz; Thu, 16 Jul 2026 15:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wkSBy-0007lR-QP
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wkSBw-0008UQ-Jz
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 15:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784231778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U228GzrKyORQv9ntqC4dIPAxuGww2BOhCo9jSL7tH2w=;
 b=UR44E2xaKQGciHgG+xdurFi4m8donW7oPqjLkan0xdx+tIQ73DEY0ksALye4yt4G7qqI1G
 ju7QdjJAMj4MjHG/npLln7A+BRpIOqEu7kYYO1TpjUIaqIXWwaiwlKfzRxdwCRaL+TSn+U
 eSFqtxX+sG1g8FSNaDjvEYSvcrXPWpk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-qTwIQS-GOtKqRPkYXgNcBg-1; Thu, 16 Jul 2026 15:56:17 -0400
X-MC-Unique: qTwIQS-GOtKqRPkYXgNcBg-1
X-Mimecast-MFC-AGG-ID: qTwIQS-GOtKqRPkYXgNcBg_1784231777
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92ea24a2db9so1168354085a.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 12:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784231777; x=1784836577; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U228GzrKyORQv9ntqC4dIPAxuGww2BOhCo9jSL7tH2w=;
 b=HUH+hvj8o9ltk2WT6bl+WqydG//Rhpout1ANni0mJT5Rr0ic7zAeDutjVYTctftV4E
 FwbVFEw/9XkaxPoWwh0nk+10a5MNJ21EOA/oI9u7mCdLqcCMPNMYC+KxpjSls0cgMTWX
 kL27zMCyWxQKn+Jl2bZDvasX36kDXn7//O6aHi/MgtJzAq4kxgng6JLBDDV0EzejcBrR
 4MsNDvNv3VCnU9n1BnYgdq/fJbcDDKfQB2YF8OCMIAheFjJ671Ew8gzzyA/hHkRq3DK+
 HUg2NieDNYV0emt4rjeIQYcurRKi0rif66EQEd3tP/oT4O/tscJqnMwV8F6CY0gtqBLD
 oWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784231777; x=1784836577;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U228GzrKyORQv9ntqC4dIPAxuGww2BOhCo9jSL7tH2w=;
 b=e4M+clByxpB/KLnfcZwwJpATFYbHj50JP6qwCquHLoReBuMEkNn0B9TUwtJgbrrXXU
 olY1xsA2QitqEao8kEv3sVWX00BaN+qeNV8MaEePf+ZW7aGwCqL3QGvM9cUNCJbrgMnP
 giQ9mnM2tJcxKyhQa5Nbk/yDDrZBodfftIQRGdGfrEURXwzWdf04SzAkV/9yMmpG+YEZ
 pmW+/SRU51Ckpwxa6INV/0mN1vpGWVEkEyDEk2bPZ9Ybri0sFK0WMw8p25oFwIKPXvi9
 Tvt52u2/KIANRDkLywIeGCrBl79AXtZJUtT7nJdSlzhk4tCwcAZAINCjFgjC7/qzUMK5
 R7Eg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTtOh8p4xWbvTcPfGc0sgv1dIN59pmCP+UDpqunBktI2N7n58xDtwdC6XtFcYtoeHdzZjDuA0kM00D@nongnu.org
X-Gm-Message-State: AOJu0YzGz5QK4NHuJlE48brlf2KTzdSKTOvkICwP95RD7vcRtX4fDFFj
 lAlavWdzjq6DeGSH9KEcWPjaFI6RkbQA5wWMoaHFT9emAEFuFklQBIF2FqZ+M2pL21uPQBasc5e
 R64q2riXV4dInp3ih+h/KIjNw5nH0tLEhK+z4fmQcPpuPpl4zibKfy6ZD
X-Gm-Gg: AfdE7cmM9gC4jToaxi4K1eUX11YCwzdWrwW6/COHQ85wVn6jkE4Xfv3e+Z1wk2VmOfZ
 nOWJxVC6zr3raOevr20lBWtccRgM3r+RZwjNJmAUYFJBO7mWD4HxjkPnjOPOKxvD/IjFt9N83AN
 9uAJGsANoABmWJVSqBqHHaNECRAKOPfIxQCRpQqHp+yV+eM66zL+DbaFDwLPCPaJoAfJHV+OwOe
 ctj+/fZAltL9FPIvuYku8BGTFukNuh5P2SRHiKjJX1lctkfdVQUCjZYqd1AQlJ+q0qJoprGx4gu
 acF92VHGcTKJ0PACoC213j5TuGyVZ8CQ/JeJ0xq1p+z6U/b82t9UoWgUxZOsjnnDFzU4
X-Received: by 2002:a05:620a:4455:b0:92e:4dd2:bb24 with SMTP id
 af79cd13be357-93086a867e5mr1292016685a.39.1784231776453; 
 Thu, 16 Jul 2026 12:56:16 -0700 (PDT)
X-Received: by 2002:a05:620a:4455:b0:92e:4dd2:bb24 with SMTP id
 af79cd13be357-93086a867e5mr1292011785a.39.1784231775730; 
 Thu, 16 Jul 2026 12:56:15 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5b8ea22sm2013726185a.15.2026.07.16.12.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 12:56:15 -0700 (PDT)
Date: Thu, 16 Jul 2026 15:56:03 -0400
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
Message-ID: <alk3U6P_W0z-XNF1@x1.local>
References: <20260707105927.2776822-1-berrange@redhat.com>
 <CAMxuvazpNiy8iqu76wJwiF3aKEizjgZaQFgF3gtHDXqiGh9Fsw@mail.gmail.com>
 <ak0q0vOeFVJsDBcL@redhat.com> <87jyqv3u32.fsf@suse.de>
 <alj7gF_ayHO7Dvb7@x1.local> <87cxwm4vkc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cxwm4vkc.fsf@suse.de>
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

On Thu, Jul 16, 2026 at 03:51:31PM -0300, Fabiano Rosas wrote:
> > I wonder if we can simply above 5 points into something simpler, or skip
> > for now?  To me, what is out of scope is more valuable to be put into doc,
> > because I bet 99% if not all of existing "security issues" on migration in
> > past few months fall into it.. so it saves huge time already for triaging.
> 
> I want to reduce the guesswork both when reporting issues and when
> triaging. People tend to sit around and imagine infinite scenarios, it's
> not productive.
> 
> This section is so we can point at it and ask for some indication of any
> of the points above. Otherwise we'll get the random bug report saying
> that weird behavior was achieved, therefore CVE. These are the
> situations I could think of that would obviously be worthy of further
> consideration.
> 
> Could you expand on why you think this is not worth having? I don't
> think I understand it.

I didn't expect to point to a bug report into "IN SCOPE" category.  IMHO,
the major use case for the doc is to point a bug report into "OUT OF SCOPE"
category.. then we can easily justify an issue to be not a CVE candidate.

When it is a real security issue, we likely need to evaluate it case by
case, but first it needs to not directly fall int OUT OF SCOPE first.

I think it could be that I hardly have any real experience with a legit
security report versus migration yet, but we have richer experience on
"what we don't think is a security issue, but only a bug" thanks to AI.. so
NOT IN SCOPE is easier to list to me than IN SCOPE ones.

Neither do I have very clear idea after reading the five examples given.

To make it clearer on what I meant, I can start by asking some questions on
the five examples listed IN SCOPE.  You don't need to answer all, or
maybe.. no need to answer any of them, just to show my confusions on
reading the examples (hence the request of simplifications, or removal, at
first version).

> 1) Privilege escalation from the guest operating system into the
> destination QEMU process or host.

Do you mean any form of guest operation to cause privilege escalation?
Obviously, it must be about during a live migration happening, otherwise I
don't see how it is relevant to migration, but then is this only talking
about a postcopy use case (where dest QEMU has vCPU running)?  After all,
precopy migration guest operations all done on source, so if there's any
privilege escalation, it needs to happen on source host first.

Also, I am a bit lost on why this is special for migration.  Such issue can
happen on any host without migration.  It's a bit unclear to me.

> 
> 2) Tampering or exfiltration of migration stream data by a third party
> at a lower privilege level than either QEMU processes involved in the
> migration.

If we have the ASSUMPTION describing migration stream is secure, why do we
worry about third party hijacking migration stream?  Someone already
breached?

> 
> 3) Termination of the source QEMU process by source virtual machine
> guest userspace, including by forcing host OS resource constraints to
> be reached.

This is also not clear on how it correlates to migration, because IIUC this
can also happen without migration.  Maybe it's trying to catch the cases
where it only can be attacked during migration?

What is "guest userspace"?  Is that the userspace of the guest OS?

> 
> 4) Other tampering or exfiltration of data from the source QEMU process
> if reached from migration code or migration stream manipulation.

This is a very generic statement to me, even though I think it's correct..
Say, how stream can be manipulated with TLS encryption?  If it's
manipulated from the guest, is the guest data being tampered on its own or
some other data?

> 
> 5) Causing source QEMU process to enter a state from which migration is
> not possible permanently.

This is a very valid one and clear to understand.  However I don't know if
any of such would really happen, though.  It's easier to happen to me when
e.g. we leaked memory in QMP handlers which may cause DoS rather than
"cannot migrate anymore"..

Also, if it's only the VM itself got affected (say, attacker from guest
within causing its VM not migratable), then the damage it can cause is very
limited too.  I'm not 100% sure I know how severe is such, and whether it's
CVE.

-- 
Peter Xu


