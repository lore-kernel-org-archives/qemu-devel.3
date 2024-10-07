Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2FACFB45D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 20:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxu01-0005qJ-NL; Mon, 07 Oct 2024 16:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxtzy-0005pt-Mu
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:06:31 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxtzt-0001Ee-VU
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:06:27 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20ba733b904so47555025ad.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728331584; x=1728936384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ShdNUjoISVvBaFZwW4KCPuVoTkTJEmjORNjns2u5W2Q=;
 b=fApRF7VxB/PxItDw1UV+7cX08uM9foZIJ1NiZ6zdZpngM5T6yTWoUS+gp71EWchcaD
 TUiuosxgi3hczkH+ClURNrMvZJVL6HVvkz5qlkGPG5QehDT/+9J0OxGbm7UZzXim5Sk9
 ZCWa/CnzkKpUiwJt9ivN4ud1bdKaf+bW+VDx+efbuPirUZ69bRsl8xfKLjI3ZAUYXTdv
 SYBlTMOo6/6stDLClJlLasLKKaLKyyk5XZBFEjh+KKlLhJRZpbU0D38CqOFgbAPWswG+
 q3ZEJ43DNr4Q8N+4VhimcpwAswO5opnR7legoh6/Jo3fezFygzFk9KjtxK65dX/l24+J
 58Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728331584; x=1728936384;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ShdNUjoISVvBaFZwW4KCPuVoTkTJEmjORNjns2u5W2Q=;
 b=xPL5H9iue6H5YSlvQ5u6M/MH8U4npoxolCoNf0Yoh9O/Kdmses7cJcPs8RONwytC2/
 fkqtqWWmbIVqQSRzCjsIRRtVrg/JVbYZterc+tDJKwwjP7BAkbuOoqoPjnybDTi9ph2Y
 WD3+twA30+CvqJuMs9Ic8curFcbGRbi7i0Nd7h9uPD6qRVJn9F683Bxfl8ROeSzYIR8V
 ueWRlwsQCo/mxIFFVY9e8O6pqrGDbNzPu3GiwFwyeiEmZlPsFWl/PqehKJkgE7JOeNfv
 yak3RP7j3zYs/j3r+Vceh0HhwmXHIW3EeXwt+3SBCEE8v99rHvZo5yMNoPZO4SM+blB+
 RKlw==
X-Gm-Message-State: AOJu0Yzgl+TA3xjS4dlY6Q0av69PHeZvcZjwwN1jFSde/WU5+SSZqOag
 dMuzi/rn2WYHsWyZERiOji/BdJIKayQvleSQcNoF9aat5Yu1eBFljUKX8xdjvPg=
X-Google-Smtp-Source: AGHT+IF0KfvbdzsfXodaVN6N5xQkyNlXAoSp/kgylzLflipyNydWh0Bd6Kp6f/ULTA6O1KbLHSxrUQ==
X-Received: by 2002:a17:902:e892:b0:20b:7388:f73 with SMTP id
 d9443c01a7336-20bfe3a021fmr199222665ad.42.1728331584154; 
 Mon, 07 Oct 2024 13:06:24 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138d0ef9sm43368285ad.98.2024.10.07.13.06.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 13:06:23 -0700 (PDT)
Message-ID: <2e4a7aad-02cc-40e6-a647-9e6bdba911a8@linaro.org>
Date: Mon, 7 Oct 2024 17:06:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gdbstub: Fix wrong CPUState pointer in breakpoint
 functions
To: Roque Arcudia Hernandez <roqueh@google.com>,
 richard.henderson@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 slongfield@google.com, komlodi@google.com
Cc: qemu-devel@nongnu.org
References: <20240906225451.1039718-1-roqueh@google.com>
 <20240906225451.1039718-2-roqueh@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240906225451.1039718-2-roqueh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62a.google.com
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

Hi Roque,

On 6/9/24 19:54, Roque Arcudia Hernandez wrote:
> In the context of using the remote gdb with multiple
> processes/inferiors (multiple cluster machine) a given breakpoint
> will target an specific inferior. If needed the remote protocol will
> use the packet 'H op thread-id' with op = 'g' to change focus to the
> inferior we want to insert/remove the breakpoint to, for instance
> 'Hgp3.3' and not 'Hcp3.3'.
> 
> This is supported by the documentation of the H packets:
> 
>   > 'H op thread-id'
>   > Set thread for subsequent operations ('m', 'M', 'g', 'G',
>   > et.al.). Depending on the operation to be performed, op should be
>   > 'c' for step and continue operations (note that this is
>   > deprecated, supporting the 'vCont' command is a better option),
>   > and 'g' for other operations.
> 
> This can also be verified in the GDB source code file gdb/remote.c.
> Functions remote_target::insert_breakpoint and
> remote_target::remove_breakpoint will eventually call
> remote_target::set_general_thread if it needs to change the process
> focus and not remote_target::set_continue_thread.
> 
> This can be seen around a comment that says:
> 
>        /* Make sure the remote is pointing at the right process, if
>           necessary.  */
> 
> Google-Bug-Id: 355027002

Where can we find more information on this bug ID?
I tried various query in the Google public tracker but
couldn't find anything.
(i.e. https://issuetracker.google.com/issues?q=canonicalid:355027002)

> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> ---
>   gdbstub/gdbstub.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)


