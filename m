Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AB4E74AC3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 16:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIVhn-0004yU-Ot; Tue, 03 Dec 2024 11:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tIVhl-0004vc-B2
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:24:53 -0500
Received: from netsrv01.beckhoff.com ([62.159.14.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <C.Koehne@beckhoff.com>)
 id 1tIVhj-0007Yv-4J
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 11:24:53 -0500
Received: from 172.17.5.173 by netsrv01.beckhoff.com (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Tue, 03 Dec 2024 16:24:47 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022e; 
 t=1733243087; bh=c/iS2UXj5QWUzz8/dCWIW081ekWBa9Ije77hJ1tAyPM=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=ed25519-sha256; b=
 iav32pRAw3kNbRVqk65GbAOrmqgMTSATOnxsMweb55ew/dCiV/zPWQ7v6YXn3+dMhbzUmmbZvfr2MbcEshzyDA==
DKIM-Signature: v=1; c=relaxed/relaxed; d=beckhoff.com; s=mail2022r; 
 t=1733243087; bh=c/iS2UXj5QWUzz8/dCWIW081ekWBa9Ije77hJ1tAyPM=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id;
 a=rsa-sha256; b=
 U+dFezKa79crtyNwEnbq21sRnxoaI8Z0us4UZzAgBIdEA3ezHSovBnmf6hFaXGPadVeHiyCIdxdbmr0iLy7gMIgkTiMah+wCDUH8+8GUu/HOXX4gEAaSNmXnWdKrQ5or7iOMApOM9Fwkzte4Ut7GrBGWcgnwfqsJ6OjjaC+5asPhCEUT0iqiC5xZ2l4Hcv7AehRDxdEqow5fsRcUHAoJy4Ne6YyRamckmZ4UVs1mileFTnb9nRhV2ZQ2/jxvuKZUkTK6bKxx5qR8HNIkG2fjsFZiPCqqUGMKGac0CLG0hrSCkHXYeEo0i+qIm5q/oSLP9EvAeXpyfTmGIrAyVRmfLQ==
Received: from ex04.beckhoff.com (172.17.5.170) by ex08.beckhoff.com
 (172.17.5.173) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 3 Dec
 2024 17:24:46 +0100
Received: from ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3]) by
 ex04.beckhoff.com ([fe80::492d:bba8:c8de:8ce3%6]) with mapi id
 15.01.2507.039; Tue, 3 Dec 2024 17:24:46 +0100
From: =?utf-8?B?Q29ydmluIEvDtmhuZQ==?= <C.Koehne@beckhoff.com>
To: "tomitamoeko@gmail.com" <tomitamoeko@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "clg@redhat.com" <clg@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 8/9] vfio/igd: emulate BDSM in mmio bar0 for gen 6-10
 devices
Thread-Topic: [PATCH v2 8/9] vfio/igd: emulate BDSM in mmio bar0 for gen 6-10
 devices
Thread-Index: AQHbRYhd1Iz8OjEFCUCqsd4nf1NQmbLUo+cA
Date: Tue, 3 Dec 2024 16:24:46 +0000
Message-ID: <5b87605936bc3ced09346f6e293af0623f39415b.camel@beckhoff.com>
References: <20241203133548.38252-1-tomitamoeko@gmail.com>
 <20241203133548.38252-9-tomitamoeko@gmail.com>
In-Reply-To: <20241203133548.38252-9-tomitamoeko@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.130.158]
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="=-FVyN9uWX0pNZzh41gTMW"
MIME-Version: 1.0
Received-SPF: pass client-ip=62.159.14.10; envelope-from=C.Koehne@beckhoff.com;
 helo=netsrv01.beckhoff.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--=-FVyN9uWX0pNZzh41gTMW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVHVlLCAyMDI0LTEyLTAzIGF0IDIxOjM1ICswODAwLCBUb21pdGEgTW9la28gd3JvdGU6Cj4g
