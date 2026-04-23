Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C818EF589AE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFtJE-0008VD-WC; Thu, 23 Apr 2026 08:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFtJ8-0008TD-AL
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 08:37:26 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFtJ6-0001t1-CC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 08:37:25 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so85256745e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 05:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776947842; x=1777552642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HCFhxoYZBppwqZge3jGlUCS+Wvlnl6gO0m3UbyzGWzs=;
 b=DNDlOGWliX7bMhTBeBIQoWOMTemBTZuMIaLFp7UjrSp4N0/gP/VhlLnbujR9BDa+jA
 pn4iNHVUPmYTMOnv+nUV0Tz3zxs+sUmojhvxa+70ijW/ab1+nCOC2USHNBaJuOmR8+jo
 9bc59tJ7dViTjnPpIfoWenyxSY88Qr1cOGVd9Ca/ePGihA1CbV/g56liVdnXgPR99Mgq
 +VON9CG4/l1ciSxTmK/uHSGKk1ATBlCmr/fOVXHqFzFq3Xq1C4JPN9A95tVpEomFNa9l
 PD6LpfQ71aOuQvQPyRRh+OOP9dnKiAeg9f3EdNnD5LEtu3gcuhKZr9fiRu5bV8GSF5z4
 Daiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776947842; x=1777552642;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HCFhxoYZBppwqZge3jGlUCS+Wvlnl6gO0m3UbyzGWzs=;
 b=nsKyFHYAMg7clIN037M2rTEJsJRvsPgRD/Xjhl8qHotYMWX16/m+pBKZnRtn/4oGZU
 R25u79A0QGMJrp1tik860lTm0OjIA4+2vFNa55l9+M5DnccgTlfI1IHD4dTRQPDigAgc
 ukmPDUqDK8TQfFjuLpXglap1kt7X8fDlBmR83Y/O6e915L8/ivpJRcxKKhuFM/EY/r5i
 hUvqjrRAeI9XT4sHgoRjHDdIfsnMXxq9x+zozDONxKRReHjxMOSCGqukK5unQ69axf0r
 CE4rUMXztaekPW6jXAXr/zx1HIAziGRjcPvuQbx2tojamMyIKRjgkd15nwdkb7N8d5V5
 1cEw==
X-Gm-Message-State: AOJu0YyU/FhaShMsghxQhR2iLbuJLqhQ4M8LhOuhdlXaG0VRG+kPZ3aD
 3sZ/pBNzC9v273juU/J7GbKGFwWc6rtmdTHBqJ3ylh3UcE2hyHjcntbO5hOFKGKziXc=
X-Gm-Gg: AeBDies/3QVuq7w9jLcsHlD5W2554RAfsq44HTf/YYL2Hd4Hh8CTejEjX09qQXR9L7B
 gEHxjoFnGHRIDGchGZC6oIyO4+zkF8OsmqCiIuohqNkXA2aZg9+HPx6nhpW4/F+GiO6FmBR8FE0
 7rgSsBfpSRwwq4RalGBbPZg49jurh8dkgf6bOvc4Le9bTwqBLyYM9JW3msPBj9SLaFfojHHJdKV
 A8SbPIfzXvOXou6lXwxQ1FAExK2xwAR75CEs/c6bmvx/UxnHgptxvpgturYNC/JQTzgwLsmd/IC
 JmrNCt22wPJUalygNPkGgqDOKQv1anH8R5LEYuI7lQ0Xt9bVQFKMTm15DQxtvo6S1JjfP4xaDpW
 o+xYkLHVLPmPDd4AZYdRCwE0WXpmVEs4hZItRY9TX9ccmaUAAVv3s03a9G3pMs44sQEYWUuXA3Q
 PmAul8cCruJXXw3YfhVKlMQHK1AjNjKiPukhtchHhxC7vfLUeJzrjp668kCkRpgrAesXHPAJceI
 WmS
X-Received: by 2002:a05:600c:4fd2:b0:488:e192:6fbd with SMTP id
 5b1f17b1804b1-488fb790869mr396236255e9.30.1776947842510; 
 Thu, 23 Apr 2026 05:37:22 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc558f2sm386407955e9.1.2026.04.23.05.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 05:37:21 -0700 (PDT)
Message-ID: <1291497d-21ae-4422-82f4-08a99224252f@linaro.org>
Date: Thu, 23 Apr 2026 14:37:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/59] target-arm queue
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
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

Stefan, there is a comment on #10 (a8af0fb24da) Richard'd rather
to be addressed.

On 23/4/26 12:01, Peter Maydell wrote:
> Hi; here's the first arm pullreq for the 11.1 cycle. One feature,
> quite a bit of refactoring in target/arm, and also I have included
> the patches to MAINTAINERS to remove people who aren't active
> in the project any more.
> 
> thanks
> -- PMM
> 
> The following changes since commit bb230769b4d01de714bed686161ad39a8f4f3fd1:
> 
>    Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-04-22 14:30:04 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260423
> 
> for you to fetch changes up to 250c9de780448fd447056ea42c7ebfdb0b32ab92:
> 
>    MAINTAINERS: Remove Xie Changlong (2026-04-23 10:39:06 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * virt: Allow user to specify cache topology
>   * target/arm: Move OMAP CP15 register definitions to cpregs-omap.c
>   * target/arm: cleanups for single-binary work
>   * MAINTAINERS: remove people who are no longer active in the project
> 
> ----------------------------------------------------------------



