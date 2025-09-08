Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E78CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf4X-0002mn-Ji; Mon, 08 Sep 2025 12:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvf4R-0002ZF-SH
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:50:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uvf4J-0001BU-DM
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350211;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5rh5fHfwO5asFin0dwWrFjZ61l+paqghd1bpf+BKkSA=;
 b=XEDTPkJ7ascqMhHlc8ACmX9HDW235OBv+jbyKMqMTG4rLByqAOzuL5KvJAVKvwhRdr7/Us
 3VJmIVNdjfmDIB3nu6SyeX1T0h3VhD+pwNR1Vo1xqzs4sklsW2Yelr4uK7ishIGW9SY2Nf
 cfDaj/BmP2xM1WCpko5i45FgFMAQDrc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-xv5lSacZO-SSszYaEtKIcw-1; Mon,
 08 Sep 2025 12:50:08 -0400
X-MC-Unique: xv5lSacZO-SSszYaEtKIcw-1
X-Mimecast-MFC-AGG-ID: xv5lSacZO-SSszYaEtKIcw_1757350207
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D49A19560B5; Mon,  8 Sep 2025 16:50:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.93])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E1C819540EE; Mon,  8 Sep 2025 16:50:04 +0000 (UTC)
Date: Mon, 8 Sep 2025 17:50:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 08/18] python: backport 'make require() preserve
 async-ness'
Message-ID: <aL8JOTBAuLNfq-OQ@redhat.com>
References: <20250903051125.3020805-1-jsnow@redhat.com>
 <20250903051125.3020805-9-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250903051125.3020805-9-jsnow@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 03, 2025 at 01:11:14AM -0400, John Snow wrote:
> This is not strictly needed functionality-wise, but doing this allows
> sphinx to see which decorated methods are async. Without this, sphinx
> misses the "async" classifier on generated docs, which ... for an async
> library, isn't great.
> 
> It does make an already gnarly function even gnarlier, though.
> 
> So, what's going on here?
> 
> A synchronous function (like require() before this patch) can return a
> coroutine that can be awaited on, for example:
> 
>   def some_func():
>       return asyncio.task(asyncio.sleep(5))
> 
>   async def some_async_func():
>       await some_func()
> 
> However, this function is not considered to be an "async" function in
> the eyes of the abstract syntax tree. Specifically,
> some_func.__code__.co_flags will not be set with CO_COROUTINE.
> 
> The interpreter uses this flag to know if it's legal to use "await" from
> within the body of the function. Since this function is just wrapping
> another function, it doesn't matter much for the decorator, but sphinx
> uses the stdlib inspect.iscoroutinefunction() to determine when to add
> the "async" prefix in generated output. This function uses the presence
> of CO_COROUTINE.
> 
> So, in order to preserve the "async" flag for docs, the require()
> decorator needs to differentiate based on whether it is decorating a
> sync or async function and use a different wrapping mechanism
> accordingly.
> 
> Phew.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> cherry picked from commit 40aa9699d619849f528032aa456dd061a4afa957
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/qmp/protocol.py | 53 ++++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 21 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


