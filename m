Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF2ACAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 14:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvzdu-0001b6-VB; Tue, 09 Sep 2025 10:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uvzds-0001aT-MV
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:48:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uvzdl-0004pe-EC
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 10:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757429288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S7K2qM1PAiI1ubms+Dwy7V8EYRo11d4cHmDiCJE3V+c=;
 b=D0NVjwlQFMLlnIGwDirZiNVbU6yupPMJEd8NytovZqgPnNsqrezUsceeB32lwbea2bdnJ8
 U4YKQV3KUKZSPqqKunG+Tsb6LHqHxvBLLVH9T1Xw2MEiebuaJ25kU+y117H1fUrbpGB0QM
 zjj8LbRK2d6dr4QorOLfp/RIpdBSMwk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-JVqZ21gJNbeNMAYNW1133w-1; Tue,
 09 Sep 2025 10:48:04 -0400
X-MC-Unique: JVqZ21gJNbeNMAYNW1133w-1
X-Mimecast-MFC-AGG-ID: JVqZ21gJNbeNMAYNW1133w_1757429282
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E48D41800656; Tue,  9 Sep 2025 14:47:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 567831956045; Tue,  9 Sep 2025 14:47:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 23D9C21E6A27; Tue, 09 Sep 2025 16:47:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,  Davidlohr Bueso
 <dave@stgolabs.net>,  ira.weiny@intel.com,  alucerop@amd.com,
 a.manzanares@samsung.com,  linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 1/4] hw/pcie: Support enabling flit mode
In-Reply-To: <20250811125552-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Mon, 11 Aug 2025 12:57:01 -0400")
References: <20250811033405.332295-1-dave@stgolabs.net>
 <20250811033405.332295-2-dave@stgolabs.net>
 <20250811165741.00003aa2@huawei.com>
 <20250811125552-mutt-send-email-mst@kernel.org>
Date: Tue, 09 Sep 2025 16:47:48 +0200
Message-ID: <87qzwfvg17.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Aug 11, 2025 at 04:57:41PM +0100, Jonathan Cameron wrote:
>> On Sun, 10 Aug 2025 20:34:02 -0700
>> Davidlohr Bueso <dave@stgolabs.net> wrote:
>> 
>> > As with the link speed and width training, have ad-hoc property for
>> > setting the flit mode and allow CXL components to make use of it.

I understand this is property "256b-flit".

> I note we didn't make it a stable API for width, want to
> prefix this one with "x-", too?

The only use of "256b-flit" is in docs/system/devices/cxl.rst [PATCH
4/4]:

    diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
    index bf7908429af8..4815de0f2dc4 100644
    --- a/docs/system/devices/cxl.rst
    +++ b/docs/system/devices/cxl.rst
    @@ -384,6 +384,29 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
       -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,sn=0x4 \
       -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k

    +An example of 4 type3 devices with volatile memory below a switch. Two of the devices
    +use HDM-DB for coherence::
    +
    +  qemu-system-x86_64 -M q35,cxl=on -m 4G,maxmem=8G,slots=8 -smp 4 \
    +  ...
    +  -object memory-backend-file,id=cxl-mem0,share=on,mem-path=/tmp/cxltest.raw,size=256M \
    +  -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest1.raw,size=256M \
    +  -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M \
    +  -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/cxltest3.raw,size=256M \
    +  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
    +  -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
    +  -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
--> +  -device cxl-upstream,bus=root_port0,id=us0,256b-flit=on \
    +  -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
--> +  -device cxl-type3,bus=swport0,volatile-memdev=cxl-mem0,id=cxl-mem0,sn=0x1,256b-flit=on,hdm-db=on \
    +  -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
--> +  -device cxl-type3,bus=swport1,volatile-memdev=cxl-mem1,id=cxl-mem1,sn=0x2,256b-flit=on,hdm-db=on \
    +  -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
    +  -device cxl-type3,bus=swport2,volatile-memdev=cxl-mem2,id=cxl-mem2,sn=0x3 \
    +  -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
    +  -device cxl-type3,bus=swport3,volatile-memdev=cxl-mem3,id=cxl-mem3,sn=0x4 \
    +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
    +

The purpose of 256b-flit=on is not explained there.  The only hint I can
find is in the commit message: "Devices require enabling Flit mode."
Which devices require what and when is less than clear.  Maybe hdm-db=on
requires 256b-flit=on?

Why does device cxl-upstream use 256b-flit=on without hdm-db=on?

I can't see where property "hdm-db" is defined.  Davidlohr, can you show
me?

I doubt users can figure out how to use this unless they're intimately
familiar with... what exactly?

>> > For the CXL root port and dsp cases, always report flit mode but
>> > the actual value after 'training' will depend on the downstream
>> > device configuration.
>> > 
>> > Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> 
>> Definitely include PCI maintainers on this.
>> +CC Michael, and Marcel.
>> 
>> Also Markus for command line bits.
>> 
>> Looks good to me.
>> 
>> Jonathan

[...]


