Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562F6C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wloyQ-0000YG-W9; Mon, 20 Jul 2026 10:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wloyD-0000QX-9N
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:27:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wloyB-00020f-Sk
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784557667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bG9lSbpjH7CVwGD26786AhtcYP1gnXTzVqNTDyqMUnI=;
 b=NX1pZt5zEhMpxPQOHEkMaq1YyGVz+Bv06hWnEaJJwc6b5G5N+K86s4iJDFgFCqS7mDLUaX
 CCPaYyr7hIsSEm/K1XcLSgVcTOGsF2rg/TiBNwA7X2xxatd+yCI5oa4Le/j/+ZlQgKEbuV
 31enmh367J1BZnEEYqIjOQQ3S88aFvc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-Gvx3h8fENEK4T5DozKlWUw-1; Mon,
 20 Jul 2026 10:27:43 -0400
X-MC-Unique: Gvx3h8fENEK4T5DozKlWUw-1
X-Mimecast-MFC-AGG-ID: Gvx3h8fENEK4T5DozKlWUw_1784557662
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3091619208B4; Mon, 20 Jul 2026 14:25:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.44])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C6600180044F; Mon, 20 Jul 2026 14:25:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5BD3C1800391; Mon, 20 Jul 2026 16:25:16 +0200 (CEST)
Date: Mon, 20 Jul 2026 16:25:16 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Timo =?utf-8?B?VGVyw6Rz?= <timo.teras@iki.fi>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/usb/host-libusb: keep autoscan enabled for bus+addr
 selector
Message-ID: <al4vZikI5uCJI-QC@sirius.home.kraxel.org>
References: <20250912-usbhost-disconnect-v1-1-9c7c5fa9b50a@iki.fi>
 <bb76dd56-e97e-4d1c-aaf8-9eb55e6858b3@redhat.com>
 <al4GiC3G1u2lgTJD@sirius.home.kraxel.org>
 <CABTJ_OeeS8YW95jfdhB_YUfcvTa-zof8e6bXrdi3R8uQbMUoQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABTJ_OeeS8YW95jfdhB_YUfcvTa-zof8e6bXrdi3R8uQbMUoQA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=kraxel@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 20, 2026 at 02:54:01PM +0300, Timo Teräs wrote:
> Hi!
> 
> The more specific use case that does not work without this (not realized
> until after writing issue/commit) is devices that need to switch modes, or
> hot plugging new items to the specific physical port. In these scenarios
> the original device disconnects and later new one connects to the port.
> Detection of the new device does not work in any device combination without
> this commit.

This makes sense.  Root cause is probably that the device is not
physically unplugged from the host port in that case.  Please add that
info to the updated commit message.

thanks,
  Gerd


