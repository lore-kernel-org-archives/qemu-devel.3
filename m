Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AF1C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 22:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzNCq-0005gy-Fp; Mon, 31 Mar 2025 18:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzNCm-0005gM-5N
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:02:04 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzNCk-0005rw-7i
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 18:02:03 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22438c356c8so96499895ad.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 15:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743458519; x=1744063319; darn=nongnu.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObOU9+2Qfd+VGFItlr3XNvdxI3agI0rtlpDObypUsp4=;
 b=XZprONVw66LJho1GnTJrOmdpmJL1TURL3ZIB4TRURUqpj6URZY1enumGQRytRyPJV9
 IipKPXkt2lURRTp8sKIqnu5fWlfN1mbTXAcwzKB3QIv1bCOwbc/PDqGaowBaHIaiBMFw
 s6nDWlsvwo0IPCq3B437jUN4M/LepToqZ8V7H5A2sRcRs1POgH1pwLGUDV3yLuGT6d/6
 Veq8/pIPkC1qp/mXHKWnhOCjtfCgpJwOTxKHTKBnGq/+F0vT2EWUrPRKWB2aZnFpyO5N
 hrU/2BEnQ8LXxLcWb8XGOTGJcSZSUU0BEPnRrWknyao8qBb2UcrIZU0ja/S9de1Sh+ql
 NnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743458519; x=1744063319;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ObOU9+2Qfd+VGFItlr3XNvdxI3agI0rtlpDObypUsp4=;
 b=WgyDBns07VF0SrPMNzWFSJyOXuUxvyxX0PmsEcZXlvwbKXjxmtAmqljDkfYvRS/b+l
 cOEXC8mtxnscKltA/GjFPA4V0IvnIhbJUITAqvQ3kzvngbO9m2H4gipvzwE0GEvP+NVc
 ch4T4vmxkvEFRsEP/ykIxVhgzw+H+axoBD0daVt+5P8UIALAb44Fgn7Ewg3nQSKHHLJO
 MkSx53LmYsqE/qxl5L335FIVf+eHsIs2EEpwQD8jX9SzBoljapQ7wshl6FFhSVUqv197
 geqhhBYjBZ475Wud2qMAft5YITgaIr1zG1rXPl0gjO2y5qc6siJC6H0mZE3qyrZFoMzt
 /YCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPhSfNJQA6EdxH1ywkm5lnHdBWv1LQQEpurdCdcNHOML79ImOOhl0U5T6OgPvLwYvBsY8WGqCXzRDD@nongnu.org
X-Gm-Message-State: AOJu0YzxmQayf87E5VPgLMdj82z2t34YmH1PECVUl9j3EoRGnOoUa2c5
 OiBKqmIVbGaAfQI+V+zrSZ70oW5e+5uG8z2ZoykwV7CiWChy8gqSV9ZF61pMuOw=
X-Gm-Gg: ASbGncvSo+YmHDYDxrKdpiGSCid5vAhxWyWSe/auMRpyDjdtkM9Fq2Yk1ynmk0g5bk+
 ksAXMXrZebsM2JzjvnTkX802b3DjICyn7jxukxAZUocmbb4BksguWRESgucluzyP3ubZqVXYtXq
 yv2rVSrSe8/WgQOyV80KeIByXqCihGsYI5boqrZZ5bCDkvn5WKHTozsgebyezVB1cVDsAvDhHd6
 rzTWDn/pZJzxRrTBe5wfvuIiJ/2FMiSyd0WxcXbz3fivr1QqlvvbxE7K30cUjNBR8ICyXXk83Lk
 GiDf++fGsbxmuw5pxkWtzgEcn3YTUQioFUE3tEqGRPl0ihSlfUJyMEE8Ew==
X-Google-Smtp-Source: AGHT+IFSl/qLSYeHnMGiEEyLgyBOKWXcB9KDFSDVch4oZDBp2m4/PpHRJWLy/IAjmN7BcDqGsMOFtA==
X-Received: by 2002:a17:902:ce12:b0:224:1294:1d26 with SMTP id
 d9443c01a7336-2292f95d890mr142274055ad.13.1743458519548; 
 Mon, 31 Mar 2025 15:01:59 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1cf860sm74440175ad.115.2025.03.31.15.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 15:01:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------H8DCrAhXvCPSwEspNEAVWP6t"
Message-ID: <7b447357-4db1-4fe9-b183-51d8eb24afc2@linaro.org>
Date: Mon, 31 Mar 2025 15:01:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/42] semihosting: Move user-only implementation
 out-of-line
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-27-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250318213209.2579218-27-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

This is a multi-part message in MIME format.
--------------H8DCrAhXvCPSwEspNEAVWP6t
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/25 14:31, Richard Henderson wrote:
> Avoid testing CONFIG_USER_ONLY in semihost.h.
> The only function that's required is semihosting_enabled.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

This breaks bsd-user,

