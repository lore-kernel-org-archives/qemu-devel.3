Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77468CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 20:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoSYI-0005GQ-U8; Tue, 19 Aug 2025 16:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uoSYH-0005GC-V3
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uoSYG-0003dp-2h
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 16:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755633802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dv4Dg9FA5OFtLq96UiUOmsTWDn5F8rcYOU6I6FEHV1M=;
 b=ZOqZyG2eWFhw79B+vpjIPjgbT/HhB4zQDSgDKZ+LDPTZTy7wA9fUTIM/5HZ6sGglbsS23r
 9p3xSCWQQR1ISjW0PrCdpP7SPsOjrUMn+ZRX9pL0svaOVxvT43MESCxzy5Y89XnzmPDXAY
 SwL6ouYf2Z6SLFJ40cO53k7X08ag7cs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-pf8SGAPPMsuXLZi7by9VPQ-1; Tue, 19 Aug 2025 16:03:16 -0400
X-MC-Unique: pf8SGAPPMsuXLZi7by9VPQ-1
X-Mimecast-MFC-AGG-ID: pf8SGAPPMsuXLZi7by9VPQ_1755633795
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-70a92827a70so127631466d6.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 13:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755633795; x=1756238595;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dv4Dg9FA5OFtLq96UiUOmsTWDn5F8rcYOU6I6FEHV1M=;
 b=QINV0Oy5RHuIhysT20IhJMj8Z0yV8V2r4TNUcMtPl4J3zFnfgTJ7ecoTcoEfsF6E62
 fMoYCQ89wy+VeN669t6VUkHxLGsrdhrH9MO4HbmYy8F1SYVKTOMygdiK+xgMBs74VUNu
 N6v2Yvn9RnL2wR0aJGk+dNfe/aqQV2sQLNIQfQCYxHy91uuGEks/YeOkXtu5LQ6B7uqQ
 oC0GrpaA8eLYRs93B63F+c+l/GbX7S2wNHdJ2BWRjRzKP3C8Tmip0iXVGqUx1u3Xvpxx
 +TOV6Nx9VcntTYRd8yFch/kS58Ivv7zd5WjZbDYUZ1lOAlgm0TzzRzLmVOmmM3rrBxJ6
 XZWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4hRMPxdcsUEysx3hHnpMHHQlxvSgC7+Yg2mt+0uqR8Tj0OdaJnh6KB7bXzMNHS4oBvaKF9lUyBvFT@nongnu.org
X-Gm-Message-State: AOJu0Yxajkc/uTkM+0ifCGnaBSPrZhh7Lf9HKZvEy8sWOZij60I7mRqC
 UNyQy0JmVcP+0wBQXE3JNpyP61y/XfPuTpy+zb/k7XbErM1Le3dHho7AygTLk6CePMZcEAv+tnb
 f0M51urBomnob7h1cJYS/+cYT8igam4bON9BlPGXahFI9KxA61+9IEehi
X-Gm-Gg: ASbGnct92q6cnO+8PhTBWYgcJ1/hdrJPeO3RlDPorHhUXYBtsudpAipsu5Gsh87MsED
 OKr3C1itTHtA/0YhUYG3pMwhERVnWE99RyxmDBI88pkjWMup6DLQPuZLiqOdCfsYdMely86SOA6
 8eadtNBXrYYwjwS99qZ8rX29/eHAlm3eqlFOzH5J5cy1lZqc7/JRSXCKlVV9Z3F6HSY/XoHKBYH
 hXZr8qsk7UrPr+je4xSIadrXAvdjiAOxYJl/HvVb+eSCypP1dzLa2qwu9w+DdmLREDjAC04Oo9K
 o7QjmS95eq3qJbrDKJm2ax4qEyIxb1rL
X-Received: by 2002:a05:6214:301a:b0:707:ba4:a241 with SMTP id
 6a1803df08f44-70d771224fbmr3223886d6.38.1755633795215; 
 Tue, 19 Aug 2025 13:03:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxbS3x+ES6MNSaTE+UMdM3qHIdNi6XYdd8duVQyj753LCmnpLPrZGGWedmaEYoTbWScc1tQA==
