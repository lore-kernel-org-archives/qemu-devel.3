Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCF4C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 12:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx4Ni-0000VS-Tj; Wed, 17 Apr 2024 08:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rx4Nh-0000VJ-PQ
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 08:27:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rx4Nf-0001Lg-S0
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 08:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713356833;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QJZeT+fshNMwXYlnJ65hZSRdezTXDJn03gT3oBGYSh8=;
 b=JdfvfSh3Kov1M9epmiuv0plscZpHiWWYKREaDAznkXmEzbkGI1F2aOu/qAqe1SeuqGeq8g
 JFU919ZcG933AVbRYi0jNiNpIgkZ+bXuuEA4byQZWbaY3AgjFDPrHvaBkebCXhIiNBZgCu
 8JbmMKgHeQlZVgtNPWsiMFYNX3Bm7ek=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-abKamUT5MUmtl7hnAxlqyw-1; Wed, 17 Apr 2024 08:27:10 -0400
X-MC-Unique: abKamUT5MUmtl7hnAxlqyw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB6C18021A5;
 Wed, 17 Apr 2024 12:27:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F1B512166B32;
 Wed, 17 Apr 2024 12:27:08 +0000 (UTC)
Date: Wed, 17 Apr 2024 13:27:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Anthony Harivel <aharivel@redhat.com>, pbonzini@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, vchundur@redhat.com,
 rjarry@redhat.com
Subject: Re: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <Zh_AF3YfiZeIAkCU@redhat.com>
References: <20240411121434.253353-1-aharivel@redhat.com>
 <20240411121434.253353-4-aharivel@redhat.com>
 <Zh+fRliUJ8sPcOpD@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zh+fRliUJ8sPcOpD@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
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

On Wed, Apr 17, 2024 at 06:07:02PM +0800, Zhao Liu wrote:
> Hi Anthony,
> 
> May I ask what your usage scenario is? Is it to measure Guest's energy
> consumption and to charged per watt consumed? ;-)
> 
> On Thu, Apr 11, 2024 at 02:14:34PM +0200, Anthony Harivel wrote:
> > Date: Thu, 11 Apr 2024 14:14:34 +0200
> > From: Anthony Harivel <aharivel@redhat.com>
> > Subject: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
> > 
> > Starting with the "Sandy Bridge" generation, Intel CPUs provide a RAPL
> > interface (Running Average Power Limit) for advertising the accumulated
> > energy consumption of various power domains (e.g. CPU packages, DRAM,
> > etc.).
> >
> > The consumption is reported via MSRs (model specific registers) like
> > MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are
> > 64 bits registers that represent the accumulated energy consumption in
> > micro Joules. They are updated by microcode every ~1ms.
> 
> What is your current target platform?

I think we can assume /all/ future CPUs are conceptially in scope
for this.

The use case is to allow guest owners to monitor the power consumption
of their workloads, so they can take steps to optimize their guest VM
workloads to reduce power consumed.

> On future Xeon platforms (EMR and beyond) RAPL will support TPMI (an MMIO
> interface) and the TPMI based RAPL will be preferred in the future as
> well:

Is the MSR based interface likely to be removed in future silicon,
or it will be remain for back compat ?

> * TPMI doc: https://github.com/intel/tpmi_power_management
> * TPMI based RAPL driver: drivers/powercap/intel_rapl_tpmi.c
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


