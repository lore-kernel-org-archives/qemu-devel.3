Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105D6C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 14:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWFQX-0000OX-4z; Mon, 30 Jun 2025 10:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1uWFQI-0000Nj-7H
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 10:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbrivio@redhat.com>)
 id 1uWFQC-0008W9-3T
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 10:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751293422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XguLVPas8vLBmV5N6UZJ9WWBP1Z9nTe1Xs0TRWIpjx0=;
 b=HqMQrYArkNpTvs11r1ZerwKaDxufHFV35HrUjvBQHU7pPyJj2fB2nnWTdS9BnShw0gwCmD
 ryAy46S3DosTLIXA+qeEaKtv/zjwdi4Xrg1aM6uIk0ZayuBDktTinOyJBvFNKQ8zI8zG1h
 mcqbkja7EfPu597mHwTGsp5uqy2wYL0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-85c155KLOm-J9RmXfLszXA-1; Mon, 30 Jun 2025 10:22:30 -0400
X-MC-Unique: 85c155KLOm-J9RmXfLszXA-1
X-Mimecast-MFC-AGG-ID: 85c155KLOm-J9RmXfLszXA_1751293350
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4539b44e7b1so9959185e9.1
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 07:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751293349; x=1751898149;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XguLVPas8vLBmV5N6UZJ9WWBP1Z9nTe1Xs0TRWIpjx0=;
 b=ukQwkXdX8vpOZaWrJzd0Y1BSF2Mj0sEK8y8bGjC7+DZ+rEa0mDbyiMdlbETIQiUS6U
 /1btDP4bglIjR9Gs0ppAdJgBoOiFAQc12ozbzL6S3S9EMeslPHDE5h/4mmfVwbUbpTvb
 oV8/qq7fXFL/rbHhgklYEJoFoz6iptKqp1Z9bxQrh4bWyRuc4q2sgepE5j7k+u1xWjhb
 uYm1zBkR+0xxHrkh0UxpQ7YWYk5k+sWU6jQTKhKLgfCywVHDEmpdsZ4RXmsbVzZS3zDu
 ws3joPiiN0o0WdlddioNRhKvMO3cdvUpJqjUou0/GZkvqiISM8LozCL4Gy2K02DlrI5e
 AXOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHzRHKnwNnce62X8Iabe7KW9IdemECs1DBmsHdOSKi2tC+SlVnCM+pcJefbkMdvbFHp38MljjctBaj@nongnu.org
X-Gm-Message-State: AOJu0Yz5k6GWyjdWv855bBq2J6xlZ1dv/e/RSvNWKH+1q2biK+ce7TfX
 ag1ngrP1XnoUHMIa9NrPRPnP6ZWdwX3/r7nCV5V7jZdd9q5Ggb7oVm3hryjFe47maVAL6MXRR9U
 jZuSm/1ppaV7yWyolvT2BZaF8Yi/U2f7ToPtfC6M40hMtwlxhXZzlMww+
X-Gm-Gg: ASbGncvMuywwEQXu9cg6sTduDTPp6IlGbGxnFSyo3JdoEFo/+AmZGhtw0g4ZZdqqaRj
 pNiSqUicv7mtGEr7orGO6w2m4ADxPnvFM9IzapgFp/6mlNMCLL+9czUAOpwmq4pQdpY9d5Rpz4Y
 gX7ucpvwAZb4nzPT+VKRS/uPleCjQjbwhle65hrds0WSGBMxew8BzCumaD6uVnhmilLdvPwZc3c
 4DvtyE7G86Kh64A6/wJx1HWFLuaK5z/wN/4PAfDVOa2AjI6kekZmS+ZDwvsvz4Mvia4mkhlB4Ev
 3z4eBw8EWkXTFNjXv4vcR0f5PXjl0mttfA==
X-Received: by 2002:a05:600c:818d:b0:453:1058:f8aa with SMTP id
 5b1f17b1804b1-4538ee4dad4mr151870585e9.15.1751293349419; 
 Mon, 30 Jun 2025 07:22:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRacDJjYTMOJ54yovmnl2PTcBfIxMreQLw6+1Ud8xa9w3dNSUMFn2j44FHMD9fI8n0Lmwj4Q==
X-Received: by 2002:a05:600c:818d:b0:453:1058:f8aa with SMTP id
 5b1f17b1804b1-4538ee4dad4mr151870145e9.15.1751293348841; 
 Mon, 30 Jun 2025 07:22:28 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud.
 [2a10:fc81:a806:d6a9::1]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453883d81besm149327255e9.38.2025.06.30.07.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 07:22:28 -0700 (PDT)
