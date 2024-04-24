Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8821C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXwu-0001nA-P8; Wed, 24 Apr 2024 04:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzXwr-0001lq-Qy
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:25:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzXwp-0008K9-DF
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713947146;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Do8rqvpVYrQLUokyNJNfhMQO0qIwbAVh4vfyFkXJ1lE=;
 b=GpI1v8SxIVj/SlmWEnsyevUEQk8PJru8M/VpJDQ9tU8Exh+G1OJhs/4oB4xeAxTWfy6OX2
 j5aO23P8GjMALA3Y6Wk3rx4NMyrOjGQoqVCrTNtDj7hSuaTWhtKo7RS/LxDQBTfmhV/Jx6
 IWUrJV2O3qR35wkk52mQjUJT7k/3Ga4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-nuRkCVrBPRe1Vez5vDRM0w-1; Wed, 24 Apr 2024 04:25:42 -0400
X-MC-Unique: nuRkCVrBPRe1Vez5vDRM0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B2BB18065B2;
 Wed, 24 Apr 2024 08:25:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BABE112132A;
 Wed, 24 Apr 2024 08:25:41 +0000 (UTC)
Date: Wed, 24 Apr 2024 09:25:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Lei Wang <lei4.wang@intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, manish.mishra@nutanix.com,
 xiaoyao.li@intel.com, chenyi.qiang@intel.com, tao1.su@linux.intel.com
Subject: Re: [PATCH] target/i386: Introduce SapphireRapids-v3 to add missing
 features
Message-ID: <ZijCAz19K6-Y29uF@redhat.com>
References: <20240424072912.43188-1-lei4.wang@intel.com>
 <ZijDx4m117yv64JK@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZijDx4m117yv64JK@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

On Wed, Apr 24, 2024 at 04:33:11PM +0800, Zhao Liu wrote:
> Hi Lei,
> 
> On Wed, Apr 24, 2024 at 03:29:12AM -0400, Lei Wang wrote:
> > Date: Wed, 24 Apr 2024 03:29:12 -0400
> > From: Lei Wang <lei4.wang@intel.com>
> > Subject: [PATCH] target/i386: Introduce SapphireRapids-v3 to add missing
> >  features
> > X-Mailer: git-send-email 2.39.3
> > 
> > Add the missing features(ss, tsc-adjust, cldemote, movdiri, movdir64b) in
> > the SapphireRapids-v3 CPU model.
> 
> Considering that these are missing features, not hardware updates/fixes/Linux
> support changes, then as opposed to adding v3, it would be more appropriate
> to add these flags directly to the v1 SPR model with Fixes tag (Fixes:
> commit 7eb061b06e97 ("i386: Add new CPU model SapphireRapids")).

That would break compatibility with v1 CPU models from existing releases
of QEMU. Once released, a CPU version is read-only to preserve compatibility,
which is why we have the CPU versioning concept. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


