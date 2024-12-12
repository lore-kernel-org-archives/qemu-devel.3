Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5506E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 19:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLonn-0000iG-3X; Thu, 12 Dec 2024 14:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLonj-0000hk-2K
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:24:43 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tLonh-0004uD-Ai
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 14:24:42 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ef89dbd8eeso649595a91.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 11:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734031480; x=1734636280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w/abNnvBHtttfka38vRKpfU/Dxz3B0Ut4WqIGonSpTc=;
 b=aokRtCUPbDgyXmWwp0wkUGAXiJRG8wVtrbElstPcsf/n7sUfba6WAhaMTwB+HbovJl
 ftMCmm/XlfUugOHEI7lR1jT9GwJQ+OfB3iZqbdWAeiG+r/WTLZ1wC2kOitgs4N4zuG5/
 ajxGI3OnsisvKAt4gQXPLijQ9y6w18g1Bt6vI/C10qDmKCDZXa0Ru4k1wpzmcZ94tbz7
 TIOfIW8eFqaiUxrVvXNBHU8xy/fv6ydIKxWrO4NStTwxwhozK0U15UPsdYVkL9UBq7qy
 kCPAvkp7sq0MATgUybNvflCTKaTplOSjWvhc5rKc7ifRntiMpKC/nNmUM5fTLzGEcr0/
 ZY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734031480; x=1734636280;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w/abNnvBHtttfka38vRKpfU/Dxz3B0Ut4WqIGonSpTc=;
 b=a7aLJGHp9c99SOJK+kjQ/JAJA9yDg7GMJ8Mglqsyxa5lWhKzm8lO00hRqxAoGLkfKT
 w9H5QFT0uowkP9XPgRQzkJrfFm9+MyIms3JoL0lgu918iRsheRINB1SeMtU/cEjW4OcM
 1Htz3Gzx5+Hp9nStqphW0S2EN2NTOfR2CJIujrjt9DOaV02qggIOYHiSZW36l0QE1tJS
 27rVJ6nVqkXIGtpN1I+rBZXd2X8V2WtlWtDfwXULrw3Rhv+dLKrhRqALtzeAZJdGq4Ud
 0nsLIIqxwXnDj5+LCWH6SmG4qsGeaNfZhjw86yMPXLvBlhej5UleokOVmbOujg/dFBRy
 xTVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0BIMXQjHuyDvE39NRIV85Pd6IxCA9AmTI0NRp139HtlJGnaScIfh96FgDekQ3wvLx8V9sju3IynAt@nongnu.org
X-Gm-Message-State: AOJu0YzqTzfDoSG+x8qgAiZpCDq5yVZbjXFqRp1TRBzKAi3y2saAmblV
 kOUeptj5OmCwtPTwtcykWedhPBk82vs4f+jAV5+t9KU5G/EV95mPF80EAtzF3KlbdYtI3NJ+nwt
 HJ9k=
X-Gm-Gg: ASbGnctBDBpbtmABFOjMwcDvOCUFN5hTfDX/lvSiHFQBpZysUyXlnFhIJ/Be5qySaGW
 mCVDb5KlSvafXZQt4qmbnaxBf2s9qbd58tCLl/6hAZShOWUiRqcBpyJdsFx4iQMIeLPXvjlTivs
 O8SPgWVi3SRXTKCjYZ0M8fHPFp/iSYBMGS9iWnFtSHM9YxBHWKEMtbwPBBAzRP0BRdtDjtG5qrh
 saglXtQL/j/FrQ59hsQPL0/8vQGo3CrFiBjLAIKk5tqVcdr+G+kf3xfplGo9c+p8XEnlwcHnvsY
 nOZmD3uGJ1O92v7a2ITnKGqVc3D2
