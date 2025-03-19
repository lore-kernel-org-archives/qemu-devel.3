Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C19C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tux25-0006he-Dl; Wed, 19 Mar 2025 13:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tux1x-0006bl-CN
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:16:41 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tux1v-0005Hb-E9
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:16:37 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-223a7065ff8so59777145ad.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 10:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742404593; x=1743009393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i7CSFF/xP0BzrwGLI8UBRWRA07CF5/ehUxgphij7Ps4=;
 b=aKgEK9PvYQ30p2FFPZr5xu02AEBEzFfCL14XdgdXaW3fa7tjIkQIUdiL9KgtG0vito
 et7aoTORZmlaB5ZOGqiwJyjWjyOirSGnYf737SCPrsR4Q9OfjS9/BfGGxUwE2v2+Jvq8
 Zm1mejKsDgMcN+thiiY7rLKYNvBz1w47lRQLDRMt6aSa7eUJHEZhh9WuNfcSl8di2fKz
 Gr9WJyhXpsSz+ZRRpmPrJyby5rPrgeaAbLUJ8GKdeQOywamQkATFTbiRlgrDGNvuh/1O
 eJ6mlSQKdiya8sIs710gQay+GFbFXiul3tYqDCW0fYL+QjUQ9BgvURtFPXTeQ+2VLlEY
 CN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742404593; x=1743009393;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i7CSFF/xP0BzrwGLI8UBRWRA07CF5/ehUxgphij7Ps4=;
 b=QmX4eDZ9+mEetEB3J7zcPMgy0csWy++66GoUPXa7FmFKsCiuBcfHwF/Sntt3wxrCs1
 QRs3EV5GbWNXYBhDaSUPxQaMFyNpYexArKrE1MLImIs/ZLTP/mpV0m/StHJ/eD3vQ0Pn
 SDCCx5QBR/gULoI67ljwELLAXAomkQ2YML7JA+P/Q/O9HBTrohzNSKfNPRgZZOWSNE9C
 xe21cBcSDDqWv6bC+yIo8ZPhP0oArv1fiLqDcFkwf9o+6jgn/O9guHYN/rdT+w9xDk3r
 uhIj8SnN7wmFOg5+fPcw9EgjhQLMCmkWpMmWyWa4eb0Rmbed3JNlHk1XijCAngzuUlKO
 oCFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhIZJwdyqbhZf6gUD1e3bzw3oqM1c1/o15CoiwD0CPXqCEoUTNKq6ZY1+6QMJ5ozF1OxtPsVoScR9w@nongnu.org
X-Gm-Message-State: AOJu0Yx/Da34+nYKiyGUQI3GKTiTYXmFJqLfNRWwABOW8Sev5mUUKyVY
 KWq++QhAkDjoLHaArUUjl/Pxxkxb3mHaQY2z2u9yNoocGy6cLzyW9kCCECHLWcs=
X-Gm-Gg: ASbGnctZxlKl3/WkRF3OWrfiSL0ZHb55A0f9VLU0o1eCEF0gYvxOfGYLD/OA4xBt7A+
 iZ2nGD+ukPdEEYumFvH5S4GBlPAE7xArFCn8HbM/86kjWYb1Ogae3udM6TsNKiFpW2klCge3QCB
 PHLYobcm6iCHyRumEV9UJ//DrffqxhjT78aYhEB6Dut31L9SMHc7bwuF5cB1R+Gd23V4XNTxE8S
 Mqx2OLuLb61mXcVsEPKREOcoxFc/hdjC9mgZrjsQylMznEem9oapDU0DHLcvZhG5pfoPJI0hS02
 ihI2ISTSTflD1h6+Ak1fH9GJjmCQ6eaCmnpsSwTKfNerYkGBMN3PYmJE8Wix4fFQFYwb
X-Google-Smtp-Source: AGHT+IGTYC01CwE26xgaE7RDvLDwBfHM3GZP+YtD4Jlq2WIc4mcjDH5M1V7qQ/wTbn43V8XElDhG5A==
X-Received: by 2002:a05:6a00:1391:b0:736:3d7c:236c with SMTP id
 d2e1a72fcca58-7376d634a3dmr5235151b3a.14.1742404593227; 
 Wed, 19 Mar 2025 10:16:33 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea947a4sm11289148a12.70.2025.03.19.10.16.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 10:16:32 -0700 (PDT)
Message-ID: <5dd0a559-388a-46b8-9479-5fdd5a1e8f81@linaro.org>
Date: Wed, 19 Mar 2025 10:16:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/42] include/exec: Split out cpu-mmu-index.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-7-richard.henderson@linaro.org>
 <c76d7019-7087-4522-9b49-bc99fa71436f@linaro.org>
 <b039499c-4c0a-4eb1-ae74-ce1fe5386f20@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b039499c-4c0a-4eb1-ae74-ce1fe5386f20@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

