Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DECE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 21:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeoN-0003KC-Rj; Tue, 17 Dec 2024 16:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeoL-0003Jf-E3
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 16:08:57 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeoG-0000aw-3f
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 16:08:57 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so16556465ad.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 13:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734469730; x=1735074530; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A+kUvMjEPMpVN762zYtstsEFtWx41aCZXeS9Avpt6JU=;
 b=DjciydxdSlDjvDJCJz6gaCrcC5AuRNiAkplJTWyk/iUZvwXdHwIQ4BfC6VE8rnSnAU
 9xq/c/PCoavPOTdmTJi0wesJWUeg1PZbpJJfO4+XnYK2F8jeIXQRFIY0J0V/MvzQqajh
 u99nPDYSRBvfC7oToHopyyb53d6nhvJmAChZK9hGJgSWQkdnPJpIYNdp0XfqCG6klHFL
 s/TKLpaBcuFhZi1MIAPQeSlRG+g7gFQw4WRN77JN7IAzytDJYQydEN+b4z0+c8LhgMjh
 Iwo7cOYehlXaJGt6sdICTnc0+Xd9WUv1jJPcML5GBGfOBTj38xvkjvKpDQHQqvYOt4VN
 QtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734469730; x=1735074530;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A+kUvMjEPMpVN762zYtstsEFtWx41aCZXeS9Avpt6JU=;
 b=k95inLPszTs48cqb+TqlOEdC5GXHcdauGJy4gyXNpkHchFyeYfMGKMoTS0H42PT1IH
 ACYKe19MPqBsfL478qnSWV+vYmYnTWQJ68Cj79A2ddrcgkY7UNyLhh5Wd3m2x0vWykmo
 BaXr9f1kqVcVGmtgdw0UEqG1iCatcbNQQt9A7K7WjYjJ0xA9GWFuft5ba/1Ow4x4PSAx
 W1wQOyugeQHu74xHFgUYydrVXzkLEWy9nF8RsOrA5Mr9kJGMyBLzS5PtC89Yibweoc3O
 5QuVcXC/+B2iB0g3HqDErGkd3yt3zQ87zHDTWeME6Sxq0qcDqOXBvTQSeYlpPu4kxmMH
 62uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZKqQD2t2DmEx+ZtMtGx3NaIfwW0PqLbMWrA2DiXSXDpoVP6jHvUfTbsn/zj4T7oxa8XJCTN+q1260@nongnu.org
X-Gm-Message-State: AOJu0Yzy34u1gimwChHr7k94Wm8TSfQF9cK1TzAV7lFPa5/mqQhz78wZ
 G83jVRh1dK7aie3PSCh1PXXAuH2yUynKTrjZQ50iDDDeqrHUhrjBCEOsap2T5SY=
X-Gm-Gg: ASbGncsg6ggZhH7gz5y9C53rb1sMB5OxyO8hI9ilvpwHLP2S/k6NaH7ZWrQW++lZ/Gg
 SDMTLt3j2AFvE3DYFs1W20RohUxq7VMaph17OVgfoz6YyxcLUu6XDtkHTDwonl2fWggK3EAPQtl
 cF+sSJCEDW2PTsUZjux5/vx2ulR9JBiKLVcMQI6DsX/NEch70ykHIOrbmXSCWcqXvFWLXUcpory
 XDyEbI/kTZODtTSny0ojcS5pl9ieI/c0ZD3PJUawUR1HaP2pugQb5pEFKdV5avXQfE/Pg==
X-Google-Smtp-Source: AGHT+IGzTc8c8eSwyXIy6XiydPjK26PU/zgDm4aadlOPIjw9470Wl4qLwZSu9O30GkpUABnd4fi2OQ==
X-Received: by 2002:a17:903:1103:b0:215:b45a:6a5e with SMTP id
 d9443c01a7336-218d70dc24dmr3727815ad.18.1734469729822; 
 Tue, 17 Dec 2024 13:08:49 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1d000d9sm63753785ad.0.2024.12.17.13.08.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 13:08:49 -0800 (PST)
