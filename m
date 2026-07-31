Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA5AC5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wprc2-0006O6-BW; Fri, 31 Jul 2026 14:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wprc0-0006Nj-Fx
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:05:36 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wprby-0002wc-Of
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:05:36 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6680ae2031fso1098942d50.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 11:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785521133; cv=none;
 d=google.com; s=arc-20260327;
 b=p3JbPao7VViPI9WlLwqpp3DbQyumsymLYQeLWVCqXj6bxn0opaH1o/18uKZPS5KiOd
 FQ5yRuAwPYzuN+e4B6fQWnyReNzKe3BdCLL8xC2bVQp01losCGHADNkxPAMIxUfOVtbg
 RgyHLBHr27fILY2xBeNzZYPwFx1rLIouixqDBexh4WPQRw/CetqPJOrC3Jxkh1SUw2CC
 jciImC19Y8S1qvKuFoNAmp2EkmdX91UyO0MfGAjyDob9eyBy/Mv4ubPIaeUbfO7lAlO+
 WjZv0Mqx2BOVldP+hze5yVQZ5EBWoZAp1AZ8wj1aS3y1/B1i0joNYr41E9ZuD8BY7DMX
 Rv9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5S9gN/jFvniC6qSLID9ELn8k3pszI/eh5UwHh5bns3w=;
 fh=hkJYBzlLFB1Hu+yotcIJBiJRRwI/iNOrLzc4m4v/pUY=;
 b=ayDTpsk3JXV+XyBIf9JBWEL8FaioqVHMBxsyWPEmFPUSn4s6HXQ+tf65Lyhzhqmrya
 F3CBXEkZ7u+hObSde2H+75R6F35oq7gZ7DKZHUIhNHw489ATXAGa/PwPRBZPc1kTj/y6
 RS7+tVljw7nn0fHD5ahp5KwX9/1m1pCFbBTPx4x97XIU9RlB1+tcfoX0+eTdpDdYK6l2
 9ZHS+tiup9rMALn8vFil5ap4TWcZwP+ViY4AchWA+pLjif195Q5n0rLIuAH1Le6yDRJ3
 N5ax2Kkprccn9uAotWak5dMvTSzubE5rn6omm0R++OJhWGpjea9buA6LneX39BNrx1Aj
 4hOg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785521133; x=1786125933; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5S9gN/jFvniC6qSLID9ELn8k3pszI/eh5UwHh5bns3w=;
 b=kc1z4XDp0eD4qR31G+W3R0Q4162dBC3rfkd99/lurJ3ggRQuqjrtHqCSZ119Jlu8co
 xYqnjqousNtULnrOUMOhb4FjCD7beOhdzWfj40a35InLLw8JWjmE7KuwFplHVmOJ+2vy
 +J/6xLlRfzgPKMy70e9uYvZzd5SZA1wF4xzvZt6ACdCn4UtqhDNsFDOqSho0FlZPnoS9
 c9ptK9xrphKr73P3AOJBgAz/leiMQeYdok5gmq3910z/MVI0cMQ987z75mxhpZMRq9lO
 LKBwmmpUVBqAqi7V2RhaHFZrUi6aBHUAxOABXrwvHOcFeEIoGeOyjc+NIVKSlTCavFMp
 bi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785521133; x=1786125933;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5S9gN/jFvniC6qSLID9ELn8k3pszI/eh5UwHh5bns3w=;
 b=pXskEpM13KV1iHMXkPxG6GYcYw+KLS3ruafKVUxusbD4OzuO7zLYpjKtSbcO+AvC9C
 +huqA9sAIMLoP2QLO9SxwQU16BhSaVTf75DKvObkSN8k+yPwDmRMNkyQrPSh7jfZzjGV
 61/zXJdA+WNTxLnaxyvXpWOF44R+Q6/fBS/lzkOD/7hwNf3AjtZRP8EI9piLfpazlxws
 YvYK+X59o2TJRhjnGC7PoY1XHaAS/PBcw2DlMy29VUdpuyH2IIFsyPgpQAkSb4xfNCYX
 qaC4vxUzX2q+xqxiN3gVDbj5HTicfPMMLRUMYAHLoL6Zf3HiedvcJBY6fgi9ex8xQ3uD
 zIvA==
