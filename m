Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F275C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4K0B-0002Xt-MR; Wed, 09 Sep 2026 11:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x4K09-0002XQ-Vt
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:14:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x4K07-0003gb-Fc
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788966853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ezyyp/IVeEXSLnaCXChRua6jJQSLaskdA/wuwVKiWKU=;
 b=GePzXKxqoid6r2aNFzWX0Ibw+qpJjcJ38iLyr1Lc0X2ZKMtSlB6mJRih72VdffJ5wMqdYh
 zl5jEvC5HkXdZrMxg7nY3lTpem/6G2ABrkhjjxOjy6l7LTpiwUbv1ClNAf5Ldz48lYYXQi
 wRxCOYQfy9BTexKqt2TZPuJes9R08hA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-E1HbyYpPN6qRvhETvXGVfA-1; Wed,
 09 Sep 2026 11:14:11 -0400
X-MC-Unique: E1HbyYpPN6qRvhETvXGVfA-1
X-Mimecast-MFC-AGG-ID: E1HbyYpPN6qRvhETvXGVfA_1788966850
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E44CB1956050; Wed,  9 Sep 2026 15:14:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.37])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 15FE1195608C; Wed,  9 Sep 2026 15:14:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EFD73180038F; Wed, 09 Sep 2026 17:14:07 +0200 (CEST)
Date: Wed, 9 Sep 2026 17:14:07 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: David Vrabel <david.vrabel@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/4] hw/pci-bridge: Add generic PCIe switch upstream
 and downstream ports
Message-ID: <aqF26NFTUtPDaLA9@sirius.home.kraxel.org>
References: <20260908155223.164787-1-david.vrabel@nutanix.com>
 <20260908155223.164787-2-david.vrabel@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908155223.164787-2-david.vrabel@nutanix.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

  Hi,

> +#define GEN_PCIE_DOWNSTREAM_PORT_VENDOR_ID       0x1b36
> +#define GEN_PCIE_DOWNSTREAM_PORT_DEVICE_ID       0x0016

These #defines are maintained in include/hw/pci/pci.h,
please add them there next to the existing ones.

Also make sure to update docs/specs/pci-ids.rst
when allocating a new ID from the range for qemu.

take care,
  Gerd


