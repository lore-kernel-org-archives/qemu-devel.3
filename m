Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680FCE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 11:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tObFx-0006FX-L7; Fri, 20 Dec 2024 06:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=077b2128c=graf@amazon.de>)
 id 1tObFx-0006FL-22
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 06:33:21 -0500
Received: from smtp-fw-52002.amazon.com ([52.119.213.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=077b2128c=graf@amazon.de>)
 id 1tObFv-0005yF-72
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 06:33:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1734694399; x=1766230399;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=a1GSq2T5aMtDv4LJ+YxtVs3Y3Sb21s7MRf7viPDcJVw=;
 b=dHm7ZzicMNAu4UG6h83XLeWcH8wkpmftkSrUMg7n28zOQP5o3mjcheDT
 UbD64rxUDYklA8myl0ewqGErB6qWUCP3LqXSPxhRYIU7oD2CViHwi5Bh1
 TF9syt74iHRA5ihCDv53AH3IT1kmw4XyZMLpmSspjQHJuoQa7gildBZDJ c=;
X-IronPort-AV: E=Sophos;i="6.12,250,1728950400"; d="scan'208";a="682917104"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-52002.iad7.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 11:33:10 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:62951]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.85:2525] with
 esmtp (Farcaster)
 id 65606565-87a7-4cc9-9bce-62b8afa2db07; Fri, 20 Dec 2024 11:33:10 +0000 (UTC)
X-Farcaster-Flow-ID: 65606565-87a7-4cc9-9bce-62b8afa2db07
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 20 Dec 2024 11:33:03 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39; Fri, 20 Dec 2024
 11:33:01 +0000
Message-ID: <1bbf92cf-d9d0-421e-b674-fb216cb7216a@amazon.com>
Date: Fri, 20 Dec 2024 12:32:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <3b2e9941-e5a3-4981-adda-f5121bc98e9a@linaro.org>
 <CAK3XEhNVXZDD0i3pxpSgnogheyJO7dfQ4p0UdvhqU3DrFXJ_ZA@mail.gmail.com>
 <55f6dfe7-cadf-4942-81e8-18b15938c349@linaro.org>
 <CAK3XEhNN9EO75vgsdRboMZ7nwZbaL0eenSwSy-7Hze-ukyTZsQ@mail.gmail.com>
 <7c1a7e86-8996-43ab-aa07-6763387b2bc5@linaro.org>
 <CAK3XEhOZ50Co0hAS31KYyQA+mgwXSoGCxMu_vhZXmpP0RwT6Mw@mail.gmail.com>
 <CAK3XEhOAD1cueixs6w2ojvudOwz5YrTxzN4x_kgZTkg_EfFXsA@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAK3XEhOAD1cueixs6w2ojvudOwz5YrTxzN4x_kgZTkg_EfFXsA@mail.gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=52.119.213.150;
 envelope-from=prvs=077b2128c=graf@amazon.de; helo=smtp-fw-52002.amazon.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
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

