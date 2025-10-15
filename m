Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C41CCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 14:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v928r-0005B1-15; Wed, 15 Oct 2025 10:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v928o-00058m-Ol
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v928b-0000ul-4X
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760537154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cCrddXcidIQ9A3To8IogeyAG+qxddUvlSZV1OOUZn9s=;
 b=L/tLTZYCsEdtnxbGykqJwdO6JZNY7TXkqVRnFZO1tKxlzr/R/+Q33Nq1HbzgJSO/2XnDpW
 JD4fKcswCn+4SP3o/lI9FFe1Nr/bH8qfslwoEMP7/h26G8b/w2AiegOWUKpk6uFDM0YYwE
 kcsYyAkgb0WVQ8NRyi8K2UpJcv3Yt3E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-d2QJO8QlOjqTxbd3qYbfhQ-1; Wed,
 15 Oct 2025 10:05:52 -0400
X-MC-Unique: d2QJO8QlOjqTxbd3qYbfhQ-1
X-Mimecast-MFC-AGG-ID: d2QJO8QlOjqTxbd3qYbfhQ_1760537149
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BDCB1860978; Wed, 15 Oct 2025 14:05:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62AE91953985; Wed, 15 Oct 2025 14:05:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E420C21E6A27; Wed, 15 Oct 2025 16:05:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,  Yanan Wang <wangyanan55@huawei.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5 2/3] hw/uefi: add 'info firmware-log' hmp monitor
 command.
In-Reply-To: <20251015120637.1736402-3-kraxel@redhat.com> (Gerd Hoffmann's
 message of "Wed, 15 Oct 2025 14:06:36 +0200")
References: <20251015120637.1736402-1-kraxel@redhat.com>
 <20251015120637.1736402-3-kraxel@redhat.com>
Date: Wed, 15 Oct 2025 16:05:42 +0200
Message-ID: <87cy6ob6q1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> This adds the hmp variant of the query-firmware-log qmp command.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/uefi/ovmf-log.c   | 27 +++++++++++++++++++++++++++
>  hmp-commands-info.hx | 13 +++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
> index 85dda15ab6ad..e281a980a101 100644
> --- a/hw/uefi/ovmf-log.c
> +++ b/hw/uefi/ovmf-log.c
> @@ -231,3 +231,30 @@ FirmwareLog *qmp_query_firmware_log(Error **errp)
>      ret->log = g_base64_encode((const guchar *)log->str, log->len);
>      return ret;
>  }
> +
> +void hmp_info_firmware_log(Monitor *mon, const QDict *qdict)
> +{
> +    g_autofree gchar *log_esc = NULL;
> +    g_autofree guchar *log_out = NULL;
> +    Error *err = NULL;
> +    FirmwareLog *log;
> +    gsize log_len;
> +
> +    log = qmp_query_firmware_log(&err);
> +    if (err)  {
> +        hmp_handle_error(mon, err);
> +        return;
> +    }
> +
> +    g_assert(log != NULL);
> +    g_assert(log->log != NULL);

QAPI ensures this, so I wouldn't bother myself.  Up to you.

> +
> +    if (log->version) {
> +        g_autofree gchar *esc = g_strescape(log->version, NULL);
> +        monitor_printf(mon, "[ firmware version: %s ]\n", esc);
> +    }
> +
> +    log_out = g_base64_decode(log->log, &log_len);
> +    log_esc = g_strescape((gchar *)log_out, "\r\n");
> +    monitor_printf(mon, "%s\n", log_esc);
> +}
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index eaaa880c1b30..f0aef419923c 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -990,3 +990,16 @@ SRST
>    ``info cryptodev``
>      Show the crypto devices.
>  ERST
> +
> +    {
> +        .name       = "firmware-log",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show the firmware (ovmf) debug log",
> +        .cmd        = hmp_info_firmware_log,
> +    },
> +
> +SRST
> +  ``info firmware-log``
> +    Show the firmware (ovmf) debug log.
> +ERST

With the update of monitor/hmp.h moved here from PATCH 1
Reviewed-by: Markus Armbruster <armbru@redhat.com>


