Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C03E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 19:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoq5-0003bo-Cq; Thu, 12 Dec 2024 14:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLopU-00033E-6d
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:26:35 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLopP-0005H7-Vc
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:26:30 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ee786b3277so646311a91.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 11:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734031586; x=1734636386; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TgjbEO1OUtjkhF/mpi0i+wxBAVuooTZYfCvPc7XN6y4=;
 b=LIfl5XWmXtWvcMw7n3PYiMPWHjk6O9QDr8IhoqknvLoiRE+IJR4jQVT4clIm96D2tX
 qERoR7rCi27nh5WSx6TtJl30lacpK8264Vbc9T5l5Q/E1VEp6mjpIZ3iUJjKl0a3mZ5A
 yy71cmOwt52VJpUjNHOHNfoUtNUq/C4xNGRCEmklHIWMfq29t7j6naDSlzt6PrFhWWfD
 nDfDluzPrAmPsdG/8EKTq9d0JZ50mdwl2d2Io1/r9G959TTRDR9fBU6n3062dnSFl0rx
 x+uxNeCWYjaDzuzrS2+G9r06+lDcPHJoAdkEzTwfVDiZW9mAn1hDkkvi6t1G+Nz7mQwB
 4Ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734031586; x=1734636386;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TgjbEO1OUtjkhF/mpi0i+wxBAVuooTZYfCvPc7XN6y4=;
 b=Ndw0gPTlm3h8x6Y724qOEkbItT18dSlFFHDHZtMM9ueIbiLLFGwy/2Q23lXHnbdrpA
 eBd80PNPzZ8hho+rp5UkXzBUBVlskEuxbHI9v9exXBtR3aJhXsdR7yO3EYpSoOXe8cvU
 Zqv6kIKfDEvu18iJxwII/GWFsiMifX7tw5RgoDXb1MM8Ll9LSWzayiX01cQoSd4P03Ko
 N9U+rbmZ8+zftc4dqcNdfcHAfHNA8hApRBrjbiXXPdld5esqwW71eSVy4FqPrjghEkN3
 H1p/0Pu1jyqjDLNX2QUR6ZAqDVsXqWak/vEQroE4EAlXeHQrJ4RlRR9usDaDlVLAOhL8
 JQZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTKONaF5I0iUreLDXuLXvsQMtThVRsWVUPtR4b2iK2KhfP0s2uD46104TnCNcq9kxhKfnHrwpgVJZ8@nongnu.org
X-Gm-Message-State: AOJu0Yw6W5vN+fONlr0vF1x2DVX8iMYOJMEkcVIdF/2u+F24H7HWUz99
 Vs8e6rQZFxjc3ZHEQMr5NUFZqu7Qq7zWykFgZSAUxkui755aRvFVNSZx6zmDGdURdE82UkBgjgZ
 q7F4=
X-Gm-Gg: ASbGncsDZlfLaCdWYKOdhwkJBW6H2k2fm7Z0CdXM9YIJQ2kSNZpBxWGI07c4eGimcg6
 DgDqCibtV81SHoozqRnAAkIkjfEfhSbf9GVBvTEjFoOPPvkb2ppw58/R0Q55Aq/tqxen9iQXsSC
 3ehQvbscc+qQhMsehS94nF8Xp/2F3QlqVGWDwOia9VroMAY7ZlOMC3ZzzR/Yfgtton0H++eD72N
 +WftO93iJBXftuQ0WpS9EsjAY2ygzWOR5frvhu8Yk0LL23vMECbt4eXgPM3uV9iVlBViiY02a73
 8GqrNT6vy2Z390Ujk0koeD8DXtrh
X-Google-Smtp-Source: AGHT+IFMuzAnGRjKGuogH92xUzD93Ard93bWjyrtInBjbE/wt9MTRwhHh2k9GzqNEblSoAF87i1o/Q==
X-Received: by 2002:a17:90b:3f46:b0:2ee:c04a:4276 with SMTP id
 98e67ed59e1d1-2f13925ad0bmr7743175a91.5.1734031585939; 
 Thu, 12 Dec 2024 11:26:25 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142e40bc8sm1644421a91.50.2024.12.12.11.26.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 11:26:25 -0800 (PST)
Message-ID: <48a7a3b4-5ea3-4b7c-9418-e280fab8d5bb@linaro.org>
Date: Thu, 12 Dec 2024 11:26:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/18] accel/tcg: Move user-related declarations out of
 'exec/cpu-all.h' (4/4)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
 <20241212185341.2857-15-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241212185341.2857-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

