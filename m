Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6EDC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 17:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwQBM-0002xG-2Y; Mon, 15 Apr 2024 13:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwQBL-0002x6-6I
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 13:31:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rwQBJ-0003xN-Gz
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 13:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713202308;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AydjyBs6LzOYz3Jy9BRREvazpy+lYPG1Un3sEr91ddI=;
 b=Ex8sK82dkmR7F2xHADo6yisGGl9KJ9WjOUYwz1blEF6KggvAVKgV42KIBTE4Z78+Ap5Pr0
 tIDxlb9XQ05aCUkuRE1KJejOkCPAusAmb0aSmKyb6YpiqhOFtu4LwgyX5OsDJ64Sh50ZBc
 NL63lm1kemWRgtqtAxE+77BzSXuqUuo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-52EMPevqN2m2nyBg4_8NjQ-1; Mon, 15 Apr 2024 13:31:46 -0400
X-MC-Unique: 52EMPevqN2m2nyBg4_8NjQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19D401887314;
 Mon, 15 Apr 2024 17:31:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B455CC13FA2;
 Mon, 15 Apr 2024 17:31:44 +0000 (UTC)
Date: Mon, 15 Apr 2024 18:31:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org,
 Eric Auger <eauger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, armbru@redhat.com
Subject: Re: [PATCH v8] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Message-ID: <Zh1ketp8cvLoYjok@redhat.com>
References: <20240312074849.71475-1-shahuang@redhat.com>
 <Zf2bbcpWYMWKZpNy@redhat.com>
 <1881554f-9183-4e01-8cda-0934f7829abf@redhat.com>
 <ZgE71v8uGDNihQ5H@redhat.com>
 <46f0c5ab-dee7-4cd4-844d-c418818e187c@redhat.com>
 <ZgwBvuCrTwKmA0IK@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgwBvuCrTwKmA0IK@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
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

On Tue, Apr 02, 2024 at 03:01:50PM +0200, Kevin Wolf wrote:
> Am 29.03.2024 um 04:45 hat Shaoqin Huang geschrieben:
> > Hi Daniel,
> > 
> > On 3/25/24 16:55, Daniel P. Berrangé wrote:
> > > On Mon, Mar 25, 2024 at 01:35:58PM +0800, Shaoqin Huang wrote:
> > > > Hi Daniel,
> > > > 
> > > > Thanks for your reviewing. I see your comments in the v7.
> > > > 
> > > > I have some doubts about what you said about the QAPI. Do you want me to
> > > > convert the current design into the QAPI parsing like the
> > > > IOThreadVirtQueueMapping? And we need to add new json definition in the
> > > > qapi/ directory?
> > 
> > I have defined the QAPI for kvm-pmu-filter like below:

> > @@ -2439,6 +2441,7 @@ static Property arm_cpu_properties[] = {
> >                          mp_affinity, ARM64_AFFINITY_INVALID),
> >      DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
> >      DEFINE_PROP_INT32("core-count", ARMCPU, core_count, -1),
> > +    DEFINE_PROP_KVM_PMU_FILTER("kvm-pmu-filter", ARMCPU, kvm_pmu_filter),
> >      DEFINE_PROP_END_OF_LIST()
> >  };
> > 
> > And I guess I can use the new json format input like below:
> > 
> > qemu-system-aarch64 \
> > 	-cpu host, '{"filter": [{"action": "a", "start": 0x10, "end": "0x11"}]}'
> > 
> > But it doesn't work. It seems like because the -cpu option doesn't
> > support json format parameter.
> > 
> > Maybe I'm wrong. So I want to double check with if the -cpu option
> > support json format nowadays?
> 
> As far as I can see, -cpu doesn't support JSON yet. But even if it did,
> your command line would be invalid because the 'host,' part isn't JSON.
> 
> > If the -cpu option doesn't support json format, how I can use the QAPI
> > for kvm-pmu-filter property?
> 
> This would probably mean QAPIfying all CPUs first, which sounds like a
> major effort.

I wonder if we can do a half-way house where we parse the JSON and
turn it into regular QemuOpts internally, and then just use QAPI
parsing for the filter property. IOW, publically give the illusion
that -cpu has been QAPI-ified, but without actually doing the hard
part yet. The idea being to avoid inventing a new cli syntax that
has no analogue to QAPI.
With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


