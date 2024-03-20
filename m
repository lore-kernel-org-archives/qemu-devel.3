Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C51C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 14:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmwdU-0005iY-Vu; Wed, 20 Mar 2024 10:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmwdT-0005hr-Sb
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:09:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmwdR-0004AQ-Ug
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710943780;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wWC3NPJ5B4V/3836lJ+D7CEtSyOJnNma4teub39CUpQ=;
 b=TTRVhb5nfID+vfFYrDxd9EGdxLVOOdcKRHvQQeNpKm50noq5IS/ceIt8e4msKHs6QIQQeS
 a6SStApPorKZel+CZsuHuc0LipB0Z+VEvVI2POdt9FDsSA7delM6lbJfVXb/ntQ4/aL2P9
 5AziJBCncr958YNrnuiqqzGIIEqQZW8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-yHUTaCpGNYyu5AUjSfGgDg-1; Wed, 20 Mar 2024 10:09:39 -0400
X-MC-Unique: yHUTaCpGNYyu5AUjSfGgDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B301181B7AE
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 14:09:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 482E42022C1D;
 Wed, 20 Mar 2024 14:09:37 +0000 (UTC)
Date: Wed, 20 Mar 2024 14:09:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Sanjay Rao <srao@redhat.com>, Boaz Ben Shabat <bbenshab@redhat.com>,
 Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH] coroutine: cap per-thread local pool size
Message-ID: <ZfruHHh9tEr-1zI6@redhat.com>
References: <20240318183429.1039340-1-stefanha@redhat.com>
 <ZfmWhDaG5mN-GCeO@redhat.com> <20240319175510.GA1127203@fedora>
 <ZfnxSd4lseZuWoQ5@redhat.com> <20240320133539.GA1190824@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320133539.GA1190824@fedora>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 20, 2024 at 09:35:39AM -0400, Stefan Hajnoczi wrote:
> On Tue, Mar 19, 2024 at 08:10:49PM +0000, Daniel P. Berrangé wrote:
> > On Tue, Mar 19, 2024 at 01:55:10PM -0400, Stefan Hajnoczi wrote:
> > > On Tue, Mar 19, 2024 at 01:43:32PM +0000, Daniel P. Berrangé wrote:
> > > > On Mon, Mar 18, 2024 at 02:34:29PM -0400, Stefan Hajnoczi wrote:
> > > > > diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> > > > > index 5fd2dbaf8b..2790959eaf 100644
> > > > > --- a/util/qemu-coroutine.c
> > > > > +++ b/util/qemu-coroutine.c
> > > > 
> > > > > +static unsigned int get_global_pool_hard_max_size(void)
> > > > > +{
> > > > > +#ifdef __linux__
> > > > > +    g_autofree char *contents = NULL;
> > > > > +    int max_map_count;
> > > > > +
> > > > > +    /*
> > > > > +     * Linux processes can have up to max_map_count virtual memory areas
> > > > > +     * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond this limit. We
> > > > > +     * must limit the coroutine pool to a safe size to avoid running out of
> > > > > +     * VMAs.
> > > > > +     */
> > > > > +    if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, NULL,
> > > > > +                            NULL) &&
> > > > > +        qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
> > > > > +        /*
> > > > > +         * This is a conservative upper bound that avoids exceeding
> > > > > +         * max_map_count. Leave half for non-coroutine users like library
> > > > > +         * dependencies, vhost-user, etc. Each coroutine takes up 2 VMAs so
> > > > > +         * halve the amount again.
> > 
> > Leaving half for loaded libraries, etc is quite conservative
> > if max_map_count is the small-ish 64k default.
> > 
> > That reservation could perhaps a fixed number like 5,000 ?
> 
> While I don't want QEMU to abort, once this heuristic is in the code it
> will be scary to make it more optimistic and we may never change it. So
> now is the best time to try 5,000.
> 
> I'll send a follow-up patch that reserves 5,000 mappings. If that turns
> out to be too optimistic we can increase the reservation.

BTW, I suggested 5,000, because I looked at a few QEM processes I have
running on Fedora and saw just under 1,000 lines in /proc/$PID/maps,
of which only a subset is library mappings. So multiplying that x5 felt
like a fairly generous overhead for more complex build configurations.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


