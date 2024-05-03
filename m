Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3485BC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uYD-0003do-DV; Fri, 03 May 2024 11:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uYB-0003dI-5V
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:10:15 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uY9-0006Sx-9e
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:10:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41dc9f98e8dso12531985e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714749011; x=1715353811; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=doBc12Ya5M4rI9e01/aga5rnun+gpIOU4yPN5xAIBtg=;
 b=bi8hpPquKJCoLyshT9//E5+0yjFTtAqwjTRBOvzi8A0MvKzJGYfNNtxsj1JIFQZO/D
 VFYPPm0SvC///h5nlHVZkInzjME3STtBjmiNdiITGberRiG+1feFFnIulxsuP6QnJo6q
 IlkjtqKYzH4kBbjLipUlFqE2Vx+qnpKgO+nQmqX7EIluyBFDkXgJ6Qe08b0etAMUSEPP
 5ucZORt91w3RvjtTEVBvxa+184/TmDiojXw1JYuyzTXf/wV1Jb9gd2svHeHwRg4tSHcI
 Snl+ZxdDrm6JBlVL60jxq3MmHtQ7cOAZtS+uEVW6wVTBzNqrnSVJUZI/Ogf3m/TCM0AS
 6b+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714749011; x=1715353811;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=doBc12Ya5M4rI9e01/aga5rnun+gpIOU4yPN5xAIBtg=;
 b=v55XKpolH377qxryz1kaZwXi4JlV4BBAZIatLSs/grUXh8Q9wq0oxvt0U6yUEdtwBp
 hUhOCcGCXt9m8CD577XTdw5cGDLZ84HUFyG8vVBroJJZiyIp3V+eKfDUkQAv4Cs1w4ce
 6cjJkaRzB/ytNxjLDgQqHVAk5roULF2iaFjF+jvHiWifKjvjs1z8lhVtb1NaJm4F3S36
 +XqG8wGLrgEgJI6gADNYHgiNGHUsmFppjm0NJRb32gC38rTCekqfQzF20HgffKBE2LK2
 m4uyxx15pT6SDXQeM3TLTNeoZKbsyaIPoiN0bKxnGra3qxFmyh3/UjumcTAhMSJfsbg/
 Hi2g==
X-Gm-Message-State: AOJu0Yxng9YepZ3fLcUbExQ55oq06lfI441irHMR5uMXoMHDd2wmOktJ
 lsFySLwTwZDoRl8qIu5QUJ5dPHCKmhPIDq2ATVcBlvB5D5mOlHcrpL10uuJCeBkv8JvJxpVbdRY
 8
X-Google-Smtp-Source: AGHT+IGvFGOhblweIJqJH4VhLlnUKZRRiuzSHYbL30xMHJSIdEnV+ZrEhGHH+uYCLISTybinOGbvBw==
X-Received: by 2002:adf:ed83:0:b0:34d:b3a0:5614 with SMTP id
 c3-20020adfed83000000b0034db3a05614mr3026559wro.8.1714749011107; 
 Fri, 03 May 2024 08:10:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 j8-20020adfea48000000b0034dcde55043sm3955574wrn.101.2024.05.03.08.10.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 08:10:10 -0700 (PDT)
Message-ID: <2f7d5d45-e4ee-4685-993e-4fd4969de093@linaro.org>
Date: Fri, 3 May 2024 17:10:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] accel/tcg: Call tcg_flush_jmp_cache() again when
 creating user-mode cpu
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
References: <20240503123456.28866-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240503123456.28866-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

+Claudio & Peter

On 3/5/24 14:34, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (5):
>    accel/tcg: Move SoftMMU specific units to softmmu_specific_ss[]
>    accel/tcg: Move system emulation files under sysemu/ subdirectory
>    accel/tcg: Do not define cpu_exec_reset_hold() as stub
>    accel/tcg: Introduce common tcg_exec_cpu_reset_hold() method

Richard raised this question: Why AccelOpsClass is system-only?
(also related, why "sysemu/cpus.h" is).

