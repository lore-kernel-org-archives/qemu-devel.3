Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFE9E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 18:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXlaC-0002pn-JP; Tue, 14 Jan 2025 13:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXlZn-0002lz-WE
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:23:45 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXlZm-0004OH-1H
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:23:43 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-216395e151bso703375ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 10:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736879019; x=1737483819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ManKySrlKZlhieFNSR79/ldahZKp4ApfQgglGbwOz+4=;
 b=bgXg5pbBfh7o17ytyaplnRX9SZbxbwXfV6mNEntBmq176UjM9Ggbt/bcx+qajBvpDq
 ay/dX28GunVjQAs5fB7+EkXhlB+TmoXpKT/ZnoA4OToNST6WdQuUKT/MdtoW9ecA1kfE
 Ow0mC36D8aP6qEtu8G8y/uyJ86hosQE9/ZH1ttT61NWwifoaXqmLN9oqbihP4razzBrd
 LllNbUiUeL76avM3gfzTsCxxLF5sGnYqOSt6QzSTC44jTGPgkugv6ggljQwCIgDxL+Sv
 xUlIwLDEPnqhquohbC0lV5OaSooXHqcrmoU2JTxTaJJz+xHGK/hnZvkiFtxyZvyoBfL9
 v9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736879019; x=1737483819;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ManKySrlKZlhieFNSR79/ldahZKp4ApfQgglGbwOz+4=;
 b=RdnCLsHiINCIg5wrGxjsx83eO8xA1NiBIwzbGCu1anmXRUVHAWQXHaiCxDKrePyks/
 yHjMSDeQzBuhKslqM4NA76CI+STVe78DWjkS2is1E85TK8tT3SOkJVwsaR0pEBEZkX9X
 ZDr2n/8kTLg5RgF3O+qp2yuuEf6jASFHJYNSfn8zmitGkgw7/+Ap99lhY9b5ZDUB2joH
 gcPlHhulBqwjiN5oO1oEcnPCrIXRDdhlyyB9ytYj7pikA2/WFJO+Oq6hAf5XlmZpA5To
 Ho6m6lBJPkCSaJuIcvrB5A0qer+CCoPx+AOUeN/Z+DBgh8P4qIYswlz4ON0FapV8jmpk
 iyjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl1BhTzz4rtLDU9AxdmoCVDT+ifED/4DEfSrJ0mkMaZO/kq5Sg7hMEXW/upZ3SBITdeMH50c12D2Ei@nongnu.org
X-Gm-Message-State: AOJu0YzVXjxI3R1RvMtoOPAIO0ehuIy7vbuKHBxMTOSEkdts1NGxbPCb
 uAbdE6Yp3wjGjGGf8DUmjFt60Hr+73YQfWyNOefnKm0P3A/Jia3mEzEzFblw3t4=
X-Gm-Gg: ASbGncuHIDjTmi7rI19c2vxT1agCvNxpz2R/4ZEMt74ChZq1yWcdvggOvb1hFNadP65
 E0ENWI+CWSuZ4VVnk6cfPvLCauVcCtG3jQmUUOZe72K3M8EqglTEd75P+ZLBGA4VD9zwDVPDJUL
 zvWiAH6bnCO3iJMB6+dJI3G9/rlngHSkse+oH1RwsfDVX/hb9iV/z919SU68efR41SzIEmUCRIz
 ntdaGtb4VUNa+4r8ZQ7qcYW8bvzUh14XAmcE+LNH9UJhPtayS44Eq38b/kTkHXAiuXC6A==
X-Google-Smtp-Source: AGHT+IGdDIjMWbvRwa3hUf43cI0dPHEQACjAOw43YSFLznxpNEBE9wIgwT+Cl/RQy4gkXCGHT42NcA==
X-Received: by 2002:a17:903:2bce:b0:216:11cf:790 with SMTP id
 d9443c01a7336-21a8d6669a5mr336432025ad.16.1736879019463; 
 Tue, 14 Jan 2025 10:23:39 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21bbce1fe5fsm31951025ad.154.2025.01.14.10.23.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 10:23:39 -0800 (PST)
Message-ID: <d4380638-9663-441a-9b49-c7eb443c8654@linaro.org>
Date: Tue, 14 Jan 2025 10:23:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/37] editorconfig: update for perl scripts
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Stefan Weil <sw@weilnetz.de>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
 <20250114113821.768750-28-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250114113821.768750-28-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

T24gMS8xNC8yNSAwMzozOCwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBXZSBoYXZlIHR3byB0
eXBlcyBvZiBwZXJsIHNjcmlwdHMgaW4gdGhlIHRyZWUuIFRoZSBvbmVzIGZyb20gdGhlDQo+
IGtlcm5lbCBhcmUgbW9zdGx5IHRhYiBiYXNlZCB3aGVyZSBhcyBzY3JpcHRzIHdlIGhhdmUg
d3JpdHRlbiBvdXJzZWx2ZXMNCj4gdXNlIDQgc3BhY2UgaW5kZW50YXRpb24uDQo+IA0KPiBB
dHRlbXB0IHRvIGNvZGlmeSB0aGF0IGluIG91ciAuZWRpdG9yY29uZmlnDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+IC0t
LQ0KPiAgIC5lZGl0b3Jjb25maWcgfCAxMyArKysrKysrKysrKysrDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS8uZWRpdG9yY29u
ZmlnIGIvLmVkaXRvcmNvbmZpZw0KPiBpbmRleCA3MzAzNzU5ZWQ3Li5hMDRjYjkwNTRjIDEw
MDY0NA0KPiAtLS0gYS8uZWRpdG9yY29uZmlnDQo+ICsrKyBiLy5lZGl0b3Jjb25maWcNCj4g
QEAgLTQ3LDMgKzQ3LDE2IEBAIGVtYWNzX21vZGUgPSBnbHNsDQo+ICAgWyouanNvbl0NCj4g
ICBpbmRlbnRfc3R5bGUgPSBzcGFjZQ0KPiAgIGVtYWNzX21vZGUgPSBweXRob24NCj4gKw0K
PiArIyBieSBkZWZhdWx0IGZvbGxvdyBRRU1VJ3Mgc3R5bGUNCj4gK1sqLnBsXQ0KPiAraW5k
ZW50X3N0eWxlID0gc3BhY2UNCj4gK2luZGVudF9zaXplID0gNA0KPiArZW1hY3NfbW9kZSA9
IHBlcmwNCj4gKw0KPiArIyBidXQgdXNlciBrZXJuZWwgInN0eWxlIiBmb3IgaW1wb3J0ZWQg
c2NyaXB0cw0KPiArW3NjcmlwdHMve2tlcm5lbC1kb2MsZ2V0X21haW50YWluZXIucGwsY2hl
Y2twYXRjaC5wbH1dDQo+ICtpbmRlbnRfc3R5bGUgPSB0YWINCj4gK2luZGVudF9zaXplID0g
OA0KPiArZW1hY3NfbW9kZSA9IHBlcmwNCj4gKw0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sg
Qm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

