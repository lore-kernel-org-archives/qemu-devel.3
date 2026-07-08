Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C050C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 08:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whNM1-00047v-2k; Wed, 08 Jul 2026 04:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whNLu-00047W-T7
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 04:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whNLs-0002gR-1Z
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 04:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783498190;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0TB7DFqel2rPM5dpQalW14jchk3pumPA/dLu8HfST0A=;
 b=JBlvAyOUf/XL7S0XPQDwpo7w/UsaMbZMypzaBXnhvkmEDeGtpvJzvjDXLnkDsinyU7HeyS
 VBnHXytYfYWNFHTPVQJLLaVV8rmVNA7Hra1RzuqkQdGg0a5UgiW6AR98e4OA5+AaeqD3Op
 Har6kgEbj+sgQeV4HrbDYQTlkBvnVUE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-Yy9gGY1tOY2G3ByehRQtug-1; Wed,
 08 Jul 2026 04:09:48 -0400
X-MC-Unique: Yy9gGY1tOY2G3ByehRQtug-1
X-Mimecast-MFC-AGG-ID: Yy9gGY1tOY2G3ByehRQtug_1783498187
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40B8E18052E3; Wed,  8 Jul 2026 08:09:47 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.28])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22D3B1955F43; Wed,  8 Jul 2026 08:09:45 +0000 (UTC)
Date: Wed, 8 Jul 2026 09:09:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anatol Belski <anbelski@linux.microsoft.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC] virtio-villain: Guest fault injection for VMM robustness
Message-ID: <ak4Fxt989xkWfgwD@redhat.com>
References: <98dd26094403c204c7c2f0270d96b9c75842c7d8.camel@linux.microsoft.com>
 <aktl-ojkXVZ4Jira@redhat.com>
 <a2a7bb2e20d954689a638b8a27b7fb95de156667.camel@linux.microsoft.com>
 <akzXblNvD5s4QGgB@redhat.com>
 <861020196095d6d91a83b878a1ed744b2824d159.camel@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <861020196095d6d91a83b878a1ed744b2824d159.camel@linux.microsoft.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 07, 2026 at 11:09:12PM +0200, Anatol Belski wrote:
> On Tue, 2026-07-07 at 11:39 +0100, Daniel P. Berrangé wrote:
> 
> > We appreciate the intent not to flood projects ! Feel free to
> > drip-feed issues to us, a handful at a time though over days
> > or weeks if there will be alot to process.
> > 
> > We recently switched our security disclosure process over to using
> > our regular GitLab issue tracker, so would prefer any bugs to be
> > filed there, rather than emailing people directly:
> > 
> >   https://www.qemu.org/contribute/security-process/
> 
> Perfect, that makes it easy. I will file on the GitLab tracker and
> send them in small batches over the next couple of weeks rather than
> all at once. For the ones with a host side impact, a guest triggered
> hang or use after free, I will tick the confidential box and let
> triage decide whether it stays that way.
> 
> 
> > We also have tests/functional/ in QEMU where we boot real guest OS
> > disk images and/or kernel/initrd pairs. The minimal initramfs
> > approach would probably fit in nicely with that, and indeed I have
> > long wanted us to replace some of our full-fat disk images with
> > minimal self contained initramfs images to speed up smoke testing.
> 
> That sounds like a clean fit. The harness already boots a kernel plus
> a tiny initramfs with a single static init and no full OS, so it
> should slot into tests/functional/ with little friction. Each test
> finishes in under a second when passing, since there is no full VM
> boot involved, which makes it suitable for smoke testing too. Would
> it be useful to have these wired in there directly, or is there a
> different shape that would work better for you?

Yes, I think it'd be interesting to try to fit them directly into a
functional test script. I guess having the virtio-villain repo as a
git submodule would probably be the way to go to access the individual
tests to build the initramfs.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


