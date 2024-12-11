Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DA9E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSp-0001S1-0V; Wed, 11 Dec 2024 11:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLPSa-00016l-3z
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:12 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLPSY-0007qV-FS
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:11 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-725ee27e905so3832340b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934069; x=1734538869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R/8rIeF0TDteUXFj/RITr0ALWgOxAOP826Or7EBLfgI=;
 b=FEE+LKhXGE08VpF+W4P8Zs6wisfopXMBFmIkTWROy8c6gg/sq5rbi7EGCqMxrENH2M
 AjpXZR4xy+pQTWrJPDP4jv2n5mBcpphGimluQHUy0ppvdQBggISh+eM9r+Vq1aqXEQU/
 M04WNTTxGk+wuuS7aJQDltYHOfTXA+FUetQg6GeHqqStlGuofCJsDghmAt2SEcMoZNLK
 A/0+btIvmMLDapEi4OuOEMKai+ZQMF1PQ2V+CcS3O4W7SQyuZeeSEm3fst62le5QpXjV
 qRjplf8bQ+lGpK3hUIbHOSXTIdZcPtvgO886XHoXVUG878r51MtVo+DEPziXVcWw926x
 jZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934069; x=1734538869;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R/8rIeF0TDteUXFj/RITr0ALWgOxAOP826Or7EBLfgI=;
 b=vBpFQdUeezNi6ZhcMXNwaeF8/K29+ZGIDY9qDnSvndrESm3tKqPfq+SzL00CaG64Dp
 udclxO9pZHJWpitU4bHATdp/ZS2NEZBGeO4XyONnIkSheRBDGyaDAXyhnfE/gL5anr3B
 iuE75Vbd5iJuR2S2SVy6RO8X1MzncRpa1oy4QglJRjhi1WmAC6heLgqhPGKixMnX7mqp
 zoSN5fbnt0INM/y1uz3ZhAN6GeNPJDFskbFRN+yy/cJKZkr4beNbkM1h9JZBuj5Urm3d
 AK8mNaVWvFCcXp9aO/qHiUFR+5DNuFnI5jrIPQPMkeFMAcIHHJrK10SwO0m4He+y04CT
 +UQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVrWegkqK4ABTllxH7KR/Yy+iCXxZuyDC8maKFewTuscdKbh1W8T5Eq01A/un8KnsITv5/HTj46aCy@nongnu.org
X-Gm-Message-State: AOJu0YyoNUf0CKYQ92vAVWxkTIMu0Mdt9czlV2HsB2XWxFgeK2t8JP6T
 eZL/D/REYUzOGQtA+v8oFiUkDXnX5rXThtiqLg8pn0OpqiZZjmm5rqe6yaHozEo=
X-Gm-Gg: ASbGncvEkIQdCTdhg5ylY0anPCdVCV12B62i2xQ9vWURKaRz5ZJCZs5+wxlOOylswPK
 DqQMqJZLBF3ruzqi0l141MqSlDoINSUMLR3OkMV0s6buOGE1cmvhdyZ0l5SO0lOkaONSyxyVK4A
 KLYpkfhAQE5s7ntKbV7a6kFhQQL0564eBUT/JCzg0rEcVqT3ahqWi7MB5sPAHoAKNB04vcyO+uf
 3Hc0QVJ08T6F5VHbfFR3wkG3n5TNiI9olgq1L7dCY46NUl5mQ+pAC93IFHAgDgaSMS5o2a6KGwy
 iOXDyQv/EQKbTgaG8JLcbIqEDg==
X-Google-Smtp-Source: AGHT+IHVEtZAk+HzNzF2+zrLOq2c1LiYiL0X2EinosbU0WqAKvQRBhnLix7+bf2/ztLjZteojuXsRw==
X-Received: by 2002:a05:6a21:e92:b0:1db:eff0:6ae7 with SMTP id
 adf61e73a8af0-1e1cdb2359emr637538637.33.1733934068701; 
 Wed, 11 Dec 2024 08:21:08 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725d36e66e1sm7811131b3a.178.2024.12.11.08.21.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 08:21:08 -0800 (PST)
Message-ID: <41bb7f1a-35b7-4f38-b8cc-9b40bb3da1ed@linaro.org>
Date: Wed, 11 Dec 2024 08:21:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/20] tests/functional/aarch64: add tests for FEAT_RME
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Eric Farman
 <farman@linux.ibm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20241210204349.723590-1-alex.bennee@linaro.org>
 <20241210204349.723590-16-alex.bennee@linaro.org>
 <ba91b0da-ea60-4802-b336-f3a650d06ae4@redhat.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ba91b0da-ea60-4802-b336-f3a650d06ae4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

