Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348A6C021A7
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 09:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tis2c-0002GF-M9; Fri, 14 Feb 2025 04:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tis2a-0002G5-E7
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 04:31:20 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tis2Y-0000it-Og
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 04:31:20 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5de51a735acso3432776a12.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 01:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739525475; x=1740130275; darn=nongnu.org;
 h=user-agent:mime-version:date:autocrypt:references:in-reply-to:cc:to
 :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RumS1TxssgGfR7/2i83oHjeXmfmGJCefT9NZzLt2aUQ=;
 b=NFK/pUq17ydXnzuP6ulVIdlB27BNb53sIGx2IdvYXA2GItOy6P1v4MABTGjsZlmlN0
 F3gg3g54xWBdYdctDm+5V82ejzHKA+Q/fsCmAKZjksUtIlUjDwOJ6u2KaOQKcCNs+8N4
 JOb1HdTD+Nfsn7owunlz0scnA5ZykwHKmAZBdPNaTSQ/QzECrowsOMPIU+PvjRJMZKLL
 1RjWGJ6pjTEHhWhbNEQjQjwtugLD9UtnSWi64zhzcLLiBHRdIAOTsU9Xe7kYmqJbkPLM
 w+eyFT1li88iuAFODqBNJy9A0Fjcs/eCPhHrLAJ5WMrvo06BYgjh8XKvizYAGBFdFthj
 sVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739525475; x=1740130275;
 h=user-agent:mime-version:date:autocrypt:references:in-reply-to:cc:to
 :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RumS1TxssgGfR7/2i83oHjeXmfmGJCefT9NZzLt2aUQ=;
 b=NRfw4Ok7taKCSFWTxELKuUYOYGaetRcbR/H3e5HH/q+cf2Qj1xi7rfcmxPG+n4o3k2
 0Z7qhaKmjQtWYRgVSYPaQ+DTjl2sFQDxkDxKyjqj9dhxa51YHtwIqVHD/yV2CV/e4S7b
 84lR2ufLNS6IriLuR1RvOC2k5DaJca13nRCjP2vnFcaTjJygFPEsX6sFCCTN0wFr/lhS
 2kdGcCHyDr7w9UQGObCVf2DegChiV34kiMNzsL+ONmFoAuch20YLJNtKMBJusA/6t94a
 VnKzfT1eUpf825sIhYh4B16tk2X3HTSI5qxegKbkSBnXb8j9R3FHDFNOWeOvXKXF/+v1
 ROwA==
X-Gm-Message-State: AOJu0YzPZDUzgGIKvZKumWamsekukbxECsFLeyZTDxmdapymGDLUR4Dn
 M486oJpfYZjw7l39XPi7K+FX84iV3riR+QtN+pWTOHZcMmkLzv3VUTdDmBWq
X-Gm-Gg: ASbGncuXWVEsGKmIie2/zpxJzeYDg3aj5sp9mNIyqh45hsd1yO//a0MqhPvvG8BpThU
 ijGDXKE84VNYLCUL1UrMn+XQRNvS0ZL0Ne7LZCzCN1ARJj8TjwgEFj55dTTvp9snXN2JEFrasG6
 qxJxgRjju+tPpaT2d7H0EvZc5//wDlCPEKTmbkJW/qAHrUr8wy2TCGjfeNkIjexmxOuZcqNxoEZ
 BBF+CArHIWj0qF8jXt3kvtIrFAe6JHayXuG781ImrxevFMRxwLRZpuTMx1UIL0VigNaPEEtvy2M
 urgT3x9m0qVNHfVoX+b1Pu8nx8HY
X-Google-Smtp-Source: AGHT+IHV90VDCPD54wiWUrKV09FNs1YtuP00XrAOb8hv27GUJX+UC9MhJAOLLeNXW92K/RvynDMUKw==
X-Received: by 2002:a05:6402:3606:b0:5dc:7fbe:730a with SMTP id
 4fb4d7f45d1cf-5dec9b70130mr7076222a12.0.1739525475070; 
 Fri, 14 Feb 2025 01:31:15 -0800 (PST)
Received: from [172.21.178.255] ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece287d13sm2598695a12.68.2025.02.14.01.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 01:31:13 -0800 (PST)
Message-ID: <ef8108aa73c693cc54c08c81a14201138b14172f.camel@gmail.com>
Subject: Re: [PATCH v2] vfio: Add property documentation
From: Corvin =?ISO-8859-1?Q?K=F6hne?= <corvin.koehne@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>, 
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>, Eric
 Farman	 <farman@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, 
 tomitamoeko@gmail.com
In-Reply-To: <20250213144513.32b3241f.alex.williamson@redhat.com>
References: <20250213135050.1426258-1-clg@redhat.com>
 <20250213144513.32b3241f.alex.williamson@redhat.com>
Autocrypt: addr=corvin.koehne@gmail.com; prefer-encrypt=mutual;
 keydata=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
 LwksVmgc9s79+9pSpeP5DbIeMzhrIK
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-v/3sUI8E4SlzamTeMQGz"
Date: Fri, 14 Feb 2025 10:31:08 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x52e.google.com
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


