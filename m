Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06A7C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 15:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiEgb-0006tN-0e; Wed, 12 Feb 2025 10:30:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiEgY-0006rf-S5
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:29:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tiEgX-0003Ie-6k
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 10:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739374195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FIvkKst6NSBbzxr1gfOZM78qN3yVkmtFOMIkYq5oqLo=;
 b=QIyvZvlGpHSltlz0KAlSUK5X0uq7189kBD+RnY9160CtAg40rD0CoM33HY8Sq7Xdt7Tlvx
 s2mcXWwXr3RVu8FogQ0dIP3cH95Z1artHbDbaEiKJBsLsczkZlC9LWjgdU9dB3MnTZQUJ+
 rzQqsvC/P1IguStam6E2XefLuX4SctI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-QhrWZWcsMXGMJobiG5TBXg-1; Wed,
 12 Feb 2025 10:29:54 -0500
X-MC-Unique: QhrWZWcsMXGMJobiG5TBXg-1
X-Mimecast-MFC-AGG-ID: QhrWZWcsMXGMJobiG5TBXg_1739374193
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4B1819560B1; Wed, 12 Feb 2025 15:29:52 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.168])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2C3D180056F; Wed, 12 Feb 2025 15:29:50 +0000 (UTC)
Date: Wed, 12 Feb 2025 16:29:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 01/11] rust: Build separate qemu_api_tools and
 qemu_api_system
Message-ID: <Z6y-bBK4ZAAcPhFm@redhat.com>
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-2-kwolf@redhat.com>
 <1bcb9de2-5932-4c24-958d-7a86cfcea70e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bcb9de2-5932-4c24-958d-7a86cfcea70e@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Am 12.02.2025 um 11:01 hat Paolo Bonzini geschrieben:
> On 2/11/25 22:43, Kevin Wolf wrote:
> > The existing qemu_api library can't be linked into tools because it
> > contains a few bindings for things that only exist in the system
> > emulator.
> > 
> > This adds a new "system" feature to the qemu_api crate that enables the
> > system emulator parts in it, and build the crate twice: qemu_api_tools
> > is the core library that can be linked into tools, and qemu_api_system
> > is the full one for the system emulator.
> 
> As discussed on IRC, the issue here is ClassInitImpl<>, which has to be
> defined in the same crate for qemu_api::qom and qemu_api::qdev.
> 
> Right now, the block layer has no use for QOM, but later it will (for secret
> management, for example), so splitting QOM into a separate crate does not
> work long term.
> 
> I'll try to figure out an alternative way to do the class_init bindings.

There were more problems with splitting the qemu_api crate related to
bindgen. Basically, you would want the system emulator bindings to
contain only those things that aren't already part of the common
bindings. But the system emulator headers will obviously include common
headers, too, so this becomes tricky.

If you don't do this, you get two bindings for the same type, but the
binding types won't be compatible with each other etc.

This approach of just building two separate libraries was a lot easier.
Apart from the obvious inefficiency, I just hate the need for
rust_dependency_map everywhere to make the library show up with the
neutral 'qemu_api' name in both cases. Maybe there is a better approach
where this could be defined for the library itself rather than for each
user, but I couldn't find one. meson is still black magic to me.

Kevin