Ck9uIDIwLjEyLjI0IDExOjAwLCBBbmkgU2luaGEgd3JvdGU6Cj4+PiBFaXRoZXIgYWRkIHRoZSBJ
Mzg2IGRlcGVuZGVuY3kgb3IgZG9uJ3QgdXNlIFBDX01BQ0hJTkUsIGJlY2F1c2Ugb24KPj4+IG5v
bi14ODYgdGFyZ2V0cyBQQ19NQUNISU5FKHFkZXZfZ2V0X21hY2hpbmUoKSkgd2lsbCBjcmFzaC4K
Pj4gQWggdGhpcyBpcyB3aGVyZSB3ZSBoYXZlIGEgZGlzY29ubmVjdC4gSSBhc3N1bWVkIHRoYXQK
Pj4+IHBjbXMgPSBQQ19NQUNISU5FKG1fb2JqKQo+PiB3b3VsZCByZXR1cm4gTlVMTCBvbiBub24t
eDg2Lgo+Pgo+PiBTZWVtcyBhIGJldHRlciB3YXkgdG8gZG8gdGhpcyAoYXMgaXMgZG9uZSBpbiB2
Z2EuYykgaXMgdG8gdXNlCj4+IG9iamVjdF9keW5hbWljX2Nhc3QoKQo+PiBIb3cgYWJvdXQKPj4K
Pj4gZGlmZiAtLWdpdCBhL2h3L21pc2Mvdm1md3VwZGF0ZS5jIGIvaHcvbWlzYy92bWZ3dXBkYXRl
LmMKPj4gaW5kZXggMGU5MGJkMTBlMS4uMTlkMDQyYjkyOSAxMDA2NDQKPj4gLS0tIGEvaHcvbWlz
Yy92bWZ3dXBkYXRlLmMKPj4gKysrIGIvaHcvbWlzYy92bWZ3dXBkYXRlLmMKPj4gQEAgLTMyLDkg
KzMyLDExIEBAIHN0YXRpYyBpbmxpbmUgVk1Gd1VwZGF0ZVN0YXRlICp2bWZ3dXBkYXRlX2ZpbmQo
dm9pZCkKPj4gICBzdGF0aWMgdWludDY0X3QgZ2V0X21heF9md19zaXplKHZvaWQpCj4+ICAgewo+
PiAgICAgICBPYmplY3QgKm1fb2JqID0gcWRldl9nZXRfbWFjaGluZSgpOwo+PiAtICAgIFBDTWFj
aGluZVN0YXRlICpwY21zID0gUENfTUFDSElORShtX29iaik7Cj4+ICsgICAgTWFjaGluZVN0YXRl
ICptcyA9IE1BQ0hJTkUobV9vYmopOwo+PiArICAgIFBDTWFjaGluZVN0YXRlICpwY21zOwo+PiAt
ICAgIGlmIChwY21zKSB7Cj4+ICsgICAgaWYgKG9iamVjdF9keW5hbWljX2Nhc3QoT0JKRUNUKG1z
KSwgVFlQRV9YODZfTUFDSElORSkpIHsKPj4gKyAgICAgICAgcGNtcyA9IFBDX01BQ0hJTkUobV9v
YmopOwo+PiAgICAgICAgICAgcmV0dXJuIHBjbXMtPm1heF9md19zaXplOwo+PiAgICAgICB9IGVs
c2Ugewo+PiAgICAgICAgICAgcmV0dXJuIDA7Cj4+Cj4gRm9yIHRoZSByZWNvcmRzLCBJIHRlc3Rl
ZCB0aGlzIHdpdGggYXJtIGFuZCB0aGUgZm9sbG93aW5nIGNvbW1hbmQgbGluZQo+IGRvZXMgbm90
IGNyYXNoIFFFTVU7Cj4KPiAuL3FlbXUtc3lzdGVtLWFybSAtbWFjaGluZSB2aXJ0LTkuMiAtZGV2
aWNlIHZtZnd1cGRhdGUKPgo+IEkgaGF2ZSBhbHNvIGFkZGVkIGEgc2VwYXJhdGUgZnVuY3Rpb25h
bCB0ZXN0IHRvIGV4ZXJjaXNlIGJhc2ljIGRldmljZQo+IGNyZWF0aW9uIHdoaWNoIHdpbGwgYmUg
cGFydCBvZiB2NSB3aGVuIEkgc2VuZCBpdCBvdXQuCgoKWW91IGFyZSBjdXJyZW50bHkgbm90IGlt
cGxlbWVudGluZyB0aGUgcmVzZXQgbG9naWMgcmVxdWlyZWQgdG8gYWN0dWFsbHkgCm1ha2Ugdm1m
d3VwZGF0ZSB3b3JrLiBUaGF0IG1lYW5zIHRlY2huaWNhbGx5LCB0aGUgZGV2aWNlIHNob3VsZCBu
b3QgYmUgCmluc3RhbnRpYWJsZSBvbiAqYW55KiBwbGF0Zm9ybSBhdCB0aGUgbW9tZW50LiBGb3Ig
ZXhhbXBsZSB3aXRoIHRoZSAKY29tbWFuZCBsaW5lIGFib3ZlIHlvdSB3b3VsZCBhZHZlcnRpc2Ug
dGhlIGNhcGFiaWxpdHkgdG8gdXBkYXRlIGZpcm13YXJlIAppbiBmdy1jZmcsIGJ1dCB0aGVuIG5v
dCBiYWNrIGl0IGJ5IGZ1bmN0aW9uYWxpdHkuIElmIFFFTVUgd2VyZSB0byBtZXJnZSAKdGhpcyBw
YXRjaCwgaXQgd291bGQganVzdCBjcmVhdGUgYSBicm9rZW4gZGV2aWNlLgoKUGxlYXNlIG1ha2Ug
c3VyZSB0aGF0IHRoZSB2bWZ3dXBkYXRlIGRldmljZSBjYW4gb25seSBiZSBpbnN0YW50aWF0ZWQg
b24gCm1hY2hpbmUgdHlwZXMgdGhhdCBpdCBoYXMgZnVsbCBzdXBwb3J0IGZvci4KCgpBbGV4CgoK
CgpBbWF6b24gV2ViIFNlcnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3Jh
dXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNj
aGxhZWdlciwgSm9uYXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxv
dHRlbmJ1cmcgdW50ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1
MzggNTk3Cg==


