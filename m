Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACA8C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPBm-0004AQ-S8; Sun, 23 Mar 2025 13:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twPBe-00049C-0Q
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:32:44 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twPBa-0002Et-M8
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:32:36 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2243803b776so53449755ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751147; x=1743355947; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QN0GHYm7ARKHsVaSIzGzewxESAN/2OxGoKlMgVhc8Ig=;
 b=uq130VKupXtYVKxBCKQkzCQyb4Ce8gQ0Et+4BgrWqPCyVDjiRwet7Ijt7BlYOVVBOx
 YS0gzf5oBs6gVfkA9ZQ00IECM/QU/Qlsah0bZKUM4mOkzaBn9Fqbul/YZ49t6oid4inR
 wRyww5bPU0cC7G7L+pcWvQVc6J/8j9scrrhUjxYWRPjWD8Ntk11v188Y4/TBzvwJwCcY
 w6sAL860I/2cIoqJkg0RCf/fpMCVm28yfyHCNo3ei+2BbGLS/ie/jL/j7K0GTVs6aaxA
 zM14Ai4G+bPZjFgStlZs9RGKmT24HSSxZh1XcyFghAFjJiKLHbk5KhL5nUUwr7k7mtbu
 o+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751147; x=1743355947;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QN0GHYm7ARKHsVaSIzGzewxESAN/2OxGoKlMgVhc8Ig=;
 b=DZsZqHzy0XiHoUDJLBqAyTNFupWHM00ATHSGyCv4tfFBHanuJ66a6WKjJema4WuMKC
 qvXyI6l1YKs8dvZm4sgzTpdeOgDh+NS3y6Jv6oqFG/yiZ4BvlfLN2+os0e7Alf3mXtS/
 6MA7ZwhERMcenrvKsMHdmsjjJxTOFZlR8MDk55NnYvr9wd4nBZrmRodBUfwA7T40I/zc
 mjNeaBkm6GRRp6hy7z67u7krCIWt2sD4lBiasIvciL5HDR5gbg2f2CqG/lN0hXqJaNU9
 jU3RSBeFcm0be+g0+K9DNVFboidnVLx9xRW+nAY+yYWwvrBTEzb9+u7izgBwF+zA46Hv
 YMbw==
X-Gm-Message-State: AOJu0YyExwT2iuULaE00wl5IZ8O1fvZAHeVKFEGGbgXFRAw8VqR4enEC
 7FM7ATlatwtvJmDQJHnkkaaqWPxY5K6zOjIQYHmD6HFpYgzicAS/gjsYZnHOx7U=
X-Gm-Gg: ASbGnctu/hKjIrpLJQal6375wAQvczEBbsC60tPjEK66MJ81OL3eBcn8DNxTmIdIFtO
 lWDUuKw+OP85jpYXhKPlP/XsmayXfdPDH/rlQLs+QHYMuRStnyg6k4ZCFUGE514St+POwmyOL7m
 ib5b7qQ71NipXmwdPDaGCWmZ3wCgVh738KAidiR2kO/rjljoLy1CK+S3wv4hxG0HAoEDGyrVNHX
 ICFbRAz+739CCxBRvyXamZOOQR5UetZkPhsDkl9OiTskbgsbsSUg/yzGhyF/Gbf1TW/mgu+l64A
 yxdM/+TOhnetzSCl0g11H44MDz2voQ9PJSGuWsihWTPB5N/EwKAulhFESQ==
X-Google-Smtp-Source: AGHT+IGwnwcaX2ssWP0FvqI3mw/RLSqk3B8/HVXK8zY51t0taTc5yPC+uD4q61HWQx+YrwuvWBwFzA==
X-Received: by 2002:a17:902:c411:b0:224:1ec0:8a1a with SMTP id
 d9443c01a7336-22780e1a8demr154590515ad.51.1742751147223; 
 Sun, 23 Mar 2025 10:32:27 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3030f5d4f0asm6273658a91.17.2025.03.23.10.32.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 10:32:26 -0700 (PDT)
Message-ID: <4dd676bf-3b33-42cb-8054-3e06e3ac656a@linaro.org>
Date: Sun, 23 Mar 2025 10:32:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] gdbstub: conversion to runtime endianess helpers
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <0bc36324-4fb7-41ee-a9f1-3a7de4ad7fa4@linaro.org>
 <87a59eli7m.fsf@draig.linaro.org>
 <3e1c7b60-18cf-4ca6-b853-02203954fc3a@linaro.org>
 <8b8bf1e1-ebcb-4779-ab09-c208da910630@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <8b8bf1e1-ebcb-4779-ab09-c208da910630@linaro.org>
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

