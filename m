Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17EAD7832F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 15:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI8Ub-00086M-FY; Mon, 02 Dec 2024 10:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=059b58481=graf@amazon.de>)
 id 1tI8UO-00082i-58
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 10:37:33 -0500
Received: from smtp-fw-52003.amazon.com ([52.119.213.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=059b58481=graf@amazon.de>)
 id 1tI8UL-0001l0-OR
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 10:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1733153850; x=1764689850;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9ypauYx+rmA7o+v6oQXb1DJayLbzLUy5WJV0av+Jzjw=;
 b=g9GZso10iIKb541fev7OVdox+q1Yk9+8yMRQOIf7sgJVfX2qiTT6YWaZ
 yOI8LorqquDxQ2h89DIgXxD6WvEtFNCcOLt7+STIA6BGmEX89vauhbbK2
 BUdW7bRqnOGnArDOXX8OUo67LPRtkPoidjpBWkJWxN9bMiSYzxJjjRnXK k=;
X-IronPort-AV: E=Sophos;i="6.12,202,1728950400"; d="scan'208";a="45951957"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
 by smtp-border-fw-52003.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 15:37:26 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:7051]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.41:2525]
 with esmtp (Farcaster)
 id 4c7f3d0f-05d9-4bbb-a755-e69d7d718b41; Mon, 2 Dec 2024 15:37:25 +0000 (UTC)
X-Farcaster-Flow-ID: 4c7f3d0f-05d9-4bbb-a755-e69d7d718b41
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 2 Dec 2024 15:37:25 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Mon, 2 Dec 2024
 15:37:24 +0000
Message-ID: <71578735-157b-4347-98cb-f899be535809@amazon.com>
Date: Mon, 2 Dec 2024 16:37:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] device/virtio-nsm: Support string data for extendPCR
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>
References: <20241109123208.24281-1-dorjoychy111@gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20241109123208.24281-1-dorjoychy111@gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=52.119.213.152;
 envelope-from=prvs=059b58481=graf@amazon.de; helo=smtp-fw-52003.amazon.com
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

