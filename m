Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1462C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 15:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s01H6-0004fX-GM; Thu, 25 Apr 2024 11:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s01H5-0004fJ-BI
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s01H3-0005Rc-IT
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 11:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714059876;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=o7yVS7sqzJbSgr/Af26TxwGh366HIo7fyUBLUNTwfYs=;
 b=Xu1Dwfp4aKBVQLRZTp61wLIDBsWX8zxTC6YCtDNlx3BX/vTXsTANZCeTbYTe00uIrMpTqu
 A33KahE/XmDB5H063hhadWOXymEBgFUByWAzUpNYqgfcEwExDRaN2/DyOyGka5vzqHNq7h
 pfwqHJYynOwYPBu6VaBtQrSokzZVWG8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-61HDk5KLM_SOfN6VL8WMtQ-1; Thu,
 25 Apr 2024 11:44:32 -0400
X-MC-Unique: 61HDk5KLM_SOfN6VL8WMtQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED8C738049F3;
 Thu, 25 Apr 2024 15:44:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 184B2202450D;
 Thu, 25 Apr 2024 15:44:30 +0000 (UTC)
Date: Thu, 25 Apr 2024 16:44:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] ci: move external build environment setups to CentOS
 Stream 9
Message-ID: <Zip6XaU70q6k0uut@redhat.com>
References: <20240412103708.27650-1-pbonzini@redhat.com>
 <73911b7b-da94-441a-95b0-bcfb23f7b8fb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73911b7b-da94-441a-95b0-bcfb23f7b8fb@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 25, 2024 at 05:03:43PM +0200, Thomas Huth wrote:
> On 12/04/2024 12.37, Paolo Bonzini wrote:
> > RHEL 9 (and thus also the derivatives) are available since two years
> > now, so according to QEMU's support policy, we can drop the active
> > support for the previous major version 8 now.
> > 
> > Thus upgrade our CentOS Stream build environment playbooks to major
> > version 9 now.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   .../stream/{8 => 9}/build-environment.yml     | 31 ++++++-------
> >   .../stream/{8 => 9}/x86_64/configure          |  4 +-
> >   .../stream/{8 => 9}/x86_64/test-avocado       |  0
> >   scripts/ci/setup/build-environment.yml        | 44 +++++++------------
> >   4 files changed, 34 insertions(+), 45 deletions(-)
> >   rename scripts/ci/org.centos/stream/{8 => 9}/build-environment.yml (75%)
> >   rename scripts/ci/org.centos/stream/{8 => 9}/x86_64/configure (98%)
> >   rename scripts/ci/org.centos/stream/{8 => 9}/x86_64/test-avocado (100%)
> 
>  Hi Paolo!
> 
> Not sure whether you've seen my busted pull request, but anyway: It seems
> like this was not enough to update the custom runner. You also need to
> update .gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml for this.
> 
> By the way, who has access to the s390x custom runner and could update it to
> Ubuntu 22.04 now? It still seems to work with 20.04 which will be out of
> support from the QEMU POV next week...

I rather wish that the custom runners were all using podman/docker,
so we could have the jobs just build containers for the envs, like
we do on shared runners, and/or on the Azure runners. That way we're
not beholden to an admin to manually update OS intsalls.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


