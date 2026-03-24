Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C807CF54ABC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52eA-0001Mp-OH; Tue, 24 Mar 2026 10:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w52e5-0001Me-AB
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w52e1-00043f-H4
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774362128;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0XBUBwi3Zf5pfMjU+07zUXH8/nVIh+qva4e/GW2GcRQ=;
 b=CajIZDS8iJqSZIRf6jm8Knpevvu3J4RN8x7CI1ZP/GEbvG1hPQb5Wk6MjpmV5UgpFxVqv/
 wZI3fj6hhTrDtOHdVyg4FiZW7++JmoimVBfVEUrUPIbp1I35FBEfhKeBgwD3WcKT3nDYfO
 7RU8eExUUCdckIfz546ZexeAEuGBxhc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9--3c9oUqUMbmFLN5rD3-YhA-1; Tue,
 24 Mar 2026 10:22:06 -0400
X-MC-Unique: -3c9oUqUMbmFLN5rD3-YhA-1
X-Mimecast-MFC-AGG-ID: -3c9oUqUMbmFLN5rD3-YhA_1774362126
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B9B919560B1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 14:22:06 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8DBA19560B1; Tue, 24 Mar 2026 14:22:04 +0000 (UTC)
Date: Tue, 24 Mar 2026 14:22:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 32/60] ui: avoid duplicating vgafont16 in each
 translation unit
Message-ID: <acKeCAREsp9VzdAn@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-32-48eb1dcf7b76@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317-qemu-vnc-v1-32-48eb1dcf7b76@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 17, 2026 at 12:50:46PM +0400, Marc-André Lureau wrote:
> vgafont.h defined vgafont16 as a static const array, so every .c file
> that included it (via console-priv.h) got its own 4 KiB copy, that
> the linker may or not deduplicate?
> 
> Move the array definition into a new vgafont.c compilation unit and
> turn the header into a proper extern declaration with an include guard.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/vgafont.h   | 4613 +-------------------------------------------------------
>  ui/vgafont.c   | 4613 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  ui/meson.build |    1 +
>  3 files changed, 4619 insertions(+), 4608 deletions(-)

> 
> diff --git a/ui/vgafont.h b/ui/vgafont.h
> index 7e1fc473f75..4498ac4e07b 100644
> --- a/ui/vgafont.h
> +++ b/ui/vgafont.h
> @@ -1,4611 +1,8 @@
> -static const uint8_t vgafont16[256 * 16] = {
> +#ifndef VGAFONT_H
> +#define VGAFONT_H
>  
> -    /* 0 0x00 '^@' */
> -    0x00, /* 00000000 */
> -    0x00, /* 00000000 */
> -    0x00, /* 00000000 */
> -    0x00, /* 00000000 */
> -    0x00, /* 00000000 */
> -    0x00, /* 00000000 */
> -    0x00, /* 00000000 */
> -    0x00, /* 00000000 */
> -    0x00, /* 00000000 */
> -    0x00, /* 00000000 */
> -    0x00, /* 00000000 */
> -    0x00, /* 00000000 */
> -    0x00, /* 00000000 */
> -    0x00, /* 00000000 */
> -    0x00, /* 00000000 */
> -    0x00, /* 00000000 */
> +#include <stdint.h>

This is pulled in by  osdep.h, which every .c file should
be including. Assuming that's removed, then

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


