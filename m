Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD36E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 18:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVww6-00040x-H3; Thu, 09 Jan 2025 13:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tVww3-00040V-7h
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:07:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tVww1-0000Ts-GY
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736446027;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=thcdTaMkcBPZiQQBQfOrDiE0LPdRcq2tGrDzgZHBKkk=;
 b=Ke5E5e1Z9Ih9w9VMB+uRXHk9UozL8o8pbPkMaRSCrQNEzhaWVyesIwavray7bq6WIZF8xZ
 eJDXyW4GzTrluM+QFpQSM/YqSlRZyhwY2U1bLnQ+mGieHOkpTeMT16/TXj4KOpyJe7E86D
 fCigu+u3ViqvB/OcUtruF3BIDHhZs/k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-fbTYKwicOdi6c0dZ8WcH1w-1; Thu,
 09 Jan 2025 13:07:04 -0500
X-MC-Unique: fbTYKwicOdi6c0dZ8WcH1w-1
X-Mimecast-MFC-AGG-ID: fbTYKwicOdi6c0dZ8WcH1w
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62C9A1955D90; Thu,  9 Jan 2025 18:07:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.128])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB67C19560AD; Thu,  9 Jan 2025 18:07:01 +0000 (UTC)
Date: Thu, 9 Jan 2025 18:06:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roman Penyaev <r.peniaev@gmail.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, "Bonzini, Paolo" <pbonzini@redhat.com>
Subject: Re: [PATCH v6 6/8] chardev/char-mux: implement backend chardev
 multiplexing
Message-ID: <Z4AQQp_Kes-IRoK3@redhat.com>
References: <20241223132355.1417356-1-r.peniaev@gmail.com>
 <20241223132355.1417356-7-r.peniaev@gmail.com>
 <CAMxuvaxFGXDYpwPfqTUZuBVY4iF_BCm6jwOM=quUBn98hYPt=g@mail.gmail.com>
 <CACZ9PQVe1Axq6Lp_acaQuXpih2hwAU_7jz-NywyYBQ88hxt1og@mail.gmail.com>
 <CAMxuvaxzd41bRxa4=zNMdpe420W-w_GAmOjYJsYTMs1+jqdMdw@mail.gmail.com>
 <CACZ9PQW-RJHvkDzBO1T9YDAPX_6zcEuK3kQAEukybBL0PZEB5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACZ9PQW-RJHvkDzBO1T9YDAPX_6zcEuK3kQAEukybBL0PZEB5g@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 09, 2025 at 01:56:40PM +0100, Roman Penyaev wrote:
> Hi,
> 
> On Tue, Jan 7, 2025 at 3:57 PM Marc-André Lureau
> <marcandre.lureau@redhat.com> wrote:
> > Whether we talk about multiplexing front-end or back-end, the issues
> > are similar. In general, mixing input will create issues. Teeing
> > output is less problematic, except to handle the buffering...
> 
> I understand your concerns. What exact issues do you have in mind?
> Are these issues related to the input buffer handling, so technical issues?
> Or issues with usability?

While the design / impl technically allows for concurrent input to be
sent to the frontend, from multiple backends, in practice I don't think
we need to be particularly concerned about it.

I don't see this as being a way for multiple different users to interact
concurrently. Rather I'd see 1 user of the VM just deciding to switch
from one backend to the other on the fly. IOW, although technically
possible, the user will only be leveraging one at a time to send input.

We very definitely do need all backends to receive output from the guest
concurrently too, as you'd want the historical output context to be
visible on whatever backend you choose to use at any given point in time.

If a user decides to be crazy and send input from multiple backends
concurrently, then they get to keep the mess.

> > > Do you think we need to artificially introduce multiplexing logic to be fully
> > > compliant with multiplexer naming? It's not hard to do, repeating
> > > `mux_proc_byte()` from `mux-fe`. In my use-case, I'll still need to disable
> > > multiplexing in favor of 'mixing', for example with the 'mixer=on' option,
> > > i.e. '-chardev mux-be,mixer=on,...`. Or do you think it should be some
> > > completely different beast, something like mixer chardev?
> >
> > I think it would be saner to have the muxer be selectors: only work
> > with one selected be or fe. Otherwise, we can run into various issues.
> 
> In multiplexing (not mixing) for the use-case that I am describing, there is one
> serious drawback: as soon as you switch the "focus" to another input device
> (for example from vnc to socket chardev), you will not be able to s]witch back
> from the same input console - the input now works on another device. This looks
> strange and does not add convenience to the final user. Perhaps, for a case
> other than console, this would be reasonable, but for console input -
> I would like
> to keep the mixer option: the front-end receives input from both back-ends.

Agreed, I think this is desirable. If you did the exclusive access mode,
it'd complicate things as you now need a way to switch between active
backends, while also reducing the usefulness of it.

The main thing I'm not a fan of here is the naming 'mux-fe', as I think we
should have something distinct from current 'mux', to reduce confusion
when we're talking about it.

How about 'overlay' or 'replicator' ? 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


