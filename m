Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAB0D3E788
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 05:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8YRL-0002Fh-Ne; Wed, 06 Nov 2024 00:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=033153df9=graf@amazon.de>)
 id 1t8YRK-0002FU-64
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 00:18:46 -0500
Received: from smtp-fw-52003.amazon.com ([52.119.213.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=033153df9=graf@amazon.de>)
 id 1t8YRI-0004tX-Fu
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 00:18:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1730870325; x=1762406325;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XDyb+7BZvh2V7DvMBrzT1VzXz7Zk406IftAbQkHvV5k=;
 b=DpvV9GvE3p/hGf3p7dmEVpnQeKIRBzQuE6T/5WE+1T0e+nhzXCvd4l2O
 Z/9sdbwAY3N0q33sd0Q6uvM7aGyOlLuzPih9uk62YuIh5mdkTQy05zJFX
 15ipJbHRwZlLCaM89abjni11y+7lK1OgOLxJEyerc8hBLJz5sT8rHNPXH 8=;
X-IronPort-AV: E=Sophos;i="6.11,262,1725321600"; d="scan'208";a="39325592"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-52003.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 05:18:37 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:42785]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.102:2525]
 with esmtp (Farcaster)
 id acd235b8-0eef-4f9b-a9a1-aae758fb6413; Wed, 6 Nov 2024 05:18:36 +0000 (UTC)
X-Farcaster-Flow-ID: acd235b8-0eef-4f9b-a9a1-aae758fb6413
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 05:18:35 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Wed, 6 Nov 2024
 05:18:33 +0000
Message-ID: <c69f62ad-f6b0-47b5-a2f7-04c2829c7475@amazon.com>
Date: Tue, 5 Nov 2024 21:18:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target-i386: Walk NPT in guest real mode
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, "Jan
 Kiszka" <jan.kiszka@siemens.com>, Eduard Vlad <evlad@amazon.de>
References: <20240921085712.28902-1-graf@amazon.com>
 <cc832858-9161-466e-ab52-9909f120fb12@ilande.co.uk>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <cc832858-9161-466e-ab52-9909f120fb12@ilande.co.uk>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=52.119.213.152;
 envelope-from=prvs=033153df9=graf@amazon.de; helo=smtp-fw-52003.amazon.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

SGV5IE1hcmssCgpPbiAwNS4xMS4yNCAyMzo1NCwgTWFyayBDYXZlLUF5bGFuZCB3cm90ZToKPgo+
IEhpIEFsZXgsCj4KPiBUaGlzIGNvbW1pdCBhcHBlYXJzIHRvIGJyZWFrIG15IFdpblhQIGJvb3Qg
dGVzdDogd2l0aCB0aGlzIHBhdGNoIAo+IGFwcGxpZWQsIGF0dGVtcHRpbmcKPiB0byBib290IFdp
blhQIGZyb20gQ0RST00gZmFpbHMgd2l0aCBTZWFCSU9TIGdldHRpbmcgc3R1Y2sgZWFybHkgaW4g
YSAKPiBib290IGxvb3AuIEl0IGlzCj4gcG9zc2libGUgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSBl
YXNpbHkgd2l0aDoKPgo+IMKgIC4vYnVpbGQvcWVtdS1zeXN0ZW0teDg2XzY0IC1jZHJvbSB3aW54
cC5pc28gLWJvb3QgZAoKClRoYW5rcyBhIGxvdCBmb3IgdGhlIHJlcG9ydCEgSXQgYWxzbyBzZWVt
cyB0byBicmVhayBOZXRCU0QgCihodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUv
LS9pc3N1ZXMvMjY1NCkuIEknbGwgaGF2ZSBhIGxvb2sgCnRvbW9ycm93IHRvIHJvb3QgY2F1c2Ug
YW5kIHdpbGwgc2VuZCBhIHBhdGNoIHRvIGZpeC4KCgpBbGV4CgoKCgpBbWF6b24gV2ViIFNlcnZp
Y2VzIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcg
QmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4g
V2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJC
IDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1MzggNTk3Cg==