77u/Q0FVVElPTjogRXh0ZXJuYWwgRW1haWwhIQo+IEEgcmVjZW50IGNvbW1pdCBpbiBpOTE1IGRy
aXZlciBbMV0gY2xhaW1zIHRoZSBCRFNNIHJlZ2lzdGVyIGF0IDB4MTA4MGMwCj4gb2YgbW1pbyBi
YXIwIGhhcyBiZWVuIHRoZXJlIHNpbmNlIGdlbiA2LiBNaXJyb3IgdGhpcyByZWdpc3RlciB0byB0
aGUgMzIKPiBiaXQgQkRTTSByZWdpc3RlciBhdCAweDVjIGluIHBjaSBjb25maWcgc3BhY2UgZm9y
IGdlbjYtMTAgZGV2aWNlcy4KPiAKPiBbMV0KPiBodHRwczovL25vc3BhbXByb3h5d2VicC5iZWNr
aG9mZi5jb20vZW5Rc2lnL2xpbms/aWQ9QkFnQUFBQ0RpTUZEQVZOaDk3a0FBQUNYY2NETFYyakhn
cHFvUFg3TXpnUllKX1F2aEhjSWdFdV9jeTVFWkN1QmtKVmpHZlVRUkhKSXlESG5walB3MmVNR2l4
WndKeHBDU25HRVdZYmZFcVdxRnpuRHoxZE1ERkVmY2pmblVZNDdPV2tLUlhxMk1DdWZqWHlIVUFQ
MlZ5U19OS25wSjBWYTd1YWpNMzhIYVNWNGR2R1dPX0NSa1V1cUluTW1pYmFGZ2UzWF9TazBiekZJ
X01mWUdWQk4xVHZJeklUcllDTGNtS3d5cDktb1M2MURJN2l2MjlJWkI5STBXSlVScTB0MU5rMGgt
MjJ6bFhqeHJRMgo+IMKgCj4gCj4gU2lnbmVkLW9mZi1ieTogVG9taXRhIE1vZWtvIDx0b21pdGFt
b2Vrb0BnbWFpbC5jb20+Cj4gLS0tCj4gwqBody92ZmlvL2lnZC5jIHwgMjYgKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA4IGRl
bGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9ody92ZmlvL2lnZC5jIGIvaHcvdmZpby9pZ2Qu
Ywo+IGluZGV4IGJjMThmYzhjYzAuLmU0NjRjZDY5NDkgMTAwNjQ0Cj4gLS0tIGEvaHcvdmZpby9p
Z2QuYwo+ICsrKyBiL2h3L3ZmaW8vaWdkLmMKPiBAQCAtNDg0LDcgKzQ4NCw4IEBAIHN0YXRpYyBj
b25zdCBNZW1vcnlSZWdpb25PcHMgdmZpb19pZ2RfcXVpcmtfbWlycm9yXyMjbmFtZQo+ID0ge8Kg
wqDCoMKgwqDCoMKgwqDCoMKgIFwKPiDCoH07Cj4gwqAKPiDCoFZGSU9fSUdEX1FVSVJLX01JUlJP
Ul9SRUcoSUdEX0dNQ0gsIGdnYykKPiAtVkZJT19JR0RfUVVJUktfTUlSUk9SX1JFRyhJR0RfQkRT
TV9HRU4xMSwgYmRzbSkKPiArVkZJT19JR0RfUVVJUktfTUlSUk9SX1JFRyhJR0RfQkRTTSwgYmRz
bSkKPiArVkZJT19JR0RfUVVJUktfTUlSUk9SX1JFRyhJR0RfQkRTTV9HRU4xMSwgYmRzbTY0KQo+
IMKgCj4gwqAjZGVmaW5lIElHRF9HR0NfTU1JT19PRkZTRVTCoMKgwqDCoCAweDEwODA0MAo+IMKg
I2RlZmluZSBJR0RfQkRTTV9NTUlPX09GRlNFVMKgwqDCoCAweDEwODBDMAo+IEBAIC01MTEsNyAr
NTEyLDcgQEAgdm9pZCB2ZmlvX3Byb2JlX2lnZF9iYXIwX3F1aXJrKFZGSU9QQ0lEZXZpY2UgKnZk
ZXYsIGludAo+IG5yKQo+IMKgwqDCoMKgwqAgKiBpbnRvIE1NSU8gc3BhY2UgYW5kIHJlYWQgZnJv
bSBNTUlPIHNwYWNlIGJ5IHRoZSBXaW5kb3dzIGRyaXZlci4KPiDCoMKgwqDCoMKgICovCj4gwqDC
oMKgwqAgZ2VuID0gaWdkX2dlbih2ZGV2KTsKPiAtwqDCoMKgIGlmIChnZW4gPCAxMSkgewo+ICvC
oMKgwqAgaWYgKGdlbiA8IDYpIHsKPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPiDCoMKgwqDC
oCB9Cj4gwqAKPiBAQCAtNTI1LDEyICs1MjYsMjEgQEAgdm9pZCB2ZmlvX3Byb2JlX2lnZF9iYXIw
X3F1aXJrKFZGSU9QQ0lEZXZpY2UgKnZkZXYsIGludAo+IG5yKQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIElHRF9HR0NfTU1JT19PRkZTRVQsICZxdWlyay0+bWVtWzBdLAo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIDEpOwo+IMKgCj4gLcKgwqDCoCBtZW1vcnlfcmVnaW9uX2luaXRfaW8oJnF1
aXJrLT5tZW1bMV0sIE9CSkVDVCh2ZGV2KSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnZmaW9faWdkX3F1aXJrX21pcnJvcl9iZHNtLCB2ZGV2
LAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAi
dmZpby1pZ2QtYmRzbS1xdWlyayIsIDgpOwo+IC3CoMKgwqAgbWVtb3J5X3JlZ2lvbl9hZGRfc3Vi
cmVnaW9uX292ZXJsYXAodmRldi0+YmFyc1swXS5yZWdpb24ubWVtLAo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgSUdEX0JEU01fTU1JT19PRkZTRVQsICZxdWlyay0+bWVtWzFdLAo+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgMSk7Cj4gK8KgwqDCoCBpZiAoZ2VuIDwgMTEpIHsKPiArwqDCoMKgwqDC
oMKgwqAgbWVtb3J5X3JlZ2lvbl9pbml0X2lvKCZxdWlyay0+bWVtWzFdLCBPQkpFQ1QodmRldiks
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgJnZmaW9faWdkX3F1aXJrX21pcnJvcl9iZHNtLCB2ZGV2LAo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJ2ZmlvLWlnZC1i
ZHNtLXF1aXJrIiwgNCk7Cj4gK8KgwqDCoMKgwqDCoMKgIG1lbW9yeV9yZWdpb25fYWRkX3N1YnJl
Z2lvbl9vdmVybGFwKHZkZXYtPmJhcnNbMF0ucmVnaW9uLm1lbSwKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgSUdEX0JEU01fTU1JT19PRkZTRVQsCj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICZxdWlyay0+bWVtWzFdLCAxKTsKPiArwqDCoMKgIH0gZWxzZSB7Cj4gK8Kg
wqDCoMKgwqDCoMKgIG1lbW9yeV9yZWdpb25faW5pdF9pbygmcXVpcmstPm1lbVsxXSwgT0JKRUNU
KHZkZXYpLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICZ2ZmlvX2lnZF9xdWlya19taXJyb3JfYmRzbTY0LCB2ZGV2LAo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJ2
ZmlvLWlnZC1iZHNtLXF1aXJrIiwgOCk7Cj4gK8KgwqDCoMKgwqDCoMKgIG1lbW9yeV9yZWdpb25f
YWRkX3N1YnJlZ2lvbl9vdmVybGFwKHZkZXYtPmJhcnNbMF0ucmVnaW9uLm1lbSwKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSUdEX0JEU01fTU1JT19PRkZTRVQsCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICZxdWlyay0+bWVtWzFdLCAxKTsKPiArwqDCoMKgIH0KPiDC
oAo+IMKgwqDCoMKgIFFMSVNUX0lOU0VSVF9IRUFEKCZ2ZGV2LT5iYXJzW25yXS5xdWlya3MsIHF1
aXJrLCBuZXh0KTsKPiDCoH0KClJldmlld2VkLWJ5OiBDb3J2aW4gS8O2aG5lIDxjLmtvZWhuZUBi
ZWNraG9mZi5jb20+Cg==


