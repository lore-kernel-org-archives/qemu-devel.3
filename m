Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9432AC83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 08:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueV6v-0000ax-TY; Wed, 23 Jul 2025 04:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ueV6S-0000SX-3y
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 04:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ueV6G-0002SH-5s
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 04:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753260316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dC3q7/A3Y6Pxh9In9/dxZIjQlz5k+cSO84uBmObuEaY=;
 b=DAewJIbnBRG5vYVbfRtUJgjsR5YhA1fzihr2xkvmY2EdcxgPOFTt4hNpW8I+7LafgTE4OA
 BO0OTFntperXB6L3CgXmSL5TaUtJn9Wq8C5Xeo4xhXX2JhG6rNCq2hA2P3slFu7bFFWJ52
 DoRexTk6XamIw9f15tl3C0XoIBo+/Ek=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-1XVdBrp_PYSG-JCD3eJlvQ-1; Wed,
 23 Jul 2025 04:45:14 -0400
X-MC-Unique: 1XVdBrp_PYSG-JCD3eJlvQ-1
X-Mimecast-MFC-AGG-ID: 1XVdBrp_PYSG-JCD3eJlvQ_1753260313
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7866B195FE11; Wed, 23 Jul 2025 08:45:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.154])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E78F1956094; Wed, 23 Jul 2025 08:45:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4DD021800382; Wed, 23 Jul 2025 10:45:10 +0200 (CEST)
Date: Wed, 23 Jul 2025 10:45:10 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, 
 Shaoqin Huang <shahuang@redhat.com>
Subject: Re: [PATCH] hw/i386: Fix 'use-legacy-x86-rom' property compatibility
Message-ID: <7jxttgt6lpiodvrzjqugdbm342ypi4xkle43b6donsju4gwd6a@yrypxamrqip5>
References: <20250723062714.1245826-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250723062714.1245826-1-clg@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jul 23, 2025 at 08:27:14AM +0200, Cédric Le Goater wrote:
> Commit 350785d41d8b ("ramfb: Add property to control if load the
> romfile") introduced the `use-legacy-x86-rom` property for the
> `vfio-pci-nohotplug` device, allowing control over VGA BIOS ROM
> loading. However, the property compatibility setting was incorrectly
> applied to the `vfio-pci` device instead, which causes all `vfio-pci`
> devices to fail to load. This change fixes the issue by ensuring the
> property is set on the correct device.
> 
> Fixes: d5fcf0d960d8 ("hw/i386: Add the ramfb romfile compatibility")
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Shaoqin Huang <shahuang@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Acked-by: Gerd Hoffmann <kraxel@redhat.com>


