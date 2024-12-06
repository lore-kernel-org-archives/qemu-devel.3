Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07362E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 09:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJUeA-0001NX-Dp; Fri, 06 Dec 2024 04:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tJUe8-0001N4-Ct
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 04:29:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tJUe6-0005W1-4C
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 04:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733477348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4L3e0mLfzbbv7hAu4HyqMEBb2a5jC9cjt+Yt5w7gL6U=;
 b=fJ0qvXvreDTfQFPLs6Mn0/Hf6aofu9gAdZNkTZgR6fuHnfe05kULKBabX+i2SpGvFeN4wZ
 8mezdkw4J3ZpgyGMBbddD1/PMeqmi+MBH5hYWdLYlDt0CaCxyRw80cvoZ/wWX5fREJWOUN
 LWHd/bDZxM/ISWpodbnkJa0N2lvLqCA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-Q7lMu-UbNQOuO3X7b9PVBA-1; Fri,
 06 Dec 2024 04:29:05 -0500
X-MC-Unique: Q7lMu-UbNQOuO3X7b9PVBA-1
X-Mimecast-MFC-AGG-ID: Q7lMu-UbNQOuO3X7b9PVBA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02B74195608F; Fri,  6 Dec 2024 09:28:59 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.39.192.129])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C9421955F3E; Fri,  6 Dec 2024 09:28:57 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id 9510025421A; Fri,  6 Dec 2024 10:28:54 +0100 (CET)
Date: Fri, 6 Dec 2024 10:28:54 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-for-9.2? v2 1/2] hw/display/vga: Do not reset
 'big_endian_fb' in vga_common_reset()
Message-ID: <46kzowk6brtwqrelpplth2l4axeyrqj3n3inzfnwavbtw7ls3c@vdssph2yubx2>
References: <20241129101721.17836-1-philmd@linaro.org>
 <20241129101721.17836-2-philmd@linaro.org>
 <21c5e930-d7ee-4dd8-a238-862f4db87849@linaro.org>
 <2f6a993cd0e12c2bf903440f9f921d7af58bee36.camel@kernel.crashing.org>
 <yqxiqgaazxuvvtx3onfqlndx2t2sa3i7iykufkl56r45iwyusj@xatjov5qiea2>
 <ffac691bd93fee5192b8e91b03171422e5df0a1b.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffac691bd93fee5192b8e91b03171422e5df0a1b.camel@kernel.crashing.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Dec 06, 2024 at 10:00:37AM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2024-12-03 at 11:51 +0100, Gerd Hoffmann wrote:
> > 
> > The only case I'm aware of where the byte order is actually switched is
> > booting a ppc64le guest in a pseries machine, where the opal firmware
> > runs in bigendian mode and the linux kernel runs in little endian mode.
> > 
> > So here the changed reset behavior could actually make a difference, but
> > you will only notice if the opal firmware does *not* set the byte order
> > register.
> 
> OPAL (well skiboot) doesn't display anything anyways (or at least it
> didn't when I wrote it :-). It just boots Linux as a bootloader. So as
> long as Linux itself sets the register it should be fine.

Oh, mixed up the firmware names, it's SLOF not OPAL.

sorry for the confusion,
  Gerd


