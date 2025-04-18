Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD97C369CB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 03:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5cSx-0003DQ-S0; Thu, 17 Apr 2025 23:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5cSv-0003CP-O9
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 23:32:33 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5cSt-0004pA-F3
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 23:32:33 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22c33e5013aso18801365ad.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 20:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744947149; x=1745551949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DglYwTioCGrv1xV12gBJVLZ7o+SZF2iV9AFPebBc3Pg=;
 b=OelbZ4Qm69czpxrECc0or726RKCC5i6ELOdqC8JvRH0CnwLfM+As6VVPtFa6rlkVjS
 3xDxm6lw6EoFo47ZWmmfYYvax2tLI7KP6K7D/xQENXYsAfTDzlaCuiJXdmYi5gGZABkN
 B/8ey1Mlcv5SJUPsHeqM4ft7H7O2PKKCSriVLT8rP0phRuDc/2MrjHJEtOA9aWEXzjKY
 CekF7LapNsROEk1NJbW9srvlPIS+OzGIQeZiKSWrIANnoznwMnOLWNxLfds4VbI7C2P9
 kHFCSiB/dfPiM54O8YmSyIB0TgGgCs4PKX/y6Fkeh77dzZPzBMaEMRJOkBdEzw+f8Rjh
 3CMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744947149; x=1745551949;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DglYwTioCGrv1xV12gBJVLZ7o+SZF2iV9AFPebBc3Pg=;
 b=SZep2UuYfvi8rrzWzwOe1kkYc2QvQ5zSkNExZaWWwI1p+Oti9xW29DIcOKoF7kW7C9
 bozzDFgbLRTmYT4W1nwlN7s2nC9IoDyXchpWOVE5ONoCmsp62Q3rRXOYBqIdXcllsc1Z
 7+2JIsw3ocnf/h37nZgXfqo6bDi/WWP9o5chWLm2rPMcvyobERwrL/a3q3wgAMMS44Ru
 PbQRlRnbpbatLuSKAFIKDbAPurf1WGdA+iHHa1pEu0TEMNWhlx7WTBPjAIER60zCdWIl
 IuigL28amLDpGTneFaL04froKgcK2irR83+pp0Nh+MMbjoH7TySsoj6MmptBog3eCgfS
 mR/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRi9pd1ZKStWmKi+EOrVwSdhsuoxrbbaffeh+LYoV5k6r3mEgWxmL4pNSj/EK6oK62v85dDM1jSH3p@nongnu.org
X-Gm-Message-State: AOJu0Yyb2PyhTFFbtGMMKZzc1o+Qw2nyqoxeF7FHDag6eLp64XS5TL3J
 c0z+jZ3u5nfgos5bbrMujVYd39BAuroJgJVYTA9KHmyspQ1Y9nh1ClHU2PVijtk=
X-Gm-Gg: ASbGnctAmvNBp5Zpr/L7S8WZYV4BoLh45xfQ6qpXZjUUWyZyWw9psgXB+6qoK8R6YXi
 1QxpGPqCuBG1yjs7qDBs4y14pVdDVo2vLH8Qb41cH4D0mDBPwqh6Z82vTgHuTVMTqlH/g+yD85z
 wAixb1/+Bq5uaZrbtA5LLenvHO1lqYSMIdt7XDrRJMLG+DqI+O0f3JgKaBWgfQcEsiMq1SVOBVj
 Zvgr4oX/jNMfGXRyGTX/sJQEX+ZgckqctRdHoPweCtOjtToOjXjODxHbeyz9LV5dIsDc/DsvoRc
 veekfNj1d8WnYAFIi9lcg8iDmbQR80HK9TwPsYToitjVGt0yQj97zA==
X-Google-Smtp-Source: AGHT+IFAd0s23G7YFam73EX+J5aOMY67MGTN8EfshOPL1m9UAHjoZ7K/gYAOsW71MmZiQCJ7d3t25Q==
X-Received: by 2002:a17:902:e944:b0:220:ca08:8986 with SMTP id
 d9443c01a7336-22c535a177fmr24149855ad.22.1744947149019; 
 Thu, 17 Apr 2025 20:32:29 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdaca6sm8145405ad.9.2025.04.17.20.32.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 20:32:28 -0700 (PDT)
