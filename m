Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CEBC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 19:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5UVR-0007wd-GF; Thu, 17 Apr 2025 15:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5UV1-0007tp-Ui
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 15:02:13 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5UUy-0008TO-8N
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 15:02:11 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b074d908e56so846618a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744916524; x=1745521324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L+667g5HAPBUuOb36DPmVj7TbFDJx+ZTfcaQPsMOZTE=;
 b=TG7ODbe9R6pmoAv02p7wrHw2wVQlPxn68/H6hTicToLBIsrh1WTGZLk9XiodhO6N6M
 3iYEU2Sjycq+SiB0njxlrkADnRdjEzo55nlIzd9/C99X0lkhtGJORChJ27JWlB1k2sgY
 UA5HXpOSQx88Dfju5RC8XIA+CIwv0IdvmzxiGcxXHnERDs1DmSxoxY0AvW7XVRKEWQwX
 6XpVUn3UUmCZj0rFBYdlKvYBWrMZoQjDFRYIqxV0lC8zN+I3mVEclXPuxbwd4Fqj4NZ0
 diS1U3o3x2zsSQm3AZi5fDOjJgvNRs3vVPm2vWcHAb++AnrTZiza6spN7lUDYbQC6ZLc
 qLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744916524; x=1745521324;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L+667g5HAPBUuOb36DPmVj7TbFDJx+ZTfcaQPsMOZTE=;
 b=HZC83wrgEw5tGf1tYXlDiQBPUyuLG+yh1qNsZR8h7yNZ6f9eKvkfIMh1knXijxScNH
 fIUJauuSQt/NbyOkuGzUf0b4HhDMQpVgrBo2xW1IKt4aXHpv44dgUVQ4hnxVRB1l6w3r
 V+mysADow3/b8MmdbjvrgnoPrlzNxhMYYiBqyGuL8dn0g1+nGZpvkZbW9Hw1c0Dbn1tz
 XhRrNYC+uylevvYWivYo1Yeqeq6FZ9VM1HAiATK5JCIQVIJtWPfmYZp2tPyI3lv7saAy
 n5IR9bZccGn4cATLhlzGjZxc/OWwQ7tYsX+23gX7q5rTVeoFRYbimdXsJOF3aiHy1ijq
 0oRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY1E3N8K0d3AG9pW5KggraYi9USkXsguVYd2PS9PjFeDhww9CaZk9ElBhC/FNFcS6V27xlREtgE0Hh@nongnu.org
X-Gm-Message-State: AOJu0YzeZJ3QXPeqF75xzScjymggQuHswIgrBn9705K/1SHqDScXrflJ
 Q3P4bLteWfOA4f4dw/b4C9O8D2aAxYZB4uaRsTXRtTlGHFongkw/Lko7pgSA/QY=
X-Gm-Gg: ASbGncvTA3uqyayVnnvt5r7xx/MNjRQmtw7Lxbv2UmiYF4ZIc8nJRyJ/RD3aes1sPoy
 CY75rTYai7jyTpuG07O1RSiMJhGBlwi3s20qhiS+haWHeYTA94kFSMWwWo/Z0qgtUvtCsfxt0qW
 o2SUJgnhRdXdq7ZahtUvdMedW3OH9KBBRQT6Etp557C17ijTGDCljfS4AFXXGR4NPRQoy4KotTA
 P2kSjok+t2AkMjr1fMImhis8SlVmEItszaem4EU5ENebfI/ViAlNSgUPpO2FRufZqmKE8j3Jfvj
 qulXTEZMKLfd7Bh+OKp7JlhlazPuYLF9sLi+rHmNN6DRuIYmr/GqOA==
X-Google-Smtp-Source: AGHT+IHyAJ4KguBZDz1yCuaMb3FT2pNnBFRsOlgW1mXm9UjJEVPCc55pMJY7qRHsfOyiXLjpn5EeEg==
X-Received: by 2002:a17:90b:5646:b0:2ee:f80c:6889 with SMTP id
 98e67ed59e1d1-3087bcc8a9dmr120116a91.33.1744916524122; 
 Thu, 17 Apr 2025 12:02:04 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087bb6945fsm37541a91.26.2025.04.17.12.02.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 12:02:03 -0700 (PDT)
Message-ID: <f5380fe5-9479-47d8-9bd5-a3100cab5afb@linaro.org>
Date: Thu, 17 Apr 2025 12:02:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] cpus: Replace CPU_RESOLVING_TYPE -> target_cpu_type()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250417165430.58213-1-philmd@linaro.org>
 <84eaddaa-ad02-4cf9-be3d-3d8da7a2d312@linaro.org>
 <fe5198f0-df6c-4b9b-9c68-9b18d8f01406@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <fe5198f0-df6c-4b9b-9c68-9b18d8f01406@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

