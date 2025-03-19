Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4258DC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 20:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuzpP-0000NJ-QF; Wed, 19 Mar 2025 16:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuzp4-0000Hn-QX
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 16:15:31 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuzp2-0005Gp-Nh
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 16:15:30 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3011737dda0so87775a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 13:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742415326; x=1743020126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jjJvlOnU49s+Zbb8733WbLiCItr7uaYdoO51OudCE6k=;
 b=R5qyguWcw7hqySeqyIZQXEWWynSM9cZSI+98CQqoN5mEiru0PSsSrsdTwKMnHD0mmw
 R/UdpYrWDJPxt+Dd20sLYM2ryFAQUUKw3wZ6Vh2hahKPppn1o/Aw/YFcFirLoyF0F5zQ
 8cjNXf3MFY6tpo1oiFBDD0s9He1OmDclJ7Dni0vRICLhnDvw3MRCA3XWBzM7a/5M4qU5
 /t5QMXqUMLAK2j/6gaZOxK81e7n3vzC98AcQeRItQcyg4n4CTMlB5cGChdnBN1Ttzylv
 gKpen0LnlK5T7KS/H2CukF9L1MAfAHnvHXxNAz9VODSYDhwKDFsG6IDjPhLIxNNH0nmW
 jTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742415326; x=1743020126;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jjJvlOnU49s+Zbb8733WbLiCItr7uaYdoO51OudCE6k=;
 b=NM7sVs3HtjiCZGptvXBQPROwUJXhdcE+eTO6qAmsNo6mQEmfCdCCTEwe1ovJYzlRlh
 0jJoGQId1Kx6ye7wM5AcsqQNyAc7b1QuULsLb42tLdhsKBMfsnvsm1fBJelMVthf8Pw/
 d4SigdQNM4BEZZIonF1wa5Ng+rnccqUyavWEWK7SRNQJXa4otEpt4bxooCn92lJiyzY8
 iborNdZq3NkaACgiciqzWTpz/1txzKn6IJcEYdQZtiBSIaIQCg8o2OpDa32qsh8lmX8M
 Cp7iw14KQRjXxszRRcErYZy/HQZYsD/EYxYEDULD9Hjd0XJt5AA5t5ecn515DuQElATl
 t2YQ==
X-Gm-Message-State: AOJu0YyGgE2EkZVEMcHkl0N05dzSCWpZqD83T1fyAdhfz2xHaL2ANj50
 aB1+uypEpyDJASC0XCoVC9lG1T7rVzjqTxeEpbRKW8N6VprVSkP8jCq5JCaT5WY=
X-Gm-Gg: ASbGncsABQKZVLMn22nXANvSBrXQBQ21VH8WOq0ll6pdUJpvTwEpJ4BbKeEc8Hu3Cqd
 LoUd9FbEiP6inSNS6E7EWht3gzDy03qGAeILDWseJjptEmSjBNyv2YtosRIOUgXZLFngroGlNLh
 2vLh4VMdEtVooIhvIv38RRzVfri0s9Un1KJyh1Xrq7ZQwrPHsMHoPm213l26b8ZfnltgoSneEWM
 QZ/PsGcYiZfLGc+SxvyAkysqL7zErueVXWlNB7BuzEu9AvHCZ3uM3XA6DtIXMpsAu6T16IYUTNI
 1IJH5ZB2pRu3Si90SzREA9jjjMpU8nOOIg4SpdIui0zW/RqSrZSnWoO4/A==
X-Google-Smtp-Source: AGHT+IG/qfPdy626hThIYa/RsoZd8+ixXNZ5S+14ncTQSUR3/THRotw28A4RHNR31RiMxmmch69q8w==
X-Received: by 2002:a17:90b:1a88:b0:2ff:7331:18bc with SMTP id
 98e67ed59e1d1-301be202b7fmr5479737a91.26.1742415325934; 
 Wed, 19 Mar 2025 13:15:25 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf5b80b5sm2116351a91.38.2025.03.19.13.15.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 13:15:25 -0700 (PDT)
Message-ID: <9c48029e-1921-447e-8b38-4b171dce1210@linaro.org>
Date: Wed, 19 Mar 2025 13:15:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/18] system/xen: remove inline stubs
Content-Language: en-US
To: Anthony PERARD <anthony.perard@vates.tech>
Cc: qemu-devel@nongnu.org, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org, David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 manos.pitsidianakis@linaro.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Xu <peterx@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20250317183417.285700-1-pierrick.bouvier@linaro.org>
 <20250317183417.285700-14-pierrick.bouvier@linaro.org> <Z9rNBFsWR39czUGQ@l14>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <Z9rNBFsWR39czUGQ@l14>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

T24gMy8xOS8yNSAwNjo1NiwgQW50aG9ueSBQRVJBUkQgd3JvdGU6DQo+IE9uIE1vbiwgTWFy
IDE3LCAyMDI1IGF0IDExOjM0OjEyQU0gLTA3MDAsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6
DQo+PiBSZXZpZXdlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5h
cm8ub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBsaW5hcm8ub3JnPg0KPiANCg0KVGhpcyB3YXMgYSBiYWQgY29weS1wYXN0ZSwg
dGhhbmtzLg0KDQo+IFJldmlld2VkLWJ5OiBBbnRob255IFBFUkFSRCA8YW50aG9ueS5wZXJh
cmRAdmF0ZXMudGVjaD4NCj4gDQo+IFRoYW5rcywNCj4gDQoNCg==

