Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7449FE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 09:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOZRD-0002AJ-Gg; Fri, 20 Dec 2024 04:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tOZRB-0002A6-HN
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 04:36:49 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tOZR9-000095-T1
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 04:36:49 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-72739105e02so1836233b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 01:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1734687406; x=1735292206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fwtMOspPTsliAPgaOSgL81eS5X/8EjwJ+cEcVrGmXLY=;
 b=H7s4WtDamzyjTB+nlax84WKUt/RrUMpDykX2ubAjbmEeba7Ls2FMrRgL+eQqIYHQ7m
 0XAFB+a3nli4Sg1W8seovmq4EYOS+6x8gUi74ZOJkPlKcdoVZ9BPxgJ5+ILefkbw6MJY
 SJGv4bwRP8J3g1kHUmpxsnSlTj8TrEliWjiZ9Bfirs13g4IyKs3erEUbp30pW/49UIDd
 f6Vli8a5x8YfkqCYZXbmy8ri1d10q/y6gd6l7Y7wQtHOshKFfDggEMdRB9caYwd65OFb
 NR58LCQHWgPEMOSRoxqbfGhRM8Aia3P9TzAXYVnZhuTUJMQPiB1tNVkcNTCEp5/GWuJc
 +6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734687406; x=1735292206;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fwtMOspPTsliAPgaOSgL81eS5X/8EjwJ+cEcVrGmXLY=;
 b=XGeNcHzLXZXjC3/psmvnHELxWR8qzX2UX8ABprVXM0RtaY0r4cqNpFstLHn6I1teh3
 tpcRBSiQ+BnpFEPrAgHbXT8OdOGOEV+oIk3k4M+eIQRO2PLrpxdfNy6iF5z7AB8LIhDy
 q1ajrP+PtxoXc6ap8quHH2RQys/RP4n8E87TQYEPZwG4KR9yxgZv8+BFKwTHgBI5pEZr
 FE4zKcaklBacNECG6BNbbNiITXNDzA06I+21I9kew0InFsyiNYhdsLf+0O0y5NChpjLv
 1upqp4ifPVM4ii8AYy6kdZ/xGm2Nn9twM50yul7b9dYXmj4CfSNOS3NaQwvZR3dxiGev
 Bgsw==
X-Gm-Message-State: AOJu0YwkndOefKeP+7/87fIU4fC1MrDJImmjHGBH9oMOxT6Sx0972EJn
 9Pvv7kL18hqa0YiteJbM3m8krmXEJfMlZ62SigkJ79wwAZtIK74LeBQ+BY0IcMk=
X-Gm-Gg: ASbGncuLaA8PXkYEAyE55hyxGxi7bbzmL8ARRUNtfElgba0fcWaxQGhNrxWTYNnxc5h
 h5MhGNkZ3+9GWDmZmWRZ0JgJZQlTkddbumRUvc6fn5ZS7GTd012ZiABTHzHP/eqCVhXORmUOp+G
 g7lMfEnqmbgiCxxzrfaoODvUZYTnZjK/aDNF8gHAjy23Rq9JxXko+tQ3LGRSBnCyuFrFJHz2YVx
 SJETCYq2BqGZ0AGI9VRaursVHVRV5EA43UQR7BTrKb8pXqhj/DQDmb4v8+I0rQT0UAjWQ==
X-Google-Smtp-Source: AGHT+IE56o5rI21+R51idNQnRY/l6MP8xkfJvggCT5MoX6XP3T4Mxr6B6lwBmWSLwJdV57sbBQORsA==
X-Received: by 2002:a05:6a21:680b:b0:1e1:a0b6:9872 with SMTP id
 adf61e73a8af0-1e5e045a333mr3736158637.11.1734687406133; 
 Fri, 20 Dec 2024 01:36:46 -0800 (PST)
Received: from [192.168.68.110] ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb50sm2691921b3a.90.2024.12.20.01.36.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 01:36:45 -0800 (PST)
Message-ID: <e4c992fc-9b25-4059-806e-cf8a25b523c0@ventanamicro.com>
Date: Fri, 20 Dec 2024 06:36:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/39] riscv-to-apply queue
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
 <20241219204549.GA724589@fedora>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241219204549.GA724589@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x442.google.com
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

