Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA9EC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 06:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Hlf-0002o3-2R; Tue, 01 Sep 2026 02:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x1Hlc-0002mu-79
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x1Hla-00052q-No
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788243281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kTSDbKJgn8D9szBWPHfdNfcvJcIT+LMocQqRDCfjgS4=;
 b=ROElAS08N7oRhjRPOh2CY6GaXw5SHNFMMA21VPxeqB9+2m2T0OsSjoSSDkwuC+K0DOMNtJ
 aUVCBglXn4OSdAwNhO34XjKjfaZBLA83rvKJkHqFdhrVj1RzsqNQA+eIWBR76CduK7A8pt
 Hj7q6hiNcDVIM/8AKRleRcPzZ1W8eBQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-GCe_9T6SM-irTNaXMFUM9w-1; Tue,
 01 Sept 2026 02:14:23 -0400
X-MC-Unique: GCe_9T6SM-irTNaXMFUM9w-1
X-Mimecast-MFC-AGG-ID: GCe_9T6SM-irTNaXMFUM9w_1788243262
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E95081955F3D; Tue,  1 Sep 2026 06:14:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.41])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9B581955F7C; Tue,  1 Sep 2026 06:14:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D0FBF1800620; Tue, 01 Sep 2026 08:14:18 +0200 (CEST)
Date: Tue, 1 Sep 2026 08:14:18 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Subject: Re: [PATCH] hw/nvme: fix firmware boot path when nvme-ns has a
 bootindex
Message-ID: <apZtCH_xUMbVWHDJ@sirius.home.kraxel.org>
References: <20260819-fix_nvme-v1-1-6d3d5e6909c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-fix_nvme-v1-1-6d3d5e6909c1@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

On Wed, Aug 19, 2026 at 10:04:42AM +0200, Luigi Leonardi wrote:
> The correct way to register an NVMe namespace in fw_boot_order is to use
> the NVMe controller as the device pointer with the namespace ID appended
> as a suffix, producing:
> 
>   /pci@i0cf8/pci1b36,0010@4/namespace@1,0
> 
> This is how the controller-level bootindex works.
> Explicit nvme-ns devices instead register the nvme-ns device itself,
> which is wrong: realize() reparents the namespace onto the NVMe subsystem
> bus, disconnecting it from the controller in the bus hierarchy.
> qdev_get_fw_dev_path() therefore produces a path without the controller's
> address:
> 
>   /nvme-ns/namespace@1,0
> 
> Fix by re-registering in realize(), once the controller and final nsid
> are known, using the controller as the device pointer with the namespace
> suffix. The old entry (registered against the nvme-ns device) must be
> removed first since add_boot_device_path() only removes entries matching
> the same device pointer, and leaving both would cause a
> duplicate-bootindex error.
> 
> device_add_bootindex_property() cannot be called in realize() because
> QEMU parses command-line properties before realize() runs, so the
> bootindex property must exist by instance_init() time. The final nsid is
> not yet known then either as it's assigned in realize().
> 
> The fix is restricted to non-shared namespaces: for shared namespaces
> there is no single controller to register the boot path against.
> 
> Also add the symmetric unrealize() cleanup so that hot-unplugging a
> non-shared nvme-ns with a bootindex removes the fw_boot_order entry that
> was registered against the controller in realize().
> 
> Reported-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd


