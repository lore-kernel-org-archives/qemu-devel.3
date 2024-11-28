Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89A8D690EF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 09:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGbIO-0008U4-Pt; Thu, 28 Nov 2024 04:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tGbIL-0008S8-PJ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 04:58:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tGbIK-0001wX-3l
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 04:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732787922;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DaoIDD9DX1ctP9AdyE9jR2hgQzd9SXLuzfpXjWxnP5U=;
 b=Z5DqAJ5vjHncRgTnlv5+DbYMZCg5EZ2dW8PPb40eAQMhbtSMMtc6Di/xd+Yof4zMwrgXQZ
 io5WAG6hgwcBgxfw0yCDY4kRd1QeWXQixWndUQtFO2KhoTEJNIFJlHiMGzyQDJgidoBE/m
 c8JSCa7NJqTjTx4k6cNGNL/gdA6KRcY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-UFAd8rKIM4u8YIDY8pTL8g-1; Thu,
 28 Nov 2024 04:58:38 -0500
X-MC-Unique: UFAd8rKIM4u8YIDY8pTL8g-1
X-Mimecast-MFC-AGG-ID: UFAd8rKIM4u8YIDY8pTL8g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 273A31953971; Thu, 28 Nov 2024 09:58:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8D2B195605A; Thu, 28 Nov 2024 09:58:32 +0000 (UTC)
Date: Thu, 28 Nov 2024 09:58:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Camilla Conte <cconte@redhat.com>
Subject: Re: [PULL 15/42] tests/functional: enable pre-emptive caching of
 assets
Message-ID: <Z0g-xPTSrBHQUVQF@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
 <20240904103923.451847-16-thuth@redhat.com>
 <66bf4784-f1e4-479f-83db-2d4f91c10e48@linaro.org>
 <Z0YF9i2pwBkznkCD@redhat.com>
 <CAFEAcA-ematCTyj0SN2=e3mGHvp0VWjN1GV-Tu5Rkf-V721L1w@mail.gmail.com>
 <8ff5ef91-1a4b-498e-a948-37444d699f94@redhat.com>
 <7c62e46b-26c8-48e7-b8ec-b7478146a8d1@linaro.org>
 <ce5825ff-53f5-4cf9-aa6d-e0d28639e664@redhat.com>
 <90b56207-a602-454f-9d3a-82de83a8f2a8@linaro.org>
 <340ed154-86d8-45da-bc81-5e1ebb8af8f4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <340ed154-86d8-45da-bc81-5e1ebb8af8f4@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Nov 28, 2024 at 10:54:43AM +0100, Thomas Huth wrote:
> On 27/11/2024 19.02, Richard Henderson wrote:
> > On 11/27/24 00:29, Thomas Huth wrote:
> > > On 26/11/2024 23.54, Richard Henderson wrote:
> > > > On 11/26/24 11:52, Thomas Huth wrote:
> > > > > I think we want to continue to maek failing downloads as
> > > > > test failures, otherwise we'll never notice when an asset is
> > > > > not available from the internet anymore (since SKIPs just
> > > > > get ignored).
> > > > 
> > > > I disagree.  Download failures are not rare.
> > > 
> > > That's not what I said / meant. Sure, servers can have hiccups and
> > > downloads can fail, but that's what we have the cache for. So having
> > > a working cache is essential.
> > > 
> > > OTOH, if you simply mark tests as SKIP if the download fail, we'll
> > > likely miss if an asset vanishes completely, since some people
> > > already have it in their cache and the remaining people will likely
> > > just ignore skipped tests.
> > If the cache is populated, we will *not* miss if an asset vanishes,
> > because we won't ever try the URL.
> 
> Well, we'll notice it as soon as people run the tests that don't have the
> asset in their cache yet.

We could make the cache validation logic do a "HEAD" request to
detect if the asset still exists, and fail on 404 even if we have
asset cached. The "HEAD" request should be generally fast given
it only grabs headers, no payload, unless the server is completely
DOSd.

> > If the cache is unpopulated, and the download fails, then we cannot run
> > the test. Indicating FAIL is *useless* because there's nothing that we
> > can do about it, and we also skip additional tests that CI could be
> > running.
> 
> Thinking about it for a little bit longer, I think we might rather want to
> distinguish the different failures that can occur during download. If we get
> a 404 error, it means that the asset has completely vanished and thus the
> test is broken, i.e. that's the case when we want to have a real error, I
> think.
> 
> But if the server is just not responding or gives a 5xx (like 503 or 504)
> server error, the failure is likely just a temporary one and we should skip
> the test instead. Does that sound acceptable to you? If so, I can look into
> creating a patch for this.



> 
>  Thomas
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


