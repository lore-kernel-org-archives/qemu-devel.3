Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FE8C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 22:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaMXm-0006zH-Ex; Fri, 11 Jul 2025 18:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baxiantai@gmail.com>)
 id 1uaMVb-00066m-OA
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 18:46:27 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baxiantai@gmail.com>)
 id 1uaMVX-0007OZ-Se
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 18:46:23 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e8b838203d3so208662276.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752273976; x=1752878776; darn=nongnu.org;
 h=mime-version:content-language:accept-language:in-reply-to
 :references:message-id:date:thread-index:thread-topic:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=igEit28helRgISGM9cIXLE240MuQVC82FHmo5spg0wY=;
 b=WejRtFJ5MLvfrOw9KtCUlHO3TYnQa5ZjnlWx81pr3ryfeDrediw1DHl1KrSgMoJm+/
 BtKWuxGIUauS/dQPKh03lnm8ZvFsqa4Be83Q7Fl7y2VM4xYzvglXQBk+q14yzmGuPzMj
 bao3Q1eYRHr4HLSTvnCcSKDWdXRpKkwQjO+yXZKBbegaYOS63UZXhlTiJqsO8I1WGbmf
 yG8kxVaaMXiaEPt5SChIUychbB1ZxgOEx8+ChGpX1TjoXDCRgm28iHOWxiVUPe9n/hBe
 pEyejEKCjzR+zUlq118U1Rj31dfANdEq2Nz2hhl6cRFo+MKQaIDCgaDXobxvPgX1iQ6q
 yjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752273976; x=1752878776;
 h=mime-version:content-language:accept-language:in-reply-to
 :references:message-id:date:thread-index:thread-topic:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=igEit28helRgISGM9cIXLE240MuQVC82FHmo5spg0wY=;
 b=s01o2+nmLhMfXVkeEYIyySt3DtyWIP/AKj/aPtSmXdEo/KAVIV2sexNjMevYOkQVk2
 vOePZm1AXXSEr7jkRCcegpgpJfZStudvF0N1i+MSlhmtyyuhpVuEo+ZigAa5OL6I6OEQ
 lq+ReQpXdn8FHho4G4yXSuRhkbjB/QdE8mh5x6TbBassdFALbHWtPF+o1Ps6CK0R7m8y
 0prNYoi9dIEtmCNTbkm4zWeHYQH1IAcAR1bkhCEkBb7tJ1rW9yGKHz+0PvctMwjDNKEB
 Q9Qst9/0Zyv3V5Vaa+AIOQNG2aI7ZWHuSvDeUk+GYmJSoicFcBaj2ZsIrZxq0rN6/tSX
 RjeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIu7hTFnXpFC3gTbXB99G+Fh1brW02MWduUa5ulR9SFVuC3HcT4CEdcNS5YlLtaQcZfUxivCa3U6wS@nongnu.org
X-Gm-Message-State: AOJu0YwnJwl0puSGGvmXkOHkPnS/ZhwG15yRSI9evByxA7/X87+SOJfI
 o9/vzPsxxCiT0iWOz01voAqi+TfG3iH5j7PmpKl0hJr+AULNOVqpXJHy
X-Gm-Gg: ASbGnctoaVfIQaHtZx45L1PGRGYIetM+2ngj0pN+WdfNyvCJUkksWpZQSut+7XZxbw9
 5OTBRHFujJlrAieFF58YM2EZuk3nSKPQvZG3gDFjVOmK2q/4nwBBTfFbSnaVqG5LtUE/qGuDT90
 WwLWqEyj5e61JcRnvU5NHVlmRQP+3tJZ+nuUofaAK6vMkwfxt8i8JIWXLgNS9diJg8aMo6gQaUs
 a/VL/+ta0lLBKmaut46sbMrbYjbbah2xn2zyYmJX6enjHpbGg3SaiFDTM31Bn3sppPQLQsG2S+8
 jac7CQWGMy0wOfJlqLG8DxUQ8rG//ev/oMQlfaVRhEN6ko9F/gNmkvhvjdRp1vpGLnGa0iWzEDD
 TNtYwWsFN+C3Q0zVGidu2OvJAjQqtWjL6VYD3Qwmgf8JAaHVc7+qN89xNgtQQs9esMgwW5SC1eH
 rvb4KEuA==
X-Google-Smtp-Source: AGHT+IGjEvG8FxzE+YPRzHwKF7WJ6oGQvU141EO6GZh2XhIWjZAdh/JdXW0dPDE1WlMY3AEtDHZntg==
X-Received: by 2002:a05:6902:4883:b0:e84:4bf4:dbfc with SMTP id
 3f1490d57ef6-e8b85b98192mr2780559276.6.1752273976175; 
 Fri, 11 Jul 2025 15:46:16 -0700 (PDT)
Received: from IA1PR11MB7774.namprd11.prod.outlook.com ([2603:1036:207:832::5])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e8b7ae26ec8sm1385291276.8.2025.07.11.15.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 15:46:15 -0700 (PDT)
From: Zhiwei LIU <baxiantai@gmail.com>
To: =?gb2312?B?0LuyqA==?= <xb@ultrarisc.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "anup@brainfault.org" <anup@brainfault.org>,
 "anup.patel@wdc.com" <anup.patel@wdc.com>
Subject: Re: [PATCH for v10.0.0] target/riscv/kvm/kvm-cpu: Fixed the issue of
 resume after QEMU+KVM migration
Thread-Topic: [PATCH for v10.0.0] target/riscv/kvm/kvm-cpu: Fixed the issue of
 resume after QEMU+KVM migration
Thread-Index: AQHb8kZMYlLsxl5bRkeQs8dHiG8hzrQthdjB
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Fri, 11 Jul 2025 22:46:14 +0000
Message-ID: <IA1PR11MB77748F271FCEA18690232687FC4BA@IA1PR11MB7774.namprd11.prod.outlook.com>
References: <58a08318.d0.196e7eb9068.Coremail.xb@ultrarisc.com>
 <7a1f4eee.1a1.1970b8e1ccb.Coremail.xb@ultrarisc.com>
 <5d1fb28d.7df.197f8d04ed8.Coremail.xb@ultrarisc.com>
In-Reply-To: <5d1fb28d.7df.197f8d04ed8.Coremail.xb@ultrarisc.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
x-ms-reactions: allow
Content-Type: multipart/alternative;
 boundary="_000_IA1PR11MB77748F271FCEA18690232687FC4BAIA1PR11MB7774namp_"
