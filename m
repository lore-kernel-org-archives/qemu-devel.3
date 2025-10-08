Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C2DCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NjK-0003Ka-BU; Wed, 08 Oct 2025 02:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6NjJ-0003KP-8D
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v6NjG-00043k-OT
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759905168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bnXhYHxiYf28m/vX97R0O4Dj/PyL1DkrfnBkN+mEfZw=;
 b=bSGpamuSZQkxaJylyvJgHRJxDY94gJeT9mRp3ITp+UT6uLUK129RYuCFp1izAZR+lm0TbA
 fS1KcG061P5D0CjkLJATLhpEIlaa0PybB1GFSo388vlsAeqQmLno70RiP88lmhpKuOQ9ul
 wJXmYgumUi+Fj3bV8kV3iPc+ADXB6/c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-kfqQl5o1NQqxmSVqFGnXsQ-1; Wed,
 08 Oct 2025 02:32:45 -0400
X-MC-Unique: kfqQl5o1NQqxmSVqFGnXsQ-1
X-Mimecast-MFC-AGG-ID: kfqQl5o1NQqxmSVqFGnXsQ_1759905163
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DEEC7180034A; Wed,  8 Oct 2025 06:32:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEA3F1800576; Wed,  8 Oct 2025 06:32:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5BFAD21E6A27; Wed, 08 Oct 2025 08:32:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <lvivier@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Yanan Wang <wangyanan55@huawei.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>,  Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2] hw/uefi: add "info ovmf-log" + "query-ovmf-log"
 monitor commands
In-Reply-To: <20251007135216.1687648-1-kraxel@redhat.com> (Gerd Hoffmann's
 message of "Tue, 7 Oct 2025 15:52:16 +0200")
References: <20251007135216.1687648-1-kraxel@redhat.com>
Date: Wed, 08 Oct 2025 08:32:39 +0200
Message-ID: <87347toqd4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

Gerd Hoffmann <kraxel@redhat.com> writes:

> Starting with the edk2-stable202508 tag OVMF (and ArmVirt too) have
> optional support for logging to a memory buffer.  There is guest side
> support -- for example in linux kernels v6.17+ -- to read that buffer.
> But that might not helpful if your guest stops booting early enough that
> guest tooling can not be used yet.  So host side support to read that
> log buffer is a useful thing to have.
>
> This patch implements both qmp and hmp monitor commands to read the
> firmware log.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

[...]

> diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
> index cf718761861d..ffdb7e979e0f 100644
> --- a/tests/qtest/qmp-cmd-test.c
> +++ b/tests/qtest/qmp-cmd-test.c
> @@ -52,6 +52,8 @@ static int query_error_class(const char *cmd)
>          /* Only valid with accel=tcg */
>          { "x-query-jit", ERROR_CLASS_GENERIC_ERROR },
>          { "xen-event-list", ERROR_CLASS_GENERIC_ERROR },
> +        /* requires firmware with memory buffer logging support */
> +        { "query-ovmf-log", ERROR_CLASS_GENERIC_ERROR },
>          { NULL, -1 }
>      };
>      int i;

Makes sense.

> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 6142f60e7b16..eca0614903d1 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -977,3 +977,16 @@ SRST
>    ``info cryptodev``
>      Show the crypto devices.
>  ERST
> +
> +    {
> +        .name       = "ovmf-log",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show the ovmf debug log",
> +        .cmd_info_hrt = qmp_query_ovmf_log,
> +    },
> +
> +SRST
> +  ``info ovmf-log``
> +    Show the ovmf debug log.
> +ERST
> diff --git a/hw/uefi/meson.build b/hw/uefi/meson.build
> index 91eb95f89e6d..c8f38dfae247 100644
> --- a/hw/uefi/meson.build
> +++ b/hw/uefi/meson.build
> @@ -1,4 +1,4 @@
> -system_ss.add(files('hardware-info.c'))
> +system_ss.add(files('hardware-info.c', 'ovmf-log.c'))
>  
>  uefi_vars_ss = ss.source_set()
>  if (config_all_devices.has_key('CONFIG_UEFI_VARS'))
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 038eab281c78..329034035029 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1839,6 +1839,16 @@
>    'returns': 'HumanReadableText',
>    'features': [ 'unstable' ]}
>  
> +##
> +# @query-ovmf-log:
> +#
> +# Find firmware memory log buffer in guest memory, return content.
> +#
> +# Since: 10.2
> +##
> +{ 'command': 'query-ovmf-log',
> +  'returns': 'HumanReadableText' }

All other commands returning HumanReadableText are unstable.  Does this
one need to be stable?  If yes, why?

> +
>  ##
>  # @dump-skeys:
>  #


