Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F39FD49780
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 18:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHoON-0005bA-MC; Sun, 01 Dec 2024 13:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tHoOL-0005ae-FI
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 13:09:57 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tHoOJ-0004Qc-Oc
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 13:09:57 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21271dc4084so25505525ad.2
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 10:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733076591; x=1733681391; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n9Vkf4VpTjxNdTnHmUl8ymEfzbkbXtr5XEawODDydQ4=;
 b=zNNYHtJQMGj6KuL0A8QCk4madTFowzTM3iC8ub0sWwRVCL10dRPbOUZC4lvk9zWFzc
 jiHDLvOM7+yMLu2zItlP+uoXXqgMF7sZ7e5BphSOxNuaKx6hXnK7GKo4cTTBvyV1NMq8
 VPI+cdhQ+yjX3Kz5Sd8YaxRwVesurn91sGZ+SE2aOEha7tPw5SE9SVMmbpmUORi8cfcI
 dH5cI4Nll76lHt/RFEsfmryi6A0vBRPfftM7q/E9Eu0g9qcTtRSCdwY7nsid66OtXDJi
 iIQ9KqAIGJcjGhf207q6wq0fOr383i6qE8sDA7LnDa1E/qeMHav9DbE0Kq/HUUqIB/HA
 1sEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733076591; x=1733681391;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n9Vkf4VpTjxNdTnHmUl8ymEfzbkbXtr5XEawODDydQ4=;
 b=AUxpCELtETcEepHFNS3aRSk1oyCSF/iVMLtko2mUSCDi/o96RIkz95s7WYIfnmDwxx
 P1Y37oOpTfxq0ApnoytmCF7IChkDkaPDMu4U8gXJSrLxQk7lLUrl9664d3sqQBJWAXF1
 n+Vz6ecoDDd+86SceXBWLtZg2yVWVSArloJo5hi7/fWV58iaOgirc0uI2yRGY0ih3419
 89EKvDbHz7TxSq90ERDCROfsf9xKgTQtL5WF1FzdQes3ZHiI/axoydGuDf4CVNFbvYUS
 NXNCvpFDokXcH3wKNNjRLeF/xohKd4ysYYh95FvL83HRsAK3enWjOzRQbOF3EWoK21Nh
 A9CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxjn2xf4powjERi5/HRREYRZgHKgRm8toLI+dOJ236qaqT4SGl1wVPH8QsEHBXd9zi+9KXmtcdBEdu@nongnu.org
X-Gm-Message-State: AOJu0YwHUgunOnz5YMD/G896nU8mwcdLBC6Gz1rnvHvkva9N5/7oKVjp
 WhuNKQ3IRXlO90d9wX1AroHxx2uooM1umcUP6YjrxwUPF4m0otoxmeBWMWV//x0=
X-Gm-Gg: ASbGncuUgQqJ6+2jiJcsIw2FbdMLyuK5HHfzjWbsFCLUZ9j9UxgSzGJjKlmsnGkR4q1
 t5wuTmKeTUKHZBnbCbBcVev4y1FVWdSbAQXW+ShGAXexHQF3FlEjiQZWd0lVkyLkZ+Dj5/lyy2l
 ufKR8yf6Zhj3M06ncb3mZbMJSZtxdAxVlaJy0nc2g0UjcSbZX7VUhmPouh+R63nf4rr9sk/weGl
 jb2zXtVTnHV7No4QMQnhT9iVc0fo1GIXyfCuc/3rC7AvT2S1FzfN9pVyGIqc1YOcWM0ene6E4/9
 5jBXqWiRbBMopv2DS8qEzg==
X-Google-Smtp-Source: AGHT+IFwMHlT7+qpfrlTZFCrtuyJIrNP01U7im6VCLuOYP209+ovTVwo+5uWDAseSrmGIvTk59sb+g==
X-Received: by 2002:a17:902:ec90:b0:215:603e:214a with SMTP id
 d9443c01a7336-215603e2398mr104659985ad.1.1733076591477; 
 Sun, 01 Dec 2024 10:09:51 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2154704346asm41225055ad.18.2024.12.01.10.09.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2024 10:09:51 -0800 (PST)
