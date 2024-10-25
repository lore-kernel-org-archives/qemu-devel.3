Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D3DD149E8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 19:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4QHp-0006BI-2X; Fri, 25 Oct 2024 15:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4QHi-0006Ak-Em
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 15:47:49 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4QHg-0006zS-8N
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 15:47:45 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e2eb9dde40so1856241a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 12:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729885662; x=1730490462; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=epFyQamFzejAdgg0Piu0hjrKmK+lVrEOp6fGU8JK8jU=;
 b=M/l+vUuWTATTGqxQ/+BwaEfz6aEBD8ZXhHXhHpofNwhDZx/OdswZvAr0xq6mpI2/sl
 Cu0WHwpmzbzNcejsWK8MlEnsQZX0r191t92ePeeKz2fSmqMcLF9RdbqL1ODzCfr8qQ5R
 31r+N7QDtb3HUB2BdrqroDyBGgetzs15Wd0T9bpw4FEtKOw6uhEvS+SttldRL0nknCN7
 FdI8nrnCqu7Le1D9Mek+26ezMWc1+Mum3vnackujrBr2n65ZjbO3rN0uiOijTgSb6jSw
 NtLQiuk00tOSOboBGXjMcgsjcpYiiySkKLoTMkIxj9SL6vqh8/y1apP06DrBXr3moq12
 rveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729885662; x=1730490462;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=epFyQamFzejAdgg0Piu0hjrKmK+lVrEOp6fGU8JK8jU=;
 b=bMekt0OHNMvPMBNlqPH5kluXL5EPzMjNVK5UeunknKjR8ctOTmizGG9Mks5P9pfVLY
 oSqiBVE9oknWgE0OmCG9j8hwqxfrwEqKEoiVs0XMURaHFCfXQtWtgxVy/Bwum/TcpzIB
 OOGF+XWWGSdMwaUd6tg/wA7bJV3pshzyjYfSEf6KZIVhfQ3m6ZABEW6qUKiowftHXwO6
 648b26NCRl8K3/NN/74fJY83f6sFiSNEPBmPDPUnzlYrb/VfDfpVW0X07jOM9aTA6V3H
 7y4MtChbqDYabxsCg56roHnrwjYwBEv49XvSeTHYFfV6J5XwmuvTHjypQiMVTmA9GvK4
 q63A==
X-Gm-Message-State: AOJu0YxWbEQvLir4ZzwohXuu0Pa4EKc98Kv4PkofdIwRN61tyIWECO6S
 Lf7Hl0X0BhcLHDW0yy+QPU3KNR3eiR9DGQMlNgX7EH+cp9S+gCKdmpbX8Ts9saE=
X-Google-Smtp-Source: AGHT+IEf2a9HY29CA2oJ0r8T8sc51JxLAI6FfCpGFtqaphkouKZnYtKwcsn9UmyshsoQfX/joEY1Lw==
X-Received: by 2002:a17:90a:f491:b0:2e2:b6ef:1611 with SMTP id
 98e67ed59e1d1-2e8f107b9e4mr612450a91.18.1729885662172; 
 Fri, 25 Oct 2024 12:47:42 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e77e55e030sm3915347a91.37.2024.10.25.12.47.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 12:47:41 -0700 (PDT)
Message-ID: <91bedb1f-8c66-4dac-ae1f-bbf0769293b6@linaro.org>
Date: Fri, 25 Oct 2024 12:47:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/23] dockerfiles: install bindgen from cargo on Ubuntu
 22.04
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Junjie Mao <junjie.mao@hotmail.com>,
 "P. Berrange, Daniel" <berrange@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-23-pbonzini@redhat.com>
 <580f10bc-4d37-4ece-b9d8-496ba66b7966@linaro.org>
 <CABgObfbhJLeAon9rfpSpFG4cwDvCEMnK+1tkmOR5-+mkSdGOUQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CABgObfbhJLeAon9rfpSpFG4cwDvCEMnK+1tkmOR5-+mkSdGOUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gMTAvMjUvMjQgMTI6MzUsIFBhb2xvIEJvbnppbmkgd3JvdGU6DQo+IA0KPiANCj4gSWwg
