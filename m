Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD09C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 02:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5bst-0008AU-67; Thu, 17 Apr 2025 22:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5bsq-0008A5-SK
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 22:55:16 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5bso-00006y-LU
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 22:55:16 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-af590aea813so2611719a12.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 19:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744944913; x=1745549713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jysRZG7IC5BNvpFAYpeDgHllFLDMtmDXhM+PEUQTCvA=;
 b=g0avuUEbYNMw5n6FBDl6jp4rJn8yvfEbkQbKf/+fr2xQ26fzWoeOpCjj+pXkTDfD8P
 DGn0EXHr4CUknZ1H0ROx/819ZtyRTM+29YywoXIMYHwTVjZkMif/hxj04Z8lRsz6X2vV
 BceIysInkY8w8KOk7ySv+xFVczfJfmo6U3t9M1/9TFxS96G/mVowP7bGR3LP7lFMa2Xb
 CwDdlyAUfrytZhg5H7KOtEiLm8GfToFC29PGRpozIrhUg4KkFb3dWapO7lrgFL6Zbg6D
 ALYfPC/BZ3wyiksE/0UeSP+c+cJYMPMaVqJqJy9LKKTmydzx11X6I1T5ZBBe0Uy7W72X
 jbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744944913; x=1745549713;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jysRZG7IC5BNvpFAYpeDgHllFLDMtmDXhM+PEUQTCvA=;
 b=ZonlcK1UxwWrXoJ+u665Ny8dhecLgIZQdGRK1n2MRyLv6XLeffml/PbMacwZ3/EEHZ
 y0Z6Qq3nY+55B/0ZpGPvXBT2EHxqS9OZsfnxl4gRG6RKs5JIdMC5Zp3P4njQfl+8f9so
 kfk6rkkIeen59zLgfSuwVcc9btkbLGEsoNbWyXbNMMBQwLa9mPwtkCaX2R1ZY9vxiqMx
 BSuz060IFv5r+mdWwxZtt3r7urW/9MizjrtUDmt12KQJ6LMUpcLPdVzHX9DkgNwWCiY5
 nDOwO/i+ycsxYFp2y8GIDCfNQlAFM+xkCdm6K660FVHZIsyuxxJ5+sMBvKxYJs/4yb+s
 ZOvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlUjxqqIHb2mdHvENXxVfPE+WGn53h4Fo40R3sbs/ei/95I3KduLxCrG2LumL9xHAEi6jubAEQS66+@nongnu.org
X-Gm-Message-State: AOJu0YwHQmhffUGT7j2Nu5bkfFEOs+RQSrP0ymKyditVpHG+9ctDHUMJ
 4unhjOYnUaw1aGoKcdaHePaDgC/E716cuSjaqRIhiQyLP9KkuqRr0czlJt3boJI=
X-Gm-Gg: ASbGncuyU/ncfBKPAACICrBpiGxLp3P6Ca/kBfPDdGq152us333J7M5Xa0FcQyc5p7F
 kOVvcn0Z0oi1gAB0fnwqzNmBz4W+xBaPJhxZEmki/n82dQLlHC2LXaYO7+uSKy9odDttf+3KOQD
 D7tFM2D+sBDwEQHjYZit5nIdltvJBLHSOoKDmrswGRjJhNrKz6w3h+a4uj9dgChGlXm/m7x/9F6
 hrY0uIoGgP7tEX6jr/otKMN7PyTvGdIXy90/f1XuWy37RyEQjGa6vgxnoPFiSydKxne/3bYpnqx
 F0b1jta0UWLyjthe3lZURgKlqK3nHoLHF29y5PwSjWQUOhkZmOp+/A==
X-Google-Smtp-Source: AGHT+IEDL3fpZ3bMhu8o9BqWhvd+qwyawroa8hJarNqo8muFh/1XQLkhva3PvCX0PsDbptaUHjwdUA==
X-Received: by 2002:a17:902:f644:b0:224:7a4:b31 with SMTP id
 d9443c01a7336-22c53e38f33mr14045095ad.6.1744944912557; 
 Thu, 17 Apr 2025 19:55:12 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bf398fsm7753635ad.66.2025.04.17.19.55.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 19:55:12 -0700 (PDT)
Message-ID: <94f61b71-495b-447e-830d-897d83e334a8@linaro.org>
Date: Thu, 17 Apr 2025 19:55:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 01/11] qapi: Rename TargetInfo structure as
 BinaryTargetInfo
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250418005059.4436-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

