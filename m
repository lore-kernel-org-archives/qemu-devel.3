Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F9DC369CB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 03:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5cZf-0007Ej-8r; Thu, 17 Apr 2025 23:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5cZd-0007EU-E3
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 23:39:29 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5cZY-0005Ov-Ne
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 23:39:28 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-af5139ad9a2so968348a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 20:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744947562; x=1745552362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YP7FsRLWD3rC3elj3vAw0pjn4qphoXX2eHLlQoNMR44=;
 b=XIepXU5FivhrX5cuNH2G2kxTuidwtdZ5OehNoDnn4vnwapEN6RX4tTmOXit8tuYBbv
 UXVKgZT+EH6TkVmVGooV2ejoknQCbAmXIppHf9OTPD/lnM4fiTmIqHtP4woy86x9NGF8
 y0tZ24NqPe5SrfRAYS1HcClx6Eiwv/RgyBcoLGDn/EKoUfdAIsoWsIB2qTWUMfmBIX+v
 L0lLTDxgAJg1Qt7PDMe/JTkkrd6R2mMp3E8H3o9hzGV73sMDKd7Bnp/dQrjtwEQHydDp
 GPZhAmR2fyEs3d/izQyZu3zJKvGkIVp3pcTD7tnaW3LDGbi9SBIZe7mGLcsYYd0xKFgD
 hUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744947562; x=1745552362;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YP7FsRLWD3rC3elj3vAw0pjn4qphoXX2eHLlQoNMR44=;
 b=N4BxYZqDw2ZyQQkZovkMq6Pv10d5XvBDYbGdsJHqn+mOqYOgtKiBx6p6voRQ7KfOLe
 LYZEuIzzYaPyHmKY3IhNGwsQenAMRi8TGSCbIllEs7cGh4t5SZip/bw3OnG0RxNR2bQx
 VgiJ/PavilyH+nfvBldVjv19R80KLW8Rp+QETdHHZVERcORiCWRSJdY8mN87zMeUZzE6
 R0zPU8noIZXsbEFSyD8Mqdq4G7DHWzEsMRKrus85nQJ4RGrqeYLv/OlMF+djZKkOtuzW
 am+6+Ht+40bqY8X/JXE7wHCSbc0eW20HOUB87B13rEHyC/4Q/h4/YaUy79Cma1/NdYah
 3F2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6mnZDDVayWv2d+0rmBOU850nGC3I4rWqZfWA4os/uXysLilyxXBxvpIERy68mxdKiEqAKwXwUPJ0Y@nongnu.org
X-Gm-Message-State: AOJu0YyZU/ZoFsi5RExzw84M6sxJvkG7tBsdOSwC4USlNMayj+fqVRCT
 WfBZ3rTNEA61A/U5iqzET6oYamPW9V5RnuwJqi5p+O6m7wdQ8DcT+FDgk1zeluo=
X-Gm-Gg: ASbGncuK3KTwYdBlEsOHYyTjOj97dUet6jdjSKwTkeeUPY5fucHLhYDVguU9fNNSX6d
 +oeIpJ0489uU+O4XVSvS9JUL+9/0As5WHjBJ7+7nUhSk/wrN0j9zfMfCEAoai3LZGQ1maun0Sid
 QGf4FJfDngT/J6MW8fv8Az0WOkq6DJmjvkE7Erbi23FU0cEqVHMHoB5K7InWi3e+VxbkTYrx4MX
 NnjNE2vzvHdJWfNxpYUeMlhyaCgpG9cB/r3iVxrhev+F6LQ+Otcj7WCTtZjD6k+EIlD86nAdxUl
 qQr/2cFQty2Bnbb8Gw7ZtCkOk8Z/KhkGd76X6F/y3RtGUwCzWMXzyZwPBBcvmSyO
X-Google-Smtp-Source: AGHT+IFjvlMiiZYJ0Io3Ollb1i+m6gtSS6ASOajBbyUBUYEQe4QpDSdKpoyJWRmQBgdrU2WaowuZnw==
X-Received: by 2002:a17:90b:51c2:b0:2ee:d7d3:3019 with SMTP id
 98e67ed59e1d1-3087bb5332amr2410069a91.12.1744947562193; 
 Thu, 17 Apr 2025 20:39:22 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087dee87edsm260993a91.3.2025.04.17.20.39.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 20:39:21 -0700 (PDT)
Message-ID: <6db25ff8-17af-42b6-8753-029e6c89c9ea@linaro.org>
Date: Thu, 17 Apr 2025 20:39:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 08/11] config/target: Implement per-binary
 TargetInfo structure (ARM)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-9-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250418005059.4436-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

