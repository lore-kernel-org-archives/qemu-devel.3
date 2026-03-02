Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA1DEA4E07
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 14:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx4Ip-00016z-MO; Mon, 02 Mar 2026 09:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vx4IP-0000uO-Aa
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:30:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vx4IN-00085f-Lj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772461847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wEvv7MDAti30N75x55e7xmvtC1IPhrMpWCie/Kz91/A=;
 b=CwDMIbxnjM08hF3aCRmHUn7LzUM42Kn1k0unfO6WPG0Qw4akeZrPkTtAiYL2rdo8+lmGHi
 t7M3J1I+6jfTfk9TY5+xorSRPDLREJ3aqx8qyVy9GIcZTMWa4KahkJFg2ncbylk7z1Cxtf
 R9omUJSjyt92TLHeOWCriAXYS17F+6Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-gXsGHP-4MnC7OUMynH_i8w-1; Mon,
 02 Mar 2026 09:30:46 -0500
X-MC-Unique: gXsGHP-4MnC7OUMynH_i8w-1
X-Mimecast-MFC-AGG-ID: gXsGHP-4MnC7OUMynH_i8w_1772461845
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C0DD18001E6; Mon,  2 Mar 2026 14:30:45 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.198])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BD9530001B9; Mon,  2 Mar 2026 14:30:43 +0000 (UTC)
Date: Mon, 2 Mar 2026 15:30:41 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/5] block: Introduce BDRV_O_NO_DATA_{WRITE,RESIZE}
Message-ID: <aaWfEfuBZGW4BHPD@redhat.com>
References: <20260205144737.31131-1-hreitz@redhat.com>
 <20260205144737.31131-3-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205144737.31131-3-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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

Am 05.02.2026 um 15:47 hat Hanna Czenczek geschrieben:
> Add BDS flags that prevent taking WRITE and/or RESIZE permissions on
> pure data (no metadata) children.  These are going to be used by qcow2
> during formatting, when we need write access to format the metadata
> file, but no write access to an external data file.  This will allow
> creating a qcow2 image for a raw image while the latter is currently in
> use by the VM.
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  include/block/block-common.h | 11 +++++++++++
>  block.c                      | 15 +++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/block/block-common.h b/include/block/block-common.h
> index c8c626daea..504f6aa113 100644
> --- a/include/block/block-common.h
> +++ b/include/block/block-common.h
> @@ -245,6 +245,17 @@ typedef enum {
>  
>  #define BDRV_O_CBW_DISCARD_SOURCE 0x80000 /* for copy-before-write filter */
>  
> +/*
> + * Promise not to write any data to pure (non-metadata-bearing) data storage
> + * children, so we don't need the WRITE permission for them.
> + * For image creation, formatting requires write access to the image, but not
> + * necessarily to its pure storage children.  This allows creating an image on
> + * top of an existing raw storage image that is already attached to the VM.
> + */
> +#define BDRV_O_NO_DATA_WRITE  0x100000

Can't we just use BDRV_O_NO_IO for this one? It is stricter because it
doesn't allow reading either, but I don't think image creation ever
requires reading from the image?

> +/* Same as O_NO_DATA_WRITE, but for resizing */
> +#define BDRV_O_NO_DATA_RESIZE 0x200000

How does this differ from BDRV_O_RESIZE (apart from being negative)?
Doesn't resizing always refer to the data part?

Kevin


