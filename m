Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4215CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 11:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6p1W-00082G-1a; Thu, 09 Oct 2025 07:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6p1Q-00081l-BF
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 07:41:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6p1I-0005C6-4C
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 07:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760010070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6LBwgHAck6qzLtHSd098K7JOIjp1DnHZWDlC6UXD1V4=;
 b=UW1yvSmbq7GmREpmJ+LH6/mzlrJYCSa4+DyVDAMZ7VSfuXpYs5CZY2wjW5tcv/pcP2KMRS
 lW+JmxpVBl9rEXkaUZXtRh9jTKxaXImp+giQ9T9/VX/nfO3mRBaf9uIm/+M2GOClJ2YO+3
 eloxLWx/RA/80e4dnz7Zr9FX6oFgF04=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-KnlBGFbJO9G_68MLWcG5yg-1; Thu,
 09 Oct 2025 07:41:06 -0400
X-MC-Unique: KnlBGFbJO9G_68MLWcG5yg-1
X-Mimecast-MFC-AGG-ID: KnlBGFbJO9G_68MLWcG5yg_1760010064
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCE94197752F; Thu,  9 Oct 2025 11:40:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 645E51944A8A; Thu,  9 Oct 2025 11:40:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4746B21E6A27; Thu, 09 Oct 2025 13:40:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,  Daniel P . =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>,  Xiaoyao Li <xiaoyao.li@intel.com>,
 qemu-devel@nongnu.org,  kvm@vger.kernel.org,  Zhenyu Wang
 <zhenyu.z.wang@intel.com>,  Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Babu Moger <babu.moger@amd.com>,  Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v9 02/21] hw/core/machine: Support modules in -smp
In-Reply-To: <87plwgzzc4.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 28 Feb 2024 10:56:43 +0100")
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <20240227103231.1556302-3-zhao1.liu@linux.intel.com>
 <87plwgzzc4.fsf@pond.sub.org>
Date: Thu, 09 Oct 2025 13:40:36 +0200
Message-ID: <87jz14qp57.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Zhao Liu <zhao1.liu@linux.intel.com> writes:
>
>> From: Zhao Liu <zhao1.liu@intel.com>
>>
>> Add "modules" parameter parsing support in -smp.
>>
>> Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>
> QAPI schema
> Acked-by: Markus Armbruster <armbru@redhat.com>

I missed something.  The patch added @modules without updating "The
ordering from ...":

    ##
    # @SMPConfiguration:
    #
    # Schema for CPU topology configuration.  A missing value lets QEMU
    # figure out a suitable value based on the ones that are provided.
    #
    # The members other than @cpus and @maxcpus define a topology of
    # containers.
    #
--> # The ordering from highest/coarsest to lowest/finest is: @drawers,
--> # @books, @sockets, @dies, @clusters, @cores, @threads.

Where does it go in this list?

The order below suggests between @clusters and @modules.

    #
    # Different architectures support different subsets of topology
    # containers.
    #
    # For example, s390x does not have clusters and dies, and the socket
    # is the parent container of cores.
    #
    # @cpus: number of virtual CPUs in the virtual machine
    #
    # @maxcpus: maximum number of hotpluggable virtual CPUs in the virtual
    #     machine
    #
    # @drawers: number of drawers in the CPU topology (since 8.2)
    #
    # @books: number of books in the CPU topology (since 8.2)
    #
    # @sockets: number of sockets per parent container
    #
    # @dies: number of dies per parent container
    #
    # @clusters: number of clusters per parent container (since 7.0)
    #
    # @modules: number of modules per parent container (since 9.1)
    #
    # @cores: number of cores per parent container
    #
    # @threads: number of threads per core
    #
    # Since: 6.1
    ##


