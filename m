Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D589FC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 17:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whVnP-0007yc-0O; Wed, 08 Jul 2026 13:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whVnM-0007xp-PT
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 13:10:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whVnK-00007L-VQ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 13:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783530646;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DC/Xmp1EFs92MEa7tYVfSmHopH1ID1fSNwx287pqV2k=;
 b=bcsFSBpT1KtIEDS0BtgRCvUg0SdaCOfdb/DLZ9+6Rvscvuy3qVsNNOmLaHz6RNhBy5mLRj
 wZSXNmoAkuevbCksCBPRKbpmCet5BM0Kx6umU0TnuOZepd1Zo+cHYBjBoPpn6UHM2J82ld
 0pFqaSr8P9WAK9O43tm27E2lkGOiEcg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-in7c3cSmNjGaxM8wqtl39g-1; Wed,
 08 Jul 2026 13:10:40 -0400
X-MC-Unique: in7c3cSmNjGaxM8wqtl39g-1
X-Mimecast-MFC-AGG-ID: in7c3cSmNjGaxM8wqtl39g_1783530639
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E6751955F13; Wed,  8 Jul 2026 17:10:39 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.28])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 434D41774; Wed,  8 Jul 2026 17:10:34 +0000 (UTC)
Date: Wed, 8 Jul 2026 18:10:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 linux-s390@vger.kernel.org, dengler@linux.ibm.com,
 borntraeger@linux.ibm.com, fcallies@linux.ibm.com
Subject: Re: [PATCH v10 10/21] target/s390x: Base support for cpacf protected
 keys
Message-ID: <ak6Eh8Df9K5Ew-2E@redhat.com>
References: <20260706094317.17032-1-freude@linux.ibm.com>
 <20260706094317.17032-11-freude@linux.ibm.com>
 <87v7asjpzc.fsf@redhat.com>
 <26e04f8752e3235d6e8819cad1a5d9df@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26e04f8752e3235d6e8819cad1a5d9df@linux.ibm.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

On Mon, Jul 06, 2026 at 02:18:25PM +0200, Harald Freudenberger wrote:
> On 2026-07-06 13:51, Cornelia Huck wrote:
> > On Mon, Jul 06 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:
> > 
> > > Add base support for cpacf protected key handling.
> > > 
> > > The qemu version provided here is only a fake intended to make
> > > protected key available for developing and testing purpose:
> > > * The protected key is 'derived' from the clear key by xoring
> > >   the fixed pattern 0xAAAA... onto the key value.
> > > * The AES Wrapping Key Verification Pattern is a fixed
> > >   value of 32 bytes 0xFACEFACE...
> > > 
> > > Add preprocessor defines for the xor pattern and wkvp used to
> > > construct ('encrypt') a protected key from a clear key value with
> > > this implementation. Also add some static functions to 'encrypt'
> > > from clear key to protected key and 'decrypt' back to cpacf_aes.c.
> > > 
> > > The preprocessor defines shall be used later in testcases to
> > > construct and decode protected keys.
> > 
> > Hmm... so does that mean that we only provide the protected key handling
> > in the !KVM case for people who want to run via tcg for some development
> > purposes? Does the user actually get some kind of notice in that case,
> > if for example they run with !KVM due to some configuration hiccup? IOW,
> > do users get some clue that they are running with a fake placeholder
> > implementation, other than the setup being slow?
> > 
> 
> Well, there are 2 paths leading to protected use:
> 1) you have a secure key and want to 'derive' a protected key from that
>    to operate faster. This is for example the case now when you have an
>    PAES encrypted filesystem.
>    In such a case you need a crypto card with the Master Key setting
>    fitting to when your secure key was generated.
>    -> this is not a practical way for qemu on !KVM as you need a crypto
>    card AND the s390 firmware stack.
> 2) you 'derive' a protected key from a clear key value. On a s390 system
>    this is done via the privileged instruction PCKMO. On this qemu with
>    !KVM this is the fake I implemented.
>    In general it is absolutely not recommended to go this path as the source
>    of the key is/was/needs to stay in OS memory. So you don't win any
>    security by using protected keys this way - in fact you would have
>    done better to just use the clear key as it is. Please note also, that
>    by default this path on a s390 system is disabled - however, for testing
>    purpose there are ways to use it this way.
>    However, this is exactly what this implementation here is for. For
> testing
>    purpose you may 'derive' a protected key from clear key or any other way
>    as the algorithm to derive is clear documented here. And then you can
> play
>    around and run tests with protected key implementations.
> 
> I see your point: How can a innocent user see that his/her vm is running
> with
> this fake installation instead of the real one. The answer is:
> If the source of the protected key is a secure key - then there is no path
> on the faked implementation to get a hand on a protected key.
> If the source of the protected key is a clear key - honestly does it even
> matter which implementation is then running?

IMHO any use of TCG inherantly throws away any security guarantees
that rely on a guaranteed hardware impl, and in addition we don't
claim that TCG provides a secure host/guest boundary & thus excluded
it from CVE triage.

IOW, if someone is concerned about integrity of their VM, the
answer is to detect the presence of TCG in general, rather than
detect anything related to this narrow protected key feature.

TL;DR: this is at most a docs problem to highlight the limitations
of using TCG in general, and not a problem for this patch series.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


