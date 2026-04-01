Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFB410F6FBF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xno-0006gR-Re; Wed, 01 Apr 2026 11:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7xnT-0006Ue-9K
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:48:08 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7xnN-0004Jz-4D
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:47:57 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64edf260b49so2133881d50.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775058466; cv=none;
 d=google.com; s=arc-20240605;
 b=F0sjHIWptZ3ZB6JuMQhZx3jENhkdmFbFEfTjID0+ZbgXdwt0Ghns1TYfqJLtg0NXDu
 7QW8XwpAhKq7pis/I6vQQ49cPeVSii74HmQv927UyEpRAtKce2YK2BdfM/XEK7vzwpdG
 rGO2HiHEBVrh2UZ/bzOVnNV7iMeN7PeQ570Vus67yUTbqzr5bkhAylQrRr04WUO2MrKX
 voxRZQK6bxFh7ttiaLsg13nivHLyK/DJswsDn6gYnEV07MDy8U32YnYiRxoagRFUqRnF
 k1in0DmGdvj5gvuaV1S7UF4gxk8vlCyfupHLm7QSt6xt+5HIXKr8CjiBvhC9EpohKhPb
 +xjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=kmB9aIaU6FDnNTOkQ+8o75AxF7qUsTKMyzO9o82yd2w=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=I03gy0r2bVN+NPKUHkeoHDk2LXbiOUiyQjBuUsvUDtHBqLm5RH6kMFp93ngEODqxOO
 fy4e/pnelmTnhELxjBdnEggPibJfy0T8dI4zd1SYxzs0uLzGgco7GOurqkFwMceX5TIB
 K8xwq0y4FHnJyaxuHOQBP3ZYm0/0Mgkxz55a4H5YdvpfwmJzdgPpuEvKxteq8qISQXSx
 FZ9DnXoYCm2ODdA2X4xXLiW31TTUtJ5EWo8XJVChRseTTOjTmAjhUjCZRUwq+wsLN1FC
 JNQ/uHGUZnnEL1tUKNq+aRyJdnHG9LDwVvmZO7jqzTKdaPV6q9090SO0aiOoC9zX6d3Q
 iBEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775058466; x=1775663266; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kmB9aIaU6FDnNTOkQ+8o75AxF7qUsTKMyzO9o82yd2w=;
 b=LyHRCMjhbmTUNR1hft5CIyCwyCVd4aQmqTaVJFHgidt1Z9yoS2MvgUO9E8kovhoZC9
 4W+oo9nPJq1cF60VJp7YeRrj5qjedsRWM7HjE2o+9vDA/NohnjRAps8K/sAGC5PuZxe5
 TO0nx6UXI4zk8+2F/b5ur4z/An29FX5n8rvcvNn+nbWcH+Og7IqF5gUH6ah/yAjW7/oF
 7JNutcv0aPpZ9IZ1Fg4sTKi+ZRDK8S+MNJ6Ak3Qp06y31yAZyyLvLctxMUt8FkkoJBBN
 CkGXqRDaVplQd3et17+b11eyZpI2ZbeShsDmfACseGun9PVaIGyzvGTOw0KJfAUglCzm
 nbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775058466; x=1775663266;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kmB9aIaU6FDnNTOkQ+8o75AxF7qUsTKMyzO9o82yd2w=;
 b=ZmqrefmpkjluF7xFwk1A1Ryt3YEiGO27Bkxhu11IoOeZ0PwS28vpemcwpygQTx3MIv
 Y7Nea7072I2hs5oYJLzFcmSio8pnUQrCUBjvlVLLUdRCaBSuMrcR0NHr/b53dlaePlb8
 ulQdWstwlOVBdZLqCOGLbr9AC++wH1hjDpIYYSuueMqff18ZhC+dq15cm93KIjOSS2Gl
 N88jZHyDo5u4xKgJfEheqn3f9Q1bSlxS3uTCL4epUWJxW7kZ3LRRS7BUnzkD4uXSJJWn
 e1ILAVZHSdRDZ5Xxouth12KlYSau4cd6jIDFEPEbKtDEvI7/BK48AQVeg5M1dgqw5zPF
 l9mA==
X-Gm-Message-State: AOJu0YyMconKjLcRX4dEZhA6H579LdMxevpCZbXDLklCPS/Ef3u7EsY2
 ZQ9YERLxE7p8hIIuuY/c9Qi0Z3TfB43Xa3dJeuuLUVSOgWMnG7BCsKqWwLiRMRgPE+rbmutHzJV
 QC3R4W2Lh7i4aifK0WxT4oS53DusR3V+zQ+m4eL1Fvrn2PwIg3M5Nwfo=
X-Gm-Gg: ATEYQzzvzHm9brc0bcnDI8CPQSW+LmC3ltbg7/wRySUKc9K4gSW3hxKBeKCmEzzUNNx
 oAl5CSs3JVWCPZKMRlWjSNNCjPtHbZbxQvqMYa8P99dm940313s7rl+riMcPPwDqAJkTgP6gPiu
 33kcyPHoBoaRuzcN0wXweTrG0KtDlpivWUS6b5NsxHaur2ikBHEOVb9hgtmHhvLScCwMOXq3G2w
 +3H/3zpE/Chx2Vn/1Y1Bu4fLk0p60am3vqksRTOFgkv9JpG6Ry2izDDHF88+VV9C4Lmia3QtA62
 ViquqZx7LaX+kx5OP8Py+mdeG0vsz1HUnO4NAsUudQ/9iN5swVVzRzoAEvVAIK3WiJI=
X-Received: by 2002:a05:690e:1205:b0:64e:65a5:a1cd with SMTP id
 956f58d0204a3-650268b3a4fmr7348447d50.35.1775058460777; Wed, 01 Apr 2026
 08:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260401094848.2661985-1-peter.maydell@linaro.org>
In-Reply-To: <20260401094848.2661985-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Apr 2026 16:47:29 +0100
X-Gm-Features: AQROBzAlIQ0CKQe5s9K4oOg6VzK_Mf1B0lp2vm5DoigccxhH9PPSo-ODB8mdEjQ
Message-ID: <CAFEAcA9wD6rxUceNHAZmQ-a-730LjvkQiEtfevYugVKC4eDQJA@mail.gmail.com>
Subject: Re: [PULL 0/6] linux-user queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Wed, 1 Apr 2026 at 10:48, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This is a set of linux-user bugfixes that I pulled together
> that seemed to me worth getting into rc2. This doesn't
> represent any desire on my part to be a maintainer for
> linux-user :-)
>
> -- PMM
>
> The following changes since commit 6aeb397debb1c253901bbade8816656c29b63003:
>
>   Merge tag 'for-11.0-rc-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-03-31 13:41:29 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pm215/qemu.git tags/pull-linux-user-20260401
>
> for you to fetch changes up to 7e966ef38f58f91e05a46fdfda4ba63a9a1567d6:
>
>   bsd-user, linux-user: signal: recursive signal delivery fix (2026-03-31 19:13:20 +0100)
>
> ----------------------------------------------------------------
> linux-user:
>  * don't incorrectly sign extend guest addresses from mlock etc
>  * fix name_to_handle_at when AT_HANDLE_MNT_ID_UNIQUE flag is set
>  * update select timeout writeback
>  * make openat2() use -L for absolute paths
>  * correctly handle SIGSEGV generated when trying to deliver
>    a synchronous signal
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