MIME-Version: 1.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=baxiantai@gmail.com; helo=mail-yb1-xb2f.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_IA1PR11MB77748F271FCEA18690232687FC4BAIA1PR11MB7774namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SGkgWGllQm8sDQpDb3VsZCB5b3UgZ2l2ZSB0aGUgbWV0aG9kIG9uIGhvdyB0byB0ZXN0IGl0Pw0K
DQpUaGFua3MsDQpaaGl3ZWkNCg0Ku/HIoU91dGxvb2sgZm9yIEFuZHJvaWQ8aHR0cHM6Ly9ha2Eu
bXMvQUFiOXlzZz4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpGcm9tOiBxZW11
LWRldmVsLWJvdW5jZXMrYmF4aWFudGFpPWdtYWlsLmNvbUBub25nbnUub3JnIDxxZW11LWRldmVs
LWJvdW5jZXMrYmF4aWFudGFpPWdtYWlsLmNvbUBub25nbnUub3JnPiBvbiBiZWhhbGYgb2Yg0Luy
qCA8eGJAdWx0cmFyaXNjLmNvbT4NClNlbnQ6IEZyaWRheSwgSnVseSAxMSwgMjAyNSA1OjI4OjEw
IFBNDQpUbzogcWVtdS1kZXZlbEBub25nbnUub3JnIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQpD
YzogYWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+OyBw
YWxtZXJAZGFiYmVsdC5jb20gPHBhbG1lckBkYWJiZWx0LmNvbT47IHBib256aW5pQHJlZGhhdC5j
b20gPHBib256aW5pQHJlZGhhdC5jb20+OyBhbnVwQGJyYWluZmF1bHQub3JnIDxhbnVwQGJyYWlu
ZmF1bHQub3JnPjsgYW51cC5wYXRlbEB3ZGMuY29tIDxhbnVwLnBhdGVsQHdkYy5jb20+DQpTdWJq
ZWN0OiBbUEFUQ0ggZm9yIHYxMC4wLjBdIHRhcmdldC9yaXNjdi9rdm0va3ZtLWNwdTogRml4ZWQg
dGhlIGlzc3VlIG9mIHJlc3VtZSBhZnRlciBRRU1VK0tWTSBtaWdyYXRpb24NCg0KVGhpcyBpcyB2
MyBvZiB0aGlzIHBhdGNoIHRvIGZpeCBwYXRjaCBmb3JtYXQNCg0KVGhpcyBwYXRjaCBmaXhlcyB0
d28gY3JpdGljYWwgaXNzdWVzIGluIFFFTVUgd2l0aCBLVk06DQoxLiBQb3N0LU1pZ3JhdGlvbiBG
YWlsdXJlIGluIFVzZXIgTW9kZTogV2hlbiBRRU1VIHdpdGggS1ZNIGlzIHJ1bm5pbmcgaW4gdXNl
ciBtb2RlLCB0aGUgZ3Vlc3QgbWF5IGZhaWwgdG8gZnVuY3Rpb24gY29ycmVjdGx5IGFmdGVyIG1p
Z3JhdGlvbi4NCjIuIE11bHRpLUNvcmUgR3Vlc3QgSW5jb25zaXN0ZW5jeTogQWZ0ZXIgbWlncmF0
aW9uLCBvbmx5IHRoZSBmaXJzdCBDUFUgKGNvcmUgMCkgcmVtYWlucyBmdW5jdGlvbmFsLCB3aGls
ZSBhbGwgb3RoZXIgY29yZXMgYmVjb21lIHVucmVzcG9uc2l2ZS4NCg0KQ2hhbmdlcyBpbmNsdWRl
Og0KLSBQcm9wZXJseSByZXN0b3JpbmcgZ3Vlc3QgcHJpdmlsZWdlZCBzdGF0ZSBkdXJpbmcgcmVn
aXN0ZXIgc3luY2hyb25pemF0aW9uLg0KLSBDb3JyZWN0bHkgdXBkYXRpbmcgbXVsdGktY29yZSBz
dGF0ZSBhZnRlciBtaWdyYXRpb24gdG8gZW5zdXJlIGFsbCBjb3JlcyBhcmUgYWN0aXZlLg0KDQpT
aWduZWQtb2ZmLWJ5OiBYaWUgQm8gPHhiQHVsdHJhcmlzYy5jb20+DQotLS0NCiB0YXJnZXQvcmlz
Y3Yva3ZtL2t2bS1jcHUuYyB8IDIzICsrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNo
YW5nZWQsIDIzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9rdm0v
a3ZtLWNwdS5jIGIvdGFyZ2V0L3Jpc2N2L2t2bS9rdm0tY3B1LmMNCmluZGV4IDc1NzI0YjZhZjQu
LmExNWNhYTIwY2UgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYw0KKysr
IGIvdGFyZ2V0L3Jpc2N2L2t2bS9rdm0tY3B1LmMNCkBAIC01NzYsNiArNTc2LDE0IEBAIHN0YXRp
YyBpbnQga3ZtX3Jpc2N2X2dldF9yZWdzX2NvcmUoQ1BVU3RhdGUgKmNzKQ0KICAgICB9DQogICAg
IGVudi0+cGMgPSByZWc7DQoNCisgICAgLypSZXN0b3JlIHRoZSBndWVzdCdzIHByaXZpbGVnZWQg
bGV2ZWwgYWZ0ZXIgbWlncmF0aW9uKi8NCisgICAgcmV0ID0ga3ZtX2dldF9vbmVfcmVnKGNzLCBS
SVNDVl9DT1JFX1JFRyhlbnYsIG1vZGUpLCAmcmVnKTsNCisgICAgaWYgKHJldCkgew0KKyAgICAg
ICAgcmV0dXJuIHJldDsNCisgICAgfQ0KKyAgICBpZihyZWcgIT0gMykgew0KKyAgICAgICAgZW52
LT5wcml2ID0gcmVnOw0KKyAgICB9DQogICAgIGZvciAoaSA9IDE7IGkgPCAzMjsgaSsrKSB7DQog
ICAgICAgICB1aW50NjRfdCBpZCA9IGt2bV9yaXNjdl9yZWdfaWRfdWxvbmcoZW52LCBLVk1fUkVH
X1JJU0NWX0NPUkUsIGkpOw0KICAgICAgICAgcmV0ID0ga3ZtX2dldF9vbmVfcmVnKGNzLCBpZCwg
JnJlZyk7DQpAQCAtNjAxLDYgKzYwOSwxNSBAQCBzdGF0aWMgaW50IGt2bV9yaXNjdl9wdXRfcmVn
c19jb3JlKENQVVN0YXRlICpjcykNCiAgICAgICAgIHJldHVybiByZXQ7DQogICAgIH0NCg0KKyAg
ICAvKlNhdmUgZ3Vlc3QgcHJpdmlsZWdlIGxldmVsIGJlZm9yZSBtaWdyYXRpb24qLw0KKyAgICBy
ZWcgPSBlbnYtPnByaXY7DQorICAgIGlmKHJlZyAhPSAzKSB7DQorICAgICAgICByZXQgPSBrdm1f
c2V0X29uZV9yZWcoY3MsIFJJU0NWX0NPUkVfUkVHKGVudiwgbW9kZSksICZyZWcpOw0KKyAgICAg
ICAgaWYgKHJldCkgew0KKyAgICAgICAgICAgIHJldHVybiByZXQ7DQorICAgICAgICB9DQorICAg
IH0NCisNCiAgICAgZm9yIChpID0gMTsgaSA8IDMyOyBpKyspIHsNCiAgICAgICAgIHVpbnQ2NF90
IGlkID0ga3ZtX3Jpc2N2X3JlZ19pZF91bG9uZyhlbnYsIEtWTV9SRUdfUklTQ1ZfQ09SRSwgaSk7
DQogICAgICAgICByZWcgPSBlbnYtPmdwcltpXTsNCkBAIC0xMjg5LDYgKzEzMDYsMTIgQEAgaW50
IGt2bV9hcmNoX3B1dF9yZWdpc3RlcnMoQ1BVU3RhdGUgKmNzLCBpbnQgbGV2ZWwsIEVycm9yICoq
ZXJycCkNCiAgICAgICAgIHJldHVybiByZXQ7DQogICAgIH0NCg0KKyAgICAvKkVuc3VyZSBhbGwg
bm9uLWNvcmUgMCBDUFVzIGFyZSBydW5uYWJsZSBhZnRlciBtaWdyYXRpb24qLw0KKyAgICBpZigo
bGV2ZWwgPT0gS1ZNX1BVVF9GVUxMX1NUQVRFKSAmJiAoY3MtPmNwdV9pbmRleCAhPSAwKSl7DQor
ICAgICAgICBSSVNDVkNQVSAqY3B1ID0gUklTQ1ZfQ1BVKGNzKTsNCisgICAgICAgIHJldCA9IGt2
bV9yaXNjdl9zeW5jX21wc3RhdGVfdG9fa3ZtKGNwdSwgS1ZNX01QX1NUQVRFX1JVTk5BQkxFKTsN
CisgICAgfQ0KKw0KICAgICBpZiAoS1ZNX1BVVF9SRVNFVF9TVEFURSA9PSBsZXZlbCkgew0KICAg
ICAgICAgUklTQ1ZDUFUgKmNwdSA9IFJJU0NWX0NQVShjcyk7DQogICAgICAgICBpZiAoY3MtPmNw
dV9pbmRleCA9PSAwKSB7DQotLQ0KMi4zNC4xDQoNCg0KDQoNCj4gLS0tLS3Urcq808q8/i0tLS0t
DQo+ILeivP7Iyzog0LuyqCA8eGJAdWx0cmFyaXNjLmNvbT4NCj4gt6LLzcqxvOQ6MjAyNS0wNS0y
NiAxNTo0NTo1MiAo0MfG2tK7KQ0KPiDK1bz+yMs6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiCz
rcvNOiBhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20sIHBhbG1lckBkYWJiZWx0LmNvbSwgcGJvbnpp
bmlAcmVkaGF0LmNvbSwgYW51cEBicmFpbmZhdWx0Lm9yZywgYW51cC5wYXRlbEB3ZGMuY29tDQo+
INb3zOI6IFJlOiBbUEFUQ0ggVjJdIHRhcmdldC9yaXNjdi9rdm0va3ZtLWNwdTogRml4ZWQgdGhl
IGlzc3VlIG9mIHJlc3VtZSBhZnRlciBRRU1VK0tWTSBtaWdyYXRpb24NCj4NCj4gVGhpcyBpcyB2
MiBvZiB0aGlzIHBhdGNoIHdpdGggbm8gZnVuY3Rpb25hbCBjaGFuZ2VzOyBhZGRpbmcgQ0MuDQo+
DQo+IC0tLQ0KPiAgdGFyZ2V0L3Jpc2N2L2t2bS9rdm0tY3B1LmMgfCAyMyArKysrKysrKysrKysr
KysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykNCj4NCj4gLS0t
IGEvdGFyZ2V0L3Jpc2N2L2t2bS9rdm0tY3B1LmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2t2bS9r
dm0tY3B1LmMNCj4gQEAgLTU3Niw2ICs1NzYsMTQgQEAgc3RhdGljIGludCBrdm1fcmlzY3ZfZ2V0
X3JlZ3NfY29yZShDUFVTdGF0ZSAqY3MpDQo+ICAgICAgfQ0KPiAgICAgIGVudi0+cGMgPSByZWc7
DQo+DQo+ICsgICAgLyogUmVzdG9yZSBndWVzdCBwcml2aWxlZ2UgbGV2ZWwgYWZ0ZXIgbWlncmF0
aW9uICovDQo+ICsgICAgcmV0ID0ga3ZtX2dldF9vbmVfcmVnKGNzLCBSSVNDVl9DT1JFX1JFRyhl
bnYsIG1vZGUpLCAmcmVnKTsNCj4gKyAgICBpZiAocmV0KSB7DQo+ICsgICAgICAgIHJldHVybiBy
ZXQ7DQo+ICsgICAgfQ0KPiArICAgIGlmIChyZWcgIT0gMykgew0KPiArICAgICAgICBlbnYtPnBy
aXYgPSByZWc7DQo+ICsgICAgfQ0KPg0KPiAgICAgIGZvciAoaSA9IDE7IGkgPCAzMjsgaSsrKSB7
DQo+ICAgICAgICAgIHVpbnQ2NF90IGlkID0ga3ZtX3Jpc2N2X3JlZ19pZF91bG9uZyhlbnYsIEtW
TV9SRUdfUklTQ1ZfQ09SRSwgaSk7DQo+ICAgICAgICAgIHJldCA9IGt2bV9nZXRfb25lX3JlZyhj
cywgaWQsICZyZWcpOw0KPiBAQCAtNjAxLDYgKzYwOSwxNSBAQCBzdGF0aWMgaW50IGt2bV9yaXNj
dl9wdXRfcmVnc19jb3JlKENQVVN0YXRlICpjcykNCj4gICAgICAgICAgcmV0dXJuIHJldDsNCj4g
ICAgICB9DQo+DQo+ICsgICAgLyogU2F2ZSBndWVzdCBwcml2aWxlZ2UgbGV2ZWwgYmVmb3JlIG1p
Z3JhdGlvbiAqLw0KPiArICAgIHJlZyA9IGVudi0+cHJpdjsNCj4gKyAgICBpZiAocmVnICE9IDMp
IHsNCj4gKyAgICAgICAgcmV0ID0ga3ZtX3NldF9vbmVfcmVnKGNzLCBSSVNDVl9DT1JFX1JFRyhl
bnYsIG1vZGUpLCAmcmVnKTsNCj4gKyAgICAgICAgaWYgKHJldCkgew0KPiArICAgICAgICAgICAg
cmV0dXJuIHJldDsNCj4gKyAgICAgICAgfQ0KPiArICAgIH0NCj4gKw0KPiAgICAgIGZvciAoaSA9
IDE7IGkgPCAzMjsgaSsrKSB7DQo+ICAgICAgICAgIHVpbnQ2NF90IGlkID0ga3ZtX3Jpc2N2X3Jl
Z19pZF91bG9uZyhlbnYsIEtWTV9SRUdfUklTQ1ZfQ09SRSwgaSk7DQo+ICAgICAgICAgIHJlZyA9
IGVudi0+Z3ByW2ldOw0KPiBAQCAtMTI4OSw2ICsxMzA2LDEyIEBAIGludCBrdm1fYXJjaF9wdXRf
cmVnaXN0ZXJzKENQVVN0YXRlICpjcywgaW50IGxldmVsLCBFcnJvciAqKmVycnApDQo+ICAgICAg
ICAgIHJldHVybiByZXQ7DQo+ICAgICAgfQ0KPg0KPiArICAgIC8qIEVuc3VyZSBhbGwgbm9uLWNv
cmUgMCBDUFVzIGFyZSBydW5uYWJsZSBhZnRlciBtaWdyYXRpb24gKi8NCj4gKyAgICBpZiAoKGxl
dmVsID09IEtWTV9QVVRfRlVMTF9TVEFURSkgJiYgKGNzLT5jcHVfaW5kZXggIT0gMCkpIHsNCj4g
KyAgICAgICAgUklTQ1ZDUFUgKmNwdSA9IFJJU0NWX0NQVShjcyk7DQo+ICsgICAgICAgIHJldCA9
IGt2bV9yaXNjdl9zeW5jX21wc3RhdGVfdG9fa3ZtKGNwdSwgS1ZNX01QX1NUQVRFX1JVTk5BQkxF
KTsNCj4gKyAgICAgICAgaWYgKHJldCkgew0KPiArICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4g
KyAgICAgICAgfQ0KPiArICAgIH0NCj4NCj4gICAgICBpZiAoS1ZNX1BVVF9SRVNFVF9TVEFURSA9
PSBsZXZlbCkgew0KPiAgICAgICAgICBSSVNDVkNQVSAqY3B1ID0gUklTQ1ZfQ1BVKGNzKTsNCj4g
ICAgICAgICAgaWYgKGNzLT5jcHVfaW5kZXggPT0gMCkgew0KPiAtLQ0KPiAyLjM0LjENCj4NCj4N
Cj4NCj4NCj4gPiAtLS0tLdStyrzTyrz+LS0tLS0NCj4gPiC3orz+yMs6INC7sqggPHhiQHVsdHJh
cmlzYy5jb20+DQo+ID4gt6LLzcqxvOQ6MjAyNS0wNS0xOSAxNzo0MTozNiAo0MfG2tK7KQ0KPiA+
IMrVvP7IyzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+ID4gs63LzTogYWxpc3RhaXIuZnJhbmNp
c0B3ZGMuY29tLCBwYWxtZXJAZGFiYmVsdC5jb20sIHBib256aW5pQHJlZGhhdC5jb20NCj4gPiDW
98ziOiBbUEFUQ0hdIHRhcmdldC9yaXNjdi9rdm0va3ZtLWNwdTogRml4ZWQgdGhlIGlzc3VlIG9m
IHJlc3VtZSBhZnRlciBRRU1VK0tWTSBtaWdyYXRpb24NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggZml4
ZXMgdHdvIGNyaXRpY2FsIGlzc3VlcyBpbiBRRU1VIHdpdGggS1ZNOg0KPiA+DQo+ID4gMS4gUG9z
dC1NaWdyYXRpb24gRmFpbHVyZSBpbiBVc2VyIE1vZGU6IFdoZW4gUUVNVSB3aXRoIEtWTSBpcyBy
dW5uaW5nIGluIHVzZXIgbW9kZSwgdGhlIGd1ZXN0IG1heSBmYWlsIHRvIGZ1bmN0aW9uIGNvcnJl
Y3RseSBhZnRlciBtaWdyYXRpb24gZHVlIHRvIGluY29ycmVjdCBwcml2aWxlZ2Ugc3RhdGUgcmVz
dG9yYXRpb24uDQo+ID4NCj4gPiAyLiBNdWx0aS1Db3JlIEd1ZXN0IEluY29uc2lzdGVuY3k6IEFm
dGVyIG1pZ3JhdGlvbiwgb25seSB0aGUgZmlyc3QgQ1BVIChjb3JlIDApIHJlbWFpbnMgZnVuY3Rp
b25hbCwgd2hpbGUgYWxsIG90aGVyIGNvcmVzIGJlY29tZSB1bnJlc3BvbnNpdmUuIFRoaXMgcGF0
Y2ggZW5zdXJlcyBhbGwgY29yZXMgYXJlIHByb3Blcmx5IHNldCB0byBydW5uYWJsZSBzdGF0ZSBh
ZnRlciBtaWdyYXRpb24uDQo+ID4NCj4gPiBDaGFuZ2VzIGluY2x1ZGU6DQo+ID4gLSBQcm9wZXJs
eSByZXN0b3JpbmcgZ3Vlc3QgcHJpdmlsZWdlZCBzdGF0ZSBkdXJpbmcgcmVnaXN0ZXIgc3luY2hy
b25pemF0aW9uLg0KPiA+IC0gQ29ycmVjdGx5IHVwZGF0aW5nIG11bHRpLWNvcmUgc3RhdGUgYWZ0
ZXIgbWlncmF0aW9uIHRvIGVuc3VyZSBhbGwgY29yZXMgYXJlIGFjdGl2ZS4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFhpZSBCbyA8eGJAdWx0cmFyaXNjLmNvbT4NCj4gPg0KPiA+IC0tLQ0KPiA+
ICB0YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYyB8IDIzICsrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiAtLS0gYS90
YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYw0KPiA+ICsrKyBiL3RhcmdldC9yaXNjdi9rdm0va3Zt
LWNwdS5jDQo+ID4gQEAgLTU3Niw2ICs1NzYsMTQgQEAgc3RhdGljIGludCBrdm1fcmlzY3ZfZ2V0
X3JlZ3NfY29yZShDUFVTdGF0ZSAqY3MpDQo+ID4gICAgICB9DQo+ID4gICAgICBlbnYtPnBjID0g
cmVnOw0KPiA+DQo+ID4gKyAgICAvKiBSZXN0b3JlIGd1ZXN0IHByaXZpbGVnZSBsZXZlbCBhZnRl
ciBtaWdyYXRpb24gKi8NCj4gPiArICAgIHJldCA9IGt2bV9nZXRfb25lX3JlZyhjcywgUklTQ1Zf
Q09SRV9SRUcoZW52LCBtb2RlKSwgJnJlZyk7DQo+ID4gKyAgICBpZiAocmV0KSB7DQo+ID4gKyAg
ICAgICAgcmV0dXJuIHJldDsNCj4gPiArICAgIH0NCj4gPiArICAgIGlmIChyZWcgIT0gMykgew0K
PiA+ICsgICAgICAgIGVudi0+cHJpdiA9IHJlZzsNCj4gPiArICAgIH0NCj4gPg0KPiA+ICAgICAg
Zm9yIChpID0gMTsgaSA8IDMyOyBpKyspIHsNCj4gPiAgICAgICAgICB1aW50NjRfdCBpZCA9IGt2
bV9yaXNjdl9yZWdfaWRfdWxvbmcoZW52LCBLVk1fUkVHX1JJU0NWX0NPUkUsIGkpOw0KPiA+ICAg
ICAgICAgIHJldCA9IGt2bV9nZXRfb25lX3JlZyhjcywgaWQsICZyZWcpOw0KPiA+IEBAIC02MDEs
NiArNjA5LDE1IEBAIHN0YXRpYyBpbnQga3ZtX3Jpc2N2X3B1dF9yZWdzX2NvcmUoQ1BVU3RhdGUg
KmNzKQ0KPiA+ICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gICAgICB9DQo+ID4NCj4gPiArICAg
IC8qIFNhdmUgZ3Vlc3QgcHJpdmlsZWdlIGxldmVsIGJlZm9yZSBtaWdyYXRpb24gKi8NCj4gPiAr
ICAgIHJlZyA9IGVudi0+cHJpdjsNCj4gPiArICAgIGlmIChyZWcgIT0gMykgew0KPiA+ICsgICAg
ICAgIHJldCA9IGt2bV9zZXRfb25lX3JlZyhjcywgUklTQ1ZfQ09SRV9SRUcoZW52LCBtb2RlKSwg
JnJlZyk7DQo+ID4gKyAgICAgICAgaWYgKHJldCkgew0KPiA+ICsgICAgICAgICAgICByZXR1cm4g
cmV0Ow0KPiA+ICsgICAgICAgIH0NCj4gPiArICAgIH0NCj4gPiArDQo+ID4gICAgICBmb3IgKGkg
PSAxOyBpIDwgMzI7IGkrKykgew0KPiA+ICAgICAgICAgIHVpbnQ2NF90IGlkID0ga3ZtX3Jpc2N2
X3JlZ19pZF91bG9uZyhlbnYsIEtWTV9SRUdfUklTQ1ZfQ09SRSwgaSk7DQo+ID4gICAgICAgICAg
cmVnID0gZW52LT5ncHJbaV07DQo+ID4gQEAgLTEyODksNiArMTMwNiwxMiBAQCBpbnQga3ZtX2Fy
Y2hfcHV0X3JlZ2lzdGVycyhDUFVTdGF0ZSAqY3MsIGludCBsZXZlbCwgRXJyb3IgKiplcnJwKQ0K
PiA+ICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gICAgICB9DQo+ID4NCj4gPiArICAgIC8qIEVu
c3VyZSBhbGwgbm9uLWNvcmUgMCBDUFVzIGFyZSBydW5uYWJsZSBhZnRlciBtaWdyYXRpb24gKi8N
Cj4gPiArICAgIGlmICgobGV2ZWwgPT0gS1ZNX1BVVF9GVUxMX1NUQVRFKSAmJiAoY3MtPmNwdV9p
bmRleCAhPSAwKSkgew0KPiA+ICsgICAgICAgIFJJU0NWQ1BVICpjcHUgPSBSSVNDVl9DUFUoY3Mp
Ow0KPiA+ICsgICAgICAgIHJldCA9IGt2bV9yaXNjdl9zeW5jX21wc3RhdGVfdG9fa3ZtKGNwdSwg
S1ZNX01QX1NUQVRFX1JVTk5BQkxFKTsNCj4gPiArICAgICAgICBpZiAocmV0KSB7DQo+ID4gKyAg
ICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+DQo+
ID4gICAgICBpZiAoS1ZNX1BVVF9SRVNFVF9TVEFURSA9PSBsZXZlbCkgew0KPiA+ICAgICAgICAg
IFJJU0NWQ1BVICpjcHUgPSBSSVNDVl9DUFUoY3MpOw0KPiA+ICAgICAgICAgIGlmIChjcy0+Y3B1
X2luZGV4ID09IDApIHsNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo+ID4gX19fX19fX19fX19f
X19fX19fX19fX3d3dy51bHRyYXJpc2MuY29tDQo+ID4g1tjSqszhyr6jurG+08q8/rD8wKi4vbz+
tcTE2sjdysfK3Leowsmxo7uktcSxo8Pc0MXPoqOsyOe5+8T6srvKx9a4tqjK1bz+yMujrMfrwaK8
tL2rsb7Tyrz+yb6z/aOst6jCyb371rnIzrrOt8e3qLXExfvCtqGiuLTWxqGitKuypbvy0tTIzrrO
t73Kvcq508OxvtPKvP6ho7G+08q8/tbQsPy6rLXE0uK8+6GivajS6crHu/nT2rvyyty1vc7St72x
7bTvus22qNLltcTM9b/uvLDM9bz+tcTP3raoo6zI587eztK3vbXE1f3Kvcrpw+azzsflu/LK2sio
o6yyu7/Jsbu1pbbA1/fOqsjOus7H6dDOz8K1xNakvt278tLAvt2ho7jQ0LvE+rXEwO294tPrxeS6
z6GjsObIqMv509Cho0lNUE9SVEFOVCBOT1RJQ0U6IFRoaXMgZW1haWwsIGluY2x1ZGluZyBpdHMg
YXR0YWNobWVudCBpZiBhbnksIGlzIGNvbmZpZGVudGlhbC4gSWYgeW91IGFyZSBub3QgdGhlIGlu
dGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIGRlbGV0ZSBpdCBmcm9tIHlvdXIgY29tcHV0ZXIgaW1t
ZWRpYXRlbHkuIEFueSBkaXNjbG9zdXJlLCBjb3B5aW5nLCBvciBkaXN0cmlidXRpb24gb2YgdGhp
cyBtZXNzYWdlLCBvciB0YWtpbmcgb2YgYW55IGFjdGlvbiBiYXNlZCBvbiBpdCBpcyBzdHJpY3Rs
eSBwcm9oaWJpdGVkLiAgQW55IG9waW5pb25zIGFuZCBzdWdnZXN0aW9ucyBjb250YWluZWQgaW4g
dGhpcyBlbWFpbCBhcmUgc3ViamVjdCB0byB0aGUgdGVybXMgYW5kIGNvbmRpdGlvbnMgZXhwcmVz
c2VkIGFuZCBkZWZpbmVkIGJ5IHVzIGFuZCBzaG91bGQgbm90IGJlIHJlbGllZCB1cG9uIHVuY29u
ZGl0aW9uYWxseSB1bmRlciBhbnkgY2lyY3Vtc3RhbmNlcyB1bmxlc3MgdGhleSBhcmUgY29uZmly
bWVkIGluIG9mZmljaWFsIHdyaXR0ZW4gY2xhcmlmaWNhdGlvbiBvciBhdXRob3JpemF0aW9uIGZy
b20gdXMuICBUaGFuayB5b3UgZm9yIHlvdXIgdW5kZXJzdGFuZGluZyBhbmQgY29vcGVyYXRpb24u
QWxsIHJpZ2h0cyByZXNlcnZlZC4NCj4NCj4NCj4gX19fX19fX19fX19fX19fX19fX19fX3d3dy51
bHRyYXJpc2MuY29tDQo+INbY0qrM4cq+o7qxvtPKvP6w/MCouL28/rXExNrI3crHyty3qMLJsaO7
pLXEsaPD3NDFz6KjrMjnufvE+rK7ysfWuLaoytW8/sjLo6zH68GivLS9q7G+08q8/sm+s/2jrLeo
wsm9+9a5yM66zrfHt6i1xMX7wrahori01sahorSrsqW78tLUyM66zre9yr3KudPDsb7Tyrz+oaOx
vtPKvP7W0LD8uqy1xNLivPuhor2o0unKx7v509q78srctb3O0re9se2077rNtqjS5bXEzPW/7ryw
zPW8/rXEz962qKOsyOfO3s7St721xNX9yr3K6cPms87H5bvyytrIqKOssru/ybG7taW2wNf3zqrI
zrrOx+nQzs/CtcTWpL7du/LSwL7doaO40NC7xPq1xMDtveLT68Xkus+ho7DmyKjL+dPQoaNJTVBP
UlRBTlQgTk9USUNFOiBUaGlzIGVtYWlsLCBpbmNsdWRpbmcgaXRzIGF0dGFjaG1lbnQgaWYgYW55
LCBpcyBjb25maWRlbnRpYWwuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQs
IHBsZWFzZSBkZWxldGUgaXQgZnJvbSB5b3VyIGNvbXB1dGVyIGltbWVkaWF0ZWx5LiBBbnkgZGlz
Y2xvc3VyZSwgY29weWluZywgb3IgZGlzdHJpYnV0aW9uIG9mIHRoaXMgbWVzc2FnZSwgb3IgdGFr
aW5nIG9mIGFueSBhY3Rpb24gYmFzZWQgb24gaXQgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4gIEFu
eSBvcGluaW9ucyBhbmQgc3VnZ2VzdGlvbnMgY29udGFpbmVkIGluIHRoaXMgZW1haWwgYXJlIHN1
YmplY3QgdG8gdGhlIHRlcm1zIGFuZCBjb25kaXRpb25zIGV4cHJlc3NlZCBhbmQgZGVmaW5lZCBi
eSB1cyBhbmQgc2hvdWxkIG5vdCBiZSByZWxpZWQgdXBvbiB1bmNvbmRpdGlvbmFsbHkgdW5kZXIg
YW55IGNpcmN1bXN0YW5jZXMgdW5sZXNzIHRoZXkgYXJlIGNvbmZpcm1lZCBpbiBvZmZpY2lhbCB3
cml0dGVuIGNsYXJpZmljYXRpb24gb3IgYXV0aG9yaXphdGlvbiBmcm9tIHVzLiAgVGhhbmsgeW91
IGZvciB5b3VyIHVuZGVyc3RhbmRpbmcgYW5kIGNvb3BlcmF0aW9uLkFsbCByaWdodHMgcmVzZXJ2
ZWQuDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX3d3dy51bHRyYXJpc2MuY29tDQrW2NKqzOHK
vqO6sb7Tyrz+sPzAqLi9vP61xMTayN3Kx8rct6jCybGju6S1xLGjw9zQxc+io6zI57n7xPqyu8rH
1ri2qMrVvP7Iy6Osx+vBory0vauxvtPKvP7JvrP9o6y3qMLJvfvWucjOus63x7eotcTF+8K2oaK4
tNbGoaK0q7Klu/LS1MjOus63vcq9yrnTw7G+08q8/qGjsb7Tyrz+1tCw/LqstcTS4rz7oaK9qNLp
yse7+dPau/LK3LW9ztK3vbHttO+6zbao0uW1xMz1v+68sMz1vP61xM/etqijrMjnzt7O0re9tcTV
/cq9yunD5rPOx+W78srayKijrLK7v8mxu7WltsDX986qyM66zsfp0M7PwrXE1qS+3bvy0sC+3aGj
uNDQu8T6tcTA7b3i0+vF5LrPoaOw5sioy/nT0KGjSU1QT1JUQU5UIE5PVElDRTogVGhpcyBlbWFp
bCwgaW5jbHVkaW5nIGl0cyBhdHRhY2htZW50IGlmIGFueSwgaXMgY29uZmlkZW50aWFsLiBJZiB5
b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2UgZGVsZXRlIGl0IGZyb20g
eW91ciBjb21wdXRlciBpbW1lZGlhdGVseS4gQW55IGRpc2Nsb3N1cmUsIGNvcHlpbmcsIG9yIGRp
c3RyaWJ1dGlvbiBvZiB0aGlzIG1lc3NhZ2UsIG9yIHRha2luZyBvZiBhbnkgYWN0aW9uIGJhc2Vk
IG9uIGl0IGlzIHN0cmljdGx5IHByb2hpYml0ZWQuICBBbnkgb3BpbmlvbnMgYW5kIHN1Z2dlc3Rp
b25zIGNvbnRhaW5lZCBpbiB0aGlzIGVtYWlsIGFyZSBzdWJqZWN0IHRvIHRoZSB0ZXJtcyBhbmQg
Y29uZGl0aW9ucyBleHByZXNzZWQgYW5kIGRlZmluZWQgYnkgdXMgYW5kIHNob3VsZCBub3QgYmUg
cmVsaWVkIHVwb24gdW5jb25kaXRpb25hbGx5IHVuZGVyIGFueSBjaXJjdW1zdGFuY2VzIHVubGVz
cyB0aGV5IGFyZSBjb25maXJtZWQgaW4gb2ZmaWNpYWwgd3JpdHRlbiBjbGFyaWZpY2F0aW9uIG9y
IGF1dGhvcml6YXRpb24gZnJvbSB1cy4gIFRoYW5rIHlvdSBmb3IgeW91ciB1bmRlcnN0YW5kaW5n
IGFuZCBjb29wZXJhdGlvbi5BbGwgcmlnaHRzIHJlc2VydmVkLg0K

