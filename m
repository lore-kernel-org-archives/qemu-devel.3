Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CBCC369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 18:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7IGT-0000ri-L8; Tue, 22 Apr 2025 14:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7IGN-0000qm-T0
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:22:34 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7IGJ-0000F9-Me
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 14:22:29 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so4811418b3a.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 11:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745346138; x=1745950938; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jvd5snhjtwy6nHzxTqr8pLhoYGxkxas2yhzwHV6nVG0=;
 b=EYf9D7pb5hz+LM8Y+T02ACMKwLBubNJpy+azWYkTgCl9LTQ5/LxQnVzvCXS5mqAQ5p
 Bs7gc8w9Yewr93Uw/tasOitbElt4kK+heRyhrqx360LU9s+bQYWe8NJl0g4TAG2F6OaW
 S/LUjaNoUENg2fWoqq+DNI0P/6PnaL9gVah2waZNRt/JLRbpeovttBQuQwBaE6v6Oxtl
 39mxr8sS6sNZcMfW/9QmWu2jwYZstvaTBRrHwUo4SQaoqml9iihb9kNA+zKzG9934W4i
 isO3w3yx2XoRWru4O4jUl3F3u4c4cQJys6FD4V65GsD3Gqk6SES5n3wfKhBXqpBthksz
 7C4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745346138; x=1745950938;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jvd5snhjtwy6nHzxTqr8pLhoYGxkxas2yhzwHV6nVG0=;
 b=JybvjHv19TY/JXVjjWsqVzdXhUtl+W2mEe7qturGa2qrox6ngStIh5/Jy+5HRrrkb1
 sC1pYgqGXmg5mqcf6/BOoGVFMLJ7783gXPm+YVCuycwg5wm6gSpMeIhD88C6nrYEzQP0
 874qSwwGCY4/7Fc5OawkrZPcs+lE4wJYb2pa7D4C2n15UwUFM5//d59+nziQJd/3cB9+
 QbwMDkY33gJDFQyB1O7ttkkmNEYUX9TTk9etCPb1jbzw5KGw2y8uV8s2daESx9BCcghv
 MZIu7P/l/HdnZuR5ziiTQxYBCEGzErgb/j9c+p36kfZCljdOTGEnnMR8TNJnkUAt036S
 gr9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDGWaXiM6eFrEjNE873ZAuPFXmPWYGexdUSq76mrJa/+H3T+Iv+BlyDRndb14HStsc5oHX4K42CG57@nongnu.org
X-Gm-Message-State: AOJu0YxDFOz4N+3qsYIlV68kS8/88cVzD9NC5UJIY8PfkoUuKoWhLW1V
 EQPhCqEEADDM07lqiPgF8SBE8JH9WnuQD2ODWJMpQNx4VJ4UbwH/nj34MeishJs=
X-Gm-Gg: ASbGncvPV5gP2T9ugOF0eVwQNhp63WWgfaGzh+q/MZpL7x8QZrjHdg4F3MET6WSBCeE
 YJh2oGvL3+ZHA6e+vUfYakXndslwF/FZI7lu30tFXavYlixEvvPvW7I6+l8vQzFS7PGOpgs/iB/
 KTp9s6x0bVWjbf8UZvkZPx33kyvAv65pquuSJQFZQMSdvHbxWJsMljDOuK4WZ/RQzsGw/DQGc9o
 5qVcUNVQZLOKcQ+4ulihyrp1Ekus31N8/dBmEUtaViXk5mxrxPKSvm4lTc9eK1nQdguzx+2xmuY
 cxhNpGy9zTzKaEMnfBm50UiV4u6CeqA2/deICSdQ2aBvVmCryJT76gT8PGkEHlCe
