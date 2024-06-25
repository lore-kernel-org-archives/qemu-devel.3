Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B527C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 09:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM2bi-0005rP-FN; Tue, 25 Jun 2024 05:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sM2bg-0005qi-MY
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 05:36:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sM2be-0001RE-TT
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 05:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719308213;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xEBJ7yXdfCZHvrq+wSL3olkkkWdwvjg8+2gq6kYFvkA=;
 b=ElM0JlV+ssIr3EuQX1U1zKBxh77QjOCO10PDEK4pe46fQEgOKw5VjiXZUPxF3vXfC6WOnb
 euokXR4AcMhWif9hdngzpM/Yl0q5w73ZrABzqqWocO+HWVu9Ug9DwCDD8/YO45AEQxBEpC
 Xn6nsjRsJFctppFUmW6mXibAU2vsrSo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-P3gIUBYHMGyKTalXYfVKZQ-1; Tue,
 25 Jun 2024 05:36:49 -0400
X-MC-Unique: P3gIUBYHMGyKTalXYfVKZQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16F7119560B3; Tue, 25 Jun 2024 09:36:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C444E1956087; Tue, 25 Jun 2024 09:36:42 +0000 (UTC)
Date: Tue, 25 Jun 2024 10:36:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Felix Wu <flwu@google.com>, pbonzini@redhat.com,
 eduardo@habkost.net, peterx@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, Roman Kiryanov <rkir@google.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 1/2] qom: Rename Object::class into Object::klass
Message-ID: <ZnqPpqfBxlk9tEdX@redhat.com>
References: <20240624204400.103747-1-flwu@google.com>
 <d82916f9-3f5c-43f1-a545-0f5a30c8459e@linaro.org>
 <CAFEAcA-HdxjCau=6p7fY5=dGY++YS-GHkxufLJ6-n3rD-GQofQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-HdxjCau=6p7fY5=dGY++YS-GHkxufLJ6-n3rD-GQofQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jun 25, 2024 at 10:23:54AM +0100, Peter Maydell wrote:
> On Tue, 25 Jun 2024 at 03:20, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> > Since you are posting different C++ enablement cleanups,
> > I suggest you add a section in our docs/devel/style.rst
> > requesting to keep headers C++ compatible, by not using
> > C++ reserved keywords, etc...
> >
> > In particular because the mainstream project is not build-testing
> > for C++, thus we will likely merge patches breaking C++ and
> > make your life harder. That said, a C++ header smoke-build job
> > in our CI could help.
> 
> Unless there's some easy mechanism for contributors to check
> that they haven't broken whatever our C++ requirement is,
> I don't think we should define it in the style guide.
> 
> More generally, we specifically removed the handling we
> had for being able to include our headers from C++ source
> files. (cf the stuff we added in commit 875df03b221 for
> extern "C" blocks and then removed again later). If we're
> not bringing that back (and I don't think we should) then
> we're not actually trying to have our headers be C++
> compatible, so what are we aiming for?

I really dislike the drip-feeding of patches fixing C++ related
problems. As maintainers we've no idea what the end state is,
is this the last patch, or are there another 100 of these patches
to trickle out one at a time. Ultimately from the QEMU maintainer
POV anything related to C++ compatibility is a distraction, given
the general consensus has turned to Rust as the future for QEMU,
not C++.

If we're going to take any C++ compat cleanups as a courtesy to
ease burden of a downstream fork, then I'd like to see a complete
series in one go, so we can sensibly evaluate whether the end
state is something desirable from QEMU's POV.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


