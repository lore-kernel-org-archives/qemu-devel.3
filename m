Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F2FD3C55E
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 07:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1hq1-00071i-Bn; Fri, 18 Oct 2024 03:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1hpz-00071L-QO
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 03:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1hpx-0006Vw-Q4
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 03:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729238152;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gNyzRNiHs0oc+XzfsXtXom6AwYaOyQqog0N49F4HPNQ=;
 b=IguI8ferQaEtU2yvyyUIqyTdJBvQEHCSmmBaXZZzP38jGbYTBDXGQ5RvTYRkMoYP89RuLL
 HXKZrpgDnNKI0KVsFb/4+I22yD/tVwvUE9k4m1iqQ/m3XXpOxq59HWc8MXAHf1sJ+qMY7s
 W4/q3JeBvGzrcnKS068HhcfprjtUYig=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-Sj6d6TAHOwuj_38ez3pBHw-1; Fri,
 18 Oct 2024 03:55:49 -0400
X-MC-Unique: Sj6d6TAHOwuj_38ez3pBHw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC94E19560B8; Fri, 18 Oct 2024 07:55:45 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBA3A19560AD; Fri, 18 Oct 2024 07:55:38 +0000 (UTC)
Date: Fri, 18 Oct 2024 08:55:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH v3 1/7] hw/core: Make CPU topology enumeration
 arch-agnostic
Message-ID: <ZxIUd9tMi9o1UVOS@redhat.com>
References: <20241012104429.1048908-1-zhao1.liu@intel.com>
 <20241012104429.1048908-2-zhao1.liu@intel.com>
 <ZxEte1KBwWuCdkb1@redhat.com> <ZxHJri+rgdGKf/0L@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxHJri+rgdGKf/0L@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Oct 18, 2024 at 10:36:30AM +0800, Zhao Liu wrote:
> Hi Daniel,
> 
> > > -/*
> > > - * CPUTopoLevel is the general i386 topology hierarchical representation,
> > > - * ordered by increasing hierarchical relationship.
> > > - * Its enumeration value is not bound to the type value of Intel (CPUID[0x1F])
> > > - * or AMD (CPUID[0x80000026]).
> > > - */
> > > -enum CPUTopoLevel {
> > > -    CPU_TOPO_LEVEL_INVALID,
> > > -    CPU_TOPO_LEVEL_SMT,
> > > -    CPU_TOPO_LEVEL_CORE,
> > > -    CPU_TOPO_LEVEL_MODULE,
> > > -    CPU_TOPO_LEVEL_DIE,
> > > -    CPU_TOPO_LEVEL_PACKAGE,
> > > -    CPU_TOPO_LEVEL_MAX,
> > > -};
> > > -
> > 
> > snip
> > 
> > > @@ -18,3 +18,47 @@
> > >  ##
> > >  { 'enum': 'S390CpuEntitlement',
> > >    'data': [ 'auto', 'low', 'medium', 'high' ] }
> > > +
> > > +##
> > > +# @CpuTopologyLevel:
> > > +#
> > > +# An enumeration of CPU topology levels.
> > > +#
> > > +# @invalid: Invalid topology level.
> > 
> > Previously all topology levels were internal to QEMU, and IIUC
> > this CPU_TOPO_LEVEL_INVALID appears to have been a special
> > value to indicate  the cache was absent ?
> 
> Now I haven't support this logic.
> x86 CPU has a "l3-cache" property, and maybe that property can be
> implemented or replaced by the "invalid" level support you mentioned.
> 
> > Now we're exposing this directly to the user as a settable
> > option. We need to explain what effect setting 'invalid'
> > has on the CPU cache config.
> 
> If user set "invalid", QEMU will report the error message:
> 
> qemu-system-x86_64: Invalid cache topology level: invalid. The topology should match valid CPU topology level
> 
> Do you think this error message is sufficient?

If the user cannot set 'invalid' as an input, and no QEMU interface
will emit, then ideally we would not define 'invalid' in the QAPI
schema at all.

This woudl require us to have some internal only way to record
"invalid", separately from the topology level, or with a magic
internal only constant that doesn't clash with the public enum
constants. I guess the latter would be less work e.g. we could
"abuse" the 'MAX' constant value

   #define CPU_TOPOLOGY_LEVEL_INVALID CPU_TOPOLOGY_LEVEL_MAX

or separate it with a negative value

   #define CPU_TOPOLOGY_LEVEL_INVALID -1


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


