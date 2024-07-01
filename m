Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B925C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 08:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOCQ2-00066G-55; Mon, 01 Jul 2024 04:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sOCN6-0005lR-Hg
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:26:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sOCN4-0002db-Rg
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719822404;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HguodlYdyUJpK2Fv+UT+CKR5Vy/WkRaQ7GfAJ9z6fVw=;
 b=i+5udHFNoHFyz/xGdnKYMFmkiIqGvMvnaL8xVotXpjTpy+X6ekzQ357Y72i+OY9YAbsF5D
 tDJajjxDKvUUkH9EEoetFekknNlA9zCbUyeveajidV2XLaoVutafkNomfFv7V5cLJyvfNR
 SfRAEyIIaR7EahyHEwsTmz0TKfO4/gY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-4U-baDjjNZWeVW5-C8pE6w-1; Mon,
 01 Jul 2024 04:26:40 -0400
X-MC-Unique: 4U-baDjjNZWeVW5-C8pE6w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84AFE196CE15; Mon,  1 Jul 2024 08:26:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.124])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB0AC1956089; Mon,  1 Jul 2024 08:26:36 +0000 (UTC)
Date: Mon, 1 Jul 2024 09:26:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v42 06/98] hw/sd/sdcard: Do not store vendor data on
 block drive (CMD56)
Message-ID: <ZoJoOSm2dELw4oRq@redhat.com>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240628070216.92609-7-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jun 28, 2024 at 09:00:42AM +0200, Philippe Mathieu-Daudé wrote:
> "General command" (GEN_CMD, CMD56) is described as:
> 
>   GEN_CMD is the same as the single block read or write
>   commands (CMD24 or CMD17). The difference is that [...]
>   the data block is not a memory payload data but has a
>   vendor specific format and meaning.
> 
> Thus this block must not be stored overwriting data block
> on underlying storage drive. Keep it in a dedicated
> 'vendor_data[]' array.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Cédric Le Goater <clg@redhat.com>
> ---
> RFC: Is it safe to reuse VMSTATE_UNUSED_V() (which happens
> to be the same size)?

This field became unused with:

commit 12c125cba9c548929ccf4da2515e5b795c94afd9
Author: Eric Blake <eblake@redhat.com>
Date:   Fri May 6 10:26:39 2016 -0600

    sd: Switch to byte-based block access
    
which was in 2.6.1 / 2.7.0


Thus if someone is using a machine type that is 2.6 or
older, I don't think it is safe to unconditionally
reuse that field.

My pending series deprecates everything upto 2.12, but
we won't remove those machine types until 2 further
release are past.

You could gamble that SD card usage is niche enough
that its highly unlikely someone will be using SD
card at the same time as these ancient machine types.

The safe thing would be a new field.
 
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> ---
>  hw/sd/sd.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


