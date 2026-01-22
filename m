Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF56D6CFA1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 18:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viz7H-000818-Fq; Thu, 22 Jan 2026 13:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1viz7F-00080C-WC
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 13:09:10 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1viz7E-0003FM-Cq
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 13:09:09 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so11399645e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 10:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769105347; x=1769710147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SyjlxxNBFLSr45ZnDAu4wyegtPNWUVAW01YnKBsvvhE=;
 b=lyGMD6NVm+BKUd8wqtEjVls6fpaN7rqrVTxBgkg6psXrV0qu/OSalgLuXACQ0p4Kmr
 i4zyr/5ebADOHY2x2gPVkXd7zhKv5isadx5spwPaQuKdeQeJG1V67OYcRiYy+sxlbjnn
 z3Q9d2Sq0kkIoR02yo0iiiVWEjrbggAk5AZla9GBjB+QJ46wJ3FCkvm9K5rGMpZmq4Pu
 S3CgxOwX35kUuJMDcUOoypu0KI40cVR9fXNxpL6XVIVVy67GFEP+WN3QUh9dxWyoMNZA
 3aj7Zn1z6JxR8X/8fKcDEGOV2htFJerK2Mb4e89Uv+ttM11ptPNz16ihfBB+BHR2Dn+Z
 iKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769105347; x=1769710147;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SyjlxxNBFLSr45ZnDAu4wyegtPNWUVAW01YnKBsvvhE=;
 b=rksyOcSC6uapOWzrfETA6AqZrwiUy0Ifnezm02CGTM505lYUBGHH/L9mV11TQQeY7r
 Je6jlLgsdySJ9qO36d3lb8q4knQtQssmKCcgs+NsTXm2bpAXn018UsRKZGaFn5uoFqoR
 5frMgf8x8R/rL0CEF2OypVeOJcHD86HAJMWQFJHeQ7BCnUIM61JP+jILWprqPZ8prreb
 VUCAkJlO4oYoZ0F/OI1D25gkFhcaFGmrR+Ar7nKE9oglzs7lnvEdVLsU/a3+QIFHwCOu
 BwFmYW/usG4WI5QcuWHpZrMvlA46WfP1wzdijJsHgGHsK39MtJ3LB05ufaaMR28tSS1A
 VW4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtZGgKoeqayxKXuntQl0IwYuq1PPoU9GnQvsvslNGzFsLFU2X+GKXKAZPF54ACgQhNRal9rTA3I5j+@nongnu.org
X-Gm-Message-State: AOJu0YyMqk7fhHAP0nZxkYfX9D+rq1wMrwbumyh/lA35dauezI0kqn8c
 bS/oQAE4K2zoeYv9en4i4HK+VXBx8JF8+ILulkTJgvEr9hUTdodJTNXpTLDbBWiZFRo=
X-Gm-Gg: AZuq6aLCXmEvFoLua//nAPL7l3yPwLDnobbXAZEmDcJ9EfSREjmlLk/0Jn5Ko10COo4
 lFXmTimZq3Joce6aFJbIDbCmPQT8cpeP2CXtzBEDSzHSOmcARsshqqb9CgyKxuMVDKT398ZRVJH
 p5Eei1Q3pbgXLoPijnWYJAsc4j7fvgE7AjOmrzY3CNtzbGlNqlLv44IhLvNYX2qH294dWjotqjY
 eMK90mYCYkGQZ/hykBrwzuxOnBWzfsm0Le/8q/3fkVbOmIfDn63LM247UK+NWdq9c9Bc/sso2+p
 MucQD6pHGa9Cz+qCIBR4kKy0Kg8j9QakljaudfqD3eveBb7WgWcXV1KShp54iXSbb8iBWjZIiVt
 lWAkgxZ0RAABppRtLd4ic1zr34UPIVR8K5ziWfHIkBk9en5Kiq/YWFtzZqj7kxW+uoCmrvtx/iT
 skVfssAtxG2M7Y
X-Received: by 2002:a05:600c:3e15:b0:47d:885d:d2ff with SMTP id
 5b1f17b1804b1-4804c9bff75mr8213805e9.29.1769105346560; 
 Thu, 22 Jan 2026 10:09:06 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470cc278sm78933085e9.12.2026.01.22.10.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 10:09:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C27F25F7C3;
 Thu, 22 Jan 2026 18:09:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  David Hildenbrand <david@kernel.org>,
 qemu-s390x@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] tests/tcg/s390x: Test DIVIDE TO INTEGER
In-Reply-To: <c29ba170-d046-48b1-8cda-f0e4ada4f276@linux.ibm.com> (Ilya
 Leoshkevich's message of "Thu, 22 Jan 2026 17:59:06 +0100")
References: <20260121222116.713325-1-iii@linux.ibm.com>
 <20260121222116.713325-4-iii@linux.ibm.com>
 <87jyx9mwcn.fsf@draig.linaro.org>
 <c29ba170-d046-48b1-8cda-f0e4ada4f276@linux.ibm.com>
User-Agent: mu4e 1.12.15; emacs 30.1
Date: Thu, 22 Jan 2026 18:09:04 +0000
Message-ID: <87ecnhmse7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> On 1/22/26 17:43, Alex Benn=C3=A9e wrote:
>> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>>
>>> Add a test to prevent regressions. Data is generated using a
>>> libFuzzer-based fuzzer and hopefully covers all the important corner
>>> cases.
>>>
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>>   tests/tcg/s390x/Makefile.target     |   3 +
>>>   tests/tcg/s390x/divide-to-integer.c | 215 ++++++++++++++++++++++++++++
>>>   2 files changed, 218 insertions(+)
>>>   create mode 100644 tests/tcg/s390x/divide-to-integer.c
>>>
>>> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile=
.target
>>> index da5fe71a407..d5ec01d04fd 100644
>>> --- a/tests/tcg/s390x/Makefile.target
>>> +++ b/tests/tcg/s390x/Makefile.target
>>> @@ -49,14 +49,17 @@ TESTS+=3Dcvd
>>>   TESTS+=3Dcvb
>>>   TESTS+=3Dts
>>>   TESTS+=3Dex-smc
>>> +TESTS+=3Ddivide-to-integer
>>>     cdsg: CFLAGS+=3D-pthread
>>>   cdsg: LDFLAGS+=3D-pthread
>>>     rxsbg: CFLAGS+=3D-O2
>>> +divide-to-integer: CFLAGS+=3D-O2
>> As we generally compile -O0 to make life easier for people debugging
>> behaviour via gdbstub could we have an explanation of why -O2 is needed
>> here? Is it the same reason as rxsbg?
>>
>> <snip>
>
> Yes, this is because inlining is mandatory for the mask argument, and
> -O0 does not honor always_inline.

Could we add a comment to that effect in the Makefile. Otherwise looks
fine to me:

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

