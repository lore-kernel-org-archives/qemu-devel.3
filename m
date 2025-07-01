Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7C4C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 07:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWVMG-0007Ua-9B; Tue, 01 Jul 2025 03:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWVM9-0007TR-P4
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 03:24:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWVM5-0002id-VC
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 03:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751354674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/zv2SkYKPqpSeH05xRuJftTOquvB5rAvPKRlA54iwI=;
 b=E3QHa2/+U6o3UY8JNtGI3ycMKFA/qKqB9It1GnKqrws66958PL0yIChzjAHzGB8Y+jD6qa
 z3GSvFmzLqL3EA/VJ/raPu6gzFlcRjRtZ9Me4jpJTNP+PT3+FW+tH1ZOgxSGqMnnXWpMeI
 SyVyT3JED9ymo9SJy+IliH+HC1TOy1U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-cVv8XLZCPDik102gNZWmtg-1; Tue, 01 Jul 2025 03:24:33 -0400
X-MC-Unique: cVv8XLZCPDik102gNZWmtg-1
X-Mimecast-MFC-AGG-ID: cVv8XLZCPDik102gNZWmtg_1751354672
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f7f1b932so1758041f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 00:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751354671; x=1751959471;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N/zv2SkYKPqpSeH05xRuJftTOquvB5rAvPKRlA54iwI=;
 b=UqYGf0siAYm8JDl7dZquMjDZacfTJeop+QqUZAnTEsahRgeXtQ9qWfpIdEWjVx3n5/
 PT0/2nTag13IbIxr6pteyplOk3f8VTLp13J7MRoFjGYXI5eERr+YT1/2KiMbE48ZkD4x
 MUNMz7xcfXq8I20uVIrVm1fQPgij0YVovMdstGJgYItTSRsN0bECtLqz0H8jOsl0Xwjs
 Ws+o764bsC4L339E9g/dMki8TS8QKAIVfResp9neAHQZ+uimQ4gIgqVDWU/rfVk5Swvx
 9r0r3znXTA6il5tZvz+FhMGYUgrrEW+jzCIDOOiLrvhsJ8w7RAXiTF2ZNZCqxCFv8Xi5
 nIqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEIy90VXxg75v72GpP2i3n52ztH1CjFVZzwSAh+Ek99maMmn8RF5XUiNHpilgDt16YnyvwHGjHo8Ge@nongnu.org
X-Gm-Message-State: AOJu0Yw59/pu6+zNhzdx2DAp8eFd3EsZf8BH7KP1wjjggdZlcedRck13
 BDcatzWao7FzaTC0L4bvN4R0far5VQ5XuP+zEevfQtQ9doM1Dje5NAStxX9uTqISx2/S3vDyc3H
 HwwoA8mCEQ55F78bPxDQ32GEnuoEWhvpshs5C/nkc3JZv3Q9Mlo89Cv4i
X-Gm-Gg: ASbGncu+EaoMhuMbanavHVa+XqVHyBRbsuuJnoHoMq6SNxDnil4XYdcCttxxfLLIJQR
 XgwJsTMFOojfaeJwl1BpT8f1ViI/A6xhBDyNRoo3Hsa7fp/dTYnIqt+RxMm+f7dXG+jaRED6WC6
 SLhewFnZ4UUPYHyXqkyLuhBpBCc1QCraNAN6262mGGKrJ4K9vGvqtmNoGR/eSHed1zfmGcZfGhh
 RWegESdlvqkrZ9uMuKN5B33aBNc5L+1Uzn2FHS10vUNGPTDVtNQ39IlNo8lkDYScSWyeMVBvfzC
 yg0YXEqEod3lYXibkiYSNY6X69DYAdl9Emt+52u99wAw1oG9NLmvDy9iKAX9VjGcgn0yp2D4k+f
 sjLtjnmso1STbqFRM0/TYwkSsyxvXz6nmZFqzPppuGVvZMdSe78M=
X-Received: by 2002:adf:9d89:0:b0:3a6:e2d5:f14c with SMTP id
 ffacd0b85a97d-3a8fdeff3fcmr11681276f8f.30.1751354671528; 
 Tue, 01 Jul 2025 00:24:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKvaoz3ItB6k1I3vlYAsWz1ZuEXsWM0/qqNhWd1jOEFHrqtdcO8Pzi4G4PUGLhbbZWOcf1LQ==
X-Received: by 2002:adf:9d89:0:b0:3a6:e2d5:f14c with SMTP id
 ffacd0b85a97d-3a8fdeff3fcmr11681241f8f.30.1751354671031; 
 Tue, 01 Jul 2025 00:24:31 -0700 (PDT)
