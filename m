Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD21C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1Lv-0002R1-8d; Tue, 11 Mar 2025 11:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts1Lm-0002BJ-Lr
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:17:00 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts1Lj-0005nE-Q4
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:16:58 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-223fd89d036so110449955ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 08:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741706213; x=1742311013; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X8LOGG4uU8FOZpUEyBqgQ5KobC97qVpoXve38nvbWcU=;
 b=htiPoAKxSkt4bQOXQvl93QAQI8a9jXywoY+IVWv6v3V/HliZ4z0WonDSYEz2QRzD5I
 oVtvc6boOHcDKAyPBUBAOUqwVARaLZ8ug55cT0Ldqrx/fV9gt2vlADFUSaKZLydCYwpt
 Ml4O+UFlG4bAWIWsFsPbi3c5sE4gpbRVh/Q1gVkJg22t/3h/nDK4c3Ocw47nLgs2RpDM
 6eG6n2o52TVlVbsgHXzuafpzRq2eCmc4giWIT4zKoBFBAJP6KE3m5vq7ZAEXzUMRkBuv
 2iuoJ+zWwLN31OuAFCUVlk66+IF5nnGSq0Ne30RkFEQZjJw95tqIhSWex/O8b6rjOiSk
 3Ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741706213; x=1742311013;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X8LOGG4uU8FOZpUEyBqgQ5KobC97qVpoXve38nvbWcU=;
 b=Gix/i52ImW+hiK+hxezMlh31RP8hK+qCFPpC+92IxJ2Mr/8QOeAt+M9zlL9xlt9Lr0
 PbUN+2oFwlXtzBjJ6sGQMW9sQMFMRzLOtmM7i3wq0sAf24TsiPSsB0D/dOb2lhPYOF9X
 n4kBONqbmAvEM4Rr+ol2TNPsua782YBPAlC41BUyplliRPm+cOlupqOuXQBZyASUfBRk
 MHo+tROLPhCnYgVZEAbPZuturyV0buK0r2QvrCIvcsBd/tUQd8nSm7sBiHrQVdh3Yo3K
 zUopyYIKLxfMDCpoFJNU4hJ1bqMJZmApjICKdclCiaYlDXCei3k9iejxp0AG1UznEs9+
 6MWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFAyj7uGLkDhJ9S1rNceewm7BzgsoMxrzcS+494UBweTQnkq6G32sCGWgz+6L0uvhsKa9xLNrmO6d4@nongnu.org
X-Gm-Message-State: AOJu0YxdF8uNzyAI+3R5Sox6fl8DYuUhYz+cs+wlwp8RT2aImCrwZ03M
 XPoQ37xxFY1zKZsltgAUpXmOX+Np9rilLQNGxRmbXS76To1c7C/8Nr8eWQMxcfM=
X-Gm-Gg: ASbGnctbr3fFXVNh09+PsDP/Pxbbh3iK0NTe8iXf83edbzXRnIOmGSY5qfAkmg8BqIr
 IVLRULAL7B7KRhBaq+ndKoWwjpUvfq47ubQS2f5OEVaZeaSDfbiNzWY68MAPNqQSvy1s4E6D5nQ
 LaV3HRR6nC5DeVk22AicUywU3YQ5omCGGJ2KytgvzqhQF21yueKiO+T0msieBxhJmVLAvNJ1o9Q
 hQVnRm/Q9ns9mqj7WY0vqrvLt5S+/Fjx4w0M3Yha5CWLyKf2q5D8WiMby5+kxMfa5/YTGmAIrgk
 IRnJ4alMvqjSmI7qrKbNQlMuFC+2tWrAos0t+jUFi5WZW0ZO94XOfk1pDQ==
X-Google-Smtp-Source: AGHT+IEfixA7L2fnS5UNE8FbDPTHCcGVSGrEqusGAVylfXrcSrSOLbWL24c8Jlqg7HqGHL0V+epMxw==
X-Received: by 2002:a17:903:230b:b0:224:f12:3746 with SMTP id
 d9443c01a7336-22428aaeb0amr227978355ad.30.1741706213011; 
 Tue, 11 Mar 2025 08:16:53 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a68b89eesm9616262b3a.104.2025.03.11.08.16.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 08:16:52 -0700 (PDT)
