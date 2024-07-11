Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9768EC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 12:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRsrL-0006id-ME; Thu, 11 Jul 2024 08:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRsrJ-0006hu-DD
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 08:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRsrG-00034k-66
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 08:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720700708;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EZgsViSmjAgA5s1NKIOJXY6hRVBiDPzgsv7I1Ld09gw=;
 b=goaKJo4GKY5chGqau+kpRc82mqp3CseK1DmFlTLV7HuYvkdKfYWIPJrELk+SVRG1A9/1kn
 /0yvDscN6tTwc6o2C9Xy1bAZ/m40OlleR91ClnGhZ9ZBOGO8pGgeVyHZplQGsykdPYCIww
 3+9wuPRY69xKzx0r1HtrM4cTce7s6Bk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-rA-kO1SQNK6lrx36q8ysjQ-1; Thu,
 11 Jul 2024 08:25:05 -0400
X-MC-Unique: rA-kO1SQNK6lrx36q8ysjQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EBB9196E0A0; Thu, 11 Jul 2024 12:25:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B954619560AA; Thu, 11 Jul 2024 12:25:00 +0000 (UTC)
Date: Thu, 11 Jul 2024 13:24:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Wang, Lei4" <lei4.wang@intel.com>
Subject: Re: [PATCH v1] target/i386: kvm: Block migration when enfore_cpuid
 is set to false
Message-ID: <Zo_PGVjbRHMfe-Gf@redhat.com>
References: <20240703144912.130988-1-wei.w.wang@intel.com>
 <Zo_GZfR1sQH06TCp@redhat.com>
 <DS0PR11MB6373A148EDE4EB3125B6C42DDCA52@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS0PR11MB6373A148EDE4EB3125B6C42DDCA52@DS0PR11MB6373.namprd11.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Thu, Jul 11, 2024 at 12:10:34PM +0000, Wang, Wei W wrote:
> On Thursday, July 11, 2024 7:48 PM, Daniel P. Berrangé wrote:
> > On Wed, Jul 03, 2024 at 10:49:12PM +0800, Wei Wang wrote:
> > > When enforce_cpuid is set to false, the guest is launched with a
> > > filtered set of features, meaning that unsupported features by the
> > > host are removed from the guest's vCPU model. This could cause issues for
> > live migration.
> > > For example, a guest on the source is running with features A and B.
> > > If the destination host does not support feature B, the stub guest can
> > > still be launched on the destination with feature A only if enforce_cpuid=false.
> > > Live migration can start in this case, though it may fail later when
> > > the states of feature B are put to the destination side. This failure
> > > occurs in the late stage (i.e., stop&copy phase) of the migration
> > > flow, where the source guest has already been paused. Tests show that
> > > in such cases the source guest does not recover, and the destination
> > > is unable to resume to run.
> > >
> > > Make "enfore_cpuid=true" a hard requirement for a guest to be
> > > migratable, and change the default value of "enforce_cpuid" to true,
> > > making the guest vCPUs migratable by default. If the destination stub
> > > guest has inconsistent CPUIDs (i.e., destination host cannot support
> > > the features defined by the guest's vCPU model), it fails to boot
> > > (with enfore_cpuid=true by default), thereby preventing migration from
> > > occuring. If enfore_cpuid=false is explicitly added for the guest, the
> > > guest is deemed as non-migratable (via the migration blocker), so the
> > > above issue won't occur as the guest won't be migrated.
> > 
> > Blocking migration when enforce=false is making an assumption that users of
> > that setting are inherantly broken. This is NOT the case if the user/app has
> > already validated compatibility in some manner outside QEMU. Blocking
> > migration in this case will break valid working use cases.
> 
> It's just an enforcement to ensure a safe migration. Without this (i.e., the current
> QEMU code) is making an assumption that users always have validated
> compatibility in a good manner outside QEMU, which is risky to some degree?

QEMU configurations must never be assumed to be migratable by default.
There is a huge set of things that a user must do with QEMU configuration
to guarantee migratability beyond CPU features. All aspects of guest HW
device topology must be set explicitly.

> Do you see how this would break valid working use cases (any examples)?
> This is actually what we are looking for. Please be aware that "enforce" is
> changed to be true by default to make the guest to be migratable by default
> under the enforcement.

Setting "enforce" will break existing use of QEMU. It is valid to launch
QEMU with a CPU model that is not fully supported by the host, allowing
QEMU to disable unsupported features automatically.

> > IMHO this patch doesn't need to exist. If users of QEMU want strong protection
> > they can already opt-in to that with enforce=true.
> 
> AFAIK, many users are not aware of this, and also we couldn't assume everybody
> knows it. That's why we want to add the enforcement.

Users who directly launch QEMU are expected to know about QEMU config
details for migration. If they don't, then they ought to be using a
higher level tool like libvirt, which ensures the configuration is
migration compatible.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


