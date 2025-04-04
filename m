Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31070C3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 18:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0lhz-000378-1u; Fri, 04 Apr 2025 14:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0lhr-00035d-QY
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:23:57 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0lhm-0008Jc-JS
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:23:53 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2279915e06eso24382775ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 11:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743791028; x=1744395828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k2UPCdWAkZnmHRmxp8ea3w/kzy49y+wfNIRoxLG2EVc=;
 b=y+JVEpTvFwSxdBafyXvtKzmQbOHWLGOAY/hKSXi3FpCsPlu0IaiznK/Y45q8e9i8v5
 NbNc2o+5GuENGwBuaEgmPhicJfwcV8TNUpXOj7Q/7Krd3nMvuNsp4esZHCt2A9x4I0r/
 eAo0gNrdUjUgoFlMf/CBGGRTSRuIiWUm1kRr2Yk18S4PAy998FM3uIuRz9LN5vhv8lKa
 na/dlKgp5C35ID3V4dgrD/ab1b5rI1TdIZbfvIPHmdrP6Nn3jiDlBM/6OOB8D9sMKx1i
 otU5Xv4Rqxow4G9LaAfmZrgLJP3ucNkSS7UHmO6tk1TKzHprrrPouuWVRhPzdXJsjXnK
 sdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743791028; x=1744395828;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k2UPCdWAkZnmHRmxp8ea3w/kzy49y+wfNIRoxLG2EVc=;
 b=noUmINgCvW1y/9lGHpXk8WFOdNbVS5i07D8S+7Mmc01BuAM8rzvOmqXyfb/aEc1scC
 6cq20Ik17mCeP7BPa6cqezI5CeBJ7AsJj8BPDtBBfU0IrJHd6mztoH5to9V4AYplDEFK
 BUh5Zu2BVcLRr6QnMOt269nj0es9spQC1TINuTvYBrUx5xnyrzyiBpVHtNojBoFON0kP
 kqsWDDQA5lXWGkR0NOAVia6T3SW4SQvYdBu12he9JicwxXeDJ763yqMTyDZzCQXIU4bx
 hSkoKVMvm3g9OFseuBvZbVysjKYi1lwAgBUWEsxBYY39jWmHSUMuiO7tti4DMEPWCAao
 KYIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOnhLu24drgk91J/LUphleF/lqCt2UUNhaU5Oul0gkUscrn8oGII91ZK0EAEFNjHNyQjIqVGj+0+Aw@nongnu.org
X-Gm-Message-State: AOJu0YxXUjRrN9Ziy1QFhzIIFiQg+d7EM70W0DpaqDc3cvRJh6nfz/JX
 KUvF6im83JatRSzCesUY3PY2WsL4wXd8drd3ITKR0QTIDb4C6GqL7S9+bcoqpkQ=
X-Gm-Gg: ASbGncspy+QhZ7pBZxZis+R48Oo49saOS08ye/0kSWne99WQ6pUrsoMRYfloiN8XbYj
 ceOOynmFjUIkbJdMaKaSwniooLzWDpjPfC5ndXY0KUC8qfyKijErVkEzBTFrAIlx1LLf7slGLBC
 nsIjfM8+uE9hg0keoMN1+aqiW4ZB91K3XGLPWxEfL8ov4EEQqRPdDceluRtmsQ7DDtqvCwwmHC8
 BLXQHZnwwjygd/u1P3RxvcZ9N4yG+WQHTZlOjumpo7SSTEqDEI5LeGByAyn9Bl2OkrChWB53kXz
 sEgodVUwRaZQFeRDj6TK9dqfPx30zEQPoBIFPY6niq0NydS9ZcqoV+aR9LJwfO+YvyWe
X-Google-Smtp-Source: AGHT+IFG5XxcBypw9TRWZ4uL85fLvips5NOGj3/CkTks4WQUwf1UtypqCT/W5zZ0SxBJBHhvLxgZCA==
X-Received: by 2002:a17:902:da8f:b0:21f:85d0:828 with SMTP id
 d9443c01a7336-22a8a1bb664mr54689235ad.41.1743791028352; 
 Fri, 04 Apr 2025 11:23:48 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297866efc0sm35457405ad.207.2025.04.04.11.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 11:23:47 -0700 (PDT)
