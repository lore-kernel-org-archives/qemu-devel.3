Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5AEE77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvcN-00041b-Ee; Wed, 04 Dec 2024 15:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIvcL-00040L-Jy
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:05:01 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIvcK-0003La-2d
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:05:01 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7fd10cd5b1aso143086a12.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733342698; x=1733947498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nnv71+rW9GA7t2uIqnUeOj8gJtCmfjXmgXPNueQy4H8=;
 b=QzHmlnQkq9s9+BeV/8BoTP/Su5viMIezlda7hQXzj0o8SSorhVH1p35g54BkKYnnyX
 m7h0dqy5PvOk7ojnWk0lxHuUJN+yEewgyyYZLzHpVtH2CvHEw7+mF5YPdmJTTHv8B9+m
 nYs+a8hCxfdJ42dHgYDLFQrf+aa1W7hRUFay2vw5cLkcilO0vqnNtnJNcQpEnh49cxhs
 eGUB0t3hT4dQOjQZ8OT2cKA4mgTTdP6rDVw1TtILEM2GWF+VN7ZR98I68khkTwPaCGca
 U0M25+o1dsd7AgcrRPPOC6m+u9RSFMf+wdQgRvzJQzX8wIZf3Dh5cPLh0FEP/y7AFTey
 TQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733342698; x=1733947498;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nnv71+rW9GA7t2uIqnUeOj8gJtCmfjXmgXPNueQy4H8=;
 b=ON1YSNOhvXeZLk+VDtUzvHbgOTGFh7m6lheLmGzAzEJG1D4ESuuBjQjp35t2m4/fJK
 3B70xy0ue95WiSatdyp0JMsovE8vy7XIcT7VDUBK6raEhTuUmDQe4WsFXOG4rWcQdCar
 TO5IwESDgn15++PsPbmwWnwxUAuEzBfRkuGtCfFcquF/SzvxMiuvREJA3qHyKZT6bmSj
 TzXZRF57JPr9fV/bDRFGDMaG5jjupxHIhe/7KsHdw9DtGPfb7fCA9iE4bLWp6rqd/sga
 aKJQfoW41i/oNpPAH5Des19Q8CZHLiayTU6eYI3mB6lfdEaoVyjILiBy/5vvkVADr4TF
 /v1g==
X-Gm-Message-State: AOJu0YzkRCOZOcoFrEzT+Iedv+y8lssDOASiXmj8iqc+HyJJEdwkcE05
 OOJFW87ITZ2cyG2G5bU2O59yqvLzgZ1V6CoSk25fL/D9q3jmGLzkoF4ThH/RfEg=
X-Gm-Gg: ASbGnculuxD1RiyeJOyNIUeLDWBOBm7iOZJ0fiXegEXUS57hTNJyLpjEJWC6KtsbuRJ
 dYjsNjpmsqf0oEp0cdZ3LsYXk6B5tbzgXuoQ2mA8b7CKzRAI+XrTlx4OwJPSsf4ttc2cAXA6A2U
 /H1ulLvg5TxKUr0uA6YV1P2YzcnEoiViwh/TvJczEt+XNQTYeHkyArxuSu3M0EJbfcZoG2zTJUv
 cIAgQEtmar7WnJL3iYba8ZItyGpsxoAIAPqLJFCzrg0k1IsdsmCzX+1MjP1a+jvweZdYCoPbtBT
 deLUnGyDa4mQY7UwA7J31Q==
X-Google-Smtp-Source: AGHT+IGuVDDp8VLB9IPM6Tk9931pTC/c2PD9N5IN9kikQ+p67vwnXXDubjFWHYUbPdrnBQmPwk3bbA==
X-Received: by 2002:a05:6a20:918d:b0:1e0:f495:1bd9 with SMTP id
 adf61e73a8af0-1e16bdd3296mr8455695637.8.1733342698352; 
 Wed, 04 Dec 2024 12:04:58 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fc9c3a0c3csm11763116a12.76.2024.12.04.12.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 12:04:57 -0800 (PST)
Message-ID: <2e88ea19-fdae-429c-a674-a0fd5d91eced@linaro.org>
Date: Wed, 4 Dec 2024 12:04:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tests/functional/aarch64: add tests for FEAT_RME
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, mathieu.poirier@linaro.org,
 jean-philippe@linaro.org, marcin.juszkiewicz@linaro.org,
 gustavo.romero@linaro.org
References: <20241203213629.2482806-1-pierrick.bouvier@linaro.org>
 <87frn3bxfg.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87frn3bxfg.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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

T24gMTIvNC8yNCAwMTozOCwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBUaGlz
IGJvb3QgYW4gT1AtVEVFIGVudmlyb25tZW50LCBhbmQgbGF1bmNoIGEgbmVzdGVkIGd1ZXN0
IFZNIGluc2lkZSBpdA0KPj4gdXNpbmcgdGhlIFJlYWxtcyBmZWF0dXJlLiBXZSBkbyBpdCBm
b3IgdmlydCBhbmQgc2JzYS1yZWYgcGxhdGZvcm1zLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4gDQo+
IFF1ZXVlZCB0byB0ZXN0aW5nL25leHQsIHRoYW5rcy4NCj4gDQoNClRoYW5rcyBBbGV4Lg0K
DQpGWUksIHRoaXMgdGVzdCB0cmlnZ2VycyBhIHVic2FuIGlzc3VlLCB0aGF0IEkgZml4ZWQg
aW4gWzFdLg0KDQpBcyBQZXRlciBkaWQgZ29vZCBlZmZvcnRzIHRvIGNsZWFudXAgdWJzYW4g
aXNzdWVzIHdlIGhhZCAobm9uZSBsZWZ0IGZyb20gDQp3aGF0IEkgdHJpZWQpLCBpdCB3b3Vs
ZCBiZSB1bmZvcnR1bmF0ZSB0byByZWludHJvZHVjZSBvbmUgYXQgdGhlIHNhbWUgDQp0aW1l
IHdlIG1lcmdlIHRoZSBjdXJyZW50IHBhdGNoLg0KDQpbMV0gDQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9xZW11LWRldmVsLzIwMjQxMjA0MTk1MTExLjI5MjExNDEtMS1waWVycmljay5i
b3V2aWVyQGxpbmFyby5vcmcvVC8jdQ0K

