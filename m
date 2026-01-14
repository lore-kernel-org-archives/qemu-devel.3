Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE947D31A2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 09:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfww4-0006A0-N6; Wed, 14 Jan 2026 04:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfwvv-00067y-5m
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 04:12:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfwvt-0005Pz-IA
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 04:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768381972;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eV7Emqbw4qW8q4jLtkh8gkLnkiRzZ8akU1fPrOO1/Mo=;
 b=Xa0k48mVoyZPx2mDReCv7eB6ADDHRIe9lHjEj7hIQJRBELy+EpzuYsq+S7j/yRMivd2ZqT
 572iKsTnBUpipvLahdrwAO4LfD0bwNlG8iXR3bBKAmwEK/UE+qkz2fXRuwIKL6TofY+uic
 orHxjh9HYH2ifD/l5GktpaCUou3+DOg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-TO9WLLicOLiuTY3FFeJCUg-1; Wed,
 14 Jan 2026 04:12:49 -0500
X-MC-Unique: TO9WLLicOLiuTY3FFeJCUg-1
X-Mimecast-MFC-AGG-ID: TO9WLLicOLiuTY3FFeJCUg_1768381968
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B13C5195608D; Wed, 14 Jan 2026 09:12:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.41])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54C4319560A2; Wed, 14 Jan 2026 09:12:45 +0000 (UTC)
Date: Wed, 14 Jan 2026 09:12:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PULL 13/31] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Message-ID: <aWdeCSSPgsArrWh6@redhat.com>
References: <20250704101433.8813-1-philmd@linaro.org>
 <20250704101433.8813-14-philmd@linaro.org>
 <44ccfba7-21a3-4c24-aa6a-4b2bdb989792@redhat.com>
 <dd7fbe03-1458-4c44-b8db-a9d5e9ae33f1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd7fbe03-1458-4c44-b8db-a9d5e9ae33f1@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jan 13, 2026 at 09:30:32PM +0100, Philippe Mathieu-Daudé wrote:
> On 13/1/26 20:32, Thomas Huth wrote:
> > On 04/07/2025 12.14, Philippe Mathieu-Daudé wrote:
> > > No need for accel-specific @dirty field when we have
> > > a generic one in CPUState.
> > > 
> > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> > > Message-Id: <20250703173248.44995-20-philmd@linaro.org>
> > > ---
> > >   target/i386/nvmm/nvmm-all.c | 21 ++++++++++-----------
> > >   1 file changed, 10 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> > > index f1c6120ccf1..aea61a6fd2a 100644
> > > --- a/target/i386/nvmm/nvmm-all.c
> > > +++ b/target/i386/nvmm/nvmm-all.c
> > ...
> > > @@ -982,7 +981,7 @@ nvmm_init_vcpu(CPUState *cpu)
> > >           }
> > >       }
> > > -    qcpu->dirty = true;
> > > +    qcpu->vcpu_dirty = true;
> > >       cpu->accel = qcpu;
> > >       return 0;
> > 
> > FYI, this does not seem to compile:
> > 
> > ../src/target/i386/nvmm/nvmm-all.c: In function 'nvmm_init_vcpu':
> > ../src/target/i386/nvmm/nvmm-all.c:988:9: error: 'AccelCPUState' has no
> > member named 'vcpu_dirty'
> >    988 |     qcpu->vcpu_dirty = true;
> >        |         ^~
> 
> s/qcpu/cpu/
> 
> > 
> > Is anybody checking the netbsd builds at all?
> 
> 3 reviewers and 6 months later.
> 
> Should we add a policy for bitrotting untested code?

Since we don't cover netbsd in GitLab CI, all responsibility for keeping
it working lies with whomever cares about the distro. No contributors
or maintainers in general should feel obligated to fix bugs in untested
platforms unless they specifically care about the platform.

> > (I'm currently trying to update test/vm/netbsd to version 10.1, that's
> > how I noticed it)

MAINTAINERS lists no one against test/vm/netbsd.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


