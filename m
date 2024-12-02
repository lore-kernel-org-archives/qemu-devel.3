Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29180D7832F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 15:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI8WK-0000Uo-Bw; Mon, 02 Dec 2024 10:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=059b58481=graf@amazon.de>)
 id 1tI8WI-0000Ub-6c
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 10:39:30 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=059b58481=graf@amazon.de>)
 id 1tI8WG-0002Dq-Po
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 10:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1733153968; x=1764689968;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Pozak5lK3svxFrHwYzwzhIMl8EUoO1/1JfsL2sm/bV4=;
 b=dGCmvmcRyxpDjnjl3UC4KMejl4WuQc5Pc9FtRy4r1d/Tkb/HkQRynHRi
 lCkfjpIyt36q61R8iT5x9n7+earQ0gJpKRIl9tjPIegcADvUP4k7kvGio
 EP7td5rClKbPvT5pHOcfOOjBCFMeunzfELHYkNEFD5t7+CXd4Kp2chYt9 w=;
X-IronPort-AV: E=Sophos;i="6.12,202,1728950400"; d="scan'208";a="389928658"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
 by smtp-border-fw-33001.sea14.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 15:39:19 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:59316]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.147:2525]
 with esmtp (Farcaster)
 id db8baf12-342b-4eef-8973-6291098d86f6; Mon, 2 Dec 2024 15:39:19 +0000 (UTC)
X-Farcaster-Flow-ID: db8baf12-342b-4eef-8973-6291098d86f6
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 2 Dec 2024 15:39:17 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Mon, 2 Dec 2024
 15:39:15 +0000
Message-ID: <44ec59ba-2f36-4482-9b56-05b583199603@amazon.com>
Date: Mon, 2 Dec 2024 16:39:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eif: Use stateful qcrypto apis
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>
References: <20241109123039.24180-1-dorjoychy111@gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20241109123039.24180-1-dorjoychy111@gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.171.190.10;
 envelope-from=prvs=059b58481=graf@amazon.de; helo=smtp-fw-33001.amazon.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

Ck9uIDA5LjExLjI0IDEzOjMwLCBEb3Jqb3kgQ2hvd2RodXJ5IHdyb3RlOgo+IFdlIHdlcmUgc3Rv
cmluZyB0aGUgcG9pbnRlcnMgdG8gYnVmZmVycyBpbiBhIEdMaXN0IGR1ZSB0byBsYWNrIG9mCj4g
c3RhdGVmdWwgY3J5cHRvIGFwaXMgYW5kIGluc3RlYWQgZG9pbmcgdGhlIGZpbmFsIGhhc2ggY29t
cHV0YXRpb24gYXQKPiB0aGUgZW5kIGFmdGVyIHdlIGhhZCBhbGwgdGhlIG5lY2Vzc2FyeSBidWZm
ZXJzLiBOb3cgdGhhdCB3ZSBoYXZlIHRoZQo+IHN0YXRlZnVsIHFjcnlwdG8gYXBpcyBhdmFpbGFi
bGUsIHdlIGNhbiBpbnN0ZWFkIHVwZGF0ZSB0aGUgaGFzaGVzCj4gaW5saW5lIGluIHRoZSByZWFk
X2VpZl8qIGZ1bmN0aW9ucyB3aGljaCBtYWtlcyB0aGUgY29kZSBtdWNoIHNpbXBsZXIuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBEb3Jqb3kgQ2hvd2RodXJ5IDxkb3Jqb3ljaHkxMTFAZ21haWwuY29tPgoK
ClJldmlld2VkLWJ5OiBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPgoKQWxleAoKCgoK
CkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1
c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2No
bGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90
dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0IEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMzY1IDUz
OCA1OTcK


