Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B2BCFA457
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 10:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3vJr-0000cA-E6; Thu, 24 Oct 2024 06:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3vJp-0000bh-H1
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 06:43:53 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3vJn-0001vW-NN
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 06:43:53 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-539f2b95775so829155e87.1
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 03:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729766629; x=1730371429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWJBtozLqy0b6lUijPgrye/KhIjejY8gVk8KjjAEgbI=;
 b=bN4uKHlunwHnys3w/ovZMlMk204q4PG0WIE+VNxenDqCkYeJdHWdTLjMsPGTvte246
 tpIf4JNWn5ukIR+dO9JTKB04K8PJmW89G+aKv+BLn/NW6mwRePe4+UGR//kweUcMfo4E
 Ngi3++5+Em4bnjcEZPAtpnuB4EPRZ3VJa6uCVg55VwI2T4MGdIMomy1YUPCxWKop/Hvq
 BbqmkU9WQmb9EiJA6ZTXC6xEYCh9VndGtlcAcg5VtbRvovDWo2OpUOq4cU44qIRc6hKP
 ktLbLBePG+1mQOeSKMx3wD9OYewElL4213g4rSZq7m7RlLRiuSmyoSXS9pqaqsHP/Tba
 J5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729766629; x=1730371429;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GWJBtozLqy0b6lUijPgrye/KhIjejY8gVk8KjjAEgbI=;
 b=ti2ruqu14WaoLrPtfwuBnA57FLhlBCrk/XtpuAVXwCmBehp1Mz5IjtRPEvQ0i3Youa
 SNekDWl5NnTw/wOpJxk1nstpIbHmFjqv7qRFK+Hm+3l6iKNBtt9dqtD2XT97ewjk8UHm
 ziMp08Oj1CKjGLtT7EK1ysvqB0sHxVqXPOYOCIOUkdVd2T3aDiP8IO2aEAh99tW9yiwR
 8YaWWMf68XwNKPwBC8/lfM/GK03VqslrnTbYiPRdfLW5fNNfyPGf3XCm9TGNc5ks1wd8
 jKBPay3MQoUSHtuwx6H+POyK11AE4rlqnlRmC4rGeqpZYfbiBCeRIDRy2N3egLB1S2nU
 jHEg==
X-Gm-Message-State: AOJu0YxA8HozaP4e4x3iQlMTIbop6ru/Iou6G+mM4AmF/MFoczEgqbog
 +uqdkv7QJXN9qeJY9KCvgPvUI165tKWcnId4fwrilrlAFLu4ElnRZuzgO8otXGs=
X-Google-Smtp-Source: AGHT+IEDg1VgFd2rMLcSzhCZxb/DD91SCgQZquUivckX53K6u/jdpCm2OeGDFEgoX4PYSEzDd1NMdg==
X-Received: by 2002:a05:6512:31d2:b0:531:8f2f:8ae7 with SMTP id
 2adb3069b0e04-53b1a341253mr4552891e87.25.1729766629367; 
 Thu, 24 Oct 2024 03:43:49 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a9157261fsm598947366b.150.2024.10.24.03.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 03:43:48 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DE04B5F786;
 Thu, 24 Oct 2024 11:43:47 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  kwolf@redhat.com,
 junjie.mao@hotmail.com,  manos.pitsidianakis@linaro.org,  Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 01/14] rust: patch bilge-impl to allow compilation
 with 1.63.0
In-Reply-To: <20241022100956.196657-2-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Tue, 22 Oct 2024 12:09:42 +0200")
References: <20241022100956.196657-1-pbonzini@redhat.com>
 <20241022100956.196657-2-pbonzini@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Thu, 24 Oct 2024 11:43:47 +0100
Message-ID: <877c9xkcgs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
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

UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4gd3JpdGVzOg0KDQo+IEFwcGx5IGEg
cGF0Y2ggdGhhdCByZW1vdmVzICJsZXQgLi4uIGVsc2UiIGNvbnN0cnVjdHMsIHJlcGxhY2luZyB0
aGVtIHdpdGgNCj4gImlmIGxldCAuLi4gZWxzZSIgb3IgImxldCAuLi4gPSBtYXRjaCAuLi4iLiAg
ImxldCAuLi4gZWxzZSIgd2FzIHN0YWJpbGl6ZWQgaW4NCj4gUnVzdCAxLjY1LjAuDQo+DQo+IFJl
dmlld2VkLWJ5OiBaaGFvIExpdSA8emhhbzEubGl1QGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT4NCg0KTXkgY29uZmlndXJlIG9u
IGEgY2xlYW4gYnVpbGQgZGlyIGJsb3dzIHVwIHdpdGg6DQoNCiAgYmlsZ2UtMC4yLXJzfCBEb3du
bG9hZGluZyBiaWxnZS1pbXBsLTAuMi1ycyBzb3VyY2UgZnJvbSBodHRwczovL2NyYXRlcy5pby9h
cGkvdjEvY3JhdGVzL2JpbGdlLWltcGwvMC4yLjAvZG93bmxvYWQNCiAgRG93bmxvYWRpbmc6IDEw
MCV84paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI
4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI
4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI
4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI
4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI
4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI4paI
4paI4paI4paI4paI4paI4paI4paI4paI4paI4paIfCAyMy45ay8yMy45ayA1LjMwTUIvcyBldGEg
MDA6MDANCiAgYmlsZ2UtMC4yLXJzfCBBcHBseWluZyBkaWZmIGZpbGUgImJpbGdlLWltcGwtMS42
My4wLnBhdGNoIg0KICBiaWxnZS0wLjItcnN8IHBhdGNoaW5nIGZpbGUgc3JjL3NoYXJlZC9kaXNj
cmltaW5hbnRfYXNzaWduZXIucnMNCiAgYmlsZ2UtMC4yLXJzfCBIdW5rICMxIEZBSUxFRCBhdCAy
NiAoZGlmZmVyZW50IGxpbmUgZW5kaW5ncykuDQogIGJpbGdlLTAuMi1yc3wgMSBvdXQgb2YgMSBo
dW5rIEZBSUxFRCAtLSBzYXZpbmcgcmVqZWN0cyB0byBmaWxlIHNyYy9zaGFyZWQvZGlzY3JpbWlu
YW50X2Fzc2lnbmVyLnJzLnJlag0KICBiaWxnZS0wLjItcnN8IHBhdGNoaW5nIGZpbGUgc3JjL3No
YXJlZC9mYWxsYmFjay5ycw0KICBiaWxnZS0wLjItcnN8IEh1bmsgIzEgRkFJTEVEIGF0IDIyIChk
aWZmZXJlbnQgbGluZSBlbmRpbmdzKS4NCiAgYmlsZ2UtMC4yLXJzfCAxIG91dCBvZiAxIGh1bmsg
RkFJTEVEIC0tIHNhdmluZyByZWplY3RzIHRvIGZpbGUgc3JjL3NoYXJlZC9mYWxsYmFjay5ycy5y
ZWoNCg0KICAuLi8uLi9zdWJwcm9qZWN0cy9iaWxnZS0wLjIuMC9tZXNvbi5idWlsZDo5OjA6IEVS
Uk9SOiBGYWlsZWQgdG8gYXBwbHkgZGlmZiBmaWxlICJiaWxnZS1pbXBsLTEuNjMuMC5wYXRjaCIN
Cg0KICBBIGZ1bGwgbG9nIGNhbiBiZSBmb3VuZCBhdCAvaG9tZS9hbGV4L2xzcmMvcWVtdS5naXQv
YnVpbGRzL3J1c3QvbWVzb24tbG9ncy9tZXNvbi1sb2cudHh0DQoNCiAgRVJST1I6IG1lc29uIHNl
dHVwIGZhaWxlZA0KDQpTbyBkbyBJIGhhdmUgc29tZSBoaWRkZW4gc3RhdGUgc29tZXdoZXJlPw0K
DQotLSANCkFsZXggQmVubsOpZQ0KVmlydHVhbGlzYXRpb24gVGVjaCBMZWFkIEAgTGluYXJvDQo=

