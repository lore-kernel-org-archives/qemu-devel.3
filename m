Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501FFD6ED2B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 13:24:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE7AE-0006t9-VR; Thu, 21 Nov 2024 08:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tE7AD-0006sj-LL
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 08:24:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tE7AB-0006YI-Mk
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 08:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732195441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YkdxfLxg6wDJzq1KoAfz4DcR2YRc1VOumPvRDp9+Ozc=;
 b=C5O1n8an2sNzD29WWzl2RIdFDX+B+G0zfNutasC3ISp0zICb76rgC8JlTrYAG7C113J378
 GWOROyiYLdxLeq98HC6931HtE11t9fwUOLylc3cKamMetKpH55P21FaXiLVBWLzTFBFAoZ
 jlUj+eVSqC3jOP4KCzLMJGRchjCRrwI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-xGL4gtUKMlCvdvRs1Our-Q-1; Thu,
 21 Nov 2024 08:24:00 -0500
X-MC-Unique: xGL4gtUKMlCvdvRs1Our-Q-1
X-Mimecast-MFC-AGG-ID: xGL4gtUKMlCvdvRs1Our-Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 264091955F10; Thu, 21 Nov 2024 13:23:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.95])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D03E919560A3; Thu, 21 Nov 2024 13:23:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8A2C721E6A28; Thu, 21 Nov 2024 14:23:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Eduardo Habkost <eduardo@habkost.net>,  Peter
 Maydell <peter.maydell@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Juraj Marcin <jmarcin@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?C=C3=A9dri?=
 =?utf-8?Q?c?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 09/12] qdev: Add machine_get_container()
In-Reply-To: <20241120215703.3918445-10-peterx@redhat.com> (Peter Xu's message
 of "Wed, 20 Nov 2024 16:57:00 -0500")
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-10-peterx@redhat.com>
Date: Thu, 21 Nov 2024 14:23:56 +0100
Message-ID: <87plmoiutv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> Add a helper to fetch machine containers.  Add some sanity check around.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/hw/qdev-core.h | 10 ++++++++++
>  hw/core/qdev.c         | 17 +++++++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 5be9844412..38edfb1b54 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -996,6 +996,16 @@ const char *qdev_fw_name(DeviceState *dev);
>  void qdev_assert_realized_properly(void);
>  Object *qdev_get_machine(void);
>  
> +/**
> + * machine_get_container:
> + * @name: The name of container to lookup
> + *
> + * Get a container of the machine (QOM path "/machine/XXX").

Suggest "/machine/NAME" here.

> + *
> + * Returns: the machine container object.
> + */
> +Object *machine_get_container(const char *name);
> +
>  /**
>   * qdev_get_human_name() - Return a human-readable name for a device
>   * @dev: The device. Must be a valid and non-NULL pointer.

[...]


