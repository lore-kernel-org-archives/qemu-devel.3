Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32588C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twnY8-0001eL-V6; Mon, 24 Mar 2025 15:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnXz-0001aI-OZ
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:33:27 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnXx-00062z-KP
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:33:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227aaa82fafso37750585ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742844796; x=1743449596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FADuRUtGLKd5sUeVMt2YSVy5VQl69kAnhXYEbSw0eyg=;
 b=fztnPg4COmALugoQslguzyZhwNoYkSu7Pf6eCmsSRlDYFJ3p72qIawzmDs9UiNKmm+
 m6dQ0heAW2V7P5lsI1xIHT48fdq3Yvluw4+KBYTgjVnPIiuDiIiPnKvuLVtztoPQ0FyW
 OMug5xGi+yuu9jYafdDfYTGQX8935wSZ1R5XEsBklWW3FYsB4rfln9qoEm9VGbblW3f3
 kQRQEzZ2lSYCcxrNra0okjF2PJi+15gMMHc9iK9bryEC6LpOx8iiyo7lwfuuJTusuKxj
 w/7uGVZ6IVsyWa8SrduMWzvzbtc50/FgfEXVfKdPLmfzhpTNBtQ+peCl/m/lIDb5U8id
 1qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742844796; x=1743449596;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FADuRUtGLKd5sUeVMt2YSVy5VQl69kAnhXYEbSw0eyg=;
 b=WdL4YaeSc4/Bn9cf+Pp3eEECpMWAzyu9loEnONdMPzRJVYDl9zsL4ba14t4vWkpznF
 /WTPTPyLg7piOLBLEocjrF6GdrIq4e8LUdSmoZSH02tk091QtH+pSrSNxGKmuTfYvvS+
 zYjaHE8C8z0wYD2gKQHZgUvcGQ8+a/hbCj2gUGb3UAPHj505G4yKQeN1/wcJ6XVGqxL5
 qko15SNVUd4sVeIT8mmhAv7TfL/p6wiH+m0Vvlp9BfORPTMaXX8r8aBH34a+e16vyS/C
 ba+OtR7KRGdE47viVMj1cUGcmwXZ2sdNAQdrjR+O5KL6nwEQOyuCMImojvG10S+n1SgO
 lMzw==
X-Gm-Message-State: AOJu0YzYarxF5E7Uy5p1dAlCbie4+1acYL0a6WTIeXBWNXK6MRwrdka6
 EVOhRcMzX1Lo9pE0x7Qijw/5COJhuHcl+nWDUDR9UODFyeQd3qh7mQUszkV4s5M=
X-Gm-Gg: ASbGncuQ45l8J7s2EpUP2Xma/fESXRn0uUGIV935phDceNI+yDsOj0ZuuKkTU0whCNM
 OMqWDWNmitIdCxlUgtUy+dvW+pI6Ou5YkceMH41SVaj+qexyUkwEsUCj2ATtz9WZJPgANGlH5Fs
 45nt37BseGYujbrQsF/4CqNA5qGKfRjWaXDG9Ha9XBswOmD5w5HyY90U8PPiuGAd18m8i14ZZoI
 AQiLbCUriWBM6lFEgQKlpojN8MsEwVdRO7hZHCgHLDj5AZf8+mW9VIyGwyRw9/hrVtet4yciZic
 L3OiKwxz0YIkEZhCgXdaHRAihEG92A/EnJlfiRA0tIuqm165nCdAgTgGIA==
X-Google-Smtp-Source: AGHT+IFrQqfrRy0m/4XhYyJrZ4t7qxawSZ5CHlj/YgGqbOvgJ8kpNdq47eQCqSPaPj5jGnBRayOOEw==
X-Received: by 2002:a05:6a20:918a:b0:1f5:59e5:8adb with SMTP id
 adf61e73a8af0-1fe42c6cd8amr26029813637.0.1742844795781; 
 Mon, 24 Mar 2025 12:33:15 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a479c1sm7589585a12.70.2025.03.24.12.33.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:33:15 -0700 (PDT)
Message-ID: <afc4476e-c94a-49e3-9e8c-ca7001666bf3@linaro.org>
Date: Mon, 24 Mar 2025 12:33:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] include/gdbstub: add note to helpers.h
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-12-alex.bennee@linaro.org>
 <729ee2cc-ecaf-41d0-afbd-25f51952dbeb@linaro.org>
 <87v7ry2v84.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87v7ry2v84.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

