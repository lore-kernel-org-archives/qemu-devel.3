Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D37C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Tnn-0006AZ-A7; Wed, 23 Sep 2026 16:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tnl-00069u-En
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:42:49 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tnj-0005rN-VH
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:42:49 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85a4329731cso814232b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790196166; x=1790800966; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MmWh0yzSusuFW16awIVZo3NtJcNpQMdUzGOiAOugz5U=;
 b=TvuoI0GRO5D4OEUt4d2eRkjq0kRDdZkRkspVFUVBPW0fH5BiN8UeiaM1P9opqHpDxl
 JpvPP9pA40pXZJfkbr22avFnUIXcdbG5x914QMPLtXI01Q+BaHaGPtfseQBfpl64c+JW
 AZ2zf0MnOaUueMJJhzFe4D6mDwvOvSOMm8x2yOC9vNugB+jE8j3NkQISShbQLoE3SLwB
 cVy3vT/g8CBNIUs8CnN3ziPolMzkGhvnvaxjSiCMsGTjED0mVuJ92qj+GUU9GLcvLRnU
 IedQPuE2k7EFDUVbm1yo8P4oK6mZyetGo5Eea5cwJMqIXpviFcUwteG7p0yZC++RjRVp
 3Hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790196166; x=1790800966;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MmWh0yzSusuFW16awIVZo3NtJcNpQMdUzGOiAOugz5U=;
 b=s7rN3f07MpLrz4I2Pr5P0qKeUfKsm2VLElAk5/fS/YwzL3+VHGxleSMBjVENevBGPE
 0lhdyGzEXeOfMbMdveIY6jztyHQJ7EkrXKtW5B8nY+mXaI6MCZAgnVrX3hdanybu2ujU
 +tFeag+tpz/AqZH+glBy7AOHgrqVO4jb5YC4pBSfXrD25FYEqN1/BCqEFfeKfVhf2krB
 sPPWR5meCNhVF6Sx+wSBsKHQFRPtb3dkBDY/UOMyrfmw9B6GFalYYwQp1HgpV5y94aH7
 oz4ea2ObdU+hiAiy336e+k7vahF4j6CdMY7NbVrjKTBvun0bYQpKMibhup0xfwtrPyQ4
 8PFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDQz54wH7mBrWP7oiL4T1oUpp94GjCJERojGf2BTNidLwd8c1COEPxxVtnSgmMQBxib8veVcWsKBLq@nongnu.org
X-Gm-Message-State: AFuF++ltERha6l11ihr7BI9KzIHZf2BhaEov8Q+R5ySBtjaiFvkGEDYl
 HUwMJVSPsEx+d9UgC+6fgHO9qHWQ5zyHh0FiMbEXjEOBOLTn6h4CYlNSWSu1mmgwb9g=
X-Gm-Gg: AYBFou3dEehqXkWPEG+0413oFYHR9bXUCxtISJEUMslRgYEQz0dhNfSPHiSqvou8Yqh
 tIGNOYKCzrEbbtNHPteTfx7/M/r+vxy0oXmyHALTgl0A1BR4/wh7q4E3xtQxYe1y9CY+nYIbETX
 dXZgWRx2uUA9lT2nfFbwGY6zbb6KdayXXMT8QNFwXu6vcyL6YyqUhX35Og9VrZPVHQ1wjbbI+xO
 9NmHZrO50ycnJHy5Snmx+widUBstTaRLXwkuSrMmaaisqOVGZ5xB3o4sBvE6d875dl88xvT1pq8
 c2JXtM2jf/kW1spwoxzLLIylqlm1DgcNBiEhuE01VemybLwiYMnnPZ9ctFs+m3FVNVrX1XaM3gt
 NbU/ZdPN45hCwZYhBeQezqQmm2sd8MDBzPxTYVvoqwphl4hsE/cLOonFD9AzpsRqXEuW6AXhD9V
 7N/edddXs/xpa1fRab7ZvkU+ZBjlwdK64a7p8DgztaOEnVbUuHXX4tbi7SSoA7TXorR6J0EngWA
 5uC8gKa6zd+YEtpWXKwPd8bc+zzx/wt2IJDMy6g+FbxmWYkvbxo
X-Received: by 2002:a05:6a00:bb91:b0:872:6004:f117 with SMTP id
 d2e1a72fcca58-87e9957399bmr290925b3a.24.1790196166050; 
 Wed, 23 Sep 2026 13:42:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1cfbfd6esm1816578b3a.20.2026.09.23.13.42.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 13:42:45 -0700 (PDT)
Message-ID: <4ca867a6-8ea5-4ae6-8428-c4f58b36d3c9@linaro.org>
Date: Wed, 23 Sep 2026 13:42:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] target/arm: Add a debug check that all sysregs are
 migrated
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>
References: <20260907130223.3148989-1-peter.maydell@linaro.org>
 <20260907130223.3148989-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260907130223.3148989-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

On 9/7/26 06:02, Peter Maydell wrote:
> We mark some sysregs with ARM_CP_ALIAS (either manually or
> automatically) to indicate that they are accessing underlying guest
> CPU state whose migration and reset is handled by some other
> register.  (For example, typically we make the 32-bit view of a
> register an alias and handle migration for the 64-bit view.)
> 
> Add a debug check that we actually do handle the migration elsewhere:
> for every sysreg in the hashtable (i.e.  which might be visible to
> the guest), check that some register in the migration list has a
> field offset that matches.  This isn't perfect but it can catch some
> bugs.  In particular it did fire for the various secure banked
> registers that we were not migrating before the fixes in the previous
> patches.
> 
> Because the check is more of a debugging aid than something I'm
> confident will never produce a false-positive report for some niche
> combination of CPU and machine options, we only do it for debug
> builds, and make it a warning printed to the user rather than an
> assertion failure.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 121 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 121 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