T24gMy8yMy8yNSAwODo0MSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDIxLzMvMjUgMTg6MzEsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pg0KPj4gQWRkaW5n
IHByb3BlciBmdW5jdGlvbnMgZGVmaW5pdGlvbiBpbnN0ZWFkIG9mIG1hY3JvcywgYW5kIGVs
aW1pbmF0aW5nDQo+PiBpZmRlZnMgaXMgbm90IHJlYWxseSBib2lsZXJwbGF0ZS4NCj4gDQo+
IEluIGFub3RoZXIgdGhyZWFkIFJpY2hhcmQgc2FpZCBmb3IgdGhlc2UgY2FzZXMgd2Ugc2hv
dWxkIHVzZSBfR2VuZXJpYygpDQo+IG1vcmUuDQo+IA0KDQpJIHdhcyB0aGlua2luZyBhYm91
dCBzdWdnZXN0aW5nIGl0IHdoZW4gSSBmaXJzdCBhbnN3ZXJlZCBvbiB0aGlzIHRocmVhZC4g
DQpIb3dldmVyLCBJIHJlYWxpemVkIGl0IGRvZXNuJ3QgcmVhbGx5IGhlbHAgdXMgdG93YXJk
cyBvdXIgZW5kIGdvYWwgdG8gDQp1bmlmeSB2YXJpYW50cyBvZiBhIGNvbXBpbGF0aW9uIHVu
aXQuDQoNCl9HZW5lcmljIGlzIGp1c3QgYSB3YXkgdG8gaGF2ZSBhIGNvbXBpbGUgdGltZQ0K
c3dpdGNoKHR5cGVvZih4KSkgew0KICAgY2FzZSB0eXBlX2E6IC4uLg0KICAgY2FzZSB0eXBl
X2I6IC4uLg0KfQ0KDQpUaGlzIGlzLCBpbiBzb21lIHdheXMsIHdoYXQgb3VyIGV4aXN0aW5n
IG1hY3JvcyBkbyBoZXJlLCBiYXNlZCBvbiANClRBUkdFVF9MT05HX0JJVFMuIFNvbWUgQyBj
b21waWxlcnMgdGFyZ2V0dGluZyBlbWJlZGRlZCBzeXN0ZW1zIHN1cHBvcnQgDQpzaXplb2Yg
b24gaW50ZWdyYWwgdHlwZXMgaW4gdGhlIHByZXByb2Nlc3NvciB0byBzdXBwb3J0IHRoaXMg
a2luZCBvZiANCmNhc2UgYmVmb3JlIF9HZW5lcmljIGV4aXN0ZWQuDQoNCkl0IGNhbiByZXBs
YWNlIG1hY3JvcyBiYXNlZCBvbiBzdGF0aWMgdHlwZXMsIGJ1dCBpdCBkb2Vzbid0IG1ha2Ug
bXVjaCANCm1vcmUgdG93YXJkcyBlbGltaW5hdGluZyB0YXJnZXQgdHlwZSBkZXBlbmRlbmN5
Lg0KDQpJdCBjb3VsZCBzdGlsbCBiZSB1c2VkIGhlcmUgdGhvdWdoLCB0byBhdm9pZCB0aGUg
bmVlZCB0byBwYXRjaCBhbGwgDQp0YXJnZXRzIHVzaW5nIGdkYiByZWdpc3RlciBtYWNyb3Ms
IHRoYXQgYWxyZWFkeSB1c2VkIGZpeGVkIHR5cGVzLg0KDQpCdXQgc2luY2Ugb3VyIGxpc3Qg
b2YgY2FsbCBzaXRlcyBpcyBub3Qgc28gaHVnZSwgSSB3b3VsZCBiZSBpbiBmYXZvciB0byAN
CmZpeCB0aGUgY29kZSBkaXJlY3RseSwgaW5zdGVhZCBvZiByZWx5aW5nIG9uIF9HZW5lcmlj
LiBCdXQgSSdtIG9wZW4gdG8gDQp0aGF0IGlmIHdlIGNvbGxlY3RpdmVseSB0aGluayBpdCdz
IGEgYmV0dGVyIHdheS4NCg0KPj4gQWRkaW5nIGNhc3RzIHRvIGxvb3NlbiB0eXBlIHN5c3Rl
bSBpcyBub3QgYSB3aW4gdmVyc3VzIHRoYXQuDQo+IA0KPiBBZ3JlZWQuDQoNCg==

