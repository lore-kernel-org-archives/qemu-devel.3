Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38104E69EA6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 10:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIQVi-0005yE-Cr; Tue, 03 Dec 2024 05:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tIQVg-0005y4-NM
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:52:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tIQVc-0004BI-OU
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 05:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733223118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MM88nLSHvGMks3pTQGimld9RrEjmRQTbxD0/wSlLIWQ=;
 b=ZCkLULFFmhRXxGyNS6C5zwudmLG7AsYjQEhHoSAIGshHtUho+g7lpKGiFvcEEj9Rp9mHud
 u98du1cdvG+tu2YrfYatdSfjr0sBT7GOZS/bnZSfrhf4j41KUtr+4mRh0FgzbwmIZEUMnh
 vRa/3zZnWJDGiTg+k/jOXNiNoF2u3Yo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-fSP8pZNUMNqC3M8SsDNlzw-1; Tue,
 03 Dec 2024 05:51:55 -0500
X-MC-Unique: fSP8pZNUMNqC3M8SsDNlzw-1
X-Mimecast-MFC-AGG-ID: fSP8pZNUMNqC3M8SsDNlzw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0FD41955F45; Tue,  3 Dec 2024 10:51:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.12])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40B091956054; Tue,  3 Dec 2024 10:51:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 067A41800629; Tue, 03 Dec 2024 11:51:50 +0100 (CET)
Date: Tue, 3 Dec 2024 11:51:49 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-for-9.2? v2 1/2] hw/display/vga: Do not reset
 'big_endian_fb' in vga_common_reset()
Message-ID: <yqxiqgaazxuvvtx3onfqlndx2t2sa3i7iykufkl56r45iwyusj@xatjov5qiea2>
References: <20241129101721.17836-1-philmd@linaro.org>
 <20241129101721.17836-2-philmd@linaro.org>
 <21c5e930-d7ee-4dd8-a238-862f4db87849@linaro.org>
 <2f6a993cd0e12c2bf903440f9f921d7af58bee36.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f6a993cd0e12c2bf903440f9f921d7af58bee36.camel@kernel.crashing.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  Hi,

> For bochs and ati, there's a register to configure it as well, so there
> *may* be an expectation that it gets reset there, I'm less certain.

The default is there for backward compatibility reasons and it should
default to machine byte order so you get something working even in case
the guest does not explicitly set the byte order via register.  Which
should be increasingly rare these days, the register was added in
(checking git log) 2014: commit b5682aa4ca79 ("vga-pci: add qext region
to mmio")

The only case I'm aware of where the byte order is actually switched is
booting a ppc64le guest in a pseries machine, where the opal firmware
runs in bigendian mode and the linux kernel runs in little endian mode.

So here the changed reset behavior could actually make a difference, but
you will only notice if the opal firmware does *not* set the byte order
register.

take care,
  Gerd


