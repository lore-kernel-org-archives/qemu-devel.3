Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4885E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 18:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOhoU-0007LJ-JX; Fri, 20 Dec 2024 13:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOhoS-0007L3-Rm
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 13:33:25 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOhoR-0000sg-46
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 13:33:24 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso1951963a12.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 10:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734719601; x=1735324401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/edbafS/HOfN8WEKRZvjqd3U/kpCLZf9r2iQpCZ+LMg=;
 b=qt5hUIWv3l0pXtkb8Z/nNnUbt9yesldvnz0JogzqYwngLXetX89r7aR5NY1anELTPt
 EPWyiUrPY9NEc+By31HLzEQmKIHBpOHJPLnvp+GI6OuXSEqu8Iks/1VDagGWs3PXYHrZ
 +En0UvNzMP4GG8XSGK2N45WKdqBI89WZLx1gOxSKJIfVbyq7qdamrjlTia/wp/diWsh5
 eFtl3/OiJqBy2DqiyJa49f+FBJyjXctoti+DbDPsR2HMK7l/5q7Gxsbhx6maySayJiJ6
 yau416jS8cvcWde+FLIdHX3ssvugOw6Iaf3lA+EJAdeyi0gk/+nNVWYuKchZImN40vbK
 yMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734719601; x=1735324401;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/edbafS/HOfN8WEKRZvjqd3U/kpCLZf9r2iQpCZ+LMg=;
 b=wh8PlquEor0dRDUlwQtmzUQcH7knvK/m9rfDxm4a9gC/jFtjzxSqB3DrTDv3nIBKcu
 /H1jGjA6/NUTGq+veTayfqtbWRNW1dc5U4qrknjhqBwEUuPZLr7jQoh1yH3C1CxgD409
 rJmmth81lDnpMBtIypeXXtP+KfweH7UwwBH3LxI4PrJ/6JiRFcWbFuqDdJ2z2q2TJ33d
 MC/kHf02q3I7VR/qOlMWqpmsVp9ZjajOCUBggSGHIEnHEdxa2r25I/8ZOco2HBdVa+dZ
 S+17f6gwYrsKIeQMJkXMJg8dsFGUVABp8OXfjyX+Z+0tIR+ntLjtD+FFlSv83TENEMmT
 Ee7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEhUIq3TQVVO04Q7ZT3Ec+TmR3kWM3cvHAgJilUkjElRT9YTfLt0KDU7jVy4bmC6o9GURX5ByhfwP4@nongnu.org
X-Gm-Message-State: AOJu0Yw3Z3wjHqzq7XJCO2qoXn5uA0jZjD8W4TKikfZj4GvE812YObqB
 jH+q4rDgneAjv/7fVTpiJYZxtRm/rOGfhcE+9Guy6MXoXZIQzM+Gh2KOK/wsCBCtTCaHCPLJVt4
 l
X-Gm-Gg: ASbGncvWoj35OLCqkGvZYYvqzCug4VFl/UYRvcj26d2WSaldWdW/qH+u6mQsq2parYQ
 Sqpjedw1f3klyhCKpfr5XJyjZSjiyv+/WDjJhu9xBQ7lgLYFG0WQX2PXyfKbJ7aRfaUa/lTfEws
 LsLRzCj1u0ZyXytPCZ7ebaomH/MpnFzcDpDQR5KaqTZou8ZFiNssSIYHCR+C7qqzJfiIJ2OAoRK
 gwHQgLHLK60lQWmv3Nb67aIXnNUsvCYcP14d40w8TLFaNr7qoX/iWg6aKQ/2iIRTsJb8A==
X-Google-Smtp-Source: AGHT+IGgeV8Ceuf/Xvan+/Z55iABJGEC/HmQyLN+O5+TSZTg7Fq8xIdEjVeEty4oVVA9IYot1+ajMA==
X-Received: by 2002:a17:90b:51c2:b0:2ee:9e06:7db0 with SMTP id
 98e67ed59e1d1-2f452e1d3f9mr5992263a91.11.1734719600968; 
 Fri, 20 Dec 2024 10:33:20 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96e933sm32209805ad.59.2024.12.20.10.33.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 10:33:20 -0800 (PST)
Message-ID: <2cbb0e17-4799-4bcf-a39e-e9d50ea1e2df@linaro.org>
Date: Fri, 20 Dec 2024 10:33:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Test assets not available anymore for
 tests/functional/test_rx_gdbsim.py
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
References: <5f571195-39b9-45e5-ba03-fd835afb5012@linaro.org>
 <b853ab30-fc7a-4e03-82da-0ed97fd4aa0b@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b853ab30-fc7a-4e03-82da-0ed97fd4aa0b@linaro.org>
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

T24gMTIvMjAvMjQgMDI6NTAsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBP
biAxOS8xMi8yNCAyMDo0NywgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+IEhpIGFsbCwN
Cj4+DQo+PiBhc3NldHMgZm9yIHRlc3RzL2Z1bmN0aW9uYWwvdGVzdF9yeF9nZGJzaW0ucHkg
YXJlIG5vdCBhdmFpbGFibGUgYW55bW9yZS4NCj4+DQo+PiBJdCBzZWVtcyB0aGF0IHRoZSBk
aXJlY3RvcnkgImh0dHBzOi8vYWNjLmRsLm9zZG4uanAvdXNlcnMiIHZhbmlzaGVkIGZyb20N
Cj4+IHRoZSB3ZWIsIGFuZCBpdCdzIG5vdCBhIHRlbXBvcmFyeSBpc3N1ZS4NCj4+IElmIHNv
bWVvbmUgc3RpbGwgaGFzIHRob3NlIGFzc2V0cyBvbiB0aGVpciBsb2NhbCBjYWNoZSwgbWF5
YmUgaXQncyBhDQo+PiBnb29kIHRpbWUgdG8gdXBsb2FkIHRoZW0gc29tZXdoZXJlIGVsc2Us
IGFuZCB1cGRhdGUgdGhlIHRlc3QuDQo+IA0KPiBJIHBvc3RlZCBhIHBhdGNoIGZvciB0aGF0
IDQgeWVhcnMgYWdvIGJ1dCBpdCBnb3QgbG9zdDoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcWVtdS1kZXZlbC8yMDIwMDYzMDIwMjYzMS43MzQ1LTEtZjRidWdAYW1zYXQub3JnLw0K
PiANCj4gSSdsbCByZXNwaW4sIHRoYW5rcyBmb3Igbm90aWNpbmcuDQoNClRoYW5rcyBQaGls
aXBwZS4NCg==

