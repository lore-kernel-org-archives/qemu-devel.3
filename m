Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F8AF01814
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 09:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyR3D-0007HA-8c; Fri, 06 Mar 2026 04:00:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyR39-0007EA-Jj
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:00:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vyR36-0006iS-VN
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772787642;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AeP90lwPWF3vRccYxN3m/eVGvhVbc4ld/ZW2SUXuoio=;
 b=Tw2PNyBIvuKKqkWcHtGyQgzwPjfI0dMqgQ/255IOm/yVG9cUfn0JEqUVQTy/QlElATjiFr
 LrCSf9LAvULxZwSHFcsSnLeiDSu0OCIQtMJBvnUYKWXnpG/hfBse+w2allS2CL4Jm35gHp
 C18AyD9R2p0WG6kFQr5eI21mpY/oHq4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-sxUZMrPNMsCwCmSMm7EGxA-1; Fri,
 06 Mar 2026 04:00:40 -0500
X-MC-Unique: sxUZMrPNMsCwCmSMm7EGxA-1
X-Mimecast-MFC-AGG-ID: sxUZMrPNMsCwCmSMm7EGxA_1772787639
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20AFD1956054; Fri,  6 Mar 2026 09:00:39 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.197])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6B761800671; Fri,  6 Mar 2026 09:00:35 +0000 (UTC)
Date: Fri, 6 Mar 2026 09:00:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "clg@redhat.com" <clg@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/3] conf: add support for 'scalable_mode' and
 'first_stage' attributes to intel IOMMU
Message-ID: <aaqXnjKsqJm5-_H_@redhat.com>
References: <20251218110449.53658-1-zhenzhong.duan@intel.com>
 <20251218110449.53658-3-zhenzhong.duan@intel.com>
 <aUPk4f8PU1uenVN-@redhat.com>
 <IA3PR11MB9136424958A27E048C9CFF0D92B0A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <IA3PR11MB9136A7DF7A2EF4CD567DAAC7927AA@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA3PR11MB9136A7DF7A2EF4CD567DAAC7927AA@IA3PR11MB9136.namprd11.prod.outlook.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 06, 2026 at 02:20:18AM +0000, Duan, Zhenzhong wrote:
> 
> 
> >-----Original Message-----
> >From: Duan, Zhenzhong
> >Subject: RE: [PATCH 2/3] conf: add support for 'scalable_mode' and 'first_stage'
> >attributes to intel IOMMU
> >
> >>-----Original Message-----
> >>From: Daniel P. Berrangé <berrange@redhat.com>
> >>Subject: Re: [PATCH 2/3] conf: add support for 'scalable_mode' and
> >>'first_stage' attributes to intel IOMMU
> >>
> >>On Thu, Dec 18, 2025 at 06:04:48AM -0500, Zhenzhong Duan wrote:
> >>> Correspond to 'x-scalable-mode' and 'x-flts' properties in QEMU.
> >>
> >>The 'x-' prefix on these property names indicates QEMU considers
> >>them experimental / unstable, which makes them unsuitable for
> >>exposing from libvirt.  We need the QEMU implementation to become
> >>fully supported first.
> >
> >I see, thanks. I didn't know this rule before.
> >
> >CCing qemu vtd maintainer/reviewers and qemu-devel:
> >
> >Do you think we can drop 'x-' as we had "x-scalable-mode" more than 5 years and
> >"x-flts" more than 1 year?
> 
> Kindly ping, any comments?

Since the code change is pretty small, I'd suggest just sending a
patch proposal to make the change, and letting discussion happen
then.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