T24gMy8xOC8yNSAxODoxNiwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMTgv
MjUgMTc6MDIsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzE4LzI1IDE0OjMx
LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBUaGUgaW1wbGVtZW50YXRpb24gb2Yg
Y3B1X21tdV9pbmRleCB3YXMgc3BsaXQgYmV0d2VlbiBjcHUtY29tbW9uLmgNCj4+PiBhbmQg
Y3B1LWFsbC5oLCBkZXBlbmRpbmcgb24gQ09ORklHX1VTRVJfT05MWS7CoCBXZSBhbHJlYWR5
IGhhdmUgdGhlDQo+Pj4gcGx1bWJpbmcgY29tbW9uIHRvIHVzZXIgYW5kIHN5c3RlbSBtb2Rl
LsKgIFVzaW5nIE1NVV9VU0VSX0lEWA0KPj4+IHJlcXVpcmVzIHRoZSBjcHUuaCBmb3IgYSBz
cGVjaWZpYyB0YXJnZXQsIGFuZCBzbyBpcyByZXN0cmljdGVkIHRvDQo+Pj4gd2hlbiB3ZSdy
ZSBjb21waWxpbmcgcGVyLXRhcmdldC4NCj4+Pg0KPj4NCj4+IEEgc2lkZSBxdWVzdGlvbjog
V2h5IGlzIE1NVV9VU0VSX0lEWCBkaWZmZXJlbnQgZGVwZW5kaW5nIG9uIGFyY2hpdGVjdHVy
ZT8NCj4+IEknbSB0cnlpbmcgdG8gdW5kZXJzdGFuZCB3aHkgKGFuZCBieSB3aGF0KSBwcmV2
aW91cyBpbmRleGVzIGFyZSByZXNlcnZlZCB3aGVuIE1NVV9VU0VSX0lEWA0KPj4gaXMgbm90
IHplcm8uDQo+IA0KPiBEZXBlbmRzIG9uIHRoZSB0cmFuc2xhdG9yLCBidXQgb2Z0ZW46IGNw
dV9tbXVfaW5kZXggbWF5IGJlIGVuY29kZWQgaW50byB0Yl9mbGFncywgYW5kIHRoZQ0KPiB0
cmFuc2xhdG9yICphbHNvKiB1c2VzIHRoaXMgZW5jb2RpbmcgdG8gZGV0ZXJtaW5lIHRoZSBw
cml2IHN0YXRlLiAgU28gaWYsIGluIHVzZXItb25seQ0KPiBtb2RlLCB3ZSBmYWlsIHRvIGVu
Y29kZSBNTVVfVVNFUl9JRFggaW50byB0Yl9mbGFncywgd2UnbGwgZ2V0IGluY29ycmVjdCBw
cml2IGNoZWNrcyBpbiB0aGUNCj4gdHJhbnNsYXRvciBhbmQgZmFpbCB0byByYWlzZSBTSUdJ
TEwgZm9yIHByaXZsZWRnZWQgb3BlcmF0aW9ucy4NCj4gDQo+IERlcGVuZGluZyBvbiB0aGUg
dGFyZ2V0LCB0aGUgbW11X2luZGV4IHNwYWNlIG1heSBiZSBxdWl0ZSBjb21wbGljYXRlZCwg
d2l0aCB2YXJpb3VzDQo+IG1lYW5pbmdzIGFzc2lnbmVkIHRvIHZhcmlvdXMgYml0cy4gIFRo
dXMgIjAiIG1heSBub3QgYmUgcmVhc29uYWJsZSBmb3IgTU1VX1VTRVJfSURYLg0KPiANCj4g
U2VlLCBmb3IgaW5zdGFuY2UsIGVudW0gQVJNTU1VSWR4IG9yIHBwYyBocmVnX2NvbXB1dGVf
aGZsYWdzX3ZhbHVlKCkuDQo+IChCb3RoIG9mIHdoaWNoLCBhbXVzaW5nbHksIHVzZSBNTVVf
VVNFUl9JRFggMDsgbmVpdGhlciBoZXJlIG5vciB0aGVyZS4pDQo+IA0KDQpUaGFua3MgZm9y
IHlvdXIgYW5zd2VyLg0KDQpJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5LCB0aGlzIGlzIHNp
bXBseSBhbiAoYXJiaXRyYXJ5KSBjaG9pY2UgcmVsYXRlZCANCnRvIGVhY2ggdGFyZ2V0IGFy
Y2hpdGVjdHVyZSBpbXBsZW1lbnRlZCBpbiBRRU1VLCBhbmQgaXQgZG9lcyBub3QgbWF0Y2gg
DQphbnkgcHJvcGVydHkgb2YgYSAqcmVhbCogY3B1LiBJcyB0aGF0IGNvcnJlY3Q/DQoNCklu
IG90aGVyIHdvcmRzLCBpdCBjb3VsZCBoYXZlIGJlZW4gaW1wbGVtZW50ZWQgaW4gYSB3YXkg
dGhhdCANCk1NVV9VU0VSX0lEWCBpcyB0aGUgc2FtZSBmb3IgYWxsIGFyY2gsIGJ1dCBpdCBo
YXNuJ3QgYmVlbiBkb25lIHRoaXMgd2F5LiANCklzIHRoYXQgY29ycmVjdD8NCg0KSSdtIG5v
dCBsb29raW5nIGZvciBtb2RpZnlpbmcgYW55dGhpbmcgcmVsYXRlZCB0byB0aGlzLCBqdXN0
IHdhbnQgdG8gDQptYWtlIHN1cmUgSSBnZXQgaXQgcmlnaHQuDQoNCj4gDQo+IHJ+DQoNCg==


