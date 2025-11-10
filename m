Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01464CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIQ4o-00086F-26; Mon, 10 Nov 2025 06:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vIPnJ-0004l7-4M
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:10:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vIPnD-0004JZ-Qh
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762773037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aktDvrJZFWRZUdhpU6PBPhEblVgeorLPMPLU5b2fnG0=;
 b=a21hYyPrGjvnvxlJRRF8UZJ5rU9KiXhtk+l8bhwu/uz561s+9nyCJfvfRxOnd0Ugv2WSNX
 jSnLcIJBp8gB9NfAki2CPTHHD1M9etJfjpk958VwkPhP20edFf3Rr7zuNSchQ4OjTRVqPA
 rP0WmpasJpYkWG4abibtb6jhsgpPrpk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-64MPK9eAOyasw2H9ArjJWA-1; Mon, 10 Nov 2025 06:10:36 -0500
X-MC-Unique: 64MPK9eAOyasw2H9ArjJWA-1
X-Mimecast-MFC-AGG-ID: 64MPK9eAOyasw2H9ArjJWA_1762773035
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-341661973daso3291025a91.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 03:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762773034; x=1763377834; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aktDvrJZFWRZUdhpU6PBPhEblVgeorLPMPLU5b2fnG0=;
 b=EtxXdtp1X5oz3+i2F4Tp+uEfiS00siSmVCbZFOwe23AeSnZB1stUHFZo/pPVmp+uD8
 Ex7XNDurf6QsRgguNAOK3yHOUeTvfo0o0KlPb5sg6aOtqHdFn8vdMhqDasZjx5Fs2/xt
 gcPjBCTcrqbiw8Hgp4X55IyQMWXAPjzZDlQ3/UyWGGdZS1A/2amH7veIExNU2oCTrXiU
 TT/TS60Vck83jcVFI2Z4rM3kh/pokchJSIG0OlLAE898xBbHXrniAlj86HEO+d5wHK7N
 upkew31csg8Z5LAJh7H/I3PIsr1hSJrwiJ36xEjyp7WeSW74/a7Eeoj61FHwOQSEO2YT
 ClQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762773034; x=1763377834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aktDvrJZFWRZUdhpU6PBPhEblVgeorLPMPLU5b2fnG0=;
 b=aEG65YQ8Asg9/8J5wIKPS1LtxNEwKmzV6QDdCOULz0qiMD0tMB8nUMmGh22XTuI42A
 7nspkwMv1+yk7BYc1G9O4U7PyOTMI8TWFV71DevAhp/pxGnwDKhEYiKq+b/dmzt8huC4
 2OO7V3fPEjvNJksA1McrBH3YPkJTu3wBVSDJ/txKIgCmevpvnXtN0TygtToZjD1ELTCt
 pG4FaxLVeZWJtHQgu85sAoviMJ8tvhw37uFzfAwEqW7IZdzbxiNNjsCSQbmDcE7nXiWk
 zHHt1Fd0TSmty1nWsmw6nN6kCq939xm/NOxCWUiZ+lWIb9DWIPwVvmtoLNkl5mPYPYfV
 6ZsA==
X-Gm-Message-State: AOJu0YzIhtww49sD/1kOxNCPOPPfuaaJzD7UkwlspaWbRYF1Ltp0TAb3
 kH0LhxETyKv8mO+dHRWQMYMsPX969ArSm8AIEpfRQAbR70P3lpe3zuzsZK/CzXfmBxE9u8KNFBD
 qKFsFRgRNZ3tJwqBJHeBNvJO1fKp52ZpsgIDajT5nrVHA24RLshYU6HjEv/aOEt5UT4Sqc5spaX
 x4iAcu83f39RJKIChG/U4jyDnTdGhixeN6r3+Y8t1V/g==
