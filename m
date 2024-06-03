Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16257C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5sS-0006dU-27; Mon, 03 Jun 2024 07:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE5sQ-0006Y6-Db
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:29:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE5sI-0000sN-IW
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717414153;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XpRLLcPKxPeWrQnAe/guP+u11AxHD9u5mJBFCTPDKRc=;
 b=McytJ/wb5DZx6iXhlB4iy3Ht3px7MKaO9GjQrNoGHNpmSfdc4LUJSyPKNzzD8TzE6Bip6f
 C8+NKa9HVF+1YLDUvEmpCqyjKofJNJ2R1ETRtCs2f+xd5YPp73bfbbVgJ50woNORj4TMMK
 /9CIZGnV2XtFBlPwYIix4PmutyJw7l4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-Gl5EuS44MTmIW7yW_aDxEw-1; Mon,
 03 Jun 2024 07:29:10 -0400
X-MC-Unique: Gl5EuS44MTmIW7yW_aDxEw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0F2C3806701;
 Mon,  3 Jun 2024 11:29:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64B931C0D101;
 Mon,  3 Jun 2024 11:29:08 +0000 (UTC)
Date: Mon, 3 Jun 2024 12:29:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: qemu CI & ccache: cache size is too small
Message-ID: <Zl2pAiLgHQWVAYln@redhat.com>
References: <4ccbaa65-41cf-4317-9dfb-2c9ab17296d0@tls.msk.ru>
 <5d4de3b2-a940-44e1-bde9-77e8389fb58c@redhat.com>
 <61ae842e-179e-453a-b109-e8801354b9e4@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61ae842e-179e-453a-b109-e8801354b9e4@tls.msk.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, May 27, 2024 at 02:38:08PM +0300, Michael Tokarev wrote:
> 27.05.2024 14:19, Thomas Huth wrote:
> > On 27/05/2024 12.49, Michael Tokarev wrote:
> > > Hi!
> > > 
> > > Noticed today that a rebuild of basically the same tree (a few commits apart)
> > > in CI result in just 11% hit rate of ccache:
> > > 
> > > https://gitlab.com/mjt0k/qemu/-/jobs/6947445337#L5054
> > 
> > For me, the results look better:
> > 
> >   https://gitlab.com/thuth/qemu/-/jobs/6918599017#L4954
> 
> Yeah, it's a bit better, but still not good enough.
> I dunno how much changes the source had between the two runs.
> It still had 11 cleanups, and the cache size is at the same level.
> (It is an older ccache, too).
> 
> > > while it should be near 100%.  What's interesting in there is:
> > > 
> > > 1) cache size is close to max cache size,
> > > and more important,
> > > 2) cleanups performed 78
> > > 
> > > so it has to remove old entries before it finished the build.
> > 
> > Did you maybe switch between master and stable branches before that run?
> > ... I guess that could have invalidated most of the cached files since
> > we switched from CentOS 8 to 9 recently...?
> 
> Nope, nothing else ran between the two and it was just a few
> source-level commits (stable-8.2 pick ups), without changing
> giltab/containers/etc configuration.
> 
> I increased cache size to 900M and did another test run, here are
> the results: https://gitlab.com/mjt0k/qemu/-/jobs/6947894974#L5054
> 
> cache directory                     /builds/mjt0k/qemu/ccache
> primary config                      /builds/mjt0k/qemu/ccache/ccache.conf
> secondary config      (readonly)    /etc/ccache.conf
> stats updated                       Mon May 27 11:17:44 2024
> stats zeroed                        Mon May 27 11:10:22 2024
> cache hit (direct)                  1862
> cache hit (preprocessed)             274
> cache miss                          1219
> cache hit rate                     63.67 %
> called for link                      285
> called for preprocessing              71
> compiler produced empty output         5
> preprocessor error                     2
> no input file                          6
> cleanups performed                     0
> files in cache                      9948
> cache size                         654.6 MB
> max cache size                     900.0 MB
> 
> This is having in mind that the previous run was with CCACHE_SIZE=500M
> and had multiple cleanups, so 63% is actually more than I'd expect already.

Given your original job had cache of 447 MB, and new cache is 654 MB, the
old cache is 68% of size of the new cache. So effectively your 63% is
high 90's cache hit rate of what was present.

This would suggest a cache size of 700 MB is more appropriate, unless some
other jobs have even high usage needs.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