--=-v/3sUI8E4SlzamTeMQGz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDI1LTAyLTEzIGF0IDE0OjQ1IC0wNzAwLCBBbGV4IFdpbGxpYW1zb24gd3JvdGU6
Cj4gT24gVGh1LCAxMyBGZWIgMjAyNSAxNDo1MDo1MCArMDEwMAo+IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiArwqDCoMKgIC8qCj4gPiArwqDCoMKgwqAgKiBJ
R0QKPiA+ICvCoMKgwqDCoCAqLwo+ID4gKwo+ID4gK8KgwqDCoCBvYmplY3RfY2xhc3NfcHJvcGVy
dHlfc2V0X2Rlc2NyaXB0aW9uKGtsYXNzLCAvKiAyLjcgKi8KPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICJ4LWlnZC1vcHJlZ2lvbiIsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAiQWRkIElHRCBPcFJlZ2lvbiBzdXBwb3J0IGZvcgo+ID4gKGhlYWRsZXNzIHN5c3RlbSkiKTsK
PiAKPiBbQ2MgVG9taXRhIGFuZCBDb3J2aW4gaGF2ZSBtb3JlIHJlY2VudCB1bmRlcnN0YW5kaW5n
IG9mIElHRCBvcHRpb25zXQo+IAo+IE5vdCBuZWNlc3NhcmlseSBmb3IgaGVhZGxlc3Mgc3lzdGVt
cywgdW5sZXNzIG90aGVycyBoYXZlIGJldHRlcgo+IHN1Z2dlc3Rpb25zLCBtYXliZSBqdXN0ICJF
eHBvc2UgaG9zdCBJR0QgT3BSZWdpb24gdGFibGUgdG8gZ3Vlc3QiLgo+IAoKU291bmRzIGdvb2Qu
IE5vdGUgdGhhdCBpdCdzIHJlcXVpcmVkIGZvciB0aGUgSW50ZWwgR09QIChFRkkgZHJpdmVyKSBh
bmQgdGhlCldpbmRvd3MgZHJpdmVyLiBTbywgaXQncyBtYW5kYXRvcnkgZm9yIG5vbiBoZWFkbGVz
cyBzeXN0ZW1zLgoKPiA+ICvCoMKgwqAgb2JqZWN0X2NsYXNzX3Byb3BlcnR5X3NldF9kZXNjcmlw
dGlvbihrbGFzcywgLyogMi43IChTZWUgYzRjNDVlOTQzZTUxKQo+ID4gKi8KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICJ4LWlnZC1nbXMiLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgIkFkZCBJbnRlbCBncmFwaGljcyBsZWdhY3kgbW9kZQo+ID4gZGV2aWNlIGFzc2lnbm1l
bnQgc3VwcG9ydC4gIgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIkFzc2lnbiAwMDow
Mi4wIGZyb20gdGhlIGhvc3QgdG8KPiA+IDAwOjAyLjAgaW4gdGhlIFZNIik7Cj4gCj4gTm90IHJl
YWxseS7CoCBUb21pdGEgYWRkZWQgYSB1c2VmdWwgY29tbWVudCBhbmQgY29tbWl0IGxvZyBpbgo+
IDM3ZjA1YTU5ZTg2OS7CoCBQZXJoYXBzOgo+IAo+ICJPdmVycmlkZSBEVk1UIFByZS1BbGxvY2F0
ZWQgdmFsdWUgZm9yIElHRCBzdG9sZW4gbWVtb3J5LiAoMzJNaUIgdW5pdHMpIgoKTml0OiBUaGlz
IHNldHMgdGhlIEdyYXBoaWNzIE1vZGUgU2VsZWN0IHZhbHVlIG9mIHRoZSBHTUNIIEdyYXBoaWNz
IENvbnRyb2wKcmVnaXN0ZXIuIFdoaWxlIHdlIGN1cnJlbnRseSBvbmx5IHN1cHBvcnQgdmFsdWVz
IGluIHRoZSByYW5nZSBvZiAweDAwIC0gMHg0MCwgSQpkb24ndCBzZWUgYSByZWFzb24gdG8gbm90
IHN1cHBvcnQgMHhGMCAtIDB4RkUgd2hpY2ggdXNlcyA0IE1pQiBpbmNyZW1lbnRzLgoKCi0tIApL
aW5kIHJlZ2FyZHMsCkNvcnZpbgo=


--=-v/3sUI8E4SlzamTeMQGz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEgvRSla3m2t/H2U9G2FTaVjFeAmoFAmevDVYACgkQ2FTaVjFe
Amq3BA/+OxHCkMagETBg+NMmlv1MX45bMtHrZWIPksXw6opPx4ssBGME7oVfYt64
xV6BH5rV/sJtQfHXFq56o+Kl1lhJJc6QLfCxkSFcMZZpAi7oOfp84UhdKn6AMrDU
G9y111Zvx8tNMpCM7sL65sPstQtZIeSNjVu5+2Lk1qsmAG14ADq7EuFXwhHY3NP3
6eK8zg/GuThW/AG2jHNUaj7RQ2/+tleYBFOIO5xTq/OBngzS39dBIql8KO5DDPVs
uJdCRV/MFhmatI6xK8dscqdnMs7aL2lLRUQ0hc7kGPM0rMnfV1s1qRDQuTX96KN0
IO1rabkQZdpo7GX6Mzu2ILzelHG97jUByFA62neIYESj62qftKpTqGhe2zTCyKuq
YrLYGfSH0EAeMdRPLLMT2fB8EK6MyRj9QnBfL+1rkI8m1/HtUzq3M0n17llr1mz/
bXXMv4R8a8YynYxlyROj8eBBFJVQxzjcC7VgzcLazi9bC4lvlI04pI3kqzzVlXCi
ZK5LzIf0TImrWXXYZXmoaeet2T8S5hzLk2JCjZsaRJshYwutzraKfDoH94ZyPn0n
J9foo6ud5GQJb3Ip91v/NBQXItnH+/ZQK5m2iY3D0pi8K/11NkdQ37HeNATJVb/m
XpwGhLXVt8woitwk2PPnR7vA096j4Fx3/2DSXrKGyGa2lGowdA4=
=dqlW
-----END PGP SIGNATURE-----

--=-v/3sUI8E4SlzamTeMQGz--

