Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD836C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 16:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sezMj-0006x6-Bk; Fri, 16 Aug 2024 11:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sezMi-0006wS-Es
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sezMg-0005Kh-Ji
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723823984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cY7E8nDPEJJ/mztgi68VVEACWdl3qH90cN/qlqMvRek=;
 b=PxbRBhg7/KWCojPeS2Swk+JcNYO6JeV9kXZA0MYnyv2YT3s3SGTcS4BAHoX1KE12dsthMd
 JCXT4NlkWeBESR7XWNxhzBWA4tDmWHE3VnXz5hgswLEvVjU9z/WVBuvOb2g8htCf5ynccc
 gw9zrXK76hKA+PO6I9PxAFz2vESYBe8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-lFySx7NJPmynbaMt8kLzYg-1; Fri, 16 Aug 2024 11:59:42 -0400
X-MC-Unique: lFySx7NJPmynbaMt8kLzYg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6bba0f9d3efso4265706d6.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 08:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723823982; x=1724428782;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cY7E8nDPEJJ/mztgi68VVEACWdl3qH90cN/qlqMvRek=;
 b=nynpyvJeGPu6Q/oqPI/qeSoXZiZq3JoQDYXJyDAjNoQ6UT5uxCkIVBeoG8QV++C9yv
 0GKE9zIvnezz7WZPLX3uyYRwkoUJtBeJdZ1s57vm8P8hKxUUvxFXTt/ggPSqQogx7QSH
 eDTdf+zKunOG2SHi3sBgLOiUVWXi27dk9NDaUsIyEF5D9y+F/QG9Ahte/OaQy1c+r+dj
 e2ArOfk9e1mj+2E4si/VMcM2JeL0jrTxi4DZFVYrAB6GQFkdIIId4/XnNXSru8xCmLiw
 9ODUz/Nuk8G9Cr5+M/8nSCMWfdUCzHpTfhs6Ye/8WBxDI0KHUff7yzj2Eb/omRRREesN
 UT7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxhc0bu+qKk/uIX+amf343RKxAqnA+ewgtHsWbHdBZt72+Vom79nH8uh9MzCYm8fg2XoBDhgC4Ycpt@nongnu.org
X-Gm-Message-State: AOJu0YzT3CwdujqVEnTFhK/0mC3ve6jE97Z2eEkDzdlEDiqA/AGVoADV
 ziPVe6YsrEYnEvoc/lMk6c748BSd2gvFm7ezNeODxZqsWkjffA9Sd4dj2wF5Y9gau7Z/emneosB
 Xrptltd+Pi8s34u4o/TtxChkEPGdCFiI0W5c4IRvMI/Sx0wDBMlAl
X-Received: by 2002:a05:6214:2a83:b0:6bf:6ef5:4160 with SMTP id
 6a1803df08f44-6bf7cc8e5e0mr20814966d6.0.1723823982287; 
 Fri, 16 Aug 2024 08:59:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4djCgR3SmyNt4MGftRC+Zs5l7E4bxHqdVMNSJnDqNv3eyALCp/fCmHHC1VbGdlUhfbAX7jw==
X-Received: by 2002:a05:6214:2a83:b0:6bf:6ef5:4160 with SMTP id
 6a1803df08f44-6bf7cc8e5e0mr20814846d6.0.1723823981858; 
 Fri, 16 Aug 2024 08:59:41 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6fe11bd9sm18919786d6.52.2024.08.16.08.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 08:59:41 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:59:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 0/6] Live update: cpr-transfer
Message-ID: <Zr93bOr1zrSZadf5@x1n>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <Zpk2bfjS1Wu2QbcO@x1n>
 <90a01b2b-6a72-475f-9232-3af73d1618cf@oracle.com>
 <Zr5lC9ryCsn9FjE2@x1n>
 <94478262-034d-48db-bd4d-c74ca3c315a6@oracle.com>
 <Zr9u1YV4m9Uzvj7Z@x1n> <Zr9yGoXBpHIzrDak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zr9yGoXBpHIzrDak@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
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

