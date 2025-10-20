Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D04CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAomW-0000Lb-On; Mon, 20 Oct 2025 08:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vAomF-0000L4-5N
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vAomC-0006Hv-G2
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760962446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f6t6yOKQvEWN4ViavTmYpqe46aTjkb2qaTb3w9Z1kmw=;
 b=Vrd14kxJQLF6eYyCcVIv0UY2ufN9kN75bcrm9/zEzOjdk6ziQ+qTROFLWyz6j6XIaSnSDl
 n2icfBKkVaPONiXf6YhnKT7JlCuTiVGJwBMY6wZwnbC/+8vBxtYICjQUz/bI2H9t+7b2gv
 EvpKsjlPjMyC435M7FDK1k9bt7wFDJs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-VIHb0w8MO8SrXwvjSX1QvQ-1; Mon,
 20 Oct 2025 08:14:04 -0400
X-MC-Unique: VIHb0w8MO8SrXwvjSX1QvQ-1
X-Mimecast-MFC-AGG-ID: VIHb0w8MO8SrXwvjSX1QvQ_1760962443
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1BAE195422B; Mon, 20 Oct 2025 12:14:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8311619560A2; Mon, 20 Oct 2025 12:14:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 53D951800392; Mon, 20 Oct 2025 14:14:00 +0200 (CEST)
Date: Mon, 20 Oct 2025 14:14:00 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Roy Hopkins <roy.hopkins@randomman.co.uk>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 4/5] igvm: track memory regions created
Message-ID: <ntzigwnexbqg4hmlqyuucipv6gw7o2xkqanpfdrwi3ydff3a3z@lrr3xwf4x6vw>
References: <20251015112342.1672955-1-kraxel@redhat.com>
 <20251015112342.1672955-5-kraxel@redhat.com>
 <jef63vhoedtg6l6l2luiyo7wpfdolewdpuzhfmxc6p2ek7u4w2@vbrhzyw67rg5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jef63vhoedtg6l6l2luiyo7wpfdolewdpuzhfmxc6p2ek7u4w2@vbrhzyw67rg5>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
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

On Fri, Oct 17, 2025 at 03:58:53PM +0200, Stefano Garzarella wrote:
> On Wed, Oct 15, 2025 at 01:23:41PM +0200, Gerd Hoffmann wrote:
> > Keep a linked list of the memory regions created by igvm.
> 
> Sorry, my knowledge of MemoryRegions is limited, but why do we need to do
> this if we never access the list?
> To keep references to regions?

Keep track of the things we have created, so we can clean them up
properly.  Which is indeed not needed in this patch, but we will
probably need that in the future for the bring-your-own-firmware
project (aka reboot guest with new IGVM image).

take care,
  Gerd


