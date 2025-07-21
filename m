Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3ADC83F27
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 06:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udk1D-0006Qz-HL; Mon, 21 Jul 2025 02:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1udk11-0006HD-SL
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 02:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1udk0v-00024s-Iw
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 02:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753079317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=abrAJLrVEfXev0cxwTJM0WINea4wXMs6hvLU7IrqPBQ=;
 b=YkKhIZEpyt/KhOpkpiIDcNwCCiZM94COCsIgeIJdW0w77GTQoAAT056ioNV/2nFrf0nXqe
 6TvyE6uNbLg50JNNf2sBcq8BANS8+OpWo86YsZj/npC9fFfiIcUddSqUtxV/MzEZHuerW/
 P78/pSQz2n2RaaWZvs/BRPUUX3goa7c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-jJTYp8PLOZGxEPMNlWa88Q-1; Mon,
 21 Jul 2025 02:28:35 -0400
X-MC-Unique: jJTYp8PLOZGxEPMNlWa88Q-1
X-Mimecast-MFC-AGG-ID: jJTYp8PLOZGxEPMNlWa88Q_1753079313
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6FBC195FD2B; Mon, 21 Jul 2025 06:28:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C88919560A3; Mon, 21 Jul 2025 06:28:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C553E1800615; Mon, 21 Jul 2025 08:28:29 +0200 (CEST)
Date: Mon, 21 Jul 2025 08:28:29 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Alex Williamson <alex.williamson@redhat.com>, Sergio Lopez <slp@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Shaoqin Huang <shahuang@redhat.com>
Subject: Re: [PULL 2/3] vfio: Move the TYPE_* to hw/vfio/types.h
Message-ID: <ma53hy32octccy2wnq34hmcshgfyky3xj2rc75gu36rxhxkkoq@hbzm623ss4gc>
References: <20250718194349.65771-1-kraxel@redhat.com>
 <20250718194349.65771-3-kraxel@redhat.com>
 <4fff6291-7121-4b4e-b271-77b859206817@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fff6291-7121-4b4e-b271-77b859206817@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Jul 18, 2025 at 11:03:40PM +0200, Cédric Le Goater wrote:
> On 7/18/25 21:43, Gerd Hoffmann wrote:
> > From: Shaoqin Huang <shahuang@redhat.com>
> > 
> > Move the TYPE_* to a new file hw/vfio/types.h because the
> > TYPE_VFIO_PCI will be used in later patch, but directly include the
> > hw/vfio/pci.h can cause some compilation error when cross build the
> > windows version.
> > 
> > The hw/vfio/types.h can be included to mitigate that problem.
> 
> As said earlier, the string literal "vfio-pci" could be used instead
> of the TYPE_VFIO_PCI define and avoid the extra vfio header file.

I think it makes sense to use TYPE_VFIO_PCI, for consistency and to
avoid typos in the device name.

take care,
  Gerd


