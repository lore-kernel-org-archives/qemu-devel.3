Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDF9C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9NIx-0001sr-R5; Wed, 23 Sep 2026 09:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1x9NIt-0001s2-RA
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:46:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1x9NIq-00030z-Mo
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790171186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7CqoBLckCgxng+hHDLhYS/rM6ovCXw393XvTfcnfW7M=;
 b=RG0oryGCTqRHj2A5C2UMUxVDdrUU8Cvy1XucQ3dQ2d9Lz7+3usa9m3YF/Sy534Vta4baKW
 hdnq57Tz14s2MM1zdqFG/QA3/VmlKyY2tUiEALV7MQkxX9u+OsrsO/rcWONyQaxkdFwVUR
 nqKTzUZiAAC4HrfgHBXmQvKVjpajAeg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-UHz6WtQnORy3OjafeBX1jQ-1; Wed, 23 Sep 2026 09:46:24 -0400
X-MC-Unique: UHz6WtQnORy3OjafeBX1jQ-1
X-Mimecast-MFC-AGG-ID: UHz6WtQnORy3OjafeBX1jQ_1790171184
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90e80ce3597so20014926d6.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790171184; x=1790775984; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7CqoBLckCgxng+hHDLhYS/rM6ovCXw393XvTfcnfW7M=;
 b=OD5bYJq0HnNcfA3sB0/TWZmPKXxdy53iKfmhRdeWv2gIv8/c0utLA8wqFklDovsOrN
 UT+PCLQLBltRgty4I7cUgGAher6TBpP7X6CvbjnvDEFIJwAb1BicgKPXtKUf1B2C7E1v
 TY/1RtacPFUYClV3FKYBnaGi56Yom0QiLyl3RfqjHsKGoozV7hE380gvQD1nltMYRyek
 YUOYnahVVXnMKH/3WfBNhB7wfOu2KuNjHY+1blK3sbvbHhRLzzx/tEDt8oPfxru44QeF
 A8zlgXI9aP3+jkeWx/hYbXW92BJ8QaZin0HMv/nw3KSyQPOLkE5813iec9MOOULQx5jK
 gxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790171184; x=1790775984;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7CqoBLckCgxng+hHDLhYS/rM6ovCXw393XvTfcnfW7M=;
 b=gf+9q9JaxIl6xaMG3cRGIPyEgtVONJB+OY6MGgGljuVSe8eV5cu0cvODCf3NGWGI0z
 gFRlnvM8jq8wMQCT/VRqK73B+cRwIzogGZ7UwIPfjHnmHPRkIxVBO5j18UHr2zgnCjVK
 vh9mgt3SLEUA2rUSVY7XngQZEQbI9fewdmq/mB6Of9S7BarE0/UCyy1dGmc/gYpue1gV
 8BkxUwkNNubeF6n7e21NICHCOSJCsD4zThsp1YF+X+jAwfKKZ+6yILxbh0z1BSfPABIQ
 tHxGZg9R+1nhxxZo8EIO3lu1BEg4GdFCBG9rj9S5BtoioF+rrk6ubZKoSfNY+r76VcFB
 6KBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx/Q/GEIrtLJsebzhIRFOO0YC4xP2Hmq01I8MZkwQp73YZZSvYEkjWeGYi+8WBwUAzrGTyJNxlFhOQt@nongnu.org
X-Gm-Message-State: AFuF++k/hrAnDyx+2MBlI7dfk0ch8AzKwGmFR6v1u8iCS+CsAdq3EM3y
 SQmsEKJ7CPRJVRsPMnolOTBPkenqI92ZrZa6E3LMwHH7xSPZktorwTLx8+DUGIqIAPt/eE1kvDE
 PXlcSLZpI1Yi0rWt/SBWvzZcKvYU3aAvFGeOoVvQbZndh0V0Q5Svi5zHF
