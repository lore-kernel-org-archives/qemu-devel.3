Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CAFC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 14:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx5Di-000400-B9; Tue, 25 Mar 2025 10:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tx5Da-0003zI-RR
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 10:25:27 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tx5DZ-0001l6-3H
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 10:25:26 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-226185948ffso109226975ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742912723; x=1743517523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ev8H5hW3YKFGi2DmfoRfOKAsTEGFQWSbua0lpMfn/y4=;
 b=DxTPuWfj+yWmHWngQby1SCCN8XMdNKwJ23K/hh5G5Eq5ZYSNElNT0QfscB5WTV/FCy
 FmA7YwqoWo9YbaygiNIeukFKV73+/nM/AqAwB1+jOtsa1yR0DHRXfiArWdnyOMzLxWh8
 whOK7yo2vVe1CJdEgLadjMVhK38MuREuGQRP0E6FPgdSx0XlYCnkO1zAZu84G4omfjDE
 ATn43mYl3Cgf7eT5kWLdCLcej/V1pWm6ahAWbT0/N4IOhZm/a9wwFzlXPXOmxLCYTkDk
 yLCddlKkdOSMmAAYf0RMIRcdcOdyPMhk/gqSmRkqWmk3y0vucVaDAzOfk7fBR6hfbLsG
 xPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742912723; x=1743517523;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ev8H5hW3YKFGi2DmfoRfOKAsTEGFQWSbua0lpMfn/y4=;
 b=XqPH7DkEynl0HfO9sLG78Hl2V5G+UmtJn0xfDiNucdZVBNxneXH5Dk2/8GX03BI6IM
 oGaSDxC/zn8jaExeCtccrVNgNw9bewV9JWUXJreQCKJK40JBbt2tUPTrKS4CmcibrRSG
 lFS9+nNmBKy8GmskAnT0X1e+RPfu/1eERbZjcMMaigFitH/lyz5ptiS/C6metAofNxO8
 izH84V7ujDcx717ABbpwgm1Qs0pGkwk/7bQJV5iqX9fih0I+BtLv/8FUxEYSmIvZwi56
 7TIlg+cId7AI4W+xMbRt+F5y1bGOJ6OSzhxzHw1Ff5FKKMD22gk+LB+Cd0SyBUrea37h
 aAcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgBllkLixyr3C7KDs0+3CUUCBnIagqkF4G2pg5DeIWjHWfe9PKUUl6WFVR3ABqal6yA/s8Q0+/4GSZ@nongnu.org
X-Gm-Message-State: AOJu0YwwNXkW2Bupij2BkW7wvT9adNEBgCJ+opVsYBifRUd/P/beUpmm
 FqBG3t/SszLGA2E44AKPk/gVKNhhducsGfVDqsw37GnXnzW1WwmAMBPOv8z1lJI=
X-Gm-Gg: ASbGnctobn/eO6z9fWg7Z+pwEgWIwyJwPIUcsz4QCAgI7QHXB5+Ej3v6a2hZoBpUI2E
 12nmPnyRl8xbhqLDwaT2WqyEZMU72I1b0UonAfF4Wxvi0U/PJpYZxNOh1pH4jEFvbMBbZVfupBa
 /TnbCK/uC5D8Qk2gsgTs5kE6ga906b9Gh1Sf4nfGnu+xLrYknGH5WljuZp5oTMpl4SmPV8bzmmA
 ag/MrNuAfldyZ5KbQ5S7VX/qS3eewMR6RS8HBkpEAxqw6pmHlAHW1iTKRPCxRnCOs4E0rK9fOaM
 zbGeCjcT7C9kEtJbATcjCmqWGkBsc1h/5Pfo7/T82a+5zEMHHi/dj22OVA==
X-Google-Smtp-Source: AGHT+IFWxqLkNDMPvo4+4xAXoh/x9rxpYlBjbxGSKFOHCxOSdQrUpxzSZOOrOJbQi1uEoHTOHOa+9g==
X-Received: by 2002:a17:902:f652:b0:223:5ada:88ff with SMTP id
 d9443c01a7336-22780d9bde9mr299549905ad.24.1742912723255; 
 Tue, 25 Mar 2025 07:25:23 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f3b520sm90875085ad.6.2025.03.25.07.25.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 07:25:22 -0700 (PDT)
Message-ID: <d728469c-13bf-4d79-bfce-f06d088124fc@linaro.org>
Date: Tue, 25 Mar 2025 07:25:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 0/5] exec: Remove TARGET_LONG_SIZE definition
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
References: <20250325130221.76116-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250325130221.76116-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

T24gMy8yNS8yNSAwNjowMiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFRB
UkdFVF9MT05HX1NJWkUgaXMgb25seSB1c2VkIGluIDEgc291cmNlIGZpbGUNCj4gYW5kIDEg
aGVhZGVyLiBSZW1vdmUgaXQgdG8gYmUgYWJsZSB0byBmb2N1cyBvbg0KPiBtYWtpbmcgVEFS
R0VUX0xPTkdfQklUUyB0YXJnZXQgYWdub3N0aWMuDQo+IA0KPiBQaGlsaXBwZSBNYXRoaWV1
LURhdWTDqSAoNSk6DQo+ICAgIHRhcmdldC9pMzg2OiBVc2UgZXhwbGljaXQgbGl0dGxlLWVu
ZGlhbiBMRC9TVCBBUEkNCj4gICAgZ2Ric3R1YjogUmVtb3ZlIGxkdHVsX2JlX3AoKSBhbmQg
bGR0dWxfbGVfcCgpIG1hY3Jvcw0KPiAgICB0YXJnZXQvcHBjL2dkYnN0dWI6IFJlcGxhY2Ug
VEFSR0VUX0xPTkdfU0laRSAtPiBzaXplb2YodGFyZ2V0X3Vsb25nKQ0KPiAgICB1c2VyL3Rz
d2FwOiBSZXBsYWNlIFRBUkdFVF9MT05HX1NJWkUgLT4gVEFSR0VUX0xPTkdfQklUUw0KPiAg
ICBleGVjL3RhcmdldF9sb25nOiBSZW1vdmUgVEFSR0VUX0xPTkdfU0laRSBkZWZpbml0aW9u
DQo+IA0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmll
ckBsaW5hcm8ub3JnPg0K

