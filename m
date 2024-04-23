Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5A0C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 10:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzDpC-0004rT-RX; Tue, 23 Apr 2024 06:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzDp8-0004qp-T9
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 06:56:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzDp6-0007jp-4K
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 06:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713869787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J8c3Fyi1pBUNFxJAAiarqfqftAmseD0yfDbT7jonBtY=;
 b=IEvI4C06DardzTB9uYX5LsO0zO/LNkJNm4nHscZWsLLqSTdxiXphDU8wjkiEKuky9afW0B
 TX38GJa2VrnrzdFWLYomzgAgOyAD3SYCjW2uZ74MoiUWCmHh6KO3QANASwYgWVyxoCIcSe
 xQbD/kzj2ZHaXB+v7S96tFJBQCleTk0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-vI45iBszNiubaTkIwKfzqw-1; Tue, 23 Apr 2024 06:56:23 -0400
X-MC-Unique: vI45iBszNiubaTkIwKfzqw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF8A5811000;
 Tue, 23 Apr 2024 10:56:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E6F5200A5C5;
 Tue, 23 Apr 2024 10:56:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1234321E6811; Tue, 23 Apr 2024 12:56:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <ankita@nvidia.com>,  <marcel.apfelbaum@gmail.com>,
 <philmd@linaro.org>,  <mst@redhat.com>,  <qemu-devel@nongnu.org>,  Dave
 Jiang <dave.jiang@intel.com>,  Huang Ying <ying.huang@intel.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  <eduardo@habkost.net>,
 <imammedo@redhat.com>,  <linux-cxl@vger.kernel.org>,
 <linuxarm@huawei.com>,  Michael Roth <michael.roth@amd.com>,  Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH 3/6] hw/acpi: Generic Port Affinity Structure support
In-Reply-To: <20240403102927.31263-4-Jonathan.Cameron@huawei.com> (Jonathan
 Cameron's message of "Wed, 3 Apr 2024 11:29:24 +0100")
References: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
 <20240403102927.31263-4-Jonathan.Cameron@huawei.com>
Date: Tue, 23 Apr 2024 12:56:21 +0200
Message-ID: <87r0ewcppm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> These are very similar to the recently added Generic Initiators
> but instead of representing an initiator of memory traffic they
> represent an edge point beyond which may lie either targets or
> initiators.  Here we add these ports such that they may
> be targets of hmat_lb records to describe the latency and
> bandwidth from host side initiators to the port.  A descoverable
> mechanism such as UEFI CDAT read from CXL devices and switches
> is used to discover the remainder fo the path and the OS can build
> up full latency and bandwidth numbers as need for work and data
> placement decisions.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  qapi/qom.json                            |  18 +++
>  include/hw/acpi/acpi_generic_initiator.h |  18 ++-
>  include/hw/pci/pci_bridge.h              |   1 +
>  hw/acpi/acpi_generic_initiator.c         | 141 +++++++++++++++++------
>  hw/pci-bridge/pci_expander_bridge.c      |   1 -
>  5 files changed, 141 insertions(+), 38 deletions(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 85e6b4f84a..5480d9ca24 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -826,6 +826,22 @@
>    'data': { 'pci-dev': 'str',
>              'node': 'uint32' } }
>  
> +
> +##
> +# @AcpiGenericPortProperties:
> +#
> +# Properties for acpi-generic-port objects.
> +#
> +# @pci-bus: PCI bus of the hostbridge associated with this SRAT entry

What's this exactly?  A QOM path?  A qdev ID?  Something else?

> +#
> +# @node: numa node associated with the PCI device

NUMA

Is this a NUMA node ID?

> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'AcpiGenericPortProperties',
> +  'data': { 'pci-bus': 'str',
> +            'node': 'uint32' } }
> +
>  ##
>  # @RngProperties:
>  #
> @@ -944,6 +960,7 @@
>  { 'enum': 'ObjectType',
>    'data': [
>      'acpi-generic-initiator',
> +    'acpi-generic-port',
>      'authz-list',
>      'authz-listfile',
>      'authz-pam',
> @@ -1016,6 +1033,7 @@
>    'discriminator': 'qom-type',
>    'data': {
>        'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
> +      'acpi-generic-port':          'AcpiGenericPortProperties',
>        'authz-list':                 'AuthZListProperties',
>        'authz-listfile':             'AuthZListFileProperties',
>        'authz-pam':                  'AuthZPAMProperties',

[...]


