Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18853FF886D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRpD-0008Ms-IC; Mon, 27 Apr 2026 15:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHRp8-0008Ka-TD
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:40:55 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHRp5-0007I9-Ow
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:40:54 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so53493835e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777318848; x=1777923648; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8adT00sYmCE4icsm1qkp6lI8/aVb7DrH9njcSCEgl+E=;
 b=KYCCs3w6WRqzX2RIyScxVRX0mIWLuTO+i2Wpe6If3V0egEokQJHTSIDG5g9onGD91G
 1x0DRW9dId5ozq6NE38/4xpyxMRIIx7dkxntBo2TARIWjTSMqVOAOhUhyO840EdkxkUv
 1zyGG24P/d7eFduyDfXvGD1rmZm533z0c65jadhUbMJ08opC1JZuvSPpHUJHRs86k9ox
 R1ilv3S1Xwe/tIOMy+WjARjL5sewG7FPHDzAcCwLEF0oIgcOJZDsPFK6MkNgCkEm47sH
 IgxdWO2jIgI3i/pwzHdMGTKzhIfdKxZP5q3JAazUtuzTOVxx3b+1wcvzszjbcAQCTzcW
 pVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777318848; x=1777923648;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8adT00sYmCE4icsm1qkp6lI8/aVb7DrH9njcSCEgl+E=;
 b=FRt+ISmX+RDymOef/mCmXIsKOX7ij2ERZQr1zvQ3Dcni6pDrOWLRN5EH0porLf4Q0z
 3FSWlUSxo6uhwnP0+zhLjR+nb4oPYn5UkmhU1X3kkaIzglz32I1ZrYAsitF0jDlYCWP2
 EBcQ8gauOeObuxOPd8hL2hSwCT6ZjRnnqNywn/I1YIzAbF5bJWfhTw88TiJbDN1dH8KP
 /sMoByTV7ID9zFnWgIbEKllb2w5qEbxmLse/6+vY1NqabKt0W+hj1tP9aB1c+qrI54f0
 5tKpJm/eZjEWYo79+Mda9jUrWNjrRTnGWuU7U2I5/IdHnHJAAI/BRUCtUdx+lSKTCRNq
 w/zg==
X-Gm-Message-State: AOJu0Yzm4XV+Yhe9sweF48QQ8CCR0DoEDZOTE1OtA84K+fSVU/EIMYTK
 8+KkF5fBsmIBkz3dESyy5EaYEzsn+ReX47xxwDYB2hHn3Z59wYSAoYB4
X-Gm-Gg: AeBDiesc/68ahUMZ5QmTcwGbTYqhGgi4iQ3WBPbbjUNexHD+Zf1XD2RGfCAW+RZXmjE
 BFHURELsA9goIJiwdmAe2kqfc+/AGftkgLwTfiUArAm03rUpL+0oYyd6EcFiUp639lzrvUS9IYD
 hvxBXvVMHWMrgOqC7mgRMv90kwNcgdFBnwxuC4gswUhvuFakMhx8mEbZis2nvXFotNS95ggZSCQ
 ggy0zxvMcwmxfz1Wx3mzSL0jo5CPG1r4b22NBKsKehtxCBEGw2jbfhEBHCuIQcgxYKTaBHvdSNg
 M9KCGo8eXFMS/RyKWtXjvYRnum2FGQoevD4F8SnE8x1Pff1L92NWKB6jVCkWUcwSRt+GZV/gJmM
 ij9uqEyTWkM8dh3T9KPGh7Ouu0GIIzgRGFDsVDURw0shpqO0Xj9XOE05P8fhtBoNWf4knYx6dYZ
 +2edI2vNsxCp5ccq3p/W+hJEjBxuhxcSQCJLrltQZ7dDtNdKM9e6M=
X-Received: by 2002:a05:600c:19cd:b0:489:1baf:8c03 with SMTP id
 5b1f17b1804b1-48a77e50d27mr421825e9.11.1777318848212; 
 Mon, 27 Apr 2026 12:40:48 -0700 (PDT)