--_000_IA1PR11MB77748F271FCEA18690232687FC4BAIA1PR11MB7774namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Hi XieBo,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Could you give the method on how to test it?</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
<br>
</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Thanks,</div>
<div dir=3D"auto" style=3D"font-family: Aptos, Aptos_MSFontService, -apple-=
system, Roboto, Arial, Helvetica, sans-serif; font-size: 12pt;">
Zhiwei</div>
<div id=3D"ms-outlook-mobile-body-separator-line" dir=3D"auto"><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto" style=3D"font-family: =
Aptos, Aptos_MSFontService, -apple-system, Roboto, Arial, Helvetica, sans-s=
erif; font-size: 12pt;">
=BB=F1=C8=A1<a href=3D"https://aka.ms/AAb9ysg">Outlook for Android</a></div=
>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> qemu-devel-bounces+ba=
xiantai=3Dgmail.com@nongnu.org &lt;qemu-devel-bounces+baxiantai=3Dgmail.com=
@nongnu.org&gt; on behalf of =D0=BB=B2=A8 &lt;xb@ultrarisc.com&gt;<br>
<b>Sent:</b> Friday, July 11, 2025 5:28:10 PM<br>
<b>To:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b> alistair.francis@wdc.com &lt;alistair.francis@wdc.com&gt;; palme=
r@dabbelt.com &lt;palmer@dabbelt.com&gt;; pbonzini@redhat.com &lt;pbonzini@=
redhat.com&gt;; anup@brainfault.org &lt;anup@brainfault.org&gt;; anup.patel=
@wdc.com &lt;anup.patel@wdc.com&gt;<br>
<b>Subject:</b> [PATCH for v10.0.0] target/riscv/kvm/kvm-cpu: Fixed the iss=
ue of resume after QEMU+KVM migration</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This is v3 of this patch to fix patch format<br>
<br>
This patch fixes two critical issues in QEMU with KVM:<br>
1. Post-Migration Failure in User Mode: When QEMU with KVM is running in us=
er mode, the guest may fail to function correctly after migration.<br>
2. Multi-Core Guest Inconsistency: After migration, only the first CPU (cor=
e 0) remains functional, while all other cores become unresponsive.<br>
<br>
Changes include:<br>
- Properly restoring guest privileged state during register synchronization=
.<br>
- Correctly updating multi-core state after migration to ensure all cores a=
re active.<br>
<br>
Signed-off-by: Xie Bo &lt;xb@ultrarisc.com&gt;<br>
---<br>
&nbsp;target/riscv/kvm/kvm-cpu.c | 23 +++++++++++++++++++++++<br>
&nbsp;1 file changed, 23 insertions(+)<br>
<br>
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c<br>
index 75724b6af4..a15caa20ce 100644<br>
--- a/target/riscv/kvm/kvm-cpu.c<br>
+++ b/target/riscv/kvm/kvm-cpu.c<br>
@@ -576,6 +576,14 @@ static int kvm_riscv_get_regs_core(CPUState *cs)<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp; env-&gt;pc =3D reg;<br>
<br>
+&nbsp;&nbsp;&nbsp; /*Restore the guest's privileged level after migration*=
/<br>
+&nbsp;&nbsp;&nbsp; ret =3D kvm_get_one_reg(cs, RISCV_CORE_REG(env, mode), =
&amp;reg);<br>
+&nbsp;&nbsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; if(reg !=3D 3) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; env-&gt;priv =3D reg;<br>
+&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 1; i &lt; 32; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t id =3D kvm_riscv_=
reg_id_ulong(env, KVM_REG_RISCV_CORE, i);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kvm_get_one_reg(cs=
, id, &amp;reg);<br>
@@ -601,6 +609,15 @@ static int kvm_riscv_put_regs_core(CPUState *cs)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
+&nbsp;&nbsp;&nbsp; /*Save guest privilege level before migration*/<br>
+&nbsp;&nbsp;&nbsp; reg =3D env-&gt;priv;<br>
+&nbsp;&nbsp;&nbsp; if(reg !=3D 3) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kvm_set_one_reg(cs, RIS=
CV_CORE_REG(env, mode), &amp;reg);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 1; i &lt; 32; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t id =3D kvm_riscv_=
reg_id_ulong(env, KVM_REG_RISCV_CORE, i);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D env-&gt;gpr[i];<br=
>
@@ -1289,6 +1306,12 @@ int kvm_arch_put_registers(CPUState *cs, int level, =
Error **errp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
+&nbsp;&nbsp;&nbsp; /*Ensure all non-core 0 CPUs are runnable after migrati=
on*/<br>
+&nbsp;&nbsp;&nbsp; if((level =3D=3D KVM_PUT_FULL_STATE) &amp;&amp; (cs-&gt=
;cpu_index !=3D 0)){<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RISCVCPU *cpu =3D RISCV_CPU(cs)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kvm_riscv_sync_mpstate_=
to_kvm(cpu, KVM_MP_STATE_RUNNABLE);<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (KVM_PUT_RESET_STATE =3D=3D level) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RISCVCPU *cpu =3D RISCV_CP=
U(cs);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cs-&gt;cpu_index =3D=
=3D 0) {<br>
--<br>
2.34.1<br>
<br>
<br>
<br>
<br>
&gt; -----=D4=AD=CA=BC=D3=CA=BC=FE-----<br>
&gt; =B7=A2=BC=FE=C8=CB: =D0=BB=B2=A8 &lt;xb@ultrarisc.com&gt;<br>
&gt; =B7=A2=CB=CD=CA=B1=BC=E4:2025-05-26 15:45:52 (=D0=C7=C6=DA=D2=BB)<br>
&gt; =CA=D5=BC=FE=C8=CB: qemu-devel@nongnu.org<br>
&gt; =B3=AD=CB=CD: alistair.francis@wdc.com, palmer@dabbelt.com, pbonzini@r=
edhat.com, anup@brainfault.org, anup.patel@wdc.com<br>
&gt; =D6=F7=CC=E2: Re: [PATCH V2] target/riscv/kvm/kvm-cpu: Fixed the issue=
 of resume after QEMU+KVM migration<br>
&gt; <br>
&gt; This is v2 of this patch with no functional changes; adding CC.<br>
&gt; <br>
&gt; ---<br>
&gt;&nbsp; target/riscv/kvm/kvm-cpu.c | 23 +++++++++++++++++++++++<br>
&gt;&nbsp; 1 file changed, 23 insertions(+)<br>
&gt; <br>
&gt; --- a/target/riscv/kvm/kvm-cpu.c<br>
&gt; +++ b/target/riscv/kvm/kvm-cpu.c<br>
&gt; @@ -576,6 +576,14 @@ static int kvm_riscv_get_regs_core(CPUState *cs)<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; env-&gt;pc =3D reg;<br>
&gt; <br>
&gt; +&nbsp;&nbsp;&nbsp; /* Restore guest privilege level after migration *=
/<br>
&gt; +&nbsp;&nbsp;&nbsp; ret =3D kvm_get_one_reg(cs, RISCV_CORE_REG(env, mo=
de), &amp;reg);<br>
&gt; +&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp; if (reg !=3D 3) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; env-&gt;priv =3D reg;<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 1; i &lt; 32; i++) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t id =3D =
kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, i);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kvm_get_=
one_reg(cs, id, &amp;reg);<br>
&gt; @@ -601,6 +609,15 @@ static int kvm_riscv_put_regs_core(CPUState *cs)<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; +&nbsp;&nbsp;&nbsp; /* Save guest privilege level before migration */<=
br>
&gt; +&nbsp;&nbsp;&nbsp; reg =3D env-&gt;priv;<br>
&gt; +&nbsp;&nbsp;&nbsp; if (reg !=3D 3) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kvm_set_one_reg(cs=
, RISCV_CORE_REG(env, mode), &amp;reg);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 1; i &lt; 32; i++) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t id =3D =
kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, i);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D env-&gt;=
gpr[i];<br>
&gt; @@ -1289,6 +1306,12 @@ int kvm_arch_put_registers(CPUState *cs, int le=
vel, Error **errp)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; +&nbsp;&nbsp;&nbsp; /* Ensure all non-core 0 CPUs are runnable after m=
igration */<br>
&gt; +&nbsp;&nbsp;&nbsp; if ((level =3D=3D KVM_PUT_FULL_STATE) &amp;&amp; (=
cs-&gt;cpu_index !=3D 0)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RISCVCPU *cpu =3D RISCV_CP=
U(cs);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kvm_riscv_sync_mps=
tate_to_kvm(cpu, KVM_MP_STATE_RUNNABLE);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn ret;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KVM_PUT_RESET_STATE =3D=3D level) {<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RISCVCPU *cpu =
=3D RISCV_CPU(cs);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cs-&gt;cpu_i=
ndex =3D=3D 0) {<br>
&gt; -- <br>
&gt; 2.34.1<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; &gt; -----=D4=AD=CA=BC=D3=CA=BC=FE-----<br>
&gt; &gt; =B7=A2=BC=FE=C8=CB: =D0=BB=B2=A8 &lt;xb@ultrarisc.com&gt;<br>
&gt; &gt; =B7=A2=CB=CD=CA=B1=BC=E4:2025-05-19 17:41:36 (=D0=C7=C6=DA=D2=BB)=
<br>
&gt; &gt; =CA=D5=BC=FE=C8=CB: qemu-devel@nongnu.org<br>
&gt; &gt; =B3=AD=CB=CD: alistair.francis@wdc.com, palmer@dabbelt.com, pbonz=
ini@redhat.com<br>
&gt; &gt; =D6=F7=CC=E2: [PATCH] target/riscv/kvm/kvm-cpu: Fixed the issue o=
f resume after QEMU+KVM migration<br>
&gt; &gt; <br>
&gt; &gt; This patch fixes two critical issues in QEMU with KVM:<br>
&gt; &gt; <br>
&gt; &gt; 1. Post-Migration Failure in User Mode: When QEMU with KVM is run=
ning in user mode, the guest may fail to function correctly after migration=
 due to incorrect privilege state restoration.<br>
&gt; &gt; <br>
&gt; &gt; 2. Multi-Core Guest Inconsistency: After migration, only the firs=
t CPU (core 0) remains functional, while all other cores become unresponsiv=
e. This patch ensures all cores are properly set to runnable state after mi=
gration.<br>
&gt; &gt; <br>
&gt; &gt; Changes include:<br>
&gt; &gt; - Properly restoring guest privileged state during register synch=
ronization.<br>
&gt; &gt; - Correctly updating multi-core state after migration to ensure a=
ll cores are active.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Xie Bo &lt;xb@ultrarisc.com&gt;<br>
&gt; &gt; <br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; target/riscv/kvm/kvm-cpu.c | 23 +++++++++++++++++++++++<br>
&gt; &gt;&nbsp; 1 file changed, 23 insertions(+)<br>
&gt; &gt; <br>
&gt; &gt; --- a/target/riscv/kvm/kvm-cpu.c<br>
&gt; &gt; +++ b/target/riscv/kvm/kvm-cpu.c<br>
&gt; &gt; @@ -576,6 +576,14 @@ static int kvm_riscv_get_regs_core(CPUState =
*cs)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; env-&gt;pc =3D reg;<br>
&gt; &gt; <br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; /* Restore guest privilege level after migrat=
ion */<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; ret =3D kvm_get_one_reg(cs, RISCV_CORE_REG(en=
v, mode), &amp;reg);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; if (reg !=3D 3) {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; env-&gt;priv =3D reg;=
<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; <br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 1; i &lt; 32; i++) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t id=
 =3D kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, i);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kvm=
