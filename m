Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13822ECE57B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 09:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snall-0008Vb-2R; Mon, 09 Sep 2024 05:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1snalj-0008SY-Dk
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 05:33:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1snalh-0005NS-LP
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 05:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725874387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zp3fMx02yjuxBxyLnCz8moKM20upWbpFrJDtxAa470U=;
 b=ZYeCUPsDk0+k7Hf42nLxmUVrTKlBbYO2s82nB4iBRMNZgbunzIPCki5yZX0Orky0V/Q+TX
 FsK89d/dZShaw4GiP+LB/tQNbFWm8sqq7xg2E2AQWi47bT1Tx/daHE2Uxrgwe7+o47nFFb
 EtyktZllOdK3rcaV+9AFyMEeftV3gOU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-t1KvnuyKPJaCpllU2xLNIw-1; Mon,
 09 Sep 2024 05:33:03 -0400
X-MC-Unique: t1KvnuyKPJaCpllU2xLNIw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C057F19560B1; Mon,  9 Sep 2024 09:33:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.146])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BBCB30001A1; Mon,  9 Sep 2024 09:33:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DC8B81800D70; Mon,  9 Sep 2024 11:32:57 +0200 (CEST)
Date: Mon, 9 Sep 2024 11:32:57 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Niek Linnenbank <nieklinnenbank@gmail.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: qemu emulation for USB ports of Allwinner H3
Message-ID: <xgwmp3mjq2vhhwgbkbjr76o3yejkbm2ke7ybfes7xbafmpha53@pihh3myr7h7o>
References: <85f61ad3-da14-43f7-983c-62053ce0cfa6@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85f61ad3-da14-43f7-983c-62053ce0cfa6@roeck-us.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, Sep 08, 2024 at 11:36:18AM GMT, Guenter Roeck wrote:
> Hi,
> 
> the Allwinner H3 USB port qemu emulation creates separate USB ports
> for its EHCI and OHCI controllers, resulting in a total of 8 USB ports.
> From the orangepi-pc emulation:
> 
> # lsusb
> Bus 005 Device 001: ID 1d6b:0002
> Bus 003 Device 001: ID 1d6b:0002
> Bus 001 Device 001: ID 1d6b:0002
> Bus 008 Device 001: ID 1d6b:0002
> Bus 006 Device 001: ID 1d6b:0001
> Bus 004 Device 001: ID 1d6b:0001
> Bus 002 Device 001: ID 1d6b:0002
> Bus 009 Device 001: ID 1d6b:0001
> Bus 007 Device 001: ID 1d6b:0001
> 
> The SoC supports EHCI companion interfaces, and my understanding is that
> it only has four physical USB ports. Does the real hardware instantiate
> separate EHCI and OHCI interfaces (for a total of 8 USB ports), or does it
> use the companion functionality ?

Well, on the guest side you'll see 8 ports even when using the companion
functionality.  Each physical usb port has one ehci port (used when you
plug in usb 2.0+ devices) and one ohci port (used when you plug in usb
1.1 devices).

The main difference is on the qemu backend side.  When using the
companion functionality you have a single qemu usb bus accepting both
1.1 and 2.0+ devices.  When not using the companion functionality you
have one usb bus accepting 2.0+ devices and another usb bus accepting
usb 1.1 devices ...

The guest-visible difference is an per-port bit in ehci registers which
controls whenever ehci or the companion manages the device plugged in.
This bit exists for backward compatibility (guests without ehci driver
can manage all devices via ohci, with usb 2.0+ devices being downgraded
to 1.1 compatibility mode then).

> If the real hardware only instantiates four USB ports (or, in other words,
> if it utilizes EHCI companion functionality), would it make sense to
> reflect that in qemu ?

Yes.

take care,
  Gerd


