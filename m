Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE90D30016
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 15:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oqy-0004zI-NE; Fri, 18 Oct 2024 11:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1oqw-0004yl-JG
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:25:22 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1oqu-0007ct-K7
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:25:22 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2fb584a8f81so27219031fa.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729265119; x=1729869919; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQTsppqQg8l9iM4w+0DERoHy56Ihw+GYNagsipVysbk=;
 b=riwekbz7As76Wo4PwP2KZsEpPOYm1XhwlOsawGyCjsUKgSQp3GGIq21Pe54uxzq7fP
 A4/YIge/2bLaJY3Rk2txQQjeIndY/YB9fc2fMmlwU3zFCjYyyBQZD1qNRRfuYj3eFZzD
 7VBqdKjK4BHdoGCgPR7+uJEU/qBMk5p7Kfi2beMi2C2JecRZrsHjemIwHzTK8ig+/SzU
 qPe0ifeQXfvAYx7o7cVS7296N0H1gseN0kcbjLmNf7e+5E6CTkaHnTgIjE714dd9MZvW
 XPdAZlGuH8aaJaPmmeperxsnKE8V2xIzp9t810wktVsZLAU6We56zC31fz9xlJcSZLvf
 CNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729265119; x=1729869919;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQTsppqQg8l9iM4w+0DERoHy56Ihw+GYNagsipVysbk=;
 b=VcjY3fI2yRXqlH9NHFF1skFL2D2NiJsMB0Dn4xwZi00baKo9vbA9y3u/CV+C7Js+Rn
 xdA6GOsTkSDZQqn7hfXZGXkMvcrMWQQipWLY3FShyQ/0x1aXkYty9TDcSqJ3cyg54yH0
 BfQa3XSq3LXxcmu1AP7kOW8SYRlizqA5EwRo48dnNkRGoA2SjKNLyGzHfFl2xfPb3OEe
 /bCIqsVtO07AmaZLKdxPkSeY2YtuyFwt5CMOZ0wcN78WdVnXJ9haEjHsRVSveoq77/rn
 VGMHo5ge20ye1pivPirga32jy8I7fPsfzyxLgpWhOesLiasTYz5Ms8/PBPT+nXGdIvCV
 21eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTkwG8oYZTaNN3prcxm4WIw1fJkIrKEn/Z98z15wYClt9PtO1eWMhNJFsPCw/APwrEoWq24bp3Z4wY@nongnu.org
X-Gm-Message-State: AOJu0YwFYHeK7Tkl0GPQGqnQAyhAW7E/cSTa2CMis6fQjLhXoKiumWjm
 kwY+6KWiZgIbJ5ZqpqEd0Uvjrfq/TGo/4Dji1xPf67BZ3Z+TynZFKFsTrO03L6opxK0sfs0XCWq
 j9fFdKZ3iHXohG4+hiyxQvosIvavLS6U9h77cRw==
X-Google-Smtp-Source: AGHT+IEamTRTBFUYUPwoPO/y8uvrMHHHCn1vQce02s3kL2+4o8ZsJySjmMeebBXJ8+OdinIj1idZT0Nueb+RVh9Fe1Q=
X-Received: by 2002:a2e:4601:0:b0:2fb:599a:a900 with SMTP id
 38308e7fff4ca-2fb82ea506cmr15566441fa.15.1729265118561; Fri, 18 Oct 2024
 08:25:18 -0700 (PDT)
MIME-Version: 1.0
References: <20241017143211.17771-1-farosas@suse.de>
 <20241017143211.17771-5-farosas@suse.de>
 <ZxEl4zYgHLoLeHCT@redhat.com> <87r08e3d74.fsf@suse.de>
 <ZxIj694WqXwwMRIY@redhat.com>
In-Reply-To: <ZxIj694WqXwwMRIY@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2024 16:25:07 +0100
Message-ID: <CAFEAcA9eFApeeLBQvFC8zPNo+Ovk5woA5HKzaQ5j3=hd-G4smw@mail.gmail.com>
Subject: Re: [PATCH 4/4] ci: Add check-migration-quick to the clang job
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