Received: from ?IPV6:2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f?
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e59659sm12411974f8f.77.2025.07.01.00.24.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 00:24:29 -0700 (PDT)
Message-ID: <0ffd2ae1-2e77-4911-aead-27f318771561@redhat.com>
Date: Tue, 1 Jul 2025 09:24:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/21] block: Move qemu_fcntl_addfl() into osdep.c
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Brian Song <hibriansong@gmail.com>
References: <20250604132813.359438-1-hreitz@redhat.com>
 <20250604132813.359438-13-hreitz@redhat.com> <20250609150310.GF29452@fedora>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250609150310.GF29452@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gMDkuMDYuMjUgMTc6MDMsIFN0ZWZhbiBIYWpub2N6aSB3cm90ZToNCj4gT24gV2VkLCBK
dW4gMDQsIDIwMjUgYXQgMDM6Mjg6MDRQTSArMDIwMCwgSGFubmEgQ3plbmN6ZWsgd3JvdGU6
DQo+PiBNb3ZlIGZpbGUtcG9zaXgncyBoZWxwZXIgdG8gYWRkIGEgZmxhZyAob3IgYSBzZXQg
b2YgZmxhZ3MpIHRvIGFuIEZEJ3MNCj4+IGV4aXN0aW5nIHNldCBvZiBmbGFncyBpbnRvIG9z
ZGVwLmMgZm9yIG90aGVyIHBsYWNlcyB0byB1c2UuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBF
cmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEhhbm5h
IEN6ZW5jemVrIDxocmVpdHpAcmVkaGF0LmNvbT4NCj4+IC0tLQ0KPj4gICBpbmNsdWRlL3Fl
bXUvb3NkZXAuaCB8ICAxICsNCj4+ICAgYmxvY2svZmlsZS1wb3NpeC5jICAgfCAxNyArLS0t
LS0tLS0tLS0tLS0tLQ0KPj4gICB1dGlsL29zZGVwLmMgICAgICAgICB8IDE4ICsrKysrKysr
KysrKysrKysrKw0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDE2
IGRlbGV0aW9ucygtKQ0KPiBJIHdhcyBjdXJpb3VzIGlmIHB1dHRpbmcgUE9TSVggZmNudGwo
MikgaW4gb3NkZXAuYyB3b3VsZCB3b3JrIG9uDQo+IFdpbmRvd3MuIEl0IGRvZXMgbm90Og0K
Pg0KPiB4ODZfNjQtdzY0LW1pbmd3MzItZ2NjIC1tNjQgLUlsaWJxZW11dXRpbC5hLnAgLUku
IC1JLi4gLUlxYXBpIC1JdHJhY2UgLUl1aSAtSXVpL3NoYWRlciAtSS91c3IveDg2XzY0LXc2
NC1taW5ndzMyL3N5cy1yb290L21pbmd3L2luY2x1ZGUvZ2xpYi0yLjAgLUkvdXNyL3g4Nl82
NC13NjQtbWluZ3czMi9zeXMtcm9vdC9taW5ndy9saWIvZ2xpYi0yLjAvaW5jbHVkZSAtZmRp
YWdub3N0aWNzLWNvbG9yPWF1dG8gLVdhbGwgLVdpbnZhbGlkLXBjaCAtV2Vycm9yIC1zdGQ9
Z251MTEgLU8yIC1nIC1mc3RhY2stcHJvdGVjdG9yLXN0cm9uZyAtV2VtcHR5LWJvZHkgLVdl
bmRpZi1sYWJlbHMgLVdleHBhbnNpb24tdG8tZGVmaW5lZCAtV2Zvcm1hdC1zZWN1cml0eSAt
V2Zvcm1hdC15MmsgLVdpZ25vcmVkLXF1YWxpZmllcnMgLVdpbXBsaWNpdC1mYWxsdGhyb3Vn
aD0yIC1XaW5pdC1zZWxmIC1XbWlzc2luZy1mb3JtYXQtYXR0cmlidXRlIC1XbWlzc2luZy1w
cm90b3R5cGVzIC1XbmVzdGVkLWV4dGVybnMgLVdvbGQtc3R5bGUtZGVjbGFyYXRpb24gLVdv
bGQtc3R5bGUtZGVmaW5pdGlvbiAtV3JlZHVuZGFudC1kZWNscyAtV3NoYWRvdz1sb2NhbCAt
V3N0cmljdC1wcm90b3R5cGVzIC1XdHlwZS1saW1pdHMgLVd1bmRlZiAtV3ZsYSAtV3dyaXRl
LXN0cmluZ3MgLVduby1taXNzaW5nLWluY2x1ZGUtZGlycyAtV25vLXBzYWJpIC1Xbm8tc2hp
ZnQtbmVnYXRpdmUtdmFsdWUgLWlxdW90ZSAuIC1pcXVvdGUgL2hvbWUvc3RlZmFuaGEvcWVt
dSAtaXF1b3RlIC9ob21lL3N0ZWZhbmhhL3FlbXUvaW5jbHVkZSAtaXF1b3RlIC9ob21lL3N0
ZWZhbmhhL3FlbXUvaG9zdC9pbmNsdWRlL3g4Nl82NCAtaXF1b3RlIC9ob21lL3N0ZWZhbmhh
L3FlbXUvaG9zdC9pbmNsdWRlL2dlbmVyaWMgLWlxdW90ZSAvaG9tZS9zdGVmYW5oYS9xZW11
L3RjZy9pMzg2IC1tbXMtYml0ZmllbGRzIC1tbXMtYml0ZmllbGRzIC1tY3gxNiAtbXNzZTIg
LURfR05VX1NPVVJDRSAtRF9GSUxFX09GRlNFVF9CSVRTPTY0IC1EX0xBUkdFRklMRV9TT1VS
Q0UgLWZuby1zdHJpY3QtYWxpYXNpbmcgLWZuby1jb21tb24gLWZ3cmFwdiAtZm5vLXBpZSAt
bm8tcGllIC1mdHJpdmlhbC1hdXRvLXZhci1pbml0PXplcm8gLWZ6ZXJvLWNhbGwtdXNlZC1y
ZWdzPXVzZWQtZ3ByIC1tbXMtYml0ZmllbGRzIC1tbXMtYml0ZmllbGRzIC1wdGhyZWFkIC1t
bXMtYml0ZmllbGRzIC1NRCAtTVEgbGlicWVtdXV0aWwuYS5wL3V0aWxfb3NkZXAuYy5vYmog
LU1GIGxpYnFlbXV1dGlsLmEucC91dGlsX29zZGVwLmMub2JqLmQgLW8gbGlicWVtdXV0aWwu
YS5wL3V0aWxfb3NkZXAuYy5vYmogLWMgLi4vdXRpbC9vc2RlcC5jDQo+IC4uL3V0aWwvb3Nk
ZXAuYzogSW4gZnVuY3Rpb24gJ3FlbXVfZmNudGxfYWRkZmwnOg0KPiAuLi91dGlsL29zZGVw
LmM6NjI1OjEzOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2Zj
bnRsJyBbLVdpbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gICAgNjI1IHwgICAg
IGZsYWdzID0gZmNudGwoZmQsIEZfR0VURkwpOw0KPiAgICAgICAgfCAgICAgICAgICAgICBe
fn5+fg0KPiAuLi91dGlsL29zZGVwLmM6NjI1OjEzOiBlcnJvcjogbmVzdGVkIGV4dGVybiBk
ZWNsYXJhdGlvbiBvZiAnZmNudGwnIFstV2Vycm9yPW5lc3RlZC1leHRlcm5zXQ0KPiAuLi91
dGlsL29zZGVwLmM6NjI1OjIzOiBlcnJvcjogJ0ZfR0VURkwnIHVuZGVjbGFyZWQgKGZpcnN0
IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQ0KPiAgICA2MjUgfCAgICAgZmxhZ3MgPSBmY250bChm
ZCwgRl9HRVRGTCk7DQo+ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+
DQo+IC4uL3V0aWwvb3NkZXAuYzo2MjU6MjM6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVu
dGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBl
YXJzIGluDQo+IC4uL3V0aWwvb3NkZXAuYzo2Mjk6MTk6IGVycm9yOiAnRl9TRVRGTCcgdW5k
ZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pDQo+ICAgIDYyOSB8ICAgICBp
ZiAoZmNudGwoZmQsIEZfU0VURkwsIGZsYWdzIHwgZmxhZykgPT0gLTEpIHsNCj4gICAgICAg
IHwgICAgICAgICAgICAgICAgICAgXn5+fn5+fg0KPiBjYzE6IGFsbCB3YXJuaW5ncyBiZWlu
ZyB0cmVhdGVkIGFzIGVycm9ycw0KDQpBaCwgdGhhbmtzIQ0KDQpJ4oCZbGwgbW92ZSBpdCB1
cCBpbnRvIHRoZSAjaWZuZGVmIF9XSU4zMiBibG9jayBhcm91bmQgcWVtdV9kdXBfZmxhZ3Mo
KSANCmFuZCBmcmllbmRzLg0KDQpIYW5uYQ0K