Ck9uIDA5LjExLjI0IDEzOjMyLCBEb3Jqb3kgQ2hvd2RodXJ5IHdyb3RlOgo+IE5TTSBkZXZpY2Ug
aW4gQVdTIE5pdHJvIEVuY2xhdmVzIHN1cHBvcnRzIGV4dGVuZGluZyB3aXRoIGJvdGgKPiBieXRl
c3RyaW5nIGFuZCBzdHJpbmcgZGF0YS4KPgo+IFNpZ25lZC1vZmYtYnk6IERvcmpveSBDaG93ZGh1
cnkgPGRvcmpveWNoeTExMUBnbWFpbC5jb20+CgoKUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBHcmFm
IDxncmFmQGFtYXpvbi5jb20+CgpBbGV4CgoKPiAtLS0KPiAgIGh3L3ZpcnRpby92aXJ0aW8tbnNt
LmMgfCAyMSArKysrKysrKysrKysrKy0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNl
cnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aXJ0
aW8tbnNtLmMgYi9ody92aXJ0aW8vdmlydGlvLW5zbS5jCj4gaW5kZXggYTNkYjhlZWYzZS4uNjgz
MGZjZmUxNyAxMDA2NDQKPiAtLS0gYS9ody92aXJ0aW8vdmlydGlvLW5zbS5jCj4gKysrIGIvaHcv
dmlydGlvL3ZpcnRpby1uc20uYwo+IEBAIC00NDQsNyArNDQ0LDcgQEAgc3RhdGljIGJvb2wgaGFu
ZGxlX2Rlc2NyaWJlX3BjcihWaXJ0SU9OU00gKnZuc20sIHN0cnVjdCBpb3ZlYyAqcmVxdWVzdCwK
PiAgICAqICAgICAgIGtleSA9IFN0cmluZygiaW5kZXgiKSwKPiAgICAqICAgICAgIHZhbHVlID0g
VWludDgocGNyKSwKPiAgICAqICAgICAgIGtleSA9IFN0cmluZygiZGF0YSIpLAo+IC0gKiAgICAg
ICB2YWx1ZSA9IEJ5dGVfU3RyaW5nKGRhdGEpLAo+ICsgKiAgICAgICB2YWx1ZSA9IEJ5dGVfU3Ry
aW5nKGRhdGEpIHx8IFN0cmluZyhkYXRhKSwKPiAgICAqICAgICB9Cj4gICAgKiAgIH0KPiAgICAq
IH0KPiBAQCAtNTA0LDE0ICs1MDQsMjEgQEAgc3RhdGljIGVudW0gTlNNUmVzcG9uc2VUeXBlcyBn
ZXRfbnNtX2V4dGVuZF9wY3JfcmVxKHVpbnQ4X3QgKnJlcSwgc2l6ZV90IGxlbiwKPgo+ICAgICAg
ICAgICBpZiAoY2Jvcl9zdHJpbmdfbGVuZ3RoKHBhaXJbaV0ua2V5KSA9PSA0ICYmCj4gICAgICAg
ICAgICAgICBtZW1jbXAoc3RyLCAiZGF0YSIsIDQpID09IDApIHsKPiAtICAgICAgICAgICAgaWYg
KCFjYm9yX2lzYV9ieXRlc3RyaW5nKHBhaXJbaV0udmFsdWUpKSB7Cj4gKyAgICAgICAgICAgIGlm
IChjYm9yX2lzYV9ieXRlc3RyaW5nKHBhaXJbaV0udmFsdWUpKSB7Cj4gKyAgICAgICAgICAgICAg
ICBzdHIgPSBjYm9yX2J5dGVzdHJpbmdfaGFuZGxlKHBhaXJbaV0udmFsdWUpOwo+ICsgICAgICAg
ICAgICAgICAgaWYgKCFzdHIpIHsKPiArICAgICAgICAgICAgICAgICAgICBnb3RvIGNsZWFudXA7
Cj4gKyAgICAgICAgICAgICAgICB9Cj4gKyAgICAgICAgICAgICAgICBuc21fcmVxLT5kYXRhX2xl
biA9IGNib3JfYnl0ZXN0cmluZ19sZW5ndGgocGFpcltpXS52YWx1ZSk7Cj4gKyAgICAgICAgICAg
IH0gZWxzZSBpZiAoY2Jvcl9pc2Ffc3RyaW5nKHBhaXJbaV0udmFsdWUpKSB7Cj4gKyAgICAgICAg
ICAgICAgICBzdHIgPSBjYm9yX3N0cmluZ19oYW5kbGUocGFpcltpXS52YWx1ZSk7Cj4gKyAgICAg
ICAgICAgICAgICBpZiAoIXN0cikgewo+ICsgICAgICAgICAgICAgICAgICAgIGdvdG8gY2xlYW51
cDsKPiArICAgICAgICAgICAgICAgIH0KPiArICAgICAgICAgICAgICAgIG5zbV9yZXEtPmRhdGFf
bGVuID0gY2Jvcl9zdHJpbmdfbGVuZ3RoKHBhaXJbaV0udmFsdWUpOwo+ICsgICAgICAgICAgICB9
IGVsc2Ugewo+ICAgICAgICAgICAgICAgICAgIGdvdG8gY2xlYW51cDsKPiAgICAgICAgICAgICAg
IH0KPiAtICAgICAgICAgICAgc3RyID0gY2Jvcl9ieXRlc3RyaW5nX2hhbmRsZShwYWlyW2ldLnZh
bHVlKTsKPiAtICAgICAgICAgICAgaWYgKCFzdHIpIHsKPiAtICAgICAgICAgICAgICAgIGdvdG8g
Y2xlYW51cDsKPiAtICAgICAgICAgICAgfQo+IC0gICAgICAgICAgICBuc21fcmVxLT5kYXRhX2xl
biA9IGNib3JfYnl0ZXN0cmluZ19sZW5ndGgocGFpcltpXS52YWx1ZSk7Cj4gICAgICAgICAgICAg
ICAvKgo+ICAgICAgICAgICAgICAgICogbnNtX3JlcS0+ZGF0YV9sZW4gd2lsbCBiZSBzbWFsbGVy
IHRoYW4gTlNNX1JFUVVFU1RfTUFYX1NJWkUgYXMKPiAgICAgICAgICAgICAgICAqIHdlIGFscmVh
ZHkgY2hlY2sgZm9yIHRoZSBtYXggcmVxdWVzdCBzaXplIGJlZm9yZSBwcm9jZXNzaW5nCj4gLS0K
PiAyLjM5LjUKPgoKCgpBbWF6b24gV2ViIFNlcnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJt
YW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzog
Q2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dl
cmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3Qt
SUQ6IERFIDM2NSA1MzggNTk3Cg==


