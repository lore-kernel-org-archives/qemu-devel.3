Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D8BE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 20:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSMfc-0004za-U9; Mon, 30 Dec 2024 15:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSMfa-0004zN-Co
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 15:47:22 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSMfY-0001tW-JK
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 15:47:22 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43635796b48so58062725e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 12:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735591638; x=1736196438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=snkrafQsWQMaAuKwEfiu0dZU6b8hZ+pshhmdbEumino=;
 b=bXSWhCvsgM8oPrKT+QE8shxVetpMpySXI+QEkACFKiRkxZpezuXBLG1V/C13297Xi7
 1YZPDrUJhTsqvKjtO+8j/hBbJr+Yo7tANWH0uCBy110objY67G02DhuSdPso/MzvVEVd
 pqSZjU7x35Wt8Aocuu7aCjbVzgWhIwQnBBuoZNbE4goehnswaE0lUOxHFVXJx7lZ0RZK
 Ujn8hmoZW7XMNc6Qno39Nwykod4YcrTqXy9MjUbZ9h7Dj3Kn4F3aSlHSci4Ax0IRIuRY
 zAwqJ1qYyVYai45++tL2FttvjQ/NnqhfZHEHk35l5woo7NW+H1hD+0f24650UIr0kcRY
 WdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735591638; x=1736196438;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=snkrafQsWQMaAuKwEfiu0dZU6b8hZ+pshhmdbEumino=;
 b=Oz1pwUv8gm6V6OzvDriwkriOCB6AhzZ+Em6MdLfk/Zxr3JYTJR9SWQjQn1aD8R/o6M
 sn6614w4et8BHHKnNu4a9WfSHBXAoK2gb6LrAhRmYPyjoWSu7Wt0VCK6sfA6AjCSO66W
 L4wGWrGvyLUZ8Vxf7rG3uSqyITZodKUZvREGKyKK/4ZauYVfC22Ny7ug97HC94sfQ0wr
 a12cboiHEhiN/G5SfxKeiSMob+3y8CKTkNaAQA1DutqLtc+3xI5BZyU+gUYVHp4bYpv1
 F3ndI1+2qHTH5DW44snyPyapTG7Yy+/KgWiwZ4+DWtjURcJYYGwk3MwHMkVdcyhdNg13
 XmWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx/v8wWflsZXOj+3LFxc6Yi0gxbDf2ZFCJY7w9QxLOhWFbSMsQcr9S8zIv2Vw/DM4+u/migv3HVgP8@nongnu.org
X-Gm-Message-State: AOJu0YwNAXnuj5BflGhriciSh7wX+snmiJ4pnV/86h3mVtleKqkuXENr
 Uy9SUu585CAX35dgzXCIhfzge199OcLmG9WpBZp7Zr4AfywDNixRoC2bRZBqUnUg74qpS164l+8
 N
X-Gm-Gg: ASbGncupC51CmWBc/eEM22kAMUGAdwS0kR4j3360c106WMs434SXFWWSpqQDD26Vr7y
 fxpSrKck8acgPmtXVYFJ+ZHHyyHze5w0Tgl/QCW7Jis13C0lALhsjTOP9HfS8cMAccTh+GwjNvP
 Vo9IDu/EkwHzAxjwU1e7VZy2aA/Q/+HRuEAGrB057SVNIhNUSu1ahqF+zUJXA8HHO+hIoqIqBo8
 Udw7TmQPeqm/M+yEWqzcE5S/JJ/T/LvmLvfjiKRpYfMf7nan00YmloTgn8vLwuqkp9o82FaLJYQ
 W77oVFxsnx2ntAQGpAlUINUN
X-Google-Smtp-Source: AGHT+IFqrRQxKG1wIzrLFok3u1x6qXClvXemY26WSkiJkKELKpeOILjKCQUMh1wGB0TQfpzG1DfBUQ==
X-Received: by 2002:a05:600c:746:b0:436:185f:dfae with SMTP id
 5b1f17b1804b1-4365c770940mr351628165e9.6.1735591638322; 
 Mon, 30 Dec 2024 12:47:18 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c829015sm30955642f8f.13.2024.12.30.12.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 12:47:17 -0800 (PST)
Message-ID: <6db51529-4754-49dc-8af5-2b40019ed30e@linaro.org>
Date: Mon, 30 Dec 2024 21:47:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] hppa CPU reset and speedup
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241230152519.86291-1-philmd@linaro.org>
 <32a4d72c-6cc2-4c33-876d-ddf66b71fab4@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <32a4d72c-6cc2-4c33-876d-ddf66b71fab4@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 30/12/24 21:24, Helge Deller wrote:
> Hi Philippe,
> 
> On 12/30/24 16:25, Philippe Mathieu-Daudé wrote:
>> Respin of:
>> https://lore.kernel.org/qemu-devel/20241229234154.32250-1- 
>> deller@kernel.org/
>> "Add CPU reset function and speed up runtime and translation."
>>
>> - Remove hppa_cpu_init()
> 
> Thanks for picking up my patches and integrating them properly
> with the reset code.


>> - Reset PSW using M bit (untested)
> 
> We haven't implemented PSW-M support and the first
> thing the firmware does is to reprogram PSW.
> So, basically it's not needed.

Good to know it isn't needed yet (I grepped and noticed
very few uses). Are you OK with the patch as is (as it
matches the spec)?

