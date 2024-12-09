Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D84E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 18:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKiwr-0005dS-Tc; Mon, 09 Dec 2024 13:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKiwk-0005dA-8b
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:57:30 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKiwi-0000qZ-MC
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:57:30 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee709715d9so3410509a91.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 10:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733770646; x=1734375446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xHWyWIpkl+UUjWSNwAJ6Y7cRZasOcLT+JStYL/774yM=;
 b=hqO+UBgbOnRyIWKHWOdkzmKIoSaOLF+zySRvegEk/p2p7e8C3nAXgeNqYfCXSHpKrL
 KeDveD8RS6x52JRpFKTHBrtCBFb9fDu5ICm5hHLyqjfTudMrUBqV1FBD9hOFQ26nUrap
 AgZiBfTN+zeQVEgardak2w8CFmCk1lqXAhHG4/2KViorbcvlOBuAr1rMGzwWaor8+VLE
 NaVwXMzGYhjzI41KA2yEDpK6KsGDg/y3IfzUuhw2GPbF3v372MbXmiUp42H8bVo+3cAv
 wDTjhTCKxiOjFEpLhb4s+rVoTH2ILxZcqMuC8pJZYgGybFb5mX9EXWLtcHw7Ngiue+YM
 JB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733770646; x=1734375446;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xHWyWIpkl+UUjWSNwAJ6Y7cRZasOcLT+JStYL/774yM=;
 b=cE/UgkAe2QD7aXIeaFUongbxsqikaISljD9VjHLDLIL7myZSDIgHd+lqLQTEWxqcXT
 3SM+dN1ym8twUAqPBLZRVLdjyUxfCpT1S0AgmWjnaq3tM6uzQHwpE4fTDf90iNBprDy2
 X08db8vynvpFqpqtTxcfcYcfFnhKkORfCr+q8Egl+M+XyR+JvxM/Hox0/7dqlr/ZTB8J
 PcLpYv76j3RT+AcugL1NzZ06UR9GANNv2jEtswbTIz8+7L38ZmJNixvgKI0YBEuFNnvM
 qCRxPAAdtIITZHr+StgIu6VICpnLgickuBQO5MvaTZ0xAigjLWj9+R4brCoUXZqGwMDo
 9BmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOJy2oPgq/yukQkE1uT0hrm7BBYOy3TGRv+pyjvonEku/ik8rLnOfwp4R0CluuI49JHZTHw/dUIK7J@nongnu.org
X-Gm-Message-State: AOJu0Yyk0HiWvstmY+j4p63DrcBswM0PvvTSHwZ7W1QGWz2V4bk34kOj
 DY2h/WUp2cWGLIHNhoU1D0z2RdQK8cD9a1qj0rV1n3IShFJRV19C5BBK8WRlSjE=
X-Gm-Gg: ASbGncsx4IPoHpInF9pbXFyOStGMzSYLgut3Z1PWC6yJqb51DeYwwmxTSddxGe0WEOZ
 H4zjBQRkbqxFJaIzZqhdt1ub6GTi7MNLOzZElLUSKVH84AozzNkjdL0YZILgadCtbQIvLxBLC4N
 +E7vozJzSwx7kiwC19L3ISWZKEeoev+D0scCuOAlj979QCXIQr9oV0Lk4Ks9jHI2d2JJGyHM6Nq
 6ZX1/pHXkhJEn7zmtPEgnCTAtjiduKIOLnqWt0aaRE/2xMcUZh7tKJ/vzTqgvvPoFZ2OT1GaUnM
 obVVDek7/A/Qa2jAePjyXQ==
X-Google-Smtp-Source: AGHT+IHA00bwlKyTIOb+/5jcDa5Z6xLz4dqA9ccWhjeU99ErdrKR4ZT+Bdux+kmBWsGNbEIZXfttVQ==
X-Received: by 2002:a17:90a:e7ce:b0:2ee:f80c:6884 with SMTP id
 98e67ed59e1d1-2efcf26e242mr2449372a91.33.1733770645678; 
 Mon, 09 Dec 2024 10:57:25 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd578b457csm769976a12.27.2024.12.09.10.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 10:57:25 -0800 (PST)
Message-ID: <c87d5221-68eb-47c7-aa42-4bfcb041d9bf@linaro.org>
Date: Mon, 9 Dec 2024 10:57:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: replace 'Edit on GitLab' with 'View page source'
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20241209163506.2089961-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241209163506.2089961-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

T24gMTIvOS8yNCAwODozNSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gUUVNVSB0
YWtlcyBjb250cmlidXRpb25zIHZpYSB0aGUgbWFpbGluZyBsaXN0LCBzbyB3aGlsZSB5b3Ug
Y2FuIGVkaXQgYQ0KPiBmaWxlIG9uIGdpdGxhYiBhbmQgdGhlbiBzd2l0Y2ggdG8gdGhlIHRl
cm1pbmFsIHRvIHNlbmQgYSBwYXRjaCwgdGhlDQo+IHdvcmRpbmcgJ0VkaXQgb24gR2l0TGFi
JyBzdHJvbmdseSBzdWdnZXN0cyB3ZSB0YWtlIG1lcmdlIHJlcXVlc3RzLg0KPiANCj4gU3dp
dGNoaW5nIGJhY2sgdG8gIlZpZXcgcGFnZSBzb3VyY2UiIGlzIGEgbW9yZSBhZ25vc3RpYyB0
ZXJtIHRoYXQgZG9lcw0KPiBub3QgaW1wbHkgYSBwYXJ0aWN1bGFyIGNvbnRyaWJ1dGlvbiBh
cHByb2FjaCwgdGhhdCB3ZSBoYWQgdXNlZCBpbiBRRU1VDQo+IGJlZm9yZToNCj4gDQo+ICAg
IGNvbW1pdCA3M2U2YWVjNjUyMmUxZWRkNjNmNjMxYzUyNTc3YjQ5YTM5YmMyMzRmDQo+ICAg
IEF1dGhvcjogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5j
b20+DQo+ICAgIERhdGU6ICAgVHVlIE1hciAyMyAxNTo1MzoyOCAyMDIxICswNDAwDQo+IA0K
PiAgICAgIHNwaGlueDogYWRvcHQga2VybmVsIHJlYWR0aGVkb2MgdGhlbWUNCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+
DQo+IC0tLQ0KPiAgIGRvY3MvY29uZi5weSB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kb2Nz
L2NvbmYucHkgYi9kb2NzL2NvbmYucHkNCj4gaW5kZXggYzExYTZlYWQ4YS4uMTY0YThlZThi
MiAxMDA2NDQNCj4gLS0tIGEvZG9jcy9jb25mLnB5DQo+ICsrKyBiL2RvY3MvY29uZi5weQ0K
PiBAQCAtMTg2LDcgKzE4Niw3IEBADQo+ICAgXQ0KPiAgIA0KPiAgIGh0bWxfY29udGV4dCA9
IHsNCj4gLSAgICAiZGlzcGxheV9naXRsYWIiOiBUcnVlLA0KPiArICAgICJzb3VyY2VfdXJs
X3ByZWZpeCI6ICJodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS9ibG9i
L21hc3Rlci9kb2NzLyIsDQo+ICAgICAgICJnaXRsYWJfdXNlciI6ICJxZW11LXByb2plY3Qi
LA0KPiAgICAgICAiZ2l0bGFiX3JlcG8iOiAicWVtdSIsDQo+ICAgICAgICJnaXRsYWJfdmVy
c2lvbiI6ICJtYXN0ZXIiLA0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGll
cnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

