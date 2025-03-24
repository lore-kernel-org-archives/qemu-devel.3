Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE08EC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twn1W-0001bl-Br; Mon, 24 Mar 2025 14:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twn1L-0001Ku-32
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:59:37 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twn1I-0001T9-IS
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:59:34 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ff6a98c638so10064427a91.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742842770; x=1743447570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0EB0v/gzI6zo/2nudFuK1145nVAXg9BNg53HxXQ5JR0=;
 b=jRrVbpLVS8IGRp57rbuPclW86lv8UzS7+R1G25chLa0jKDRTcdVxf20jdUpF67wu5e
 H4O+plPf0vnoaVS8JfogbCB79YrYBw29+lKXppqVL/PkxulOgEyeTFBC1ie9sEEdbpak
 oq/Tld19Vw/RGupPIYfZOdwfOPmHRc17yZAP11hpgxzAYHTkhtbeZfXFhiqpvzRfvOmu
 FE7zSqVlg3c+tm4C2MlXyrHmsA1BpKQ+AJnEni9UtbQSCugZgzm3czOh1NGw8IetJnmY
 2euAdxr90maDFfQ+qvnZv68/aDvI0+S2qrzMrS5qvaQTgjtY7dSRpBrecacSU3c9xnto
 6g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842770; x=1743447570;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0EB0v/gzI6zo/2nudFuK1145nVAXg9BNg53HxXQ5JR0=;
 b=NVs8zaCn/smyjT4cfeJrIHKDxpZTPzpa0+TGsNCfW7lQhzCJSxh3HPpwhKn4g07SpH
 +f56u4F03W1bwizFx2Chu9o+ZiIRYSADDu/isb1XXPKd7+W6pcwrYT2jzilgEC42ek19
 bZuFI52OZeABTpArn9CTG3QcD+GizPEShgy56sFG71TTqMJofHgKaye07Td2LUc7Z/ON
 8vS4DHftSOMFtLT83IetSjgS02Jw93+E5toaoddjlIyK+QvIXMGrgcXhTubvbemDzKuc
 Y78riYEPQm99T//oi5NqAghrTDH1sMN7MES9lz6deefKFxguO+vJ0qYKBKeJsaJe9IqK
 ScDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXVcj2mGvtBAXRENRUp7zrkGaVZHDU7a2EVVdKhONc2tTR5UcDNGfw4iLB5ZhfLVJS9R2shUhQIBKH@nongnu.org
X-Gm-Message-State: AOJu0YyE98mEr9rj03hp5GIAvooERAqvZxAyb1MPMq4ga7zno1eL5buf
 yabtuCdV4xsK7GbJTYHb6XvpFqk3LChzYvma+XYsTCvEZHaJABP0x+wejtARylM=
X-Gm-Gg: ASbGncug0DaEUKv6GhJq9jkH834atkbczuiVMvSHRagZm7QxqT057iOj9Wmf+A3RJ+a
 WpsXJ0/U5NFX0IV70TvleMlQSIBy4mS+wvKTDOYhnnzFdGkZg4nVGBHJdhgFZVuC6jEE0MGIX9n
 M9vl6dk+DweoXU/xSa+9uAKAcZGlzi/n5jJAzoLPSgrZHB6R5rCtu+9pdmJb5kzSnn5xXY0QV5z
 NSs0M/ZqGQWsYIbO126nkELApuW8OrhTfbZyf6NKXvqD8bHVpovLacuFT4eGH1hc9J3BQbvi32I
 rznv/ZGQGbwNKIw71CQwujxxYRBpYuiL07zH5IAf+Ua76/Ml7Qqhmo72WRLKLd5rXyFZ
X-Google-Smtp-Source: AGHT+IGNooZLOI736yAW2K8W2XVBsk+wc8OIW8HQ7qJVXaXIjeJglFsPvQWA3K3g+2fYePukJ+raaw==
X-Received: by 2002:a17:90b:4c0a:b0:2ee:ad18:b309 with SMTP id
 98e67ed59e1d1-3030fe6e1fdmr16640938a91.3.1742842769681; 
 Mon, 24 Mar 2025 11:59:29 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4c4easm74755265ad.84.2025.03.24.11.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 11:59:29 -0700 (PDT)
Message-ID: <03280ae6-c89b-41a7-a9a0-4157cba8c538@linaro.org>
Date: Mon, 24 Mar 2025 11:59:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 0/7] cpus: Convert cpu_list definition to
 CPUClass:list_cpus callback
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250324184611.44031-1-philmd@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250324184611.44031-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

