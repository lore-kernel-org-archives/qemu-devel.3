Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2DDCD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 19:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXkiy-0006Cx-5X; Thu, 11 Jun 2026 15:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXkiu-0006Cp-CB
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 15:05:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXkis-0006iB-3N
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 15:05:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490ac10e337so931925e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781204743; x=1781809543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PhmRuTmgByYt8ib2ciO7JS69kZuB14k/pcM9H6faXkM=;
 b=DEQ+IquKsfACa8Xeg4Lft5b3NAsjh/hflkzt5kjuA4M1bpSG3IgxigfNWbqhvXpQBd
 5GRnfqouLZc3CajeVNj/jrAr2Mb9vHD5pZz/WTkNzFkSryXO517G4vag6qppSMGWE7a4
 tK1H38/a92Jwyx+BECxbLRKTxn9pDG4hRZE9tCZuPy9dXEQdgYz++yvtMJkXmETxop5F
 n0h1XoAhjo/icSaOjo4N56JEV2KQUwFenH3Ya3ZLoEZ0g2BNc5+o4QpSlRubj6UDXZcD
 KR3c82yQJwcV7XD0ZcVfbt/XSSWKK+4iSKfHhhcC8DlDnqL6i1/ohfUAJd76+OnpFWg3
 MO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781204743; x=1781809543;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PhmRuTmgByYt8ib2ciO7JS69kZuB14k/pcM9H6faXkM=;
 b=bHwOR+SpKnLqKamTgqB9b5G4swqwYPomBpXTVH4mkJUfCGDas2yO+t6ZbmXu0WldzE
 CxJWtfOyFz7RUfZBF2hfFSGmvtpHtSW/UryggHMRPY/A0TTnfKtB3wvfzA7+QU6+RGN1
 qqOOyRjRGnUPsXzD8LaTBGKB7tom+PNqihR5d1haKmVLkSlpwngbdPg+usVITfDRzNUg
 3W/gKVR09zMBWPFnIzvqkGQGfhjZiuh9toqc4eWTaFA35kSFqL7ztSASmu+OAEJV3H5p
 LwktqQTRLaQGimbLahDnZE1q1CBm1kO2T21N+e8jXOYqjrBvZB3m0RNXCYhNtBXT/eiB
 LaKg==
X-Gm-Message-State: AOJu0YwEECoHwy0wVFJRPCkFfu3ZkIfa38/UoI9dV+zyqKUE5+WH+K9I
 uQwC4I+M7WovyuzsIKRZjERZ+qs4iFR/ueSWW/nw36+hF/PiKf4ZuZ0ezuRutcX3Q1M=
X-Gm-Gg: Acq92OHNCYizmeoXFGF25u5QWGnzN/zKnEEvfhBLs6r3A1Bufgti5lC8adVLxDomV3M
 uIAPBytfKTBw0q0DW/Ju8aBUr6Bakgdo2aBN2CYtFVmKsnMy1NGyCjLbqbIN7T0uda2I51MAtKy
 SfPsz3dZRhTVufrx0a4b9AuwlEK9HVTY14XNbxKdgJuBGItWQr4qUpDiuOznmkh1IaUH4qPzrxv
 riBJAPHkidmtsgfj7RIiGifq4yWAmUFHH3dHWhcDswlaAGqQCJ/MnZLSw4Y2abOD5NBnzfdlMol
 zs6SwrXWyR3ZclPx+GGLQ6jB3dpOhghZZi0jFfnz+T+5q/o35eNQhaJnyNhL3y5Z6VKEAP7L75Y
 yjl0q9Rd/I6TB1eqvDkBxbE+EW6qltGmdRRqJDN0/d+jb03afeCrA1kOqjkwnWTgkMSNU4W5kdR
 qwZLam3vjNqqm+VSN5ToFONgdyfhsX+0S9dw==
X-Received: by 2002:a05:600c:1d12:b0:490:b1b8:95f5 with SMTP id
 5b1f17b1804b1-490e55ef4cfmr54471405e9.15.1781204743333; 
 Thu, 11 Jun 2026 12:05:43 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4b39e9sm5744695e9.0.2026.06.11.12.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 12:05:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AF8F35F894;
 Thu, 11 Jun 2026 20:05:41 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <th.huth+qemu@posteo.eu>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH] tests/functional: allow pylint to introspect cv2
In-Reply-To: <544ac437-5dfd-4cf0-8332-16cf8bd56260@redhat.com> (Thomas Huth's
 message of "Thu, 11 Jun 2026 20:49:02 +0200")
References: <20260611162536.2184620-1-alex.bennee@linaro.org>
 <544ac437-5dfd-4cf0-8332-16cf8bd56260@redhat.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 11 Jun 2026 20:05:41 +0100
Message-ID: <874ij8ganu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> On 11/06/2026 18.25, Alex Benn=C3=A9e wrote:
>> To fix:
>>    qemu-test.test_pylint
>> "/home/alex/lsrc/qemu.git/tests/functional/arm/test_integratorcp.py:83:
>> I1101: Module 'cv2' has no 'imread' member, but source is
>> unavailable. Consider adding this module to extension-pkg-allow-list
>> if you want to perform analysis based on run-time introspection of
>> living objects. (c-extension-no-member)"
>
> Which pylint version are you using? I don't get this with my pylint
> here (version 4.0.4)...

  dpkg --status pylint
  Package: pylint
  Status: install ok installed
  Priority: optional
  Section: python
  Installed-Size: 2073
  Maintainer: Debian Python Team <team+python@tracker.debian.org>
  Architecture: all
  Version: 3.3.4-1

>
>  Thomas
>
>
>> Manually running python3 showed I could indeed import cv2 and call
>> those functions.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   tests/functional/pylintrc | 2 ++
>>   1 file changed, 2 insertions(+)
>> diff --git a/tests/functional/pylintrc b/tests/functional/pylintrc
>> index 049c3e76f12..c4c5237aa9d 100644
>> --- a/tests/functional/pylintrc
>> +++ b/tests/functional/pylintrc
>> @@ -82,3 +82,5 @@ disable=3Dbad-inline-option,
>>     # Minimum lines number of a similarity.
>>   min-similarity-lines=3D20
>> +
>> +extension-pkg-allow-list =3D cv2

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

