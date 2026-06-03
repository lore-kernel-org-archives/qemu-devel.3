Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCE3CD6E64
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 09:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUi1S-0007Zh-EW; Wed, 03 Jun 2026 05:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wUi1Q-0007ZT-VS
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wUi1P-0002Ug-DI
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 05:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780479382;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GLPlpg3oewvuR5EidhmzPEmBQsItbJhUvrr+inupClg=;
 b=UcJfO4CutZdivJbfJl4R3GEuMp1d6YfMtPGDMH5eHv+O2XdKhZvc34nn245CBSOJMPE6kd
 BV5VZxCIjNQLxL5igkbjpXwbx7EcSdRGTFrc/H2XLizMMtDqnaB1V7yKbAwFrB80LRY6xu
 33n9kcoI3aKvsfa0uEs7mwQ4tlpjtgk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-K5nBx7idNJK8XSInsaWl3g-1; Wed,
 03 Jun 2026 05:36:20 -0400
X-MC-Unique: K5nBx7idNJK8XSInsaWl3g-1
X-Mimecast-MFC-AGG-ID: K5nBx7idNJK8XSInsaWl3g_1780479380
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCB7C195606B; Wed,  3 Jun 2026 09:36:19 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92E75763; Wed,  3 Jun 2026 09:36:18 +0000 (UTC)
Date: Wed, 3 Jun 2026 10:36:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: Question about recent iotest changes, 'make check' and 'ninja
 test'
Message-ID: <ah_1jqsrH6MaD8qx@redhat.com>
References: <0c7e5dec-44fc-4c1b-b0ce-cb9fdd6d0a5c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c7e5dec-44fc-4c1b-b0ce-cb9fdd6d0a5c@oss.qualcomm.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 26, 2026 at 05:14:16PM -0300, Daniel Henrique Barboza wrote:
> Hi,
> 
> I happen to use 'ninja -C build test to do a (usually) quick sanity test
> on patches and changes and whatnot.  An usual run of this target tests
> around 327 individual tests with the RISC-V stuff I usually build.
> 
> After pulling today's master 'ninja -C build test' is now running a whooping
> 1366 tests.  Here's an example:
> 
> 
> $ ninja -C build -j 9 test
> ninja: Entering directory `build'
> mkvenv: checking for pygdbmi>=0.11.0.0
> mkvenv: installing pygdbmi==0.11.0.0
> [2/3] Running all tests
> [1-12/1366] (....)
>  (....)
> [250-260/1366] 🌕 block-qcow2-optional+block-slow - qemu:io-qcow2-014
> [250-261/1366] 🌖 block-qcow2-optional+block-slow - qemu:io-qcow2-014
> [252-262/1366] 🌒 block-qcow2-optional+block-slow - qemu:io-qcow2-026
> (...)
> 
> I noticed a lot of these "optional+block-slow" tests being ran now, something that
> wasn't happening before.
> 
> If I use 'make check' I have the results I was having with 'ninja -C build test'
> before the recent changes.
> 
> I tried to bisect and got to this commit:
> 
> commit daf0d008822be3cb14cdb533f7237c3c789bc373 (HEAD)
> Author: Daniel P. Berrangé <berrange@redhat.com>
> Date:   Mon Jan 12 13:01:49 2026 +0000
> 
>     iotests: remove redundant meson suite for iotests
> 
> 
> From what I can tell this commit triggered (unintended?) stuff that was already in the
> code.  In other words I am not sure if this commit is actually the culprit, so I am
> reluctant to even call this a bug.
> 
> My question is: should I be using 'ninja test'?  It seems to me that the common practice
> is to use 'make check' and maybe I've been using an "unsupported" testing scheme.

"make check" is the normal way we expect developers to run tests.

That will trigger a moderately filtered set of tests suites that
we think we reasonable to expect for day-to-day validation.

There are various other make targets that can enable additional
tests that are known to ninja.

If you are directly using 'ninja test' you'll get everything and if
that's too much, you need to use cli args to exclude certain suites
of tests.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


