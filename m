Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DFAC54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 17:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riHYu-0005it-8j; Thu, 07 Mar 2024 12:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcello.bauer@9elements.com>)
 id 1riF2q-0007lW-8m
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:48:28 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcello.bauer@9elements.com>)
 id 1riF2o-0001Uq-4j
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 09:48:27 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d09cf00214so12381641fa.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 06:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1709822902; x=1710427702; darn=nongnu.org;
 h=cc:to:subject:from:content-language:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=F45Azcnkf9T5J3qyHkJEwFVazuDoffrbrM8DW4yD7Nw=;
 b=CwfM7iqdd//xi7Yzr9n3iBMXP7cWFctIj7wPsEFg/5TOHkfc3m2FNEBxE9+yTT3s47
 Si9WPIPGshJTeksQunZKyjKsdwSijTNe07TCkQ9CkALHAREk3j/bgXghUlzMvupcWkIQ
 vpeO0SJ4IfO1h2e6UTKZWzHPhoLkZUit4XacWd5H6cA8xinFLJGq9XGxT5Xx8zYPLcAh
 POmO+wNLehLzMfv/5xzOKBaA7207OgtBOmpa8z9MHFnyrLtGQ1dr46utOCsslmBMJ+Vm
 25VrH7tAwJS9z3sn/LtlcvxttKIiUPpUSlSW9Q9Yzdj6xTZsrUDK3g/QXyw/Ogc5ZFC/
 vIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709822902; x=1710427702;
 h=cc:to:subject:from:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F45Azcnkf9T5J3qyHkJEwFVazuDoffrbrM8DW4yD7Nw=;
 b=amVfIrc0WhIiSmxRNV4Or9QDp6FGejSGIVTlEoUDaPNsGjW0sycTr0t5RnuB1DA7KZ
 i+Rff3dwzXGSSMwlK4TuFH2qdS3y5xQiCW7EO0RogxhWHpLKSD9fCQc9fU1lxoUBcu9B
 df+yMuUjtNehv4JVG+0HaEZb8uuqho2MTnZkoopW66/JqA61CTIdongOJKCDlq6UMJq1
 e0P4Wl95jr8h543DEAUw7coSB+EprGPwi0FqYBpQqJ/9IBOt6c9A9JP6TWz43zdCZiMf
 DFATRZ5IkvfACNct3mMtfifIAz7cvcO0o3UjoTMu2cy7v8y9xvoxAUZV1bZHY1YlIueY
 y8oQ==
X-Gm-Message-State: AOJu0YwrBjji8/AFGnbfE1U1XsXzl5k25zf0Zj8qYM5K4E6C9rMHbnEm
 HykfNtO868NqW/EVVvtciAbuglbUAXtmf6jSmbuYP1XDRlq1IO5rN7BLKaxzXklU97rY97LXy5R
 m1Es=
X-Google-Smtp-Source: AGHT+IHEmX9D6grZmhFe3ci/inp0S8z/W8XMgidpn2PcglfYloBovmkCAwouW3UtBx5xlfuaN6dRiA==
X-Received: by 2002:a2e:980b:0:b0:2d4:16a5:b361 with SMTP id
 a11-20020a2e980b000000b002d416a5b361mr130575ljj.25.1709822901924; 
 Thu, 07 Mar 2024 06:48:21 -0800 (PST)
Received: from [10.130.172.188] ([185.209.196.192])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a05640243c800b00567fd12c7f8sm1388449edc.60.2024.03.07.06.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 06:48:21 -0800 (PST)
Message-ID: <83d42ca1-1656-4581-a056-bb0197c0ba09@9elements.com>
Date: Thu, 7 Mar 2024 15:48:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
Subject: KVM internal error due to non-atomic memslot updates by
 pci_update_vga()
To: qemu-devel@nongnu.org
Cc: eesposit@redhat.com, alex.williamson@redhat.com,
 richard.henderson@linaro.org, pbonzini@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, wangyanan55@huawei.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FGd46UpQusVd0SyZQ7GBARHw"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=marcello.bauer@9elements.com; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 07 Mar 2024 12:29:40 -0500
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FGd46UpQusVd0SyZQ7GBARHw
Content-Type: multipart/mixed; boundary="------------dRGrs1RY3W4Y9TyAIPjOihE0";
 protected-headers="v1"
