Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B13B606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fmLv2+5i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsjs-0001RB-69; Mon, 02 Nov 2026 09:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNsiJ-00085w-P2
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNsiG-0005Gl-I0
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793628519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=grg9FKd6iKJomJal3CYJ4U4vQMCnT6o8hFeIMXOlPVI=;
 b=fmLv2+5ifTcU/Y8xonlnfX3eFDECAL5my0pxZHwfhb/Cv6x2bolxywdArHTOr9rVlGAtiz
 4P0cYasKPxHPKBS7r/Q8yTxSanV0vZK5gA9kezihVWrCFD7yRycaLIha0CV4kHidn7Q1Ku
 IwwAdlEdIyT9AoQGKiCFMXvTylDZhSs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-crF7Vc6JPmmHrsO_N-7TnA-1; Mon,
 02 Nov 2026 09:08:34 -0500
X-MC-Unique: crF7Vc6JPmmHrsO_N-7TnA-1
X-Mimecast-MFC-AGG-ID: crF7Vc6JPmmHrsO_N-7TnA_1793628510
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 403571956062; Mon,  2 Nov 2026 14:08:30 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E0831955D6F; Mon,  2 Nov 2026 14:08:28 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 17/18] hw/usb/redirect-server: Implement isochronous
 OUT transfers
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, junjie.cao@intel.com, 
 junjie.cao@linux.dev, clg@kaod.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-18-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-18-jamin_lin@aspeedtech.com>
Date: Mon, 02 Nov 2026 18:07:30 +0400
Message-Id: <179362845024.3960472.4540726377291333778.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=784;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hJvGUxn6plNHSiGGl7omQzqPVVmIxQziy7e/MT9o/6E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6JklfS+mn8zeM4IpV8GvoTwsJ5L78+CmeqKvL
 ELYRm1g/oyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauiZJQAKCRDa6OEJdZac
 5Rc7EACF+C6p8LW5n/I8XO5Cs+PHM7mSX7pum8MHr+ws1ln+w3dQa0b+q7PoE1tu0mpXYIuGXoT
 icrBIGj5rhYBjzTdohkpSDkEoMJwDn+I4d5eJiyy9DCStKHRFp7Xj6mhvUvddnMClVecKTbC526
 fSKS/93FE0eY7AU8YyCG3e2y1Jd68XaBaicRcjAqYTZM4lNrRePBHW32xYnAUjY2he8EAUXN5mc
 22lxrZ3ZC+K+OyaoM5S0sWkiT2KM7q/XvforGmwR42R39dWktzIg2M/RTk3A1C9ojYqaLvu4L4H
 FgvS+G08Cak7LpB5rTff1h1B+KDgT39Jb6fR67JChoQESX3YXt7hFgGAp0HdK40qjsjqsVTxgLO
 FB4caTSba5qalcyWgTY8b7KdyRADPk+H42fdLSXwjB6mQs0Gdruuy6I3Vkux2160eFQ/MncqAjB
 gGoryaBaaKKSPTytzsRm06wg4TXAXicnWI/ZzBFU/qVmNVuxX9Uk0GdPq2xSUyl0r9tQoGpkmC5
 uJZi1wB9Re3Q1h4jS2F2GArMXHb1P8tciSxwgqrTs3wzZW/eH5soANXhH+z7hPeoccdvAzc5MpR
 qXNqXT0S5/nOH5TImx9KUgUoiTLyGxS7HnsPJeCGoH+bsQh4InjH3mJbbGZ0s1kVJWExGjl+yAX
 aEemQuWUnWPszbA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 09:22:27 +0000, Jamin Lin <jamin_lin@aspeedtech.com> wrote:
> The protocol has three callbacks for isochronous transfers:
> start_iso_stream_func, stop_iso_stream_func and iso_packet_func.
> Isochronous has no capability bit, and the parser calls them without
> checking, so a server cannot leave them out.
> 
> Implement the three for an OUT endpoint. Endpoint 0 is control, so
> refuse it. The host sends a packet for every OUT transfer. It sends
> nothing for an IN transfer, so refuse an IN endpoint with a stall.
> Only a stall makes the host close the stream. Any other status leaves
> it open on the host side.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