DQoNCk9uIDEyLzE5LzI0IDU6NDUgUE0sIFN0ZWZhbiBIYWpub2N6aSB3cm90ZToNCj4gSGkg
QWxpc3RhaXIsDQo+IFBsZWFzZSB0YWtlIGEgbG9vayBhdCB0aGUgZm9sbG93aW5nIENJIGZh
aWx1cmU6DQo+IA0KPiB4ODZfNjQtdzY0LW1pbmd3MzItZ2NjIC1tNjQgLUlsaWJxZW11dXRp
bC5hLnAgLUkuIC1JLi4gLUlxYXBpIC1JdHJhY2UgLUl1aSAtSXVpL3NoYWRlciAtSS91c3Iv
eDg2XzY0LXc2NC1taW5ndzMyL3N5cy1yb290L21pbmd3L2luY2x1ZGUvZ2xpYi0yLjAgLUkv
dXNyL3g4Nl82NC13NjQtbWluZ3czMi9zeXMtcm9vdC9taW5ndy9saWIvZ2xpYi0yLjAvaW5j
bHVkZSAtSS91c3IveDg2XzY0LXc2NC1taW5ndzMyL3N5cy1yb290L21pbmd3L2luY2x1ZGUv
cDExLWtpdC0xIC1mZGlhZ25vc3RpY3MtY29sb3I9YXV0byAtV2FsbCAtV2ludmFsaWQtcGNo
IC1XZXJyb3IgLXN0ZD1nbnUxMSAtTzIgLWcgLWZzdGFjay1wcm90ZWN0b3Itc3Ryb25nIC1X
ZW1wdHktYm9keSAtV2VuZGlmLWxhYmVscyAtV2V4cGFuc2lvbi10by1kZWZpbmVkIC1XZm9y
bWF0LXNlY3VyaXR5IC1XZm9ybWF0LXkyayAtV2lnbm9yZWQtcXVhbGlmaWVycyAtV2ltcGxp
Y2l0LWZhbGx0aHJvdWdoPTIgLVdpbml0LXNlbGYgLVdtaXNzaW5nLWZvcm1hdC1hdHRyaWJ1
dGUgLVdtaXNzaW5nLXByb3RvdHlwZXMgLVduZXN0ZWQtZXh0ZXJucyAtV29sZC1zdHlsZS1k
ZWNsYXJhdGlvbiAtV29sZC1zdHlsZS1kZWZpbml0aW9uIC1XcmVkdW5kYW50LWRlY2xzIC1X
c2hhZG93PWxvY2FsIC1Xc3RyaWN0LXByb3RvdHlwZXMgLVd0eXBlLWxpbWl0cyAtV3VuZGVm
IC1XdmxhIC1Xd3JpdGUtc3RyaW5ncyAtV25vLW1pc3NpbmctaW5jbHVkZS1kaXJzIC1Xbm8t
cHNhYmkgLVduby1zaGlmdC1uZWdhdGl2ZS12YWx1ZSAtaXF1b3RlIC4gLWlxdW90ZSAvYnVp
bGRzL3FlbXUtcHJvamVjdC9xZW11IC1pcXVvdGUgL2J1aWxkcy9xZW11LXByb2plY3QvcWVt
dS9pbmNsdWRlIC1pcXVvdGUgL2J1aWxkcy9xZW11LXByb2plY3QvcWVtdS9ob3N0L2luY2x1
ZGUveDg2XzY0IC1pcXVvdGUgL2J1aWxkcy9xZW11LXByb2plY3QvcWVtdS9ob3N0L2luY2x1
ZGUvZ2VuZXJpYyAtaXF1b3RlIC9idWlsZHMvcWVtdS1wcm9qZWN0L3FlbXUvdGNnL2kzODYg
LW1tcy1iaXRmaWVsZHMgLW1jeDE2IC1tc3NlMiAtRF9HTlVfU09VUkNFIC1EX0ZJTEVfT0ZG
U0VUX0JJVFM9NjQgLURfTEFSR0VGSUxFX1NPVVJDRSAtZm5vLXN0cmljdC1hbGlhc2luZyAt
Zm5vLWNvbW1vbiAtZndyYXB2IC1mbm8tcGllIC1uby1waWUgLWZ0cml2aWFsLWF1dG8tdmFy
LWluaXQ9emVybyAtZnplcm8tY2FsbC11c2VkLXJlZ3M9dXNlZC1ncHIgLW1tcy1iaXRmaWVs
ZHMgLXB0aHJlYWQgLW1tcy1iaXRmaWVsZHMgLU1EIC1NUSBsaWJxZW11dXRpbC5hLnAvbWVz
b24tZ2VuZXJhdGVkXy4uX3RyYWNlX3RyYWNlLWh3X3Jpc2N2LmMub2JqIC1NRiBsaWJxZW11
dXRpbC5hLnAvbWVzb24tZ2VuZXJhdGVkXy4uX3RyYWNlX3RyYWNlLWh3X3Jpc2N2LmMub2Jq
LmQgLW8gbGlicWVtdXV0aWwuYS5wL21lc29uLWdlbmVyYXRlZF8uLl90cmFjZV90cmFjZS1o
d19yaXNjdi5jLm9iaiAtYyB0cmFjZS90cmFjZS1od19yaXNjdi5jDQo+IEluIGZpbGUgaW5j
bHVkZWQgZnJvbSB0cmFjZS90cmFjZS1od19yaXNjdi5jOjU6DQo+IC4uL2h3L3Jpc2N2L3Ry
YWNlLWV2ZW50czogSW4gZnVuY3Rpb24gJ19ub2NoZWNrX190cmFjZV9yaXNjdl9pb21tdV9z
eXNfbXNpX3NlbnQnOg0KPiAuLi9ody9yaXNjdi90cmFjZS1ldmVudHM6MTk6MjI6IGVycm9y
OiBmb3JtYXQgJyVseCcgZXhwZWN0cyBhcmd1bWVudCBvZiB0eXBlICdsb25nIHVuc2lnbmVk
IGludCcsIGJ1dCBhcmd1bWVudCA2IGhhcyB0eXBlICd1aW50NjRfdCcge2FrYSAnbG9uZyBs
b25nIHVuc2lnbmVkIGludCd9IFstV2Vycm9yPWZvcm1hdD1dDQo+ICAgICAxOSB8IHJpc2N2
X2lvbW11X3N5c19tc2lfc2VudCh1aW50MzJfdCB2ZWN0b3IsIHVpbnQ2NF90IG1zaV9hZGRy
LCB1aW50MzJfdCBtc2lfZGF0YSwgdWludDMyX3QgcmVzdWx0KSAiTVNJIHNlbnQgdG8gdmVj
dG9yICV1IG1zaV9hZGRyIDB4JWx4IG1zaV9kYXRhIDB4JXggcmVzdWx0ICV1Ig0KPiAgICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+DQo+IC4uLi4uLg0KPiAuLi9ody9yaXNjdi90cmFjZS1ldmVudHM6MTk6
MjI6IGVycm9yOiBmb3JtYXQgJyVseCcgZXhwZWN0cyBhcmd1bWVudCBvZiB0eXBlICdsb25n
IHVuc2lnbmVkIGludCcsIGJ1dCBhcmd1bWVudCAzIGhhcyB0eXBlICd1aW50NjRfdCcge2Fr
YSAnbG9uZyBsb25nIHVuc2lnbmVkIGludCd9IFstV2Vycm9yPWZvcm1hdD1dDQo+ICAgICAx
OSB8IHJpc2N2X2lvbW11X3N5c19tc2lfc2VudCh1aW50MzJfdCB2ZWN0b3IsIHVpbnQ2NF90
IG1zaV9hZGRyLCB1aW50MzJfdCBtc2lfZGF0YSwgdWludDMyX3QgcmVzdWx0KSAiTVNJIHNl
bnQgdG8gdmVjdG9yICV1IG1zaV9hZGRyIDB4JWx4IG1zaV9kYXRhIDB4JXggcmVzdWx0ICV1
Ig0KPiAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+fn5+fg0KPiAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8DQo+ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2
NF90IHtha2EgbG9uZyBsb25nIHVuc2lnbmVkIGludH0NCj4gY2MxOiBhbGwgd2FybmluZ3Mg
YmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCg0KDQpJdCByZWFsbHkgc2VlbXMgbGlrZSBldmVy
eSB0aW1lIEkgZG9uJ3QgcnVuIHRoZSBnaXRsYWIgcGlwZWxpbmUgYmVmb3JlIHBvc3RpbmcN
CnBhdGNoZXMgdGhlcmUncyBzb21ldGhpbmcgaW4gdGhlcmUgdGhhdCBleHBsb2RlcyBhIHdp
bmRvd3MtbGlrZSBydW5uZXIgOigNCg0KVGhhbmtzIEFsaXN0YWlyIGZvciBjbGVhbmluZyB1
cCBteSBtZXNzIGluIHYyLg0KDQoNCkRhbmllbA0KDQoNCj4gDQo+IGh0dHBzOi8vZ2l0bGFi
LmNvbS9xZW11LXByb2plY3QvcWVtdS8tL2pvYnMvODY5MTcwNDk2OSNMMjU3OA0KPiANCj4g
T25jZSB0aGUgaXNzdWUgaGFzIGJlZW4gc29sdmVkLCBwbGVhc2Ugc2VuZCBhIG5ldyByZXZp
c2lvbiBvZiB0aGlzIHB1bGwNCj4gcmVxdWVzdC4NCj4gDQo+IFRoYW5rcywNCj4gU3RlZmFu
DQoNCg==

