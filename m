Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9430AC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whj1C-0003r0-0I; Thu, 09 Jul 2026 03:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whj1A-0003qU-Ej
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 03:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whj18-0000iw-CC
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 03:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783581472;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LLQallOHiCO1CXhrr78OGZA2cYyfA2TiZ1XNl37eVAE=;
 b=QtGYRq/kbprsvMhOIaOIEhBInv9J+ijHIF7Tk6Avk9u+L9JptYIS965s7IyWb7sQyVTNdv
 eVzs2Wq6P2UiKPaDZaBryyLHYP/G46V8H40ctQuqEv8Cfsn4l++w4iSkjDx9oVJTwzzBua
 xGLPd/lVEoVMMpThocGuFKjdVzDnF/4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-mFSSK6TYP_m-y69RZhYQHg-1; Thu,
 09 Jul 2026 03:17:49 -0400
X-MC-Unique: mFSSK6TYP_m-y69RZhYQHg-1
X-Mimecast-MFC-AGG-ID: mFSSK6TYP_m-y69RZhYQHg_1783581468
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3806D195606E; Thu,  9 Jul 2026 07:17:48 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAF881800595; Thu,  9 Jul 2026 07:17:46 +0000 (UTC)
Date: Thu, 9 Jul 2026 08:17:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anatol Belski <anbelski@linux.microsoft.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC] virtio-villain: Guest fault injection for VMM robustness
Message-ID: <ak9LAQDQMIZjWor5@redhat.com>
References: <98dd26094403c204c7c2f0270d96b9c75842c7d8.camel@linux.microsoft.com>
 <aktl-ojkXVZ4Jira@redhat.com>
 <a2a7bb2e20d954689a638b8a27b7fb95de156667.camel@linux.microsoft.com>
 <akzXblNvD5s4QGgB@redhat.com>
 <861020196095d6d91a83b878a1ed744b2824d159.camel@linux.microsoft.com>
 <ak4Fxt989xkWfgwD@redhat.com>
 <068f20b5ff9e0ab58706c0f2260292c9fa63c471.camel@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <068f20b5ff9e0ab58706c0f2260292c9fa63c471.camel@linux.microsoft.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 08, 2026 at 08:25:19PM +0200, Anatol Belski wrote:
> On Wed, 2026-07-08 at 09:09 +0100, Daniel P. Berrangé wrote:
> 
> 
> > Yes, I think it'd be interesting to try to fit them directly into a
> > functional test script. I guess having the virtio-villain repo as a
> > git submodule would probably be the way to go to access the
> > individual
> > tests to build the initramfs.
> 
> A submodule would work. The build is a plain musl-gcc static link
> plus a cpio wrap, so it should integrate without pulling in extra
> dependencies.
> 
> One question on the kernel side. The harness currently uses the
> Cloud Hypervisor prebuilt kernel
> 
> https://github.com/cloud-hypervisor/linux/releases/tag/ch-release-v6.16.9-20260508
> 
> which seems fully sufficient for the goals here. Is there a QEMU
> preferred prebuilt kernel for tests/functional/ that I should use
> instead?

We don't have any stock kernel. Tests refer to any kenrel/initrd
image that they require and download it via the "Asset" class
functions which have caching built-in.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


