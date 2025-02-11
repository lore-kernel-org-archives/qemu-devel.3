Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4742C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 15:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ths3l-0002I0-6p; Tue, 11 Feb 2025 10:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ths3j-0002HF-8F
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 10:20:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ths3h-00082j-8Z
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 10:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739287217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VZxI4cgSEJolcbBtPngxMid5RD0SmoXjNHYsqUoBDxs=;
 b=OPJvWNFVMOPSeH6kypfcu1IBAFoh0xf4/djCRZbbCtLWkDuUww1zK7CGhe800TkmB47SzP
 yl4NNqgzp4I4GouGjSC4wu7qHB7NoBIH9KK0TgJ+e+F51LJ2RS/ZTOu/gNyJChHXtBmASC
 FV7PeVnMwTeP3XqZI1osHQPcyA0oXxs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-kne4PbDsMleRpbpI-PyXOw-1; Tue, 11 Feb 2025 10:20:16 -0500
X-MC-Unique: kne4PbDsMleRpbpI-PyXOw-1
X-Mimecast-MFC-AGG-ID: kne4PbDsMleRpbpI-PyXOw
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e45d62930aso51808506d6.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 07:20:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739287216; x=1739892016;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VZxI4cgSEJolcbBtPngxMid5RD0SmoXjNHYsqUoBDxs=;
 b=K3utZhs/5aHmBYPeFbjPgmvCbd4lp3McEzMwbeuwNoWtlP9U4qUtQxVa7LUcFBcwSY
 MU/NYY7w7pze20vXpuuTQpzaa5DYUjkvwr+IVsZxhkDLX1kpXHD23tocQ4Ut1c1mzMJn
 zcown286rQLCsfRG6JfMvInRUNNnFK1I7FpUnQaDs2ifeqB4fXXgxvYZMIB9KaO8irjv
 BH8oxM9DsXpAUnJiuEsNzFsgIj90MmhsMKMP3iTcDLkCkK6inAPshZUG/FHxKOFZxSmB
 3YDNdNa/TyssGB3wZ8EstHda42T4To3EGhKX4axOAmwOfmDTMMVbldLaVHPoaywYsET/
 6Izg==
X-Gm-Message-State: AOJu0YzIQ4NwGJqe0ScuP8TYp2X+2MCnppaYeWAFTznytmFqm95s3sBH
 V1x4GHn7L6hPFgYQPA0EOvIkoiWv+1Xze8BDzpCIq61xGK7tGUqgUdguPHJGxzZALbAJ2kM/thQ
 PwTwGOuPp8j2XMTxB7GSTuUC5tWGR0j8mN6GmkpgQCtegCjehPcSf
X-Gm-Gg: ASbGnctpCFR0PyAQOpteqLGaLYDAkT2zv308pvwOkEPNTbk/Jdp71U9FLnpqXfbRJd4
 0AzIYq4qxAMdih1aTaVDVZkPobPPJJFQ7SW3kFbhmo+NfVlEtZVqTmfW3We04fdzlNlTZMNCxxv
 ChQHouM4+lW2eW/XRsbw9VsY/VGr1+OGBfCkPF8JNBb5BdvFMwCWcsXMQYmfuDEGlIUZM5fUbsA
 T/h24oqp6lzSyr/Svwz/eZp4E9LUoUMVlhuPxz18sNtSz+frjgJY5kfIz4=
X-Received: by 2002:a05:6214:5188:b0:6e2:4575:6bd5 with SMTP id
 6a1803df08f44-6e4455e60b9mr250971676d6.12.1739287215761; 
 Tue, 11 Feb 2025 07:20:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuDyJatQLl1XoE+rgo7bgygrYXJAzzE7KlcKEZz+nG250S+0TuOv7iHy419sD11HjiWQqmUw==
X-Received: by 2002:a05:6214:5188:b0:6e2:4575:6bd5 with SMTP id
 6a1803df08f44-6e4455e60b9mr250971436d6.12.1739287215376; 
 Tue, 11 Feb 2025 07:20:15 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e4437ddc85sm54627516d6.87.2025.02.11.07.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 07:20:14 -0800 (PST)
Date: Tue, 11 Feb 2025 10:20:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v5 3/5] migration: enable multifd and postcopy together
Message-ID: <Z6tqq5jpbDHsVtVw@x1.local>
References: <20250205122712.229151-1-ppandit@redhat.com>
 <20250205122712.229151-4-ppandit@redhat.com>
 <Z6VCxEKxn6-_okRx@x1.local>
 <CAE8KmOwJSYq2Ok38_sq29cr7JhbLLh1ZEncP13QpDdnYKOAheQ@mail.gmail.com>
 <Z6YqstgG2bSY45dM@x1.local>
 <CAE8KmOwMTw-m0w+JbFBZ7mn-ZuSNfpk9xbq-_KbLXu7_kDhDVg@mail.gmail.com>
 <Z6owYoktb5nk2yRw@x1.local>
 <CAE8KmOy+C7QzDHJ5hfWg93zSV0ctGYYz30qsQTe-=+iq1vA+fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOy+C7QzDHJ5hfWg93zSV0ctGYYz30qsQTe-=+iq1vA+fQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 11, 2025 at 02:34:07PM +0530, Prasad Pandit wrote:
> On Mon, 10 Feb 2025 at 22:29, Peter Xu <peterx@redhat.com> wrote:
> > Yes, and I suggest a rename or introduce a new helper, per previous reply.
> 
> * Okay, will try it.
> 
> > I didn't follow, sorry - do you mean this patch is correct on dropping the
> > mapped-ram check? I don't yet understand how it can work if without.
> 
> * It goes for channel peek if '!migrate_mapped_ram', ie. when
> mapped_ram is not set. When it is enabled, likely it just falls into
> the multifd channel, like other tls/file channels. I'll see if we have
> to add a check for mapped_ram stream, like tls/file one.
> 
> > I meant tls channels should have these magics too.  Do you mean they're not?
> 
> * Yes. AFAIU, tls/file channels don't send magic values.

Please double check whether TLS will send magics.  AFAICT, they should.

> 
> > No I don't think so.
> > Flushing sending side makes sure send buffer is empty.  It doesn't
> > guarantee recv buffer is empty on the other side.
> 
> * A simple 'flush' operation is not supposed to guarantee reception on
> the destination side. It is just a 'flush' operation. If we want to
> _confirm_ whether the pages sent to the destination are received or
> not, then the destination side should send an 'Acknowledgement' to the
> source side. Is there such a mechanism in place currently?

No.  We need to figure out a way to do that properly, and that's exactly
what I mentioned as one of the core changes we need in this series, which
is still missing.  We may or may not need an ACK message.  Please think
about it.

> 
> > >
> > > * If all multifd pages are sent/written/flushed onto the multifd
> > > channels before postcopy_start() is called, then multifd pages should
> > > not arrive at the destination after postcopy starts IIUC.  If that is
> > > happening, we need a reproducer for such a case. Do we have such a
> > > reproducer?
> >
> > With or without a reproducer, we need to at least justify it in theory.  If
> > it doesn't even work in theory, it's a problem.
> 
> * The theory that both multifd and postcopy channels use the same
> underlying network wire; And in that multifd pages get delayed, but
> postcopy pages don't, is not understandable. There must be something
> else happening in such a case, which a reproducer could help with.

Please consider the case where multifd recv threads may get scheduled out
on dest host during precopy phase, not getting chance to be scheduled until
postcopy already started running on dst, then the recv thread can stumble
upon a page that was sent during precopy.  As long as that can be always
avoided, I think we should be good.

Thanks,

-- 
Peter Xu


