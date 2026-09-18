Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2081C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 19:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7e88-00067t-JU; Fri, 18 Sep 2026 15:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7e85-000675-9B
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 15:20:15 -0400
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7e83-0005EE-KU
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 15:20:13 -0400
Received: by mail-pj2-x0e.google.com with SMTP id
 98e67ed59e1d1-398cb5615deso1257542a91.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 12:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789759210; x=1790364010; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5+BiLjva/sjzmvGTPYZluwi4vhPxCt+RMrM6MmQmU98=;
 b=we7BXvZBCh668cfeu5nk+jIgBHJfC8ZiWtzFMHsZj8vFlE48itqVDOvtBsGJNm7gqy
 NqRY8Ppm36sqACvnLsGEP6UlvA4Y/+Wpfo7/dtiPIaYNO23peyNjio3yt9D9ZNCxujV9
 0ARrGpnnBpC6Yjy7ZASaD9CD30IOXVNb2dmStkqZiDCuppn1oUlXKVqNXr+goYHRyMl0
 1nfPm44GG0oFmgAU6dpG5carHofklXCAh/HZYK/6jGbkHpwRykhYYb66xiHjFm6rTPu5
 qBtRtowr+ZmRFlqi/D8+URlKhSzwXN4ksNKV6HBBGqk034kp8PW6k80UwdxG1q0TbPxo
 dWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789759210; x=1790364010;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5+BiLjva/sjzmvGTPYZluwi4vhPxCt+RMrM6MmQmU98=;
 b=B7m6AOej6aY9QAUU2IHkSNWLi2oOqUHPSH9ZmXKim4GIfAd0iErCQfUGG9k8LczVyz
 XoA5miyrpkJKgZYcmbv4opcHi2S0j5J1/8im5jZQc+t7O8Mv3en+0GSXgqy17UhhCHx7
 Ja1StWKvXC69eSXcrTSJusk0PIrlrSoj0s789LJ7xb22YFXqq2vKeR9PKR2PEz4aD+ok
 ArTsSxLUzTW76B/ZitqKN3ne/aaDNvh1qSC9iGFEfiQvlXZ0q847V11IuapGBehdPmde
 S3FxIm3/VbF3H+0KOhBXnxilHyY6FyYkU+P636q4YSd6OgaWS9WNDV29PRGi5y5yKmHG
 z7Hw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4fnjAFSfV/8xhQJKTDkqNtdrTKvYZz1ScP4NSdoK7uNqr95iTHxMgqO9eRqEPgKUnyC6MtTiWVVVr@nongnu.org
X-Gm-Message-State: AFuF++kC+ONwjFdnlpLDx2HUMkTHla5H3NCh7oIhnz+2gBbUozgBNWCc
 T3ITU0RQpv7SXCp5vFE/fPhiYwl7e6V5/4MTxgp6R8mJXQyQEgwjy1MgNXrZX93prFA=
X-Gm-Gg: AYBFou2qbq8D5xTMEdwR2F3yXndl0l37LgSjylQaJMc3e+RGziQQHJnEFZ5cQBFVzek
 Si2F9OjdwSy/8HyYkadQe080/pEuyW0BZixTiVAslyC5ciDDHgYvABZngXB46Rqt7c+4ArDmbVB
 9c5X9SBVg/e/JmRccvd2QrJgEcGiiXXcn6+ex/7GwuZGaxX7n1/yQN/hXHppXWDea35u2zt6lPR
 /WcikFJi897etZajrW8dOwQY62mNJBB82tFQ4R0/7Niqnnk2lePczNcs2vOyoUG1FuNZ25NuD50
 qLjcDjoN14rWZNjdhvDlnkOAfybAW2hvr009iyM68XELjh4L9H661Cf/tj87MaiJsJn6HSHIfTd
 P1h4R3OR+70y34w862432WMUcFDfOgFqiA7uyEsAODnYCmXLi0BLOZcvLKQcShwN8O2fG7kjQ3c
 aBB74aBlXguIhFgDbEpLmiwvgUGZtlpUylstW4lBsH5M8J5KCO03DD5nA0DZiXg7C0mZ793uVpx
 oSHw/YIWMe3DNxlRbjiWv6I/yseeOOJkVsPJVooe2viSEZYhcu69wxgZIAUfw==
X-Received: by 2002:a17:90b:3952:b0:39e:6a82:afda with SMTP id
 98e67ed59e1d1-39e6a82bbedmr1355001a91.44.1789759209952; 
 Fri, 18 Sep 2026 12:20:09 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:317e:3514:d7db:974c?
 ([2603:800c:7900:ed00:317e:3514:d7db:974c])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c342b3c67sm370652eec.10.2026.09.18.12.20.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2026 12:20:09 -0700 (PDT)
Message-ID: <1f85efbb-eb27-4ee2-ad11-7dc900525fb8@linaro.org>
Date: Fri, 18 Sep 2026 09:20:07 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/17] check-tcg and docker cleanups
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260918142429.336497-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260918142429.336497-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/18/26 04:24, Alex Bennée wrote:
> The following changes since commit 3b5d71cc3652fa7f5ecc449f05dae3ead2b718d7:
> 
>    Merge tag 'pull-ufs-20260918' ofhttps://gitlab.com/jeuk20.kim/qemu into staging (2026-09-17 15:18:09 -1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-11.1-more-check-tcg-docker-meson-180926-1
> 
> for you to fetch changes up to 2e92f9cfdf050d987b9ab551088a7678bebfb613:
> 
>    gitlab: drop check-tcg from clang-system job (2026-09-18 14:03:58 +0100)
> 
> ----------------------------------------------------------------
> check-tcg and docker cleanups
> 
>    - regenerate meson-buildoptions.sh to match master
>    - revert cross_cc logic back into configure
>    - ensure configure also honours --containers
>    - simplify compiler probing to support just vdso and rom building
>    - remove libc requirements from s390x system test
>    - ensure meson and Makefile.include triggered containers are the same
>    - allow the container registry to be configured
>    - remove some unused cruft from docker.py
>    - fix some variable expansion typos
>    - update the gitlab @user mappings
>    - make meson built docker images use :console
>    - fix build container volume mapping for out of tree builds
>    - drop check-tcg from gitlab jobs without compilers

Applied, thanks.

r~