Date: Mon, 30 Jun 2025 16:22:25 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Markus Armbruster via Devel <devel@lists.libvirt.org>
Cc: Markus Armbruster <armbru@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?=
 Lureau <marcandre.lureau@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?=
 =?UTF-8?B?w6k=?= <philmd@linaro.org>, Stefan Weil <sw@weilnetz.de>, Stefano
 Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin " <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Dr. David Alan Gilbert " <dave@treblig.org>, Eric
 Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 09/10] net: Add passt network backend
Message-ID: <20250630162225.451a7df9@elisabeth>
In-Reply-To: <877c10cnqg.fsf@pond.sub.org>
References: <20250618155718.550968-1-lvivier@redhat.com>
 <20250618155718.550968-10-lvivier@redhat.com>
 <87pletlflp.fsf@pond.sub.org>
 <957e1b39-bb40-4752-9d61-84f2b1ca7aa2@redhat.com>
 <87pleticbb.fsf@pond.sub.org> <aFqUENpgRvcYru6L@redhat.com>
 <3bb6ca25-c691-4a9a-9de3-9db7444c8904@redhat.com>
 <877c10cnqg.fsf@pond.sub.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sbrivio@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, 25 Jun 2025 08:57:27 +0200
Markus Armbruster via Devel <devel@lists.libvirt.org> wrote:

> [...]
>
> Back to the design question how to pass configuration via qemu-system to
> the passt program with this new backend.
> 
> Your patch replicates passt command line options as optional members of
> QAPI type NetDevPasstOptions.  Any passt options not covered are
> inaccessible.
> 
> Or rather inaccessible via QMP / HMP / CLI.  You can still access them
> by pointing @passt to a wrapper script.
> 
> This leads us to a possible alternative: make such a wrapper script the
> *only* way to configure passt.  This is like NetdevTapOptions @script
> and @downscript.  Mind, I'm not telling you it's a good idea, I'm merely
> trying to map the solution space!

I'd prefer this idea to having explicit QEMU support (code) for each
passt option, mostly because a. it's a lot of code and b. passt doesn't
completely guarantee backwards compatibility, only to a reasonable
extent (the general idea is to deprecate options first, then to make
them disappear in a couple of years).

Still, I see three main issues with it:

1. you would still need to distribute an example of a wrapper script,
   and that will eventually get outdated as well

2. it's complicated and somewhat surprising. You would probably need to
   configure different wrapper scripts (or functions in scripts?)
   depending on what guest you're running

3. that would be the usual fun with LSMs. What SELinux label would the
   script have? Should we define a separate AppArmor policy for it? Or
   make it a subprofile...?

> Instead of trying to make NetDevPasstOptions complete (so you need to
> fall back to a wrapper script only when using a version of passt with
> different options), we can limit it to a curated set of options.  We'd
> need to decide which ones :)
> 
> You pointed out yet another alternative: pass through the passt command
> line directly.  Two obvious ways: a single shell command string to be
> passed to system(3), or an array of strings to be passed to execv(3).

...so I'd much prefer this approach (it's actually an alternative I was
suggesting to Laurent in some offline chats earlier). We did the same
in Podman for pasta(1) (same binary as passt(1), different command, for
containers):

  https://github.com/containers/common/blob/2d2b7a488601a3557301420fce6acb58d0898b95/libnetwork/pasta/pasta_linux.go#L172

where you would do, say:

  podman --net=pasta:--pcap,/tmp/pasta.pcap,--no-dhcpv6,...

This one looks simple, the documentation of options is always updated
and maintained as part of passt's documentation, and there's no need to
change anything in QEMU if we introduce new options or deprecate some.

I would use an array of strings (same as it's done for Podman) rather
than a flat argument for system(3), because:

> system(3) is a terrible idea with untrusted input, but this is trusted
> input.

...even if it's trusted input, a single, long argument with quotes is
more error-prone than separate arguments, I think.

> Any other interface ideas?
> 
> Since the backend is for human user convenience: which of these ways
> would be convenient for human users?

As I'm familiar with passt(1) options, passing options through is the
most convenient for me, personally.

I often use passt without libvirt exactly because it's awkward to pass,
say, debugging options (I have to use some horrible /usr/local/bin/passt
wrapper script with a switch case inferring the name of the guest from
the socket path given as argument, and sometimes it's unpractical):

  https://issues.redhat.com/browse/RHEL-52281

and it's especially awkward to help users debugging things this way, so
it would be nice if QEMU could make it convenient, instead.

-- 
Stefano


