Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D59C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 10:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkhn3-0002kU-Gs; Wed, 19 Feb 2025 05:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francescolavra.fl@gmail.com>)
 id 1tkhn1-0002kF-Ln
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 05:58:51 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <francescolavra.fl@gmail.com>)
 id 1tkhmz-0005Z9-Un
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 05:58:51 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38f378498b0so3299430f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 02:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739962728; x=1740567528; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hWa0KcU05B95Kj4EgP8ZhPIrYp6WCMUxD6IImKVDfu8=;
 b=ax9UdhB6w7tQuBlSSfOtsNucBqmzYBEaYfoas16Y5RfA4OExLf4D+v/YKSdUZrOuWL
 /FSJ3fFviGOp09Yp3Dvz0yxfC5wqK9TiowCVsOvdZx2/AMzhHD8hc86SFsP0wj+vntZb
 92L9z5bOmqHgIZLXolJBkSalkMkEPMQgAl8g/sxyzmykDOjC7+G9yEVJIMxdWBV73EH4
 qqDkj9tFjwRwQfAxZXnkBEnFZ1R9R4vu54LGQScCg7LG07gOLovV5iUAh+TkgljhwMIX
 HRXBIaWXPoZxWveBSMP0UA7gZkZ+Bo+K7D93kQj6MslBpS3ohn/NaM68FGBgy/ScFoBn
 aGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739962728; x=1740567528;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hWa0KcU05B95Kj4EgP8ZhPIrYp6WCMUxD6IImKVDfu8=;
 b=nbYAm/1YE4fzr8a3FZTy8XB1geptI8ltSE/P3bgOKj34htPgRqoxhpMxgOW6wlUn9g
 p0i0WHCcv80uTREwWiIkSTXEgeeGNE/6y/GEhEI9cxMLKG48iK+Gb0i6el4L1sAq9jeh
 gCimyxELGnPaxuKgQuK4bzqvGj0JR8GkoOeNVAUTrVt42i3v3dpHX2krF5ZwOWe+DgYP
 8yxnOSUnZBInR9b920V0eB8cnlSSc0G8uCszGBAlfqFywDr5UKCt4rCaaQ+SJ3ZxK2n/
 2zHkBHQAvcpO9t0aIxc2SiUKmZ9jq9NSfvu5Jy10g6phETMNMX7cSnCnPbrvQrICLfUU
 WNHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc8FUPUAL01uYjKoXA/dDK/wEYdBtw8Rf5tPGn63P2T3uRYz8X9anLfsZ7dboZSbY2QIDySDkMqH59@nongnu.org
X-Gm-Message-State: AOJu0YykVf/vO11MKPipGNFysVa33xqNoWJVSvVRXGwsA9c+kG2rXyiw
 PNHJi8JPJNsCnhFjhMIy/K8vrJ2bnQLxqlzWCLQrRJnkr6K2FbXN
X-Gm-Gg: ASbGncsJ6yRUC3vs+5wVqM9EKZORD2sHXmbkvPy37zA4FMH2dyWSLRa9I+dWMaiFGK5
 D+2N4yKnOA59SwSWRWKMFS4usgs1AUQIzcBg3EYiXEDsbkesgEDANwNGaME8SogbXQyUywrn9W9
 yFLp64KAn9xSZSDpBWM09AfYG9WAjv/rbrGFyd7GbQI6HeoHJ/PPOPyI1WKcc6I4X2OK82Ci0Ty
 UaZir1PmFqi1cBNoDwiPr5M7kjZkEus9cJA4PVQbyNGQk0t9zlfB9HLcqGA+ugeiRH6BFFZvWTS
 lJx2UJAgYUuRD207iSszoquUiERuwUfqupF9UYYhmQwFa44Uj1i0F0+OoUQwgK7FWb3n83ll
X-Google-Smtp-Source: AGHT+IHXKJZTfwSLoxDWU99PQefFxQjd9dujVTOF/9TaLmnFIFk3O7jX4E7v8WovkAveBu/o59Cu3A==
X-Received: by 2002:a05:6000:1a54:b0:38f:4e50:8b0b with SMTP id
 ffacd0b85a97d-38f58796ab6mr2280770f8f.31.1739962728096; 
 Wed, 19 Feb 2025 02:58:48 -0800 (PST)