Message-ID: <75ff92e0-7384-4af4-bc9f-64a6b0febc9f@linaro.org>
Date: Tue, 17 Dec 2024 13:08:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Change default pointer authentication algorithm on
 aarch64 to impdef
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org
References: <20241204211234.3077434-1-pierrick.bouvier@linaro.org>
 <7cd98960-0c0d-481f-96ea-08e0578d5cad@linaro.org>
 <b0962854-65c3-47d0-8f0a-072fdf51e7b6@linaro.org>
 <6e29d9cb-1c67-4fdc-97f1-32c90bed1048@linaro.org>
 <19df9957-6653-4086-aa1f-07263efcddde@linaro.org>
 <87pllq69l6.fsf@draig.linaro.org>
 <CAFEAcA_xe5QEPsrByM8ems_rxt-KsVRAgkKhGk24X-1J0vcCDA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA_xe5QEPsrByM8ems_rxt-KsVRAgkKhGk24X-1J0vcCDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

T24gMTIvMTcvMjQgMDI6MzgsIFBldGVyIE1heWRlbGwgd3JvdGU6DQo+IE9uIFR1ZSwgMTcg
RGVjIDIwMjQgYXQgMDc6NDAsIEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9y
Zz4gd3JvdGU6DQo+Pg0KPj4gUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBs
aW5hcm8ub3JnPiB3cml0ZXM6DQo+Pg0KPj4+IE9uIDEyLzE2LzI0IDExOjUwLCBSaWNoYXJk
IEhlbmRlcnNvbiB3cm90ZToNCj4+Pj4gT24gMTIvMTYvMjQgMTM6MjYsIFBpZXJyaWNrIEJv
dXZpZXIgd3JvdGU6DQo+Pj4+PiBPbiAxMi8xNi8yNCAxMToxMCwgUmljaGFyZCBIZW5kZXJz
b24gd3JvdGU6DQo+Pj4+Pj4gT24gMTIvNC8yNCAxNToxMiwgUGllcnJpY2sgQm91dmllciB3
cm90ZToNCj4+Pj4+Pj4gcWVtdS1zeXN0ZW0tYWFyY2g2NCBkZWZhdWx0IHBvaW50ZXIgYXV0
aGVudGljYXRpb24gKFFBUk1BNSkgaXMgZXhwZW5zaXZlLCB3ZQ0KPj4+Pj4+PiBzcGVudCB1
cCB0byA1MCUgb2YgdGhlIGVtdWxhdGlvbiB0aW1lIHJ1bm5pbmcgaXQgKHdoZW4gdXNpbmcg
VENHKS4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gU3dpdGNoaW5nIHRvIHBhdXRoLWltcGRlZj1vbiBp
cyBvZnRlbiBnaXZlbiBhcyBhIHNvbHV0aW9uIHRvIHNwZWVkIHVwIGV4ZWN1dGlvbi4NCj4+
Pj4+Pj4gVGh1cyB3ZSB0YWxrZWQgYWJvdXQgbWFraW5nIGl0IHRoZSBuZXcgZGVmYXVsdC4N
Cj4+Pj4+Pj4NCj4+Pj4+Pj4gVGhlIGZpcnN0IHBhdGNoIGludHJvZHVjZSBhIG5ldyBwcm9w
ZXJ0eSAocGF1dGgtcWFybWE1KSB0byBhbGxvdyB0byBzZWxlY3QNCj4+Pj4+Pj4gY3VycmVu
dCBkZWZhdWx0IGFsZ29yaXRobS4NCj4+Pj4+Pj4gVGhlIHNlY29uZCBvbmUgY2hhbmdlIHRo
ZSBkZWZhdWx0Lg0KPj4+Pj4+Pg0KPj4+Pj4+PiBQaWVycmljayBCb3V2aWVyICgyKToNCj4+
Pj4+Pj4gICAgICAgdGFyZ2V0L2FybTogYWRkIG5ldyBwcm9wZXJ0eSB0byBzZWxlY3QgcGF1
dGgtcWFybWE1DQo+Pj4+Pj4+ICAgICAgIHRhcmdldC9hcm06IGNoYW5nZSBkZWZhdWx0IHBh
dXRoIGFsZ29yaXRobSB0byBpbXBkZWYNCj4+Pj4+Pj4NCj4+Pj4+Pj4gICAgICBkb2NzL3N5
c3RlbS9hcm0vY3B1LWZlYXR1cmVzLnJzdCB8ICA3ICsrKysrLS0NCj4+Pj4+Pj4gICAgICBk
b2NzL3N5c3RlbS9pbnRyb2R1Y3Rpb24ucnN0ICAgICB8ICAyICstDQo+Pj4+Pj4+ICAgICAg
dGFyZ2V0L2FybS9jcHUuaCAgICAgICAgICAgICAgICAgfCAgMSArDQo+Pj4+Pj4+ICAgICAg
dGFyZ2V0L2FybS9hcm0tcW1wLWNtZHMuYyAgICAgICAgfCAgMiArLQ0KPj4+Pj4+PiAgICAg
IHRhcmdldC9hcm0vY3B1NjQuYyAgICAgICAgICAgICAgIHwgMzAgKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tDQo+Pj4+Pj4+ICAgICAgdGVzdHMvcXRlc3QvYXJtLWNwdS1mZWF0
dXJlcy5jICAgfCAxNSArKysrKysrKysrKy0tLS0NCj4+Pj4+Pj4gICAgICA2IGZpbGVzIGNo
YW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPj4+Pj4+Pg0KPj4+
Pj4+DQo+Pj4+Pj4gSSB1bmRlcnN0YW5kIHRoZSBtb3RpdmF0aW9uLCBidXQgYXMtaXMgdGhp
cyB3aWxsIGJyZWFrIG1pZ3JhdGlvbi4NCj4+Pj4+Pg0KPj4+Pj4+IEkgdGhpbmsgdGhpcyB3
aWxsIG5lZWQgdG8gYmUgdmVyc2lvbmVkIHNvbWVob3csIGJ1dCB0aGUgb25seSB0aGluZyB0
aGF0IHJlYWxseSBnZXRzDQo+Pj4+Pj4gdmVyc2lvbmVkIGFyZSB0aGUgYm9hcmRzLCBhbmQg
SSdtIG5vdCBzdXJlIGhvdyB0byBsaW5rIHRoYXQgdG8gdGhlIGluc3RhbnRpYXRlZCBjcHUu
DQo+Pj4+Pj4NCj4+Pj4+DQo+Pj4+PiAgICBGcm9tIHdoYXQgSSB1bmRlcnN0b29kLCBhbmQg
SSBtYXkgYmUgd3JvbmcsIHRoZSB1c2UgY2FzZSB0byBtaWdyYXRlICh0Y2cpIHZtIHdpdGgg
Y3B1IG1heA0KPj4+Pj4gYmV0d2VlbiBRRU1VIHZlcnNpb25zIGlzICpub3QqIHN1cHBvcnRl
ZCwgYXMgd2UgY2FuJ3QgZ3VhcmFudGVlIHdoaWNoIGZlYXR1cmVzIGFyZSBwcmVzZW50DQo+
Pj4+PiBvciBub3QuDQo+Pj4+IFRoaXMgZG9lc24ndCBhZmZlY3Qgb25seSAtY3B1IG1heCwg
YnV0IGFueXRoaW5nIHVzaW5nIGFhcmNoNjRfYWRkX3BhdXRoX3Byb3BlcnRpZXMoKToNCj4+
Pj4gbmVvdmVyc2UtbjEsIG5lb3ZlcnNlLW4yLCBjb3J0ZXgtYTcxMC4NCj4+Pj4NCj4+Pg0K
Pj4+IEkgdGhpbmsgdGhpcyBpcyBzdGlsbCBhIGNoYW5nZSB3b3J0aCB0byBkbywgYmVjYXVz
ZSBwZW9wbGUgY2FuIGdldCBhDQo+Pj4gMTAwJSBzcGVlZHVwIHdpdGggdGhpcyBzaW1wbGUg
Y2hhbmdlLCBhbmQgaXQncyBhIGJldHRlciBkZWZhdWx0IHRoYW4NCj4+PiB0aGUgcHJldmlv
dXMgdmFsdWUuDQo+Pj4gSW4gbW9yZSwgaW4gY2FzZSBvZiB0aGlzIG1pZ3JhdGlvbiBzY2Vu
YXJpbywgUUVNVSB3aWxsIGltbWVkaWF0ZWx5DQo+Pj4gYWJvcnQgdXBvbiBhY2Nlc3Npbmcg
bWVtb3J5IHRocm91Z2ggYSBwb2ludGVyLg0KPj4+DQo+Pj4gSSdtIG5vdCBzdXJlIGFib3V0
IHdoYXQgd291bGQgYmUgdGhlIGJlc3Qgd2F5IHRvIG1ha2UgdGhpcyBjaGFuZ2UgYXMNCj4+
PiBzbW9vdGggYXMgcG9zc2libGUgZm9yIFFFTVUgdXNlcnMuDQo+Pg0KPj4gU3VyZWx5IHdl
IGNhbiBvbmx5IGhvbm91ciBhbmQgYXBwbHkgdGhlIG5ldyBkZWZhdWx0IHRvIC1jcHUgbWF4
Pw0KPiANCg0KV2l0aCBhbGwgbXkgcmVzcGVjdCwgSSB0aGluayB0aGUgY3VycmVudCBkZWZh
dWx0IGlzIHdyb25nLCBhbmQgaXQgd291bGQgDQpiZSBzYWQgdG8ga2VlcCBpdCB3aGVuIHBl
b3BsZSBkb24ndCBwcmVjaXNlIGNwdSBtYXgsIG9yIGZvciBvdGhlciBjcHVzIA0KZW5hYmxp
bmcgcG9pbnRlciBhdXRoZW50aWNhdGlvbi4NCg0KSW4gYWxsIG91ciBjb252ZXJzYXRpb25z
LCB0aGVyZSBzZWVtcyB0byBiZSBhIGZvY3VzIG9uIGNob29zaW5nIHRoZSANCiJmYXN0ZXN0
IiBlbXVsYXRpb24gc29sdXRpb24gdGhhdCBzYXRpc2ZpZXMgdGhlIGd1ZXN0IChiZWhhdmlv
dXIgd2lzZSkuIA0KQW5kLCBmb3IgYSByZWFzb24gSSBpZ25vcmUsIHBvaW50ZXIgYXV0aGVu
dGljYXRpb24gZXNjYXBlZCB0aGlzIHJ1bGUuDQoNCkkgdW5kZXJzdGFuZCB0aGUgY29uY2Vy
biByZWdhcmRpbmcgcmV0cm8gY29tcGF0aWJpbGl0eSwgYnV0IGl0IHdvdWxkIGJlIA0KYmV0
dGVyIHRvIGFzayBwb2xpdGVseSAod2l0aCBhbiBlcnJvciBtZXNzYWdlKSB0byBwZW9wbGUg
dG8gcmVzdGFydCANCnRoZWlyIHZpcnR1YWwgbWFjaGluZXMgd2hlbiB0aGV5IHRyeSB0byBt
aWdyYXRlLCBpbnN0ZWFkIG9mIGJlaW5nIHN0dWNrIA0Kd2l0aCBhIHNsb3cgZGVmYXVsdCBm
b3JldmVyLg0KSW4gbW9yZSwgd2UgYXJlIHRhbGtpbmcgb2YgYSB0Y2cgc2NlbmFyaW8sIGZv
ciB3aGljaCBJJ20gbm90IHN1cmUgcGVvcGxlIA0KdXNlIG1pZ3JhdGlvbiBmZWF0dXJlIChz
YXZlL3Jlc3RvcmUpIGhlYXZpbHksIGJ1dCBJIG1heSBiZSB3cm9uZyBvbiB0aGlzLg0KDQpC
ZXR3ZWVuIHRoZSByaXNrIG9mIGJyZWFraW5nIG1pZ3JhdGlvbiAod2l0aCBhIHBvbGl0ZSBl
cnJvciBtZXNzYWdlKSwgDQphbmQgaGF2aW5nIGEgZGVmYXVsdCB0aGF0IGlzIDEwMCUgZmFz
dGVyLCBJIHRoaW5rIGl0IHdvdWxkIGJlIGJldHRlciB0byANCmZhdm9yIHRoZSBzZWNvbmQg
b25lLiBJZiBpdCB3b3VsZCBiZSBhIDUlIHNwZWVkdXAsIEkgd291bGQgbm90IGFyZ3VlLCAN
CmJ1dCBzbG93aW5nIGRvd24gZXhlY3V0aW9uIHdpdGggYSBmYWN0b3Igb2YgMiBpcyByZWFs
bHkgYSBsb3QuDQoNCj4gVGhhdCB3YXMgd2hhdCBJIHRob3VnaHQgd2Ugd2VyZSBhaW1pbmcg
Zm9yLCB5ZXMuIFdlICpjb3VsZCogaGF2ZQ0KPiBhIHByb3BlcnR5IG9uIHRoZSBDUFUgdG8g
c2F5ICJ1c2UgdGhlIG9sZCBiYWNrLWNvbXBhdGlibGUgZGVmYXVsdCwNCj4gbm90IHRoZSBu
ZXcgb25lIiwgd2hpY2ggd2UgdGhlbiBsaXN0IGluIHRoZSBhcHByb3ByaWF0ZSBod19jb21w
YXQNCj4gYXJyYXkuIChHcmVwIGZvciB0aGUgImJhY2tjb21wYXQtY250ZnJxIiBwcm9wZXJ0
eSBmb3IgYW4gZXhhbXBsZSBvZg0KPiB0aGlzLikgQnV0IEknbSBub3Qgc3VyZSBpZiB0aGF0
IGlzIHdvcnRoIHRoZSBlZmZvcnQgY29tcGFyZWQgdG8NCj4ganVzdCBjaGFuZ2luZyAnbWF4
Jy4NCg0KV2hlbiB3ZSdsbCBkZWZpbmUgaHdfY29tcGF0XzEwXzAsIGFuZCBod19jb21wYXRf
MTFfMCwgZG8gd2UgaGF2ZSB0byANCmNhcnJ5IHRoaXMgb24gZm9yZXZlcj8gKFNhbWUgcXVl
c3Rpb24gZm9yICJiYWNrY29tcGF0LWNudGZycSIpLg0KDQo+IA0KPiAoSXQncyBub3QgdGhh
dCBtdWNoIGV4dHJhIGNvZGUgdG8gYWRkIHRoZSBwcm9wZXJ0eSwgc28gSSBjb3VsZA0KPiBl
YXNpbHkgYmUgcGVyc3VhZGVkIHRoZSBvdGhlciB3YXkuIFBvc3NpYmxlIGFyZ3VtZW50cyBp
bmNsdWRlDQo+IHByZWZlcnJpbmcgY29uc2lzdGVuY3kgYWNyb3NzIGFsbCBDUFVzLiBJZiB3
ZSBhbHJlYWR5IG1ha2UgdGhlDQo+IGRlZmF1bHQgYmUgbm90ICJ3aGF0IHRoZSByZWFsIENQ
VSBvZiB0aGlzIHR5cGUgdXNlcyIgdGhlbiB0aGF0J3MNCj4gYWxzbyBhbiBhcmd1bWVudCB0
aGF0IHdlIGNhbiBzZXQgaXQgdG8gd2hhdGV2ZXIgaXMgY29udmVuaWVudDsNCj4gaWYgd2Ug
ZG8gaG9ub3VyIHRoZSBDUFUgSUQgcmVnaXN0ZXIgdmFsdWVzIGZvciB0aGUgaW1wbGVtZW50
YXRpb24NCj4gZGVmYXVsdCB0aGVuIHRoYXQncyBhbiBhcmd1bWVudCB0aGF0IHdlIHNob3Vs
ZCBjb250aW51ZSB0byBkbw0KPiBzbyBhbmQgbm90IGNoYW5nZSB0aGUgZGVmYXVsdCB0byBv
dXIgaW1wZGVmIG9uZS4pDQo+DQoNCkZvciB0aGUgVENHIHVzZSBjYXNlLCBpcyB0aGVyZSBh
bnkgdmlzaWJsZSBzaWRlIGVmZmVjdCBmb3IgdGhlIGd1ZXN0IHRvIA0KdXNlIGFueSBzcGVj
aWZpYyBwb2ludGVyIGF1dGhlbnRpY2F0aW9uIGFsZ29yaXRobT8NCkluIG90aGVyIHdvcmRz
LCBpcyB0aGVyZSBhIHNjZW5hcmlvIHdoZXJlIHBvaW50ZXIgYXV0aGVudGljYXRpb24gd291
bGQgDQp3b3JrIHdpdGggaW1wZGVmLCBidXQgbm90IHdpdGggcWFybWF7Myw1fT8NCklmIG5v
LCBJIGRvbid0IHNlZSBhbnkgcmVhc29uIGZvciBhIGNwdSB0byBmYXZvciBhbiBleHBlbnNp
dmUgZW11bGF0aW9uLg0KDQpJbiB0aGUgYWNjZWxlcmF0b3IgY2FzZSwgd2UgcmVhZCB0aGUg
dmFsdWVzIGZyb20gdGhlIGhvc3QgY3B1LCBzbyB0aGVyZSANCmlzIG5vIHByb2JsZW0uDQoN
Cj4gLS0gUE1NDQoNCg==

