Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE81AC19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tngnB-0003DO-PI; Thu, 27 Feb 2025 11:31:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francescolavra.fl@gmail.com>)
 id 1tngmn-0002wh-28
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:31:02 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <francescolavra.fl@gmail.com>)
 id 1tngmf-0004vI-7a
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:30:52 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ab78e6edb99so156162566b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 08:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740673840; x=1741278640; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uO1689xvk+TlKlzBCtodcTbVEduWVyIaWUSdWM4KIzg=;
 b=cC9eM2Wep08w5KCjMCzNVq2YhABYFjFBJGT8VJAPJTbNlH1rmTcPlThfQ3HiEnyRjp
 hILBENoi6yxLoxiak3+IiPEyEn8pecGk5bZ7ghVvFXqZ9sUXcWKnyJNj4ZD7GDmcuXCn
 VEL8/Oza1ut/R73RF5JoLq/eEDUKUJhk9QXdFmPI6HT+mW3uFtr4X6EVHk25mFJqJKjF
 e3o7p++Lw62QtRZPp8kykA78ENSm0OC4w7adYp0z4VOXeUS+7s94FKsalUEQgBgKCM9F
 eQ/Gvxfe/pFEbEAkH/Db/5IPinnOZs2rTUZHyThCYqicgpxac4uLVaeyikVBDuD5jvEe
 GkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673840; x=1741278640;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uO1689xvk+TlKlzBCtodcTbVEduWVyIaWUSdWM4KIzg=;
 b=ub6whuPMto8+WZnSO8SvcVA6oywD1l7Pi8jozvY4sKWfUV6pRK2b4PmOBbOqtkBoGK
 KdeveUkD6rUq39ekpCHk560gsQ/+pxj8/tBcThav1e2wTXswbjbkLdfShOeqS7PCml1W
 0OKf3M7gCd+apRhScDKy6vJAdDNP4vYv6YZQHsI8qkcO/YtX4aIteKD8CAW2kof9NSWX
 rcRKVispT3q9QhQQ0VnM9HUW/Rfj0iB7fKIRkaBmS9BZVZpBRqhnLPJrB+Y00fFzLWWM
 Btp+kvQxYjOzl/KrcSbRAJrkdja4/ho0tG3VOjpI2XlCdSRNH2HMxFBd4QG6HsG7Sov4
 Xzrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2QvAExRWx8X64t383sAb0h5JHkofIwWrFVLr9gjOGRtmHHoZZ/FB/Q4KPJ1zxyEawxi/FNjPjYrmH@nongnu.org
X-Gm-Message-State: AOJu0YzWlcSvo9bS1p10L6SlhCbG9Wv0PHEfbaVbq/eUI2h5OSmYve5k
 0eemiwDfDmiXK0bh/nL2LXf0HEamm3qQkJoawLdpsQpkEdb70ao9
X-Gm-Gg: ASbGnctPoJHwlxDHKmvIxlJEGtwEcjG2YMUaeUPtQxExQHUIaEMFdzXyH/S+DLNIHFb
 9PGItTYDaroA6AJO9NmS3Ofy3z1vypQIKZifb/e5NpXOCezd83rLzI0iKS06IPFzZPNGAtBr42Y
 G9x1v1AM2ghcmqGEWhrX1ywfz18cHH+fs598A0IJ5FyjX4R8bBRKuYNuovsnA+zozFVuIqEi1+b
 /gK8nLAQDsoKN9o8Pw52FL9qQD93qcvv/nY6wBShE0vatjdF2xV7k68XA+IwPj51Xgg6aGncHOL
 yWhrTs/Nrr0CFz7nDlwp3eZDGToMVv/9W/sa9mQ7m2wuAQxg0pkHtmSIdfCcklUzbtr8etcn4kk
 I9RfmkUo=
X-Google-Smtp-Source: AGHT+IGzelRPWfeFipIB/F4GaEgnsqOh8sVGlh9zTp8YJ9TfIpAv4bd/zArwblq6NyDWvfMjBBuh1A==
X-Received: by 2002:a17:906:f597:b0:abe:bfdd:e68c with SMTP id
 a640c23a62f3a-abf25d94352mr9995066b.4.1740673839926; 
 Thu, 27 Feb 2025 08:30:39 -0800 (PST)
