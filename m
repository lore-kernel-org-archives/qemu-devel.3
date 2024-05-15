Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50A3C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 16:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Hn2-0005gS-C2; Wed, 15 May 2024 12:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7Hmu-0005dU-6T
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7Hmp-0001NM-4u
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715791644;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gWEijKm6k78Xl/7UjceGkv/fNBkvskjud+VapspJi6Y=;
 b=hIX+aAK3EO9Uri/iW/9pYpvXa/Mdh5pNWOd/ZhiEOwl+krN/EpsI0Lr4J0tZw9ZvyM7x0n
 PIqo4/z091DIwnvYk19eZifRc0camTHvXTsB1rjIb9I5m3EkDUWmSPw9B8M0ucQAdLMCxG
 BlxIHZNbTuu1n2yLsxnEWSZSlpDjA4E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-4ga3eMuROa67FEAPzX01rg-1; Wed, 15 May 2024 12:47:21 -0400
X-MC-Unique: 4ga3eMuROa67FEAPzX01rg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 771FD185A783;
 Wed, 15 May 2024 16:47:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCFAF200B4D6;
 Wed, 15 May 2024 16:47:18 +0000 (UTC)
Date: Wed, 15 May 2024 17:47:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org,
 Eric Auger <eauger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH v9] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Message-ID: <ZkTnFBNsGosNYuOj@redhat.com>
References: <20240409024940.180107-1-shahuang@redhat.com>
 <Zh1j9b92UGPzr1-a@redhat.com> <Zjyb43JqMZA+bO4r@intel.com>
 <ZjyZ1ZV7BGME_bY9@redhat.com> <ZkG4nlwRnvz9oUXX@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZkG4nlwRnvz9oUXX@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, May 13, 2024 at 02:52:14PM +0800, Zhao Liu wrote:
> Hi Daniel,
> 
> > Please describe it in terms of a QAPI definition, as that's what we're
> > striving for with all QEMU public interfaces. Once the QAPI design is
> > agreed, then the -object mapping is trivial, as -object's JSON format
> > supports arbitrary QAPI structures.
> 
> Thank you for your guidance!
> 
> I rethought and and modified my previous proposal:
> 
> Let me show the command examples firstly:
>   * Add a single event:
>     (x86) -object kvm-pmu-event,id=e0,action=allow,format=x86-default,\
>                   select=0x3c,umask=0x00
>     (arm or general) -object kvm-pmu-event,id=e1,action=deny,\
>                              format=raw,code=0x01
>  
>   * Add a counter bitmap:
>     (x86) -object kvm-pmu-counter,id=cnt,action=allow,type=x86-fixed,\
>                   bitmap=0xffff0000
>  
>   * Add an event list (must use Json syntax format):
>    (x86) -object '{"qom-type":"kvm-pmu-event-list","id"="filter0","action"="allow","format"="x86-default","events=[{"select"=0x3c,"umask"=0x00},{"select"=0x2e,"umask"=0x4f}]'
>    (arm) -object '{"qom-type":"kvm-pmu-event-list","id"="filter1","action"="allow","format"="raw","events"=[{"code"=0x01},{"code"=0x02}]'
> 
> 
> The specific JSON definitions are as follows (IIUC, this is "in terms of
> a QAPI definition", right? ;-)): 
> * Define PMU event and counter bitmap with JSON format:
>   - basic filter action:
> 
>   { 'enum': 'KVMPMUFilterAction',
>     'prefix': 'KVM_PMU_FILTER_ACTION',
>     'data': ['deny', 'allow' ] }
> 
>   - PMU counter:
> 
>   { 'enum': 'KVMPMUCounterType',
>     'prefix': 'KVM_PMU_COUNTER_TYPE',
>     'data': [ 'x86-fixed' ] }
> 
>   { 'struct': 'KVMPMUX86FixedCounter',
>     'data': { 'bitmap': 'uint32' } }
> 
>   - PMU events (total 3 formats):
> 
>   # 3 encoding formats: "raw" is compatible with shaoqin's ARM format as
>   # well as the x86 raw format, and could support other architectures in
>   # the future.
>   { 'enum': 'KVMPMUEventEncodeFmt',
>     'prefix': 'KVM_PMU_EVENT_ENCODE_FMT',
>     'data': ['raw', 'x86-default', 'x86-masked-entry' ] }
> 
>   # A general format.
>   { 'struct': 'KVMPMURawEvent',
>     'data': { 'code': 'uint64' } }
> 
>   # x86-specific
>   { 'struct': 'KVMPMUX86DefalutEvent',
>     'data': { 'select': 'uint16',
>               'umask': 'uint16' } }
> 
>   # another x86 specific
>   { 'struct': 'KVMPMUX86MaskedEntry',
>     'data': { 'select': 'uint16',
>               'match': 'uint8',
>               'mask': 'uint8',
>               'exclude': 'bool' } }
> 
>   # And their list wrappers:
>   { 'struct': 'KVMPMURawEventList',
>     'data': { 'events': ['KVMPMURawEvent'] } }
> 
>   { 'struct': 'KVMPMUX86DefalutEventList',
>     'data': { 'events': ['KVMPMUX86DefalutEvent'] } }
> 
>   { 'struct': 'KVMPMUX86MaskedEntryList',
>     'data': { 'events': ['KVMPMUX86MaskedEntryList'] } }
> 
> 
> Based on the above basic structs, we could provide 3 new more qom-types:
>   - 'kvm-pmu-counter': 'KVMPMUFilterCounter'
> 
>   # This is a single object option to configure PMU counter
>   # bitmap filter.
>   { 'union': 'KVMPMUFilterCounter',
>     'base': { 'action': 'KVMPMUFilterAction',
>               'type': 'KVMPMUCounterType' },
>     'discriminator': 'type',
>     'data': { 'x86-fixed': 'KVMPMUX86FixedCounter' } }
> 
> 
>   - 'kvm-pmu-counter': 'KVMPMUFilterCounter'
> 
>   # This option is used to configure a single PMU event for
>   # PMU filter.
>   { 'union': 'KVMPMUFilterEvent',
>     'base': { 'action': 'KVMPMUFilterAction',
>               'format': 'KVMPMUEventEncodeFmt' },
>     'discriminator': 'format',
>     'data': { 'raw': 'KVMPMURawEvent',
>               'x86-default': 'KVMPMUX86DefalutEvent',
>               'x86-masked-entry': 'KVMPMUX86MaskedEntry' } }
> 
> 
>   - 'kvm-pmu-event-list': 'KVMPMUFilterEventList'
> 
>   # Used to configure multiple events.
>   { 'union': 'KVMPMUFilterEventList',
>     'base': { 'action': 'KVMPMUFilterAction',
>               'format': 'KVMPMUEventEncodeFmt' },
>     'discriminator': 'format',
>     'data': { 'raw': 'KVMPMURawEventList',
>               'x86-default': 'KVMPMUX86DefalutEventList',
>               'x86-masked-entry': 'KVMPMUX86MaskedEntryList' } }
> 
> 
> Compared to Shaoqin's original format, kvm-pmu-event-list is not able to
> enumerate events continuously (similar to 0x00-0x30 before), and now
> user must enumerate events one by one individually.
> 
> What do you think about the above 3 new commands?

I don't know enough about KVM PMU to give feedback on the specific
choices, but in terms of how to do QAPI design, this looks like a
good start.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