X-Google-Smtp-Source: AGHT+IFbAjDbQ4V84MaxPn2TeNVbuh0JFo34Ih+WatUyO9hjqhQ2U/fAWV0UU2PU8zBaGuSgNb7IOA==
X-Received: by 2002:a17:90b:184b:b0:2ee:ab29:1a63 with SMTP id
 98e67ed59e1d1-2f13925b18bmr7397642a91.3.1734031479861; 
 Thu, 12 Dec 2024 11:24:39 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-216364e471asm85808835ad.92.2024.12.12.11.24.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 11:24:39 -0800 (PST)
Message-ID: <22dd4494-5af4-4896-8240-3bf25e0600d3@linaro.org>
Date: Thu, 12 Dec 2024 11:24:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] system: Remove unnecessary 'exec/translate-all.h'
 include
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
 <20241212185341.2857-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241212185341.2857-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

T24gMTIvMTIvMjQgMTA6NTMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBB
dCB0aGlzIHBvaW50ICJleGVjL3RyYW5zbGF0ZS1hbGwuaCIgb25seSBkZWNsYXJlDQo+IHRi
X2NoZWNrX3dhdGNocG9pbnQoKSwgd2hpY2ggaXNuJ3QgdXNlZCBieSBhbnkgb2YNCj4gY3B1
LXRhcmdldC5jIG9yIHN5c3RlbS9waHlzbWVtLmMsIHNvIHJlbW92ZSBpdHMNCj4gaW5jbHVz
aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBo
aWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBjcHUtdGFyZ2V0LmMgICAgIHwgMSAtDQo+
ICAgc3lzdGVtL3BoeXNtZW0uYyB8IDEgLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9jcHUtdGFyZ2V0LmMgYi9jcHUtdGFyZ2V0
LmMNCj4gaW5kZXggNWE3YzMyOTA4MTQuLjRhODhmMWM2ZGI4IDEwMDY0NA0KPiAtLS0gYS9j
cHUtdGFyZ2V0LmMNCj4gKysrIGIvY3B1LXRhcmdldC5jDQo+IEBAIC00MSw3ICs0MSw2IEBA
DQo+ICAgI2luY2x1ZGUgImV4ZWMvY3B1LWNvbW1vbi5oIg0KPiAgICNpbmNsdWRlICJleGVj
L2V4ZWMtYWxsLmgiDQo+ICAgI2luY2x1ZGUgImV4ZWMvdGItZmx1c2guaCINCj4gLSNpbmNs
dWRlICJleGVjL3RyYW5zbGF0ZS1hbGwuaCINCj4gICAjaW5jbHVkZSAiZXhlYy9sb2cuaCIN
Cj4gICAjaW5jbHVkZSAiaHcvY29yZS9hY2NlbC1jcHUuaCINCj4gICAjaW5jbHVkZSAidHJh
Y2UvdHJhY2Utcm9vdC5oIg0KPiBkaWZmIC0tZ2l0IGEvc3lzdGVtL3BoeXNtZW0uYyBiL3N5
c3RlbS9waHlzbWVtLmMNCj4gaW5kZXggOTNjMGZmNjBlYjQuLjBmYTZjMzdjNzc0IDEwMDY0
NA0KPiAtLS0gYS9zeXN0ZW0vcGh5c21lbS5jDQo+ICsrKyBiL3N5c3RlbS9waHlzbWVtLmMN
Cj4gQEAgLTYxLDcgKzYxLDYgQEANCj4gICANCj4gICAjaW5jbHVkZSAicWVtdS9yY3VfcXVl
dWUuaCINCj4gICAjaW5jbHVkZSAicWVtdS9tYWluLWxvb3AuaCINCj4gLSNpbmNsdWRlICJl
eGVjL3RyYW5zbGF0ZS1hbGwuaCINCj4gICAjaW5jbHVkZSAic3lzdGVtL3JlcGxheS5oIg0K
PiAgIA0KPiAgICNpbmNsdWRlICJleGVjL21lbW9yeS1pbnRlcm5hbC5oIg0KDQpSZXZpZXdl
ZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0K
DQo=

