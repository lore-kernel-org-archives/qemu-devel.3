Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CB5CD13D2
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vISxq-0000iE-9u; Mon, 10 Nov 2025 09:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vISwM-0008P9-QL
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:32:22 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vISwK-0004Ri-70
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:32:18 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4710022571cso30137335e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 06:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762785126; x=1763389926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Y/wsTBBdEgWWS9Bnmm64sNXRfHpjgDVlw3ALdx6hpk=;
 b=FLqrD+XhNW8lCU+Rr62+LaX0vF/R0yeuCXCA7wHcGgAr+m5tacczOFZTc2tSnWmL/j
 8+uEI+gjyjFH7UNHJxacWbXrgMVUhzZ/oeBGe7PsN0FrLu7AjENow659CFoNPNl5RCla
 qYGIzZ3fe0umNpqTO2u+eX2nSLH96Zh7SmWOlxAt+wJwK+rEChxeimXEvg2S3IOSLpGj
 me+falGHKTrYUh75+UC6KSO1vKtIujiHmOCaBVID5l13Zj4QF1PGmpfTSo+4befjYve5
 wSY7zBHBBlbPIoB96drL7SpBY/p+iHUsg6JhZCZgL+N8/eqDkeDH4f4BHMuiscYpyKcy
 vJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762785126; x=1763389926;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Y/wsTBBdEgWWS9Bnmm64sNXRfHpjgDVlw3ALdx6hpk=;
 b=AAfhdM5JL9j7vhljWyqu/twYsMqX13VcwC7uzkKXq6Rn8zP2n5ShsCt4RBlyVaxFk+
 FswKDugnw/1xjg+19QLp1GngR/xxvfj+4N1obFwZQQFnQWR2By3Sxq+EpEUSkz3mDvak
 AT9ziKsEdShXQzc3kLhm8cft4SezdnirUDOAtltKndpYvAjCQpkyKb7zyve5ddQnZqTj
 UQEOcvBjIWIDNCVRoitEE3hYlZ199yxJuh7cwhvBANH8VlGETvMpodb/+2pUwKf3rTCj
 OFtsfHeEaoey1p50pDExt9JINqAUYS7FWid45r4nzp3wleHmlwwgZxSirlyDEOy/YAng
 IQ6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiO8YDFfA1+V8ZolyP0HedfJJVXatXGDr1APi5dQO5VKq4zdPg6urwrlWyZyxriyArXZY0m6W2jEQG@nongnu.org
X-Gm-Message-State: AOJu0Yzt4VZ0FAeWcEBd9DvDLrqxWK/U46A2NVWGcmpAQR4ZI9IMCW6u
 xm/joK4nehXvrKMytXFVHgCtxxYgwW7xYbGBxExWLDoYVvt8uSrW4xE9R3atwry9Fs/Efml1GUu
 qCkNBDz4=
X-Gm-Gg: ASbGncs53hw/fmqVCuC6r6sIaBx6mIJHFCZ5e9hzYXQBSiPn+TertU8QkzTCdRYEidh
 xn2bY2He5FX24WyGen4Q+Uh1J1B3+WdVjTtDepxF/pJtbQGUNsy2qgPZZv9L08CLOP9PkuEmljM
 AZbJQleG1dc9nZVOgoWFaV6PoCsAcB9NUI/V0X12fxiUJkdbmY5kg01RzggzAkwJKl2jckhu8E/
 jizMjY3nvn51yFvUuzLA4U16zyJUtCYBJLpyokNJBS4bQYnTiUsTgPXv48vQIdBXOdj82od/wkI
 aWy8lMssjWVCFROcrj6zu6cRyB3ieTdwIQ43nxbfqdHcNYSV1iXPWux2CcqqcqNbPeNLg0c4rjH
 o/bNuYoSUZ3Q9IQzkrmEM2gahm39e3schTTWb0ld8DweoN1/8dRTIXU1H+uLPELeqS8hsZDfbuj
 W6jIZBnORplsWhDNVvmhSYubJcHpYn
X-Google-Smtp-Source: AGHT+IEpcan9/X28kd02ktdJvT/ckNUhYBQGRW8EM0nFIwtvc1+s/kzoMLXlX2iUqOl9sIPRL/t1WQ==
X-Received: by 2002:a05:600c:4f8b:b0:477:569c:34e9 with SMTP id
 5b1f17b1804b1-47773271a62mr86608715e9.23.1762785125560; 
 Mon, 10 Nov 2025 06:32:05 -0800 (PST)
Received: from [192.168.50.95] ([206.204.154.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775ce211d8sm337505925e9.11.2025.11.10.06.32.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 06:32:05 -0800 (PST)
Message-ID: <77a5ae39-cf37-4981-9547-d65785c15866@linaro.org>
Date: Mon, 10 Nov 2025 15:32:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] Lasi fixes patches
To: deller@kernel.org, qemu-devel@nongnu.org
References: <20251109220654.46718-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251109220654.46718-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

On 11/9/25 23:06, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> The following changes since commit 917ac07f9aef579b9538a81d45f45850aba42906:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2025-11-05 16:07:18 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/lasi-fixes-pull-request
> 
> for you to fetch changes up to 8c1fa9cbecba50ae7e732923ee567fe40551d1a6:
> 
>    target/hppa: Update SeaBIOS-hppa to version 20 (2025-11-09 22:47:31 +0100)
> 
> ----------------------------------------------------------------
> hppa lasi bugfixes pull request
> 
> Please pull a bunch of fixes which repair issues introduced due to the previous
> patch series which added LASI SCSI and LASI network card support as  well as
> the new 715 machines.
> This includes fixes for reported coverty issues, and repairs the B160L machine
> emulation.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

