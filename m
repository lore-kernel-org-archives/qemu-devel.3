Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1066BCA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 13:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux3mN-0006bk-W9; Fri, 12 Sep 2025 09:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ux3mL-0006bO-NH
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 09:25:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ux3mJ-00023l-KB
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 09:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757683520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7NgeF8xRxuNe+6YX7WMoaVvw9lPS8YBf0/L6YJyBzek=;
 b=atomQDydlI/4oVI3A3ZyQT0sCkNac9r3pO5iT8FaNU4xmgz/LB+Kuw3M970Zd0COWkf7dm
 QsZzlWs4B/0gFKvkxaRUxAGSSkrN7I6obbC65fv5fz7QFRVgat4aydzSsfqOcx7Qe6vBGr
 +aCpuzDLxNVvGoWLGxrP0i54LVlkNTg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-sw9tVsqYOHaep4j6967I7w-1; Fri,
 12 Sep 2025 09:25:19 -0400
X-MC-Unique: sw9tVsqYOHaep4j6967I7w-1
X-Mimecast-MFC-AGG-ID: sw9tVsqYOHaep4j6967I7w_1757683515
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8F57180A8F5; Fri, 12 Sep 2025 13:25:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.94])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49F091800593; Fri, 12 Sep 2025 13:25:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3AD4518000A9; Fri, 12 Sep 2025 15:25:08 +0200 (CEST)
Date: Fri, 12 Sep 2025 15:25:08 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 roy.hopkins@randomman.co.uk
Subject: Re: [PATCH] igvm: add initial support for non-cc firmware in igvm
 format
Message-ID: <ub32mvhexl7ppqwzie53ztfnplamfsl6ahrlwlirvno56es36s@m6ozo7p4ao2j>
References: <20250709123007.1039675-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709123007.1039675-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 09, 2025 at 02:30:07PM +0200, Gerd Hoffmann wrote:
> Implement a ConfidentialGuestSupportClass for non-confidential VMs.
> This allows the igvm support code work without sev/tdx.
> 
> RfC: Not fully sure this is the best way to implement this.
> Alternatively we could add this directly into the igvm backend and run
> it in case no confidential guest support object is present.

Started to look at this again.  Noticed that at least simple native
igvm files (with memory regions only) boot just fine without an
ConfidentialGuestSupportClass.  Which kind-of underlines that going for
a pseudo-ConfidentialGuestSupportClass for native mode is maybe not the
best design idea ...

Nevertheless we'll go need target-specific code for some IGVM features.
That is obviously the case for loading some custom initial CPU state.
But also things like the memory map are not the same across targets,
even though some targets might share an implementation (e820 on x86,
fdt elsewhere).

Suggestions how to wire that up best?

take care,
  Gerd