T24gMy8yNC8yNSAxMTo0NiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFNp
bmNlIHYxIChUaG9tYXMgcmV2aWV3IGNvbW1lbnRzKQ0KPiAtIE1vdmUgczM5MF9zZXRfcWVt
dV9jcHVfbW9kZWwvczM5MF9jcHVfbGlzdCB0byAiY3B1X21vZGVscy5oIg0KPiAtIENvcnJl
Y3QgJ3RhcmdldC9zMzkweDogUmVnaXN0ZXIgQ1BVQ2xhc3M6bGlzdF9jcHVzJyBzdWJqZWN0
DQo+IA0KPiAnY3B1X2xpc3QnIG1pZ2h0IGJlIGRlZmluZWQgcGVyIHRhcmdldCwgYW5kIGZv
cmNlIGNvZGUgdG8gYmUNCj4gYnVpbHQgcGVyLXRhcmdldC4gV2UgY2FuIGF2b2lkIHRoYXQg
YnkgaW50cm9kdWNpbmcgYSBDUFVDbGFzcw0KPiBjYWxsYmFjay4NCj4gDQo+IFRoaXMgc2Vy
aWVzIGNvbWJpbmVkIHdpdGggYW5vdGhlciB3aGljaCBjb252ZXJ0cyBDUFVfUkVTT0xWSU5H
X1RZUEUNCj4gdG8gYSBydW50aW1lIGhlbHBlciwgYWxsb3dzIHRvIG1vdmUgbW9zdCBvZiBj
cHUtdGFyZ2V0IHRvIGNvbW1vbi4NCj4gDQoNCkkgdGhpbmsgd2Ugc2hvdWxkIGZvY3VzIG9u
IGEgbW9yZSBnZW5lcmFsIHNvbHV0aW9uLCB1c2FibGUgd2l0aCANCm1hY2hpbmVzLCBjcHVz
LCBhbmQgZGV2aWNlcywgbGlrZSB0aGUgaW50ZXJmYWNlIGJhc2VkIGFwcHJvYWNoZWQgd2Ug
DQp0YWxrZWQgYWJvdXQuDQoNCkhhdmluZyBhbiBvcHRpb25hbCBjYWxsYmFjaywgaW1wbGVt
ZW50ZWQgb24gaGFsZiB0YXJnZXQsIGxvb2tzIGxpa2UgYSANCmhhbGYgYmFrZWQgc29sdXRp
b24uIEFuZCBpdCB3b3VsZCBub3QgYmUgZGVzaXJhYmxlIHRvIGRvIHRoZSBzYW1lIHRoaW5n
IA0KZm9yIG1hY2hpbmVzLCBhbmQgZGV2aWNlcyBsYXRlci4NCg0KSW4gY2FzZSBDUFVfUkVT
T0xWSU5HX1RZUEUgaXMgYW1iaWd1b3VzIChiZWNhdXNlIDY0IGJpdCB0eXBlIGluaGVyaXQg
DQpmcm9tIDMyIGJpdCB0eXBlLCBsaWtlIFRZUEVfQUFSQ0g2NF9DUFUgaW5oZXJpdHMgZnJv
bSBUWVBFX0FSTV9DUFUpLCANCml0J3MgYmV0dGVyIHRvIGRlY2xhcmUgYW5vdGhlciBpbnRl
cmZhY2UsIG5vbiBhbWJpZ3VvdXMsIGxpa2U6DQotIFRZUEVfTUFDSElORV9UQVJHRVRfQUFS
Q0g2NA0KLSBUWVBFX01BQ0hJTkVfVEFSR0VUX0FSTQ0KLSBUWVBFX0NQVV9UQVJHRVRfQUFS
Q0g2NA0KLSBUWVBFX0NQVV9UQVJHRVRfQVJNDQotIFRZUEVfREVWSUNFX1RBUkdFVF9BQVJD
SDY0DQotIFRZUEVfREVWSUNFX1RBUkdFVF9BUk0NCg0KSSB3b3VsZCBiZSBpbiBmYXZvciB0
byBpbnRyb2R1Y2UgdGhpcyBmb3IgYWxsIHRhcmdldHMsIHNvIGFsbCBvZiB0aGVtIA0KYXJl
IGltcGxlbWVudGVkIGluIHRoZSBleGFjdCBzYW1lIHdheSwgYW5kIHRoZSBwYXR0ZXJuIGlz
IGVhc3kgdG8gZm9sbG93Lg0KDQpCeSB1c2luZyB0aGlzIGFwcHJvYWNoIGFuZCB0YWdnaW5n
IG1hY2hpbmVzL2NwdXMvZGV2aWNlcyBhY2NvcmRpbmdseSwgDQp0aGVyZSBpcyBubyBuZWVk
IGZvciBhbnkgY2FsbGJhY2sgYW55d2hlcmUsIGFuZCB0aGUgbGlzdGluZyBjb2RlIGNhbiBi
ZSANCmdlbmVyaWMuDQoNCkFzIGEgYm9udXMsIHdlIGNhbiBhc3NlcnQgYWxsIG1hY2hpbmVz
L2NwdXMgYXJlIHByb3Blcmx5IHRhZ2dlZCwgDQpzb21ldGhpbmcgaW1wb3NzaWJsZSB0byBk
byB3aXRoIHRoZSBjYWxsYmFja3MgYXBwcm9hY2gsIHdoaWNoIG9wZW5zIHJvb20gDQpmb3Ig
YSBwb3NzaWJsZSBlcnJvciwgaWYgb25lIG9mIHRoZSBjYWxsYmFjayBpcyBidWdneS4NCg==


