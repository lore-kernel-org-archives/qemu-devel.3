Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34DDCCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 11:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8H29-0003hT-0b; Mon, 13 Oct 2025 07:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8H28-0003gs-1r
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:48:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v8H1z-0000DA-Ej
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760356076;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sNnPTYbZCyewx5ZyqMD2+eJux9WBiG9bPY+F35szlDk=;
 b=Ak3+UBjTZCAjUQRgrMXbLFvlcJE0TNVBzMcTMqrKEH9mcvkFGMOM6VNgP1H2/zmV6IO1f4
 RDHJu68o2/rH2ORLc6MzpexQ7hslswoUN3ppenuCiKfOCZn2h2blNry0X0c5E0MgASUwYJ
 MjQfSeU+RzcYitFKyRSpATllLzR9JO0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-nGZjns8CPnuoWHaXFK-qBA-1; Mon,
 13 Oct 2025 07:47:53 -0400
X-MC-Unique: nGZjns8CPnuoWHaXFK-qBA-1
X-Mimecast-MFC-AGG-ID: nGZjns8CPnuoWHaXFK-qBA_1760356071
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CF881800578; Mon, 13 Oct 2025 11:47:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.40])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 759421954102; Mon, 13 Oct 2025 11:47:42 +0000 (UTC)
Date: Mon, 13 Oct 2025 12:47:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
Subject: Re: [RFC PATCH] docs/system/security: Restrict "virtualization use
 case" to specific machines
Message-ID: <aOzm2ukHfkPF-zhT@redhat.com>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
 <20250908104125-mutt-send-email-mst@kernel.org>
 <46AA9C03-CA7E-4C4B-AD05-A9053666BA52@gmail.com>
 <20251013070945-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013070945-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 13, 2025 at 07:12:31AM -0400, Michael S. Tsirkin wrote:
> On Mon, Oct 13, 2025 at 10:40:36AM +0000, Bernhard Beschow wrote:
> > 
> > 
> > Am 8. September 2025 14:45:40 UTC schrieb "Michael S. Tsirkin" <mst@redhat.com>:
> > >On Mon, Sep 08, 2025 at 01:50:57PM +0100, Peter Maydell wrote:
> > >> Currently our security policy defines a "virtualization use case"
> > >> where we consider bugs to be security issues, and a
> > >> "non-virtualization use case" where we do not make any security
> > >> guarantees and don't consider bugs to be security issues.
> > >> 
> > >> The rationale for this split is that much code in QEMU is older and
> > >> was not written with malicious guests in mind, and we don't have the
> > >> resources to audit, fix and defend it.  So instead we inform users
> > >> about what the can in practice rely on as a security barrier, and
> > >> what they can't.
> > >> 
> > >> We don't currently restrict the "virtualization use case" to any
> > >> particular set of machine types.  This means that we have effectively
> > >> barred ourselves from adding KVM support to any machine type that we
> > >> don't want to put into the "bugs are security issues" category, even
> > >> if it would be useful for users to be able to get better performance
> > >> with a trusted guest by enabling KVM. This seems an unnecessary
> > >> restriction, and in practice the set of machine types it makes
> > >> sense to use for untrusted-guest virtualization is quite small.
> > >> 
> > >> Specifically, we would like to be able to enable the use of
> > >> KVM with the imx8 development board machine types, but we don't
> > >> want to commit ourselves to having to support those SoC models
> > >> and device models as part of QEMU's security boundary:
> > >> https://lore.kernel.org/qemu-devel/20250629204851.1778-3-shentey@gmail.com/
> > >> 
> > >> This patch updates the security policy to explicitly list the
> > >> machine types we consider to be useful for the "virtualization
> > >> use case".
> > >
> > >This use-case sounds reasonable to me. I also imagine that
> > >some machines can get fixed down the road perhaps to
> > >the point where they enter the "virtualization use case".
> > >
> > >However, since we are
> > >getting this elaborate, would my old idea of a runtime flag
> > >make sense now?
> > >
> > >To recap, the idea was to add a "-virt" flag that will
> > >block any machines, devices and so on not considered
> > >part of the "virtualization use case".
> > >
> > >We could also create a mechanism for downstreams to
> > >tweak this as they see fit.
> > 
> > Hi Michael,
> > 
> > Thanks for confirming that the use case seems reasonable.
> > 
> > For now, we'd like to sharpen the term "virtualization use case" to allow for KVM to be usable in machines that aren't inside the security boundary and where maintenance commitment is unrealistic. The current approach is to adjust the policy and to spell out the machines where these commitments are made.
> > 
> > The trigger for this RFC was to be able to add KVM support to the imx8mp-evk machine. I have it working but can't currently upstream it due to our policy. It asks for unreasonable work and commitment which adds an unjustifyable burden on the maintainers.
> > 
> > I do see a need for further enhancements on the broader topic like adding a -virt switch etc. Maybe we should come up with a different term than "virtualization use case" which appears to leave a lot of room for interpretation. I propose these topics to be addressed separately.
> > 
> > What is missing for your R-b?
> > 
> > Thanks,
> > Bernhard
> 
> rebase on top of this:
> https://lore.kernel.org/all/20250926140144.1998694-1-berrange@redhat.com
> 
> if there's anything missing there, add it.

I don't think that its desirable to rebase on top of that series,
as it is liable to unduly delay Bernhard's work.

With a very minimal wording tweak our current defined policy could
avoid being a blocker for enabling KVM in imx8mp-evk. In

  https://www.qemu.org/docs/master/system/security.html

where it describes the "virtualization use case", we could simply
tweak it to always require a versioned machine type

Change

  "These use cases rely on hardware virtualization extensions
   to execute guest code safely on the physical CPU at close-
   to-native speed."

To say

  "These use cases apply to versioned machine types when used
   in combination with hardware virtualization extensions
   to execute guest code safely on the physical CPU at close-
   to-native speed"

Since imx8mp-evk won't be a versioned machine type, it is thus
trivially excluded, without us having to enumerate all machine
types int he docs.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


