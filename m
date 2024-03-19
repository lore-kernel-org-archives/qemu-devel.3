Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81468C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 20:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmfnh-0005R8-Dq; Tue, 19 Mar 2024 16:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmfnf-0005Qb-JP
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmfna-00066U-1V
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710879059;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FIH2thBsdCLtvn9JL/wA1qRuXz3hbuia94rBza8MxDE=;
 b=KRTZAcywd56GTqjZZGpc4nZEkBPWbkNCjPOkjLbdd4YsvKOf1kJMRUHg0ZhWbb1M4AMfqk
 GgRCCFjvIzzKE2G6YqtT8VuQCY5P1YYe78e6T1oVBysbRohoHZJluciBh5mi4ZtiBBgRxT
 UGxW3ZlgmlDYx02aqahjbKDeES6MiE8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-I-3cbx9KN5CpqPWfwUMFkg-1; Tue,
 19 Mar 2024 16:10:57 -0400
X-MC-Unique: I-3cbx9KN5CpqPWfwUMFkg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C0333C0252F
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 20:10:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F574492BC8;
 Tue, 19 Mar 2024 20:10:55 +0000 (UTC)
Date: Tue, 19 Mar 2024 20:10:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Sanjay Rao <srao@redhat.com>, Boaz Ben Shabat <bbenshab@redhat.com>,
 Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH] coroutine: cap per-thread local pool size
Message-ID: <ZfnxSd4lseZuWoQ5@redhat.com>
References: <20240318183429.1039340-1-stefanha@redhat.com>
 <ZfmWhDaG5mN-GCeO@redhat.com> <20240319175510.GA1127203@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319175510.GA1127203@fedora>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Mar 19, 2024 at 01:55:10PM -0400, Stefan Hajnoczi wrote:
> On Tue, Mar 19, 2024 at 01:43:32PM +0000, Daniel P. Berrangé wrote:
> > On Mon, Mar 18, 2024 at 02:34:29PM -0400, Stefan Hajnoczi wrote:
> > > diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> > > index 5fd2dbaf8b..2790959eaf 100644
> > > --- a/util/qemu-coroutine.c
> > > +++ b/util/qemu-coroutine.c
> > 
> > > +static unsigned int get_global_pool_hard_max_size(void)
> > > +{
> > > +#ifdef __linux__
> > > +    g_autofree char *contents = NULL;
> > > +    int max_map_count;
> > > +
> > > +    /*
> > > +     * Linux processes can have up to max_map_count virtual memory areas
> > > +     * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond this limit. We
> > > +     * must limit the coroutine pool to a safe size to avoid running out of
> > > +     * VMAs.
> > > +     */
> > > +    if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, NULL,
> > > +                            NULL) &&
> > > +        qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
> > > +        /*
> > > +         * This is a conservative upper bound that avoids exceeding
> > > +         * max_map_count. Leave half for non-coroutine users like library
> > > +         * dependencies, vhost-user, etc. Each coroutine takes up 2 VMAs so
> > > +         * halve the amount again.

Leaving half for loaded libraries, etc is quite conservative
if max_map_count is the small-ish 64k default.

That reservation could perhaps a fixed number like 5,000 ?

> > > +         */
> > > +        return max_map_count / 4;
> > 
> > That's 256,000 coroutines, which still sounds incredibly large
> > to me.
> 
> Any ideas for tweaking this heuristic?

The awkward thing about this limit is that its hardcoded, and
since it is indeed a "heuristic", we know it is going to be
sub-optimal for some use cases / scenarios.

The worst case upper limit is

   num virtio-blk * num threads * num queues

Reducing the number of devices isn't practical if the guest
genuinely needs that many volumes.

Reducing the threads or queues artificially limits the peak
performance of a single disk handling in isolation, while
other disks are idle, so that's not desirable.

So there's no way to cap the worst case scenario, while
still maximising the single disk performance possibilities.

With large VMs with many CPUs and many disks, it could be
reasonable to not expect a real guest to need to maximise
I/O on every disk at the same time, and thus want to put
some cap there to control worst case resource usage.

It feels like it leans towards being able to control the
coroutine pool limit explicitly, as a CLI option, to override
this default hueristic.

> > > +    }
> > > +#endif
> > > +
> > > +    return UINT_MAX;
> > 
> > Why UINT_MAX as a default ?  If we can't read procfs, we should
> > assume some much smaller sane default IMHO, that corresponds to
> > what current linux default max_map_count would be.
> 
> This line is not Linux-specific. I don't know if other OSes have an
> equivalent to max_map_count.
> 
> I agree with defaulting to 64k-ish on Linux.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