Message-ID: <0e88a1ae-f9a3-4a06-9977-e5ce9b1b626e@linaro.org>
Date: Fri, 4 Apr 2025 11:23:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 27/39] system/hvf: Expose hvf_enabled() to
 common code
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-28-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403235821.9909-28-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

T24gNC8zLzI1IDE2OjU4LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gQ3Vy
cmVudGx5IGh2Zl9lbmFibGVkKCkgaXMgcmVzdHJpY3RlZCB0byB0YXJnZXQtc3BlY2lmaWMg
Y29kZS4NCj4gQnkgZGVmaW5pbmcgQ09ORklHX0hWRl9JU19QT1NTSUJMRSB3ZSBhbGxvdyBp
dHMgdXNlIGFueXdoZXJlLg0KPiANCg0KSW5zdGVhZCwgd2UgY2FuIHNpbXBseSBtYWtlIGh2
Zl9lbmFibGVkIHByZXNlbnQgZm9yIGNvbW1vbiBhbmQgdGFyZ2V0IA0Kc3BlY2lmaWMgY29k
ZSwgYW5kIGxpbmsgY29ycmVjdCBpbXBsZW1lbnRhdGlvbiwgYmFzZWQgb24gd2hhdCB3ZSBi
dWlsZC4NCg0KSSBkb24ndCB0aGluayAqX0lTX1BPU1NJQkxFIHdhcyBhIGdvb2QgaWRlYSB0
byBzdGFydCB3aXRoLg0KDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgTUFJTlRBSU5FUlMgICAgICAg
ICAgICAgfCAgMSArDQo+ICAgaW5jbHVkZS9zeXN0ZW0vaHZmLmggICAgfCAxNCArKysrKysr
KystLS0tLQ0KPiAgIGFjY2VsL3N0dWJzL2h2Zi1zdHViLmMgIHwgMTIgKysrKysrKysrKysr
DQo+ICAgYWNjZWwvc3R1YnMvbWVzb24uYnVpbGQgfCAgMSArDQo+ICAgNCBmaWxlcyBjaGFu
Z2VkLCAyMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBhY2NlbC9zdHVicy9odmYtc3R1Yi5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvTUFJ
TlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiBpbmRleCBjNzA4M2FiMWQ5My4uMDBlZjMzYmUw
ZTIgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJTDQo+
IEBAIC01MjUsNiArNTI1LDcgQEAgUjogUGhpbCBEZW5uaXMtSm9yZGFuIDxwaGlsQHBoaWxq
b3JkYW4uZXU+DQo+ICAgVzogaHR0cHM6Ly93aWtpLnFlbXUub3JnL0ZlYXR1cmVzL0hWRg0K
PiAgIFM6IE1haW50YWluZWQNCj4gICBGOiBhY2NlbC9odmYvDQo+ICtGOiBhY2NlbC9zdHVi
cy9odmYtc3R1Yi5jDQo+ICAgRjogaW5jbHVkZS9zeXN0ZW0vaHZmLmgNCj4gICBGOiBpbmNs
dWRlL3N5c3RlbS9odmZfaW50LmgNCj4gICANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvc3lz
dGVtL2h2Zi5oIGIvaW5jbHVkZS9zeXN0ZW0vaHZmLmgNCj4gaW5kZXggZDUwMDQ5ZTFhMWEu
LjdiNDVhMmUxOTg4IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3N5c3RlbS9odmYuaA0KPiAr
KysgYi9pbmNsdWRlL3N5c3RlbS9odmYuaA0KPiBAQCAtMTksMTUgKzE5LDE5IEBADQo+ICAg
I2luY2x1ZGUgInFvbS9vYmplY3QuaCINCj4gICANCj4gICAjaWZkZWYgQ09NUElMSU5HX1BF
Ul9UQVJHRVQNCj4gKyMgaWZkZWYgQ09ORklHX0hWRg0KPiArIyAgZGVmaW5lIENPTkZJR19I
VkZfSVNfUE9TU0lCTEUNCj4gKyMgZW5kaWYgLyogIUNPTkZJR19IVkYgKi8NCj4gKyNlbHNl
DQo+ICsjIGRlZmluZSBDT05GSUdfSFZGX0lTX1BPU1NJQkxFDQo+ICsjZW5kaWYgLyogQ09N
UElMSU5HX1BFUl9UQVJHRVQgKi8NCj4gICANCj4gLSNpZmRlZiBDT05GSUdfSFZGDQo+ICsj
aWZkZWYgQ09ORklHX0hWRl9JU19QT1NTSUJMRQ0KPiAgIGV4dGVybiBib29sIGh2Zl9hbGxv
d2VkOw0KPiAgICNkZWZpbmUgaHZmX2VuYWJsZWQoKSAoaHZmX2FsbG93ZWQpDQo+IC0jZWxz
ZSAvKiAhQ09ORklHX0hWRiAqLw0KPiArI2Vsc2UgLyogIUNPTkZJR19IVkZfSVNfUE9TU0lC
TEUgKi8NCj4gICAjZGVmaW5lIGh2Zl9lbmFibGVkKCkgMA0KPiAtI2VuZGlmIC8qICFDT05G
SUdfSFZGICovDQo+IC0NCj4gLSNlbmRpZiAvKiBDT01QSUxJTkdfUEVSX1RBUkdFVCAqLw0K
PiArI2VuZGlmIC8qICFDT05GSUdfSFZGX0lTX1BPU1NJQkxFICovDQo+ICAgDQo+ICAgI2Rl
ZmluZSBUWVBFX0hWRl9BQ0NFTCBBQ0NFTF9DTEFTU19OQU1FKCJodmYiKQ0KPiAgIA0KPiBk
aWZmIC0tZ2l0IGEvYWNjZWwvc3R1YnMvaHZmLXN0dWIuYyBiL2FjY2VsL3N0dWJzL2h2Zi1z
dHViLmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAuLjQy
ZWFkYzVjYTkyDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvYWNjZWwvc3R1YnMvaHZmLXN0
dWIuYw0KPiBAQCAtMCwwICsxLDEyIEBADQo+ICsvKg0KPiArICogSFZGIHN0dWJzIGZvciBR
RU1VDQo+ICsgKg0KPiArICogIENvcHlyaWdodCAoYykgTGluYXJvDQo+ICsgKg0KPiArICog
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4gKyAqLw0KPiAr
DQo+ICsjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPiArI2luY2x1ZGUgInN5c3RlbS9odmYu
aCINCj4gKw0KPiArYm9vbCBodmZfYWxsb3dlZDsNCj4gZGlmZiAtLWdpdCBhL2FjY2VsL3N0
dWJzL21lc29uLmJ1aWxkIGIvYWNjZWwvc3R1YnMvbWVzb24uYnVpbGQNCj4gaW5kZXggOTFh
MmQyMTkyNTguLjhjYTFhNDUyOWUyIDEwMDY0NA0KPiAtLS0gYS9hY2NlbC9zdHVicy9tZXNv
bi5idWlsZA0KPiArKysgYi9hY2NlbC9zdHVicy9tZXNvbi5idWlsZA0KPiBAQCAtMiw1ICsy
LDYgQEAgc3lzdGVtX3N0dWJzX3NzID0gc3Muc291cmNlX3NldCgpDQo+ICAgc3lzdGVtX3N0
dWJzX3NzLmFkZCh3aGVuOiAnQ09ORklHX1hFTicsIGlmX2ZhbHNlOiBmaWxlcygneGVuLXN0
dWIuYycpKQ0KPiAgIHN5c3RlbV9zdHVic19zcy5hZGQod2hlbjogJ0NPTkZJR19LVk0nLCBp
Zl9mYWxzZTogZmlsZXMoJ2t2bS1zdHViLmMnKSkNCj4gICBzeXN0ZW1fc3R1YnNfc3MuYWRk
KHdoZW46ICdDT05GSUdfVENHJywgaWZfZmFsc2U6IGZpbGVzKCd0Y2ctc3R1Yi5jJykpDQo+
ICtzeXN0ZW1fc3R1YnNfc3MuYWRkKHdoZW46ICdDT05GSUdfSFZGJywgaWZfZmFsc2U6IGZp
bGVzKCdodmYtc3R1Yi5jJykpDQo+ICAgDQo+ICAgc3BlY2lmaWNfc3MuYWRkX2FsbCh3aGVu
OiBbJ0NPTkZJR19TWVNURU1fT05MWSddLCBpZl90cnVlOiBzeXN0ZW1fc3R1YnNfc3MpDQoN
Cg==