X-Gm-Gg: AYBFou2gLAZ0wOS9FXFNUnhJ9LOFL1Aaa2gis0HSXx0mP5siD74ytV5cHxR+BU8sik0
 s/NIcy3XsWlX6JCX4g3OxFxnfZLxHEVUaKlvs6XPERNZ2AYSaVjvdDNpqBg/35fBDkJu9oaSAY3
 H5XU03hmvWTZ+VKGx73lmPHeJOfnDnLGmjZTnHHKS4LEvJYTw1AIRPm4jLasyDUTwTbbLey0qZ7
 6ILIPR2B/o57CLmT13gWqconDBlQ4RaVZDfHrbH+XwGvBd6J5n4GsLoOuhAKxqiS2TJ3kHzv1pT
 zvD24umj5Uw+uC0DVGLP1ALnvqVk9D1zSVqkqmnuy44uO8LxukhC1oV5jgZGSqKr2K8UMWBjLYh
 SwN1WpCZrknXusAEJEIjTMYesZ9pu+Dfl7NT99h8IVxZtorZJwTZmWPSzoX6fILOwiScxWtDWHE
 Fxeghpx2G/
X-Received: by 2002:a05:6214:4891:b0:912:33a0:5d7b with SMTP id
 6a1803df08f44-9140c42c08emr42257316d6.27.1790171183913; 
 Wed, 23 Sep 2026 06:46:23 -0700 (PDT)
X-Received: by 2002:a05:6214:4891:b0:912:33a0:5d7b with SMTP id
 6a1803df08f44-9140c42c08emr42256976d6.27.1790171183361; 
 Wed, 23 Sep 2026 06:46:23 -0700 (PDT)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb
 (pool-173-33-204-162.cpe.net.cable.rogers.com. [173.33.204.162])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9140d16220csm18453716d6.6.2026.09.23.06.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 06:46:22 -0700 (PDT)
Message-ID: <a7417f243a73f8c99673abb8d346388909ff00c5.camel@redhat.com>
Subject: Re: [PATCH] accel/kvm: coalesced mmio: check lenght of the MMIO
 write entry
From: "mlevitsk@redhat.com" <mlevitsk@redhat.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mauro Matteo Cascella
 <mcascell@redhat.com>
Date: Wed, 23 Sep 2026 09:46:21 -0400
In-Reply-To: <cc2099f2-5e21-49fa-b0b3-c0322d0737fd@oss.qualcomm.com>
References: <20260923004631.100997-1-mlevitsk@redhat.com>
 <cc2099f2-5e21-49fa-b0b3-c0322d0737fd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

