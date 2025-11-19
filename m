Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFE7CF34A1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 13:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLiLs-0001QV-1B; Wed, 19 Nov 2025 08:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vLiLl-0001P5-RN
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:35:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vLiLi-0000jH-VD
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 08:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763559352;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3WlUOQIxwdIljy6YeUgG8qobydVquMhaPXGSQAcA6to=;
 b=Q7twRHn/fzlKzrkpxXkcmrb0lePJDff0JArLqe1V0ocSIFqMedRw6/yrSVsIHxZJkMpzdz
 gJecNyqSQqFN2ebIkzLPD7h+Qf9arC/gLRkvUZgCdfdlvclkZMtd69cFUSDCL9RPYw8GEw
 HMz8H2tBnGdIZt+Ho+vCbf80ZN1KVUM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-8SZqLeL1Mm6WPxvtRPhmAQ-1; Wed,
 19 Nov 2025 08:35:48 -0500
X-MC-Unique: 8SZqLeL1Mm6WPxvtRPhmAQ-1
X-Mimecast-MFC-AGG-ID: 8SZqLeL1Mm6WPxvtRPhmAQ_1763559345
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B402519560A7; Wed, 19 Nov 2025 13:35:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69E29180049F; Wed, 19 Nov 2025 13:35:35 +0000 (UTC)
Date: Wed, 19 Nov 2025 13:35:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 kwolf@redhat.com, hreitz@redhat.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, gengdongjiu1@gmail.com,
 peter.maydell@linaro.org, alistair@alistair23.me,
 edgar.iglesias@gmail.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 palmer@dabbelt.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, sstabellini@kernel.org,
 anthony@xenproject.org, paul@xen.org, peterx@redhat.com,
 farosas@suse.de, eblake@redhat.com, vsementsov@yandex-team.ru,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH 5/5] error: Consistently name Error * objects err, and
 not errp
Message-ID: <aR3HpH88od11v8qL@redhat.com>
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-6-armbru@redhat.com>
 <3ffe11b9-db81-4930-aefa-e55d758645bf@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ffe11b9-db81-4930-aefa-e55d758645bf@citrix.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Nov 19, 2025 at 01:22:06PM +0000, Andrew Cooper wrote:
> On 19/11/2025 1:08 pm, Markus Armbruster wrote:
> > diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
> > index b93ff80c85..3e62ec09d0 100644
> > --- a/hw/xen/xen-pvh-common.c
> > +++ b/hw/xen/xen-pvh-common.c
> > @@ -101,7 +101,7 @@ static void xen_create_virtio_mmio_devices(XenPVHMachineState *s)
> >  #ifdef CONFIG_TPM
> >  static void xen_enable_tpm(XenPVHMachineState *s)
> >  {
> > -    Error *errp = NULL;
> > +    Error *err = NULL;
> >      DeviceState *dev;
> >      SysBusDevice *busdev;
> >  
> > @@ -111,8 +111,15 @@ static void xen_enable_tpm(XenPVHMachineState *s)
> >          return;
> >      }
> >      dev = qdev_new(TYPE_TPM_TIS_SYSBUS);
> > -    object_property_set_link(OBJECT(dev), "tpmdev", OBJECT(be), &errp);
> > -    object_property_set_str(OBJECT(dev), "tpmdev", be->id, &errp);
> > +    /*
> > +     * FIXME This use of &err is is wrong.  If both calls fail, the
> > +     * second will trip error_setv()'s assertion.  If just one call
> > +     * fails, we leak an Error object.  Setting the same property
> > +     * twice (first to a QOM path, then to an ID string) is almost
> > +     * certainly wrong, too.
> > +     */
> > +    object_property_set_link(OBJECT(dev), "tpmdev", OBJECT(be), &err);
> > +    object_property_set_str(OBJECT(dev), "tpmdev", be->id, &err);
> 
> To your question, I don't know the answer, but I think it's far more
> likely that the original author didn't grok the proper use of &errp,
> than for this behaviour to be intentional.
> 
> Surely we just want a failure path and abort the construction if this
> goes wrong?

In the caller of xen_enable_tpm, we just have error_report+exit calls,
so there's no error propagation ability in the call chain.

The caller will also skip  xen_enable_tpm unless a TPM was explicitly
requested in the config.

Given that, I'm inclined to say that the object_property_set_* calls
in xen_enable_tpm should be using &error_abort, as a failure to setup
the explicitly requested TPM should be fatal.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


