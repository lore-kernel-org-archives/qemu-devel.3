Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB4ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 13:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGdlX-00049D-D0; Wed, 05 Nov 2025 08:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGdlV-00046t-CQ
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 08:41:33 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGdlT-0001Wi-Iw
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 08:41:33 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-640c1fda178so5139679a12.1
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 05:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762350089; x=1762954889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/t4QrW/FFpcbQ+jUgW9Lup50X2QqdxT2HneJHiSeyJw=;
 b=bUqrIdl8kV06+tXMEJPGzZZzzOB/QRKWVvH63ry7SmHFuZv3IOls5PrMrp4KUUyyri
 kcqlfLomV0fuDnZScu1lYx4XvU8tNB11bibgsFYyx6khXZdqJOx+4i4ijxvvfBwTUeQz
 hXYFe0wJl0i4zXpsjY4PIq6Ju+34o9hcWZrGjxmYS+ovqrzVE7E7Xlt/sNMItAAN+Om+
 +CGDcZJ2pzQVs5tqbKlsm1DErs8w+gx9JYYOjMlUwIDbSDXqKAlTZk2eDS0jhCixSuaN
 wk3/S3yrbB3CgTiykOVQ+OrxjWkjm9486ST0vyExfv0r1uGTzJ4DHSg69S9LFKCMj52f
 HRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762350089; x=1762954889;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/t4QrW/FFpcbQ+jUgW9Lup50X2QqdxT2HneJHiSeyJw=;
 b=vMuAbwSjwvD0a6e4IZF2S0sT82VNO+b4mgxfO95Rf8bDYIQZ99T9LH4mSOY2C9FAYo
 8XGiGgzcIoTj59f7+3Y+vXyRXtmLuBLF4vOHAiUyl0D4lL/JCmHqXbbbKgPUwiGAvPLY
 qrY6jfH0SFUA7jnbjQx2jwBdY9kjaAn92Mk54p0yCuxxUXlBd+BFOEBVoBi3M9JGFlF0
 n1RDY+7X39HrFI55w4MnVX/Bkogpv8NwqPwp44Vqhi1TM96XlrHHKOysM3DYKMkvObnw
 jvZrs2YQSZZImI/CmFCDSdB1NF/dHejtk50zseT2ZTPQ641mwhOMPNfqshaxNuWdEEnl
 S6hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLZVAiSKJvESjP9R/61kIW7w4WxiIeFtXJiIS+Bm2EmeD7Pjmihn7l2UjzpUN3r+9ewqRM3rDpH5gr@nongnu.org
X-Gm-Message-State: AOJu0YxVA7jDPlQRsvvvuuRg3U3YUPJA8lF1CHQWLXzFJ5Sutf2NyUB6
 kcZllCKRZYk/hTsN5m6ANlk0LxF3cUVpvef4hvwJ7KlIBW2C5VggxD5+YHlFnhF89g0=
X-Gm-Gg: ASbGncvvCIFcZ4qw0Bd+Qz0qyZxNnb4MbQUWM7/Rf0n+rG4U+smJrPJGLDs8cS5ojyi
 4Ssaj2iDHfEDJRPhm8sS0Xn+kqnaKExg71aTF6DYmX9SSB7/AbVaABOk05sQG0feTkYsRKblg7x
 xdAG9srlQ3lWQYjkDXB81+rHc+5PW4vY7rpxOX+cFt8ETUWSY5jfiwNJqixeaLd8KU0qs4tmHVi
 VwkcT+DARRyhKzSv+fOGtWZZGSc+yE69rVXh7g0gc2bki/VP72JAN1cajsi3dhK8OWAcecgdxxV
 nBNXxYtBOyHnLp1cwnpA5XFmqB6rogrm5Oj0Q8jRXWlVkhmPEmLLjLGDK43zCfniCtlCxPFq6Se
 1eRDn3Jvs9yB07vgh+hLgjsLcb/RcsAj2QHxq7z5DCh0wq0lb192DWzS9BLTCRm0AzSE3NU/4qB
 NKBSbnnmnmCdqosFkn8N/tFPWKZyQ=
X-Google-Smtp-Source: AGHT+IEqqLkVpSnxrKhnHLYyPXKdClNeyVWhC4VerClL8lTJ9/l9R65RE4GHLpFKCz39ALUqBvWJjw==
X-Received: by 2002:a05:6402:254f:b0:640:ebca:e680 with SMTP id
 4fb4d7f45d1cf-64105ca691amr2562463a12.37.1762350089489; 
 Wed, 05 Nov 2025 05:41:29 -0800 (PST)
Received: from [172.20.148.100] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5ea78sm4670844a12.21.2025.11.05.05.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 05:41:28 -0800 (PST)
Message-ID: <dfa1aec7-3449-48bf-867d-14b9b2cfeddb@linaro.org>
Date: Wed, 5 Nov 2025 14:41:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/12] qapi: Add documentation format validation
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20251104132125.4134730-1-armbru@redhat.com>
 <20251104132125.4134730-13-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251104132125.4134730-13-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x533.google.com
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

On 11/4/25 14:21, Markus Armbruster wrote:
> @@ -423,12 +428,55 @@ def get_doc_line(self) -> Optional[str]:
>               if self.val != '##':
>                   raise QAPIParseError(
>                       self, "junk after '##' at end of documentation comment")
> +            self._literal_mode = False
>               return None
>           if self.val == '#':
>               return ''
>           if self.val[1] != ' ':
>               raise QAPIParseError(self, "missing space after #")
> -        return self.val[2:].rstrip()
> +
> +        line = self.val[2:].rstrip()
> +
> +        if re.match(r'(\.\. +qmp-example)? *::$', line):
> +            self._literal_mode = True
> +            self._literal_mode_indent = 0
> +        elif self._literal_mode and line:
> +            indent = re.match(r'^ *', line).end()

Another failure from my incomplete testing last night:

https://gitlab.com/qemu-project/qemu/-/jobs/11982687207#L127

../scripts/qapi/parser.py:444: error: Item "None" of "Optional[Match[str]]" has no 
attribute "end"  [union-attr]


r~

