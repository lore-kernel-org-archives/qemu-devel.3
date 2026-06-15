Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3808CD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ2mt-0004En-1U; Mon, 15 Jun 2026 04:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZ2mq-0004Dm-TS
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZ2mo-0008VD-NL
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 04:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781512513;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iwTJDQ9ivMhJViccX27NLDlwqfHfU1ixgeZ+ookWGt0=;
 b=OCmTZGTSII5QaHqh6jKm43XGTkayrPk5atKxrXJ375vQumQ+d699MXa0Uy4l6gogSA7Z/l
 rSJzasNaLcnUIew69PMpzJ70uf5Si58mBvS85AMCWw/ZCuYUThWo+i2hxemdFE9QZBULrz
 7MLxZk3WvhkmUTKpcvj3SIr1UcJ3LB8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-XJRfNw-MP1SaAdxaDnOGvw-1; Mon,
 15 Jun 2026 04:35:10 -0400
X-MC-Unique: XJRfNw-MP1SaAdxaDnOGvw-1
X-Mimecast-MFC-AGG-ID: XJRfNw-MP1SaAdxaDnOGvw_1781512509
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66CB51956064; Mon, 15 Jun 2026 08:35:08 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.222])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 187A630001A1; Mon, 15 Jun 2026 08:35:02 +0000 (UTC)
Date: Mon, 15 Jun 2026 09:34:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 2/2] qom: Manage references to embedded child objects
Message-ID: <ai-5M6FF7CoJc_re@redhat.com>
References: <20260615-embedded-v1-0-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <20260615-embedded-v1-2-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <ai-z14dMCK33_pis@redhat.com>
 <CAFEAcA_nFiQyXyCuvwUrJ+-0fhmGoMfswK-+KsZbxahAGatTXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_nFiQyXyCuvwUrJ+-0fhmGoMfswK-+KsZbxahAGatTXw@mail.gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Mon, Jun 15, 2026 at 09:31:36AM +0100, Peter Maydell wrote:
> On Mon, 15 Jun 2026 at 09:13, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > Do we know how many examples we have of embedding objects inside
> > another ?
> 
> It is an extremely common pattern for device and SoC model
> implementations; we've been recommending it for years.
> 
> > I would much prefer if we forbid the embedding of objects. It is
> > horrible design practice to have some QOM objects which can be
> > freed via reference count and some which cannot.
> 
> That would be a very large amount of code to rewrite to the
> new paradigm. I don't object inherently ("you have pointers to
> your child objects" works better when they might be implemented
> in Rust and might play better with being able to create
> machines and wire them up on the command line); I'm just
> noting how much work it would be if you wanted to make
> embedding forbidden.

Would it be a more tractable problem to "fix" object structure only
incrementally as they gain a need to be managed/reference from
Rust code, or does the Rust usage already implicitly extend too
broadly 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


