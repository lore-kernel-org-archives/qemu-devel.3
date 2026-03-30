Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E914CFF60CE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7SVY-0002Jz-2r; Tue, 31 Mar 2026 02:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1w7SVW-0002JR-01
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1w7SVU-0004Bc-HA
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774938199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gj/Wb/xNdq9TmkmcqAWD9Cxrsq88dATko/b+Y/g+gIU=;
 b=P6NWTxNdvjJOdF+wq5cec84XmdDe0b3ese7gQkiF7/BFy4QKFOoutkuflB5VrF65UFU7RG
 FsDeA03xJD2hpq1/5PjY1QynP+yBF5hd6wOyAkG8w1ZthGh4vVfYY+lqzsZt6OXr+EKI1h
 m6R5lb9c6Z/2/aTTdYmhAYxf3v0h0QE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-jirv2hV6PCKmEMFjQ0GgIg-1; Tue,
 31 Mar 2026 02:23:17 -0400
X-MC-Unique: jirv2hV6PCKmEMFjQ0GgIg-1
X-Mimecast-MFC-AGG-ID: jirv2hV6PCKmEMFjQ0GgIg_1774938196
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50B831955EA1; Tue, 31 Mar 2026 06:23:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.48])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF5F41954102; Tue, 31 Mar 2026 06:23:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8F1CD18000A2; Mon, 30 Mar 2026 17:05:44 +0200 (CEST)
Date: Mon, 30 Mar 2026 17:05:44 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] cirrus-vga: Add property to set frame buffer
 endianness and make it default to little endian
Message-ID: <acqO5rPZtu9rcWTi@sirius.home.kraxel.org>
References: <20260330140655.31EC55968DE@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330140655.31EC55968DE@zero.eik.bme.hu>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.54, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> +    { "isa-cirrus-vga", "x-big-endian-fb", "off" },
> +    { "cirrus-vga", "x-big-endian-fb", "off" },

I don't think cirrus needs any of this.  As far I know only standard vga
is used in big endian targets.

IIRC cirrus (as-in: the physical hardware) has 4M vram and a a 8M pci
bar, where the lower 4M offer little-endian access to the vram and the
upper 4M offer big-endian access to the vram.

qemu never emulated the big-endian aperture with the automagic
byteswapping.

take care,
  Gerd


