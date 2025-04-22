Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C964C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 18:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7I56-0003NV-6H; Tue, 22 Apr 2025 14:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7I54-0003NH-Gb
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:10:50 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7I52-0003sV-Ae
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:10:50 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-30549dacd53so137428a91.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745345445; x=1745950245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TAHPiwH2hONHJBtJ2hLOxCWTMsvIShhnu3A5qRbWzQ8=;
 b=DHkWOfBdaR+e4ZUSRLFRsqZD4twxEMnC9Bg2FpMRiRYiBpZUQd5khfVfWI5edJ+dsg
 TPKo0SIw5tvGVD1h3/l/GE8Xu86aTe1X+dZXKQcUzTmAU2wOCGGFa5bdPysr76f8v8rk
 hUmvMDymAh9qDFSRmuDA9tnat0Y28cmub5xmaZKf85jmZ69+CRwpmZPZ/0yycEBCvlBP
 u677OY4fKq4/TuvE4vjPYZsdLzFXH2wMFZIKXmL51oac/0oniwdeEdPeyxmArGXaTzdL
 rJir6lHiy/EM93qus81iW/3M3tALNqhCW/DX8EaBDrjaqkgkx4X8hVRKelMLm67h/ruq
 8kNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745345445; x=1745950245;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TAHPiwH2hONHJBtJ2hLOxCWTMsvIShhnu3A5qRbWzQ8=;
 b=kCaUpKg1upZCYc/Enp6s69bEHinwQn5IgmxLVqIRmO9tuIXn+zitz/xeNf4C0tpYl1
 r6lMr5KwWJswiJi4qLgUjvdqfBv/LazaNVgPtXWoXk/cdQPkYFqnyzz8JXYgBPKfQ89k
 SuYbSd4/BkcbB6xmI3LgZVLFEdTaSvLSJrh4ZPZgEPHqhOQVqPbxNsy/Z2y9EV0V7Zaq
 r24sq/mYZCGhw6GDWFFBWWv/eE0xGN1E+v0RQZ/rJuSValQkRvlRShwJRG1fvvOGvFqm
 GbBWd1tk2oK1NFC9JvH0ldOXkUdVLfmcY6bkNs/hhT/a0MmE0ETibFIYDRq13Qqk8Siw
 sJzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPfejKiiT3AqPFVcPedJXge/VAmx9jDAxNey71GDVC3+P+Gtc6CP5n93Eux/3tN+R5+JCV1KhikEFx@nongnu.org
X-Gm-Message-State: AOJu0YzjMSrPkalYKqa+QdiVj87hxl5+mXv/AgV6Xm7MnVyIsWxqAblP
 OHUei6ZRm0J8gccIazGK8E4i4Y/S12d67JV0FUoz+xbMIuc7+92JbomCo6xxasg=
X-Gm-Gg: ASbGnct/XkLlyzRZVz2Ibx5eUP/hlSKbdVAVgVPULAxk8J+3AFlhAxqQ8Xzf+dWZDxP
 j40U2XXV7Yie9MupHCHf69IBzJG61rpsIus2uBjv4nqZS4cuB3mEVAdIAy0B/jbt7JfXB/mLOG+
 4dJK2ukVC+lTAuf62nh22wX+e2WDEWp9drW+pM1snLxiRvLcIxsjm9aoZ/Zqpfr5ciSWvkR7Tfm
 IoOKS6XwACSEecikJ6XZJ+F8ZmRrclR3MGJTFGeq8ZQdDEM7jqvyWkChdg5LsV1LNHk5NyN7NhA
 MUIgwuAmSVyqsUi41rzaEuiWvdmrNbnxHWJvvF4AIoDPtafZjiDhZw==
X-Google-Smtp-Source: AGHT+IHCs5hV8zN3s58xt58zRgJgLnPH9EISCokYJBfAFbglee3hNDQPECNC94YA9A2WDzzu0048/Q==
X-Received: by 2002:a17:90a:1546:b0:309:d208:ef1a with SMTP id
 98e67ed59e1d1-309d208ef5cmr3802611a91.5.1745345445624; 
 Tue, 22 Apr 2025 11:10:45 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087e05b25csm9012409a91.41.2025.04.22.11.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 11:10:45 -0700 (PDT)
Message-ID: <ef4dbcef-5c1d-4113-8c60-550c90baf378@linaro.org>
Date: Tue, 22 Apr 2025 11:10:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 12/19] hw/arm/virt: Register valid CPU types
 dynamically
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-13-philmd@linaro.org>
 <62c23632-b498-4fe9-b337-294b0fe4cec4@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <62c23632-b498-4fe9-b337-294b0fe4cec4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

T24gNC8yMi8yNSAxMDo1NiwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDQvMjIv
MjUgMDc6NTQsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4gKyNpZmRlZiBD
T05GSUdfVENHDQo+PiArICAgICAgICB2Y3QgPSBnX3NsaXN0X3ByZXBlbmQodmN0LCBnX3N0
cmR1cChBUk1fQ1BVX1RZUEVfTkFNRSgiY29ydGV4LWE3IikpKTsNCj4+ICsgICAgICAgIHZj
dCA9IGdfc2xpc3RfcHJlcGVuZCh2Y3QsIGdfc3RyZHVwKEFSTV9DUFVfVFlQRV9OQU1FKCJj
b3J0ZXgtYTE1IikpKTsNCj4+ICsjaWZkZWYgVEFSR0VUX0FBUkNINjQNCj4+ICsgICAgICAg
IHZjdCA9IGdfc2xpc3RfcHJlcGVuZCh2Y3QsIGdfc3RyZHVwKEFSTV9DUFVfVFlQRV9OQU1F
KCJjb3J0ZXgtYTM1IikpKTsNCj4+ICsgICAgICAgIHZjdCA9IGdfc2xpc3RfcHJlcGVuZCh2
Y3QsIGdfc3RyZHVwKEFSTV9DUFVfVFlQRV9OQU1FKCJjb3J0ZXgtYTU1IikpKTsNCj4+ICsg
ICAgICAgIHZjdCA9IGdfc2xpc3RfcHJlcGVuZCh2Y3QsIGdfc3RyZHVwKEFSTV9DUFVfVFlQ
RV9OQU1FKCJjb3J0ZXgtYTcyIikpKTsNCj4+ICsgICAgICAgIHZjdCA9IGdfc2xpc3RfcHJl
cGVuZCh2Y3QsIGdfc3RyZHVwKEFSTV9DUFVfVFlQRV9OQU1FKCJjb3J0ZXgtYTc2IikpKTsN
Cj4+ICsgICAgICAgIHZjdCA9IGdfc2xpc3RfcHJlcGVuZCh2Y3QsIGdfc3RyZHVwKEFSTV9D
UFVfVFlQRV9OQU1FKCJjb3J0ZXgtYTcxMCIpKSk7DQo+PiArICAgICAgICB2Y3QgPSBnX3Ns
aXN0X3ByZXBlbmQodmN0LCBnX3N0cmR1cChBUk1fQ1BVX1RZUEVfTkFNRSgiYTY0ZngiKSkp
Ow0KPj4gKyAgICAgICAgdmN0ID0gZ19zbGlzdF9wcmVwZW5kKHZjdCwgZ19zdHJkdXAoQVJN
X0NQVV9UWVBFX05BTUUoIm5lb3ZlcnNlLW4xIikpKTsNCj4+ICsgICAgICAgIHZjdCA9IGdf
c2xpc3RfcHJlcGVuZCh2Y3QsIGdfc3RyZHVwKEFSTV9DUFVfVFlQRV9OQU1FKCJuZW92ZXJz
ZS12MSIpKSk7DQo+PiArICAgICAgICB2Y3QgPSBnX3NsaXN0X3ByZXBlbmQodmN0LCBnX3N0
cmR1cChBUk1fQ1BVX1RZUEVfTkFNRSgibmVvdmVyc2UtbjIiKSkpOw0KPj4gKyNlbmRpZiAv
KiBUQVJHRVRfQUFSQ0g2NCAqLw0KPiANCj4gV2h5IGRvIHRoZXNlIG5lZWQgdG8gYmUgc3Ry
ZHVwJ2VkPw0KPiANCj4gRG8geW91IGFudGljaXBhdGUgb3RoZXIgaW5zdGFuY2VzIHdoZXJl
IHRoZXNlIG5hbWVzIGNhbm5vdCBiZSBjb25zdHJ1Y3RlZCBhdCBjb21waWxlLXRpbWU/DQo+
IA0KDQpJdCBzZWVtcyBpdCB3b3VsZCBiZSBtb3JlIGVhc3kgaWYgZ2V0X3ZhbGlkX2NwdV90
eXBlcyBzaW1wbHkgcmV0dXJuIGEgDQpjb25zdCogY2hhciogY29uc3QgKHNhbWUgYXMgZXhp
c3RpbmcgdmFsaWRfY3B1X3R5cGVzKSwgYW5kIGNhbGxlciBkb2VzIA0Kbm90IGhhdmUgdGhl
IHJlc3BvbnNpYmlsaXR5IHRvIGZyZWUgaXQuDQoNClRoaXMgd2F5LCB0aGUgbGlzdCBjYW4g
YmUgYnVpbHQgZWl0aGVyIHdpdGggYSBzdGF0aWMgYXJyYXkgaW5pdGlhbGl6ZXIsIA0Kb3Ig
d2l0aCBhIGR5bmFtaWMgR1B0ckFycmF5LCB0aGF0IHdlIGtlZXAgdW5kZXIgYSBsb2NhbCBz
dGF0aWMgdmFyaWFibGUsIA0Kc28gaXQgaGFzIHRvIGJlIGJ1aWx0IG9ubHkgb25jZS4gV2Ug
Y2FuIGRlYmF0ZSB0aGUgbGVhayBpbnRyb2R1Y2VkIGJ1dCBJIA0KZG9uJ3QgdGhpbmsgaXQn
cyByZWFsbHkgYSBwcm9ibGVtLg0KDQo+IA0KPiByfg0KDQo=

