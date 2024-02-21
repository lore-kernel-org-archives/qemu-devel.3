Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657A3C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoZO-00010F-32; Wed, 21 Feb 2024 10:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcoP1-0004hS-4l
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:20:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rclzc-0000st-NL
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 07:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708519589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5+iFDGsoywuH5+H7Hd1QIQz6/y36MS3F778kGZSKiq0=;
 b=Fa+EW8fGx9J5GRpTEBSl+550YmcAFZqjmNeneDPLPi25mEeO33gACNz1ZXrJZeutRolHKq
 5e6irX73ODsnWeDakoBK6kGils4vCo6wFzAGEJ5jGFszlRaViMqfAt0sn+zsQB/6YtYMix
 pe543f3hrzD8TmBwdiS6OGbB5FicNHk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-guzpp1vhOniCWJKEZF_cKg-1; Wed, 21 Feb 2024 07:46:23 -0500
X-MC-Unique: guzpp1vhOniCWJKEZF_cKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3E28845E61;
 Wed, 21 Feb 2024 12:46:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7533210800;
 Wed, 21 Feb 2024 12:46:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 67A6421E6740; Wed, 21 Feb 2024 13:46:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo
 Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eric Blake <eblake@redhat.com>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Sia Jee Heng
 <jeeheng.sia@starfivetech.com>,  qemu-devel@nongnu.org,
 kvm@vger.kernel.org,  qemu-riscv@nongnu.org,  qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,  Dapeng Mi
 <dapeng1.mi@linux.intel.com>,  Yongwei Ma <yongwei.ma@intel.com>,  Zhao
 Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 4/8] hw/core: Add cache topology options in -smp
In-Reply-To: <20240220092504.726064-5-zhao1.liu@linux.intel.com> (Zhao Liu's
 message of "Tue, 20 Feb 2024 17:25:00 +0800")
References: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
 <20240220092504.726064-5-zhao1.liu@linux.intel.com>
Date: Wed, 21 Feb 2024 13:46:21 +0100
Message-ID: <871q9656jm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
> Add "l1d-cache", "l1i-cache". "l2-cache", and "l3-cache" options in
> -smp to define the cache topology for SMP system.
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

[...]

> diff --git a/qapi/machine.json b/qapi/machine.json
> index d0e7f1f615f3..0a923ac38803 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1650,6 +1650,14 @@
>  #
>  # @threads: number of threads per core
>  #
> +# @l1d-cache: topology hierarchy of L1 data cache (since 9.0)
> +#
> +# @l1i-cache: topology hierarchy of L1 instruction cache (since 9.0)
> +#
> +# @l2-cache: topology hierarchy of L2 unified cache (since 9.0)
> +#
> +# @l3-cache: topology hierarchy of L3 unified cache (since 9.0)
> +#

Too terse, just like my review ;-P

>  # Since: 6.1
>  ##
>  { 'struct': 'SMPConfiguration', 'data': {
> @@ -1662,7 +1670,11 @@
>       '*modules': 'int',
>       '*cores': 'int',
>       '*threads': 'int',
> -     '*maxcpus': 'int' } }
> +     '*maxcpus': 'int',
> +     '*l1d-cache': 'str',
> +     '*l1i-cache': 'str',
> +     '*l2-cache': 'str',
> +     '*l3-cache': 'str' } }
>  
>  ##
>  # @x-query-irq:

[...]


