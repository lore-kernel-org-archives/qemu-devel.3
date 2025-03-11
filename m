Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A96C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1G2-0006a4-9t; Tue, 11 Mar 2025 11:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts1Ft-0006Wc-LV
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:10:54 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts1Fq-0003bQ-Pw
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:10:53 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2239aa5da08so91952795ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 08:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741705849; x=1742310649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cQwJl5AaMpNuj13k4T9FN6aD7KIBuzBDEK+lwo9Ext8=;
 b=Hs/3FWULmf3nvpK4aO9SN+8bhNvIE3wuBEShLkky5/mtOue2T2CFG1sKWdWRmOD2Dl
 K1aRtL8J9712CBZYpniGiDRL7YMdaPr0came2CUPagQwMOUDUY9YmjzmlIo9IXtQxLjD
 Xk3KHnlwVLkD3fkDa+1OhDm9s1sy8MuaoMgVsaR1AYQgJ3C8VA1EHEm2vUa25PiX/2EH
 X/NcsVERoh9m4NpxCn601AeDxUJ8zW+lEj7zFpsrOeV9y+kN05BY3ILHSjYBzjhCo7Y2
 6T77jLrJ0me9nt37Z+dbZRxn/pW6bi1MyFdZiZLeLPsy1lnQkRfPubKYq1On9kLKPX3O
 Zc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741705849; x=1742310649;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cQwJl5AaMpNuj13k4T9FN6aD7KIBuzBDEK+lwo9Ext8=;
 b=hE8GrcykH82Z12HMsC3HXUlzg5vZnaa622kfvmpRNCj4bBLkJSjzn+gA2AntskIeu+
 kBU1slvY4HflFosQzOcVUZCIAxAVryeF6Jz3wp+HQOAGnrS5HAtuFuQ+i97TW6GXbtVl
 iEDBso+XSzdDOmmRId0PLYw5SOvoswstZ9RePwU0IS2Pa1cv2+MhVyE2mdA/IzsqDsFu
 u1dGVaRMS7n7V09CHRTn2lbUuFv8jHqx+5ElmxKYSBm1QhuGzpjai/Np4CTVlogAFxTP
 ISm8ucbfBZK6qijLKJaIIpPiYy4x7ofxWnREKjdKMeItby+Tsj+vJeH6QvsNyLt4etP2
 OYwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV85vHWO+b/lcy4D9NVJzeRM1ceJAwILv665dOA2G0kqSGX4PkRRqxaXVOdZl3IIetvvXP3wz0XRq92@nongnu.org
X-Gm-Message-State: AOJu0YxlPdGYPfU5eOSF9mQi60z/HEWQNEoKPNUwRQwbJgs9ZobOFjgn
 pFe5Y3K5h49StB7Uops1JUM5aTx8ALjj6iatLF4lejXJZKiOSM1Nm1WnNB7+xdU=
X-Gm-Gg: ASbGnctIqetuheCcLUCDxRnOECW+6bxKIdbUiYNb8Z6e5+CODwec5a6zaS6WurKAPwN
 0luO4ZHcXB64eOp07ReFvrLM6r+XBnHIgVUkkyyiRviBNFaCCxHgAOCUy/fa4iLPkufEzeYAR90
 mAMCTYOmTsXwbNR0ZFcQzLcTss6bZdSikkPtgZQPCPeRfGXMbUME0WpqJ+OPUMNAQurFXSDL2Yv
 pK6AgHZIHnn8oo+UMSMk3WBVCiI4mdITdzAL8fERw+pXRvO6VQ5C48npACPEq87bdPHYhlccEOo
 jq0bU3W4LD0TRpGtB40j/5UyNWMHOiRhPYII1sPgStylwYe+E4b8733SXA==
X-Google-Smtp-Source: AGHT+IEITMrsbR3vHiF3IG5H7RZJtH9+eCZYnI84EngoCoPfv0vimXTB3AzAhTXNWBOwPqkcAjXLsA==
X-Received: by 2002:a05:6a20:7fa1:b0:1ee:dd60:194f with SMTP id
 adf61e73a8af0-1f544c378b7mr26705105637.26.1741705847979; 
 Tue, 11 Mar 2025 08:10:47 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28126d69bsm9585406a12.51.2025.03.11.08.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 08:10:47 -0700 (PDT)
Message-ID: <9706a688-b466-40ca-a6b8-0221b11f749c@linaro.org>
Date: Tue, 11 Mar 2025 08:10:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] exec/exec-all: remove dependency on cpu.h
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
 <20250311040838.3937136-8-pierrick.bouvier@linaro.org>
 <f0c7b0ff-a43a-4203-aba1-2e06a462771e@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <f0c7b0ff-a43a-4203-aba1-2e06a462771e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

T24gMy8xMS8yNSAwMDoyNiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDExLzMvMjUgMDU6MDgsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBSZXZpZXdlZC1i
eTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxp
bmFyby5vcmc+DQo+IA0KPiBNaXNzaW5nIHRoZSAid2h5IiBqdXN0aWZpY2F0aW9uIHdlIGNv
dWxkbid0IGRvIHRoYXQgYmVmb3JlLg0KPiANCj4+IC0tLQ0KPj4gICAgaW5jbHVkZS9leGVj
L2V4ZWMtYWxsLmggfCAxIC0NCj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9leGVjLWFsbC5oIGIvaW5jbHVk
ZS9leGVjL2V4ZWMtYWxsLmgNCj4+IGluZGV4IGRkNWM0MGYyMjMzLi4xOWIwZWRhNDRhNyAx
MDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvZXhlYy9leGVjLWFsbC5oDQo+PiArKysgYi9pbmNs
dWRlL2V4ZWMvZXhlYy1hbGwuaA0KPj4gQEAgLTIwLDcgKzIwLDYgQEANCj4+ICAgICNpZm5k
ZWYgRVhFQ19BTExfSA0KPj4gICAgI2RlZmluZSBFWEVDX0FMTF9IDQo+PiAgICANCj4+IC0j
aW5jbHVkZSAiY3B1LmgiDQo+PiAgICAjaWYgZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQ0K
Pj4gICAgI2luY2x1ZGUgImV4ZWMvY3B1X2xkc3QuaCINCj4+ICAgICNlbmRpZg0KPiANCg0K
UHJldmlvdXMgY29tbWl0IGlzIG5hbWVkOg0KY29kZWJhc2U6IHByZXBhcmUgdG8gcmVtb3Zl
IGNwdS5oIGZyb20gZXhlYy9leGVjLWFsbC5oDQpTbyBiZWZvcmUgdGhvc2UgY2hhbmdlcywg
aXQncyBub3QgcG9zc2libGUuDQoNCkkgY2FuIHJlcGVhdCB0aGF0IGhlcmUsIG9yIHNxdWFz
aCB0aGUgcGF0Y2hlcyB0b2dldGhlciwgYXMgeW91IHByZWZlci4NCg==