Message-ID: <de156b56-4ed5-4b04-95d4-81fc2953491d@linaro.org>
Date: Tue, 11 Mar 2025 08:16:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] exec/ram_addr: call xen_hvm_modified_memory only
 if xen is enabled
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 qemu-riscv@nongnu.org, manos.pitsidianakis@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
 <20250311040838.3937136-12-pierrick.bouvier@linaro.org>
 <2aa408e2-a412-4eb6-b589-1bc2f5ac145a@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2aa408e2-a412-4eb6-b589-1bc2f5ac145a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

T24gMy8xMS8yNSAwMDoyOSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDExLzMvMjUgMDU6MDgsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBSZXZpZXdlZC1i
eTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxp
bmFyby5vcmc+DQo+IA0KPiBJIGRpZG4ndCBmb2xsb3cgdGhpcyBkaXJlY3Rpb24gYmVjYXVz
ZSBSaWNoYXJkIGhhZCBhIHByZWZlcmVuY2UNCj4gb24gcmVtb3ZpbmcgdW5uZWNlc3Nhcnkg
aW5saW5lZCBmdW5jdGlvbnM6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvOTE1MTIwNWEtMTNkMy00MDFlLWI0MDMtZjkxOTVjZGIxYTQ1QGxpbmFyby5vcmcvDQo+
IA0KDQpUaGUgcGF0Y2ggeW91IG1lbnRpb24gd2FzIG1vdmluZyBjb2RlLCB3aGljaCBjYW4g
YmUgYXJndWFibHkgZGlmZmVyZW50IA0KZnJvbSBzaW1wbHkgZWRpdGluZyBleGlzdGluZyBv
bmUuDQpUaGF0IHNhaWQsIGFuZCBldmVuIHRob3VnaCB0aGUgY29uY2VybiBpcyByZWFsLCBJ
IHdvdWxkIGFwcHJlY2lhdGUgdG8gDQprZWVwIHRoaXMgc2VyaWVzIGZvY3VzZWQgb24gYWNo
aWV2aW5nIHRoZSBnb2FsLCBhbmQgbm90IGRvaW5nIGEgcmVmYWN0b3IgDQpvZiB0aGUgaW52
b2x2ZWQgaGVhZGVycy4NCg0KPj4gLS0tDQo+PiAgICBpbmNsdWRlL2V4ZWMvcmFtX2FkZHIu
aCB8IDggKysrKysrLS0NCj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9yYW1f
YWRkci5oIGIvaW5jbHVkZS9leGVjL3JhbV9hZGRyLmgNCj4+IGluZGV4IDdjMDExZmFkZDEx
Li4wOThmY2NiNTgzNSAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvZXhlYy9yYW1fYWRkci5o
DQo+PiArKysgYi9pbmNsdWRlL2V4ZWMvcmFtX2FkZHIuaA0KPj4gQEAgLTM0Miw3ICszNDIs
OSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY3B1X3BoeXNpY2FsX21lbW9yeV9zZXRfZGlydHlf
cmFuZ2UocmFtX2FkZHJfdCBzdGFydCwNCj4+ICAgICAgICAgICAgfQ0KPj4gICAgICAgIH0N
Cj4+ICAgIA0KPj4gLSAgICB4ZW5faHZtX21vZGlmaWVkX21lbW9yeShzdGFydCwgbGVuZ3Ro
KTsNCj4+ICsgICAgaWYgKHhlbl9lbmFibGVkKCkpIHsNCj4+ICsgICAgICAgIHhlbl9odm1f
bW9kaWZpZWRfbWVtb3J5KHN0YXJ0LCBsZW5ndGgpOw0KPj4gKyAgICB9DQo+PiAgICB9DQo+
IA0KDQo=

