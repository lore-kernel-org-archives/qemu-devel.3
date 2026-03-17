Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08C0F33805
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 06:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2OCX-0008QY-GM; Tue, 17 Mar 2026 02:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2OCQ-0008QJ-VY
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 02:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2OCO-00009h-4Q
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 02:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773729996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d91tdzbxhDbJjvX+l29VuRNyuFqUyAH+SkvraxNqufY=;
 b=dkz1a4/jS3q4B+bqW6jPOTrSMkyxmF3xB1VVFaxL46omFBQvQLsswJ+GdPpG32IHBYCHP9
 ijYqI/XWh4cIN3aKwC5ZetBLBlvMVoDq/wwty3h735R6mdbciNha++qrGrnii6p7ot2pq4
 nMvIvaJCX6+gSDLfGtz2MVB/P0UHwYs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-Be0GzhyYOjizm1RfAJH6UA-1; Tue,
 17 Mar 2026 02:46:33 -0400
X-MC-Unique: Be0GzhyYOjizm1RfAJH6UA-1
X-Mimecast-MFC-AGG-ID: Be0GzhyYOjizm1RfAJH6UA_1773729992
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76D6B19560A2; Tue, 17 Mar 2026 06:46:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F00611800107; Tue, 17 Mar 2026 06:46:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7D10621E6937; Tue, 17 Mar 2026 07:46:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  berrange@redhat.com,
 mst@redhat.com,  pbonzini@redhat.com
Subject: Re: [PATCH v2 1/2] hw/qdev: Clarify fallback order in
 qdev_get_printable_name()
In-Reply-To: <20260311215003.664815-2-alessandro@0x65c.net> (Alessandro
 Ratti's message of "Wed, 11 Mar 2026 22:50:02 +0100")
References: <20260311215003.664815-1-alessandro@0x65c.net>
 <20260311215003.664815-2-alessandro@0x65c.net>
Date: Tue, 17 Mar 2026 07:46:29 +0100
Message-ID: <87ldfrlzqy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Replace the uninformative "<unknown device>" final fallback with the
> canonical QOM path (e.g. /machine/peripheral-anon/device[0]).
>
> Also clean up comments to accurately describe qdev_get_dev_path()
> behavior, drop an unnecessary comment on the dev->id check, rename
> the @vdev parameter to @dev for consistency with surrounding code,
> and add g_assert(dev) to match qdev_get_human_name()'s precondition.
>
> Update the doc comment in qdev.h to reflect the new fallback chain.
>
> Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> ---
>  hw/core/qdev.c         | 29 ++++++++++++-----------------
>  include/hw/core/qdev.h | 11 +++++------
>  2 files changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index e48616b2c6..f9fb7966dd 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -411,33 +411,28 @@ char *qdev_get_dev_path(DeviceState *dev)
>      return NULL;
>  }
>  
> -const char *qdev_get_printable_name(DeviceState *vdev)
> +const char *qdev_get_printable_name(DeviceState *dev)
>  {
> -    /*
> -     * Return device ID if explicity set
> -     * (e.g. -device virtio-blk-pci,id=foo)
> -     * This allows users to correlate errors with their custom device
> -     * names.
> -     */
> -    if (vdev->id) {
> -        return g_strdup(vdev->id);
> +    g_assert(dev != NULL);

This replaces crash on dev->id below by an assertion failure.  I
wouldn't bother.

> +
> +    if (dev->id) {
> +        return g_strdup(dev->id);
>      }
> +
>      /*
> -     * Fall back to the canonical QOM device path (eg. ID for PCI
> -     * devices).
> -     * This ensures the device is still uniquely and meaningfully
> -     * identified.
> +     * Fall back to a bus-specific device path, if the bus
> +     * provides one (e.g. PCI address "0000:00:04.0").
>       */
> -    const char *path = qdev_get_dev_path(vdev);
> +    const char *path = qdev_get_dev_path(dev);
>      if (path) {
>          return path;
>      }
>  
>      /*
> -     * Final fallback: if all else fails, return a placeholder string.
> -     * This ensures the error message always contains a valid string.
> +     * Final fallback: return the canonical QOM path
> +     * (e.g. /machine/peripheral-anon/device[0]).
>       */

Is the comment useful?

> -    return g_strdup("<unknown device>");
> +    return object_get_canonical_path(OBJECT(dev));
>  }
>  
>  void qdev_add_unplug_blocker(DeviceState *dev, Error *reason)
> diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
> index f99a8979cc..2da7327144 100644
> --- a/include/hw/core/qdev.h
> +++ b/include/hw/core/qdev.h
> @@ -1087,18 +1087,17 @@ char *qdev_get_dev_path(DeviceState *dev);
>  
>  /**
>   * qdev_get_printable_name: Return human readable name for device
> - * @dev: Device to get name of
> + * @dev: Device to get name of. Must not be NULL.
>   *
>   * Returns: A newly allocated string containing some human
>   * readable name for the device, suitable for printing in
> - * user-facing error messages. The function will never return NULL,
> - * so the name can be used without further checking or fallbacks.
> + * user-facing error messages.
>   *
>   * If the device has an explicitly set ID (e.g. by the user on the
>   * command line via "-device thisdev,id=myid") this is preferred.
> - * Otherwise we try the canonical QOM device path (which will be
> - * the PCI ID for PCI devices, for example). If all else fails
> - * we will return the placeholder "<unknown device">.
> + * Otherwise we try the bus-specific device path (which will be
> + * the PCI address for PCI devices, for example). If all else fails
> + * we return the canonical QOM path.

I prefer imperative mood for describing function behavior:

      Return the device's ID if it has one.  Else, return the path of a
      device on its bus if it has one.  Else return its canonical QOM
      path.

Bonus: obviously not the longwinded, flowery prose LLMs barf out[*].

>   */
>  const char *qdev_get_printable_name(DeviceState *dev);


[*] Would not be welcome in QEMU at this time; see section "Use of
AI-generated content" in docs/devel/code-provenance.rst.