T24gNC8xNy8yNSAxNzo1MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFRo
ZSBRQVBJLWdlbmVyYXRlZCAnVGFyZ2V0SW5mbycgc3RydWN0dXJlIG5hbWUgaXMgb25seSB1
c2VkDQo+IGluIGEgc2luZ2xlIGZpbGUuIFdlIHdhbnQgdG8gaGVhdmlseSB1c2UgYW5vdGhl
ciBzdHJ1Y3R1cmUNCj4gc2ltaWxhcmx5IG5hbWVkLiBSZW5hbWUgdGhlIFFBUEkgb25lLCBz
aW5jZSBzdHJ1Y3R1cmUgbmFtZXMNCj4gYXJlIG5vdCBwYXJ0IG9mIHRoZSBwdWJsaWMgQVBJ
Lg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQGxpbmFyby5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgcWFwaS9tYWNoaW5lLmpzb24g
ICAgICAgICAgfCAxMiArKysrKystLS0tLS0NCj4gICBody9jb3JlL21hY2hpbmUtcW1wLWNt
ZHMuYyB8ICA0ICsrLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwg
OCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9xYXBpL21hY2hpbmUuanNvbiBi
L3FhcGkvbWFjaGluZS5qc29uDQo+IGluZGV4IGE2Yjg3OTViMDllLi4zMjQ2MjEyZjA0OCAx
MDA2NDQNCj4gLS0tIGEvcWFwaS9tYWNoaW5lLmpzb24NCj4gKysrIGIvcWFwaS9tYWNoaW5l
Lmpzb24NCj4gQEAgLTI3NSwxNSArMjc1LDE1IEBADQo+ICAgeyAnY29tbWFuZCc6ICdxdWVy
eS1jdXJyZW50LW1hY2hpbmUnLCAncmV0dXJucyc6ICdDdXJyZW50TWFjaGluZVBhcmFtcycg
fQ0KPiAgIA0KPiAgICMjDQo+IC0jIEBUYXJnZXRJbmZvOg0KPiArIyBAQmluYXJ5VGFyZ2V0
SW5mbzoNCj4gICAjDQo+IC0jIEluZm9ybWF0aW9uIGRlc2NyaWJpbmcgdGhlIFFFTVUgdGFy
Z2V0Lg0KPiArIyBJbmZvcm1hdGlvbiBkZXNjcmliaW5nIHRoZSBRRU1VIGJpbmFyeSB0YXJn
ZXQuDQo+ICAgIw0KPiAtIyBAYXJjaDogdGhlIHRhcmdldCBhcmNoaXRlY3R1cmUNCj4gKyMg
QGFyY2g6IHRoZSBiaW5hcnkgdGFyZ2V0IGFyY2hpdGVjdHVyZQ0KPiAgICMNCj4gICAjIFNp
bmNlOiAxLjINCj4gICAjIw0KPiAteyAnc3RydWN0JzogJ1RhcmdldEluZm8nLA0KPiAreyAn
c3RydWN0JzogJ0JpbmFyeVRhcmdldEluZm8nLA0KPiAgICAgJ2RhdGEnOiB7ICdhcmNoJzog
J1N5c0VtdVRhcmdldCcgfSB9DQo+ICAgDQo+ICAgIyMNCj4gQEAgLTI5MSwxMSArMjkxLDEx
IEBADQo+ICAgIw0KPiAgICMgUmV0dXJuIGluZm9ybWF0aW9uIGFib3V0IHRoZSB0YXJnZXQg
Zm9yIHRoaXMgUUVNVQ0KPiAgICMNCj4gLSMgUmV0dXJuczogVGFyZ2V0SW5mbw0KPiArIyBS
ZXR1cm5zOiBCaW5hcnlUYXJnZXRJbmZvDQo+ICAgIw0KPiAgICMgU2luY2U6IDEuMg0KPiAg
ICMjDQo+IC17ICdjb21tYW5kJzogJ3F1ZXJ5LXRhcmdldCcsICdyZXR1cm5zJzogJ1Rhcmdl
dEluZm8nIH0NCj4gK3sgJ2NvbW1hbmQnOiAncXVlcnktdGFyZ2V0JywgJ3JldHVybnMnOiAn
QmluYXJ5VGFyZ2V0SW5mbycgfQ0KPiAgIA0KPiAgICMjDQo+ICAgIyBAVXVpZEluZm86DQo+
IGRpZmYgLS1naXQgYS9ody9jb3JlL21hY2hpbmUtcW1wLWNtZHMuYyBiL2h3L2NvcmUvbWFj
aGluZS1xbXAtY21kcy5jDQo+IGluZGV4IDMxMzBjNWNkNDU2Li40MDg5OTRiNjdkNyAxMDA2
NDQNCj4gLS0tIGEvaHcvY29yZS9tYWNoaW5lLXFtcC1jbWRzLmMNCj4gKysrIGIvaHcvY29y
ZS9tYWNoaW5lLXFtcC1jbWRzLmMNCj4gQEAgLTEzMiw5ICsxMzIsOSBAQCBDdXJyZW50TWFj
aGluZVBhcmFtcyAqcW1wX3F1ZXJ5X2N1cnJlbnRfbWFjaGluZShFcnJvciAqKmVycnApDQo+
ICAgICAgIHJldHVybiBwYXJhbXM7DQo+ICAgfQ0KPiAgIA0KPiAtVGFyZ2V0SW5mbyAqcW1w
X3F1ZXJ5X3RhcmdldChFcnJvciAqKmVycnApDQo+ICtCaW5hcnlUYXJnZXRJbmZvICpxbXBf
cXVlcnlfdGFyZ2V0KEVycm9yICoqZXJycCkNCj4gICB7DQo+IC0gICAgVGFyZ2V0SW5mbyAq
aW5mbyA9IGdfbWFsbG9jMChzaXplb2YoKmluZm8pKTsNCj4gKyAgICBCaW5hcnlUYXJnZXRJ
bmZvICppbmZvID0gZ19tYWxsb2MwKHNpemVvZigqaW5mbykpOw0KPiAgIA0KPiAgICAgICBp
bmZvLT5hcmNoID0gcWFwaV9lbnVtX3BhcnNlKCZTeXNFbXVUYXJnZXRfbG9va3VwLCB0YXJn
ZXRfbmFtZSgpLCAtMSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAm
ZXJyb3JfYWJvcnQpOw0KDQpHb29kIGZvciBtZS4gSWYgYW55b25lIHdhbnRzIGFub3RoZXIg
bmFtZSB0aGFuIEJpbmFyeVRhcmdldEluZm8sIEknbSBvayANCndpdGggaXQuDQoNClJldmll
d2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+
DQoNCg==

