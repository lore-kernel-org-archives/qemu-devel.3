Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A863E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 18:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVxgu-0006D0-QY; Thu, 09 Jan 2025 13:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tVxgf-000652-OL
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:55:25 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tVxgd-0006L1-V4
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:55:21 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso20397935ad.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 10:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736448918; x=1737053718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NgJhSKvv4Fl1r5bGyBeNP2FbkM//DKOYtOmfW4bl+2I=;
 b=qg0lLpJFb9dm/joB4BQDb7SGcHAWMhCPAz0h9aLZqorVq211VWEOm48zQg+hwt9u+k
 DF91PawfjKbk1B2f8fUEY3tjjZlAqeUeWFRAMaAr9ouFdVuYiXYDmIqHsB3MFOHu3TQe
 4cVjvdLRh/0UshWGbzhz0V1hDseHRhWZuahHzPSIOZVafJgFCPqaAzRG6erqNJNEmQDS
 YzCFhjoNzbKxvjz6re3EfReMFi3LlhS1KsQxi8NV+INDTKSlL0Agis73NNptfEcVc0z4
 A+mvN916uqQDTf+A7EeAFR8wVf1qOmBVUms4gckLqFpxgyBhvoGrtqoUGtaQewjLwkJH
 VLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736448918; x=1737053718;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NgJhSKvv4Fl1r5bGyBeNP2FbkM//DKOYtOmfW4bl+2I=;
 b=XoEcQATK14cr9mPTOna0mFkDbAmfcu9UW1DLluRBQJJHRT0nGNIfVjlEgQj1rZh9wP
 T0i78QUsDKJYluy5mTXnkCWLbefLp3I8jEjNwvBqEHYa8/0aiuTtEInpZmNJ2iFW84yA
 UXPZxdoXeNkqvSxM07bEI0WXZw7mb0yBq+7uv2o6lk63aCh4Vblgm00ZVXdpj3jVi/BC
 pk0WtN+ima/HFG6s5cpiKtdlW2EHV3PKrmIBfP5wWZG4K5NsQhuUpbLmn8xd/K0WuWbw
 knC9mCwIa3OoM2C6cfAluhqABY0/hFCYhLRPjdpXKgOdq8vmT92tARQir/cIb6IGol2v
 9zjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyeVz9EVxupOqqkY8M6Cv06EDFyL0CpsRaJEaedN4Lntv31vRPD6zDc7wNpKfJzlQucr9d6GGsP8vM@nongnu.org
X-Gm-Message-State: AOJu0YxOonGJizaN4hf2RXDKItZcSQ/2gcIBb3O+KXH+1ojYy3ti7Slf
 xzhFz7VSosXsn+QEdbF3IGMpraLkJbVjO/QtY6BHt9ftXLM8bkVrpDbCRSBessk=
X-Gm-Gg: ASbGnctoonoC/CiPMzq68zP30IbcTKnoZGPtkfEXJFpT6XO0ZjnycHt9CJvme8qQPsf
 UlsZoPDg+ceZzxlt+GWY7CQcihvs0CEF6WS91B8gITPJP32E3oQ9xpxFH1XBXKw5WvX1J+wb17n
 12QG0B+n6Qi5QewZDbc4PR0SYbF8LObN5ADxAki5LtMxZuvDHsKrfNyyuHOQ1pSZBukoeM76Z9a
 Gbr3la2lj/pOr7l2Z0CxeXduz7O4N5b3IHUYXRlFi57XSWrrp/B+1cllXtoqOg00VMiWg==
X-Google-Smtp-Source: AGHT+IHpBrT0MeOjEt70PWgZ0v2a/DCdqWS0lbOFDwqFr7GZya9UUTbV+rTpDbOZ7egtohKhDhOxPA==
X-Received: by 2002:aa7:8887:0:b0:72a:bb83:7804 with SMTP id
 d2e1a72fcca58-72d21fd2e16mr11347518b3a.17.1736448918462; 
 Thu, 09 Jan 2025 10:55:18 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d4067e61asm115821b3a.128.2025.01.09.10.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 10:55:18 -0800 (PST)
Message-ID: <da769717-0823-45b4-8b1c-9fd2611d0092@linaro.org>
Date: Thu, 9 Jan 2025 10:55:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/22] system: propagate Error to gdbserver_start (and
 other device setups)
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
 <20250109170619.2271193-11-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250109170619.2271193-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

T24gMS85LzI1IDA5OjA2LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IFRoaXMgc3RhcnRlZCBh
cyBhIGNsZWFuLXVwIHRvIHByb3Blcmx5IHBhc3MgYSBFcnJvciBoYW5kbGVyIHRvIHRoZQ0K
PiBnZGJzZXJ2ZXJfc3RhcnQgc28gd2UgY291bGQgZG8gdGhlIHJpZ2h0IHRoaW5nIGZvciBj
b21tYW5kIGxpbmUgYW5kDQo+IEhNUCBpbnZvY2F0aW9ucy4NCj4gDQo+IE5vdyB0aGF0IHdl
IGhhdmUgY2xlYW5lZCB1cCBmb3JlYWNoX2RldmljZV9jb25maWdfb3JfZXhpdCgpIGluIGVh
cmxpZXINCj4gcGF0Y2hlcyB3ZSBjYW4gZnVydGhlciBzaW1wbGlmeSBieSBpdCBieSBwYXNz
aW5nICZlcnJvcl9mYXRhbCBpbnN0ZWFkDQo+IG9mIGNoZWNraW5nIHRoZSByZXR1cm4gdmFs
dWUuIEhhdmluZyBhIHJldHVybiB2YWx1ZSBpcyBzdGlsbCB1c2VmdWwNCj4gZm9yIEhNUCB0
aG91Z2ggc28gdHdlYWsgdGhlIHJldHVybiB0byB1c2UgYSBzaW1wbGUgYm9vbCBpbnN0ZWFk
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5h
cm8ub3JnPg0KPiBBY2tlZC1ieTogSWx5YSBMZW9zaGtldmljaCA8aWlpQGxpbnV4LmlibS5j
b20+DQo+IA0KDQo8c25pcD4NCg0KPiAtc3RhdGljIGludCBnZGJzZXJ2ZXJfb3Blbl9wb3J0
KGludCBwb3J0KQ0KPiArc3RhdGljIGludCBnZGJzZXJ2ZXJfb3Blbl9wb3J0KGludCBwb3J0
LCBFcnJvciAqKmVycnApDQoNCkRpZCB5b3UgbWVhbjoNCnN0YXRpYyBib29sIGdkYnNlcnZl
cl9vcGVuX3BvcnQuLi4/DQoNCldpdGggdGhhdCwNClJldmlld2VkLWJ5OiBQaWVycmljayBC
b3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

