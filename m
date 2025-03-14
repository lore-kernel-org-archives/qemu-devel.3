Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5FDC28B2F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 21:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttCyF-0005ES-GV; Fri, 14 Mar 2025 17:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ttCyE-0005EI-8k
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 17:53:34 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ttCyC-0005x0-2E
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 17:53:33 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22398e09e39so55958215ad.3
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 14:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741989210; x=1742594010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JhcWxH4RYeajmVbf5fxie+Dl8qBNAdAaNO1V90Ie5Zc=;
 b=aT87jtP6kCJl4pxFy7D6UXXWV/Gnpp40iQRU0ZkKqiL0r1wU7K/4FoZb+6ZTVyj6fO
 zExc+ylKMNTEyGo19T3aL66f3XO0QIz4RMu9rG4nrdSWon+NcrL0Nw0d0DJaYx2CmEWw
 9pFx8qYg52L4hB3o2esq5gKyRc9VtCOY9v7WkPqB8CTyKqfR9ehKerp4+2pN8HyfbpYp
 yNSVw1uxKxfij7czNkf6Xv61wlob2ZJxLfqpPjorUg0wjZhBK6M6VB8+gnUxz0o+i/xA
 9bTFrPWnWYwN6a7Gz4zM7nwgTmJqLja9GpmtHgChbwlXHdXSSDPgOwp9GC33QyNOj9MU
 XBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741989210; x=1742594010;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JhcWxH4RYeajmVbf5fxie+Dl8qBNAdAaNO1V90Ie5Zc=;
 b=PUqjeqXaA4KoUxGj0UjJM1Qe4INzVFPR+WT4DKCmkzNAoyn9uOWLoKcNNZnfBNhDRB
 52PjRzozF4IFYshAhzt5Khq8owZICnkRiD5TdY2nx+cyY3FbXcp1+jzMfL5/ECLQliMl
 71wX00fQFs+A7BXzqoN5HKKSsIuJ6c+AGKjmEs2ONHaN0g1xWkFltWQ8GLHzs5OmxcdW
 72ZOg9pkQf35m7gsVHNplMjFxBaBY7ukKgcJwtz402l26S4S9d7F5l1poctEV6aN4m8f
 e+hiFoiZiZrqZ3stE0/kXAiiTu4y2NL/9q5MbZHgGAiFRhet20Nbk6FFnyB7p0wpyce5
 wWHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAEQczRuRv0HS88fTwe5hW17ZGM86Xup86UUwJ3bywiv1GE3HEtlJYSW2ohtUlY0Gmbkk8DxFQa3BR@nongnu.org
X-Gm-Message-State: AOJu0YzKP0bMq6XDgIGi64LpVFHXY5QLDTFkj/M5lQBuE6IqhylACqVo
 SJdi1/uVD4tskYAuVnNG785FZia2tlZ6yXPJOAE44DzoIBATyT/xDVJIgp5hR44=
X-Gm-Gg: ASbGncsr4pKWTg2xh7Eeot3N/gBPwlNo3mo4wCeC8NXki0qTsrnOd73Ptl4Winf9N1b
 eiPykR6VdBGKokqGB8EraGCw+prAC1tQ6Ktb+ZhlcIxoYUnqB/oz4e7ouC7Q5QsVN457sRrdF05
 Vj0k5srZXUaO6AzHbU/OKn8WpIGa+a06P2cnvXmTn/RmDgWPZ49K+ZtetH8M7Ogdh16OYQuOkg9
 939fmlfgSjoLQp4+v54LeOxyXZaCnVnluZUEqbVv9iU3r5IAKm6u2h9ixgcN86X4genqFwptOok
 WjD4nacouk0S5u6F7D9WVp/r1x8eqzYQxPjS1ZWbm2HLrG614F9MVCjdnySqb1JQ0tWb
X-Google-Smtp-Source: AGHT+IGeOzxOHxbkVDALlYJtnWV3IG8K4PDxhzGUiZatl/bZqWlWHQBOwJMePHnTGUVGB9Bp7fDsUA==
X-Received: by 2002:a17:903:3202:b0:220:bcc5:2845 with SMTP id
 d9443c01a7336-225e0a1854cmr50346895ad.7.1741989210080; 
 Fri, 14 Mar 2025 14:53:30 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6889eeesm33473215ad.29.2025.03.14.14.53.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 14:53:29 -0700 (PDT)
