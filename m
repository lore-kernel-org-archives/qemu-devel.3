Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8D0E6B244
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 11:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6q51-0003di-V9; Fri, 01 Nov 2024 07:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6q4z-0003dL-UX
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 07:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6q4y-0008Cr-5o
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 07:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730461474;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MTK4C9nmCxwBGAHkMDGqC3aldRiSRLsySsQ9Gf4cIBY=;
 b=bbL0grzq/oFPwoJiQKEyGXjfFO0ZstFDuOWmLKddF3pjpgxzfP6CsAPNXVXOCLGnnCMkTZ
 Z9uQuPiXifZ/Mar8o76a5lUP5O93yxEdQrXotsxYK4Q1SND8AxGezYJWArXCDJUNhk99To
 KSr78qu35QkERERWsKtLeEurUlyfr4o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-3p9rQNlbP12dCew3q-mUCA-1; Fri,
 01 Nov 2024 07:44:30 -0400
X-MC-Unique: 3p9rQNlbP12dCew3q-mUCA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C357119560A7; Fri,  1 Nov 2024 11:44:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.145])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC3EC1956086; Fri,  1 Nov 2024 11:44:23 +0000 (UTC)
Date: Fri, 1 Nov 2024 11:44:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 2/3] qdev-properties: Add
 DEFINE_PROP_ON_OFF_AUTO_BIT64()
Message-ID: <ZyS_FHG1WDncSidt@redhat.com>
References: <20241022-virtio-v2-0-b2394236e053@daynix.com>
 <20241022-virtio-v2-2-b2394236e053@daynix.com>
 <Zx_AuOl7l5b2UIjG@redhat.com>
 <fcff076c-5616-46f3-aaa1-45d3ad1bbb44@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcff076c-5616-46f3-aaa1-45d3ad1bbb44@daynix.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 31, 2024 at 04:21:53PM +0900, Akihiko Odaki wrote:
> On 2024/10/29 1:50, Daniel P. Berrangé wrote:
> > On Tue, Oct 22, 2024 at 01:50:39PM +0900, Akihiko Odaki wrote:
> > > DEFINE_PROP_ON_OFF_AUTO_BIT64() corresponds to DEFINE_PROP_ON_OFF_AUTO()
> > > as DEFINE_PROP_BIT64() corresponds to DEFINE_PROP_BOOL(). The difference
> > > is that DEFINE_PROP_ON_OFF_AUTO_BIT64() exposes OnOffAuto instead of
> > > bool.
> > 
> > Again, same feedback as last time.
> > 
> > With this design, existing users of DEFINE_PROP_BIT64 that
> > get converted to DEFINE_PROP_ON_OFF_AUTO_BIT64, in addition
> > to gaining the desired "auto" value, also gain redundant
> > 'on' and 'off' values as side-effects.
> > 
> > In the next patch, the stated problem is that virtio code
> > needs to distinguish between bits that are user set, and
> > bits that are set based on available host backend features.
> > 
> > That doesn't seem to require us to accept any new values
> > from the user. It should be sufficient to track user
> > specified features, separately from user specified values.
> > ie when parsing user input for bitfields, we need to parse
> > into a pair of fields
> > 
> >    uint64_t has_user_features;  /* which bits were specified */
> >    uint64_t user_features;      /* values of specified bits*/
> 
> Properties also have getters. We don't know what to return with them without
> the new value.

The virtio changes in the next patch are just accessing the bitsets
directly. A getter could just be made to return false for unset
values, on the assumption that any caller should be checking the
has_user_features bits beforehand.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


