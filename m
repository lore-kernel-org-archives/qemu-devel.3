Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11612C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 21:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUZ3F-0000rt-Fe; Thu, 18 Jul 2024 17:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUZ3E-0000rO-ET
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:52:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUZ3C-0002RH-7w
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721339552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xxmRmPggPtfN0+2dsoC+i05xhL7xRFEC3uQVvRcOxeU=;
 b=XOztDX1qGjP2Q04vOE7ysY5/PbqUWBJdktSoDKjjlEpI8AzfmDTXDCEkZIbmpKxYvoNx2x
 nBcs3wFw6jGmGuhXgmc9OP0R8geKPbk5L41OpMyjFeO75AAOQyl9QvBVBOLzzYFlOhh4Pg
 tLqG/N+WWmpLMq1umACCcckLXj6B+bM=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-X1MIE9UkOp2fOg_VuhC1-g-1; Thu, 18 Jul 2024 17:52:29 -0400
X-MC-Unique: X1MIE9UkOp2fOg_VuhC1-g-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-25e40fa42ddso265688fac.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 14:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721339548; x=1721944348;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxmRmPggPtfN0+2dsoC+i05xhL7xRFEC3uQVvRcOxeU=;
 b=dqmzDqyYql8xf57w1mLHq6zFAvSGF9/pbduukrQU8LXR8ukoIUHf0YCzh9Fh7ovocF
 U8UQBhemwNgWceTk9hXEyC7D5q2KBw6eJ8+Lsbefd/BJQ3AGPx7L+HbUkEYWvTheTE6i
 oj2AksDn5A2sdAgU0ICATqpFbjeBuMNYD8zkOL+ulSjrj0wlH8I4SN7Ek8HjQWeXNycA
 tbloBy47LhwZ2Cxuu4cLwPR2+Cn6K0TqBUwZotmOgMFue7iD+RgjLatyNTuw2yk1A9OR
 b+cKbfhAfKkm24hL9jvuxsU5vnC9o34uzgVeqyie33fc1NyFu8j32qQooUNUuwobfZqm
 3LPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtStlvgFjiVhZ/Ctujnlve2xQp6vksGWH5K7rvQ25KOVM/Ux0bskdSbSTsLL29Z2M4QEGpP/1ESLcQb8TH/f8gcYVzH+8=
X-Gm-Message-State: AOJu0YwWCE0IqJUbFeTxf1qhOgEqI25txg7dTD35cPwvI8PleO7XQEPP
 +pM4KrM5lplQgLF4Opx0hE/+ne5tcBxoziB+qJCriQkdOiuWP1egAnPAWz06LwaIMu26Q9djsTP
 ilNpfeaPutZ/rAgNPgLHrWGko8gQYTWE/wLEZxBs/ICH6qBnwhr85
X-Received: by 2002:a05:6870:b14e:b0:260:246e:ba16 with SMTP id
 586e51a60fabf-2610710bfa5mr666376fac.3.1721339548466; 
 Thu, 18 Jul 2024 14:52:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkqX77hM44EWt5LOhVRiUZUUytJuVA2thyHs50BOn0M8PtbL2YIy/CSg2SxB3OisDnKZEwvw==
X-Received: by 2002:a05:6870:b14e:b0:260:246e:ba16 with SMTP id
 586e51a60fabf-2610710bfa5mr666368fac.3.1721339548146; 
 Thu, 18 Jul 2024 14:52:28 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a198fae753sm5880785a.16.2024.07.18.14.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 14:52:27 -0700 (PDT)
Date: Thu, 18 Jul 2024 17:52:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
Message-ID: <ZpmOmXS2G3f_65xK@x1n>
References: <Zn15y693g0AkDbYD@x1n> <877cdtfcsi.fsf@suse.de>
 <Zo7cncqkxB89AUBe@x1n> <87y169dmu3.fsf@suse.de>
 <Zo8DaHbWlrNe3RXL@x1n> <87msmodnly.fsf@suse.de>
 <ZpAEIvbNr-ANuASV@x1n> <87jzhi1odn.fsf@suse.de>
 <ZpmFT9O-UN30i1F1@x1n> <87frs61jcr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87frs61jcr.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Jul 18, 2024 at 06:27:32PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Jul 18, 2024 at 04:39:00PM -0300, Fabiano Rosas wrote:
> >> v2 is ready, but unfortunately this approach doesn't work. When client A
> >> takes the payload, it fills it with it's data, which may include
> >> allocating memory. MultiFDPages_t does that for the offset. This means
> >> we need a round of free/malloc at every packet sent. For every client
> >> and every allocation they decide to do.
> >
> > Shouldn't be a blocker?  E.g. one option is:
> >
> >     /* Allocate both the pages + offset[] */
> >     MultiFDPages_t *pages = g_malloc0(sizeof(MultiFDPages_t) +
> >                                       sizeof(ram_addr_t) * n, 1);
> >     pages->allocated = n;
> >     pages->offset = &pages[1];
> >
> > Or.. we can also make offset[] dynamic size, if that looks less tricky:
> >
> > typedef struct {
> >     /* number of used pages */
> >     uint32_t num;
> >     /* number of normal pages */
> >     uint32_t normal_num;
> >     /* number of allocated pages */
> >     uint32_t allocated;
> >     RAMBlock *block;
> >     /* offset of each page */
> >     ram_addr_t offset[0];
> > } MultiFDPages_t;
> 
> I think you missed the point. If we hold a pointer inside the payload,
> we lose the reference when the other client takes the structure and puts
> its own data there. So we'll need to alloc/free everytime we send a
> packet.

For option 1: when the buffer switch happens, MultiFDPages_t will switch as
a whole, including its offset[], because its offset[] always belong to this
MultiFDPages_t.  So yes, we want to lose that *offset reference together
with MultiFDPages_t here, so the offset[] always belongs to one single
MultiFDPages_t object for its lifetime.

For option 2: I meant MultiFDPages_t will have no offset[] pointer anymore,
but make it part of the struct (MultiFDPages_t.offset[]).  Logically it's
the same as option 1 but maybe slight cleaner.  We just need to make it
sized 0 so as to be dynamic in size.

Hmm.. is it the case?

-- 
Peter Xu