Message-ID: <a7b53ff2-dbc5-4851-803c-24565f30cb05@linaro.org>
Date: Fri, 14 Mar 2025 14:53:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: disable split_debug on Windows and on non-git
 builds
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, Konstantin Kostiuk <kkostiuk@redhat.com>
References: <20250314153824.65303-1-pbonzini@redhat.com>
 <44fc2b85-ab20-401a-9c71-54240bb1e503@linaro.org>
 <87ldt7gvr8.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87ldt7gvr8.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

T24gMy8xNC8yNSAxNDoxNCwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBPbiAz
LzE0LzI1IDA4OjM4LCBQYW9sbyBCb256aW5pIHdyb3RlOg0KPj4+IC1nc3BsaXQtZHdhcmYg
aXMgcmVwb3J0ZWQgdG8gcHJvZHVjZSBicm9rZW4gYmluYXJpZXMgb24gV2luZG93cy4NCj4+
PiBUaGUgbGlua2VyIHByb2R1Y2VzIHdhcm5pbmdzIGJ1dCBleGl0cyBzdWNjZXNzZnVsbHk6
DQo+Pj4gL3Vzci9saWIvZ2NjL3g4Nl82NC13NjQtbWluZ3czMi8xNC4yLjAvLi4vLi4vLi4v
Li4veDg2XzY0LXc2NC1taW5ndzMyL2Jpbi9sZDoNCj4+PiBxZ2EvcWVtdS1nYS5leGU6LzQ6
IHNlY3Rpb24gYmVsb3cgaW1hZ2UgYmFzZQ0KPj4+IC91c3IvbGliL2djYy94ODZfNjQtdzY0
LW1pbmd3MzIvMTQuMi4wLy4uLy4uLy4uLy4uL3g4Nl82NC13NjQtbWluZ3czMi9iaW4vbGQ6
DQo+Pj4gcWdhL3FlbXUtZ2EuZXhlOi8yNDogc2VjdGlvbiBiZWxvdyBpbWFnZSBiYXNlDQo+
Pj4gYW5kIGFzIGEgcmVzdWx0IHFlbXUtZ2EuZXhlIGZhaWxzIHRvIHN0YXJ0Lg0KPj4+IE9u
IHRvcCBvZiB0aGlzLCBhbHNvIGRpc2FibGUgLWdzcGxpdC1kd2FyZiB1bmxlc3MgYnVpbGRp
bmcgZnJvbSBnaXQuDQo+Pj4gU2ltaWxhciB0byAtV2Vycm9yLCBzcGxpdCBkZWJ1ZyBpbmZv
IGlzIHByb2JhYmx5IG5vdCB0aGUgYmVzdCBjaG9pY2UNCj4+PiBmb3IgcGVvcGxlIHRoYXQg
d2FudCB0byBidWlsZCBmb3IgaW5zdGFsbGluZy4NCj4+PiAoUmFuZG9tIHRob3VnaHRzOiB0
aGVyZSBpcyBhIHRlbnNpb24gaGVyZSBiZXR3ZWVuIGFkZGluZyBhbiBvcHRpb24NCj4+PiB0
aGF0IGlzIHVzZWZ1bCBmb3IgUUVNVSBkZXZlbG9wZXJzLCBhbmQgbWVzc2luZyB0aGluZ3Mg
dXAgZm9yIGV2ZXJ5b25lDQo+Pj4gZWxzZSBieSBkb2luZyBzb21ldGhpbmcgZGVjaWRlZGx5
IG5vbi1zdGFuZGFyZC4gIEZvciBleGFtcGxlLCBkaXN0cm9zDQo+Pj4gYXJlIHN0YXJ0aW5n
IHRvIGNyZWF0ZSBhIGZha2UgZ2l0IHJlcG9zaXRvcnkganVzdCBzbyB0aGF0IHRoZXkgY2Fu
DQo+Pj4gdXNlICJnaXQgYW0iIHRvIGFwcGx5IHBhdGNoZXM7IHdoaWxlIHNvbWUgb2YgdGhl
bSwgZm9yIGV4YW1wbGUgRmVkb3JhLA0KPj4+IGFyZSB3aXNlLCBvciBwYXJhbm9pZCwgZW5v
dWdoIHRvIHBhc3MgLS1kaXNhYmxlLVhYWCBmb3IgZXZlcnl0aGluZyBhbmQNCj4+PiB0aGVu
IHR1cm4gYmFjayBvbiB3aGF0IHRoZXkgd2FudCwgaXQgY2Fubm90IGJlIGV4cGVjdGVkIHRo
YXQgZXZlcnlvbmUNCj4+PiBkb2VzIHRoaXMuICBJdCBtYXkgYmUgc2FmZXIgdG8gbWFrZSAt
LWVuYWJsZS1zcGxpdC1kZWJ1ZyBkZWZhdWx0IG9mZg0KPj4+IGZvciBldmVyeWJvZHkgYW5k
IGFkZCBpdCBzb21ld2hlcmUgaW4gZG9jcy8uICBGb3Igbm93IEkgYW0ga2VlcGluZyBpdA0K
Pj4+IGVuYWJsZWQgYnV0IHdlIGNvdWxkIGNvbnNpZGVyIGRvaW5nIHNvbWV0aGluZyBkaWZm
ZXJlbnQgZHVyaW5nIHRoZSBoYXJkDQo+Pj4gZnJlZXplIHBlcmlvZCkuDQo+Pj4gUmVwb3J0
ZWQtYnk6IEtvbnN0YW50aW4gS29zdGl1ayA8a2tvc3RpdWtAcmVkaGF0LmNvbT4NCj4+PiBT
aWduZWQtb2ZmLWJ5OiBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPj4+
IC0tLQ0KPj4+ICAgIGNvbmZpZ3VyZSAgICAgICAgIHwgNCArKysrDQo+Pj4gICAgbWVzb25f
b3B0aW9ucy50eHQgfCAyICstDQo+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4+PiBkaWZmIC0tZ2l0IGEvY29uZmlndXJlIGIvY29u
ZmlndXJlDQo+Pj4gaW5kZXggMDJmMWRkMjMxMWYuLjlhZWNlNjdlZDA4IDEwMDc1NQ0KPj4+
IC0tLSBhL2NvbmZpZ3VyZQ0KPj4+ICsrKyBiL2NvbmZpZ3VyZQ0KPj4+IEBAIC0xODY0LDYg
KzE4NjQsMTAgQEAgaWYgdGVzdCAiJHNraXBfbWVzb24iID0gbm87IHRoZW4NCj4+PiAgICAg
ICAgICB7IHRlc3QgIiRob3N0X29zIiA9IGxpbnV4IHx8IHRlc3QgIiRob3N0X29zIiA9ICJ3
aW5kb3dzIjsgfTsgdGhlbg0KPj4+ICAgICAgICAgIGVjaG8gJ3dlcnJvciA9IHRydWUnID4+
ICRjcm9zcw0KPj4+ICAgICAgZmkNCj4+PiArICBpZiB0ZXN0IC1lICIkc291cmNlX3BhdGgv
LmdpdCIgJiYgdGVzdCAiJGhvc3Rfb3MiICE9ICJ3aW5kb3dzIjsgdGhlbg0KPj4+ICsgICAg
ICBlY2hvICdzcGxpdF9kZWJ1ZyA9IHRydWUnID4+ICRjcm9zcw0KPj4+ICsgIGZpDQo+Pj4g
Kw0KPj4+ICAgICAgZWNobyAiW3Byb2plY3Qgb3B0aW9uc10iID4+ICRjcm9zcw0KPj4+ICAg
ICAgaWYgdGVzdCAiJFNNQkQiICE9ICcnOyB0aGVuDQo+Pj4gICAgICAgIGVjaG8gInNtYmQg
PSAkKG1lc29uX3F1b3RlICIkU01CRCIpIiA+PiAkY3Jvc3MNCj4+PiBkaWZmIC0tZ2l0IGEv
bWVzb25fb3B0aW9ucy50eHQgYi9tZXNvbl9vcHRpb25zLnR4dA0KPj4+IGluZGV4IDM0MzIx
MjNmZWUyLi5mMzU0NmI5YWJjMSAxMDA2NDQNCj4+PiAtLS0gYS9tZXNvbl9vcHRpb25zLnR4
dA0KPj4+ICsrKyBiL21lc29uX29wdGlvbnMudHh0DQo+Pj4gQEAgLTM2Miw3ICszNjIsNyBA
QCBvcHRpb24oJ2RlYnVnX211dGV4JywgdHlwZTogJ2Jvb2xlYW4nLCB2YWx1ZTogZmFsc2Us
DQo+Pj4gICAgICAgICAgIGRlc2NyaXB0aW9uOiAnbXV0ZXggZGVidWdnaW5nIHN1cHBvcnQn
KQ0KPj4+ICAgIG9wdGlvbignZGVidWdfc3RhY2tfdXNhZ2UnLCB0eXBlOiAnYm9vbGVhbics
IHZhbHVlOiBmYWxzZSwNCj4+PiAgICAgICAgICAgZGVzY3JpcHRpb246ICdtZWFzdXJlIGNv
cm91dGluZSBzdGFjayB1c2FnZScpDQo+Pj4gLW9wdGlvbignc3BsaXRfZGVidWcnLCB0eXBl
OiAnYm9vbGVhbicsIHZhbHVlOiB0cnVlLA0KPj4+ICtvcHRpb24oJ3NwbGl0X2RlYnVnJywg
dHlwZTogJ2Jvb2xlYW4nLCB2YWx1ZTogZmFsc2UsDQo+Pj4gICAgICAgICAgIGRlc2NyaXB0
aW9uOiAnc3BsaXQgZGVidWcgaW5mbyBmcm9tIG9iamVjdCBmaWxlcycpDQo+Pj4gICAgb3B0
aW9uKCdxb21fY2FzdF9kZWJ1ZycsIHR5cGU6ICdib29sZWFuJywgdmFsdWU6IHRydWUsDQo+
Pj4gICAgICAgICAgIGRlc2NyaXB0aW9uOiAnY2FzdCBkZWJ1Z2dpbmcgc3VwcG9ydCcpDQo+
Pg0KPj4gVW5mb3J0dW5hdGUgY29pbmNpZGVuY2UsIHRoaXMgYXBwZWFycyBhdCB0aGUgc2Ft
ZSB0aW1lIE1TWVMyIGZpeGVkDQo+PiBzb21lIGlzc3VlIHRyaWdnZXJpbmcgYSBzZWdmYXVs
dCBbMV0uIFNvIEkgZGlkbid0IGludmVzdGlnYXRlIGZ1cnRoZXINCj4+IHRoZSBjdXJyZW50
IGlzc3VlLCB0aGlua2luZyBzb21ldGhpbmcgZWxzZSBoYXZlIGJlZW4gY2hhbmdlZCBJIGRv
bid0DQo+PiBrbm93IHdoZXJlLg0KPj4NCj4+IFdvdWxkIGJlIGJldHRlciB0byByZXZlcnQg
aXQgY29tcGxldGVseSBpbmRlZWQsIGNyZWF0aW5nIGFub3RoZXIgYnVpbGQNCj4+IGNvbmZp
Z3VyYXRpb24gaXMgbm90IHdvcnRoIHRoZSAoY2hlYXApIGRpc2sgc3RvcmFnZSBzYXZlZC4N
Cj4gDQo+IFdlbGwgd2Ugc2hvdWxkIGRpc2FibGUgZGVidWcgaW5mbyBvbiB0aGUgQ0kgYnVp
bGRzIHRoZW4uIE5vdGhpbmcgaXMgZnJlZQ0KPiBhbmQgb3VyIENJIGlzIHByZXR0eSBkYW1u
ZWQgaGVhdnkgYW5kIHRoZSBidWlsZHMgYWxsIGFkZCB1cCB3aGVuIGRlYnVnDQo+IGluZm8g
aXMgb24gYnkgZGVmYXVsdC4NCj4gDQoNCklmIHRoZSBwcm9ibGVtIGlzIHRoZSBzdG9yYWdl
IGJldHdlZW4gam9icyBvciBhcnRpZmFjdHMsIG1heWJlIGl0J3MgDQpwb3NzaWJseSB0byBz
aW1wbHkgc3RyaXAgdGhlIGJpbmFyaWVzPw0KDQo+Pg0KPj4gWzFdIGh0dHBzOi8vZ2l0aHVi
LmNvbS9tc3lzMi9NSU5HVy1wYWNrYWdlcy9pc3N1ZXMvMjM1NzcNCj4gDQoNCg==

