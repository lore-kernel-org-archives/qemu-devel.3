Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F15EC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 17:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgEL-0005S5-OJ; Fri, 21 Mar 2025 13:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvgEK-0005Rn-2j
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 13:32:24 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvgEI-0001p4-CV
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 13:32:23 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22398e09e39so48997145ad.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 10:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742578341; x=1743183141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=khs57nOzMjRHqIeP3VPq1TaCBsNPRN9RxtxEZHHr/pQ=;
 b=BCjG243EZUHwwgOWWdrw2WjnKBuNSVEZVokJIMU2WrxiiFqOVwYHCCbekg+F/29Y+M
 NgM3RgZuPzyxDqUubhDIZTX3daVrPYJQSa1NgwGYTXd55Kksn2BWHtd2N+4+AiZaqwyz
 jHtybANft9+8VKQ/xrJ8QU9EtQ9sy9DTt33xl3P0Wz4s+Rs7pik/trOgPKnORG1cNWXF
 r/Phc39TG6cl/bGFI+T9KooWmkkawP6sQcTjJSC/tlyVlA5sN4AS1Vcct1UXML0TgxUY
 G19lHgSZy1iMZv5gI3oXIAkMpeUa5JFStXMeKnBjr1/ztNpCPI3ApcR/mgpEBnri00Vv
 6lrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742578341; x=1743183141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=khs57nOzMjRHqIeP3VPq1TaCBsNPRN9RxtxEZHHr/pQ=;
 b=j04EDb4k4sulHog1XBjwggi+s+LVbukY0FArXDlBVJju0b69+FxfiHdQAqKuPqSErv
 vVlZ4r9JR3tvg+o5L+wWraT83dbcUd48UnsOU3SLI9qcZphO1GWtd3AVGsW85Oj75Y5O
 Ih4QuSJfWfWVFBKEgpqJPhfY38Yvc2ZsTyzvDNQOOYzCZqEUAPZ76i5z25hDkt7q6PjS
 sQRl3ttBYM9NFgu6FJe876ZIsZZ3gHDjJ9DIE00ghD4Yav/m2yisH8FGeYKw8d4jshC9
 5zwGRlq6om/0aVxckKGoqETz2jvExduutKuEOklMwSEhw5dKggx7QcpsXI4Cjp9Zq+/5
 O+yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkSKsbmn1l4dAhteskUblws4bbB5n+vIvhYPd+7uikRwD+c9OODoSMcd7I4CgnhbD3TlhvALW2jd6Z@nongnu.org
X-Gm-Message-State: AOJu0YwNb7djEEdZ4nivmbLtE1JQxflMEdObOM5LIIoAKIulziA6je+W
 4uB0tcOIAw1R/Owe+RuogcloXV9UMm5gVgcebjjVboAaWl6jwJnH4sRVn9U2TWc=
X-Gm-Gg: ASbGnctjFeLTZKEKXMvPC3wf0VambmpErlPo3/QJ1FWunMNaF6YTxjWq5RDv/MbMJbX
 eh9Zw61Yt6G5Yg5oOWVB9POMKd4qDvPPHKqD8UhnKex9YeihOQ7ZfdjNfrJBNgsvjsHYXtIbIzX
 YVyb5JoCMwXE5RjsKow+qTOdiaeJysY08WEHLNmVX5tFWNYX2PlkvCx7/rJlEw3h29vrMswqsSB
 UOCQVG2vIAVp2RiQeperjLRNj2/9691WfU/QIbUubWOu038BDho9kYVb08hv5+KwFfcq/smaq03
 qvzBBfgI34yPUYyr9jbCTHtDNelE3ZQSTFKbYGYrQ736jHfNWG0OSEjpX6J5n0cywSn/cA==
X-Google-Smtp-Source: AGHT+IH1tkkpaejhzOBNNp0bBsUs1L6HGwZRM/BYr36y8+0Fl3F66Cmy4k8tf91/K2C1EFcogwR7Vg==
X-Received: by 2002:a05:6a20:7346:b0:1f3:33bf:6640 with SMTP id
 adf61e73a8af0-1fe42f2dd67mr6399987637.18.1742578341010; 
 Fri, 21 Mar 2025 10:32:21 -0700 (PDT)
Received: from [172.16.224.217] ([209.53.90.26])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a280ed02sm1778540a12.31.2025.03.21.10.32.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 10:32:20 -0700 (PDT)
Message-ID: <c3807789-39f3-4108-8b3a-607834c6fa28@linaro.org>
Date: Fri, 21 Mar 2025 10:32:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 1/4] target/riscv: Restrict RV128 MTTCG check on
 system emulation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250321155925.96626-1-philmd@linaro.org>
 <20250321155925.96626-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250321155925.96626-2-philmd@linaro.org>
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

T24gMy8yMS8yNSAwODo1OSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE11
bHRpLXRocmVhZGVkIFRDRyBvbmx5IGNvbmNlcm5zIHN5c3RlbSBlbXVsYXRpb24uDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFy
by5vcmc+DQo+IC0tLQ0KPiAgIHRhcmdldC9yaXNjdi90Y2cvdGNnLWNwdS5jIHwgMiArLQ0K
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvdGNnLWNwdS5jIGIvdGFyZ2V0L3Jp
c2N2L3RjZy90Y2ctY3B1LmMNCj4gaW5kZXggZmI5MDM5OTJmYWEuLjYwYTI2YWNjNTAzIDEw
MDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL3RjZy1jcHUuYw0KPiArKysgYi90YXJn
ZXQvcmlzY3YvdGNnL3RjZy1jcHUuYw0KPiBAQCAtMTA1MCw2ICsxMDUwLDcgQEAgc3RhdGlj
IGJvb2wgcmlzY3ZfdGNnX2NwdV9yZWFsaXplKENQVVN0YXRlICpjcywgRXJyb3IgKiplcnJw
KQ0KPiAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAgICB9DQo+ICAgDQo+ICsjaWZu
ZGVmIENPTkZJR19VU0VSX09OTFkNCj4gICAgICAgaWYgKG1jYy0+bWlzYV9teGxfbWF4ID49
IE1YTF9SVjEyOCAmJiBxZW11X3RjZ19tdHRjZ19lbmFibGVkKCkpIHsNCj4gICAgICAgICAg
IC8qIE1pc3NpbmcgMTI4LWJpdCBhbGlnbmVkIGF0b21pY3MgKi8NCj4gICAgICAgICAgIGVy
cm9yX3NldGcoZXJycCwNCj4gQEAgLTEwNTgsNyArMTA1OSw2IEBAIHN0YXRpYyBib29sIHJp
c2N2X3RjZ19jcHVfcmVhbGl6ZShDUFVTdGF0ZSAqY3MsIEVycm9yICoqZXJycCkNCj4gICAg
ICAgICAgIHJldHVybiBmYWxzZTsNCj4gICAgICAgfQ0KPiAgIA0KPiAtI2lmbmRlZiBDT05G
SUdfVVNFUl9PTkxZDQo+ICAgICAgIENQVVJJU0NWU3RhdGUgKmVudiA9ICZjcHUtPmVudjsN
Cj4gICANCj4gICAgICAgdGNnX2NmbGFnc19zZXQoQ1BVKGNzKSwgQ0ZfUENSRUwpOw0KDQpS
ZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8u
b3JnPg0KDQo=

