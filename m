Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50031C3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kZz-0003EF-KU; Fri, 04 Apr 2025 13:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZQ-0002Oq-NP
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:11:13 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZJ-0005oY-4V
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:11:05 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-af5139ad9a2so1626110a12.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743786659; x=1744391459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bLk3Lavca5OlyK2p5foHyA3r0sJ+g0KSR2zlqMzBFOI=;
 b=dgpECm4JPtIZW3xSGcAnI819CsCd3SseEtmGtuSPVqrE8UeYCBY/qgk9qOUXIrHviR
 cjSYCNLKrIxY+miS1xsCM70M0513eb0gLsCjpKa37RzhbvpRZvqVyTMayUBgyU3Hq3R9
 2OKk4ZSgxnk+TAwX1Pz0lZLVALoTGRrtk0xK8cPHRgWrTfX+UCmyG4AdNXYLTtTSaCt3
 Xdr2K0b1j0rM4O3TDlvMEbKXIbY6FTEYGfdSkpXSbpqptYYCY+sOqNUFxo35Hmur9Bsc
 mY8F5gQDE7+MSRZLvKcChAereTUlcR71QcLuBCJAEG+Nv8UvCOKoowgXRswH51j8x7G8
 Nw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743786659; x=1744391459;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bLk3Lavca5OlyK2p5foHyA3r0sJ+g0KSR2zlqMzBFOI=;
 b=SN//TOfeRiD7vIWBpqQq0dVcIPvtGnQBIXmp8xEILW5adFBOWXfl4w/EAOj0gc4S/6
 XAbeErPoXCJZXToSdTDPsIQTyHfXN5lKChfT8qHwftldPPC0lkamSFQkEX6BEVO+8eB9
 9ShICwoP5PmM4LjeoqsrvbCGqsr1eqfxESHF7MnXXW10Rd3TfIGTKcqQfdNorfVCeGJR
 +NWP0Rkia8ofIdHTkCh6IaJCTqun38GtfVbSOqgFv99JIzxhTGdX0DWGlcfJ8jNKykh1
 TU8F6O5ENV/y974Dr+vowNwHXx2rEDbv5cjDd9b65xDaXOMOI8T2VgVOonOuSOIn7mZ4
 MyXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq4ISX8kUDJ5LxsxF/CRTKACxbWK7mF3OToU3fkCSvwzatRDfVGF6tjTMFU11NzYm9t/e0nY0JR1hx@nongnu.org
X-Gm-Message-State: AOJu0YymD1ot6Jx5QHSoeXn3YIdquU+gtnR/21v4gLnKXSkaklJKVLWH
 xSL0biOQ4l4caI7nByyE7DTcTsWZ7b2O/QL+TM6jI+E0IJjg64GVI74Q9rq51uZIoOnoGxha7M9
 V
X-Gm-Gg: ASbGncvTxnJadk/oYUOSx5G+8rP81q0F2e3FZxJYISP0hXOaMy4UcVWLXX5YGTRf9cK
 sJRmy0/yGW8O9MoKOMxjgOg3QkfSkG51zmnG4ETqISMpMhieLv2PM97rNtWi/EAjtbXU8TRFRkX
 Y4dqzqBrUVk+D20dUf5j9bZtomBPbARDpYbYRDNA4cERiRrAaTW7VmplkYX5mtYQ2Koz2VA3Nzz
 030DazXDqa/M2kh44J1ye7vV7SE3gXd3SagedGP4cLdIx96C+FZMJPYrmPwarkzmWfzseP8ffxL
 ARIW/936JaSRYaDOQnTirAelUQnoVM2fY3dzRNEQuvt9R9aQH6bevqoEYseMRYXI0/bJ
X-Google-Smtp-Source: AGHT+IFstFioH72yZnzXEf6cO20S6Nppc9P2Hs/XqdnwW36gRiNkicvcH1vpqd2xllJeeU+F0T96Cg==
X-Received: by 2002:a17:90b:540f:b0:2ee:ab29:1a63 with SMTP id
 98e67ed59e1d1-306a611253fmr4547595a91.3.1743786659079; 
 Fri, 04 Apr 2025 10:10:59 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057ca498c6sm4357416a91.13.2025.04.04.10.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:10:58 -0700 (PDT)
Message-ID: <59138782-03f6-459c-ba77-1255d0305c07@linaro.org>
Date: Fri, 4 Apr 2025 09:56:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 15/19] accel: Include missing 'qemu/accel.h'
 header in accel-internal.h
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-16-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403234914.9154-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

T24gNC8zLzI1IDE2OjQ5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gSW4g
ZmlsZSBpbmNsdWRlZCBmcm9tIC4uLy4uL2FjY2VsL2FjY2VsLXRhcmdldC5jOjI5Og0KPiAu
Li8uLi9hY2NlbC9hY2NlbC1pbnRlcm5hbC5oOjEzOjMyOiBlcnJvcjogdW5rbm93biB0eXBl
IG5hbWUgJ0FjY2VsQ2xhc3MnDQo+ICAgICAxMyB8IHZvaWQgYWNjZWxfaW5pdF9vcHNfaW50
ZXJmYWNlcyhBY2NlbENsYXNzICphYyk7DQo+ICAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBeDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1
LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGFjY2VsL2FjY2VsLWlu
dGVybmFsLmggfCAyICsrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2FjY2VsL2FjY2VsLWludGVybmFsLmggYi9hY2NlbC9hY2Nl
bC1pbnRlcm5hbC5oDQo+IGluZGV4IDAzNDI2YWEyMWVlLi5kM2E0NDIyY2JmNyAxMDA2NDQN
Cj4gLS0tIGEvYWNjZWwvYWNjZWwtaW50ZXJuYWwuaA0KPiArKysgYi9hY2NlbC9hY2NlbC1p
bnRlcm5hbC5oDQo+IEBAIC0xMCw2ICsxMCw4IEBADQo+ICAgI2lmbmRlZiBBQ0NFTF9JTlRF
Uk5BTF9IDQo+ICAgI2RlZmluZSBBQ0NFTF9JTlRFUk5BTF9IDQo+ICAgDQo+ICsjaW5jbHVk
ZSAicWVtdS9hY2NlbC5oIg0KPiArDQo+ICAgdm9pZCBhY2NlbF9pbml0X29wc19pbnRlcmZh
Y2VzKEFjY2VsQ2xhc3MgKmFjKTsNCj4gICANCj4gICAjZW5kaWYgLyogQUNDRUxfU1lTVEVN
X0ggKi8NCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZp
ZXJAbGluYXJvLm9yZz4NCg0K