T24gV2VkLCAyMDI2LTA5LTIzIGF0IDA3OjA3ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToKPiBIaSBNYXhpbSwKPiAKPiBPbiAyMy85LzI2IDAyOjQ2LCBNYXhpbSBMZXZpdHNr
eSB3cm90ZToKPiA+IEtWTSdzIGNvYWxlc2NlZCBtbWlvIHJpbmcgYnVmZmVyIGhhcyBlbnRyaWVz
IHRoYXQgY29udGFpbiBkZWZmZXJlZCBNTUlPCj4gPiB3cml0ZXMuCj4gPiAKPiA+IEVhY2ggc3Vj
aCBlbnRyeSBjb250YWlucyB0aGUgbGVuZ3RoLCBhbiA4IGJ5dGUgdmFsdWUgYW5kIGEgZ3Vlc3Qg
YWRkcmVzcy4KPiA+IAo+ID4gV2hpbGUgdGhlIGxlbmd0aCB2YWx1ZSBjb21lcyBmcm9tIHRoZSBr
ZXJuZWwsIGl0IGlzIHN0aWxsIHBvc3NpYmxlIGZvcgo+ID4gYW4gYXR0YWNrZXIgdG8gY29ycnVw
dCB0aGUgbGVuZ3RoIGZpZWxkIHVzaW5nIGFub3RoZXIgZXhwbG9pdC4KPiA+IAo+ID4gVGhlIGF0
dGFja2VyIGNhbiB0aGVuIGludm9rZSBrdm1fZmx1c2hfY29hbGVzY2VkX21taW9fYnVmZmVyLCB3
aGljaCBibGluZGx5Cj4gPiB0cnVzdHMgdGhlIGxlbmd0aCBhbmQgY2FuIGJlIHVzZWQgdG8gaW5m
bGljdCBmdXJ0aGVyIGRhbWFnZS4KPiA+IAo+ID4gQWRkIGEgc2FuaXR5IGNoZWNrIG9uIHRoZSBs
ZW5ndGggZmllbGQgdG8gcHJldmVudCB0aGlzLgo+ID4gCj4gPiBUaGlzIHBhdGNoIHdhcyBvbmx5
IGNvbXBpbGUgdGVzdGVkLgo+ID4gCj4gPiBSZXBvcnRlZCBieTogIkxhYnMsIFNUQVIiIDxpbmZv
QHN0YXJsYWJzLnNnPgo+ID4gUmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2pl
Y3QvcWVtdS8tL3dvcmtfaXRlbXMvMzg2Mwo+ID4gU2lnbmVkLW9mZi1ieTogTWF4aW0gTGV2aXRz
a3kgPG1sZXZpdHNrQHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+IMKgIGFjY2VsL2t2bS9rdm0tYWxs
LmMgfCAxMSArKysrKysrKystLQo+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2FjY2VsL2t2bS9rdm0tYWxs
LmMgYi9hY2NlbC9rdm0va3ZtLWFsbC5jCj4gPiBpbmRleCA4M2NiZDEyMGE4NDcuLjgyODk4ZmQ4
OTE0OCAxMDA2NDQKPiA+IC0tLSBhL2FjY2VsL2t2bS9rdm0tYWxsLmMKPiA+ICsrKyBiL2FjY2Vs
L2t2bS9rdm0tYWxsLmMKPiA+IEBAIC0zMTc0LDggKzMxNzQsMTUgQEAgdm9pZCBrdm1fZmx1c2hf
Y29hbGVzY2VkX21taW9fYnVmZmVyKHZvaWQpCj4gPiDCoCAKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGVudCA9ICZyaW5nLT5jb2FsZXNjZWRfbW1pb1tyaW5nLT5maXJzdF07Cj4gCj4g
Q291bGQgd2UgbW92ZSB0aGUgY2hlY2sgaGVyZT8KClllcy4KPiAKPiBEbyB3ZSB3YW50IHRvIGtl
ZXAgcHJvY2Vzc2luZyB0aGUgb3RoZXIgZW50cmllcyBpZiB0aGUgY3VycmVudCAlbGVuCj4gaXMg
YnJva2VuIG9yIGJyZWFrIGFuZCByZXR1cm4/CgpIb25lc3RseSB0aGlzIGlzIHN1Y2ggYSB0aGVv
cmV0aWNhbCBzaXR1YXRpb24gdGhhdCBJIGRvbid0IGtub3cgd2hhdCBpcyBiZXR0ZXIgaGVyZS4K
T25lIGNvdWxkIHNheSB0aGF0IHNraXBwaW5nIG5vbiBjb3JydXB0ZWQgd3JpdGVzIGFsc28gZ2l2
ZXMgc29tZSBhZHZhbnRhZ2UgdG8gdGhlIGF0dGFja2VyLgoKVGhpcyBwYXRjaCBnb2FsIGlzIG1v
c3RseSB0byBzaWxlbmNlIHRoZSBzdGF0aWMgYW5hbHlzaXMgdG9vbHMgKHJlYWQ6IEFJKSzCoApi
ZWNhdXNlIHRlY2huaWNhbGx5IHRoaXMgaXMgYSBidWZmZXIgb3ZlcmZsb3cuCgpCZXN0IHJlZ2Fy
ZHMsCglNYXhpbSBMZXZpdHNreQoKPiAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFz
ID0gZW50LT5waW8gPT0gMSA/ICZhZGRyZXNzX3NwYWNlX2lvIDogJmFkZHJlc3Nfc3BhY2VfbWVt
b3J5Owo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRkcmVzc19zcGFjZV93cml0ZShhcywg
ZW50LT5waHlzX2FkZHIsIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQsCj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZW50LT5k
YXRhLCBlbnQtPmxlbik7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZW50
LT5sZW4gPiBzaXplb2YoZW50LT5kYXRhKSkgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB3YXJuX3JlcG9ydCgiY29hbGVzY2VkIE1NSU8gZW50cnkgaGFzIGludmFsaWQgbGVu
ICV1IiwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZW50LT5sZW4pOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRkcmVzc19zcGFjZV93cml0ZShh
cywgZW50LT5waHlzX2FkZHIsIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQsCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBlbnQtPmRhdGEsIGVudC0+bGVuKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0K
PiA+ICsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNtcF93bWIoKTsKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJpbmctPmZpcnN0ID0gKHJpbmctPmZpcnN0ICsgMSkgJSBL
Vk1fQ09BTEVTQ0VEX01NSU9fTUFYOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIH0K


