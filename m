Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CDFC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 19:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYs98-0000IK-GH; Tue, 30 Jul 2024 15:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+ab1f7bf13ccfee3ca1eb+7646+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1sYs97-0000Hf-6v
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 15:04:29 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+ab1f7bf13ccfee3ca1eb+7646+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1sYs95-0007bD-53
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 15:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=tHlK4frCnLLKB+sQ5ZzNk+fstKYIjv3DMZ51KM1ewEw=; b=iLkwaNOI5cLuiW9Q2tBLkVrRLh
 kWs4PyJpI4IyQqwJFGygkSGT8DXlgh5EwrcLUMGHshfa9nQp7BLdeYPlSGXsVj1dpSYxGgX4mGWjN
 ATq61ohGzjw3P32W4GA8FFhr1Ga1A9vuH6NScMwH9EnHZrtt3rsoDV//Ku86f2tjmaAcdjppc4m6d
 K7NtQC5UaNOCBA0ML5x8U/1nJwBMaRV9fdfDNEK0cC6Eaz+QA6Mq9l2VObkRiuX9Y2B6wAU0wuFMs
 /Q24q817L2mi2BxqHST8QBU4Kef8cnWIkbMewlD2jFurmbDrIx6Lb3g9iTeuO4j2GgBQdMbWijxoP
 CdHtgdPw==;
Received: from [2001:8b0:10b:5:bb25:1856:b87e:8ac5] (helo=[IPv6:::1])
 by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1sYs8u-000000054WS-38YA; Tue, 30 Jul 2024 19:04:17 +0000
Date: Tue, 30 Jul 2024 20:04:17 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Hilber <peter.hilber@opensynergy.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
Subject: Re: [PATCH v2] hw/acpi: Add vmclock device
User-Agent: K-9 Mail for Android
In-Reply-To: <20240730135143-mutt-send-email-mst@kernel.org>
References: <bc85aba60523e0d63e760d5143c5cb57688779d1.camel@infradead.org>
 <20240730135143-mutt-send-email-mst@kernel.org>
Message-ID: <546A904C-FEEB-4365-B7AA-CA4E3D03300C@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+ab1f7bf13ccfee3ca1eb+7646+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 30 July 2024 18:53:18 BST, "Michael S=2E Tsirkin" <mst@redhat=2Ecom> wro=
te:
>We don't want to manually sync headers with Linux=2E

Indeed=2E I was briefly tempted to fake it, but figured it might get lost =
if we subsequently do run the script to automatically merge from Linux, bef=
ore the guest driver is merged there=2E

>I think Linux abi should live under uapi=2E When it is there, we can use
>=2E/scripts/update-linux-headers=2Esh machinery to import it=2E

This isn't just Linux ABI=2E It's intended as hypervisor to guest ABI too=
=2E In the fullness of time I'm hoping it'll actually be a virtio header=2E=
 In the meantime, best not to overthink it=2E It's fine in hw/acpi alongsid=
e the device itself for now, I think=2E