T24gMTIvMTIvMjQgMTA6NTMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBN
b3ZlIGRlY2xhcmF0aW9ucyByZWxhdGVkIHRvIHBhZ2UgcHJvdGVjdGlvbiB1bmRlciB1c2Vy
DQo+IGVtdWxhdGlvbiBmcm9tICJleGVjL2NwdS1hbGwuaCIgdG8gInVzZXIvcGFnZS1wcm90
ZWN0aW9uLmgiLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBpbmNsdWRlL2V4ZWMvY3B1LWFs
bC5oICAgICAgICAgfCA2IC0tLS0tLQ0KPiAgIGluY2x1ZGUvdXNlci9wYWdlLXByb3RlY3Rp
b24uaCB8IDIgKysNCj4gICBhY2NlbC90Y2cvdGItbWFpbnQuYyAgICAgICAgICAgfCAzICsr
Kw0KPiAgIGJzZC11c2VyL3NpZ25hbC5jICAgICAgICAgICAgICB8IDEgKw0KPiAgIGNwdS10
YXJnZXQuYyAgICAgICAgICAgICAgICAgICB8IDEgKw0KPiAgIGxpbnV4LXVzZXIvYXJtL2Nw
dV9sb29wLmMgICAgICB8IDEgKw0KPiAgIGxpbnV4LXVzZXIvc2lnbmFsLmMgICAgICAgICAg
ICB8IDEgKw0KPiAgIHRhcmdldC9hcm0vdGNnL2hlbHBlci1hNjQuYyAgICB8IDMgKysrDQo+
ICAgdGFyZ2V0L3MzOTB4L3RjZy9tZW1faGVscGVyLmMgIHwgNCArKystDQo+ICAgOSBmaWxl
cyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9jcHUtYWxsLmggYi9pbmNsdWRlL2V4ZWMvY3B1LWFs
bC5oDQo+IGluZGV4IDczYjExZjU4YWJiLi5mN2VlYTMzYjEwMSAxMDA2NDQNCj4gLS0tIGEv
aW5jbHVkZS9leGVjL2NwdS1hbGwuaA0KPiArKysgYi9pbmNsdWRlL2V4ZWMvY3B1LWFsbC5o
DQo+IEBAIC0xMjYsMTIgKzEyNiw2IEBAIGV4dGVybiBjb25zdCBUYXJnZXRQYWdlQml0cyB0
YXJnZXRfcGFnZTsNCj4gICANCj4gICAjZGVmaW5lIFRBUkdFVF9QQUdFX0FMSUdOKGFkZHIp
IFJPVU5EX1VQKChhZGRyKSwgVEFSR0VUX1BBR0VfU0laRSkNCj4gICANCj4gLSNpZiBkZWZp
bmVkKENPTkZJR19VU0VSX09OTFkpDQo+IC0NCj4gLWludCBwYWdlX2dldF9mbGFncyh0YXJn
ZXRfdWxvbmcgYWRkcmVzcyk7DQo+IC0NCj4gLSNlbmRpZg0KPiAtDQo+ICAgQ1BVQXJjaFN0
YXRlICpjcHVfY29weShDUFVBcmNoU3RhdGUgKmVudik7DQo+ICAgDQo+ICAgLyogRmxhZ3Mg
Zm9yIHVzZSBpbiBFTlYtPklOVEVSUlVQVF9QRU5ESU5HLg0KPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS91c2VyL3BhZ2UtcHJvdGVjdGlvbi5oIGIvaW5jbHVkZS91c2VyL3BhZ2UtcHJvdGVj
dGlvbi5oDQo+IGluZGV4IGJkZDk4YTM3ZGUxLi41MWRhYTE4NjQ4MCAxMDA2NDQNCj4gLS0t
IGEvaW5jbHVkZS91c2VyL3BhZ2UtcHJvdGVjdGlvbi5oDQo+ICsrKyBiL2luY2x1ZGUvdXNl
ci9wYWdlLXByb3RlY3Rpb24uaA0KPiBAQCAtMTksNiArMTksOCBAQA0KPiAgIHZvaWQgcGFn
ZV9wcm90ZWN0KHRiX3BhZ2VfYWRkcl90IHBhZ2VfYWRkcik7DQo+ICAgaW50IHBhZ2VfdW5w
cm90ZWN0KHRiX3BhZ2VfYWRkcl90IGFkZHJlc3MsIHVpbnRwdHJfdCBwYyk7DQo+ICAgDQo+
ICtpbnQgcGFnZV9nZXRfZmxhZ3ModGFyZ2V0X3Vsb25nIGFkZHJlc3MpOw0KPiArDQo+ICAg
LyoqDQo+ICAgICogcGFnZV9zZXRfZmxhZ3M6DQo+ICAgICogQHN0YXJ0OiBmaXJzdCBieXRl
IG9mIHJhbmdlDQo+IGRpZmYgLS1naXQgYS9hY2NlbC90Y2cvdGItbWFpbnQuYyBiL2FjY2Vs
L3RjZy90Yi1tYWludC5jDQo+IGluZGV4IDhlMjcyY2Y3OTBmLi4zZjFiZWJmNmFiNSAxMDA2
NDQNCj4gLS0tIGEvYWNjZWwvdGNnL3RiLW1haW50LmMNCj4gKysrIGIvYWNjZWwvdGNnL3Ri
LW1haW50LmMNCj4gQEAgLTMzLDYgKzMzLDkgQEANCj4gICAjaW5jbHVkZSAidGItaW50ZXJu
YWwuaCINCj4gICAjaW5jbHVkZSAiaW50ZXJuYWwtY29tbW9uLmgiDQo+ICAgI2luY2x1ZGUg
ImludGVybmFsLXRhcmdldC5oIg0KPiArI2lmZGVmIENPTkZJR19VU0VSX09OTFkNCj4gKyNp
bmNsdWRlICJ1c2VyL3BhZ2UtcHJvdGVjdGlvbi5oIg0KPiArI2VuZGlmDQo+ICAgDQo+ICAg
DQo+ICAgLyogTGlzdCBpdGVyYXRvcnMgZm9yIGxpc3RzIG9mIHRhZ2dlZCBwb2ludGVycyBp
biBUcmFuc2xhdGlvbkJsb2NrLiAqLw0KPiBkaWZmIC0tZ2l0IGEvYnNkLXVzZXIvc2lnbmFs
LmMgYi9ic2QtdXNlci9zaWduYWwuYw0KPiBpbmRleCBkYTQ5YjliZmZjMS4uZWRiY2Q0NjFi
ZmEgMTAwNjQ0DQo+IC0tLSBhL2JzZC11c2VyL3NpZ25hbC5jDQo+ICsrKyBiL2JzZC11c2Vy
L3NpZ25hbC5jDQo+IEBAIC0yMiw2ICsyMiw3IEBADQo+ICAgI2luY2x1ZGUgInFlbXUvbG9n
LmgiDQo+ICAgI2luY2x1ZGUgInFlbXUuaCINCj4gICAjaW5jbHVkZSAiZXhlYy9wYWdlLXBy
b3RlY3Rpb24uaCINCj4gKyNpbmNsdWRlICJ1c2VyL3BhZ2UtcHJvdGVjdGlvbi5oIg0KPiAg
ICNpbmNsdWRlICJ1c2VyL3Rzd2FwLXRhcmdldC5oIg0KPiAgICNpbmNsdWRlICJnZGJzdHVi
L3VzZXIuaCINCj4gICAjaW5jbHVkZSAic2lnbmFsLWNvbW1vbi5oIg0KPiBkaWZmIC0tZ2l0
IGEvY3B1LXRhcmdldC5jIGIvY3B1LXRhcmdldC5jDQo+IGluZGV4IDRhODhmMWM2ZGI4Li42
OWE0OTIwMjExMCAxMDA2NDQNCj4gLS0tIGEvY3B1LXRhcmdldC5jDQo+ICsrKyBiL2NwdS10
YXJnZXQuYw0KPiBAQCAtMjksNiArMjksNyBAQA0KPiAgICNpbmNsdWRlICJtaWdyYXRpb24v
dm1zdGF0ZS5oIg0KPiAgICNpZmRlZiBDT05GSUdfVVNFUl9PTkxZDQo+ICAgI2luY2x1ZGUg
InFlbXUuaCINCj4gKyNpbmNsdWRlICJ1c2VyL3BhZ2UtcHJvdGVjdGlvbi5oIg0KPiAgICNl
bHNlDQo+ICAgI2luY2x1ZGUgImh3L2NvcmUvc3lzZW11LWNwdS1vcHMuaCINCj4gICAjaW5j
bHVkZSAiZXhlYy9hZGRyZXNzLXNwYWNlcy5oIg0KPiBkaWZmIC0tZ2l0IGEvbGludXgtdXNl
ci9hcm0vY3B1X2xvb3AuYyBiL2xpbnV4LXVzZXIvYXJtL2NwdV9sb29wLmMNCj4gaW5kZXgg
ZWM2NjU4NjJkOTMuLjcwOWY3MThhOTlkIDEwMDY0NA0KPiAtLS0gYS9saW51eC11c2VyL2Fy
bS9jcHVfbG9vcC5jDQo+ICsrKyBiL2xpbnV4LXVzZXIvYXJtL2NwdV9sb29wLmMNCj4gQEAg
LTI1LDYgKzI1LDcgQEANCj4gICAjaW5jbHVkZSAic2lnbmFsLWNvbW1vbi5oIg0KPiAgICNp
bmNsdWRlICJzZW1paG9zdGluZy9jb21tb24tc2VtaS5oIg0KPiAgICNpbmNsdWRlICJleGVj
L3BhZ2UtcHJvdGVjdGlvbi5oIg0KPiArI2luY2x1ZGUgInVzZXIvcGFnZS1wcm90ZWN0aW9u
LmgiDQo+ICAgI2luY2x1ZGUgInRhcmdldC9hcm0vc3luZHJvbWUuaCINCj4gICANCj4gICAj
ZGVmaW5lIGdldF91c2VyX2NvZGVfdTMyKHgsIGdhZGRyLCBlbnYpICAgICAgICAgICAgICAg
IFwNCj4gZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvc2lnbmFsLmMgYi9saW51eC11c2VyL3Np
Z25hbC5jDQo+IGluZGV4IDliNmQ3NzI4ODJkLi5hMTkxZTliMjZmMiAxMDA2NDQNCj4gLS0t
IGEvbGludXgtdXNlci9zaWduYWwuYw0KPiArKysgYi9saW51eC11c2VyL3NpZ25hbC5jDQo+
IEBAIC0zMyw2ICszMyw3IEBADQo+ICAgI2luY2x1ZGUgInRyYWNlLmgiDQo+ICAgI2luY2x1
ZGUgInNpZ25hbC1jb21tb24uaCINCj4gICAjaW5jbHVkZSAiaG9zdC1zaWduYWwuaCINCj4g
KyNpbmNsdWRlICJ1c2VyL3BhZ2UtcHJvdGVjdGlvbi5oIg0KPiAgICNpbmNsdWRlICJ1c2Vy
L3NhZmUtc3lzY2FsbC5oIg0KPiAgICNpbmNsdWRlICJ0Y2cvdGNnLmgiDQo+ICAgDQo+IGRp
ZmYgLS1naXQgYS90YXJnZXQvYXJtL3RjZy9oZWxwZXItYTY0LmMgYi90YXJnZXQvYXJtL3Rj
Zy9oZWxwZXItYTY0LmMNCj4gaW5kZXggOGY0MmEyOGQwN2IuLmJjMTQ0Njg4ZGQ1IDEwMDY0
NA0KPiAtLS0gYS90YXJnZXQvYXJtL3RjZy9oZWxwZXItYTY0LmMNCj4gKysrIGIvdGFyZ2V0
L2FybS90Y2cvaGVscGVyLWE2NC5jDQo+IEBAIC0zNCw2ICszNCw5IEBADQo+ICAgI2luY2x1
ZGUgInFlbXUvYXRvbWljMTI4LmgiDQo+ICAgI2luY2x1ZGUgImZwdS9zb2Z0ZmxvYXQuaCIN
Cj4gICAjaW5jbHVkZSA8emxpYi5oPiAvKiBmb3IgY3JjMzIgKi8NCj4gKyNpZmRlZiBDT05G
SUdfVVNFUl9PTkxZDQo+ICsjaW5jbHVkZSAidXNlci9wYWdlLXByb3RlY3Rpb24uaCINCj4g
KyNlbmRpZg0KPiAgIA0KPiAgIC8qIEMyLjQuNyBNdWx0aXBseSBhbmQgZGl2aWRlICovDQo+
ICAgLyogc3BlY2lhbCBjYXNlcyBmb3IgMCBhbmQgTExPTkdfTUlOIGFyZSBtYW5kYXRlZCBi
eSB0aGUgc3RhbmRhcmQgKi8NCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9zMzkweC90Y2cvbWVt
X2hlbHBlci5jIGIvdGFyZ2V0L3MzOTB4L3RjZy9tZW1faGVscGVyLmMNCj4gaW5kZXggMGUx
MmRhZTJhYTguLjMwNzM4OGU1YmQxIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvczM5MHgvdGNn
L21lbV9oZWxwZXIuYw0KPiArKysgYi90YXJnZXQvczM5MHgvdGNnL21lbV9oZWxwZXIuYw0K
PiBAQCAtMzEsNyArMzEsOSBAQA0KPiAgICNpbmNsdWRlICJxZW11L2ludDEyOC5oIg0KPiAg
ICNpbmNsdWRlICJxZW11L2F0b21pYzEyOC5oIg0KPiAgIA0KPiAtI2lmICFkZWZpbmVkKENP
TkZJR19VU0VSX09OTFkpDQo+ICsjaWYgZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQ0KPiAr
I2luY2x1ZGUgInVzZXIvcGFnZS1wcm90ZWN0aW9uLmgiDQo+ICsjZWxzZQ0KPiAgICNpbmNs
dWRlICJody9zMzkweC9zdG9yYWdlLWtleXMuaCINCj4gICAjaW5jbHVkZSAiaHcvYm9hcmRz
LmgiDQo+ICAgI2VuZGlmDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVy
cmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