CONFIG_SEMIHOSTING is not defined in configs/targets/*bsd-user*, thus
the user stub is not included.
Since in user mode we always return true, we can simply add the stub
inconditionnally for all the user binaries.

See here for details and a patch fixing it [1] (also attached to this 
email).

[1] 
https://github.com/pbo-linaro/qemu/commit/d105112e11e521ff82b328be5f8fdc2af38aa75b

Regards,
Pierrick
--------------H8DCrAhXvCPSwEspNEAVWP6t
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-FIX-semihosting-always-include-user-definition-for-s.patch"
Content-Disposition: attachment;
 filename*0="0001-FIX-semihosting-always-include-user-definition-for-s.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkMTA1MTEyZTExZTUyMWZmODJiMzI4YmU1ZjhmZGMyYWYzOGFhNzViIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQGxpbmFyby5vcmc+CkRhdGU6IE1vbiwgMzEgTWFyIDIwMjUgMTQ6Mzk6MzAgLTA3MDAK
U3ViamVjdDogW1BBVENIXSBGSVggc2VtaWhvc3Rpbmc6IGFsd2F5cyBpbmNsdWRlIHVzZXIg
ZGVmaW5pdGlvbiBmb3IKIHNlbWlob3N0aW5nX2VuYWJsZWQKCkNPTkZJR19TRU1JSE9TVElO
RyBpcyBub3QgZGVmaW5lZCBpbiBjb25maWdzL3RhcmdldHMvKmJzZC11c2VyKiwgdGh1cwp0
aGUgdXNlciBzdHViIGlzIG5vdCBpbmNsdWRlZC4KU2luY2UgaW4gdXNlciBtb2RlIHdlIGFs
d2F5cyByZXR1cm4gdHJ1ZSwgd2UgY2FuIHNpbXBseSBhZGQgdGhlIHN0dWIKaW5jb25kaXRp
b25uYWxseSBmb3IgYWxsIHRoZSB1c2VyIGJpbmFyaWVzLgoKbGQ6IGVycm9yOiB1bmRlZmlu
ZWQgc3ltYm9sOiBzZW1paG9zdGluZ19lbmFibGVkCj4+PiByZWZlcmVuY2VkIGJ5IHRyYW5z
bGF0ZS1hNjQuYzoyODU1Cj4+PiBsaWJxZW11LWFhcmNoNjQtYnNkLXVzZXIuYS5wL3Rhcmdl
dF9hcm1fdGNnX3RyYW5zbGF0ZS1hNjQuYy5vCj4+PiByZWZlcmVuY2VkIGJ5IHRyYW5zbGF0
ZS5jOjExMzgKPj4+IGxpYnFlbXUtYWFyY2g2NC1ic2QtdXNlci5hLnAvdGFyZ2V0X2FybV90
Y2dfdHJhbnNsYXRlLmMubwo+Pj4gcmVmZXJlbmNlZCBieSB0cmFuc2xhdGUuYzo0ODE0Cj4+
PiBsaWJxZW11LWFhcmNoNjQtYnNkLXVzZXIuYS5wL3RhcmdldF9hcm1fdGNnX3RyYW5zbGF0
ZS5jLm8KClNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZp
ZXJAbGluYXJvLm9yZz4KLS0tCiBzZW1paG9zdGluZy9tZXNvbi5idWlsZCB8IDIgKy0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL3NlbWlob3N0aW5nL21lc29uLmJ1aWxkIGIvc2VtaWhvc3RpbmcvbWVzb24uYnVpbGQK
aW5kZXggYWI2N2Y4N2U0ZjAuLjFmNWNmYjNiYTcyIDEwMDY0NAotLS0gYS9zZW1paG9zdGlu
Zy9tZXNvbi5idWlsZAorKysgYi9zZW1paG9zdGluZy9tZXNvbi5idWlsZApAQCAtMTUsNyAr
MTUsNyBAQCBzeXN0ZW1fc3MuYWRkKHdoZW46IFsnQ09ORklHX1NFTUlIT1NUSU5HJ10sIGlm
X3RydWU6IGZpbGVzKAogICAnc3R1YnMtc3lzdGVtLmMnLAogKSkKIAotdXNlcl9zcy5hZGQo
d2hlbjogJ0NPTkZJR19TRU1JSE9TVElORycsIGlmX3RydWU6IGZpbGVzKCd1c2VyLmMnKSkK
K3VzZXJfc3MuYWRkKGZpbGVzKCd1c2VyLmMnKSkKIAogc3BlY2lmaWNfc3MuYWRkKHdoZW46
IFsnQ09ORklHX0FSTV9DT01QQVRJQkxFX1NFTUlIT1NUSU5HJ10sCiAJCWlmX3RydWU6IGZp
bGVzKCdhcm0tY29tcGF0LXNlbWkuYycpKQotLSAKMi4zOS41Cgo=

--------------H8DCrAhXvCPSwEspNEAVWP6t--

