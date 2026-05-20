Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9134FCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 09:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPcsY-0003eD-5j; Wed, 20 May 2026 05:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gabriel.hartmann@netways.de>)
 id 1wPcsU-0003e1-Ro
 for qemu-devel@nongnu.org; Wed, 20 May 2026 05:06:10 -0400
Received: from mail1.netways.de ([2a01:4a0:4:1002::146])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gabriel.hartmann@netways.de>)
 id 1wPcsR-0003o7-Up
 for qemu-devel@nongnu.org; Wed, 20 May 2026 05:06:10 -0400
Received: from exchange.int.netways.de (nethqex2.int.netways.de
 [IPv6:2a01:4a0:4:2102::112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail1.netways.de (Postfix) with ESMTPS id 4gL5HZ27CNz3sSB;
 Wed, 20 May 2026 11:06:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netways.de; s=20241115;
 t=1779267962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TlS9FQZbWyn4v0UmJt4dwXD0KqzT2H+vVaTa0XDkia4=;
 b=h+KCgL7qOBc/CNcrnDZJGnX5YTLWUb6WpwoQHGe1w+oEnuPAg8ZIXdmDOrVWmRMhcij6k0
 VA/3lGf/zUonbI8iKmYN4AHIltBVDPogYQhoXjgfXqiI10B8SRJM94MXbV2MiSb77fCJf+
 Fjad6EEzkegg0YAM2MCsONYmpxQjr5/rmehpfaiFDYWZJlcejNoYZbgtM+9ix4S7e0H72d
 0KujDy0D7gZ6szsJg7jNnSB3WxW/Qz/+9sMbKicDjh1e4v/zBNUsO7JPzEoRoRExs/e18L
 aw5jr2m7qBXQ9SfDUIJFqO/AtNdRD4V6CXXXagIWCK5pC62wxId+rjg/sBHO5A==
Received: from nethqex1.int.netways.de (2a01:4a0:4:2102::111) by
 nethqex2.int.netways.de (2a01:4a0:4:2102::112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 11:06:01 +0200
Received: from nethqex1.int.netways.de ([fe80::250:56ff:fe84:9c82]) by
 nethqex1.int.netways.de ([fe80::250:56ff:fe84:9c82%8]) with mapi id
 15.02.2562.037; Wed, 20 May 2026 11:06:01 +0200
From: Gabriel Hartmann <gabriel.hartmann@netways.de>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "hector.cao@canonical.com" <hector.cao@canonical.com>, "cfontana@suse.de"
 <cfontana@suse.de>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/1] module: fix early stop for load module function
Thread-Topic: [PATCH v2 1/1] module: fix early stop for load module function
Thread-Index: AQHc2KSpQAJxvBj84E+5cx2wNc9QA7YWnOWA
Date: Wed, 20 May 2026 09:06:01 +0000
Message-ID: <7433C6E4-4D93-4230-8707-AE32CC2BC888@netways.de>
References: <20260430132418.275842-1-hector.cao@canonical.com>
 <20260430132418.275842-2-hector.cao@canonical.com>
In-Reply-To: <20260430132418.275842-2-hector.cao@canonical.com>
Accept-Language: en-DE, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2a01:4a0:4:2102:a428:5739:a1f5:893d]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AADE34557DDBF940997099D44329A486@netways.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Received-SPF: pass client-ip=2a01:4a0:4:1002::146;
 envelope-from=gabriel.hartmann@netways.de; helo=mail1.netways.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gV2VkLCBBcHIgMzAsIDIwMjYgYXQgMDM6MjQ6MThQTSArMDIwMCwgSGVjdG9yIENhbyB3cm90
ZToNCj4gQ29tbWl0IGM1NTFmYjBiNTNkIHJlZ3Jlc3NlZCBtb2R1bGUtbG9hZGluZyBiZWhhdmlv
ci4NCj4gSGlzdG9yaWNhbGx5LCB3aGVuIGxvYWRpbmcgZnJvbSBvbmUgbW9kdWxlIGRpcmVjdG9y
eSBmYWlsZWQsDQo+IFFFTVUgY29udGludWVkIHNlYXJjaGluZyB0aGUgcmVtYWluaW5nIGRpcmVj
dG9yaWVzLiBUaGF0IGNvbW1pdA0KPiBtYWRlIFFFTVUgc3RvcCBpZiBhIG1hdGNoaW5nIGZpbGUg
d2FzIGZvdW5kIGJ1dCBjb3VsZCBub3QgYmUNCj4gbG9hZGVkIChmb3IgZXhhbXBsZSwgZHVlIHRv
IGEgYnVpbGQgbWlzbWF0Y2gpLg0KDQpUaGFua3MgZm9yIHRoZSB2MiwgSGVjdG9yLiBUaGUgZXJy
cCBoYW5kbGluZyB3aXRoIGVycm9yX3JlcG9ydF9lcnIoKQ0KbG9va3MgY29ycmVjdCBub3cg4oCU
IGVycm9ycyBhcmUgcmVwb3J0ZWQgYW5kIGNsZWFyZWQgYmV0d2VlbiBpdGVyYXRpb25zLA0KYW5k
IHRoZSBsYXN0IGVycm9yIGlzIHByb3BhZ2F0ZWQgdG8gdGhlIGNhbGxlci4NCg0KT25lIG1pbm9y
IGVkZ2UgY2FzZTogaWYgYW4gZWFybGllciBkaXJlY3RvcnkgaGFzIGEgYnVpbGQgbWlzbWF0Y2gN
CihydiA9IC0xKSBidXQgdGhlIHJldGFpbmVkIG1vZHVsZSBkaXJlY3RvcnkgZG9lc24ndCBoYXZl
IHRoZSBmaWxlDQphdCBhbGwgKEVOT0VOVCksIHJ2IHN0YXlzIGF0IC0xIHdpdGggKmVycnAgPT0g
TlVMTC4gVGhlIGNhbGxlcg0KZ2V0cyBhIGZhaWx1cmUgcmV0dXJuIHdpdGhvdXQgYW4gZXJyb3Ig
bWVzc2FnZS4gSW4gcHJhY3RpY2UgdGhpcw0KaXMgdW5saWtlbHkgc2luY2UgL3J1bi9xZW11Lzx2
ZXJzaW9uPi8gc2hvdWxkIGNvbnRhaW4gdGhlIG1vZHVsZQ0KaWYgaXQgd2FzIHJldGFpbmVkLCBz
byBJIGRvbid0IHRoaW5rIHRoaXMgbmVlZHMgdG8gYmxvY2sgdGhlIHBhdGNoLg0KDQpSZXZpZXdl
ZC1ieTogR2FicmllbCBIYXJ0bWFubiA8Z2FicmllbC5oYXJ0bWFubkBuZXR3YXlzLmRlPg0KDQot
LeKAgg0KR2FicmllbCBIYXJ0bWFubg0KU2VuaW9yIFN5c3RlbXMgRW5naW5lZXINCg0KTkVUV0FZ
UyBNYW5hZ2VkIFNlcnZpY2VzIEdtYkggfCBEZXV0c2NoaGVycm5zdHIuIDE1LTE5IHwgRC05MDQy
OSBOdWVybmJlcmcNClRlbDogKzQ5IDkxMSA5Mjg4NS0wIHwgRmF4OiArNDkgOTExIDkyODg1LTc3
DQpDRU86IEp1bGlhbiBIZWluLCBCZXJuZCBFcmssIFNlYmFzdGlhbiBTYWVtYW5uIHwgQUcgTnVl
cm5iZXJnIEhSQjI1MjA3DQpodHRwczovL3d3dy5uZXR3YXlzLmRlIHwgZ2FicmllbC5oYXJ0bWFu
bkBuZXR3YXlzLmRlDQoNCioqIE51cmVtYmVyZyBEaWdpdGFsIEZlc3RpdmFsIHwgT3BlbiBTb3Vy
Y2UgTmlnaHQgMjMuMDYuMjYgfCBodHRwczovL25ldHdheXMuZGUvbnVlZGlnaXRhbDIwMjYgKioN
CioqIE9wZW4gVGVjaCBEYXkgMjAyNiB8IFNvZnR3YXJlIERlZmluZWQgU3RvcmFnZSAtIE9jdG9i
ZXIgfCBOdXJlbWJlcmcgLSBodHRwczovL29wZW50ZWNoZGF5LmRlLyAqKg0KKiogT3BlbiBTb3Vy
Y2UgTW9uaXRvcmluZyBDb25mZXJlbmNlIDIwMjYgLSBOb3ZlbWJlciB8IE51cmVtYmVyZyAtIGh0
dHBzOi8vb3NtYy5kZSAqKg0KKiogTkVUV0FZUyBXZWIgU2VydmljZXMgLSBodHRwczovL253cy5u
ZXR3YXlzLmRlICoqDQoqKiBORVRXQVlTIFRyYWluaW5ncyAtIGh0dHBzOi8vbmV0d2F5cy5kZS90
cmFpbmluZ3MgKioNCg==

