Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF84E95392
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncaS-0002ls-Kl; Wed, 04 Feb 2026 08:06:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vncaC-0002gA-4W
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:06:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vnca8-0006u9-2K
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770210366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mqc8AxyZ7VYeu2sn8lyozL6Sjl0PC5lYsb/VRIxk4o4=;
 b=ScaO61Du8UkdfepHx7D/J/cIyvwY8CtukXjmLgqigcJMLQcVAXQnnSc5cLMFuj4Q5lVncL
 svKnOaH8Qeb5U8hrt7rVH7DTXizULiroXDQr7J3Deps0r3cVj8H/8NBWjb1A50/SLvfJSQ
 qgrjccCTiGkw9Bk/vRc4LSdgvEg8qnY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-K9RMfiq7N_a58gFg7tBGGg-1; Wed,
 04 Feb 2026 08:06:02 -0500
X-MC-Unique: K9RMfiq7N_a58gFg7tBGGg-1
X-Mimecast-MFC-AGG-ID: K9RMfiq7N_a58gFg7tBGGg_1770210361
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FD1518002C2; Wed,  4 Feb 2026 13:06:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0E261955D88; Wed,  4 Feb 2026 13:05:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 674D921E692D; Wed, 04 Feb 2026 14:05:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Ben Chaney <bchaney@akamai.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  "Michael S. Tsirkin" <mst@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Alex
 Williamson <alex@shazbot.org>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Stefan Weil <sw@weilnetz.de>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,
 Hamza Khan <hamza.khan@nutanix.com>,  Mark Kanda <mark.kanda@oracle.com>,
 Joshua Hunt <johunt@akamai.com>,  Max Tottenham <mtottenh@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH v4 6/8] tap: cpr support
In-Reply-To: <20260128-cpr-tap-v4-6-48e334d4216b@akamai.com> (Ben Chaney's
 message of "Wed, 28 Jan 2026 15:39:34 -0500")
References: <20260128-cpr-tap-v4-0-48e334d4216b@akamai.com>
 <20260128-cpr-tap-v4-6-48e334d4216b@akamai.com>
Date: Wed, 04 Feb 2026 14:05:57 +0100
Message-ID: <87y0l8wte2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ben Chaney <bchaney@akamai.com> writes:

> Provide the cpr=on option to preserve TAP and vhost descriptors during
> cpr-transfer, so the management layer does not need to create a new
> device for the target.
>
> Save all tap fd's in order with the tap device fds saved first,
> and the vhostfd saved after.
>
> Example:
>
> -netdev tap,id=hostnet2,cpr=on
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Signed-off-by: Ben Chaney <bchaney@akamai.com>

[...]

> diff --git a/qapi/net.json b/qapi/net.json
> index 118bd34965..4b12fca94b 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -355,6 +355,9 @@
>  # @poll-us: maximum number of microseconds that could be spent on busy
>  #     polling for tap (since 2.7)
>  #
> +# @cpr: preserve the state of this device and its associated file
> +#     descriptors during cpr-transfer for reduced migration downtime

(default: false) (since 11.0)

> +#
>  # Since: 1.2
>  ##
>  { 'struct': 'NetdevTapOptions',
> @@ -373,7 +376,8 @@
>      '*vhostfds':   'str',
>      '*vhostforce': 'bool',
>      '*queues':     'uint32',
> -    '*poll-us':    'uint32'} }
> +    '*poll-us':    'uint32',
> +    '*cpr':        'bool'} }
>  
>  ##
>  # @NetdevSocketOptions:

With that, QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