Received: from holly.home.arpa ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a774d9bd1sm3599695e9.3.2026.04.27.12.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 12:40:47 -0700 (PDT)
Message-ID: <f490c53fd4ff3005333a2e70193213677f365275.camel@gmail.com>
Subject: Re: [PATCH v3 1/2] ui/gtk: Use non-blocking clipboard retrieval
From: Jindrich Makovicka <makovick@gmail.com>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P."
 =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 21:40:47 +0200
In-Reply-To: <CAMxuvawm5Rpq2E5VbtrugJ3MZsWT1kPahJZR4=SZy-y+wgk9dw@mail.gmail.com>
References: <20260426-gtk-clipboard-v3-0-09555aaeda34@gmail.com>
 <20260426-gtk-clipboard-v3-1-09555aaeda34@gmail.com>
 <CAMxuvawm5Rpq2E5VbtrugJ3MZsWT1kPahJZR4=SZy-y+wgk9dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=makovick@gmail.com; helo=mail-wm1-x32a.google.com
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

SGksCgpPbiBNb24sIDIwMjYtMDQtMjcgYXQgMTI6NDcgKzA0MDAsIE1hcmMtQW5kcsOpIEx1cmVh
dSB3cm90ZToKPiBIaQo+ID4gwqBzdGF0aWMgdm9pZCBnZF9vd25lcl9jaGFuZ2UoR3RrQ2xpcGJv
YXJkICpjbGlwYm9hcmQsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBHZGtFdmVudCAqZXZlbnQsCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBncG9pbnRlciBkYXRhKQo+
ID4gQEAgLTE3MywxMiArMjAxLDEwIEBAIHN0YXRpYyB2b2lkIGdkX293bmVyX2NoYW5nZShHdGtD
bGlwYm9hcmQKPiA+ICpjbGlwYm9hcmQsCj4gPiDCoMKgwqDCoCBzd2l0Y2ggKGV2ZW50LT5vd25l
cl9jaGFuZ2UucmVhc29uKSB7Cj4gPiDCoMKgwqDCoCBjYXNlIEdES19PV05FUl9DSEFOR0VfTkVX
X09XTkVSOgo+ID4gwqDCoMKgwqDCoMKgwqDCoCBpbmZvID0gcWVtdV9jbGlwYm9hcmRfaW5mb19u
ZXcoJmdkLT5jYnBlZXIsIHMpOwo+ID4gLcKgwqDCoMKgwqDCoMKgIGlmIChndGtfY2xpcGJvYXJk
X3dhaXRfaXNfdGV4dF9hdmFpbGFibGUoY2xpcGJvYXJkKSkgewo+ID4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaW5mby0+dHlwZXNbUUVNVV9DTElQQk9BUkRfVFlQRV9URVhUXS5hdmFpbGFibGUg
PQo+ID4gdHJ1ZTsKPiA+IC3CoMKgwqDCoMKgwqDCoCB9Cj4gPiAtCj4gPiAtwqDCoMKgwqDCoMKg
wqAgcWVtdV9jbGlwYm9hcmRfdXBkYXRlKGluZm8pOwo+ID4gLcKgwqDCoMKgwqDCoMKgIHFlbXVf
Y2xpcGJvYXJkX2luZm9fdW5yZWYoaW5mbyk7Cj4gPiArwqDCoMKgwqDCoMKgwqAgZ3RrX2NsaXBi
b2FyZF9yZXF1ZXN0X2NvbnRlbnRzKAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xpcGJv
YXJkLCBnZGtfYXRvbV9pbnRlcm5fc3RhdGljX3N0cmluZygiVEFSR0VUUyIpLAo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZ2RfY2xpcGJvYXJkX293bmVyX2NoYW5nZV9jb250ZW50c19yZWNl
aXZlZF9jYWxsYmFjaywKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluZm8pOwo+IAo+IGNv
dWxkIHlvdSB1c2UgZ3RrX2NsaXBib2FyZF9yZXF1ZXN0X3RhcmdldHMgaW5zdGVhZD8KPiAKPiBs
Z3RtIG90aGVyd2lzZQoKU2VudCBhcyB2NCAuCgpSZWdhcmRzLAotLSAKSmluZHJpY2ggTWFrb3Zp
Y2thCg==