On Fri, Aug 16, 2024 at 04:36:58PM +0100, Daniel P. Berrangé wrote:
> On Fri, Aug 16, 2024 at 11:23:01AM -0400, Peter Xu wrote:
> > On Fri, Aug 16, 2024 at 11:13:36AM -0400, Steven Sistare wrote:
> > > On 8/15/2024 4:28 PM, Peter Xu wrote:
> > > > On Sat, Jul 20, 2024 at 04:07:50PM -0400, Steven Sistare wrote:
> > > > > > > The new user-visible interfaces are:
> > > > > > >     * cpr-transfer (MigMode migration parameter)
> > > > > > >     * cpr-uri (migration parameter)
> > > > > > 
> > > > > > I wonder whether this parameter can be avoided already, maybe we can let
> > > > > > cpr-transfer depend on unix socket in -incoming, then integrate fd sharing
> > > > > > in the same channel?
> > > > > 
> > > > > You saw the answer in another thread, but I repeat it here for others benefit:
> > > > > 
> > > > >    "CPR state cannot be sent over the normal migration channel, because devices
> > > > >     and backends are created prior to reading the channel, so this mode sends
> > > > >     CPR state over a second migration channel that is not visible to the user.
> > > > >     New QEMU reads the second channel prior to creating devices or backends."
> > > > 
> > > > Today when looking again, I wonder about the other way round: can we make
> > > > the new parameter called "-incoming-cpr", working exactly the same as
> > > > "cpr-uri" qemu cmdline, but then after cpr is loaded it'll be automatically
> > > > be reused for migration incoming ports?
> > > > 
> > > > After all, cpr needs to happen already with unix sockets.  Having separate
> > > > cmdline options grants user to make the other one to be non-unix, but that
> > > > doesn't seem to buy us anything.. then it seems easier to always reuse it,
> > > > and restrict cpr-transfer to only work with unix sockets for incoming too?
> > > 
> > > This idea also occurred to me, but I dislike the loss of flexibility for
> > > the incoming socket type.  The exec URI in particular can do anything, and
> > > we would be eliminating it.
> > 
> > Ah, I would be guessing that if Juan is still around then exec URI should
> > already been marked deprecated and prone to removal soon.. while I tend to
> > agree that exec does introduce some complexity meanwhile iiuc nobody uses
> > that in production systems.
> > 
> > What's the exec use case you're picturing?  Would that mostly for debugging
> > purpose, and would that be easily replaceable with another tunnelling like
> > "ncat" or so?
> 
> Conceptually "exec:" is a nice thing, but from a practical POV it
> introduces difficulties for QEMU. QEMU doesn't know if the exec'd
> command will provide a unidirectional channel or bidirectional
> channel, so has to assume the worst - unidirectional. It also can't
> know if it is safe to run the exec multiple times, or is only valid
> to run it once - so afgai nhas to assume once only.
> 
> We could fix those by adding further flags in the migration address
> to indicate if its bi-directional & multi-channel safe.
> 
> Technically "exec" is obsolete given "fd", but then that applies to
> literally all protocols. Implementing them in QEMU is a more user
> friendly thing.
> 
> Exec was more compelling when QEMU's other protocols were less
> mature, lacking TLS for example, but I still find it interesting
> as a facility.

Right, it's an interesting idea on its own.  It's just that when QEMU grows
into not only a tool anymore it adds burden on top as you discussed, in
which case we consider dropping things as wins (and we already started
doing so at least in migration, but iiuc it's not limited to migration).

Again, it looks reasonable to drop because I think it's too easy to tool-up
the same "exec:" function with ncat or similar things.  E.g. kubevirt does
TLS even today without qemu's TLS, and AFAIU that's based on unix sockets
not exec, and it tunnels to the daemon for TLS encryption (which is prone
of removal, though).  So even that is not leveraged as we thought.

Thanks,

-- 
Peter Xu