Message-ID: <29533dbf-b181-4d8a-badb-3a1c26f4d0d3@linaro.org>
Date: Thu, 17 Apr 2025 20:32:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 07/11] hw/core: Allow ARM/Aarch64 binaries to use
 the 'none' machine
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250418005059.4436-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

T24gNC8xNy8yNSAxNzo1MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFdo
ZW4gd2UnbGwgc3RhcnQgdG8gdXNlIHRhcmdldF9tYWNoaW5lX2ludGVyZmFjZV90eXBlbmFt
ZSgpDQo+IHRvIGZpbHRlciBtYWNoaW5lcyBmb3IgdGhlIEFSTS9BYXJjaDY0IGJpbmFyaWVz
LCB0aGUgJ25vbmUnDQo+IG1hY2hpbmUgd2lsbCBiZSBmaWx0ZXJlZCBvdXQuIFJlZ2lzdGVy
IHRoZSBwcm9wZXIgaW50ZXJmYWNlcw0KPiB0byBrZWVwIGl0IGF2YWlsYWJsZS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJv
Lm9yZz4NCj4gLS0tDQo+ICAgaHcvY29yZS9udWxsLW1hY2hpbmUuYyB8IDUgKysrKysNCj4g
ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
aHcvY29yZS9udWxsLW1hY2hpbmUuYyBiL2h3L2NvcmUvbnVsbC1tYWNoaW5lLmMNCj4gaW5k
ZXggMWNjYWY2NTJlYjQuLjYxNGI1MmRhZTBkIDEwMDY0NA0KPiAtLS0gYS9ody9jb3JlL251
bGwtbWFjaGluZS5jDQo+ICsrKyBiL2h3L2NvcmUvbnVsbC1tYWNoaW5lLmMNCj4gQEAgLTYy
LDYgKzYyLDExIEBAIHN0YXRpYyBjb25zdCBUeXBlSW5mbyBudWxsX21hY2hpbmVfdHlwZXNb
XSA9IHsNCj4gICAgICAgICAgIC5uYW1lICAgICAgICAgICA9IE1BQ0hJTkVfVFlQRV9OQU1F
KCJub25lIiksDQo+ICAgICAgICAgICAucGFyZW50ICAgICAgICAgPSBUWVBFX01BQ0hJTkUs
DQo+ICAgICAgICAgICAuY2xhc3NfaW5pdCAgICAgPSBudWxsX21hY2hpbmVfY2xhc3NfaW5p
dCwNCj4gKyAgICAgICAgLmludGVyZmFjZXMgICAgID0gKEludGVyZmFjZUluZm9bXSkgew0K
PiArICAgICAgICAgICAgeyBUWVBFX1RBUkdFVF9BUk1fTUFDSElORSB9LA0KPiArICAgICAg
ICAgICAgeyBUWVBFX1RBUkdFVF9BQVJDSDY0X01BQ0hJTkUgfSwNCj4gKyAgICAgICAgICAg
IHsgfSwNCj4gKyAgICAgICAgfSwNCj4gICAgICAgfSwNCj4gICB9Ow0KPiAgIA0KDQpJIHNl
ZSBiZXR0ZXIgd2h5IHRob3NlIHR5cGUgd2VyZSBkZWZpbmVkIGluIGEgZ2xvYmFsIGhlYWRl
ci4NCkkgd291bGQgc3RpbGwgZmF2b3IgYSBoZWFkZXIgaW4gaHcvYXJtLCB0aGF0IHRoaXMg
ZmlsZSBjYW4gaW5jbHVkZSAoYW5kIA0Kb3RoZXIgYXJjaCBsYXRlciB3aGVuIHdlJ2xsIGlt
cGxlbWVudCBpdCBmb3IgdGhlbSkuDQo=

