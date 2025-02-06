Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D46C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg0Gw-0002CU-Fb; Thu, 06 Feb 2025 06:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg0Gs-0002C4-Qf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:42:15 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg0Gr-0005Ci-1D
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:42:14 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436202dd730so5227475e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738842130; x=1739446930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+pjLuzRWt1rH4Q5pLyb4XC/Ml9Yy5R9sariFry8Hn/Q=;
 b=YXyv2EkMYOR++pRskUkod0sphfKdwv+ew50iamI+GSUe9je/tt0ZuLtKls8OaLLxU1
 j/zd/DDwIxM9/F+TLHJPi9HLKR3BPXyB1cGzgOQ3sPlfm0/awQcXMiskomtcDKXVonFt
 T/kmvsARzTJYMISGIEGj8YCF+S1vRyBAUubuyQ1vBfxDw+f944ys9xpopyA9EnuA2zCg
 9vIUqOmE2pWsE8O6k2fM4eI6GONFm+S1xS7C9vr8Z2C4qsy5X0l8SzdqyAS5T9GUzeAU
 0fMXP0vfMVMkHGDMZjhepdKY5faM2GZt/3dgZ5Tzs9pPBBw5tzOu0K10gTu0YwK75MCT
 iEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738842130; x=1739446930;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+pjLuzRWt1rH4Q5pLyb4XC/Ml9Yy5R9sariFry8Hn/Q=;
 b=Ib6B8Qvqh1gckrk5SvdWG9TX8I9mYjFyRGxjaUt6NBTRZl6fV1GLvGN0gzEmjISIo6
 2ITD7z9I+KsStHdv4AdYdKKp7mG5hen1YW4LR5cmH1J/Rsvv178TDZs9rnERrOSMriNB
 8zy0kpZJLArFBVGb2KLVplJ5jgTCS7v2IWLbm4CAyzjPQmQ4ZjTdRVofMC79CBJltTwD
 epbDHf6AC/ZZA5EtjJXgd3qzZD8mi45igdsa5FEx4iY2y3QKSipJwVBQcT5oKGB/4Xwp
 nNA9My2a+c+9ZO2h3pb1//GSKfwSHk4fyMliFURUxa3Ru9gnikEdhey35GL1vitT+muR
 L0qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgG64RGyT5bzliKoo83bkQxTwHB1ZZP3oMzTf6hhVfno3m51iAufu1R/FisdgOQ4NKiYd5i94VgGgx@nongnu.org
X-Gm-Message-State: AOJu0YwVMwLxO3CP16f4+/XCKsLlnjYBCVLLkxAJmjtBWaq1K+NdNzMN
 o9QCN+69rM/79DDA4mVNzZqD1TOPi8O1kdeolsoSxBRm5o8PQIYE9csiih2NxK0=
X-Gm-Gg: ASbGncusAHn3Tn/ph/1rzZl0oO7aAYYuGM/Ldb5SYmXfh/W9sOsXwHCfltVdkbzfn/W
 yn4El/twIHr67v9RMkUZ42WLlevGlK9anNAMYiN/pEZ2hRj1acq6hDh4Q1P4KiM8+EpY8bc7d92
 zV0M8C9xghc+5ktmoG1GNwAAMTpdNMuzJSqEIHz5CCHU53OXXN0VtRZBZG/VG0VdM2uyDbqFFQh
 bPQMr3gZkPDKXCclLTmXwWuP9iFSd+q0EayVe5mG3jzcjSilT3gm30vSz5PMCaL/F1Hhzuo+fkg
 FtBkMn82VoxYAN6Pj72rs8ndfL/dgxkgytkKFBoPXUmmp3sHXwNwq0JpQa8=
X-Google-Smtp-Source: AGHT+IFB2wz7cBDxWE+TBfK+XzxtBMCRkwTfj9yi8DH+I6/5+u5SBgdyr12cEM7+2Fa4UiD0Ne6sDQ==
X-Received: by 2002:a05:6000:1f87:b0:386:3e48:f732 with SMTP id
 ffacd0b85a97d-38db4873819mr5612823f8f.16.1738842130151; 
 Thu, 06 Feb 2025 03:42:10 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391da964e2sm16862565e9.4.2025.02.06.03.42.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 03:42:09 -0800 (PST)
Message-ID: <065577e9-94d9-4216-8a46-e4cdfb19148b@linaro.org>
Date: Thu, 6 Feb 2025 12:42:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] qom: reverse order of instance_post_init calls
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250206095836.2120918-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206095836.2120918-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 6/2/25 10:58, Paolo Bonzini wrote:
> Currently, the instance_post_init calls are performed from the leaf
> class and all the way up to Object.  This is incorrect because the
> leaf class cannot observe property values applied by the superclasses;
> for example, a compat property will be set on a device *after*
> the class's post_init callback has run.
> 
> In particular this makes it impossible for implementations of
> accel_cpu_instance_init() to operate based on the actual values of
> the properties, though it seems that cxl_dsp_instance_post_init and
> rp_instance_post_init might have similar issues.
> 
> Follow instead the same order as instance_init, starting with Object
> and running the child class's instance_post_init after the parent.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/qom/object.h | 3 ++-
>   qom/object.c         | 8 ++++----
>   2 files changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