From: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
To: qemu-devel@nongnu.org
Cc: eesposit@redhat.com, alex.williamson@redhat.com,
 richard.henderson@linaro.org, pbonzini@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, wangyanan55@huawei.com
Message-ID: <83d42ca1-1656-4581-a056-bb0197c0ba09@9elements.com>
Subject: KVM internal error due to non-atomic memslot updates by
 pci_update_vga()

--------------dRGrs1RY3W4Y9TyAIPjOihE0
Content-Type: multipart/mixed; boundary="------------qPmY5QEJL5hL8ddhON6T2xPH"

--------------qPmY5QEJL5hL8ddhON6T2xPH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

R3JlZXRpbmdzLA0KDQpJJ20gZmFjaW5nIGEgcHJvYmxlbSB3aXRoIEtWTSBtZW1zbG90IHVw
ZGF0ZXMgaW4gcGNpX3VwZGF0ZV92Z2EoKSBhbmQgDQpJJ20gbG9va2luZyBmb3IgYSBwb3Nz
aWJsZSBzb2x1dGlvbiB0byBwcmV2ZW50IHRoaXMgZXJyb3IuDQoNCkJhY2tncm91bmQ6DQpP
dmVyIHRoZSBwYXN0IGZldyB3ZWVrcywgd2UgaGF2ZSBiZWVuIGludmVzdGlnYXRpbmcgYSBi
dWcgd2hlcmUgUUVNVSANCldpbmRvd3MgMTAgVk1zIHVzaW5nIFZULWQgSW50ZWwgR1BVIHBh
c3N0aHJvdWdoIHN1ZGRlbmx5IGNyYXNoIGR1ZSB0byBhbiANCmludGVybmFsIEtWTSBlcnJv
ci4gSW4gb3JkZXIgZm9yIHRoaXMgYnVnIHRvIG9jY3VyLCBXaW5kb3dzIGlzIHNldCB0byAN
CmF1dG9tYXRpY2FsbHkgdHVybiBvZmYgdGhlIGRpc3BsYXkgd2hlbiBpZGxlLiBUaGUgcmVh
c29uIGZvciB0aGlzIGJ1ZyBpcyANCnRoYXQgdGhlIFdpbmRvd3MgSW50ZWwgR1BVIGRyaXZl
ciBkaXNhYmxlcyBWR0EgYW5kIHRoZXJlZm9yZSBkaXNhYmxlcyANCnRoZSBRRU1VIG1lbW9y
eSByZWdpb24gInZmaW8tdmdhLW1taW9AMHhhMDAwMCIuIFRoaXMgY2hhbmdlIHJlc3VsdHMg
aW4gYSANCm5vbi1hdG9taWMgS1ZNIG1lbXNsb3QgdXBkYXRlICgweDAtMHhhMDAwIC0+IDB4
MC0weGMwMDApLiBBY2Nlc3NpbmcgdGhpcyANCm1lbW9yeSBkdXJpbmcgdGhpcyBvcGVyYXRp
b24gd2lsbCBjYXVzZSBhIHBhZ2UgZmF1bHQgYW5kIHJlc3VsdCBpbiBhIA0KS1ZNX0VYSVRf
TU1JTy4gV2hpbGUgUUVNVSBjYW4gcHJvdmlkZSB0aGUgZGF0YSwgS1ZNIGlzIHJlcXVpcmVk
IHRvIA0KZW11bGF0ZSB0aGUgaW5zdHJ1Y3Rpb24sIHdoaWNoIGluIG91ciBjYXNlIGZhaWxl
ZCBkdWUgdG8gbGFjayBvZiBzdXBwb3J0IA0KZm9yIHRoZSBNT1ZTRCBpbnN0cnVjdGlvbi4g
SSdtIGN1cnJlbnRseSB3b3JraW5nIG9uIGEga3ZtIHBhdGNoIHNldCB0byANCmltcGxlbWVu
dCB0aGUgbWlzc2luZyBpbnN0cnVjdGlvbnMgb24gdGhlIGtlcm5lbCBzaWRlLiBCdXQgaXQg
d291bGQgYmUgDQpncmVhdCB0byBwcmV2ZW50IHRoaXMgcmFjZSBjb25kaXRpb24gaW4gUUVN
VSBhcyB3ZWxsLg0KDQpOb3cgdG8gbXkgZ2VuZXJhbCBxdWVzdGlvbjoNCkJlc2lkZXMgZGlz
YWJsaW5nIFZHQSwgd2hhdCBjYW4gd2UgZG8gaW4gUUVNVSB0byBhdm9pZCB0aGlzPw0KV2ls
bCB0aGUgcGF0Y2ggc2V0ICJLVk06IGFsbG93IGxpc3RlbmVyIHRvIHN0b3AgYWxsIHZjcHVz
IGJlZm9yZSIgWzFdIGJlIA0KZW5vdWdoIHRvIHByZXZlbnQgdGhpcyBidWcgb3IgYXJlIGFk
ZGl0aW9uYWwgY2hhbmdlcyBuZWVkZWQ/DQpUaGVyZSBhcmUgZXZlbiBlZmZvcnRzIHRvIGlt
cGxlbWVudCBhdG9taWMgbWVtc2xvdCB1cGRhdGVzIG9uIHRoZSBrZXJuZWwgDQpzaWRlLCBi
dXQgaXQgZG9lcyBub3QgbG9vayBsaWtlIHRoaXMgY2hhbmdlIHdpbGwgYmUgYWRvcHRlZC4g
WzJdDQoNCkFueSB0aG91Z2h0cyBhbmQgc3VnZ2VzdGlvbnMgYXJlIHdlbGNvbWUuDQoNClRo
YW5rcy4NCk1hcmNlbGxvDQotLS0NClsxXShodHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L3Byb2plY3Qva3ZtL2NvdmVyLzIwMjIxMTExMTU0NzU4LjEzNzI2NzQtMS1lZXNwb3NpdEBy
ZWRoYXQuY29tLykNClsyXShodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjIwOTA5
MTA0NTA2LjczODQ3OC0xLWVlc3Bvc2l0QHJlZGhhdC5jb20vKQ0K
--------------qPmY5QEJL5hL8ddhON6T2xPH
Content-Type: application/pgp-keys; name="OpenPGP_0xE54B6622A5EDBF61.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE54B6622A5EDBF61.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D=3D
=3DGQYi
-----END PGP PUBLIC KEY BLOCK-----

