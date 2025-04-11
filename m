Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792D9C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 15:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3GIw-0006LU-Ij; Fri, 11 Apr 2025 11:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u3GIq-0006Km-GU
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 11:28:24 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u3GIn-0001iz-Au
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 11:28:24 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so2055158b3a.3
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 08:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744385298; x=1744990098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PUAXomRvCtwsCzZCH7Q/FVlBhvZ0s7flP3e1LTaAUDI=;
 b=uoPtNowt7UP6jk9f8iNLMieAmYgcwOfj7TJhTdHaAFKWoKJsv5MfRFqpoO5qRCcZBp
 aCMdc625nDmdhDcyuVAjZ7ctkqtXhwVh3egEziT1nptB/ANLZpTjWwPVf4Zd5y+XrUCb
 uSYInJjuTlt/NvU/YteUrqHT6M+Ada4tVzyI3d7a0U5+Q+yn70elfNgyZnREfhuwXSqz
 HJUoaEWiJgD/HJX5aC5FsQohrcGU4rocfsu/kH0jFyF7StsUfrlaRyeD0rS/e94bZ0nI
 CPzjXsYLTNXClRMPyzV9ZHMdt7R7e8fRo9gaO66NTfmQnPEDoq6uGROE6qj1k2Ygbaox
 oUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744385298; x=1744990098;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PUAXomRvCtwsCzZCH7Q/FVlBhvZ0s7flP3e1LTaAUDI=;
 b=gAu0MPoWHjs2VBnHw/mNUJm0OYusnkGZ90397L9EYG8RGl9twFabDMdiyv+m/2M1tv
 jOYiZf48f6Sv7KLsoLUgxrT0gH1njb6KFkUbFa2LGdSDeFTor3/jX5uSHomZGtC8iW2T
 R2lsnYhlzig1qHPHSA/OzoC5TDdjHGU3FjZHGprfSk0TUxQj5fuepH05iysxX8kIC1HW
 4taakFc8Iq+7bVlbOO+r6Z4tHPot+mjsQy19F2M7gNDt6BnNT1sT+6Jpfh8Q1JBF9aEF
 xG285Jns8DjhrIf8CPEDHedjHXw6GE9Jrrus43GiTm0nhefQfim9GboCl2dr++0wumFt
 Qw7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoTLfw2q6yIbvbJfw89F7h2bv53Tr/bkdPkpO393+emNI8ESR5G9dYAHnnbHkjTSMsdMA9SvUU6gX1@nongnu.org
X-Gm-Message-State: AOJu0YwiQL3ZMRaUVWVqnxphEhlaePfdzLUIWuAXv0HdI5ywHLm5uUx3
 2MsozWbSs4vTVJH+Xfnztt7Lk5n0F6R5Jdwkx65dAE9GDghqw/PyZnOadZNTb5I=
X-Gm-Gg: ASbGncv0iQEADrqvejLNyAxwQFRwns5EZ4XXwOuLJohLdOPmQQCuK/MPDfB1iGgxgfD
 sr1yY+y0oQN94AtP+zOT4SeqMCZOtj1VFr1JZ56Itw/M3BwQBc759U+WBew632UZX1dDFQDY8JF
 XPLgrTqBqqE9Rws13U/Az3S+EZkFHbSu//0fTPNuWrHbIdkPuyqJSbogq98ppKEIDx8ugb3I0QJ
 0JzQ9Aj8oMEHXfM/B30PwpYcIXRZxV7cxtVJR4bV1nT2oW0b69JrEOOLLWFqvQ5zbqYlXnJ2r4C
 dCCHB8G8uUkD1cJ0mdNvilAzlZvT4xh+UOIY5RxXXu3CGhSyJgCKEQ==
X-Google-Smtp-Source: AGHT+IGwRLD44lLzlKb3cd1yIqxRyeI0/6yalZiLFwzce5Jq8dTp0VCQN9yWzNqpb5FRZABQX9b5Bg==
X-Received: by 2002:a05:6a20:4f92:b0:201:85f4:ad0a with SMTP id
 adf61e73a8af0-20185f4bb86mr1113527637.30.1744385298404; 
 Fri, 11 Apr 2025 08:28:18 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f10b3sm1645927b3a.118.2025.04.11.08.28.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 08:28:17 -0700 (PDT)
