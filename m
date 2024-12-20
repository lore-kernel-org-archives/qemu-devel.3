Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76FAE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 18:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOhaw-0005Id-V1; Fri, 20 Dec 2024 13:19:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=077b2128c=graf@amazon.de>)
 id 1tOhau-0005IT-Ni
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 13:19:24 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=077b2128c=graf@amazon.de>)
 id 1tOhat-0004a4-0o
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 13:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1734718764; x=1766254764;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=lT9bvBBGgdXF8bBXGniOmeasBAxn3YwgBtU1NSrp3Qg=;
 b=F01WW4K/EN+8/CL2oFRZnEhWu9Oclgn+ekh+Onucd+ssuL4F4352ipyi
 NZG9IS0YQ5SDGrk3mMvB+Uq9EVqAqP6Q6wGdiJtRelVfW9HDprkd1ipVW
 Kjh6uZCW/oqL6Ived0jAoDA2cYrUUzxlo0QFtCaiA16pKx0t54nz+Dpiv Q=;
X-IronPort-AV: E=Sophos;i="6.12,251,1728950400"; d="scan'208";a="457708970"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
 by smtp-border-fw-6002.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 18:19:20 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:46391]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.75:2525] with
 esmtp (Farcaster)
 id 61690754-8cb3-495f-af7f-7eb265e151fb; Fri, 20 Dec 2024 18:19:18 +0000 (UTC)
X-Farcaster-Flow-ID: 61690754-8cb3-495f-af7f-7eb265e151fb
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 20 Dec 2024 18:19:06 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39; Fri, 20 Dec 2024
 18:19:05 +0000
Message-ID: <8d616de4-3083-45e9-81b9-f9e9a00dbe71@amazon.com>
Date: Fri, 20 Dec 2024 19:19:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Ani Sinha <anisinha@redhat.com>
CC: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffman <kraxel@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel
 <qemu-devel@nongnu.org>
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <3b2e9941-e5a3-4981-adda-f5121bc98e9a@linaro.org>
 <CAK3XEhNVXZDD0i3pxpSgnogheyJO7dfQ4p0UdvhqU3DrFXJ_ZA@mail.gmail.com>
 <55f6dfe7-cadf-4942-81e8-18b15938c349@linaro.org>
 <CAK3XEhNN9EO75vgsdRboMZ7nwZbaL0eenSwSy-7Hze-ukyTZsQ@mail.gmail.com>
 <7c1a7e86-8996-43ab-aa07-6763387b2bc5@linaro.org>
 <CAK3XEhOZ50Co0hAS31KYyQA+mgwXSoGCxMu_vhZXmpP0RwT6Mw@mail.gmail.com>
 <CAK3XEhOAD1cueixs6w2ojvudOwz5YrTxzN4x_kgZTkg_EfFXsA@mail.gmail.com>
 <1bbf92cf-d9d0-421e-b674-fb216cb7216a@amazon.com>
 <CAK3XEhOmpQULP6xCetkrwHC_FzSMRs7LSsCyzeUpvqRkw-zkOA@mail.gmail.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAK3XEhOmpQULP6xCetkrwHC_FzSMRs7LSsCyzeUpvqRkw-zkOA@mail.gmail.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=52.95.49.90;
 envelope-from=prvs=077b2128c=graf@amazon.de; helo=smtp-fw-6002.amazon.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Ck9uIDIwLjEyLjI0IDE0OjMxLCBBbmkgU2luaGEgd3JvdGU6Cj4gT24gRnJpLCBEZWMgMjAsIDIw
