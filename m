Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D62CDD0E1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 20:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3LYq-0005gR-5a; Tue, 22 Oct 2024 16:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3LYn-0005fw-Bz
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:32:57 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3LYl-0007pX-9I
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:32:56 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20ca388d242so43334875ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 13:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729629174; x=1730233974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=22iDYg801c8q/L8h63/ZCoe5iOUGaky+8DT+5jhBm58=;
 b=DAkurtSTngZ91jtkTNHI2+fugtSj+kiEmSUbFhwYJcEgK866ups/B9gHXlqccc1H/S
 Qo32AjAExDm/9eFmicbdhOffKdDIUVLNCNeceja7/a52fbfuWMufy/DXKNxXCd9NR3Y7
 nRlh5aKV0w2kYxxRWWZyVa/aIweI17oCzKo+K3QUfxLIurzDTJHLIXOE/Lm5v//c8HNR
 ZBAk6z8q6txdOcz5gC2DeEa6f1vzoEhrS9aA5mFqn7mMibqv/o2Gv5FD3lCKNOh+QE3c
 H4IlkwPu5G2F2x0cwx0PkZQHs9nexMoLVronrxlBeZ0vbAdf76l+1MWF7kDmdmN4yuFD
 Dtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729629174; x=1730233974;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=22iDYg801c8q/L8h63/ZCoe5iOUGaky+8DT+5jhBm58=;
 b=th6KEmGcYe8ALnkq1yEZY/t6q3pJIupSTEVZyHFPjeeEGo9THhOnLbjtAZFwAfQf+L
 FqD0xEw/9/yQD78LrurYR492RwoyEtvh+lSymYAWb+62w62/Nh/gDJpLoIxSwq537/or
 Df8jkD2RywT/oqb+64eoRyB75Mo9gQcS97CtCBUcn+eGnPtyC2f3aLETPBj6BtwNzmVd
 iIUJDvLSThnoYjdZK2yPW2THXX8oQoZbfZiJogQsjF+1TVUgt11jiz3wz0Vz8i7cZj39
 BXvInGJCW4t8NHIZVbxeQW2I4nMcLyriaoHYnq0tyVKDOW7OQl2egkaEvozbyppvSVeO
 wTaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu1nsHkbyur3WZujNep2a2Yj+x5FVrVyBRIxPACsTndNFNlwv5ZXN6vRF0pnWiu/jGnvZQch7/OLuH@nongnu.org
X-Gm-Message-State: AOJu0YwgXdlwGApihRjpjFFpSapJRLDBrvOvlmI/GBHBna+MXZ7wmlZq
 ZQfAUfEPFlU1p84/bo5QCYAntYjrfY96wVIYtt1n66++AW590hr7rKeZupGvD+Y=
X-Google-Smtp-Source: AGHT+IFaD76bQqjYlx7C1qxfp6VbhP5GE48tnyBe+LWy7d4tLOyRp3pZwxtrqk+0RelB7tsR0TfiQA==
X-Received: by 2002:a17:902:d2c6:b0:20b:6f04:486a with SMTP id
 d9443c01a7336-20fa9e785a8mr5423175ad.35.1729629173598; 
 Tue, 22 Oct 2024 13:32:53 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0bd42asm46422095ad.165.2024.10.22.13.32.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 13:32:53 -0700 (PDT)
Message-ID: <fdea845b-d38a-4cd8-b87f-098dd7a7adbb@linaro.org>
Date: Tue, 22 Oct 2024 13:32:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/20] scripts/ci: remove architecture checks for
 build-environment updates
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 devel@lists.libvirt.org, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
 <20241022105614.839199-7-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241022105614.839199-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

T24gMTAvMjIvMjQgMDM6NTYsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gV2Ugd2VyZSBtaXNz
aW5nIHMzOTB4IGhlcmUuIFRoZXJlIGlzbid0IG11Y2ggcG9pbnQgdGVzdGluZyBmb3IgdGhl
DQo+IGFyY2hpdGVjdHVyZSBoZXJlIGFzIHdlIHdpbGwgZmFpbCBhbnl3YXkgaWYgdGhlIGFw
cHJvcHJpYXRlIHBhY2thZ2UNCj4gbGlzdCBpcyBtaXNzaW5nLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiAtLS0NCj4g
ICBzY3JpcHRzL2NpL3NldHVwL3VidW50dS9idWlsZC1lbnZpcm9ubWVudC55bWwgfCAyIC0t
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvc2NyaXB0cy9jaS9zZXR1cC91YnVudHUvYnVpbGQtZW52aXJvbm1lbnQueW1sIGIvc2Ny
aXB0cy9jaS9zZXR1cC91YnVudHUvYnVpbGQtZW52aXJvbm1lbnQueW1sDQo+IGluZGV4IGVk
ZjE5MDBiM2UuLjU2YjUxNjA5ZTMgMTAwNjQ0DQo+IC0tLSBhL3NjcmlwdHMvY2kvc2V0dXAv
dWJ1bnR1L2J1aWxkLWVudmlyb25tZW50LnltbA0KPiArKysgYi9zY3JpcHRzL2NpL3NldHVw
L3VidW50dS9idWlsZC1lbnZpcm9ubWVudC55bWwNCj4gQEAgLTM5LDcgKzM5LDYgQEANCj4g
ICAgICAgICB3aGVuOg0KPiAgICAgICAgICAgLSBhbnNpYmxlX2ZhY3RzWydkaXN0cmlidXRp
b24nXSA9PSAnVWJ1bnR1Jw0KPiAgICAgICAgICAgLSBhbnNpYmxlX2ZhY3RzWydkaXN0cmli
dXRpb25fdmVyc2lvbiddID09ICcyMi4wNCcNCj4gLSAgICAgICAgLSBhbnNpYmxlX2ZhY3Rz
WydhcmNoaXRlY3R1cmUnXSA9PSAnYWFyY2g2NCcgb3IgYW5zaWJsZV9mYWN0c1snYXJjaGl0
ZWN0dXJlJ10gPT0gJ3g4Nl82NCcNCj4gICANCj4gICAgICAgLSBuYW1lOiBJbnN0YWxsIHBh
Y2thZ2VzIGZvciBRRU1VIG9uIFVidW50dSAyMi4wNA0KPiAgICAgICAgIHBhY2thZ2U6DQo+
IEBAIC00Nyw3ICs0Niw2IEBADQo+ICAgICAgICAgd2hlbjoNCj4gICAgICAgICAgIC0gYW5z
aWJsZV9mYWN0c1snZGlzdHJpYnV0aW9uJ10gPT0gJ1VidW50dScNCj4gICAgICAgICAgIC0g
YW5zaWJsZV9mYWN0c1snZGlzdHJpYnV0aW9uX3ZlcnNpb24nXSA9PSAnMjIuMDQnDQo+IC0g
ICAgICAgIC0gYW5zaWJsZV9mYWN0c1snYXJjaGl0ZWN0dXJlJ10gPT0gJ2FhcmNoNjQnIG9y
IGFuc2libGVfZmFjdHNbJ2FyY2hpdGVjdHVyZSddID09ICd4ODZfNjQnDQo+ICAgDQo+ICAg
ICAgIC0gbmFtZTogSW5zdGFsbCBhcm1oZiBjcm9zcy1jb21waWxlIHBhY2thZ2VzIHRvIGJ1
aWxkIFFFTVUgb24gQUFyY2g2NCBVYnVudHUgMjIuMDQNCj4gICAgICAgICBwYWNrYWdlOg0K
DQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5h
cm8ub3JnPg0K

