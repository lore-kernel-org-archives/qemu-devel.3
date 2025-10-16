Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460BECCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 10:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9LQq-0002wi-6i; Thu, 16 Oct 2025 06:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9LQo-0002vq-KU
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 06:42:02 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9LQk-0002xR-S5
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 06:42:01 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-78113fdfd07so5087597b3.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760611315; x=1761216115; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bTlThrkGP7o0lPuUTwj6GZkfseRWUreUjXOtEetO0Hw=;
 b=JUOz+8/EAnv+OeQU9gkbRaRMioc2ccHTPW1I8BdHHECXb/LQFIok5xa8hnR+iU1EkW
 KJpAwHOU4Gz9vok+FuaaVVNS3+ipCBzv8Sv6l8bKNylh4OkXNQEPxB4tq5x40l0pEBCJ
 4m9A6Th+XrU8T0B8y+0B039hCvchr9arZJvcEswNl8VUEGGCz2yMjUxGZnCX3fICTWlf
 Iv2WXLz1f/idp3ONTQjIQA4eA/ReuPVw/Qi76249JsvsjPUzbhBld6D8tTo6A8UA2gaT
 zeNQNYe99IFpLvom+mqXgnvUXRc/3m/ykRKbZ13zbqrIiEsiTrLMZpZJ0cSXZmmu114j
 iKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760611315; x=1761216115;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bTlThrkGP7o0lPuUTwj6GZkfseRWUreUjXOtEetO0Hw=;
 b=YTn5EPSxVmx18dJ5EK3iIw5V77kjmNb/19K/UIRWPlSl4qBxOkvF7Ps+oMc9C0U0au
 jEXbLVJPgV0PJH8Zomxxt4FEuvJ4yXdumtho+KCArb8VZ2rB7TIRmJ7UkPMqZJd4L/bl
 zb4snLUrmPSiVVgmhkXtAwEVpF5b2MkOnLHdmdZAUxMzhedB67ktROrRbBSpdwrtcUQ1
 BlRm9OMTyo0X222tyslFZHX5xfTYHTBWoM4uKY7cSkZ9Om2m8z3KI9hQhtSuPmoSuL9A
 W5GhIx9YQiWJ6TPnvhcvSXUeEWQUNeUxYj3ZmFSriXB+CinRjsWdpEZ7FiOSRXgS9Lez
 Ezgw==
X-Gm-Message-State: AOJu0YxASxCOsyZt2LVjb1NzW+fH3HKqltIS0pOJtrab6Rc1ifHCrDmg
 FnW4yLdqyCFn6AobnRmgyV28e0k7vCdRQb0Mu+3CQUR/U0dPKpUHzTw23HV98rLMWyaZb/fm8W5
 /0zg8UQas7E9h+HDu1n5RpmVRkSSDCg2EwTLrmVj7+aSk1knVvRSk
X-Gm-Gg: ASbGncvNfuPEweJKm0Pggs57JVfYfmCf/fsJLpHnlyhogq3AhUk5fzLQvxrdJiPMP+f
 YcsaRJ+/YIPRWsT2DuYBg/KYTdYW2OdbM3CbX/GUaOUbzU835juNB+DkMWqWgScPNMfSL5yPMWA
 scIpT319erLQycd4a/7M/N/TvtTu6o7ZgeSLqNpJESpfA117LVzcGDG/fH4YTKy+9VOblJbgVBj
 o4PT/UILlf53OmdiKdE0g2yBeFVzHgTKG/Cc1dzjyIFuXlchnY7d1RRhu16sLJddYZxhPYwZpoy
 Rm+yDs9+xf0=