T24gNC8xNy8yNSAxMTozOCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE3LzQvMjUgMjA6MjgsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBNYXliZSBpdCB3
b3VsZCBiZSBwcmVmZXJhYmxlIHRvIGZvY3VzIG9uIHByb3ZpZGluZyBhIG1pbmltYWwgYnV0
DQo+PiAqY29tcGxldGUqIFRhcmdldEluZm8gYmVmb3JlIHVwc3RyZWFtaW5nIGFueSBvZiB0
aGlzLCBhcyBpdCdzIHJlYWxseQ0KPj4gYmxvY2tpbmcgdGhlIHJlc3Qgb2YgdGhlIHdvcmsg
Zm9yIHNpbmdsZSBiaW5hcnkuDQo+IA0KPiBJIHN1cHBvc2UgSSBtaXN1bmRlcnN0b29kIHlv
dSBhc2tpbmcgdG8gcG9zdCB0aGVzZSByZXZpZXdlZCBwYXRjaGVzIGFzDQo+IHNlcGFyYXRl
IG9mIHRoZSBUYXJnZXRJbmZvIHNlcmllcyB3aGljaCBuZWVkIG1vcmUgd29yazoNCj4gDQo+
ICJJIGp1c3QgZmVlbCB0aGUgbGFzdCAzIGNvbW1pdHMsIGFuZCB0aGlzIG9uZSwgYXJlIGEg
Yml0IGRpc2Nvbm5lY3RlZA0KPiBmcm9tIHRoZSBzZXJpZXMuIg0KPiANCg0KWW91J3JlIHJp
Z2h0LCBpdCBtZWFudCB0aGF0IHRoZSA0IGNvbW1pdHMgKGFjY2VsOiAqKSBhcmUgZXh0cmEg
Y2xlYW51cHMgDQphbmQgbm90IHJlYWxseSByZWxhdGVkIHRvIHRoZSBzZXJpZXMgdGl0bGUg
IkludHJvZHVjZSBUYXJnZXRJbmZvIEFQSSANCihmb3Igc2luZ2xlIGJpbmFyeSkiLCB3aGlj
aCBpcyBmaW5lIHRvIHVwc3RyZWFtIGJ5IGl0c2VsZi4NCkhvd2V2ZXIsIGludHJvZHVjaW5n
IHRhcmdldF9pbmZvLmggcGFydGlhbGx5IGp1c3QgdG8gZG8gdGhpcyBjbGVhbnVwIA0KZmly
c3Qgc291bmRzIGEgYml0IHdlaXJkIHRvIG1lLg0KDQpNeSBjb21wbGV0ZSB0aG91Z2h0IHdh
cyAiVGhpcyBjbGVhbnVwIGlzIG9rLCBidXQgcGxlYXNlIHBvc3Rwb25lIGl0IG9uY2UgDQp3
ZSBoYXZlIFRhcmdldEluZm8gQVBJIHVwc3RyZWFtIi4NCkl0J3MgYSByZW1hcmsgSSdsbCBr
ZWVwIGRvaW5nIGZvciBUYXJnZXRJbmZvLCBhcyB0aGUgZ29hbCBmb3IgdjEgaXMgdG8gDQpo
YXZlIGEgbWluaW1hbCBBUEksIGludHJvZHVjaW5nIHRoZSBjb25jZXB0IG9mIE1hY2hpbmUg
YW5kIENQVSB0eXBlcywgDQphbmQgYXBwbHkgaXQgdG8gaHcvYXJtLCB3aGljaCB3YXMgb3Vy
IGluaXRpYWwgbmVlZCBhbmQgd2h5IHdlIHRhbGtlZCANCmFib3V0IHRoaXMgaW4gdGhlIGZp
cnN0IHBsYWNlLg0KDQpPbmNlIGl0J3MgdGhlcmUgdXBzdHJlYW0sIHdlIGNhbiBhbGwgZW5o
YW5jZSBpdCBpbiBwYXJhbGxlbCwgd2l0aCB0aGUgDQp2YXJpb3VzIG5lZWRzIHdlJ2xsIGhh
dmUgZm9yIGNsZWFuaW5nIHVwIG90aGVyIHBhcnRzIG9mIHRoZSBjb2RlYmFzZS4NCg0KTXkg
cmF0aW9uYWxlIGlzIHRoYXQgaXQncyBlYXN5IHRvIHJlYmFzZSBvdXIgY29uZmxpY3Rpbmcg
Y29kZSBhZ2FpbnN0IGEgDQpjb21tb24gZmlsZSwgYnV0IGl0J3MgaGFyZCB0byBkbyBpdCBp
ZiBpdCBkb2Vzbid0IGV4aXN0LCB0aHVzIG15IA0KaW5zaXN0ZW5jZSBvbiBnZXR0aW5nIGEg
bWluaW1hbCBBUEkgZmlyc3QuDQoNCkZvciBpbnN0YW5jZSwgb25jZSBpdCdzIHVwc3RyZWFt
LCB3ZSBjYW4gZWFzaWx5IGFkZCBpbiBkaWZmZXJlbnQgc2VyaWVzIA0KKGFuZCBkaWZmZXJl
bnQgcGVvcGxlKToNCi0gdGFyZ2V0X2N1cnJlbnQoKSAtPiBlbnVtIFRhcmdldA0KLSB0YXJn
ZXRfYWFyY2g2NCgpIC0+IGJvb2wNCmFuZCBwcm9ncmVzcyB3aXRob3V0IGhhdmluZyB0byBm
aXJzdCBiZSBibG9ja2VkIGJ5IHRoZSBleGlzdGVuY2Ugb2YgDQpUYXJnZXRJbmZvIGl0c2Vs
Zi4gV2UgY2FuIGFzIHdlbGwgY2hlcnJ5IHBpY2sgb3VyIG11dHVhbCBwYXRjaGVzIA0KdG91
Y2hpbmcgVGFyZ2V0SW5mbyB3aXRob3V0IGdldHRpbmcgYmxvY2tlZCBieSB0aGUgdXBzdHJl
YW0gcHJvY2VzcyANCml0c2VsZiwgYW5kIHRoZSBmaXJzdCBzZXJpZXMgdG8gYmUgcHVsbGVk
IHdpbGwgbWFrZSBpdCBhdmFpbGFibGUgZm9yIA0KZXZlcnlvbmUuDQoNCj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8wYjQzNzZlZS01MDRiLTQwOTYtYTU5MC04YTUw
OWVjNzg5NGRAbGluYXJvLm9yZy8NCj4gDQo+Pg0KPj4gTWluaW1hbCByZXF1aXJlbWVudHMg
dG8gaGF2ZSBhIGNvbXBsZXRlIHNlcmllcyB3b3VsZCBiZToNCj4+IC0gUmVuYW1lIFFNUCBU
YXJnZXRJbmZvIHN0cnVjdCB0byB1c2UgdGhhdCBuYW1lDQo+PiAtIEJlIGFibGUgdG8gcXVl
cnkgdGFyZ2V0IGNwdSB0eXBlICh3aGF0IHRoaXMgc2VyaWVzIGRvZXMpDQo+PiAtIEJlIGFi
bGUgdG8gcXVlcnkgbWFjaGluZSBjcHUgdHlwZQ0KPj4gLSBNb2RpZnkgZ2VuZXJpYyBmdW5j
dGlvbnMgbGlzdGluZyBtYWNoaW5lcy9jcHVzIHRvIHRha2UgdGhpcyBpbnRvIGFjY291bnQN
Cj4+IC0gVGFnIGxhYmVsZWQgYm9hcmRzL2NwdSBpbiBody9hcm0gdG8gcHJvdmUgdGhpcyBp
cyB3b3JraW5nICh3aXRob3V0DQo+PiBkb2luZyBhbnkgb3RoZXIgY2xlYW51cCB0byB0aG9z
ZSBmaWxlcyBhbmQgKm5vdCogbWFrZSB0aGVtIGNvbW1vbikNCj4+IC0gTm8gb3RoZXIgYWRk
aXRpb25hbCB0YXJnZXQgaW5mb3JtYXRpb24gZm9yIHRoZSB2MSwgbGV0J3Mga2VlcCB0aGF0
IGZvcg0KPj4gbGF0ZXIuDQo+Pg0KPj4gTm90ZTogdGFyZ2V0X2NwdV90eXBlIHdpbGwgbm90
IGJlIFRZUEVfQVJNX0NQVSwgYXMgaXQgd3JvbmdseSB3cmFwcw0KPj4gYXJtMzIgYW5kIGFh
cmNoNjQgY3B1cywgd2hpbGUgaXQgc2hvdWxkIGNvcnJlY3RseSBpZGVudGlmeSBvbmUgb3Ig
dGhlDQo+PiBvdGhlci4gSSBzdWdnZXN0ZWQgVFlQRV9UQVJHRVRfQ1BVX0FSTSwgVFlQRV9U
QVJHRVRfQ1BVX0FBUkNINjQsIGFuZA0KPj4gc2FtZSBmb3IgbWFjaGluZXM6IFRZUEVfVEFS
R0VUX01BQ0hJTkVfQVJNLCBUWVBFX1RBUkdFVF9NQUNISU5FX0FBUkNINjQuDQo+PiBTbyB3
ZSBjYW4gcmV1c2UgdGhpcyBuYW1pbmcgY29udmVudGlvbiB3aXRoIGFueSBvdGhlciB0YXJn
ZXQgd2UnbGwgcmV1c2UNCj4+IGluIHRoZSBmdXR1cmUuDQo+IA0KPiBHb3QgaXQuDQo+IA0K
Pj4NCj4+IFBpZXJyaWNrDQoNCg==

