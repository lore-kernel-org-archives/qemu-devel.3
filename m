Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DD0CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcJqJ-0005a5-2V; Wed, 24 Jun 2026 05:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wcJqH-0005Zc-7P
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 05:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wcJqF-0002YX-Ma
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 05:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782293057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RkUxolUzjczhlVujEtH5ZLf/LZQTHa49lcdu1EqQ3KM=;
 b=BIcvZ/B5krrOyiOcl70VyS3qL+NdfY0s233nbWHgG2YPUJ3G8fdPkxWmBp2NjSOeiSb+vX
 jqvVie4wJs9X+QYWzoOgSq61wPuGhDHw9emSNm3EhPu2l95qNPlVjUQmoU/qdKRFZEOYVq
 BnXSNxIW1AkKNswmgHpAWZhe2jORZyI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-w340CbUeMuCArsjvbGq1RA-1; Wed,
 24 Jun 2026 05:24:12 -0400
X-MC-Unique: w340CbUeMuCArsjvbGq1RA-1
X-Mimecast-MFC-AGG-ID: w340CbUeMuCArsjvbGq1RA_1782293051
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E504718052DD; Wed, 24 Jun 2026 09:24:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.8])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 848A1180028B; Wed, 24 Jun 2026 09:24:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 56605180078A; Wed, 24 Jun 2026 11:24:09 +0200 (CEST)
Date: Wed, 24 Jun 2026 11:24:09 +0200
From: Gerd Hoffman <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Alex Graf <graf@amazon.com>, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v1 4/8] hw/misc/vmlaunchupdate: Introduce hypervisor
 fw-cfg interface support
Message-ID: <ajudPOcejMvGTTJB@sirius.home.kraxel.org>
References: <20260624055339.46862-1-anisinha@redhat.com>
 <20260624055339.46862-5-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624055339.46862-5-anisinha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

  Hi,

> +static bool disabled;

Why is this global?  Should be in VMLaunchUpdateState I think.

> +    /* free previous file context */
> +    if (igvmc->file >= 0) {
> +        igvm_free(igvmc->file);
> +    }
> +    g_free(igvmc->filename);
> +    /* set new context */
> +    igvmc->file = igvm;

I'm wondering whenever we should better keep the original file, so we
have the option to switch back.

With a boot workflow like this ...

  (1) boot qemu firmware
  (2) some efi app loads igvm with guest firmware + kernel
  (3) reset
  (4) boot guest-supplied firmware
  (5) guest-supplied firmware boots into the bundled kernel
      (without even looking at the ESP).

... you are now in a situation where the guest can't load a different
IGVM file (say with an updated kernel) using the same workflow.  The
next reset will go straight to (4) instead of restarting at (1).

> +++ b/include/hw/misc/vmlaunchupdate.h

I think it makes sense to have two include files, one for the API and
one for the qemu internals.

> +typedef struct {
> +    /* api version */
> +    uint16_t version;

uint8_t padding[6];

> +
> +    /* VMM capabilities, read-only. */
> +    uint64_t capabilities;
> +    /* control bits, see VMFWUPDATE_CTL_* */
> +    uint64_t control;
> +
> +    /*
> +     * address and size of the IGVM image.  Will be cleared when
> +     * the write completes successfully and IGVM file is correctly parsed.
> +     */

I think we should better have an explicit status field, something along
the lines of ...

enum VMLaunchUpdateStatus {
	STATUS_UNDEFINED = 0,
	STATUS_DISABLED = 1,
	STATUS_NO_IMAGE = 2,
	STATUS_IMAGE_LOAD_OK = 3,
	STATUS_IMAGE_LOAD_FAIL = 4,
}

.. instead of signaling success indirectly by clearing fields.  There is
room anyway right after the version field.

> +    uint64_t fw_image_addr;
> +    uint32_t fw_image_size;

uint64_t?

take care,
  Gerd


