Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE602C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 12:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9LrC-0002do-0s; Wed, 23 Sep 2026 08:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x9Lqz-0002cN-1k
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 08:13:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x9Lqx-00068E-7l
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 08:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790165613;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FsuGZaQ5464+gfPqQZsFyDFqhp8SJ1DY54shyteSqBU=;
 b=IvmOHB9M6Qr/Khl4oegGYl379M2iw6Yq7zujbYuP0wvU9KHzZ/2Wl7KN6mpgZPUyHDn+xk
 7hbelUeYAbsarqSMO5eeI1gB2K4wK9jjqYXJwFAvKKVjlvaYmhB2WO/W1KuCH63YGgH/BH
 b/IYgwhZOoXTMqmKRftLy/5RvQ90/Cc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-04GfPE3DMIu7VVHh66tc7Q-1; Wed,
 23 Sep 2026 08:13:29 -0400
X-MC-Unique: 04GfPE3DMIu7VVHh66tc7Q-1
X-Mimecast-MFC-AGG-ID: 04GfPE3DMIu7VVHh66tc7Q_1790165608
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A1D51955F1C; Wed, 23 Sep 2026 12:13:28 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F4D21956042; Wed, 23 Sep 2026 12:13:26 +0000 (UTC)
Date: Wed, 23 Sep 2026 13:13:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH 3/7] tests/lci/refresh: add parameter to override
 container registry
Message-ID: <arPCY7SOxipb0d0P@redhat.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921231458.3369-4-pierrick.bouvier@oss.qualcomm.com>
 <arLBBjS_T40wBa3X@redhat.com> <arLDQHOSRX-xcJum@redhat.com>
 <e97e1bb5-80c6-473d-b890-02f3cf9d0661@oss.qualcomm.com>
 <arLJAD64Vwer21My@redhat.com>
 <f193b3c9-bbd0-4ab5-8706-43407873ca5b@oss.qualcomm.com>
 <arLQljN_Y52KdjHW@redhat.com>
 <923147f1-4a20-4cb0-b2a1-ccce3450796d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <923147f1-4a20-4cb0-b2a1-ccce3450796d@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

On Tue, Sep 22, 2026 at 12:03:59PM -0700, Pierrick Bouvier wrote:
> On 9/22/2026 12:01 PM, Daniel P. Berrangé wrote:
> > On Tue, Sep 22, 2026 at 11:33:47AM -0700, Pierrick Bouvier wrote:
> >> On 9/22/2026 11:29 AM, Daniel P. Berrangé wrote:
> >>> On Tue, Sep 22, 2026 at 11:22:43AM -0700, Pierrick Bouvier wrote:
> >>>> On 9/22/2026 11:04 AM, Daniel P. Berrangé wrote:
> >>>>> On Tue, Sep 22, 2026 at 06:55:18PM +0100, Daniel P. Berrangé wrote:
> >>>>>> On Mon, Sep 21, 2026 at 11:14:54PM +0000, Pierrick Bouvier wrote:
> >>>>>>> We'll use this in next patch to switch FROM docker.io/library to
> >>>>>>> docker.io/amd64. It would not make sense to add a new target to
> >>>>>>> libvirt-ci for this, since it's just a variant of an existing target.
> >>>>>>> Simply replace container registry with arch specific one.
> >>>>>>
> >>>>>> We shouldn't need to add new targets to lcitool for this,
> >>>>>> rather it would be enhanced to include a list of arch
> >>>>>> specific container images.
> >>>>>>
> >>>>>> eg in
> >>>>>>
> >>>>>> https://gitlab.com/libvirt/libvirt-ci/-/blob/master/lcitool/facts/targets/debian-13.yml?ref_type=heads
> >>>>>>
> >>>>>> We would extend:
> >>>>>>
> >>>>>>   containers:
> >>>>>>     base: docker.io/library/debian:13-slim
> >>>>>>
> >>>>>> to allow for
> >>>>>>
> >>>>>>   containers:
> >>>>>>     base: docker.io/library/debian:13-slim
> >>>>>>     aarch64:  docker.io/amd64/debian:13-slim
> >>>>>>     ...more...
> >>>>>>
> >>>>>> such that we default to the 'base' image name, unless
> >>>>>> there is an arch specific name defined. That would be
> >>>>>> a fairly quick extension to impl in lcitool.
> >>>>>
> >>>>> Quicker than I thought.... take a look at this, which
> >>>>> I think will enable you to drop this patch and the
> >>>>> next one and get the same end result:
> >>>>>
> >>>>>   https://gitlab.com/libvirt/libvirt-ci/-/merge_requests/588
> >>>>>
> >>>>
> >>>> Very quick indeed, good job :)
> >>>>
> >>>> IIUC, when no host-arch is given, we keep on using base, but in case
> >>>> user specifies -host-arch, in this case we use one of specialized image
> >>>> (if available)?
> >>>
> >>> Actually it is indepedent of --host-arch.
> >>>
> >>> If --host-arch is omitted we default it to what uname() reports,
> >>> and the result then goes into the container image lookup, which
> >>> is optionally specialized per arch.
> >>>
> >>
> >> It works for QEMU needs, but would that be a safe default for other
> >> users of lcitool?
> > 
> > Yes, I think it ought to be OK.  If something unexpected crops up
> > we'll deal with it as needed.
> > 
> >> Technically, you can write portable Dockerfiles between arch. Our
> >> current debian-all-test is kind of an example of it (ignoring the change
> >> this series does).
> > 
> > True, but lcitool isn't guaranteeing it can be done, as we allow
> > output to filter per-arch, so there's always the risk of getting
> > the libpmem situation - IIRC it hits with 'xen-devel' too as some
> > arches lack Xen.
> > 
> > So realistically I think we would say lcitool container outputs
> > are arch specific.
> >
> 
> I'm good with this assumption. There are always small details that makes
> it hard to have truly portable Dockerfiles.
> 
> I'll wait for PR to be merged on libvirt-ci, then update current series
> with it for v2.

FYI, it is merged now.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


