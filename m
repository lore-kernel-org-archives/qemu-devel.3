Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FBFC71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 19:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYrZq-0001jC-6T; Mon, 07 Jul 2025 15:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uYrZT-0001U2-EF
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uYrZR-0005bh-64
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751916726;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=302NR68NX9S2axfZIw64TZ/EOfxkkD+1zcmr5j8M1gQ=;
 b=AL5BzN2EP3kIs+zeIlkkrM3KGwwx5sZieHch5iicSePTLiOlWua/BT7SuH/HnQmtawDTia
 pLPu2c37kPGQlx5sKXVa96sa4U9xutolhkP27hjvcFMLYZ5ZgRG2z/KtdvgBsrqTppD1EZ
 8qMkDrE5HXaxL967NadzHX6X4794Hys=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-ccWgqQwzMl2zJ26PclLY6g-1; Mon,
 07 Jul 2025 15:32:03 -0400
X-MC-Unique: ccWgqQwzMl2zJ26PclLY6g-1
X-Mimecast-MFC-AGG-ID: ccWgqQwzMl2zJ26PclLY6g_1751916722
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 879B718089B4; Mon,  7 Jul 2025 19:32:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.155])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1790B180045B; Mon,  7 Jul 2025 19:31:57 +0000 (UTC)
Date: Mon, 7 Jul 2025 20:31:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, qemu-stable@nongnu.org,
 boris.ostrovsky@oracle.com, maciej.szmigiero@oracle.com,
 Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
Message-ID: <aGwgq2cz_xcYCf4o@redhat.com>
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
 <aGO3vOfHUfjgvBQ9@intel.com>
 <c6a79077-024f-4d2f-897c-118ac8bb9b58@intel.com>
 <1ecfac9a-29c0-4612-b4d2-fd6f0e70de9d@oracle.com>
 <e19644ed-3e32-42f7-8d46-70f744ffe33b@intel.com>
 <aGQ-EGmkVkHOZcnn@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aGQ-EGmkVkHOZcnn@char.us.oracle.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Jul 01, 2025 at 03:59:12PM -0400, Konrad Rzeszutek Wilk wrote:
> ..snip..
> > OK, back to the original question "what should the code do?"
> > 
> > My answer is, it can behave with any of below option:
> > 
> > - Be vendor agnostic and stick to x86 architecture. If CPUID enumerates a
> > feature, then the feature is available architecturally.
> 
> Exactly. That is what we believe Windows does.
> 
> 
> By this logic KVM is at fault for exposing this irregardless of the
> platform (when using -cpu host). And Sean (the KVM maintainer) agrees it is
> a bug. But he does not want it in the kernel due to guest ABI and hence
> the ask is to put this in QEMU.

If QEMU unconditionally disables this on AMD, and a future AMD CPU
does implement it, then QEMU is now broken because it won't be fully
exposing valid features impl by the host CPU and supported by KVM.

IOW, if we're going to have QEMU workaround the KVM mistake, then
the code change needs to be more refined.

QEMU needs to first check whether the host CPU implements
ARCH_CAPABILITIES and conditionally disable it in the guest CPU
based on that host CPU check. Of course that would re-expose the
Windows guest bug, but that ceases to be KVM/QEMU's problem at
that point, as we'd be following a genuine physical CPU impl.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