Received: from ?IPv6:2001:b07:5d29:f42d:64f1:54a0:5dc5:6dd1?
 ([2001:b07:5d29:f42d:64f1:54a0:5dc5:6dd1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7979sm17280250f8f.83.2025.02.19.02.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 02:58:47 -0800 (PST)
Message-ID: <7e8ef2dc3958bf9ea68ac3feb68fc216a9107411.camel@gmail.com>
Subject: Re: [PATCH v7 16/52] i386/tdvf: Introduce function to parse TDVF
 metadata
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
Date: Wed, 19 Feb 2025 11:58:46 +0100
In-Reply-To: <20250124132048.3229049-17-xiaoyao.li@intel.com>
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-17-xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=francescolavra.fl@gmail.com; helo=mail-wr1-x429.google.com
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

T24gRnJpLCAyMDI1LTAxLTI0IGF0IDA4OjIwIC0wNTAwLCBYaWFveWFvIExpIHdyb3RlOgo+ICtp
bnQgdGR2Zl9wYXJzZV9tZXRhZGF0YShUZHhGaXJtd2FyZSAqZncsIHZvaWQgKmZsYXNoX3B0ciwg
aW50IHNpemUpCj4gK3sKPiArwqDCoMKgIGdfYXV0b2ZyZWUgVGR2ZlNlY3Rpb25FbnRyeSAqc2Vj
dGlvbnMgPSBOVUxMOwo+ICvCoMKgwqAgVGR2Zk1ldGFkYXRhICptZXRhZGF0YTsKPiArwqDCoMKg
IHNzaXplX3QgZW50cmllc19zaXplOwo+ICvCoMKgwqAgaW50IGk7Cj4gKwo+ICvCoMKgwqAgbWV0
YWRhdGEgPSB0ZHZmX2dldF9tZXRhZGF0YShmbGFzaF9wdHIsIHNpemUpOwo+ICvCoMKgwqAgaWYg
KCFtZXRhZGF0YSkgewo+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPiArwqDCoMKg
IH0KPiArCj4gK8KgwqDCoCAvKiBsb2FkIGFuZCBwYXJzZSBtZXRhZGF0YSBlbnRyaWVzICovCj4g
K8KgwqDCoCBmdy0+bnJfZW50cmllcyA9IGxlMzJfdG9fY3B1KG1ldGFkYXRhLT5OdW1iZXJPZlNl
Y3Rpb25FbnRyaWVzKTsKPiArwqDCoMKgIGlmIChmdy0+bnJfZW50cmllcyA8IDIpIHsKPiArwqDC
oMKgwqDCoMKgwqAgZXJyb3JfcmVwb3J0KCJJbnZhbGlkIG51bWJlciBvZiBmdyBlbnRyaWVzICgl
dSkgaW4gVERWRgo+IE1ldGFkYXRhIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBmdy0+bnJfZW50cmllcyk7Cj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlO
VkFMOwo+ICvCoMKgwqAgfQo+ICsKPiArwqDCoMKgIGVudHJpZXNfc2l6ZSA9IGZ3LT5ucl9lbnRy
aWVzICogc2l6ZW9mKFRkdmZTZWN0aW9uRW50cnkpOwo+ICvCoMKgwqAgaWYgKG1ldGFkYXRhLT5M
ZW5ndGggIT0gc2l6ZW9mKCptZXRhZGF0YSkgKyBlbnRyaWVzX3NpemUpIHsKPiArwqDCoMKgwqDC
oMKgwqAgZXJyb3JfcmVwb3J0KCJURFZGIG1ldGFkYXRhIGxlbiAoMHgleCkgbWlzbWF0Y2gsIGV4
cGVjdGVkCj4gKDB4JXgpIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBtZXRhZGF0YS0+TGVuZ3RoLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICh1aW50MzJfdCkoc2l6ZW9mKCptZXRhZGF0YSkgKyBlbnRyaWVzX3NpemUpKTsK
PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4gK8KgwqDCoCB9Cj4gKwo+ICvCoMKg
wqAgZnctPmVudHJpZXMgPSBnX25ldyhUZHhGaXJtd2FyZUVudHJ5LCBmdy0+bnJfZW50cmllcyk7
Cj4gK8KgwqDCoCBzZWN0aW9ucyA9IGdfbmV3KFRkdmZTZWN0aW9uRW50cnksIGZ3LT5ucl9lbnRy
aWVzKTsKPiArCj4gK8KgwqDCoCBpZiAoIW1lbWNweShzZWN0aW9ucywgKHZvaWQgKiltZXRhZGF0
YSArIHNpemVvZigqbWV0YWRhdGEpLAo+IGVudHJpZXNfc2l6ZSkpIHsKPiArwqDCoMKgwqDCoMKg
wqAgZXJyb3JfcmVwb3J0KCJGYWlsZWQgdG8gcmVhZCBURFZGIHNlY3Rpb24gZW50cmllcyIpOwoK
bWVtY3B5KCkgY2Fubm90IGZhaWwuLi4KCg==