Message-ID: <5620efa2-98c6-4613-b866-67e91ac6acf8@linaro.org>
Date: Sun, 1 Dec 2024 10:09:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, alex.bennee@linaro.org,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
 <4b3180bd-8054-4431-a594-0445ce4837aa@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <4b3180bd-8054-4431-a594-0445ce4837aa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

SGkgTWFyY2luLA0KDQpPbiAxMi8xLzI0IDA1OjM0LCBNYXJjaW4gSnVzemtpZXdpY3ogd3Jv
dGU6DQo+IFcgZG5pdSAyOC4xMS4yMDI0IG/CoDIyOjM3LCBQaWVycmljayBCb3V2aWVyIHBp
c3plOg0KPj4gVGhpcyBib290IGFuIE9QLVRFRSBlbnZpcm9ubWVudCwgYW5kIGxhdW5jaCBh
IG5lc3RlZCBndWVzdCBWTSBpbnNpZGUgaXQNCj4+IHVzaW5nIHRoZSBSZWFsbXMgZmVhdHVy
ZS4gV2UgZG8gaXQgZm9yIHZpcnQgYW5kIHNic2EtcmVmIHBsYXRmb3Jtcy4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFy
by5vcmc+DQo+IA0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvbWVzb24uYnVp
bGQgYi90ZXN0cy9mdW5jdGlvbmFsL21lc29uLmJ1aWxkDQo+PiBpbmRleCA1YzA0OGNmYWM2
ZC4uYjk3NWExNTYwZGYgMTAwNjQ0DQo+PiAtLS0gYS90ZXN0cy9mdW5jdGlvbmFsL21lc29u
LmJ1aWxkDQo+PiArKysgYi90ZXN0cy9mdW5jdGlvbmFsL21lc29uLmJ1aWxkDQo+PiBAQCAt
MTMsNiArMTMsOCBAQCBlbmRpZg0KPj4gICAgdGVzdF90aW1lb3V0cyA9IHsNCj4+ICAgICAg
J2FhcmNoNjRfYXNwZWVkJyA6IDYwMCwNCj4+ICAgICAgJ2FhcmNoNjRfcmFzcGk0JyA6IDQ4
MCwNCj4gDQo+PiArICAnYWFyY2g2NF9ybWVfdmlydCcgOiA3MjAsDQo+IA0KPiBUb29rIDI5
NzQuOTVzIG9uIE0xIFBybyBtYWNib29rLg0KPiANCj4+ICsgICdhYXJjaDY0X3JtZV9zYnNh
cmVmJyA6IDcyMCwNCj4gDQo+IFRoaXMgb25lIG5lZWRlZCAyMjg4LjI5cy4NCj4gDQo+PiAg
ICAgICdhYXJjaDY0X3Nic2FyZWZfYWxwaW5lJyA6IDcyMCwNCj4gDQo+IEhhdmUgdG8gY2hl
Y2sgY2F1c2UgdGltZWQgb3V0Lg0KPiANCj4+ICAgICAgJ2FhcmNoNjRfc2JzYXJlZl9mcmVl
YnNkJyA6IDcyMCwNCj4gDQo+IDMzMS42NXMNCj4gDQo+IFNvIFJNRSB0ZXN0cyBwcm9iYWJs
eSBuZWVkIGxvbmdlciB0aW1lb3V0cyBvciB3b3VsZCBub3QgcnVuIGF0IGFsbC4NCj4gDQoN
CkJ5IGFueSBjaGFuY2UsIGFyZSB5b3UgcnVubmluZyB0aG9zZSB0ZXN0cyBpbiBkZWJ1ZyBt
b2RlPw0KSXQgc2VlbXMgdG8gbWUgdGhhdCBDSSBpcyBydW5uaW5nIGZ1bmN0aW9uYWwgdGVz
dHMgd2l0aCBvcHRpbWl6ZWQgDQpidWlsZHMsIHNvIEknbSBub3Qgc3VyZSB3ZSB3YW50IHRv
IHN1cHBvcnQgZGVidWcgInRpbWVzIiBoZXJlLg0KDQo+IA0KPj4gKysrIGIvdGVzdHMvZnVu
Y3Rpb25hbC90ZXN0X2FhcmNoNjRfcm1lX3Nic2FyZWYucHkNCj4gDQo+PiArICAgICAgICBz
ZWxmLnZtLmFkZF9hcmdzKCctYWNjZWwnLCAndGNnJykNCj4gDQo+IFRoYXQncyBkZWZhdWx0
IHZhbHVlIHNvIGNhbiBiZSBza2lwcGVkLg0KPiANCg0KT2suDQoNCj4+ICsgICAgICAgIHNl
bGYudm0uYWRkX2FyZ3MoJy1jcHUnLCAnbWF4LHgtcm1lPW9uJykNCj4gDQo+PiArICAgICAg
ICBzZWxmLnZtLmFkZF9hcmdzKCctbScsICcyRycpDQo+IA0KPiBJIHNlbnQgcGF0Y2ggdG8g
YnVtcCBkZWZhdWx0IG1lbXNpemUgdG8gMkcgcmVjZW50bHkuDQo+IA0KDQpJcyB0aGF0IG1l
cmdlZCBhbHJlYWR5LCBvciB3aWxsIGJlIGxhdGVyPw0KDQo+PiArICAgICAgICBzZWxmLnZt
LmFkZF9hcmdzKCctTScsICdzYnNhLXJlZicpDQo+PiArICAgICAgICBzZWxmLnZtLmFkZF9h
cmdzKCctZHJpdmUnLCBmJ2ZpbGU9e3BmbGFzaDB9LGZvcm1hdD1yYXcsaWY9cGZsYXNoJykN
Cj4+ICsgICAgICAgIHNlbGYudm0uYWRkX2FyZ3MoJy1kcml2ZScsIGYnZmlsZT17cGZsYXNo
MX0sZm9ybWF0PXJhdyxpZj1wZmxhc2gnKQ0KPj4gKyAgICAgICAgc2VsZi52bS5hZGRfYXJn
cygnLWRyaXZlJywgZidmaWxlPWZhdDpydzp7dmlydHVhbH0sZm9ybWF0PXJhdycpDQo+IA0K
Pj4gKyAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWRyaXZlJywgZidmb3JtYXQ9cmF3LGlm
PW5vbmUsZmlsZT17ZHJpdmV9LGlkPWhkMCcpDQo+PiArICAgICAgICBzZWxmLnZtLmFkZF9h
cmdzKCctZGV2aWNlJywgJ3ZpcnRpby1ibGstcGNpLGRyaXZlPWhkMCcpDQo+IA0KPiBzYnNh
LXJlZiBpcyBmdWxseSBlbXVsYXRlZCB0YXJnZXQuIFRoZXJlIGlzIEFIQ0kgY29udHJvbGxl
ciBidWlsdC1pbiBzbw0KPiBvbmx5ICItZHJpdmUiIGFyZ3VtZW50IHNob3VsZCBiZSBuZWVk
ZWQgKG5vICItZGV2aWNlIiBvbmUpLg0KPiANCg0KSSBmb2xsb3dlZCBvZmZpY2lhbCBpbnN0
cnVjdGlvbnMgZnJvbSBKZWFuIFBoaWxpcHBlIHRvIGJ1aWxkIFJNRSBzdGFjaywgDQphbmQg
SSB0aGluayBpdCdzIGJldHRlciB0byBrZWVwIHRoZW0gaW4gc3luYy4NCg0KPj4gKyAgICAg
ICAgc2VsZi52bS5hZGRfYXJncygnLWRldmljZScsICd2aXJ0aW8tOXAtcGNpLGZzZGV2PXNo
cjAsbW91bnRfdGFnPXNocjAnKQ0KPj4gKyAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWZz
ZGV2JywgZidsb2NhbCxzZWN1cml0eV9tb2RlbD1ub25lLHBhdGg9e3JtZV9zdGFja30saWQ9
c2hyMCcpDQo+IA0KPj4gKyAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWRldmljZScsICd2
aXJ0aW8tbmV0LXBjaSxuZXRkZXY9bmV0MCcpDQo+PiArICAgICAgICBzZWxmLnZtLmFkZF9h
cmdzKCctbmV0ZGV2JywgJ3VzZXIsaWQ9bmV0MCcpDQo+IA0KPiBlMTAwMGUgaXMgYnVpbHQt
aW4gYWxyZWFkeQ0KPiANCg0KVGhpcyBpcyBuZWVkZWQsIGJlY2F1c2Ugd2l0aG91dCB0aGlz
LCB0aGVyZSBpcyBhbiBleHBsaWNpdCB3YWl0IGZvciBhIA0KbmV0d29yayBpbnRlcmZhY2Ug
d2hlbiBib290aW5nLiBBZGRpbmcgdGhpcyBkZXZpY2UgYWxsb3dzIHRvIHNraXAgaXQuDQoN
Cj4gDQo+IEFzIGJvdGggdmlydCBhbmQgc2JzYS1yZWYgdGVzdHMgZG8gIm1vcmUgb3IgbGVz
cyIgdGhlIHNhbWUgc3R1ZmYgdGhlbiBpdA0KPiB3b3VsZCBiZSBnb29kIHRvIG1ha2UgY29t
bW9uIGZpbGUvY2xhc3MgYW5kIHJldXNlIGl0IGJvdGggdGVzdHMgYnkNCj4gYWRkaW5nIGhh
cmR3YXJlIGRpZmZlcmVuY2VzLg0KDQpJIHdhcyB0aGlua2luZyB0aGF0IGF0IHRoZSBiZWdp
bm5pbmcsIGJ1dCBtb3N0IG9mIHRoZSBjb25maWcgaXMgDQpkaWZmZXJlbnQuIFRoZSBvbmx5
IGNvbW1vbiBwYXJ0IGlzIHRoZSBuZXN0ZWQgZ3Vlc3QgdGVzdC4NCg0KSG93ZXZlciwgSSBk
aWRuJ3Qgc2VlIGFueSBvdGhlciB0ZXN0cyB0aGF0IHdlcmUgaW1wb3J0aW5nIGZ1bmN0aW9u
cyBmcm9tIA0Kb3RoZXIgZmlsZXMsIGFuZCBzaW5jZSB3ZSB3YW50IHRvIGtlZXAgdGhvc2Ug
dHdvIHRlc3RzIGluIHNlcGFyYXRlIGZpbGVzIA0KKHRvIGFsbG93IHBhcmFsbGVsaXNtKSwg
dGhlIG1vc3QgcHJhZ21hdGljIHNvbHV0aW9uIHdhcyB0byBkdXBsaWNhdGUuDQpPdmVyYWxs
LCB0ZXN0cyBmaWxlcyBzaG91bGQgYmUgYXMgc2ltcGxlIGFzIHBvc3NpYmxlLCBldmVuIGlm
IHRoZSBwcmljZSANCmlzIHRvIHJlcGVhdCBhIGZldyBsaW5lcy4NCklmIHlvdSBoYXZlIGEg
Y2xlYW5lciBzb2x1dGlvbiwgSSdtIG9wZW4gdG8gaW1wbGVtZW50IGl0Lg0KDQpUaGFua3Ms
DQpQaWVycmljaw0K