Received: from ?IPv6:2001:b07:5d29:f42d:d6d5:ac54:57ce:812a?
 ([2001:b07:5d29:f42d:d6d5:ac54:57ce:812a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c6ed6d0sm147202666b.107.2025.02.27.08.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 08:30:39 -0800 (PST)
Message-ID: <c5418f363998a7416bf3667de7a9f3536634d3ad.camel@gmail.com>
Subject: Re: [PATCH v7 28/52] i386/tdx: Wire TDX_REPORT_FATAL_ERROR with
 GuestPanic facility
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Marcelo Tosatti
 <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>,  qemu-devel@nongnu.org, kvm@vger.kernel.org
Date: Thu, 27 Feb 2025 17:30:38 +0100
In-Reply-To: <20250124132048.3229049-29-xiaoyao.li@intel.com>
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-29-xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=francescolavra.fl@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

T24gRnJpLCAyMDI1LTAxLTI0IGF0IDA4OjIwIC0wNTAwLCBYaWFveWFvIExpIHdyb3RlOgo+IGRp
ZmYgLS1naXQgYS9zeXN0ZW0vcnVuc3RhdGUuYyBiL3N5c3RlbS9ydW5zdGF0ZS5jCj4gaW5kZXgg
MjcyODAxZDMwNzY5Li5jNDI0NGM4OTE1YzYgMTAwNjQ0Cj4gLS0tIGEvc3lzdGVtL3J1bnN0YXRl
LmMKPiArKysgYi9zeXN0ZW0vcnVuc3RhdGUuYwo+IEBAIC01NjUsNiArNTY1LDYwIEBAIHN0YXRp
YyB2b2lkIHFlbXVfc3lzdGVtX3dha2V1cCh2b2lkKQo+IMKgwqDCoMKgIH0KPiDCoH0KPiDCoAo+
ICtzdGF0aWMgY2hhciAqdGR4X3BhcnNlX3BhbmljX21lc3NhZ2UoY2hhciAqbWVzc2FnZSkKPiAr
ewo+ICvCoMKgwqAgYm9vbCBwcmludGFibGUgPSBmYWxzZTsKPiArwqDCoMKgIGNoYXIgKmJ1ZiA9
IE5VTEw7Cj4gK8KgwqDCoCBpbnQgbGVuID0gMCwgaTsKPiArCj4gK8KgwqDCoCAvKgo+ICvCoMKg
wqDCoCAqIEFsdGhvdWdoIG1lc3NhZ2UgaXMgZGVmaW5lZCBhcyBhIGpzb24gc3RyaW5nLCB3ZSBz
aG91bGRuJ3QKPiArwqDCoMKgwqAgKiB1bmNvbmRpdGlvbmFsbHkgdHJlYXQgaXQgYXMgaXMgYmVj
YXVzZSB0aGUgZ3Vlc3QgZ2VuZXJhdGVkIGl0Cj4gYW5kCj4gK8KgwqDCoMKgICogaXQncyBub3Qg
bmVjZXNzYXJpbHkgdHJ1c3RhYmxlLgo+ICvCoMKgwqDCoCAqLwo+ICvCoMKgwqAgaWYgKG1lc3Nh
Z2UpIHsKPiArwqDCoMKgwqDCoMKgwqAgLyogVGhlIGNhbGxlciBndWFyYW50ZWVzIHRoZSBOVUxM
LXRlcm1pbmF0ZWQgc3RyaW5nLiAqLwo+ICvCoMKgwqDCoMKgwqDCoCBsZW4gPSBzdHJsZW4obWVz
c2FnZSk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoCBwcmludGFibGUgPSBsZW4gPiAwOwo+ICvCoMKg
wqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgbGVuOyBpKyspIHsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAoISgweDIwIDw9IG1lc3NhZ2VbaV0gJiYgbWVzc2FnZVtpXSA8PSAweDdlKSkg
ewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJpbnRhYmxlID0gZmFsc2U7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB9Cj4gK8KgwqDCoMKgwqDCoMKgIH0KPiArwqDCoMKgIH0KPiArCj4gK8KgwqDCoCBp
ZiAobGVuID09IDApIHsKPiArwqDCoMKgwqDCoMKgwqAgYnVmID0gZ19tYWxsb2MoMSk7Cj4gK8Kg
wqDCoMKgwqDCoMKgIGJ1ZlswXSA9ICdcMCc7Cj4gK8KgwqDCoCB9IGVsc2Ugewo+ICvCoMKgwqDC
oMKgwqDCoCBpZiAoIXByaW50YWJsZSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIDMg
PSBsZW5ndGggb2YgIiUwMnggIiAqLwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ1ZiA9IGdf
bWFsbG9jKGxlbiAqIDMpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkg
PCBsZW47IGkrKykgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG1lc3Nh
Z2VbaV0gPT0gJ1wwJykgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBicmVhazsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNwcmludGYoYnVmICsgMyAqIGks
ICIlMDJ4ICIsIG1lc3NhZ2VbaV0pOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoaSA+IDApIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIHJlcGxhY2Ug
dGhlIGxhc3QgJyAnKHNwYWNlKSB0byBOVUxMICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBidWZbaSAqIDMgLSAxXSA9ICdcMCc7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fSBlbHNlIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ1ZlswXSA9ICdcMCc7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ICsKPiArwqDCoMKgwqDCoMKgwqAgfSBlbHNl
IHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBidWYgPSBnX21hbGxvYyhsZW4pOwo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIG1lbWNweShidWYsIG1lc3NhZ2UsIGxlbik7CgpUaGlzIGZhaWxz
IHRvIG51bGwtdGVybWluYXRlIHRoZSBtZXNzYWdlIHN0cmluZyBpbiBidWYuCgo=


