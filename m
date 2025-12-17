Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFC0D65C49
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVs7U-00005w-2Y; Wed, 17 Dec 2025 09:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vVs77-0008UZ-GM
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:02:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vVs6z-0006hv-LB
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765980158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+lgB0myE3jKbp313SxKO1wo9Hc1NxAA3nrDC9zw4m3c=;
 b=RTNu+VBSVma12JzgiJUz3PxE/7S5EjGXnmQWnAEdTjQesy2RefyNSO6nD8lPEwJoLronTo
 msqNGusMiAz/nkxZJEfg2P7Gvaccy879vUG8PXG2/xdGiuBxomnuTgay2yrPoK+xnq5QV6
 ojqAhtFxEUs1PmcPOHDhZ0IRkcERUBk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-VPW_SEZuPIek8f5cD4pPyg-1; Wed,
 17 Dec 2025 09:02:34 -0500
X-MC-Unique: VPW_SEZuPIek8f5cD4pPyg-1
X-Mimecast-MFC-AGG-ID: VPW_SEZuPIek8f5cD4pPyg_1765980152
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DE5F195FCFC; Wed, 17 Dec 2025 14:02:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.156])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7511230001A2; Wed, 17 Dec 2025 14:02:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 32509183B542; Wed, 17 Dec 2025 15:02:29 +0100 (CET)
Date: Wed, 17 Dec 2025 15:02:29 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, vkuznets@redhat.com, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v1 20/28] kvm/i8254: add support for confidential guest
 reset
Message-ID: <csrsbcmtbt7e4pmlivuwaaqoxa47leqfx3hkokyrptiyrzbblo@p3xf43lumviv>
References: <20251212150359.548787-1-anisinha@redhat.com>
 <20251212150359.548787-21-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212150359.548787-21-anisinha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Dec 12, 2025 at 08:33:48PM +0530, Ani Sinha wrote:
> A confidential guest reset involves closing the old virtual machine KVM file
> descriptor and opening a new one. Since its a new KVM fd, PIT needs to be
> reinitialized again. This is done with the help of a notifier which is invoked
> upon KVM vm file desciptor change during confidential guest reset process.
> 
> Some code refactoring is performed so that common operations for init and reset
> are moved into a helper function.

The refactoring part (move code to do_pit_initialize) should be a
separate patch (as you did in other parts of the series).

take care,
  Gerd


