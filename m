Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5341DD2C13D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Ld6-0002ej-1G; Tue, 05 Nov 2024 10:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=0327b8673=graf@amazon.de>)
 id 1t8Ld4-0002WA-Dx
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:38:02 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=0327b8673=graf@amazon.de>)
 id 1t8Ld2-0004wZ-BP
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1730821080; x=1762357080;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vsA+aCodJkHMo2EE6rxlbVxnZGLgQono3pGO+F+B8x8=;
 b=VO4YXFwHZt9Hqjrs+nM90HzbnMgnCEd5PpX2DYVHGKYY12JwyXmo+i+o
 zpKCnDrth+Lrbwb0A85NSGm56766UxNvVn3sUSgo5o6kVBT3ZfKOIh95p
 Vh8Qy9HWbzUEIkU1Vg9MwFDqvgz3ECMQUPN48UJk1r1yUIZqhe4wpgu/h Y=;
X-IronPort-AV: E=Sophos;i="6.11,260,1725321600"; d="scan'208";a="440452095"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-2101.iad2.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 15:37:54 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:31324]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.36:2525]
 with esmtp (Farcaster)
 id be90f70f-9910-41c8-a2d0-b02eb9a733b8; Tue, 5 Nov 2024 15:37:53 +0000 (UTC)
X-Farcaster-Flow-ID: be90f70f-9910-41c8-a2d0-b02eb9a733b8
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 15:37:52 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Tue, 5 Nov 2024
 15:37:50 +0000
Message-ID: <4d1b7a92-dd01-42ca-9342-5c845d8b67da@amazon.com>
Date: Tue, 5 Nov 2024 07:37:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 23/49] hw/core: Add Enclave Image Format (EIF) related
 helpers
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>
CC: Peter Maydell <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>
References: <20241031175214.214455-1-pbonzini@redhat.com>
 <20241031175214.214455-24-pbonzini@redhat.com>
 <CAFEAcA_mJtsuqSOnDfBLuX+cTuAmDHksRhGA3jq=5tUS5RKn4A@mail.gmail.com>
 <CABgObfbYzNMQDmEwYpXBgsUJ2V+br5QMHh4B9vWSdFxxg6wvNA@mail.gmail.com>
 <CAFfO_h4kkpJXaM5if01jWPGXdmdveE9VPNhxU=j_OVF3bu_LhA@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAFfO_h4kkpJXaM5if01jWPGXdmdveE9VPNhxU=j_OVF3bu_LhA@mail.gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=72.21.196.25;
 envelope-from=prvs=0327b8673=graf@amazon.de; helo=smtp-fw-2101.amazon.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

SGkgRG9yam95LAoKCk9uIDA1LjExLjI0IDE0OjU2LCBEb3Jqb3kgQ2hvd2RodXJ5IHdyb3RlOgo+
IE9uIFR1ZSwgTm92IDUsIDIwMjQgYXQgNjo1MeKAr1BNIFBhb2xvIEJvbnppbmkgPHBib256aW5p
QHJlZGhhdC5jb20+IHdyb3RlOgo+PiBPbiBUdWUsIE5vdiA1LCAyMDI0IGF0IDEyOjQ04oCvUE0g
UGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPiB3cm90ZToKPj4+IEhpOyBD
b3Zlcml0eSByYWlzZXMgYSBjb3VwbGUgb2YgcG90ZW50aWFsIGlzc3VlcyB3aXRoIHRoZQo+Pj4g
cmVhZF9laWZfZmlsZSgpIGZ1bmN0aW9uIGluIHRoaXMgY29tbWl0LCB3aGljaCBhcmUgYm90aAo+
Pj4gIkNvdmVyaXR5IGFzc3VtZXMgdGhlIGZpbGUgd2UncmUgcmVhZGluZyBpcyB1bnRydXN0ZWQg
YW5kIGlzCj4+PiB1bnN1cmUgdGhhdCB3ZSdyZSBjb3JyZWN0bHkgc2FuaXRpemluZyBkYXRhIGZy
b20gaXQgYmVmb3JlIHVzZSIuCj4+PiBDb3VsZCBzb21lYm9keSB3aG8gdW5kZXJzdGFuZHMgdGhl
IHVzZSBjYXNlIGhlcmUgY2hlY2sgd2hldGhlcgo+Pj4gdGhlc2UgbmVlZCBhZGRyZXNzaW5nPwo+
PiBCb3RoIGFyZSByZWFzb25hYmxlIHRvIGZpeCwgZXZlbiBpZiB0aGUgdXNlIGNhc2Ugd291bGQg
bm90IG1ha2UgdGhlbQo+PiBzZWN1cml0eSBzZW5zaXRpdmUuIEknbGwgcHJlcGFyZSBhbmQgc2Vu
ZCBhIHBhdGNoLgo+Pgo+IEFncmVlIHRoYXQgaXQgbWFrZXMgc2Vuc2UgdG8gZml4LiBUaGFua3Mg
UGFvbG8gZm9yIGxvb2tpbmcgaW50byBpdC4gSQo+IGNhbiByZXZpZXcgd2hlbiB0aGUgcGF0Y2gg
aXMgcmVhZHkuCj4KPiBCVFcgSSBzZWUgdGhlcmUgaXMgc29tZSBmb3JtYXR0aW5nIGlzc3VlIGlu
IHRoZSBkb2N1bWVudGF0aW9uIG9mCj4gbml0cm8tZW5jbGF2ZSBpbiB0aGUgUUVNVSB3ZWJzaXRl
Ogo+IGh0dHBzOi8vd3d3LnFlbXUub3JnL2RvY3MvbWFzdGVyL3N5c3RlbS9pMzg2L25pdHJvLWVu
Y2xhdmUuaHRtbAo+IEkgdGhpbmsgaXQncyBhIHNpbXBsZSBmaXggd2hlcmUgd2UgbmVlZCB0byBw
dXQgdHdvIGNvbG9ucyAoOjopIGluIGEKPiBsaW5lIGJlZm9yZSB0aGUgUUVNVSBjb21tYW5kcyBs
aW5lcy4gTWF5YmUgaXQgd291bGQgbWFrZSBzZW5zZSB0bwo+IGluY2x1ZGUgaXQgaW4gdGhlIHBh
dGNoZXMgYXMgd2VsbC4KCgpGZWVsIGZyZWUgdG8ganVzdCBzZW5kIGEgcGF0Y2ggdG8gZml4IHRo
ZW0gb24gdG9wIG9mIFBhb2xvJ3MgcHVsbCAKcmVxdWVzdCB0byB0aGUgbWFpbGluZyBsaXN0IDop
LgoKCkFsZXgKCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1h
bnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBD
aHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2Vy
aWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0IEIKU2l0ejogQmVybGluClVzdC1J
RDogREUgMzY1IDUzOCA1OTcK