X-Gm-Gg: ASbGncvdv6pb0NqHafueo2vNVpe6oUau60jrWe6Jfgc2XL8aD7ydFhIVofPqpJwbaIu
 t8dtIN0rYs3UBmdsAgwkSGNsb7Ur4V5zAtyl2/urC0sCHGTZCNDqaLn0Z8QLAmpL3zgj9SnGsf3
 9kFFolHYoLAPuLYoFzH4wvZ4fCGG1otgqsoMat1ZRU4ppGVNpd0VyJETA=
X-Received: by 2002:a17:90b:3bcb:b0:335:2823:3683 with SMTP id
 98e67ed59e1d1-3436cb89af5mr12362273a91.9.1762773034692; 
 Mon, 10 Nov 2025 03:10:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbUhIBEJL/jxacf792o+sNGSHz6/Sp72KPOVHeMcx04U65//u12mzyLE+Ifms74Ac+zQOotF5ecXz3ZRKHELA=
X-Received: by 2002:a17:90b:3bcb:b0:335:2823:3683 with SMTP id
 98e67ed59e1d1-3436cb89af5mr12362236a91.9.1762773034277; Mon, 10 Nov 2025
 03:10:34 -0800 (PST)
MIME-Version: 1.0
References: <1943ea16-c3cb-4442-be72-5719026ee13a@gmail.com>
 <pkglizwznrfj6fm7tdyew4tzmomgtp2cetxwfj2fx7ge4vtwhv@kdlj2jdxqheo>
 <9535cd2e-239a-4002-be5b-b7c7fa85f081@gmail.com>
In-Reply-To: <9535cd2e-239a-4002-be5b-b7c7fa85f081@gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 10 Nov 2025 12:10:23 +0100
X-Gm-Features: AWmQ_bl62OWWB_LlSDDHjnSUHEc2aFnXOkCl85Gc8krlhWAWuVmcHxuBZvP0fLQ
Message-ID: <CAGxU2F5ag+gfhpCOpT_AQ_41GYhxs7U-tHMadUEN_gTUoeDqRA@mail.gmail.com>
Subject: Re: vsock support for communication between guests
To: Robert Hoo <robert.hoo.linux@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

On Sun, 9 Nov 2025 at 14:13, Robert Hoo <robert.hoo.linux@gmail.com> wrote:
>
> On 11/6/2025 10:32 PM, Stefano Garzarella wrote:
> > On Fri, Oct 10, 2025 at 09:00:21PM +0800, Robert Hoo wrote:
> >> Hi,
> >>
> >> Does vsock support communication between guests?
> >> From man page, and my experiment, seems it doesn't.
> >> But why not?
> >>
> >
> > It depends, vhost-user vsock device, supports it.
> > See
> > https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock#sibling-vm-communication
> >
> > The vhost-vsock in-kernel device doesn't support it.
> >
> > The main problem is that vsock is designed for host<->guest communication, so
> > implementing a guest<->guest communication is possible, but requires more
> > configuration (e.g. some kind of firewall, etc.) and also an extension to the
> > address (see the required
> > `.svm_flags = VMADDR_FLAG_TO_HOST` in the link).
> >
> > The easy way to do that with vhost-vsock, is to use socat in the host to
> > concatenate 2 VMs (some examples here:
> > https://stefano-garzarella.github.io/posts/2021-01-22-socat-vsock/)
> >
> > Cheers,
> > Stefano
> >
> Nice, thanks Stefano. It sounds ideal for my VM <--> VM communication
> requirement. I'll read the doc carefully later.
>
> BTW, I also found your vsock-bridge
> (https://github.com/stefano-garzarella/vsock-bridge); but seems its last commit
> was 5 yrs ago. It's not recommended, is it?
>

Oh, that was just a little exercise I did to learn Rust at the time,
so I'd say no, it's not recommended.
BTW `socat` supports a similar use case, so related to the example in
the vsock-bridge's README, you can do the following:

host$ socat VSOCK-LISTEN:5201 VSOCK-CONNECT:4:5201
vm_cid3$ iperf --vsock -s
vm_cid4$ iperf --vsock -c 2

But yeah, it's not 2 ways like vsock-bridge (i.e. `vm_cid3` can't
connect to `vm_cid4`).

Cheers,
Stefano