T24gNC8xNy8yNSAxNzo1MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IElm
IGEgZmlsZSBkZWZpbmluZyB0aGUgYmluYXJ5IFRhcmdldEluZm8gc3RydWN0dXJlIGlzIGF2
YWlsYWJsZSwNCj4gbGluayB3aXRoIGl0LiBPdGhlcndpc2Uga2VlcCB1c2luZyB0aGUgc3R1
Yi4gSW1wbGVtZW50IHN1Y2gNCj4gc3RydWN0dXJlIGZvciBhcm0tc29mdG1tdS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJv
Lm9yZz4NCj4gLS0tDQo+ICAgbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgfCAgNyAr
KysrKystDQo+ICAgY29uZmlncy90YXJnZXRzL2FybS1zb2Z0bW11LmMgfCAyMiArKysrKysr
KysrKysrKysrKysrKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGNvbmZpZ3MvdGFyZ2V0
cy9hcm0tc29mdG1tdS5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzb24uYnVpbGQgYi9tZXNv
bi5idWlsZA0KPiBpbmRleCAxNjhiMDdiNTg4Ny4uZGEyNGNjMmJhNDEgMTAwNjQ0DQo+IC0t
LSBhL21lc29uLmJ1aWxkDQo+ICsrKyBiL21lc29uLmJ1aWxkDQo+IEBAIC0zODA5LDcgKzM4
MDksNiBAQCBzcGVjaWZpY19zcy5hZGQoZmlsZXMoJ3BhZ2UtdGFyZ2V0LmMnLCAncGFnZS12
YXJ5LXRhcmdldC5jJykpDQo+ICAgDQo+ICAgY29tbW9uX3NzLmFkZChmaWxlcygndGFyZ2V0
X2luZm8uYycpKQ0KPiAgIHN5c3RlbV9zcy5hZGQoZmlsZXMoJ3RhcmdldF9pbmZvLXFvbS5j
JykpDQo+IC1zcGVjaWZpY19zcy5hZGQoZmlsZXMoJ3RhcmdldF9pbmZvLXN0dWIuYycpKQ0K
PiAgIA0KPiAgIHN1YmRpcignYmFja2VuZHMnKQ0KPiAgIHN1YmRpcignZGlzYXMnKQ0KPiBA
QCAtNDI3Miw2ICs0MjcxLDEyIEBAIGZvcmVhY2ggdGFyZ2V0IDogdGFyZ2V0X2RpcnMNCj4g
ICAgICAgYXJjaF9zcmNzICs9IGdkYnN0dWJfeG1sDQo+ICAgICBlbmRpZg0KPiAgIA0KPiAr
ICB0YXJnZXRfaW5mb19jID0gbWVzb24ucHJvamVjdF9zb3VyY2Vfcm9vdCgpIC8gJ2NvbmZp
Z3MnIC8gJ3RhcmdldHMnIC8gdGFyZ2V0ICsgJy5jJw0KPiArICBpZiBub3QgZnMuZXhpc3Rz
KHRhcmdldF9pbmZvX2MpDQo+ICsgICAgdGFyZ2V0X2luZm9fYyA9IG1lc29uLnByb2plY3Rf
c291cmNlX3Jvb3QoKSAvICd0YXJnZXRfaW5mby1zdHViLmMnDQo+ICsgIGVuZGlmDQo+ICsg
IGFyY2hfc3JjcyArPSB0YXJnZXRfaW5mb19jDQo+ICsNCj4gICAgIHQgPSB0YXJnZXRfYXJj
aFt0YXJnZXRfYmFzZV9hcmNoXS5hcHBseShjb25maWdfdGFyZ2V0LCBzdHJpY3Q6IGZhbHNl
KQ0KPiAgICAgYXJjaF9zcmNzICs9IHQuc291cmNlcygpDQo+ICAgICBhcmNoX2RlcHMgKz0g
dC5kZXBlbmRlbmNpZXMoKQ0KPiBkaWZmIC0tZ2l0IGEvY29uZmlncy90YXJnZXRzL2FybS1z
b2Z0bW11LmMgYi9jb25maWdzL3RhcmdldHMvYXJtLXNvZnRtbXUuYw0KPiBuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMC4uNjI2M2Q2MDRmMTkNCj4gLS0tIC9k
ZXYvbnVsbA0KPiArKysgYi9jb25maWdzL3RhcmdldHMvYXJtLXNvZnRtbXUuYw0KPiBAQCAt
MCwwICsxLDIyIEBADQo+ICsvKg0KPiArICogUUVNVSBiaW5hcnkvdGFyZ2V0IEFQSSAocWVt
dS1zeXN0ZW0tYXJtKQ0KPiArICoNCj4gKyAqICBDb3B5cmlnaHQgKGMpIExpbmFybw0KPiAr
ICoNCj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+
ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4gKyNpbmNsdWRlICJx
ZW11L3RhcmdldF9pbmZvLWltcGwuaCINCj4gKyNpbmNsdWRlICJxZW11L3RhcmdldF9pbmZv
LXFvbS5oIg0KPiArI2luY2x1ZGUgImNwdS1xb20uaCINCj4gKw0KPiArc3RhdGljIGNvbnN0
IFRhcmdldEluZm8gdGFyZ2V0X2luZm9fYXJtX3N5c3RlbSA9IHsNCj4gKyAgICAubmFtZSA9
ICJhcm0iLA0KPiArICAgIC5tYWNoaW5lX3R5cGVuYW1lID0gVFlQRV9UQVJHRVRfQVJNX01B
Q0hJTkUsDQo+ICt9Ow0KPiArDQo+ICtjb25zdCBUYXJnZXRJbmZvICp0YXJnZXRfaW5mbyh2
b2lkKQ0KPiArew0KPiArICAgIHJldHVybiAmdGFyZ2V0X2luZm9fYXJtX3N5c3RlbTsNCj4g
K30NCg0KWW91IGNhbiBleHRyYWN0IHRoaXMgZnJvbSB0aGlzIGNvbW1pdCwgYW5kIHNxdWFz
aCB3aXRoIGFhcmNoNjQgdGFyZ2V0Lg0KSSB0aGluayBpdCdzIGEgZ29vZCBpZGVhIHRvIHN0
b3JlIHRoaXMgaW4gY29uZmlncy90YXJnZXRzLg0K