--=-FVyN9uWX0pNZzh41gTMW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmdPMM4ACgkQ2FTaVjFe
Ampd5w/+LVsYHEOiU7J3D521Zi9gFGVnggqf96/WuKTjxA3MG/j04V++UihohC0r
Vr1D/2U4i6ZHHtR2d4jw5G1I6b4LEpeaSrkBSa3I51rFDrPX5j0ZjXVdS2ihY63y
DMdUQFgvOrF/gwnEg300RU3TvWf9GWu6YoaCQlNynSLzZ39n5v8jjLCmRmjVOVx6
ET89dXGXIguLLv3SH+brBC+mntJSICu1rmbp4oX5n8B5rGuKm3nTucLjr60vcMv0
QFq3erhYblkHxmX0/CNJsVJLRyM0KTuIHfpMEMccbJ4kIJj0+5K69ytmRaKmCRnP
OXHnYHtf0/Y8p1VOdNR8cihxxrnKev8ptw1thUj+9ZIDpDf57GPdbtjU+4FqHaSc
TEp5lW5EjFMQ6mdNDz4sB8yLnEQG3VH//wi8P0SeWauuIgiQbP1gSeQ6VeBcoj7O
N3JyEQgAxGpSXNuvsjAjcyQdivtxXirtxryqsChcBHrQrs/Kaf4T79eaf8gJdMUE
PMpu/ZRFv4Osym4dnbnKSjgNMlY0rzg1J6D7KnSdOxLDA4mwMyL6xpx+z2+jlOcG
Ob7YZXz2ySQcxkVua2eT/Bsb6wDWRBejwcD4/5tlFbRgA+JkUV/oonUUkcC6R79+
eTGjKj7zd/vuq9LWr6K6udsz5lS+fsHgkjMy8UYArzKjd9mkTR4=
=Q3In
-----END PGP SIGNATURE-----

--=-FVyN9uWX0pNZzh41gTMW--