MjQgYXQgNTowM+KAr1BNIEFsZXhhbmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+IHdyb3RlOgo+
Pgo+PiBPbiAyMC4xMi4yNCAxMTowMCwgQW5pIFNpbmhhIHdyb3RlOgo+Pj4+PiBFaXRoZXIgYWRk
IHRoZSBJMzg2IGRlcGVuZGVuY3kgb3IgZG9uJ3QgdXNlIFBDX01BQ0hJTkUsIGJlY2F1c2Ugb24K
Pj4+Pj4gbm9uLXg4NiB0YXJnZXRzIFBDX01BQ0hJTkUocWRldl9nZXRfbWFjaGluZSgpKSB3aWxs
IGNyYXNoLgo+Pj4+IEFoIHRoaXMgaXMgd2hlcmUgd2UgaGF2ZSBhIGRpc2Nvbm5lY3QuIEkgYXNz
dW1lZCB0aGF0Cj4+Pj4+IHBjbXMgPSBQQ19NQUNISU5FKG1fb2JqKQo+Pj4+IHdvdWxkIHJldHVy
biBOVUxMIG9uIG5vbi14ODYuCj4+Pj4KPj4+PiBTZWVtcyBhIGJldHRlciB3YXkgdG8gZG8gdGhp
cyAoYXMgaXMgZG9uZSBpbiB2Z2EuYykgaXMgdG8gdXNlCj4+Pj4gb2JqZWN0X2R5bmFtaWNfY2Fz
dCgpCj4+Pj4gSG93IGFib3V0Cj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvbWlzYy92bWZ3dXBk
YXRlLmMgYi9ody9taXNjL3ZtZnd1cGRhdGUuYwo+Pj4+IGluZGV4IDBlOTBiZDEwZTEuLjE5ZDA0
MmI5MjkgMTAwNjQ0Cj4+Pj4gLS0tIGEvaHcvbWlzYy92bWZ3dXBkYXRlLmMKPj4+PiArKysgYi9o
dy9taXNjL3ZtZnd1cGRhdGUuYwo+Pj4+IEBAIC0zMiw5ICszMiwxMSBAQCBzdGF0aWMgaW5saW5l
IFZNRndVcGRhdGVTdGF0ZSAqdm1md3VwZGF0ZV9maW5kKHZvaWQpCj4+Pj4gICAgc3RhdGljIHVp
bnQ2NF90IGdldF9tYXhfZndfc2l6ZSh2b2lkKQo+Pj4+ICAgIHsKPj4+PiAgICAgICAgT2JqZWN0
ICptX29iaiA9IHFkZXZfZ2V0X21hY2hpbmUoKTsKPj4+PiAtICAgIFBDTWFjaGluZVN0YXRlICpw
Y21zID0gUENfTUFDSElORShtX29iaik7Cj4+Pj4gKyAgICBNYWNoaW5lU3RhdGUgKm1zID0gTUFD
SElORShtX29iaik7Cj4+Pj4gKyAgICBQQ01hY2hpbmVTdGF0ZSAqcGNtczsKPj4+PiAtICAgIGlm
IChwY21zKSB7Cj4+Pj4gKyAgICBpZiAob2JqZWN0X2R5bmFtaWNfY2FzdChPQkpFQ1QobXMpLCBU
WVBFX1g4Nl9NQUNISU5FKSkgewo+Pj4+ICsgICAgICAgIHBjbXMgPSBQQ19NQUNISU5FKG1fb2Jq
KTsKPj4+PiAgICAgICAgICAgIHJldHVybiBwY21zLT5tYXhfZndfc2l6ZTsKPj4+PiAgICAgICAg
fSBlbHNlIHsKPj4+PiAgICAgICAgICAgIHJldHVybiAwOwo+Pj4+Cj4+PiBGb3IgdGhlIHJlY29y
ZHMsIEkgdGVzdGVkIHRoaXMgd2l0aCBhcm0gYW5kIHRoZSBmb2xsb3dpbmcgY29tbWFuZCBsaW5l
Cj4+PiBkb2VzIG5vdCBjcmFzaCBRRU1VOwo+Pj4KPj4+IC4vcWVtdS1zeXN0ZW0tYXJtIC1tYWNo
aW5lIHZpcnQtOS4yIC1kZXZpY2Ugdm1md3VwZGF0ZQo+Pj4KPj4+IEkgaGF2ZSBhbHNvIGFkZGVk
IGEgc2VwYXJhdGUgZnVuY3Rpb25hbCB0ZXN0IHRvIGV4ZXJjaXNlIGJhc2ljIGRldmljZQo+Pj4g
Y3JlYXRpb24gd2hpY2ggd2lsbCBiZSBwYXJ0IG9mIHY1IHdoZW4gSSBzZW5kIGl0IG91dC4KPj4K
Pj4gWW91IGFyZSBjdXJyZW50bHkgbm90IGltcGxlbWVudGluZyB0aGUgcmVzZXQgbG9naWMgcmVx
dWlyZWQgdG8gYWN0dWFsbHkKPj4gbWFrZSB2bWZ3dXBkYXRlIHdvcmsuCj4gWWVzIHRoYXQgaXMg
Y29ycmVjdCBhbmQgdGhhdCBpcyBieSBkZXNpZ24uIFRoZSByZXNldCBsb2dpYyBvbiBDb0NvCj4g
ZGVwZW5kcyBvbiB0aGUgbGFyZ2VyIHBpZWNlIG9mIHdvcmsgb24gaG93IHRvIGVuYWJsZSByZXNl
dCBhbmQKPiByZS1pbnN0YW50aWF0aW9uIG9mIHRoZSBWTSB3aXRob3V0IHNpbXBseSB0ZXJtaW5h
dGluZy4gSSBkaWQgbm90IHdhbnQKPiB0byB3YWl0IHVudGlsIGFsbCB0aG9zZSBjb21wbGljYXRl
ZCBiaXRzIHdlcmUgc29ydGVkIG91dCBmaXJzdC4gSQo+IHdhbnRlZCB0byBtYWtlIHN1cmUgdGhh
dCB0aGUgaHlwZXJ2aXNvci9ndWVzdCBpbnRlcmZhY2UgaXMgcHV0IGluCj4gcGxhY2UuCgoKVGhp
cyBsb2dpYyBoYXMgbm8gZGVwZW5kZW5jeSBvbiBDb0NvLgoKCj4KPiBUaGF0IG1lYW5zIHRlY2hu
aWNhbGx5LCB0aGUgZGV2aWNlIHNob3VsZCBub3QgYmUKPj4gaW5zdGFudGlhYmxlIG9uICphbnkq
IHBsYXRmb3JtIGF0IHRoZSBtb21lbnQuIEZvciBleGFtcGxlIHdpdGggdGhlCj4+IGNvbW1hbmQg
bGluZSBhYm92ZSB5b3Ugd291bGQgYWR2ZXJ0aXNlIHRoZSBjYXBhYmlsaXR5IHRvIHVwZGF0ZSBm
aXJtd2FyZQo+PiBpbiBmdy1jZmcsIGJ1dCB0aGVuIG5vdCBiYWNrIGl0IGJ5IGZ1bmN0aW9uYWxp
dHkuCj4gT0sgc28gaWYgd2Ugd2FudGVkIHRvIHB1dCB0aGlzIHdvcmsgcGVhY2UgbWVhbCBpbiBz
bWFsbGVyIGNodW5rcywgY2FuCj4gd2UgaGF2ZSBhbiBhZGRpdGlvbmFsIGNhcGFiaWxpdHkgYml0
IHRoYXQgYWN0dWFsbHkgYWR2ZXJ0aXplcyB0aGlzCj4gZnVuY3Rpb25hbGl0eSBvbiBjZXJ0YWlu
IG1hY2hpbmUgdHlwZXMvcGxhdGZvcm1zPwoKCk1heWJlLiBUaGUgcHJvcGVydHkgd2UgbmVlZCBp
cyB0aGF0IHNwYXduaW5nIHRoaXMgZGV2aWNlIG9uIGEgbWFjaGluZSAKdHlwZSB0aGF0IGRvZXMg
bm90IHN1cHBvcnQgcmVzZXQgZW5saWdodGVubWVudCBmb3IgaXQgc2hvdWxkIGZhaWwgCmxhdW5j
aGluZy4gSSBkb24ndCByZWFsbHkgY2FyZSBob3cgeW91IGJ1aWxkIHRoYXQuIEJ1dCB0b2RheSwg
YWRkaW5nIAotZGV2aWNlIHZtZnd1cGRhdGUgc2hvdWxkIGZhaWwgb24gYW55IHRhcmdldCBzeXN0
ZW0uCgoKPgo+IElmIFFFTVUgd2VyZSB0byBtZXJnZQo+PiB0aGlzIHBhdGNoLCBpdCB3b3VsZCBq
dXN0IGNyZWF0ZSBhIGJyb2tlbiBkZXZpY2UuCj4gQXJlIHlvdSB0YWxraW5nIGFib3V0IENvQ28g
b3Igbm9uLUNvQ28/CgoKQWx3YXlzLiBUaGUgZ3Vlc3Qgd291bGQgc2VlIHRoZSBpbnRlcmZhY2Us
IHRyeSB0byBkcml2ZSBpdCBhbmQgdGhlbiB3ZSAKaWdub3JlIGl0cyBpbnB1dHMuIFdlIGhhdmUg
dG8gcHJldmVudCB0aGF0IGZyb20gaGFwcGVuaW5nIGlmIHdlIHdhbnQgdG8gCm1lcmdlIHRoZSBi
YXNlIGxvZ2ljIHdpdGhvdXQgYm9hcmQgYmFja2VuZCBjb2RlLgoKSSBwZXJzb25hbGx5IHRoaW5r
IHRoZSBib2FyZCBiYWNrZW5kIGNvZGUgZm9yIHBjIGlzIHNpbXBsZSBlbm91Z2ggdGhhdCAKaXQg
bWFrZXMgc2Vuc2UgdG8gZm9sZCBpbnRvIHRoaXMgcGF0Y2ggdGhvdWdoIHNvIHRoYXQgeW91IGhh
dmUgYXQgbGVhc3QgCm9uZSB3b3JraW5nIGJvYXJkLgoKCkFsZXgKCgoKCgpBbWF6b24gV2ViIFNl
cnZpY2VzIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAx
MTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRo
YW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIg
SFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1MzggNTk3Cg==