X-Google-Smtp-Source: AGHT+IFLQERIftoY+36BwPE9So8bL9jMa1/dTMl501aNs9i49adXFO7OouuEqpXaWAruWKkT91Uiwg==
X-Received: by 2002:a05:6a00:179d:b0:736:51a6:78b1 with SMTP id
 d2e1a72fcca58-73dc14e01bemr20804101b3a.11.1745346137894; 
 Tue, 22 Apr 2025 11:22:17 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfae99d6sm8925152b3a.159.2025.04.22.11.22.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 11:22:17 -0700 (PDT)
Message-ID: <ecbbebbd-8ea6-48b4-80e8-fedc23d914d9@linaro.org>
Date: Tue, 22 Apr 2025 11:22:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 16/19] hw/arm/virt: Replace TARGET_AARCH64 ->
 target_aarch64()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-17-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250422145502.70770-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

T24gNC8yMi8yNSAwNzo1NCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFJl
cGxhY2UgdGhlIHRhcmdldC1zcGVjaWZpYyBUQVJHRVRfQUFSQ0g2NCBkZWZpbml0aW9uDQo+
IGJ5IGEgY2FsbCB0byB0aGUgZ2VuZXJpYyB0YXJnZXRfYWFyY2g2NCgpIGhlbHBlci4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGlu
YXJvLm9yZz4NCj4gLS0tDQo+IFRoaXMgcmVtb3ZlcyB0aGUgbGFzdCBUQVJHRVRfQUFSQ0g2
NCBpbiBody9hcm0vLg0KPiAtLS0NCj4gICBody9hcm0vdmlydC5jIHwgOSArKysrKy0tLS0N
Cj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2h3L2FybS92aXJ0LmMgYi9ody9hcm0vdmlydC5jDQo+IGlu
ZGV4IGQ3MTk3OTU4ZjdjLi40ZTExMjcyYTNhYyAxMDA2NDQNCj4gLS0tIGEvaHcvYXJtL3Zp
cnQuYw0KPiArKysgYi9ody9hcm0vdmlydC5jDQo+IEBAIC0zMiw2ICszMiw3IEBADQo+ICAg
I2luY2x1ZGUgInFlbXUvZGF0YWRpci5oIg0KPiAgICNpbmNsdWRlICJxZW11L3VuaXRzLmgi
DQo+ICAgI2luY2x1ZGUgInFlbXUvb3B0aW9uLmgiDQo+ICsjaW5jbHVkZSAicWVtdS90YXJn
ZXQtaW5mby5oIg0KPiAgICNpbmNsdWRlICJtb25pdG9yL3FkZXYuaCINCj4gICAjaW5jbHVk
ZSAiaHcvc3lzYnVzLmgiDQo+ICAgI2luY2x1ZGUgImh3L2FybS9ib290LmgiDQo+IEBAIC0z
MTM3LDcgKzMxMzgsOCBAQCBzdGF0aWMgR1NMaXN0ICp2aXJ0X2dldF92YWxpZF9jcHVfdHlw
ZXMoY29uc3QgTWFjaGluZVN0YXRlICptcykNCj4gICAgICAgaWYgKHRjZ19lbmFibGVkKCkp
IHsNCj4gICAgICAgICAgIHZjdCA9IGdfc2xpc3RfcHJlcGVuZCh2Y3QsIGdfc3RyZHVwKEFS
TV9DUFVfVFlQRV9OQU1FKCJjb3J0ZXgtYTciKSkpOw0KPiAgICAgICAgICAgdmN0ID0gZ19z
bGlzdF9wcmVwZW5kKHZjdCwgZ19zdHJkdXAoQVJNX0NQVV9UWVBFX05BTUUoImNvcnRleC1h
MTUiKSkpOw0KPiAtI2lmZGVmIFRBUkdFVF9BQVJDSDY0DQo+ICsgICAgfQ0KPiArICAgIGlm
ICh0Y2dfZW5hYmxlZCgpICYmIHRhcmdldF9hYXJjaDY0KCkpIHsNCj4gICAgICAgICAgIHZj
dCA9IGdfc2xpc3RfcHJlcGVuZCh2Y3QsIGdfc3RyZHVwKEFSTV9DUFVfVFlQRV9OQU1FKCJj
b3J0ZXgtYTM1IikpKTsNCj4gICAgICAgICAgIHZjdCA9IGdfc2xpc3RfcHJlcGVuZCh2Y3Qs
IGdfc3RyZHVwKEFSTV9DUFVfVFlQRV9OQU1FKCJjb3J0ZXgtYTU1IikpKTsNCj4gICAgICAg
ICAgIHZjdCA9IGdfc2xpc3RfcHJlcGVuZCh2Y3QsIGdfc3RyZHVwKEFSTV9DUFVfVFlQRV9O
QU1FKCJjb3J0ZXgtYTcyIikpKTsNCj4gQEAgLTMxNDcsMTUgKzMxNDksMTQgQEAgc3RhdGlj
IEdTTGlzdCAqdmlydF9nZXRfdmFsaWRfY3B1X3R5cGVzKGNvbnN0IE1hY2hpbmVTdGF0ZSAq
bXMpDQo+ICAgICAgICAgICB2Y3QgPSBnX3NsaXN0X3ByZXBlbmQodmN0LCBnX3N0cmR1cChB
Uk1fQ1BVX1RZUEVfTkFNRSgibmVvdmVyc2UtbjEiKSkpOw0KPiAgICAgICAgICAgdmN0ID0g
Z19zbGlzdF9wcmVwZW5kKHZjdCwgZ19zdHJkdXAoQVJNX0NQVV9UWVBFX05BTUUoIm5lb3Zl
cnNlLXYxIikpKTsNCj4gICAgICAgICAgIHZjdCA9IGdfc2xpc3RfcHJlcGVuZCh2Y3QsIGdf
c3RyZHVwKEFSTV9DUFVfVFlQRV9OQU1FKCJuZW92ZXJzZS1uMiIpKSk7DQo+IC0jZW5kaWYg
LyogVEFSR0VUX0FBUkNINjQgKi8NCj4gICAgICAgfQ0KPiAtI2lmZGVmIFRBUkdFVF9BQVJD
SDY0DQo+ICsgICAgaWYgKHRhcmdldF9hYXJjaDY0KCkpIHsNCj4gICAgICAgICAgIHZjdCA9
IGdfc2xpc3RfcHJlcGVuZCh2Y3QsIGdfc3RyZHVwKEFSTV9DUFVfVFlQRV9OQU1FKCJjb3J0
ZXgtYTUzIikpKTsNCj4gICAgICAgICAgIHZjdCA9IGdfc2xpc3RfcHJlcGVuZCh2Y3QsIGdf
c3RyZHVwKEFSTV9DUFVfVFlQRV9OQU1FKCJjb3J0ZXgtYTU3IikpKTsNCj4gICAgICAgICAg
IGlmIChrdm1fZW5hYmxlZCgpIHx8IGh2Zl9lbmFibGVkKCkpIHsNCj4gICAgICAgICAgICAg
ICB2Y3QgPSBnX3NsaXN0X3ByZXBlbmQodmN0LCBnX3N0cmR1cChBUk1fQ1BVX1RZUEVfTkFN
RSgiaG9zdCIpKSk7DQo+ICAgICAgICAgICB9DQo+IC0jZW5kaWYgLyogVEFSR0VUX0FBUkNI
NjQgKi8NCj4gKyAgICB9DQo+ICAgICAgIHZjdCA9IGdfc2xpc3RfcHJlcGVuZCh2Y3QsIGdf
c3RyZHVwKEFSTV9DUFVfVFlQRV9OQU1FKCJtYXgiKSkpOw0KPiAgIA0KPiAgICAgICByZXR1
cm4gdmN0Ow0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91
dmllckBsaW5hcm8ub3JnPg0KDQo=

