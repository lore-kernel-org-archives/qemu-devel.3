Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD21E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 20:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVzVf-0005pm-HL; Thu, 09 Jan 2025 15:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tVzVb-0005p3-Tt
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 15:52:03 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tVzVa-0007d0-6E
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 15:52:03 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21634338cfdso30568285ad.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 12:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736455920; x=1737060720; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ei5//36c7TifloF4iG5uACK4sgwbuElOCBJb8weLQwc=;
 b=IVNKxtjPDrhuFOTt33dELV0qyGZbO7RQ912k4WPQMyKJL38wv0IUjyXQWafrskNXUW
 Foou0ujCXCkmpv8+t/0cZQBRZSGWK575Y0lWez/TRBeZyyJip4IRtCyknbS6jvKLWJMa
 kMHV4X7B4ClhcXRhdcUJz6jgFOdZhLFl9wc2mEnNn2qM/FkckfuPP3iggt6eDbUELR9E
 PAUoiMtuxKhFVOxzhKhDTDlXaPOwuTVRQlKKSjbUNNUp5K8LksFGI1pGuIUXpgqpa3gr
 v2eIGTi7Qq9GLAzhiaSk2JZsyOiDgsh3VUnVLlRR1VkL1a4kO4ygOuWKypv89GtisEAL
 H0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736455920; x=1737060720;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ei5//36c7TifloF4iG5uACK4sgwbuElOCBJb8weLQwc=;
 b=q27i04Gv89J7rF/NBXb/h6JAgzFGHsAs7Rtb92GovelqmLod6ld5t/WHnc3xiAuGhf
 fK0mxTk+N/AgkdQ2U2CaIUyQk5s6MjVH/m/6ovtzDqMGB9ATF0ZTZOTP1AGqj70JnBPt
 gjOIpdilTUw/rfm6lXtrr/dil39wwWP0HpE3kZJzMtP4Yrk75ROEKJCfwwqN9GlUtBTy
 VnTXqlVj2OS45eyqrIw0qb7JNkk/Apga8VPOrGeCHEAjkZK/0LS9MuidK7thK+kA7m5s
 oV56OL8K8uJs9QPu+SOgEl2pnsHQgSYHmvWO/bdTcp+Uyf8rdk1IX7KuD37jgOZ68jQK
 fzkA==
X-Gm-Message-State: AOJu0Ywb3cZVC6muGGp0RiQdA0okpXwbRWxEjFSQysARoA9mfBM8Ngtb
 tCRuSX1A6QbnU6BP06dB3HOafcnV+Gl5ZplPS/nUD1p1pPs6NXnu3Q7lAgB7HFk=
X-Gm-Gg: ASbGncvptF8SJQe045PscmUh+/qzROG/BnXyJR58JhNHaN+BbLd0tZhyWhzg/wbuC/i
 hvm0dEL5iZT6cch1ghpz0pjVJs/pS7TVf6gkPO1IS8LqZgNbvx+l521V1LNw4iZxjDAyTIIt5pb
 oDGbg8QSekxVjkl7bkpI5GIldffPrSPb+2Uy7fko020I7jNpYsGFASUBHHR1ocWnJ7OPuOJlOAU
 S0WApYs3QptHe7RzzX/kNpY1hnJu4WcmyLpNG0ANpUiQglTYJsEcSZ2UE1SZYQuvl2Wyw==
X-Google-Smtp-Source: AGHT+IHBpSkC7agzMCY1KAXduz8kZtwF1VedABXWwjIZXvDf/tVcFu27qcbLjKuCrzwqhz9U0H64Jg==
X-Received: by 2002:a05:6a20:748b:b0:1e1:a932:4a40 with SMTP id
 adf61e73a8af0-1e88d0e63b3mr13900280637.4.1736455920088; 
 Thu, 09 Jan 2025 12:52:00 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d4067ee81sm217763b3a.132.2025.01.09.12.51.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 12:51:59 -0800 (PST)
Message-ID: <ed80dfb0-167d-443d-b18a-33125d1cde7e@linaro.org>
Date: Thu, 9 Jan 2025 12:51:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] Fix 32-bit build for plugins
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241217224306.2900490-1-pierrick.bouvier@linaro.org>
 <871pxc9pq6.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <871pxc9pq6.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

T24gMS85LzI1IDAzOjQ0LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4gd3JpdGVzOg0KPiANCj4+IFNpbmNl
IDkuMi4wIHJlbGVhc2UsIHdlIGFyZSBidWlsZGluZyBjb250cmliIHBsdWdpbnMgdXNpbmcg
dGhlIFFFTVUgYnVpbGQgc3lzdGVtDQo+PiAoYmVmb3JlLCBpdCB3YXMgZXh0ZXJuYWwgbWFr
ZWZpbGVzKS4gV2hlbiBidWlsZGluZyBmb3IgMzItYml0IGhvc3QgcGxhdGZvcm0sDQo+PiBz
b21lIHdhcm5pbmdzIGFyZSB0cmlnZ2VyZWQgYW5kIGJ1aWxkIGZhaWwuDQo+Pg0KPj4gVGh1
cywgYXQgdGhlIHRpbWUsIHRoZSBkZWNpc2lvbiB3YXMgdG8gbm90IGZpeCB0aG9zZSBwbHVn
aW5zLCBhbmQNCj4+IGRpc2FibGUgYnkgZGVmYXVsdCBwbHVnaW5zIGZvciAzMi1iaXQgaG9z
dCBwbGF0Zm9ybXMgKHNlZSBjZjJhNzhjYikuDQo+IA0KPiBRdWV1ZWQgdG8gcGx1Z2lucy9u
ZXh0LCB0aGFua3MuDQo+IA0KPiBBbHRob3VnaCBJIHRoaW5rIHBlb3BsZSB0cnlpbmcgdG8g
dXNlIHBsdWdpbnMgb24gMzIgYml0IHBsYXRmb3JtcyBhcmUNCj4gc3RpbGwgaW4gZm9yIGEg
YmFkIHRpbWUuDQo+IA0KDQpUaGFua3MsIGF0IGxlYXN0IGl0IHdpbGwga2VlcCBvbiBjb21w
aWxpbmcgd2FybmluZyBmcmVlIChjYXN0cyBtaWdodCANCnN0aWxsIGhpZGUgc29tZSBwcm9i
bGVtcyB0aG91Z2gpLCB3aGljaCBpcyBiZXR0ZXIgdGhhbiBub3RoaW5nLCANCmVzcGVjaWFs
bHkgd2hlbiB3ZSBpbnRyb2R1Y2UgbmV3IHBsdWdpbnMuDQo=

