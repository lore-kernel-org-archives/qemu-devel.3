Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FC3C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoNr-00006K-BC; Wed, 21 Feb 2024 10:19:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcoKC-0001XF-EX
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:16:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcluz-00088c-25
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 07:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708519304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hfCTcbflO1YjVk3OzUtGo+Ok/3XvaaHLHZiWYZpHLsE=;
 b=L6j4F8Fie2m+OTpEH+2ROGLcei+OvVpYjl7tOsiioG1KjHIr63sZBvD1v3g+7NY48VhdFA
 hDw9hTucEUzMOtXlYe+sDs5RBZHvdguOhG5QCwHq6Xv3XJiBrXmXFHHJhSGHqqZof5EH3Y
 SEeQXczlxy+OVYOoZzV8pPGrSrC+klE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-SUvk1-neMiWrj2J9JMWqhw-1; Wed, 21 Feb 2024 07:41:39 -0500
X-MC-Unique: SUvk1-neMiWrj2J9JMWqhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4ED9A82DFE1;
 Wed, 21 Feb 2024 12:41:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 801DE8CE8;
 Wed, 21 Feb 2024 12:41:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 639E121E66C8; Wed, 21 Feb 2024 13:41:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  qemu-devel@nongnu.org,
 kvm@vger.kernel.org,  Babu Moger <babu.moger@amd.com>,  Xiaoyao Li
 <xiaoyao.li@intel.com>,  Zhenyu Wang <zhenyu.z.wang@intel.com>,  Zhuocheng
 Ding <zhuocheng.ding@intel.com>,  Yongwei Ma <yongwei.ma@intel.com>,  Zhao
 Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v8 00/21] Introduce smp.modules for x86 in QEMU
In-Reply-To: <20240131101350.109512-1-zhao1.liu@linux.intel.com> (Zhao Liu's
 message of "Wed, 31 Jan 2024 18:13:29 +0800")
References: <20240131101350.109512-1-zhao1.liu@linux.intel.com>
MTo: Zhao Liu <zhao1.liu@linux.intel.com>
Date: Wed, 21 Feb 2024 13:41:35 +0100
Message-ID: <87plwqgfb4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Zhao Liu <zhao1.liu@linux.intel.com> writes:

> From: Zhao Liu <zhao1.liu@intel.com>
>
> Hi list,
>
> This is the our v8 patch series, rebased on the master branch at the
> commit 11be70677c70 ("Merge tag 'pull-vfio-20240129' of
> https://github.com/legoater/qemu into staging").
>
> Compared with v7 [1], v8 mainly has the following changes:
>   * Introduced smp.modules for x86 instead of reusing current
>     smp.clusters.
>   * Reworte the CPUID[0x1F] encoding.
>
> Given the code change, I dropped the most previously gotten tags
> (Acked-by/Reviewed-by/Tested-by from Michael & Babu, thanks for your
> previous reviews and tests!) in v8.
>
> With the description of the new modules added to x86 arch code in v7 [1]
> cover letter, the following sections are mainly the description of
> the newly added smp.modules (since v8) as supplement.
>
> Welcome your comments!
>
>
> Why We Need a New CPU Topology Level
> ====================================
>
> For the discussion in v7 about whether we should reuse current
> smp.clusters for x86 module, the core point is what's the essential
> differences between x86 module and general cluster.
>
> Since, cluster (for ARM/riscv) lacks a comprehensive and rigorous
> hardware definition, and judging from the description of smp.clusters
> [2] when it was introduced by QEMU, x86 module is very similar to
> general smp.clusters: they are all a layer above existing core level
> to organize the physical cores and share L2 cache.
>
> However, after digging deeper into the description and use cases of
> cluster in the device tree [3], I realized that the essential
> difference between clusters and modules is that cluster is an extremely
> abstract concept:
>   * Cluster supports nesting though currently QEMU doesn't support
>     nested cluster topology. However, modules will not support nesting.
>   * Also due to nesting, there is great flexibility in sharing resources
>     on clusters, rather than narrowing cluster down to sharing L2 (and
>     L3 tags) as the lowest topology level that contains cores.
>   * Flexible nesting of cluster allows it to correspond to any level
>     between the x86 package and core.
>
> Based on the above considerations, and in order to eliminate the naming
> confusion caused by the mapping between general cluster and x86 module
> in v7, we now formally introduce smp.modules as the new topology level.
>
>
> Where to Place Module in Existing Topology Levels
> =================================================
>
> The module is, in existing hardware practice, the lowest layer that
> contains the core, while the cluster is able to have a higher topological
> scope than the module due to its nesting.
>
> Thereby, we place the module between the cluster and the core, viz:
>
>     drawer/book/socket/die/cluster/module/core/thread
>
>
> Additional Consideration on CPU Topology
> ========================================
>
> Beyond this patchset, nowadays, different arches have different topology
> requirements, and maintaining arch-agnostic general topology in SMP
> becomes to be an increasingly difficult thing due to differences in
> sharing resources and special flexibility (e.g., nesting):
>   * It becomes difficult to put together all CPU topology hierarchies of
>     different arches to define complete topology order.
>   * It also becomes complex to ensure the correctness of the topology
>     calculations.
>       - Now the max_cpus is calculated by multiplying all topology
>         levels, and too many topology levels can easily cause omissions.
>
> Maybe we should consider implementing arch-specfic topology hierarchies.
>
>
> [1]: https://lore.kernel.org/qemu-devel/20240108082727.420817-1-zhao1.liu@linux.intel.com/
> [2]: https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg04051.html
> [3]: https://www.kernel.org/doc/Documentation/devicetree/bindings/cpu/cpu-topology.txt

Have you considered putting an abridged version of your lovely rationale
into a commit message, so it can be found later more easily?