X-Received: by 2002:a05:6214:301a:b0:707:ba4:a241 with SMTP id
 6a1803df08f44-70d771224fbmr3223476d6.38.1755633794794; 
 Tue, 19 Aug 2025 13:03:14 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70bb4cfa8a5sm50765786d6.40.2025.08.19.13.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 13:03:13 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:03:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Lukas Straub <lukasstraub2@web.de>, Fabiano Rosas <farosas@suse.de>,
 Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] multifd: Make the main thread yield periodically to the
 main loop
Message-ID: <aKTYdUW_4j5qFXOx@x1.local>
References: <CAK9dgmZb=5uEwVq65Ygcza0+qtng+-5zmtQRdviX2npg_qhJRQ@mail.gmail.com>
 <20250808090054.13cb8342@penguin>
 <CAK9dgmbybw+WkC2C_qdZnwSYjGn3Q2Du4yjLOz+EmCx1po8YPg@mail.gmail.com>
 <87o6sp2a0i.fsf@suse.de> <aJYZs9NnAOqVMcd1@x1.local>
 <20250811090345.4360fec4@penguin> <878qjq0xtk.fsf@suse.de>
 <aKRSZ7jCfIzvv4jW@redhat.com> <20250819140326.6e94b1c9@penguin>
 <aKRpAP_8qjlNA20A@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKRpAP_8qjlNA20A@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 19, 2025 at 01:07:28PM +0100, Daniel P. Berrangé wrote:
> On Tue, Aug 19, 2025 at 02:03:26PM +0200, Lukas Straub wrote:
> > On Tue, 19 Aug 2025 11:31:03 +0100
> > Daniel P. Berrangé <berrange@redhat.com> wrote:
> > 
> > > On Mon, Aug 11, 2025 at 10:53:11AM -0300, Fabiano Rosas wrote:
> > > > Lukas Straub <lukasstraub2@web.de> writes:
> > > >   
> > > > > On Fri, 8 Aug 2025 11:37:23 -0400
> > > > > Peter Xu <peterx@redhat.com> wrote:
> > > > >> ...
> > > > >> migrate_cancel() should really be an OOB command..  It should be a superset
> > > > >> of yank features, plus anything migration speficic besides yanking the
> > > > >> channels, for example, when migration thread is blocked in PRE_SWITCHOVER.  
> > > > >
> > > > > Hmm, I think the migration code should handle this properly even if the
> > > > > yank command is used. From the POV of migration, it sees that the
> > > > > connection broke with connection reset. That is the same error as if the
> > > > > other side crashes/is killed or a NAT/stateful firewall in between
> > > > > reboots.
> > > > >  
> > > > 
> > > > That should all work just fine. After yank or after a detectable network
> > > > failure. The issue here seems to be that the destination recv is hanging
> > > > indefinitely. I don't think we ever played with socket timeout
> > > > configurations, or even switching to non-blocking during the sync. This
> > > > is actually (AFAIK) the first time we get a hang that's not "just" a
> > > > synchronization issue in the migration code.  
> > > 
> > > Based on the stack trace, whether the socket is blocking or not isn't a
> > > problem - QEMU is stuck in a  sem_wait call that will delay the coroutine,
> > > and thus the thread, indefinitely. IMHO the semaphore usage needs to be
> > > removed in favour of a synchronization mechanism that can integrate with
> > > event loop such that the coroutine does not block.
> > > 
> > 
> > I don't think that is an issue. The semaphore is just there to sync
> > with the multifd threads, which are in turn blocking on recvmsg.
> > 
> > Without multifd the main thread would hang in recvmsg as well in this
> > scenario.
> 
> If it is using blocking I/O that would hang, but that's another thing
> that should not be done.  The QIOChannel code supports using non-blocking
> sockets in a blocking manner by yielding the coroutine.

The thing is multifd feature, as a whole, is done with a thread-based
model.  It doesn't have any other coroutines to yield, AFAIU..

Instead, I do want to make the precopy load on dest QEMU also happen in a
separate thread instead of the main thread at some point.

I did try it once but it isn't trivial.  Unlike savevm, there're quite some
assumptions that the bql will be around when loading the VM.  But maybe I
should keep trying that until we figure out all such spots and see whether
we can still move it out at some point.

If that'll work some day, then multifd sync on dest qemu will by default
happen without BQL.

Thanks,

-- 
Peter Xu


