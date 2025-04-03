Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21682C3601B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 07:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Eu6-0007pA-SS; Thu, 03 Apr 2025 03:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u0Eu4-0007oi-8i
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 03:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u0Eu2-0008DA-Bj
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 03:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743664935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gv/jMIA6EOBogF87Q9opwCsZo1MurwWhqVbNCeVKtZw=;
 b=JzCsbfWFXUpkDxEAX1A1ZWLetJaYCL+1AsCQfkFt8kEBrQLrEo76SN4wHabNyvFTMo0Xu5
 q6CmU9CEu8xcJt2LANeeZfeTryCzft+efWCXOE313iVWNUFDPxGjChdt3AU67R5VaB8ZGt
 HyjjbDGz5+AyZsAsx/4o+O54WqoWta4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-ylG-IJIKOa2S1N6sgKJgvQ-1; Thu, 03 Apr 2025 03:22:13 -0400
X-MC-Unique: ylG-IJIKOa2S1N6sgKJgvQ-1
X-Mimecast-MFC-AGG-ID: ylG-IJIKOa2S1N6sgKJgvQ_1743664932
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-438e180821aso2077435e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 00:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743664931; x=1744269731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gv/jMIA6EOBogF87Q9opwCsZo1MurwWhqVbNCeVKtZw=;
 b=YoKECpizbJXJZCFW2gPHV3r7n+4/WwW0wEFQR0E4hcoR0ORyGZ8/BnC5obhYUZuNJe
 gGmXV1emWWwU83LxWpbq8/oLEnbxzeKK+UVlZ0Mjv4uOevmM6kLP7h36rKhQElW8XnOR
 ANMngd7+V574xDHlMPgRA+SnkToyYsT3jNCJcVEOvh4hqnpVVbOFULRBLRJAbs0BNjd/
 qoeIBcFAs8/Ggv2BJvLOzVes0ep7Gk+FmhNg6Zk4WHtWNsvTq520GNlZOyt0Pu9tVRRe
 NzuKuw9ajr6exhdGBiiJaHXPrwL7X+CG+Z14U88SKYUTLzBlJzm4At1/60ugM4lWOw6F
 Z3/A==
X-Gm-Message-State: AOJu0YwMaAVTYTzlswkLjl8Ya6r4u2ROmpdtXulj6pLuTbuP2AWspgo6
 r9KKQifghjI2f/dWaQgydO2JSrpRqT6AeQcI4/1sz5gwqNd9/ExNu+igTromNk/Qjs0v6v9xkl9
 8K/mkAryPgGpYHEef5dmHhqVnNk5xBPeFEuVZ9Ita7CtZK9XCPwKxeCJnJqcVF/pm+EP0mItf9F
 RK8IdY98lHqikYIDyfswZWSi7PloQqwTqunsVt5Q==
X-Gm-Gg: ASbGncsW/qu1JgCxc6Zkc8akC66SKCpQozGyFYnqo7BdOhOnSPmoeB2Srz76fMABq3T
 yX3ZcQuAQhaqSUWhlKpSLOkJ6PBJflmyUOE7pqxUQoIIWhrknjkN5yBNIXrn5Bsa2/8FEueE1/j
 w=
X-Received: by 2002:a05:600c:1c92:b0:439:91dd:cf9c with SMTP id
 5b1f17b1804b1-43ec13a8451mr14527895e9.10.1743664931554; 
 Thu, 03 Apr 2025 00:22:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG459bPffIbEy9Y9MSLjwhcMTGxsyIUcUfGNIWPphpQlxZH+S4W8XkH1Nyaqu176GgksZ2PtDcwwcEZbCm7J4=
X-Received: by 2002:a05:600c:1c92:b0:439:91dd:cf9c with SMTP id
 5b1f17b1804b1-43ec13a8451mr14527605e9.10.1743664931194; Thu, 03 Apr 2025
 00:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <20250318123846.1370312-8-ppandit@redhat.com>
 <87semtkz32.fsf@suse.de>
In-Reply-To: <87semtkz32.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 3 Apr 2025 12:51:53 +0530
X-Gm-Features: ATxdqUFroqqQcpaXqdITx5V5b1t6BQM2urOpzHJ-F1HQpaaKzypnX3LiL-RdGy8
Message-ID: <CAE8KmOwiFtQHpUWJE9aYcH2e8__nBjD8rp5vnWCd66wjy7e90Q@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] migration/ram: Implement save_postcopy_prepare()
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,

On Mon, 31 Mar 2025 at 20:49, Fabiano Rosas <farosas@suse.de> wrote:
> > +static bool ram_save_postcopy_prepare(QEMUFile *f, void *opaque, Error **errp)
> > +{
> > +    int ret;
> > +
> > +    if (migrate_multifd()) {
> > +        /*
> > +         * When multifd is enabled, source QEMU needs to make sure all the
> > +         * pages queued before postcopy starts to be flushed.
>
> s/to be/have been/
>
> > +         *
> > +         * Meanwhile, the load of these pages must happen before switching
>
> s/Meanwhile,//
>
> > +         * to postcopy.  It's because loading of guest pages (so far) in
> > +         * multifd recv threads is still non-atomic, so the load cannot
> > +         * happen with vCPUs running on destination side.
> > +         *
> > +         * This flush and sync will guarantee those pages loaded _before_
>
> s/loaded/are loaded/
>
> > +         * postcopy starts on destination. The rational is, this happens
>
> s/rational/rationale/
>
> > +         * before VM stops (and before source QEMU sends all the rest of
> > +         * the postcopy messages).  So when the destination QEMU received
> > +         * the postcopy messages, it must have received the sync message on
> > +         * the main channel (either RAM_SAVE_FLAG_MULTIFD_FLUSH, or
> > +         * RAM_SAVE_FLAG_EOS), and such message should have guaranteed all
> > +         * previous guest pages queued in the multifd channels to be
> > +         * completely loaded.
> > +         */

* I'll include the above suggested corrections. I'm thinking it might
help more to have such an explanatory comment at the definition of the
multifd_ram_flush_and_sync() routine. Because looking at that function
it is not clear how 'MULTIFD_SYNC_ALL' is used. It sets the
'->pending_sync' to MULTIFD_SYNC_CALL. And when '->pending_sync' is
set this way, multifd_send_thread() writes 'MULTIFD_FLAG_SYNC' on each
multifd channel. At the destination this 'MULTIFD_FLAG_SYNC' flag is
then used to sync main and multifd_recv threads.

...wdyt?

Thank you.
---
  - Prasad


