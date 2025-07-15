Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F42C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubYm5-000755-7O; Tue, 15 Jul 2025 02:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubYm0-0006ye-6S
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:04:16 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubYlt-0001wO-2O
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:04:15 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45619d70c72so11130045e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752559447; x=1753164247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P+N4BnmQmB6HVtn40n6SJndcVTtdHUMS//UkU4VLWsk=;
 b=hRzO4gtIlX2XT11Oyv8i1KztmbqBhFrRR2YOOvuTsPrCkk1ZVykjMXSSxHxSUhwK6h
 fXvQ5LOTq+8aUUoJM0VhAfevX2ndvTtCoSqAkgxA2B2Mj6z8t6B2YymfFwo6pMstHJwe
 zeHz/fwAQXcPhzmZE8cl8LJ1c/eS76jWCR3ZsrVL9gFW2d7dt7NSStvs6TFhd+F9au3x
 Jes3pqv3YXCgAmal3msFrJ9nGapLpDGdGn/ik7RJzJQU8GOkZV4lqpMUr6JPSWyCUzZm
 zg80d8rDvXETnZkpaDMntfwn/iDQ8zb00LxgeDRScSAary++9zlCVvk00SsUn2w7h3/g
 YdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752559447; x=1753164247;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P+N4BnmQmB6HVtn40n6SJndcVTtdHUMS//UkU4VLWsk=;
 b=ZXm87aIozyMOKjE6Cqu6uB+FkH1TsOIwD4FhUgLzO7x9eZOWFV4DPRpSLmS4bLMd0W
 b/HT+DwX1vy4FypeO5kxwaBc6MZmy2j+8xZnEBvprRHV2BXBEG58knf+YiEexrIZiNnz
 XsGjpCLKIDl8W1pdHK6LLyeas8T69nMH+C3VC1q5iicbInP2neP7+Mu2c0VSIs67iIww
 nEHyG51EOvbmNRy+txgfqvFFS0Lu2AUPkKduDqZITWqnE/YKbMCq4xxrLSfb84LkFo5x
 Lso4a0OdkeiTgc/KFESkHtdB/IcajKpsldR+GqEtXmT+J+j9k0eAOExpWejVfLkgGqkd
 kOSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWFhl8pQuHX59M03R68lukNBPR1eoyyzZ/PW4sLWjBHSdKqjbmTpVuqfmjTO2ga26G2fkEBO0p846T@nongnu.org
X-Gm-Message-State: AOJu0YzJWb1tdGRULx+JNQubqJRRmnFhuhQEDlvI7soWN1TTeXEzL42C
 rkXkzOq/Dx9DSIWdQSFn09l5wcViYFqNZzLaTDsQMm3W+97e0Eip/VC4102BTasAyVs=
X-Gm-Gg: ASbGnctmAppyhx2D9Db31hSEQTi+q7ug4h/aOK0rm/5BaPlOy4GVEUTSMKK7THa7AqN
 2schebsvOB8je+iuasCtNIhbM5wfwqL6pHrGa9rsZcpwwRiAsEpH//KkG32eoTA1KCM7NeMipO3
 oD0SqBR9sQSI7SHU26wJQ9LQQfm7Xh8H8y1w4w3RV29va/qEWVjvpLvgQACG8a7eHxEWD7ZQV3q
 xjWhyvF0r8+HSnKo+0p+Zs/O8vYuB+Fg3SfR9eVFdfMI6cHY8NDDaZ8y3NpJBsm4Zjd5AYSqQXM
 0T6mUyowb1T0KEM7f34xQX/JmePolIeC9c5stGKBGaqrviQ9TjjWSwIZxamtQJw9HaRvIKhpALm
 jWfRNYZO9sGwVy/vzGobkB3RdsP9eYMtvzNZcjpYsgovQQCVhX7HGQdSsCiE6dolwG4m+fioVOz
 q/
X-Google-Smtp-Source: AGHT+IFDCV9Ro2tIFmblVGOmGgFe5G4VJBG2RdVfumYIGL8DqmODaygdpzR7XqvkffoLAixswIKIfg==
X-Received: by 2002:a05:6000:144a:b0:3a4:da0e:517a with SMTP id
 ffacd0b85a97d-3b60953f5b3mr1801579f8f.23.1752559447060; 
 Mon, 14 Jul 2025 23:04:07 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd537c6fsm153301885e9.21.2025.07.14.23.04.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 23:04:06 -0700 (PDT)
Message-ID: <ff576c36-4d9e-4564-999b-9db80083da42@linaro.org>
Date: Tue, 15 Jul 2025 08:04:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] roms: re-remove execute bit from hppa-firmware*
To: Cole Robinson <crobinso@redhat.com>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <52d0edfbb9b2f63a866f0065a721f3a95da6f8ba.1747590860.git.crobinso@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <52d0edfbb9b2f63a866f0065a721f3a95da6f8ba.1747590860.git.crobinso@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 18/5/25 19:54, Cole Robinson wrote:
> This was fixed in c9d77526bddba0803a1fa982fb59ec98057150f9 for
> 9.2.0 but regressed in db34be329162cf6b06192703065e6c1010dbe3c5 in
> 10.0.0
> 
> When the bit is present, rpmbuild complains about missing ELF build-id
> 
> Signed-off-by: Cole Robinson <crobinso@redhat.com>
> ---
>   pc-bios/hppa-firmware.img   | Bin
>   pc-bios/hppa-firmware64.img | Bin
>   2 files changed, 0 insertions(+), 0 deletions(-)
>   mode change 100755 => 100644 pc-bios/hppa-firmware.img
>   mode change 100755 => 100644 pc-bios/hppa-firmware64.img

If nobody objects, I'm taking this patch via my mips-next tree.

Thanks,

Phil.