T24gMy8yNC8yNSAxMDoyOSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBPbiAyNC8z
LzI1IDExOjIxLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+Pj4gV2UndmUgbm90IHlldCBkZXBy
ZWNhdGVkIGJ1dCB3ZSBzaG91bGQgc3RlZXIgdXNlcnMgYXdheSBmcm9tIHRoZXNlDQo+Pj4g
aGVscGVycyBpZiB0aGV5IHdhbnQgdG8gYmUgaW4gYSBzaW5nbGUvaGV0ZXJvZ2VuZW91cyBi
aW5hcnkuDQo+Pg0KPj4gV2h5IG5vdCBkZXByZWNhdGU/DQo+IA0KPiBJIGd1ZXNzIHBoaWxv
c29waGljYWxseSBkbyB3ZSBleHBlY3QgdG8gZXZlbnR1YWxseSBjb252ZXJ0IGFsbCBmcm9u
dGVuZHMNCj4gdG8gdGhlIG5ldyBBUEkgb3Igb25seSB0aG9zZSB0aGF0IHdhbnQgdG8gYmUg
aW4gdGhlIHNpbmdsZSBiaW5hcnk/DQo+IFNob3VsZCBJIGp1c3QgYmUgbW9yZSBleHBsaWNp
dDoNCj4gDQo+Pj4gICAgICoNCj4+PiAgICAgKiBUaGVzZSBhcmUgYWxsIHVzZWQgYnkgdGhl
IHZhcmlvdXMgZnJvbnRlbmRzIGFuZCBoYXZlIHRvIGJlIGhvc3QNCj4+PiAtICogYXdhcmUg
dG8gZW5zdXJlIHRoaW5ncyBhcmUgc3RvcmUgaW4gdGFyZ2V0IG9yZGVyLg0KPj4+ICsgKiBh
d2FyZSB0byBlbnN1cmUgdGhpbmdzIGFyZSBzdG9yZSBpbiB0YXJnZXQgb3JkZXIuIENvbnNp
ZGVyIHVzaW5nDQo+Pj4gKyAqIHRoZSBlbmRpYW4gbmV1dHJhbCByZWdpc3RlcnMuaCBpZiB5
b3Ugd2FudCB0aGUgYXJjaGl0ZWN0dXJlIHRvIGJlDQo+Pj4gKyAqIGluY2x1ZGVkIGluIGFu
IGV2ZW50dWFsIHNpbmdsZSBRRU1VIGJpbmFyeS4NCj4+PiAgICAgKg0KPj4+ICAgICAqIENv
cHlyaWdodCAoYykgMjAyMiBMaW5hcm8gTHRkDQo+Pj4gICAgICoNCj4gDQo+IA0KPiAgIFRo
ZXNlIGFyZSBhbGwgdXNlZCBieSB0aGUgdmFyaW91cyBmcm9udGVuZHMgYW5kIGhhdmUgdG8g
YmUgaG9zdCBhd2FyZQ0KPiAgIHRvIGVuc3VyZSB0aGluZ3MgYXJlIHN0b3JlIGluIHRhcmdl
dCBvcmRlci4NCj4gDQoNCklmIHRoZSBmaXggaXMgYW4gZWFzeSAic2VkIGxpa2UiIHdpdGgg
c3RhdGljIHR5cGluZyBndWFyYW50ZWUgKHNvIG5vIGJ1ZyANCmNhbiBiZSBpbnRyb2R1Y2Vk
KSwgd2UgY2FuIHByb2JhYmx5IGp1c3QgZG8gaXQgb24gYWxsIGV4aXN0aW5nIHRhcmdldHMs
IA0KYW5kIHJlbW92ZSB0aGlzLg0KDQpJZiBpdCdzIGhhcmQgb3IgZXJyb3IgcHJvbmUsIHRo
ZW4gSSB3b3VsZCBzYXkgaXQncyBvayB0byB1c2UgYSAib25lIA0KdGFyZ2V0IGF0IGEgdGlt
ZSIgYXBwcm9hY2guDQoNCj4gICBOZXcgZnJvbnQtZW5kcyBzaG91bGQgbm90IGJlIHVzaW5n
IHRoZXNlIEFQSXMgYXQgYWxsLiBUaGV5IHNob3VsZCBiZQ0KPiAgIHVzaW5nIHRoZSBlbmRp
YW4gbmV1dHJhbCByZWdpc3RlcnMuaCBhcyBzaG91bGQgYW55IGFyY2hpdGVjdHVyZSB0aGF0
DQo+ICAgaW50ZW5kcyB0byBiZSBpbmNsdWRlZCBpbiBhbiBldmVudHVhbCBzaW5nbGUgUUVN
VSBiaW5hcnkuDQo+IA0KDQo=