_get_one_reg(cs, id, &amp;reg);<br>
&gt; &gt; @@ -601,6 +609,15 @@ static int kvm_riscv_put_regs_core(CPUState =
*cs)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;=
<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; <br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; /* Save guest privilege level before migratio=
n */<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; reg =3D env-&gt;priv;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; if (reg !=3D 3) {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kvm_set_one_r=
eg(cs, RISCV_CORE_REG(env, mode), &amp;reg);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return ret;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; +<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 1; i &lt; 32; i++) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t id=
 =3D kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, i);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D env=
-&gt;gpr[i];<br>
&gt; &gt; @@ -1289,6 +1306,12 @@ int kvm_arch_put_registers(CPUState *cs, i=
nt level, Error **errp)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;=
<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; <br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; /* Ensure all non-core 0 CPUs are runnable af=
ter migration */<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; if ((level =3D=3D KVM_PUT_FULL_STATE) &amp;&a=
mp; (cs-&gt;cpu_index !=3D 0)) {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RISCVCPU *cpu =3D RIS=
CV_CPU(cs);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kvm_riscv_syn=
c_mpstate_to_kvm(cpu, KVM_MP_STATE_RUNNABLE);<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return ret;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; <br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (KVM_PUT_RESET_STATE =3D=3D leve=
l) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RISCVCPU *c=
pu =3D RISCV_CPU(cs);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cs-&gt;=
cpu_index =3D=3D 0) {<br>
&gt; &gt; -- <br>
&gt; &gt; 2.34.1<br>
&gt; &gt; <br>
&gt; &gt; ______________________www.ultrarisc.com<br>
&gt; &gt; =D6=D8=D2=AA=CC=E1=CA=BE=A3=BA=B1=BE=D3=CA=BC=FE=B0=FC=C0=A8=B8=
=BD=BC=FE=B5=C4=C4=DA=C8=DD=CA=C7=CA=DC=B7=A8=C2=C9=B1=A3=BB=A4=B5=C4=B1=A3=
=C3=DC=D0=C5=CF=A2=A3=AC=C8=E7=B9=FB=C4=FA=B2=BB=CA=C7=D6=B8=B6=A8=CA=D5=BC=
=FE=C8=CB=A3=AC=C7=EB=C1=A2=BC=B4=BD=AB=B1=BE=D3=CA=BC=FE=C9=BE=B3=FD=A3=AC=
=B7=A8=C2=C9=BD=FB=D6=B9=C8=CE=BA=CE=B7=C7=B7=A8=B5=C4=C5=FB=C2=B6=A1=A2=B8=
=B4=D6=C6=A1=A2=B4=AB=B2=A5=BB=F2=D2=D4=C8=CE=BA=CE=B7=BD=CA=BD=CA=B9=D3=C3=
=B1=BE=D3=CA=BC=FE=A1=A3=B1=BE=D3=CA=BC=FE=D6=D0=B0=FC=BA=AC=B5=C4=D2=E2=BC=
=FB=A1=A2=BD=A8=D2=E9=CA=C7=BB=F9=D3=DA=BB=F2=CA=DC=B5=BD=CE=D2=B7=BD=B1=ED=
=B4=EF=BA=CD=B6=A8=D2=E5=B5=C4=CC=F5=BF=EE=BC=B0=CC=F5=BC=FE=B5=C4=CF=DE=B6=
=A8=A3=AC=C8=E7=CE=DE=CE=D2=B7=BD=B5=C4=D5=FD=CA=BD=CA=E9=C3=E6=B3=CE=C7=E5=
=BB=F2=CA=DA=C8=A8=A3=AC=B2=BB=BF=C9=B1=BB=B5=A5=B6=C0=D7=F7=CE=AA=C8=CE=BA=
=CE=C7=E9=D0=CE=CF=C2=B5=C4=D6=A4=BE=DD=BB=F2=D2=C0=BE=DD=A1=A3=B8=D0=D0=BB=
=C4=FA=B5=C4=C0=ED=BD=E2=D3=EB=C5=E4=BA=CF=A1=A3=B0=E6=C8=A8=CB=F9=D3=D0=A1=
=A3IMPORTANT NOTICE: This email, including its attachment if any, is confid=
ential. If you are not
 the intended recipient, please delete it from your computer immediately. A=
ny disclosure, copying, or distribution of this message, or taking of any a=
ction based on it is strictly prohibited.&nbsp; Any opinions and suggestion=
s contained in this email are subject
 to the terms and conditions expressed and defined by us and should not be =
relied upon unconditionally under any circumstances unless they are confirm=
ed in official written clarification or authorization from us.&nbsp; Thank =
you for your understanding and cooperation.All
 rights reserved.<br>
&gt; <br>
&gt; <br>
&gt; ______________________www.ultrarisc.com<br>
&gt; =D6=D8=D2=AA=CC=E1=CA=BE=A3=BA=B1=BE=D3=CA=BC=FE=B0=FC=C0=A8=B8=BD=BC=
=FE=B5=C4=C4=DA=C8=DD=CA=C7=CA=DC=B7=A8=C2=C9=B1=A3=BB=A4=B5=C4=B1=A3=C3=DC=
=D0=C5=CF=A2=A3=AC=C8=E7=B9=FB=C4=FA=B2=BB=CA=C7=D6=B8=B6=A8=CA=D5=BC=FE=C8=
=CB=A3=AC=C7=EB=C1=A2=BC=B4=BD=AB=B1=BE=D3=CA=BC=FE=C9=BE=B3=FD=A3=AC=B7=A8=
=C2=C9=BD=FB=D6=B9=C8=CE=BA=CE=B7=C7=B7=A8=B5=C4=C5=FB=C2=B6=A1=A2=B8=B4=D6=
=C6=A1=A2=B4=AB=B2=A5=BB=F2=D2=D4=C8=CE=BA=CE=B7=BD=CA=BD=CA=B9=D3=C3=B1=BE=
=D3=CA=BC=FE=A1=A3=B1=BE=D3=CA=BC=FE=D6=D0=B0=FC=BA=AC=B5=C4=D2=E2=BC=FB=A1=
=A2=BD=A8=D2=E9=CA=C7=BB=F9=D3=DA=BB=F2=CA=DC=B5=BD=CE=D2=B7=BD=B1=ED=B4=EF=
=BA=CD=B6=A8=D2=E5=B5=C4=CC=F5=BF=EE=BC=B0=CC=F5=BC=FE=B5=C4=CF=DE=B6=A8=A3=
=AC=C8=E7=CE=DE=CE=D2=B7=BD=B5=C4=D5=FD=CA=BD=CA=E9=C3=E6=B3=CE=C7=E5=BB=F2=
=CA=DA=C8=A8=A3=AC=B2=BB=BF=C9=B1=BB=B5=A5=B6=C0=D7=F7=CE=AA=C8=CE=BA=CE=C7=
=E9=D0=CE=CF=C2=B5=C4=D6=A4=BE=DD=BB=F2=D2=C0=BE=DD=A1=A3=B8=D0=D0=BB=C4=FA=
=B5=C4=C0=ED=BD=E2=D3=EB=C5=E4=BA=CF=A1=A3=B0=E6=C8=A8=CB=F9=D3=D0=A1=A3IMP=
ORTANT NOTICE: This email, including its attachment if any, is confidential=
. If you are not
 the intended recipient, please delete it from your computer immediately. A=
ny disclosure, copying, or distribution of this message, or taking of any a=
ction based on it is strictly prohibited.&nbsp; Any opinions and suggestion=
s contained in this email are subject
 to the terms and conditions expressed and defined by us and should not be =
relied upon unconditionally under any circumstances unless they are confirm=
ed in official written clarification or authorization from us.&nbsp; Thank =
you for your understanding and cooperation.All
 rights reserved.<br>
<br>
<br>
______________________www.ultrarisc.com<br>
=D6=D8=D2=AA=CC=E1=CA=BE=A3=BA=B1=BE=D3=CA=BC=FE=B0=FC=C0=A8=B8=BD=BC=FE=B5=
=C4=C4=DA=C8=DD=CA=C7=CA=DC=B7=A8=C2=C9=B1=A3=BB=A4=B5=C4=B1=A3=C3=DC=D0=C5=
=CF=A2=A3=AC=C8=E7=B9=FB=C4=FA=B2=BB=CA=C7=D6=B8=B6=A8=CA=D5=BC=FE=C8=CB=A3=
=AC=C7=EB=C1=A2=BC=B4=BD=AB=B1=BE=D3=CA=BC=FE=C9=BE=B3=FD=A3=AC=B7=A8=C2=C9=
=BD=FB=D6=B9=C8=CE=BA=CE=B7=C7=B7=A8=B5=C4=C5=FB=C2=B6=A1=A2=B8=B4=D6=C6=A1=
=A2=B4=AB=B2=A5=BB=F2=D2=D4=C8=CE=BA=CE=B7=BD=CA=BD=CA=B9=D3=C3=B1=BE=D3=CA=
=BC=FE=A1=A3=B1=BE=D3=CA=BC=FE=D6=D0=B0=FC=BA=AC=B5=C4=D2=E2=BC=FB=A1=A2=BD=
=A8=D2=E9=CA=C7=BB=F9=D3=DA=BB=F2=CA=DC=B5=BD=CE=D2=B7=BD=B1=ED=B4=EF=BA=CD=
=B6=A8=D2=E5=B5=C4=CC=F5=BF=EE=BC=B0=CC=F5=BC=FE=B5=C4=CF=DE=B6=A8=A3=AC=C8=
=E7=CE=DE=CE=D2=B7=BD=B5=C4=D5=FD=CA=BD=CA=E9=C3=E6=B3=CE=C7=E5=BB=F2=CA=DA=
=C8=A8=A3=AC=B2=BB=BF=C9=B1=BB=B5=A5=B6=C0=D7=F7=CE=AA=C8=CE=BA=CE=C7=E9=D0=
=CE=CF=C2=B5=C4=D6=A4=BE=DD=BB=F2=D2=C0=BE=DD=A1=A3=B8=D0=D0=BB=C4=FA=B5=C4=
=C0=ED=BD=E2=D3=EB=C5=E4=BA=CF=A1=A3=B0=E6=C8=A8=CB=F9=D3=D0=A1=A3IMPORTANT=
 NOTICE: This email, including its attachment if any, is confidential. If y=
ou are not the
 intended recipient, please delete it from your computer immediately. Any d=
isclosure, copying, or distribution of this message, or taking of any actio=
n based on it is strictly prohibited.&nbsp; Any opinions and suggestions co=
ntained in this email are subject to
 the terms and conditions expressed and defined by us and should not be rel=
ied upon unconditionally under any circumstances unless they are confirmed =
in official written clarification or authorization from us.&nbsp; Thank you=
 for your understanding and cooperation.All
 rights reserved.</div>
</span></font></div>
</body>
</html>

--_000_IA1PR11MB77748F271FCEA18690232687FC4BAIA1PR11MB7774namp_--