--------------qPmY5QEJL5hL8ddhON6T2xPH--

--------------dRGrs1RY3W4Y9TyAIPjOihE0--

--------------FGd46UpQusVd0SyZQ7GBARHw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEB0muAN3elg6p6gWSpVqlh6ibFBIFAmXp07AACgkQpVqlh6ib
FBJy5BAAySrzPPsuKb2quhvj06fYbJoBADd2oG9G9fQepxSY9EEzkOW6EHsLYoRR
bMicRtEB04hRCD3pBzBmCHhVomVvDbjxWLAOYAYJGRqaRrI9Y4DkrOgQO+yJrYx0
pNueqVpVueOq3ormYxhhXDg/mu3kZ4mybLpJDBaZEKISaFH+s1y4u0ZJl5crze4G
h3JSL5/cxY3v/8OaNJmvPvMj68SDvau+9KOcR95aMovrwTIQ4Uxff6Iu+4UiGB8Z
ZQdU+lYQ5mKxIewjKbI3+m5EloUNs8LKXbD3F0/+XMONfxtaaqMkvba97DEQ9Mgh
QSBGt/GVupCK0PlR+tBlj3R+RCw3jXgy+TBTExeCTfDpczmFYWqbK8UAPzdv4GJp
xEURyXp82S2kCNmRidKFsu3FLLI+AgL8cUr1PZ2mZq3qVMR7i2B1kMo3kuhBSSSm
Eeo2AIzETUA176T+UW2QCPi/R/4y2xIlhR7OgaPXXwgVLEAtiqW0XLRpLlui3akZ
tZGbo2ZRLDaWyL3GkOIWcZqea9K9hYvd9YqfvllAbwkH3QdKMyu0+zP6C8LzdYMk
OypThIshP4U4PuN/npvbSswuQ/n2Uh/o2DwHIuX47iryjRZ7vGXu4sD0CNQ2huz5
zUJVOpOBvdNT2KtB7xyM+p65ZVoXDwvNCCBB62lpg3jCdXbf3Gw=
=HmUM
-----END PGP SIGNATURE-----

--------------FGd46UpQusVd0SyZQ7GBARHw--

