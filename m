Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F287C021A4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 01:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmjIo-00083k-Il; Mon, 24 Feb 2025 20:00:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tmjIg-000835-Ut
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:59:56 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tmjIa-0005Cz-AO
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 19:59:54 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2fbfc9ff0b9so7834088a91.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 16:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740445186; x=1741049986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J1zfBDm/UrYqM7GCBIGft4UEiJEMBd40pAwLkzY07h0=;
 b=D6E19g4GsBpDBV2H/ClGrQlKW/qSn5jpA802iN7C8A/SXuhGoY6sGI0FR35RNodhpu
 XbIJh8aMAM7En4gTcqMjNaHv0j6pn3qldndGOq6RQrg7LlBpPJkZGQ674koyGHGYLxoE
 0C5Dz+jd9s1z/v2B8jEesgojvxFadfT2EIv/QF9e7EtwpGpuWxNoF5ISG/MstFjYQe0G
 Ke00NUFozC0qCo1lnCSrlfvEl8gvLcMYvmI6AqbQi/vh0hGVgrnPOobZf+RwysinzArq
 NtknG8JDcHpsUIMbUwT7teMNEpq8PBkSg3IIQouAotdiVOhIt6BGZivgKVM4JX4FhCg2
 jbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740445186; x=1741049986;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J1zfBDm/UrYqM7GCBIGft4UEiJEMBd40pAwLkzY07h0=;
 b=WflPoaZneDdEnTybSnRUruN3g17y22lnZ7OpuRx5ABO+ORq/7gj5Pr/H/FEt6sOZml
 wu8YQXxhX1CnjCY2outg5PCXoFjGnJmO43+8nlBIrdik/MXu/SAVUeRP7wqH5lSzKTk2
 TsA/WwNIKHHNqSyChgCty7qJBToObEfvMyesHGi5wgWkIOgZpO7azx96duQRSGJbaxzw
 oAwGcdOJoBtrV+eT2oXCh0wOyly2yl1npMpsmBOPB22HSoOfKL7iC0BN7WaeWpSb+VTp
 db+xhNmmKl+0Nz0vbV9kM2hthxNmDbkZedMRWHN7cDp/bM/DlGJx2UV/YuSPA7VWIj0u
 AygQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkDz76XyCyIx/2EhW6viPZ1YSvKVWfwyiQ74iEGhM/mORK86k1fof/Z4rxqhI4olKePJ9qno8tBOeA@nongnu.org
X-Gm-Message-State: AOJu0Yxb9sMfyvQEBU3wT0j7W4DBInoC0TumaF4Tu3ZcNdw1klAiUnWc
 bbBwZ/Eaym+ZdJYCgRdVbyhaeBqsLQNm0mUp7bF0E3DCtUvFa7nNHj2+TDIpwoyinGpYe2lv4aU
 tlAuhPg==
X-Gm-Gg: ASbGncvmjLJ2uai4AUXFGpZLMUwKM7DAGWrjMba7MmDqXuFFv8mXJJVZx6blb7sp7Ow
 SnL/PTBRN3bvdtTvivdFBvycph4/n3pHCKtp3yqI6nGtcFBP3d0yMrdi2ai3PYyxMgvEzKe0eRy
 jIA0lAWcNaWAvlIrdx7zxrZaXkb9ZBntOa1TF1qdA3r/bT+JYnUuetcrj6mGdGbRuoDgM/2KWcy
 +cU6m6xqvZ7S77/WVBrtLYiUi4EMIWojjuDBPfSNokiGXcOXqelp+7KNdTBqWYPh9UXec3EzmMB
 DNTQNAZwXgpX65BvEAZJ+wzNfkF92zZNndc+wF4=
X-Google-Smtp-Source: AGHT+IGvDVQH3tkxqcC5RMkqYhwc1nAbgKK0VJLYN1lBYFllez0JFj6BdUx76OsOXmDgZHMsyXb9Aw==
X-Received: by 2002:a17:90b:280c:b0:2ee:5bc9:75c7 with SMTP id
 98e67ed59e1d1-2fe68ac9330mr1934145a91.5.1740445186070; 
 Mon, 24 Feb 2025 16:59:46 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fe6dec6dc2sm52341a91.1.2025.02.24.16.59.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 16:59:45 -0800 (PST)
Message-ID: <30a35e73-2f72-4e1c-b38f-c744b6884706@linaro.org>
Date: Mon, 24 Feb 2025 16:59:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Building QEMU as a Shared Library
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: "amir.gonnen@neuroblade.ai" <amir.gonnen@neuroblade.ai>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Saanjh Sengupta <saanjhsengupta@outlook.com>
References: <PS2P216MB1388380FEF72AF5916FD9B59CCC62@PS2P216MB1388.KORP216.PROD.OUTLOOK.COM>
 <befaccff-5885-4e8d-a397-29df6cdaa7d9@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <befaccff-5885-4e8d-a397-29df6cdaa7d9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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

