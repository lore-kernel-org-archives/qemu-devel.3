Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76444CCD1A0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 12:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1squCs-0003M8-5H; Wed, 18 Sep 2024 08:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1squCl-0003L4-Ee
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:54:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1squCg-0002oQ-6V
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 08:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726664080;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7CPKzqWFUNfs70joePKYe1MxfeTWxjajpAUGeaSPGwM=;
 b=HN343E5qG/znilPp2tl334wjYG1wJZN0YfbriI7OclrFRkC9QYQNQ3OmElMqsBUnW0FWcm
 w+hwUTj8/3NaUE157YrUfw4rtpTt/hZcIuyOGFV87186QuCyy+iOMBa9pEb8HCJPd66DxG
 zKlXrWGsv7sQXH4LOv2OY1aajFp6aZA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-56R3K1_oOmmxjev7e2YvGg-1; Wed,
 18 Sep 2024 08:54:36 -0400
X-MC-Unique: 56R3K1_oOmmxjev7e2YvGg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C624193BF46; Wed, 18 Sep 2024 12:54:35 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A90219560AA; Wed, 18 Sep 2024 12:54:31 +0000 (UTC)
Date: Wed, 18 Sep 2024 14:54:27 +0200
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: dave@treblig.org
Cc: pbonzini@redhat.com, eduardo@habkost.net, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/sysbus: Remove unused sysbus_mmio_unmap
Message-ID: <ZurNgydF-6GZmYm6@redhat.com>
References: <20240918122753.22411-1-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240918122753.22411-1-dave@treblig.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 18, 2024 at 01:27:53PM +0100, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> The last use of sysbus_mmio_unmap was removed by
>   981b1c6266 ("spapr/xive: rework the mapping the KVM memory regions")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>  hw/core/sysbus.c    | 10 ----------
>  include/hw/sysbus.h |  1 -
>  2 files changed, 11 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
> index ad34fb7344..e64d99c8ed 100644
> --- a/hw/core/sysbus.c
> +++ b/hw/core/sysbus.c
> @@ -154,16 +154,6 @@ static void sysbus_mmio_map_common(SysBusDevice *dev, int n, hwaddr addr,
>      }
>  }
>  
> -void sysbus_mmio_unmap(SysBusDevice *dev, int n)
> -{
> -    assert(n >= 0 && n < dev->num_mmio);
> -
> -    if (dev->mmio[n].addr != (hwaddr)-1) {
> -        memory_region_del_subregion(get_system_memory(), dev->mmio[n].memory);
> -        dev->mmio[n].addr = (hwaddr)-1;
> -    }
> -}
> -
>  void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr)
>  {
>      sysbus_mmio_map_common(dev, n, addr, false, 0);
> diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
> index 3cb29a480e..c9b1e0e90e 100644
> --- a/include/hw/sysbus.h
> +++ b/include/hw/sysbus.h
> @@ -82,7 +82,6 @@ qemu_irq sysbus_get_connected_irq(SysBusDevice *dev, int n);
>  void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr);
>  void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
>                               int priority);
> -void sysbus_mmio_unmap(SysBusDevice *dev, int n);
>  
>  bool sysbus_realize(SysBusDevice *dev, Error **errp);
>  bool sysbus_realize_and_unref(SysBusDevice *dev, Error **errp);
> -- 
> 2.46.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


