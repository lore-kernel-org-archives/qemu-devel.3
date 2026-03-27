Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F55310ED679
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w67fj-0001x2-9e; Fri, 27 Mar 2026 09:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w67fh-0001wg-Qw
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 09:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w67ff-0001Qa-KP
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 09:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774619776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=18XX6t0QaTkcUsK1Xkq+Lwm/fm4+zwLvBudp8knxnxw=;
 b=XSE5HuIDRbQr+7FTcbSyp5jt9vlZ4lB0DfM4tG3CVYWXdfWHHucjKi/tRGYXP13HlKd4gR
 xN75cq/cdEN8T53zDgAMRmre+1N8/Ye/Xk4x5NQVjNggmPGSJp7efaHeeCgKKnxm+vCgEO
 AEhP1E1PuPBbfdDGVzKoZ0+wM3tPCq0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-UGtzxepCOeKLJN068qIuLQ-1; Fri,
 27 Mar 2026 09:56:12 -0400
X-MC-Unique: UGtzxepCOeKLJN068qIuLQ-1
X-Mimecast-MFC-AGG-ID: UGtzxepCOeKLJN068qIuLQ_1774619771
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE9AC19560A2; Fri, 27 Mar 2026 13:56:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CE071800671; Fri, 27 Mar 2026 13:56:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 048C321E6937; Fri, 27 Mar 2026 14:56:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  berrange@redhat.com,
 mst@redhat.com,  pbonzini@redhat.com
Subject: Re: [PATCH v3 2/3] hw/qdev: Prefix bus type in
 qdev_get_printable_name() device paths
In-Reply-To: <20260321100405.1525059-3-alessandro@0x65c.net> (Alessandro
 Ratti's message of "Sat, 21 Mar 2026 11:04:04 +0100")
References: <20260321100405.1525059-1-alessandro@0x65c.net>
 <20260321100405.1525059-3-alessandro@0x65c.net>
Date: Fri, 27 Mar 2026 14:56:08 +0100
Message-ID: <87ldfd4brb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Alessandro Ratti <alessandro@0x65c.net> writes:

> Raw get_dev_path() output (e.g. "0000:00:04.0", "/1") is ambiguous

"can be ambiguous" would be more precise.

> without knowing which bus produced it. Prefix the path with the bus
> type name so error messages become self-describing.
>
> Examples:
>   - PCIE device 0000:00:04.0
>   - virtio-pci-bus device 0000:00:03.0
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> ---
>  hw/core/qdev.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index c44616b4b8..904e710f8e 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -418,11 +418,13 @@ const char *qdev_get_printable_name(DeviceState *dev)
>      }
>      /*
>       * Fall back to a bus-specific device path, if the bus
> -     * provides one (e.g. PCI address "0000:00:04.0").
> +     * provides one (e.g. "PCI device 0000:00:04.0").
>       */
> -    const char *path = qdev_get_dev_path(dev);
> +    g_autofree char *path = qdev_get_dev_path(dev);
>      if (path) {
> -        return path;
> +        const char *bus_type = object_get_typename(OBJECT(dev->parent_bus));
> +        char *name = g_strdup_printf("%s device %s", bus_type, path);
> +        return name;
>      }
>  
>      return object_get_canonical_path(OBJECT(dev));

Reviewed-by: Markus Armbruster <armbru@redhat.com>