dmVuIDI1IG90dCAyMDI0LCAyMDo1MSBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQGxpbmFyby5vcmcgDQo+IDxtYWlsdG86cGllcnJpY2suYm91dmllckBsaW5hcm8ub3Jn
Pj4gaGEgc2NyaXR0bzoNCj4gDQo+ICAgICBIaSBQYW9sbywNCj4gDQo+ICAgICBPbiAxMC8y
NS8yNCAwOTowMiwgUGFvbG8gQm9uemluaSB3cm90ZToNCj4gICAgICA+IEJlY2F1c2UgVWJ1
bnR1IDIyLjA0IGhhcyBhIHZlcnkgb2xkIHZlcnNpb24gb2YgYmluZGdlbiwgdGhhdA0KPiAg
ICAgID4gZG9lcyBub3QgaGF2ZSB0aGUgaW1wb3J0YW50IG9wdGlvbiAtLWFsbG93bGlzdC1m
aWxlLCBpdCB3aWxsDQo+ICAgICAgPiBub3QgYmUgYWJsZSB0byB1c2UgLS1lbmFibGUtcnVz
dCBvdXQgb2YgdGhlIGJveC7CoCBJbnN0ZWFkLA0KPiAgICAgID4gaW5zdGFsbCB0aGUgbGF0
ZXN0IHZlcnNpb24gb2YgYmluZGdlbi1jbGkgdmlhICJjYXJnbyBpbnN0YWxsIg0KPiAgICAg
ID4gaW4gdGhlIGNvbnRhaW5lciwgZm9sbG93aW5nIFFFTVUncyBvd24gZG9jdW1lbnRhdGlv
bi4NCj4gICAgICA+DQo+ICAgICAgPiBTaWduZWQtb2ZmLWJ5OiBQYW9sbyBCb256aW5pIDxw
Ym9uemluaUByZWRoYXQuY29tDQo+ICAgICA8bWFpbHRvOnBib256aW5pQHJlZGhhdC5jb20+
Pg0KPiAgICAgID4gLS0tDQo+ICAgICAgPsKgIMKgdGVzdHMvZG9ja2VyL2RvY2tlcmZpbGVz
L3VidW50dTIyMDQuZG9ja2VyIHzCoCA1ICsrKysrDQo+ICAgICAgPsKgIMKgdGVzdHMvbGNp
dG9vbC9tYXBwaW5ncy55bWzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCA0ICsrKysN
Cj4gICAgICA+wqAgwqB0ZXN0cy9sY2l0b29sL3JlZnJlc2jCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB8IDExICsrKysrKysrKystDQo+ICAgICAgPsKgIMKgMyBmaWxlcyBj
aGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ICAgICAgPg0KPiAg
ICAgID4gZGlmZiAtLWdpdCBhL3Rlc3RzL2RvY2tlci9kb2NrZXJmaWxlcy91YnVudHUyMjA0
LmRvY2tlcg0KPiAgICAgYi90ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMvdWJ1bnR1MjIwNC5k
b2NrZXINCj4gICAgICA+IGluZGV4IGNlM2FhMzlkNGYzLi4yNDVhYzg3OTYyMiAxMDA2NDQN
Cj4gICAgICA+IC0tLSBhL3Rlc3RzL2RvY2tlci9kb2NrZXJmaWxlcy91YnVudHUyMjA0LmRv
Y2tlcg0KPiAgICAgID4gKysrIGIvdGVzdHMvZG9ja2VyL2RvY2tlcmZpbGVzL3VidW50dTIy
MDQuZG9ja2VyDQo+ICAgICAgPiBAQCAtMTQ5LDYgKzE0OSwxMSBAQCBFTlYgTEFORyAiZW5f
VVMuVVRGLTgiDQo+ICAgICAgPsKgIMKgRU5WIE1BS0UgIi91c3IvYmluL21ha2UiDQo+ICAg
ICAgPsKgIMKgRU5WIE5JTkpBICIvdXNyL2Jpbi9uaW5qYSINCj4gICAgICA+wqAgwqBFTlYg
UFlUSE9OICIvdXNyL2Jpbi9weXRob24zIg0KPiAgICAgID4gK0VOViBDQVJHT19IT01FPS91
c3IvbG9jYWwvY2FyZ28NCj4gICAgICA+ICtFTlYgUEFUSD0kQ0FSR09fSE9NRS9iaW46JFBB
VEgNCj4gICAgICA+ICtSVU4gREVCSUFOX0ZST05URU5EPW5vbmludGVyYWN0aXZlIGVhdG15
ZGF0YSBcDQo+ICAgICAgPiArwqAgYXB0IGluc3RhbGwgLXkgLS1uby1pbnN0YWxsLXJlY29t
bWVuZHMgY2FyZ28NCj4gICAgICA+ICtSVU4gY2FyZ28gaW5zdGFsbCBiaW5kZ2VuLWNsaQ0K
PiAgICAgID7CoCDCoCMgQXMgYSBmaW5hbCBzdGVwIGNvbmZpZ3VyZSB0aGUgdXNlciAoaWYg
ZW52IGlzIGRlZmluZWQpDQo+ICAgICAgPsKgIMKgQVJHIFVTRVINCj4gICAgICA+wqAgwqBB
UkcgVUlEDQo+ICAgICAgPiBkaWZmIC0tZ2l0IGEvdGVzdHMvbGNpdG9vbC9tYXBwaW5ncy55
bWwgYi90ZXN0cy9sY2l0b29sL21hcHBpbmdzLnltbA0KPiAgICAgID4gaW5kZXggOWM1YWM4
N2MxYzIuLmM5MGIyM2EwMGYxIDEwMDY0NA0KPiAgICAgID4gLS0tIGEvdGVzdHMvbGNpdG9v
bC9tYXBwaW5ncy55bWwNCj4gICAgICA+ICsrKyBiL3Rlc3RzL2xjaXRvb2wvbWFwcGluZ3Mu
eW1sDQo+ICAgICAgPiBAQCAtMSw0ICsxLDggQEANCj4gICAgICA+wqAgwqBtYXBwaW5nczoN
Cj4gICAgICA+ICvCoCAjIFRvbyBvbGQgb24gVWJ1bnR1IDIyLjA0OyB3ZSBpbnN0YWxsIGl0
IGZyb20gY2FyZ28gaW5zdGVhZA0KPiAgICAgID4gK8KgIGJpbmRnZW46DQo+ICAgICAgPiAr
wqAgwqAgVWJ1bnR1MjIwNDoNCj4gICAgICA+ICsNCj4gICAgICA+wqAgwqAgwqBmbGFrZTg6
DQo+ICAgICAgPsKgIMKgIMKgIMKgT3BlblNVU0VMZWFwMTU6DQo+ICAgICAgPg0KPiAgICAg
ID4gZGlmZiAtLWdpdCBhL3Rlc3RzL2xjaXRvb2wvcmVmcmVzaCBiL3Rlc3RzL2xjaXRvb2wv
cmVmcmVzaA0KPiAgICAgID4gaW5kZXggMGYxNmY0ZDUyNWMuLmE0NmNiYmRjYTQxIDEwMDc1
NQ0KPiAgICAgID4gLS0tIGEvdGVzdHMvbGNpdG9vbC9yZWZyZXNoDQo+ICAgICAgPiArKysg
Yi90ZXN0cy9sY2l0b29sL3JlZnJlc2gNCj4gICAgICA+IEBAIC0xMzcsNiArMTM3LDE0IEBA
IGZlZG9yYV9ydXN0dXBfbmlnaHRseV9leHRyYXMgPSBbDQo+ICAgICAgPsKgIMKgIMKgIMKg
J1JVTiAvdXNyL2xvY2FsL2NhcmdvL2Jpbi9ydXN0dXAgcnVuIG5pZ2h0bHkgY2FyZ28gaW5z
dGFsbA0KPiAgICAgYmluZGdlbi1jbGlcbicsDQo+ICAgICAgPsKgIMKgXQ0KPiAgICAgID4N
Cj4gICAgICA+ICt1YnVudHUyMjA0X2JpbmRnZW5fZXh0cmFzID0gWw0KPiAgICAgID4gK8Kg
IMKgICJFTlYgQ0FSR09fSE9NRT0vdXNyL2xvY2FsL2NhcmdvXG4iLA0KPiAgICAgID4gK8Kg
IMKgICdFTlYgUEFUSD0kQ0FSR09fSE9NRS9iaW46JFBBVEhcbicsDQo+ICAgICAgPiArwqAg
wqAgIlJVTiBERUJJQU5fRlJPTlRFTkQ9bm9uaW50ZXJhY3RpdmUgZWF0bXlkYXRhIFxcXG4i
LA0KPiAgICAgID4gK8KgIMKgICLCoCBhcHQgaW5zdGFsbCAteSAtLW5vLWluc3RhbGwtcmVj
b21tZW5kcyBjYXJnb1xuIiwNCj4gICAgICA+ICvCoCDCoCAnUlVOIGNhcmdvIGluc3RhbGwg
YmluZGdlbi1jbGlcbicsDQo+ICAgICAgPiArXQ0KPiAgICAgID4gKw0KPiAgICAgID7CoCDC
oGRlZiBjcm9zc19idWlsZChwcmVmaXgsIHRhcmdldHMpOg0KPiAgICAgID7CoCDCoCDCoCDC
oGNvbmYgPSAiRU5WIFFFTVVfQ09ORklHVVJFX09QVFMgLS1jcm9zcy1wcmVmaXg9JXNcbiIg
JSAocHJlZml4KQ0KPiAgICAgID7CoCDCoCDCoCDCoHRhcmdldHMgPSAiRU5WIERFRl9UQVJH
RVRfTElTVCAlc1xuIiAlICh0YXJnZXRzKQ0KPiAgICAgID4gQEAgLTE1Nyw3ICsxNjUsOCBA
QCB0cnk6DQo+ICAgICAgPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgdHJhaWxlcj0iIi5qb2luKGRlYmlhbjEyX2V4dHJhcykpDQo+ICAgICAgPsKgIMKgIMKg
IMKgZ2VuZXJhdGVfZG9ja2VyZmlsZSgiZmVkb3JhIiwgImZlZG9yYS00MCIpDQo+ICAgICAg
PsKgIMKgIMKgIMKgZ2VuZXJhdGVfZG9ja2VyZmlsZSgib3BlbnN1c2UtbGVhcCIsICJvcGVu
c3VzZS1sZWFwLTE1IikNCj4gICAgICA+IC3CoCDCoCBnZW5lcmF0ZV9kb2NrZXJmaWxlKCJ1
YnVudHUyMjA0IiwgInVidW50dS0yMjA0IikNCj4gICAgICA+ICvCoCDCoCBnZW5lcmF0ZV9k
b2NrZXJmaWxlKCJ1YnVudHUyMjA0IiwgInVidW50dS0yMjA0IiwNCj4gICAgICA+ICvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB0cmFpbGVyPSIiLmpvaW4odWJ1bnR1
MjIwNF9iaW5kZ2VuX2V4dHJhcykpDQo+ICAgICAgPg0KPiAgICAgID7CoCDCoCDCoCDCoCMN
Cj4gICAgICA+wqAgwqAgwqAgwqAjIE5vbi1mYXRhbCBSdXN0LWVuYWJsZWQgYnVpbGQNCj4g
DQo+ICAgICBTaG91bGQgd2UgaW5zdGFsbCB0aGUgc2FtZSB2ZXJzaW9uIGFzIHRoZSBtaW5p
bWFsIG9uZSB3ZSBleHBlY3QgKDAuNjAsDQo+ICAgICBpbiBkZWJpYW4gMTIpPyBBbGwgdGhl
IHJlc3Qgb2Ygc2VyaWVzIGlzIGZvY3VzZWQgb24gaGF2aW5nIGZpeGVkDQo+ICAgICBtaW5p
bWFsIHZlcnNpb24sIGFuZA0KPiANCj4gICAgIHRoaXMgcGF0Y2ggc2VlbXMgdG8gZXNjYXBl
IHRoaXMgcnVsZS4NCj4gDQo+IA0KPiBCdXQgaW4gdGhlIGVuZCB0aGUgb3BlcmF0aW9uIG9m
IGJpbmRnZW4gaXMgcXVpdGUgZGV0ZXJtaW5pc3RpYywgc28gaWYgDQo+IHRoZSBjb3ZlcmFn
ZSBpcyBpbXByb3ZlZCB3ZSBjYW4gaW5kZWVkIGluc3RhbGwgMC42MC54LiBGb3IgZXhhbXBs
ZSwgaWYgDQo+IHdlIHRoaW5rIHRoYXQgdXNlciBvbiBEZWJpYW4gMTIgbWlnaHQgdXNlIGRp
c3RybyBiaW5kZ2VuIHRvZ2V0aGVyIHdpdGggYSANCj4gcmVjZW50IHJ1c3RjIChpbiB0aGVp
ciBjYXNlLCBydXN0dXAtaW5zdGFsbGVkKSwgdGhlbiBpbnN0YWxsaW5nIGJpbmRnZW4gDQo+
IDAuNjAueCBvbiBVYnVudHUgd291bGQgcHJvdmlkZSBhIHNpbWlsYXIgZWZmZWN0Lg0KPiAN
Cg0KSSBtaXNzZWQgdGhhdCB0aGUgZGViaWFuIGpvYiBjb3ZlcnMgdGhpcyB1c2UgY2FzZS4g
U28gaW5kZWVkLCB3ZSBjYW4gdXNlIA0KYSByZWNlbnQgb25lIG9uIHVidW50dS4NCg0KV2hl
cmUgaXMgdGhlIGNoYW5nZSBmb3IgdGhlIGRlYmlhbiBjb250YWluZXI/DQoNCj4gT24gdGhl
IG90aGVyIGhhbmQgSSBleHBlY3QgdGhhdCB1c2VycyB3aWxsIGp1c3QgZG8gImNhcmdvIGlu
c3RhbGwgDQo+IGJpbmRnZW4tY2xpIiwgYW5kIFVidW50dSBpcyBhIHByZXR0eSBjb21tb24g
ZGlzdHJvLCBzbyB0aGF0J3Mgd2hhdCBJIA0KPiB3ZW50IGZvciBoZXJlLg0KPg0KDQpJdCdz
IGEgcmVhc29uYWJsZSBleHBlY3RhdGlvbiBpbmRlZWQuDQoNCj4gUGFvbG8NCj4gDQo+ICAg
ICBOb3RlOiB3ZSBjYW4gc3RpbGwgaW5zdGFsbCBpdCB1c2luZyBjYXJnbywgYnV0IGp1c3Qg
aGF2aW5nIGEgZml4ZWQNCj4gICAgIHZlcnNpb24gd291bGQgYmUgYmV0dGVyLg0KPiANCg==


