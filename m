Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDB6C27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 17:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHRQZ-0007OL-4L; Wed, 12 Jun 2024 13:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHRQX-0007OC-U2
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 13:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHRQW-0005jG-6i
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 13:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718211983;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zshuaE20T1MD0E6Yc4ri5wdSzxl+MGl0Oe0hkSffle8=;
 b=c7VjnFlYEjukxMaOZAWe4S9jGJoJJ43PRcuChCGT2b2tR50zWbqYP2wUKKVPdErEKKlIus
 +y4hbQ0ToPO6vW7f8r5CrjABijTtmBsAm6/iurPLRguNKFcW1HzrioHZPdNt1ghcmWaHhh
 ekxcXAiviQCzJKa8UZiBTypgGFvBy0w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-Gv5JYItoNSa-3DheCq210g-1; Wed,
 12 Jun 2024 13:06:19 -0400
X-MC-Unique: Gv5JYItoNSa-3DheCq210g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A43EE1955D5F; Wed, 12 Jun 2024 17:06:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.115])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2E3A19560AD; Wed, 12 Jun 2024 17:06:16 +0000 (UTC)
Date: Wed, 12 Jun 2024 18:06:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Monakov <amonakov@ispras.ru>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
Message-ID: <ZmnVhbnPGQOMy7Fb@redhat.com>
References: <20240612105525.8795-1-amonakov@ispras.ru>
 <ZmmAq8fbJLuaX4Qg@redhat.com>
 <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
 <ZmmIpr5f0sQy-VGl@redhat.com>
 <CABgObfZHBGxS-D9LdM1v0oDXBHoKm2-A4FknixmqjfJeQR1YLw@mail.gmail.com>
 <ZmmSxq7i_tpYj7tw@redhat.com> <Zmm6Kf8PEwZ47bMb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zmm6Kf8PEwZ47bMb@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Jun 12, 2024 at 04:09:29PM +0100, Daniel P. Berrangé wrote:
> On Wed, Jun 12, 2024 at 01:21:26PM +0100, Daniel P. Berrangé wrote:
> > On Wed, Jun 12, 2024 at 01:51:31PM +0200, Paolo Bonzini wrote:
> > > On Wed, Jun 12, 2024 at 1:38 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > This isn't anything to do with the distro installer. The use case is that
> > > > the distro wants all its software to be able to run on the x86_64 baseline
> > > > it has chosen to build with.
> > > 
> > > Sure, and they can patch the packages if their wish is not shared by
> > > upstream. Alternatively they can live with the fact that not all users
> > > will be able to use all packages, which is probably already the case.
> > 
> > Yep, there's almost certainly scientific packages that have done
> > optimizations in their builds. QEMU is slightly more special
> > though because it is classed as a "critical path" package for
> > the distro. Even the QEMU linux-user pieces are now critical path,
> > since they're leveraged by docker & podman for running foreign arch
> > containers.
> > 
> > > Or drop QEMU, I guess. Has FeSCO ever expressed how strict they are
> > > and which of the three options they'd pick?
> > 
> > I don't know - i'm going to raise this question to find out if
> > there's any guidance.
> 
> I learnt that FESCo approved a surprisingly loose rule saying
> 
>   "Libraries packaged in Fedora may require ISA extensions,
>    however any packaged application must not crash on any
>    officially supported architecture, either by providing
>    a generic fallback implementation OR by cleanly exiting
>    when the requisite hardware support is unavailable."
>

..snip..

I queried the looseness of this wording, and it is suggested
it wasn't intended to apply to existing packages, just newly
added ones. By that interpretation it wouldn't be valid for
QEMU, and we'd be pushed towards the revert downstream, to
retain a runtime check for the feature. I really hate the
idea of keeping a revert of these patches downstream though,
as it would be an indefinite rebase headache.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