T24gMTIvMTEvMjQgMDA6MDQsIFRob21hcyBIdXRoIHdyb3RlOg0KPiBPbiAxMC8xMi8yMDI0
IDIxLjQzLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+PiBGcm9tOiBQaWVycmljayBCb3V2aWVy
IDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+Pg0KPj4gVGhpcyBib290IGFuIE9Q
LVRFRSBlbnZpcm9ubWVudCwgYW5kIGxhdW5jaCBhIG5lc3RlZCBndWVzdCBWTSBpbnNpZGUg
aXQNCj4+IHVzaW5nIHRoZSBSZWFsbXMgZmVhdHVyZS4gV2UgZG8gaXQgZm9yIHZpcnQgYW5k
IHNic2EtcmVmIHBsYXRmb3Jtcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBC
b3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+Pg0KPj4gLS0tLS0NCj4+
DQo+PiB2MjoNCj4+IC0gbW92ZSB0ZXN0IHRvIGl0cyBvd24gZmlsZQ0KPj4gLSBhZGQgc2Jz
YSB0ZXN0DQo+PiAtIGNoZWNrIG91dHB1dCBvZiBgY2NhLXdvcmtsb2FkLWF0dGVzdGF0aW9u
IHJlcG9ydGANCj4+DQo+PiB2MzoNCj4+IC0gYnVpbGQgYW5kIHJ1biB0ZXN0IHdpdGggY2Nh
LXY0IGltYWdlcw0KPj4gLSBmYWN0b3JpemUgbmVzdGVkIGd1ZXN0IHRlc3QgYmV0d2VlbiBi
b3RoIHRlc3RzDQo+PiAtIHJlbW92ZSBhY2NlbCB0Y2cgb3B0aW9uIGFzIGl0IGlzIHRoZSBk
ZWZhdWx0IHdoZW4gcnVubmluZyB0ZXN0cw0KPj4gTm90ZTogSXQncyBhIGxvbmcgdGVzdCBh
bmQgdGhlcmUgaXMgYSB3b3JrIGluIHByb2dyZXNzIHRvIHVuZGVyc3RhbmQgd2h5DQo+PiBk
ZWJ1ZyBidWlsZCBpcyBzbyBzbG93ICh4MTIgdnMgb3B0aW1pemVkKS4NCj4+DQo+PiB2NDoN
Cj4+IC0gdXNlIHBhdXRoLWltcGRlZj1vbiB0byBzcGVlZCB1cCBidWlsZCB0aW1lIGV4ZWN1
dGlvbiAoeDIuNSBmYXN0ZXIpDQo+PiAtIGluY3JlYXNlIHRpbWVvdXQgdmFsdWUNCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxp
bmFyby5vcmc+DQo+PiBNZXNzYWdlLUlkOiA8MjAyNDEyMDMyMTM2MjkuMjQ4MjgwNi0xLXBp
ZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVu
bsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4+IC0tLQ0KPj4gICAgdGVzdHMvZnVu
Y3Rpb25hbC9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgfCAgIDQgKw0KPj4gICAgdGVz
dHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNoNjRfcm1lX3Nic2FyZWYucHkgfCAgNzAgKysrKysr
KysrKysrKw0KPj4gICAgdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNoNjRfcm1lX3ZpcnQu
cHkgICAgfCAxMDAgKysrKysrKysrKysrKysrKysrKw0KPj4gICAgMyBmaWxlcyBjaGFuZ2Vk
LCAxNzQgaW5zZXJ0aW9ucygrKQ0KPj4gICAgY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL2Z1
bmN0aW9uYWwvdGVzdF9hYXJjaDY0X3JtZV9zYnNhcmVmLnB5DQo+PiAgICBjcmVhdGUgbW9k
ZSAxMDA3NTUgdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FhcmNoNjRfcm1lX3ZpcnQucHkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9tZXNvbi5idWlsZCBiL3Rlc3Rz
L2Z1bmN0aW9uYWwvbWVzb24uYnVpbGQNCj4+IGluZGV4IDBhNzZiZDk5NTQuLjRlMjA3YzUz
ZDUgMTAwNjQ0DQo+PiAtLS0gYS90ZXN0cy9mdW5jdGlvbmFsL21lc29uLmJ1aWxkDQo+PiAr
KysgYi90ZXN0cy9mdW5jdGlvbmFsL21lc29uLmJ1aWxkDQo+PiBAQCAtMTMsNiArMTMsOCBA
QCBlbmRpZg0KPj4gICAgdGVzdF90aW1lb3V0cyA9IHsNCj4+ICAgICAgJ2FhcmNoNjRfYXNw
ZWVkJyA6IDYwMCwNCj4+ICAgICAgJ2FhcmNoNjRfcmFzcGk0JyA6IDQ4MCwNCj4+ICsgICdh
YXJjaDY0X3JtZV92aXJ0JyA6IDEyMDAsDQo+PiArICAnYWFyY2g2NF9ybWVfc2JzYXJlZicg
OiAxMjAwLA0KPiANCj4gSSB3YXMgYSBsaXR0bGUgYml0IHdvcnJpZWQgd2hlbiBJIHNhdyB0
aGUgYmlnIHRpbWVvdXQgdmFsdWVzIGhlcmUsIGJ1dA0KPiB0aGF0J3Mgb25seSBmb3IgZGVi
dWcgYnVpbGRzLCByaWdodD8gSSBnYXZlIGl0IGEgdHJ5IGluIGEgc3RhbmRhcmQgYnVpbGQs
DQo+IHRoZSB0ZXN0cyBib3RoIGZpbmlzaGVkIHdpdGhpbiA1IG1pbnV0ZXMsIHNvIHRoZSBz
dGFuZGFyZCBydW50aW1lIHN0aWxsDQo+IHNlZW1zIHRvIGJlIG9rLg0KPiANCg0KWWVzLCBp
dCdzIGZvciBkZWJ1ZyBvbmx5Lg0KDQo+IFRlc3RlZC1ieTogVGhvbWFzIEh1dGggPHRodXRo
QHJlZGhhdC5jb20+DQo+IA0KPiAgID4gKyAgICAjIFRoaXMgdGVzdHMgdGhlIEZFQVRfUk1F
IGNwdSBpbXBsZW1lbnRhdGlvbiwgYnkgYm9vdGluZyBhIFZNDQo+IHN1cHBvcnRpbmcgaXQs
DQo+ICAgPiArICAgICMgYW5kIGxhdW5jaGluZyBhIG5lc3RlZCBWTSB1c2luZyBpdC4NCj4g
ICA+ICsgICAgZGVmIHRlc3RfYWFyY2g2NF9ybWVfc2JzYXJlZihzZWxmKToNCj4gICA+ICsg
ICAgICAgIHN0YWNrX3BhdGhfdGFyX2d6ID0gc2VsZi5BU1NFVF9STUVfU1RBQ0tfU0JTQS5m
ZXRjaCgpDQo+ICAgPiArICAgICAgICBhcmNoaXZlX2V4dHJhY3Qoc3RhY2tfcGF0aF90YXJf
Z3osIHNlbGYud29ya2RpcikNCj4gICA+ICsNCj4gICA+ICsgICAgICAgIHNlbGYuc2V0X21h
Y2hpbmUoJ3Nic2EtcmVmJykNCj4gICA+ICsgICAgICAgIHNlbGYudm0uc2V0X2NvbnNvbGUo
KQ0KPiAgID4gKyAgICAgICAgc2VsZi5yZXF1aXJlX2FjY2VsZXJhdG9yKCd0Y2cnKQ0KPiAN
Cj4gUGxlYXNlIG1vdmUgdGhlIHNldF9tYWNoaW5lIGFuZCByZXF1aXJlX2FjY2VsZXJhdG9y
IHRvIHRoZSBiZWdpbm5pbmcgb2YgdGhlDQo+IGZ1bmN0aW9uIHNpbmNlIHRoZXkgY2FuIHNr
aXAgdGhlIHRlc3QgaW4gY2FzZSB0aGUgcHJlcmVxdWlzaXRlIGlzIG5vdA0KPiBhdmFpbGFi
bGUuIE90aGVyd2lzZSB5b3UndmUgZXh0cmFjdGVkIHRoZSBhc3NldCBpbiB2YWluLg0KPg0K
DQpBbGV4LCBjb3VsZCB5b3UgcGxlYXNlIGtpbmRseSB1cGRhdGUgaXQsIGFzIGl0J3MgcGFy
dCBvZiB5b3VyIHNlcmllcyBub3c/DQoNCj4gICAgVGhvbWFzDQo+IA0KDQpUaGFua3MsDQpQ
aWVycmljaw0K

