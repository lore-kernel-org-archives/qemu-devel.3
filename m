Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B5FCCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeHj-0007a7-I9; Wed, 22 Oct 2025 15:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBeHi-0007Zv-Cn
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:14:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBeHg-0008Aj-CE
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:14:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-475c696ab23so5101385e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761160446; x=1761765246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+HS8Mhh/cr9afQnPBk78QmksTDKpr0KuuhUDODWSRaU=;
 b=SFiEk9rAn7BfUiEukIKazXgq/PExXNnLC9vLVqkpiZWhArVdpsHwxTresmheMgUPA6
 VlnYJ8pWKim8m9yzut2kBNfZdLNqF0VokRTflGNsCEeUF0C3EvRHabN/skbvTgOmzC7i
 JiN0mDbcZ3SMaw9YU4RZEzYZKGTtSC+rfWcDN6/N76Idai4r0/QoZOpRvVB+GmKJGLsG
 UqiZTYd17CBArTtR5Dbd/OY8falb8UTjMkWst/cFlkGeodH6/iB+PB/C676aYybhNd5z
 BW3KJ89pQchKRwa2OusQAM9q/T2xI4rE7lJ0QFxRkhmLgmpKVIiG2WaCKs97yuvlhDdA
 139g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761160446; x=1761765246;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+HS8Mhh/cr9afQnPBk78QmksTDKpr0KuuhUDODWSRaU=;
 b=LA+Q/v54vnNj7ZNaIO/Jyd9V354ZgFD6kcdBKHj0wH+KGtxSFP2H6i3KVtRVDgGeE2
 q6rN0WSJgi40bRVBB0rJgqMOAq/JZlaNdsh5jXll7fya3yvsQEj7+J+DBKG2g9pxymP2
 u6qDzc3mtZVSdH5qoJU734nu298oSOexwrri3p/+7RK2KHiLfKkvbvV9M9rach1olF6s
 6jCfw6rs60lxq3WjL9aO0gKC85b/KT5XkZjSY7EvBuA4velLQtR2bZc4wm/XRCOq1WLJ
 cOrLRmc5fxk4cDKr/W39hUwgOyqSj0rICJR78wP5upDQzHeWGnC5naCSkuy70628ZIDn
 Zv+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrZ3OGZ3TsrpgzGZhTHZ9+X8p/xZXTmJhJW6b49pEhWw4j70NpSjx+sg4sff8by/7Tx4hyxvwPMnJu@nongnu.org
X-Gm-Message-State: AOJu0YxKkiTsTugT7voekEc6aHnJ4oN2SNDjXZpCNv6AejWWnId6mr22
 JtU72WN96FbftMsY4pspPCNTbnWQdIvTTJ7gGRSXcyZl2XPAzdR/P4KPH7IOn/vhmUU=
X-Gm-Gg: ASbGncuuY8UGnrirZwQhJ6WI97iFusijn4DA6pNGAzGdHqNmE2Q5yuadppNTjQkx7lw
 XzmbT2FPUXcsA2k4HVFP57pVpgH+My192Z3MjgV2GqnTo/v3ipuA6Y1fYTqjlsmA7EO1a/+C15t
 9AVKxDa4f4h1vwqheRZOFlW0BQEVRqonI7tjHtT6pfCb9DuR0oj5VDXPoI6gcxUYQQC4ZPd0zgD
 B6RmYqqLbV8FA24gRfU5IT/N2yilZgueaYwX/DNi7soDA+nkFpKqyG5g8CoRFvq7o24HKyNT9OX
 M2MgOWwOsVG8OGl5ZFFa8vCFk8AYdiLMEJkUrmhTicML/jlb6xPGUb9SplHWwvNF8cPy5x+iysE
 DkJUUhz10hGUNF/MZAKqAOXvoj4RZFdHKF6tiGsbu1etcGQ9kO6xeeDpy3kn6KezqVYvr+6V+Rf
 y40/G4j4XsYlKG9twFTVNPe+a4pF72ovLMM7peI9TyvcSTPPt/O63qFw==
X-Google-Smtp-Source: AGHT+IFddhvVyMjHfjWVDWh08sfU2sT6WlWnYgavX7mKMg0bPo+G+aJuUaV0UzW8W/SBFKpMnvnuDg==
X-Received: by 2002:a05:600c:8509:b0:471:16e5:6d7a with SMTP id
 5b1f17b1804b1-4711787dca0mr120362265e9.13.1761160446326; 
 Wed, 22 Oct 2025 12:14:06 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427c3casm56709255e9.4.2025.10.22.12.14.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 12:14:05 -0700 (PDT)
Message-ID: <57dc76d3-2a2b-428b-a457-94dcd20cb427@linaro.org>
Date: Wed, 22 Oct 2025 21:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] tests/functional: Fix problems in linuxkerenl.py
 reported by pylint
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <20251015095454.1575318-1-thuth@redhat.com>
 <20251015095454.1575318-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251015095454.1575318-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Typo "linuxkernel" in subject.

On 15/10/25 11:54, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Use proper indentation and lazy logging here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/qemu_test/linuxkernel.py | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)


> @@ -48,5 +48,5 @@ def check_http_download(self, filename, hashsum, guestport=8080,
>                   hl.update(chunk)
>   
>           digest = hl.hexdigest()
> -        self.log.info(f'sha256sum of download is {digest}.')
> +        self.log.info('sha256sum of download is %s.', digest)
>           self.assertEqual(digest, hashsum)

TBH I don't understand why 'lazy logging' is better than f-strings.
I'd rather have an unified formatting style over our Python files.

https://pylint.readthedocs.io/en/latest/user_guide/messages/warning/logging-format-interpolation.html

   Another reasonable option is to use f-string. If you want to do
   that, you need to enable logging-format-interpolation and disable
   logging-fstring-interpolation.

What about this pylint option?


