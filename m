Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED19CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 18:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9omm-00009C-C7; Fri, 17 Oct 2025 14:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9omk-00008y-CI
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 14:02:38 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9omh-0005OW-Qt
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 14:02:38 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-78f3bfe3f69so2072070b3a.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 11:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760724152; x=1761328952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e8WRG3tvnNMCpSMg7Ei1UGKAf/OWnPSE7MFlBksmiPU=;
 b=xokibtkVGp8jDh9IW2mTSL6f0nzHdnyXfXqk/OM3Ynt817UnlfFouLKF1AtxUpFFId
 tgq+CnHZ/XFLBafW1XTnwddTos48FLg9QOFkauOWIAm38uhMphbo5tTiWXum7r1Rg+Nf
 b9/6qw2mZYNXa9zUssWcyePXsVSpg4IR1FqySPNbW0sw19CV4sBuLa2HJBcjJKceXFUg
 X/L7V68DV5rLNEskOfCCOfV4xwpzexsFL+is1E6VGya5fTi3aIwSSBAYPTlyq457XzML
 V49WLbtLEvEa1OzNKtPuKdTJbgY80vdwM3Xh2UsM9atOz9crRSQUd0q1hyf91VPkC6Lq
 m3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760724152; x=1761328952;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e8WRG3tvnNMCpSMg7Ei1UGKAf/OWnPSE7MFlBksmiPU=;
 b=KcDxjaq39xmAxtfMoByx6cjviDvCvw3G4Bx/seWaol5iZ+FX4jT7Mq8SsVCU2q7ANy
 eWe3RNhQyZaJUoDQs/dT/wwsVRjHnzEr/noZOnfmdlbJVC+OlvD9NiMjZMI8svY9I5TM
 j6x0r/F7OdrvX50zieNMUbRP9tEKrGmayZLlvI8GfnObatc/wPES/OOivcpVoN7CnDwe
 MhOTUChAAnI+9pZfmakHx/nTAsNAc5tX9LMuotN9XwUI1zojWNwF4qeOgIgWTtXHdeNw
 7T9du3NICPtOT4I6vvPnIyEkzELxmVtx2+yAjfS7q5GeNUryf719kk9mRTfvgji4rTtd
 xqkQ==
X-Gm-Message-State: AOJu0YzjWUJQ+sJjkoA4dwKuJU9HVpxhRQYwfxdiKs3fSm/4s88x+mAj
 hwM8SeHIL6/YXqvNa0aPF9bdh3Vpiw4MFQ+gOun4g5thKeEJRon8XkSHqQIqKl6bufxerPn3GYl
 ++S7iT/s=
X-Gm-Gg: ASbGncvEtSJatYqIXRyAlmlf9GkCv3OIeYPZnmDojcyS9Ws33qlCm5P6G35kCNCohbW
 TSx7XMe76ox6TPbwKsF8GHvrn6q/wObtm2kAGJBmsqVJl1tFdP7whVUnPS9DdmjTZmLq2gW4hvE
 6DlaoAyg+iif/ix9sriorcJA8+HIlbareOjIWrUnLpN+6moDqDC7OL530nlo2+NYgicFxQpcns8
 0rVzh6M+qoaL9GWblDIsT1aeW8aLWTBZLFSgjDTnMMzeZeUqinlwNv+6dP0rZ/61EIRqPG3lIoF
 szZsrJ2RiuaWL4tEfdf/0bRK95ICPr9xxs/0ui8jQEBPUoflkzrcsiplO/nO2gVnm1mNJHr4nh5
 eLzt3nSVKXJs9rwutHpSvrh/BTxwcSL1PhFY+6sYPCbwrXs4qRPCt2rmS3M0gSxRwOmkRwbYlv6
 i2TY4jDmgLaBRguw==
X-Google-Smtp-Source: AGHT+IH3SIFrgV6V9xwlGkGz9Gu189QvRxAysAlov4HFqrjWORyU/wwIVQ4+WFlrWU2cpPtwELdcdw==
X-Received: by 2002:a05:6a20:6a27:b0:2dd:5de9:537d with SMTP id
 adf61e73a8af0-334a83c71f4mr6038033637.0.1760724152502; 
 Fri, 17 Oct 2025 11:02:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5de8091fsm3582a91.19.2025.10.17.11.02.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 11:02:31 -0700 (PDT)
Message-ID: <d6c47ef5-79aa-498a-a7c1-6a8e2dbf1000@linaro.org>
Date: Fri, 17 Oct 2025 11:02:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] tests/tcg/multiarch/linux/linux-test: Don't try to
 test atime update
To: qemu-devel@nongnu.org
References: <20251016150357.876415-1-alex.bennee@linaro.org>
 <20251016150357.876415-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251016150357.876415-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 10/16/25 08:03, Alex Bennée wrote:
> From: Peter Maydell<peter.maydell@linaro.org>
> 
> The linux-test test includes an attempt to check the utime and stat
> syscalls by setting the atime and mtime of a file to specific values,
> and then calling stat() to check that the values read back correctly.
> 
> Unfortunately this is flaky, as it will fail if some other process
> (for instance a virus scanner, backup program, etc) gets in and reads
> the file between the utime() and stat() call, resulting in a host
> syscall sequence like this:
> 
> utimensat(AT_FDCWD, "file2",
>    [{tv_sec=1001, tv_nsec=0} /* 1970-01-01T01:16:41+0100 */,
>     {tv_sec=1000, tv_nsec=0} /* 1970-01-01T01:16:40+0100 */], 0) = 0
> # successfully set atime to 1001 and mtime to 1000
> statx(AT_FDCWD, "file2", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT,
>    STATX_BASIC_STATS,
>    {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID,
>     stx_blksize=4096, stx_attributes=0, stx_nlink=1, stx_uid=32808,
>     stx_gid=32808, stx_mode=S_IFREG|0600, stx_ino=21659016,
>     stx_size=100, stx_blocks=8,
>     stx_attributes_mask=STATX_ATTR_COMPRESSED|STATX_ATTR_IMMUTABLE|
>           STATX_ATTR_APPEND|STATX_ATTR_NODUMP|STATX_ATTR_ENCRYPTED|
>           STATX_ATTR_AUTOMOUNT|STATX_ATTR_MOUNT_ROOT|STATX_ATTR_VERITY|
>           STATX_ATTR_DAX,
>     stx_atime={tv_sec=1760091862, tv_nsec=63509009} /* 2025-10-10T11:24:22.063509009+0100 */,
>     stx_ctime={tv_sec=1760091862, tv_nsec=63509009} /* 2025-10-10T11:24:22.063509009+0100 */,
>     stx_mtime={tv_sec=1000, tv_nsec=0} /* 1970-01-01T01:16:40+0100 */,
>     stx_rdev_major=0, stx_rdev_minor=0, stx_dev_major=252,
>     stx_dev_minor=0, stx_mnt_id=0x1f}) = 0
> # but when we statx the file, we get back an mtime of 1000
> # but an atime corresponding to when the other process read it
> 
> and which will cause the test program to fail with the error
> message "stat time".
> 
> In theory we could defend against this by e.g.  operating on files in
> a dummy loopback mount filesystem which we mounted as 'noatime', but
> this isn't worth the hassle.  Just drop the check on atime.
> 
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   tests/tcg/multiarch/linux/linux-test.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

