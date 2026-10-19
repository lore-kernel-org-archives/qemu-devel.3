Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051ECCCF2E0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIkat-00087b-6w; Mon, 19 Oct 2026 06:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1xIkaq-00086n-RZ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 06:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1xIkap-0000iF-92
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 06:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792405666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qwfdsSrVIuOZEOt6G0XZapVNdRO/I83QEUwNbnxJPSA=;
 b=cGfgGkh2vKCC90cnc4v4DvsrIaewlGfPCqHgTMOWUd2ZLyqrpNn/VMqqkajpTZgqALEn4W
 AK8RIOymSk6Sh16tBttDHfXJSW7u7T4kFhjMjSEyvrruYj1r9getWM/DwYzinzv+UxlZrn
 rg2+AfEMlqUfU3gFb/OrQQPcPRRFb1s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-pdjIy5psN-aB3B1hHLR1AA-1; Mon,
 19 Oct 2026 10:27:43 +0000
X-MC-Unique: pdjIy5psN-aB3B1hHLR1AA-1
X-Mimecast-MFC-AGG-ID: pdjIy5psN-aB3B1hHLR1AA_1792405661
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A06371955DC3; Mon, 19 Oct 2026 10:27:40 +0000 (UTC)
Received: from nucbdw.ghoffman.csb.home.kraxel.org
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F02618005BA; Mon, 19 Oct 2026 10:27:39 +0000 (UTC)
Received: by nucbdw.ghoffman.csb.home.kraxel.org (Postfix, from userid 11758)
 id 466FE4077819; Mon, 19 Oct 2026 12:27:37 +0200 (CEST)
Date: Mon, 19 Oct 2026 12:27:36 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: "junjie.cao@linux.dev" <junjie.cao@linux.dev>, 
 "junjie.cao@intel.com" <junjie.cao@intel.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Kane Chen <kane_chen@aspeedtech.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>
Subject: Re: [PATCH v6 1/8] hw/usb/bus: Let a bus opt out of automatic hub
 insertion
Message-ID: <atXr2J5oxn3BBgb-@nucbdw.ghoffman.csb.home.kraxel.org>
References: <20261019092448.278079-1-jamin_lin@aspeedtech.com>
 <20261019092448.278079-2-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019092448.278079-2-jamin_lin@aspeedtech.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ghoffman@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Mon, Oct 19, 2026 at 09:24:50AM +0000, Jamin Lin wrote:
> usb_claim_port() inserts a usb-hub when a device is plugged in and only
> one port is still free, so that more devices can follow. That is what a
> host controller with root ports wants.

Ah, well, not really.  It's there mostly for historical reasons.

The emulated usb hub supports only usb 1.1, so for newer host
controllers (ehci / xhci) it does not make much sense and the
better approach is to add more host controllers if needed.  Which
should rarely actually be the case though given that xhci supports
up to 15 root ports.

So if this gets into the way I'm wondering whenever the better
approach here is to remove this altogether.  You can still add an
USB hub manually of needed, IIRC there is (or was?) some board with
a single-port OHCI where you actually need a hub if you want plug
in both usb keyboard and usb mouse.  It just would not be automatic
any more.

Alternative idea would be to add the config option, but only enable
the automatic hub logic for actual usb 1.1 controllers (ohci / uhci),
where it does not matter much for devices whenever they are plugged
into an root port or hub port.

take care,
  Gerd