Message-ID: <b360cb8f-0e5b-4811-b625-29e0538ba61b@linaro.org>
Date: Fri, 11 Apr 2025 08:28:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Enable QEMU to run on browsers
Content-Language: en-US
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <20250409192115.GA5528@fedora>
 <dc36c24e-dc4a-4c24-97b7-8b812441ffce@linaro.org>
 <CAEDrbUZ4mbCT-npk8Nha4fDd9a5PGguAxS_RD0wG96gpQRUp+g@mail.gmail.com>
 <CAEDrbUYM3aK5ErvF=+oV=q-NVLO0uzxbYjHzcxPGvTLp7yNtwA@mail.gmail.com>
 <83f44749-0eea-48f0-8aa5-3882132e30d0@linaro.org>
 <CAEDrbUbjD0d-pP_s1oV7gSuFoDpKTDiXd7bQf6p5hQUcN_iT+g@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAEDrbUbjD0d-pP_s1oV7gSuFoDpKTDiXd7bQf6p5hQUcN_iT+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

T24gNC8xMS8yNSAwNzozNiwgS29oZWkgVG9rdW5hZ2Egd3JvdGU6DQo+IEhpIFBpZXJyaWNr
LCB0aGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjay4NCj4gDQo+ICA+IGZpcnN0LCBjb25ncmF0
cyBmb3IgdGhpcyB3b3JrIQ0KPiAgPiBJdCB3b3VsZCBiZSByZWFsbHkgbmljZSB0byBoYXZl
IHRoaXMgYXZhaWxhYmxlIHVwc3RyZWFtLCBzdGFydGluZyB3aXRoIGENCj4gID4gbW9kZXN0
IFRDSSBwb3J0LCBiZWZvcmUgaGF2aW5nIHRoZSB0Y2cgYmFja2VuZCBhbHNvLg0KPiANCj4g
U3VyZSwgSSdsbCBzcGxpdCB0aGUgcGF0Y2ggc2VyaWVzLCBzdGFydGluZyB3aXRoIHRoZSBU
Q0kgcG9ydC4NCj4gDQo+ICA+IERvIHlvdSBoYXZlIHJlY2VudCBpbmZvcm1hdGlvbiBhYm91
dCB3YXNtNjQ/IEl0IHNlZW1zIHRvIGJlIHNvbWV0aGluZw0KPiAgPiB0aGF0IGhhcyBiZWVu
IGRpc2N1c3NlZCBmb3Igc2V2ZXJhbCB5ZWFycywgd2l0aG91dCByZWFsbHkgc2VlaW5nIGFu
eQ0KPiAgPiBwcm9ncmVzcy4NCj4gDQo+IEFjY29yZGluZyB0byB0aGUgYWRvcHRpb24gc3Rh
dHVz4oCvWzFdLCB3YXNtNjQgaXMgc3VwcG9ydGVkIGJ5IHJlY2VudCB2ZXJzaW9ucw0KPiBv
ZiBDaHJvbWUgYW5kIEZpcmVmb3guIEVtc2NyaXB0ZW4gYWxzbyBzdXBwb3J0cyB3YXNtNjTi
gK9bMl0uIEhvd2V2ZXIsIGl0IGlzDQo+IG5vdCB5ZXQgc3VwcG9ydGVkIGJ5IFNhZmFyaSBv
ciBsaWJmZmnigK9bM10sIGFuZCBJIGhhdmVuJ3QgZm91bmQgYSByb2FkbWFwIGZvcg0KPiB0
aGUgYWRvcHRpb24uDQo+IA0KDQpHcmVhdCwgSSBkaWRuJ3Qgbm90aWNlIG1ham9yIGJyb3dz
ZXJzIHdlcmUgYWxyZWFkeSBzdXBwb3J0aW5nIGl0Lg0KRXZlbiBpZiBTYWZhcmkgZG9lcyBu
b3Qgc3VwcG9ydCBpdCwgbWF5YmUgaGF2aW5nIHRoZSB0d28gb3RoZXIgbWFqb3IgDQpvbmVz
IHdvdWxkIGJlIGVub3VnaCB0byB0YXJnZXQgdGhpcy4NCg0KUmVnYXJkaW5nIGxpYmZmaSwg
b3VyIHVzYWdlIG9mIGl0IHNlZW1zIGxpbWl0ZWQgaW4gdGNpLCBJIHdvbmRlciBpZiB3ZSAN
CmNvdWxkIG5vdCB3b3JrYXJvdW5kIHRoaXMuIE9yIGV2ZW50dWFsbHkgc2VlIGlmIGVuYWJs
aW5nIHdhc202NCBpcyBhIGJpZyANCndvcmsgaW4gbGliZmZpIGl0c2VsZi4NCg0KPiBbMV0g
aHR0cHM6Ly93ZWJhc3NlbWJseS5vcmcvZmVhdHVyZXMvIDxodHRwczovL3dlYmFzc2VtYmx5
Lm9yZy9mZWF0dXJlcy8+DQo+IFsyXSBodHRwczovL2Vtc2NyaXB0ZW4ub3JnL2RvY3MvdG9v
bHNfcmVmZXJlbmNlLyANCj4gc2V0dGluZ3NfcmVmZXJlbmNlLmh0bWwjbWVtb3J5NjQgPGh0
dHBzOi8vZW1zY3JpcHRlbi5vcmcvZG9jcy8gDQo+IHRvb2xzX3JlZmVyZW5jZS9zZXR0aW5n
c19yZWZlcmVuY2UuaHRtbCNtZW1vcnk2ND4NCj4gWzNdIGh0dHBzOi8vZ2l0aHViLmNvbS9s
aWJmZmkvbGliZmZpLyANCj4gYmxvYi82YTk5ZWRiODA4MmY3NWU1MjNlMGQ2ZWJhYmE0MjIx
OGI4MGUxMGM4L1JFQURNRS5tZCNzdXBwb3J0ZWQtIA0KPiBwbGF0Zm9ybXMgPGh0dHBzOi8v
Z2l0aHViLmNvbS9saWJmZmkvbGliZmZpLyANCj4gYmxvYi82YTk5ZWRiODA4MmY3NWU1MjNl
MGQ2ZWJhYmE0MjIxOGI4MGUxMGM4L1JFQURNRS5tZCNzdXBwb3J0ZWQtcGxhdGZvcm1zPg0K
PiANCj4gID4gQXMgUGhpbGlwcGUgc2FpZCwgd2UgY2FuJ3QgcmVhbGx5IHJldmVydCB0aGF0
IChpdCdzIG5vdyBhbiBhc3N1bXB0aW9uDQo+ICA+IGZvciBvdXIgc29mdG1tdSBpbXBsZW1l
bnRhdGlvbiwgYW5kIHdvdWxkIGJyZWFrIGNvZGUgaWYgd2UgZW5hYmxlZCBpdA0KPiAgPiBh
Z2FpbiBub3cuKQ0KPiAgPg0KPiAgPiBUaGF0IHNhaWQsIHdlIGNhbiBhbHdheXMgaGF2ZSBh
IGZpcnN0IHZlcnNpb24gc3VwcG9ydGluZyBvbmx5IDMyIGJpdHMNCj4gID4gdGFyZ2V0cy4g
QW5kIGxhdGVyLCB3aGVuIHdhc202NCB3aWxsIGJlIGF2YWlsYWJsZSwgd2UgY2FuIGV4dGVu
ZCB0aGlzIHRvDQo+ICA+IGFsbCByZW1haW5pbmcgb25lcy4NCj4gDQo+IFRoZSBtYWluIGNo
YWxsZW5nZSBJJ20gc2VlaW5nIGlzIHRoYXQgSSBjb3VsZG4ndCBmaW5kIGEgY2xlYXIgdGlt
ZWxpbmUgZm9yDQo+IHdhc202NCBhZG9wdGlvbiBzbyBpdCdzIGRpZmZpY3VsdCB0byBwcmVk
aWN0IHdoZW4gaXQgd2lsbCBiZSB3aWRlbHkNCj4gYXZhaWxhYmxlLg0KPiANCj4gUmVnYXJk
aW5nIHRoZSByZXZlcnQsIHRoZSB3YXNtIGJhY2tlbmQgc3VwcG9ydHMgNjQtYml0IHdvcmRz
LCBzbyB0aGUgcmV2ZXJ0DQo+IGludHJvZHVjZWQgaW4gcGF0Y2ggMDYvMTAgaXMgcGFydGlh
bCwgYXMgYWxzbyBwb2ludGVkIG91dCBieSBQYW9sby4NCj4gDQoNCk9rLCB0aGFua3MgZm9y
IHBvaW50aW5nIGl0LCBJIGRpZG4ndCByZWFsbHkgcmVhZCBpbnRvIGRldGFpbHMgb2YgdGhl
IA0KcGF0Y2gsIGFuZCBzaW1wbHkgYXNzdW1lZCB5b3Ugd2FudGVkIHRvIHJldmVydCB0aGlz
IGNoYW5nZSBjb21wbGV0ZWx5LiANCklmIHdlIGNhbiBoYXZlIGEgc29sdXRpb24gb25seSBh
ZmZlY3RpbmcgZW1zY3JpcHRlbiBidWlsZHMsIEkgdGhpbmsgaXQncyBvay4NCg0KUmVnYXJk
cywNClBpZXJyaWNrDQo=

