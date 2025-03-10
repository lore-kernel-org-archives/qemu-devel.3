Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF10DC28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 09:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trZNz-0000XQ-9A; Mon, 10 Mar 2025 05:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1trZNu-0000Wf-Cu
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:25:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1trZNr-00073e-Vh
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741598714;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FZ5JPEZKS9QS/RELeFvoYDZ4tYfGoHXJHlkiNCEiDHo=;
 b=PHlCzQc4n8C4BL/iwBrsbKervTlVMaQsIY1Gw+3KiyG3M/m54m3ME6l6Cmr9j8Cj61kLCk
 LDN49daaWa9NfOTr1NNVHkiOKQRG7YRj22zkMdwFC6LB1FPDldwgvMgfCy/3V0DfDo81pv
 sIwBwD/RD8sq9d1XfS8xhKYOYNRcqOc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-pbBKz4NRPPmOJOOCHOjKFw-1; Mon,
 10 Mar 2025 05:25:11 -0400
X-MC-Unique: pbBKz4NRPPmOJOOCHOjKFw-1
X-Mimecast-MFC-AGG-ID: pbBKz4NRPPmOJOOCHOjKFw_1741598710
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 423721800265; Mon, 10 Mar 2025 09:25:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B01A51800370; Mon, 10 Mar 2025 09:25:08 +0000 (UTC)
Date: Mon, 10 Mar 2025 09:25:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: Re: [PATCH] gitlab-ci: include full Rust backtraces in test runs
Message-ID: <Z86v8Y70sGThWb_V@redhat.com>
References: <20250129082045.1319203-1-pbonzini@redhat.com>
 <CAFEAcA9=G4sdXrxWcmq9wMqu1-ZRNxObQD3hmnFauYwiQr_8YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9=G4sdXrxWcmq9wMqu1-ZRNxObQD3hmnFauYwiQr_8YQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Mar 10, 2025 at 09:21:37AM +0000, Peter Maydell wrote:
> On Wed, 29 Jan 2025 at 08:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  .gitlab-ci.d/buildtest-template.yml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
> > index 39da7698b09..4cc19239319 100644
> > --- a/.gitlab-ci.d/buildtest-template.yml
> > +++ b/.gitlab-ci.d/buildtest-template.yml
> > @@ -63,6 +63,7 @@
> >    stage: test
> >    image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
> >    script:
> > +    - export RUST_BACKTRACE=1
> >      - source scripts/ci/gitlab-ci-section
> >      - section_start buildenv "Setting up to run tests"
> >      - scripts/git-submodule.sh update roms/SLOF
> > --
> 
> This will only add the rust backtraces when the tests
> are run from the CI logs, not when you locally run
> "make check" or similar. There's probably a better place
> to put this...

Meson's  'test()' command accepts env variables, but it'll be somewhat
tedious to add the same env to all case where we use test. Might want
to define a common 'testenv' set at the top level meson.build and then
reference it from every 'test()', unless meson has built-in support
for globally applied env vars that I'm missing.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