X-Google-Smtp-Source: AGHT+IFzquJWho5RMDUtLp5SZBHFGLOa1IKgjreFwL0wG0kpquH3r4t2/M/dZRBlGTlSQWHyYauA0hjBevchxcDn22Y=
X-Received: by 2002:a05:690e:2c3:b0:63c:dd26:331 with SMTP id
 956f58d0204a3-63cdd260bb7mr17671756d50.10.1760611315197; Thu, 16 Oct 2025
 03:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251010121435.3885228-1-peter.maydell@linaro.org>
In-Reply-To: <20251010121435.3885228-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Oct 2025 11:41:43 +0100
X-Gm-Features: AS18NWAbELbFNag36BtKu45paPluvcvPbbAu3qH3xbVnIUHiN9bShYEE_dCDUKU
Message-ID: <CAFEAcA_KzHLCV4GsHWAKSN-p6018HGLCCFuPZNOia4B_+oWDRw@mail.gmail.com>
Subject: Re: [PATCH] tests/tcg/multiarch/linux/linux-test: Don't try to test
 atime update
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Ping for review?

thanks
-- PMM

On Fri, 10 Oct 2025 at 13:14, Peter Maydell <peter.maydell@linaro.org> wrote:
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
>   [{tv_sec=1001, tv_nsec=0} /* 1970-01-01T01:16:41+0100 */,
>    {tv_sec=1000, tv_nsec=0} /* 1970-01-01T01:16:40+0100 */], 0) = 0
> # successfully set atime to 1001 and mtime to 1000
> statx(AT_FDCWD, "file2", AT_STATX_SYNC_AS_STAT|AT_NO_AUTOMOUNT,
>   STATX_BASIC_STATS,
>   {stx_mask=STATX_BASIC_STATS|STATX_MNT_ID,
>    stx_blksize=4096, stx_attributes=0, stx_nlink=1, stx_uid=32808,
>    stx_gid=32808, stx_mode=S_IFREG|0600, stx_ino=21659016,
>    stx_size=100, stx_blocks=8,
>    stx_attributes_mask=STATX_ATTR_COMPRESSED|STATX_ATTR_IMMUTABLE|
>          STATX_ATTR_APPEND|STATX_ATTR_NODUMP|STATX_ATTR_ENCRYPTED|
>          STATX_ATTR_AUTOMOUNT|STATX_ATTR_MOUNT_ROOT|STATX_ATTR_VERITY|
>          STATX_ATTR_DAX,
>    stx_atime={tv_sec=1760091862, tv_nsec=63509009} /* 2025-10-10T11:24:22.063509009+0100 */,
>    stx_ctime={tv_sec=1760091862, tv_nsec=63509009} /* 2025-10-10T11:24:22.063509009+0100 */,
>    stx_mtime={tv_sec=1000, tv_nsec=0} /* 1970-01-01T01:16:40+0100 */,
>    stx_rdev_major=0, stx_rdev_minor=0, stx_dev_major=252,
>    stx_dev_minor=0, stx_mnt_id=0x1f}) = 0
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
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> The failure happens to me occasionally on my local system.
> ---
>  tests/tcg/multiarch/linux/linux-test.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tests/tcg/multiarch/linux/linux-test.c b/tests/tcg/multiarch/linux/linux-test.c
> index 64f57cb287e..bf6e0fda262 100644
> --- a/tests/tcg/multiarch/linux/linux-test.c
> +++ b/tests/tcg/multiarch/linux/linux-test.c
> @@ -155,9 +155,14 @@ static void test_file(void)
>          error("stat mode");
>      if ((st.st_mode & 0777) != 0600)
>          error("stat mode2");
> -    if (st.st_atime != 1001 ||
> -        st.st_mtime != 1000)
> +    /*
> +     * Only check mtime, not atime: other processes such as
> +     * virus scanners might race with this test program and get
> +     * in and update the atime, causing random failures.
> +     */
> +    if (st.st_mtime != 1000) {
>          error("stat time");
> +    }
>
>      chk_error(stat(tmpdir, &st));
>      if (!S_ISDIR(st.st_mode))
> --
> 2.43.0

