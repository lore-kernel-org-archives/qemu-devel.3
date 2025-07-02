Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5B1C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 08:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWsPB-00038v-Ps; Wed, 02 Jul 2025 04:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWsP1-00038a-MR
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 04:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWsOu-0006jj-8T
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 04:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751443261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dmTDRwRRNwzLNCsAO6xgUU9um33PXDbpNqV0jo0sQIs=;
 b=E90/BDjdRF9TSXhSULbsvVevC6dYgwE0oYhHv2dptZGvpiP41lw96tK8a5d3ic6rjqB+1j
 P43CnjSZCe9lYQw+05uK+KYrCxQWFqH7kSL9zaScPNV1LjB2nm100xgbJfoGMJJ2bWb0V+
 v/ZPh4RmVQloJGPc1xkZAjoOz6QgoTU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-ZfQMPrUsMzOADc4YJJcMAw-1; Wed,
 02 Jul 2025 04:00:58 -0400
X-MC-Unique: ZfQMPrUsMzOADc4YJJcMAw-1
X-Mimecast-MFC-AGG-ID: ZfQMPrUsMzOADc4YJJcMAw_1751443256
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 120641808993; Wed,  2 Jul 2025 08:00:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19C8A180045C; Wed,  2 Jul 2025 08:00:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BAD3B21E6A27; Wed, 02 Jul 2025 10:00:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Eric Blake <eblake@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?=
 <alex.bennee@linaro.org>,  Lukas Straub <lukasstraub2@web.de>,  Ani Sinha
 <anisinha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,  Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 07/18] qapi: add cross-references to Machine core
In-Reply-To: <20250613203620.1283814-8-jsnow@redhat.com> (John Snow's message
 of "Fri, 13 Jun 2025 16:36:09 -0400")
References: <20250613203620.1283814-1-jsnow@redhat.com>
 <20250613203620.1283814-8-jsnow@redhat.com>
Date: Wed, 02 Jul 2025 10:00:52 +0200
Message-ID: <874ivvqax7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>

[...]

> diff --git a/qapi/machine.json b/qapi/machine.json
> index 6aa8abe6cce..a18c23a273c 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json

[...]

> @@ -1107,23 +1107,23 @@
>  ##
>  # @balloon:
>  #
> -# Request the balloon driver to change its balloon size.
> +# Request the `balloon` driver to change its `balloon` size.

The balloon driver is not the ballon command, and the ballon size isn't
the balloon command size, so no.

>  #
>  # @value: the target logical size of the VM in bytes.  We can deduce
> -#     the size of the balloon using this formula:
> +#     the size of the `balloon` using this formula:
>  #
>  #        logical_vm_size = vm_ram_size - balloon_size
>  #
>  #     From it we have: balloon_size = vm_ram_size - @value
>  #
>  # Errors:
> -#     - If the balloon driver is enabled but not functional because
> +#     - If the `balloon` driver is enabled but not functional because
>  #       the KVM kernel module cannot support it, KVMMissingCap
> -#     - If no balloon device is present, DeviceNotActive
> +#     - If no `balloon` device is present, DeviceNotActive
>  #
>  # .. note:: This command just issues a request to the guest.  When it
> -#    returns, the balloon size may not have changed.  A guest can
> -#    change the balloon size independent of this command.
> +#    returns, the `balloon` size may not have changed.  A guest can
> +#    change the `balloon` size independent of this command.
>  #
>  # Since: 0.14
>  #
> @@ -1142,7 +1142,7 @@
>  ##
>  # @BalloonInfo:
>  #
> -# Information about the guest balloon device.
> +# Information about the guest `balloon` device.
>  #
>  # @actual: the logical size of the VM in bytes.  Formula used:
>  #     logical_vm_size = vm_ram_size - balloon_size
> @@ -1154,12 +1154,12 @@
>  ##
>  # @query-balloon:
>  #
> -# Return information about the balloon device.
> +# Return information about the `balloon` device.
>  #
>  # Errors:
> -#     - If the balloon driver is enabled but not functional because
> +#     - If the `balloon` driver is enabled but not functional because
>  #       the KVM kernel module cannot support it, KVMMissingCap
> -#     - If no balloon device is present, DeviceNotActive
> +#     - If no `balloon` device is present, DeviceNotActive
>  #
>  # Since: 0.14
>  #
> @@ -1979,7 +1979,7 @@
>  #
>  # The result of a CPU model baseline.
>  #
> -# @model: the baselined CpuModelInfo.
> +# @model: the baselined `CpuModelInfo`.
>  #
>  # Since: 2.8
>  ##

No to all of these :)

[...]