SGkgU2FhbmpoLA0KDQpoZXJlIGlzIGEgbWluaW1hbCBwYXRjaCB0aGF0IGJ1aWxkcyBvbmUg
c2hhcmVkIGxpYnJhcnkgcGVyIHRhcmdldCAoYXJjaCwgDQptb2RlKSB3aGVyZSBhcmNoIGlz
IGNwdSBhcmNoLCBhbmQgbW9kZSBpcyBzeXN0ZW0gb3IgdXNlciwgYW5kIGxhdW5jaCANCnN5
c3RlbS1hYXJjaDY0IHRocm91Z2ggYSBzaW1wbGUgZHJpdmVyOg0KDQpodHRwczovL2dpdGh1
Yi5jb20vcGJvLWxpbmFyby9xZW11L2NvbW1pdC9mYmIzOWNjNjRmNzdkNGJmMWU1ZTUwNzk1
Yzc1YjYyNzM1YmY1YzVmDQoNCldpdGggdGhpcywgaXQgY291bGQgYmUgcG9zc2libGUgdG8g
Y3JlYXRlIGEgZHJpdmVyIHRoYXQgY2FuIGV4ZWN1dGUgYW55IA0KZXhpc3RpbmcgdGFyZ2V0
LiBJdCdzIGEgc29ydCBvZiBzaW5nbGUgYmluYXJ5IGZvciBRRU1VLCBidXQgc2hhcmVkIA0K
b2JqZWN0cyBhcmUgbWFuZGF0b3J5LCBhbmQgZHVwbGljYXRlcyBhbGwgdGhlIFFFTVUgc3Rh
dGUuIFNvIHRoZXJlIGlzIG5vIA0KcmVhbCBiZW5lZml0IGNvbXBhcmVkIHRvIGhhdmluZyBk
aWZmZXJlbnQgcHJvY2Vzc2VzLg0KDQpJbiBtb3JlLCB0byBiZSBhYmxlIHRvIGRvIGNvbmN1
cnJlbnQgZW11bGF0aW9ucywgdGhlcmUgYXJlIG11Y2ggbW9yZSANCnByb2JsZW1zIHRvIGJl
IHNvbHZlZC4gUUVNVSBzdGF0ZSBpcyBjb3JyZWN0bHkga2VwdCBwZXIgdGFyZ2V0LCBidXQg
YWxsIA0Kb3RoZXIgbGlicmFyaWVzIHN0YXRlcyBhcmUgc2hhcmVkLiBUaGVyZSBhcmUgdmFy
aW91cyBpc3N1ZXMgaWYgeW91IA0KbGF1bmNoIHR3byBlbXVsYXRpb25zIGF0IHRoZSBzYW1l
IHRpbWUgaW4gdHdvIHRocmVhZHM6DQotIGdsaWIgZ2xvYmFsIGNvbnRleHQNCi0gcWVtdSBj
YWxscyBleGl0IGluIG1hbnkgcGxhY2VzLCB3aGljaCBzdG9wcyB0aGUgd2hvbGUgcHJvY2Vz
cw0KLSBwcm9iYWJseSBvdGhlciB0aGluZ3MgSSBkaWRuJ3QgZXhwbG9yZQ0KDQpBdCB0aGlz
IHBvaW50LCBldmVuIHRob3VnaCBxZW11IHRhcmdldHMgY2FuIGJlIGJ1aWx0IGFzIHNoYXJl
ZCBvYmplY3RzLCANCkkgd291bGQgcmVjb21tZW5kIHRvIHVzZSBkaWZmZXJlbnQgcHJvY2Vz
c2VzLCBhbmQgaW1wbGVtZW50IHNvbWUgZm9ybSBvbiANCklQQyB0byBzeW5jaHJvbml6ZSBh
bGwgdGhpcy4NCkFub3RoZXIgcG9zc2liaWxpdHkgaXMgdG8gdHJ5IHRvIGJ1aWxkIG1hY2hp
bmVzIHdpdGhvdXQgdXNpbmcgdGhlIA0KZXhpc3RpbmcgbWFpbiwgYnV0IEknbSBub3Qgc3Vy
ZSBpdCdzIHdvcnRoIGFsbCB0aGUgaGFzc2xlLg0KDQpXaGF0IGFyZSB5b3UgdHJ5aW5nIHRv
IGFjaGlldmU/DQoNClJlZ2FyZHMsDQpQaWVycmljaw0KDQpPbiAyLzI0LzI1IDAxOjEwLCBQ
aGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gQ2MnaW5nIG91ciBtZXNvbiBleHBl
cnRzDQo+IA0KPiBPbiAyMi8yLzI1IDE0OjM2LCBTYWFuamggU2VuZ3VwdGEgd3JvdGU6DQo+
PiBIaSwNCj4+DQo+PiBJIHJlZmVycmVkIHRvIHlvdXIgbWFpbGluZyBjaGFpbnMgb24gc3Vn
Z2VzdGluZyBRRU1VIHRvIGJlIGJ1aWx0IGFzIGENCj4+IHNoYXJlZCBsaWJyYXJ5Lg0KPj4N
Cj4+ICpDaGFuZ2UgbWVzb24uYnVpbGQgdG8gYnVpbGQgUUVNVSBhcyBhIHNoYXJlZCBsaWJy
YXJ5ICh3aXRoIFBJQyBlbmFibGVkDQo+PiBmb3Igc3RhdGljIGxpYnJhcmllcykqDQo+PiAq
DQo+PiAqDQo+PiBDb3VsZCB5b3UgcGxlYXNlIHN1Z2dlc3Qgd2hhdCBleGFjdGx5IGhhcyB0
byBiZSBlbmFibGVkIGluIHRoZSBtZXNvbi5idWlsZD8NCj4+DQo+PiBJIGFtIGNvbmZ1c2Vk
IG9uIHRoYXQgZnJvbnQuDQo+Pg0KPj4gUmVnYXJkcw0KPj4gU2FhbmpoIFNlbmd1cHRhDQo+
IA0KDQo=

