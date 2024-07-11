Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DB5C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRuZZ-0006HM-2O; Thu, 11 Jul 2024 10:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRuZW-0006GL-Ti
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 10:14:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRuZP-0004kf-C6
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 10:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720707287;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YxeKQYRbt7FrDmJJnueUADfHWTaOPSYlmMgFXSN1VZM=;
 b=RGdEtyDjVwFk3c3TGSvC+MCkVsC/hckHQcrLBymcW+fqKLfQ4yYdTIbD/lkmUXa7bWPRQh
 nQ9TzKBAHTcVXE89e7vVscaKIMJIJBGg8h/n81Ljsnc1n4Z+i/ZHHkWgLcewvu8d4+QzKv
 Y4MKuvCI+Qk0czVOXkKCW/hNRLyodGc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-r2p_oAfYNjybYgvEMFLnXw-1; Thu,
 11 Jul 2024 10:14:43 -0400
X-MC-Unique: r2p_oAfYNjybYgvEMFLnXw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5162B1910426; Thu, 11 Jul 2024 14:14:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B024E1955EA1; Thu, 11 Jul 2024 14:14:29 +0000 (UTC)
Date: Thu, 11 Jul 2024 15:14:26 +0100
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
Message-ID: <Zo_owsKVk32F9lwb@redhat.com>
References: <20240703144912.130988-1-wei.w.wang@intel.com>
 <Zo_GZfR1sQH06TCp@redhat.com>
 <DS0PR11MB6373A148EDE4EB3125B6C42DDCA52@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Zo_PGVjbRHMfe-Gf@redhat.com>
 <DS0PR11MB63736018180E286CC7D36167DCA52@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS0PR11MB63736018180E286CC7D36167DCA52@DS0PR11MB6373.namprd11.prod.outlook.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Jul 11, 2024 at 02:13:31PM +0000, Wang, Wei W wrote:
> On Thursday, July 11, 2024 8:25 PM, Daniel P. Berrangé wrote:
> > On Thu, Jul 11, 2024 at 12:10:34PM +0000, Wang, Wei W wrote:
> > > On Thursday, July 11, 2024 7:48 PM, Daniel P. Berrangé wrote:
> > > > On Wed, Jul 03, 2024 at 10:49:12PM +0800, Wei Wang wrote:
> > > AFAIK, many users are not aware of this, and also we couldn't assume
> > > everybody knows it. That's why we want to add the enforcement.
> > 
> > Users who directly launch QEMU are expected to know about QEMU config
> > details for migration. If they don't, then they ought to be using a higher level
> > tool like libvirt, which ensures the configuration is migration compatible.
> 
> Agree that libvirt has this advantage and is more user friendly. But it doesn't seem to
> solve the issue mentioned by this patch - if users don't explicitly set "enforce=true"
> in libvirt configs for the guest, then migrating the guest across hosts with different
> features could still be risky. Unless there is similar enforcement in libvirt to require
> users to set "enforce=true" for the guest to be migratable.

Yes, libvirt takes steps to ensure CPU compatibility before migrating.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