X-Gm-Message-State: AOJu0YxOaA3HSuuTZJbk5ECsarc98oVvxOCY0AKc+Lfah0Vot166ikfn
 O88v0BXajTF6MSMkGhtb0x6AjucpVM/K0S9MN5pxA6rmV41rU/MtPea7wy002ccxiY7YH3yb+nP
 Kq+DsBz1a/kBfNUOZErB2wtcfUeFMpf8+6PelpHXYlw==
X-Gm-Gg: AR+sD13YRHnW+fEo8dxmSPbIa3L6AMsPpnOed5oOjIz44hG5DIkQHl1cuJqOw9rZd68
 sFbV8tXZgQJccBNFYG1woN5OeT1Sfqkp5sR/MC4XcYv4KC2FldyTnGqhil/Bcn0U2MMw5ACr/uY
 DpX3tJTTI19Vdaang/TSZOgnrmVMiV/DWN5wAuCVp7G9NTLRzOemfTjEjZUcTJGAJumCq3VOjlG
 LydxOrl73zcMmvBoooN9JCIUw4YhTFF7a8wb9MREqDnYjuiwEUUpfX1E3Jj0gdwHlFhlSk0xcPw
 n6NCidH4L3FHUtWhLuC2xBx1YEe/78PF3FXIdgt0thqIT+b0I/6cSu7UH5xqXy1h4VcC9VOV71F
 H69niU4IWcQZ3lypuZRc1r7mI8xEm
X-Received: by 2002:a53:ebc3:0:b0:667:bb94:18d9 with SMTP id
 956f58d0204a3-6694f06361emr841777d50.13.1785521132559; Fri, 31 Jul 2026
 11:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260728192913.61279-1-deller@kernel.org>
In-Reply-To: <20260728192913.61279-1-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2026 19:05:20 +0100
X-Gm-Features: AUfX_mwlUYFzWDz5giYQ765QmEpU2k6-J_gQmQ2BvTZOMTQUdT2QFyApk7EtawA
Message-ID: <CAFEAcA_8o2A8FDsJKacde+pdj4HzA5c7aTw=k7tmONYXD4=c_w@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Fix msqid_ds struct wrt 32-bit big endian
 architectures
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Tue, 28 Jul 2026 at 20:32, Helge Deller <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> Make sure that the time entries (msg_stime, msg_rtime and msg_ctime)
> are defined as 64-bit time_t values, since the userspace may access
> the whole 64-bit value. By this change we fix the word ordering for
> 32-bit big endian architectures as well.
>
> This fixes the msgctl01 LTP testcase on hppa32.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  linux-user/syscall.c | 30 ++++++++++++------------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 740142825d..c93b770ced 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -4216,21 +4216,15 @@ static inline abi_long do_semtimedop(int semid,
>  }
>  #endif

I see this has already gone into git, but some late review
comments. I suspect this is mostly me being confused rather
than actual problems.

>
> +#define target_time64_t         abi_ullong
> +#define target_swap_time64(x)   tswap64(x)
> +
>  struct target_msqid_ds

Is this the kernel's "struct msqid_ds" (which it calls "Obsolete, used
only for backwards compatibility and libc5 compiles") or its msqid64_ds?
The layout matches msqid64_ds, which makes our struct a bit
confusingly named.

>  {
>      struct target_ipc_perm msg_perm;
> -    abi_ulong msg_stime;
> -#if TARGET_ABI_BITS == 32
> -    abi_ulong __unused1;
> -#endif
> -    abi_ulong msg_rtime;
> -#if TARGET_ABI_BITS == 32
> -    abi_ulong __unused2;
> -#endif
> -    abi_ulong msg_ctime;
> -#if TARGET_ABI_BITS == 32
> -    abi_ulong __unused3;
> -#endif
> +    target_time64_t msg_stime;
> +    target_time64_t msg_rtime;
> +    target_time64_t msg_ctime;

Assuming msqid64_ds, the kernel version of this struct has a comment:
 * 64 bit architectures use a 64-bit long time field here, while
 * 32 bit architectures have a pair of unsigned long values.
 * On big-endian systems, the lower half is in the wrong place.

That would make tswap64() not the right swap for 32-bit big
endian guests.

thanks
-- PMM