T24gRnJpLCAxOCBPY3QgMjAyNCBhdCAxMDowMSwgRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFu
Z2VAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IFRlc3QgcmVsaWFiaWxpdHkgaXMgYSBkaWZmZXJlbnQg
dGhpbmcuIElmIGEgcGFydGljdWxhciB0ZXN0IGlzDQo+IGZsYWt5LCBpdCBuZWVkcyB0byBlaXRo
ZXIgYmUgZml4ZWQgb3IgZGlzYWJsZWQuIFNwbGl0dGluZyBpbnRvDQo+IGEgZmFzdCAmIHNsb3cg
Z3JvdXBpbmcgZG9lc24ndCBhZGRyZXNzIHJlbGlhYmlsaXR5LCBqdXN0IGhpZGVzDQo+IHRoZSBw
cm9ibGVtIGZyb20gdmlldy4NCg0KT24gdGhlIHN1YmplY3Qgb2YgJ2ZsYWt5JywgaGVyZSdzIGFu
b3RoZXIgbG93LXJlcGVhdGFiaWxpdHkNCmludGVybWl0dGVudCB3aXRoIG1pZ3JhdGlvbi10ZXN0
IHRoYXQgSSBqdXN0IHJhbiBpbnRvIGluDQonbWFrZSB2bS1idWlsZC1vcGVuYnNkJzoNCg0K4pa2
ICA5Ny85MTYgL3BwYzY0L21pZ3JhdGlvbi9tdWx0aWZkL3RjcC9wbGFpbi9jYW5jZWwNCiAgICAg
ICAgICAgT0sNCuKWtiAgOTYvOTE2IC9pMzg2L21pZ3JhdGlvbi9wcmVjb3B5L3RjcC90bHMveDUw
OS9hbGxvdy1hbm9uLWNsaWVudA0KICAgICAgICAgICBPSw0K4pa2ICA5Ny85MTYgL3BwYzY0L21p
Z3JhdGlvbi9tdWx0aWZkL3RjcC9wbGFpbi96bGliIC0NCkVSUk9SOi4uL3NyYy90ZXN0cy9xdGVz
dC9taWdyYXRpb24taGVscGVycy5jOjMyMjpjaGVja19taWdyYXRpb25fc3RhdHVzOg0KYXNzZXJ0
aW9uIGZhaWxlZCAoY3VycmVudF9zdGF0dXMgIT0gImZhaWxlZCIpOiAoImZhaWxlZCIgIT0gImZh
aWxlZCIpDQpGQUlMDQrilrYgIDk3LzkxNg0KICAgICAgICAgICBFUlJPUg0K4pa2ICA5NS85MTYg
L2FhcmNoNjQvbWlncmF0aW9uL211bHRpZmQvdGNwL2NoYW5uZWxzL3BsYWluL25vbmUNCiAgICAg
ICAgICAgT0sNCiA5Ny85MTYgcWVtdTpxdGVzdCtxdGVzdC1wcGM2NCAvIHF0ZXN0LXBwYzY0L21p
Z3JhdGlvbi10ZXN0DQogICAgICAgICAgIEVSUk9SICAgICAgICAgIDEzNC4zOHMgICBraWxsZWQg
Ynkgc2lnbmFsIDYgU0lHQUJSVA0K4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCVIOKcgCAg4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCVDQpzdGRlcnI6DQp3YXJuaW5nOiBmZDogbWlncmF0aW9uIHRv
IGEgZmlsZSBpcyBkZXByZWNhdGVkLiBVc2UgZmlsZTogaW5zdGVhZC4NCndhcm5pbmc6IGZkOiBt
aWdyYXRpb24gdG8gYSBmaWxlIGlzIGRlcHJlY2F0ZWQuIFVzZSBmaWxlOiBpbnN0ZWFkLg0KKioN
CkVSUk9SOi4uL3NyYy90ZXN0cy9xdGVzdC9taWdyYXRpb24taGVscGVycy5jOjMyMjpjaGVja19t
aWdyYXRpb25fc3RhdHVzOg0KYXNzZXJ0aW9uIGZhaWxlZCAoY3VycmVudF9zdGF0dXMgIT0gImZh
aWxlZCIpOiAoImZhaWxlZCIgIT0gImZhaWxlZCIpDQpxZW11LXN5c3RlbS1wcGM2NDogRmFpbGVk
IHRvIGNvbm5lY3QgdG8gJzEyNy4wLjAuMToyNDEwOSc6IEFkZHJlc3MNCmFscmVhZHkgaW4gdXNl
DQpxZW11LXN5c3RlbS1wcGM2NDogRmFpbGVkIHRvIHBlZWsgYXQgY2hhbm5lbA0KDQoodGVzdCBw
cm9ncmFtIGV4aXRlZCB3aXRoIHN0YXR1cyBjb2RlIC02KQ0K4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV
4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCV4oCVDQoNClByb2JhYmx5IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvQ0FGRUFjQThwOUJLQ3JuOUVmRlhUcEhF
KzV3LV84emh0RV81MlNwWkx1Uy0renBGNUdnQG1haWwuZ21haWwuY29tLw0KDQppbiBhIHNsaWdo
dGx5IGRpZmZlcmVudCBmb3JtLg0KDQp0aGFua3MNCi0tIFBNTQ0K

