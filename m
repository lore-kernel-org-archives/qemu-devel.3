Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE551606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vXtNjArk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM3IT-0004CM-KW; Wed, 28 Oct 2026 09:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xM3Hc-00046F-NG
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:01:44 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xM3Ha-0004Al-VR
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 09:01:36 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8ac9d666d4eso7996447b3.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 06:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793192493; cv=none;
 d=google.com; s=arc-20260327;
 b=I8I8CoNRU/j1sXp1YFsKnMhx2AzgSOnaWg3td28BQGqXLJFSDpGoRKzxN4A2CMT8pz
 TAO+/uufvLRI3iaiG4BrxzKEOXdC8iptbhovl+huq5PBiSZHNjNolsX1bXbs1JZn8yxs
 6IPSWYkMROd9Q3MyNTj89eyUNx7bpNbyYa6Lf66oa8kpJ2NDPY1WW9BWNjnw5W+eqgwo
 YPCQB3gkbWtf1R2bhOlWl+Dw34yQcNhUbUdPTp0eQjdx5nUYCLjqkr1KIDDLMNL+yDIW
 MOgOmmPn5vQ2q2cqfIQubwwu/Mao4sIOliFg/z4KL5FoCWDtazzTaVCclNDRv2Z12Zgo
 chqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fZg6f4KrLfn7joNSBQ6CYhCigv3VSj17jUoJg/q+lEk=;
 fh=6kA7zD1fEbjvrCBaI6MtrsnL+a6Nmdg7AZiPql1yqgM=;
 b=BOJB1qM5jhxqvlIS5AXDjo+KXfZaaa7Ru8t9+dPxZ8DxO5I9qDh+HR2arBRPhEAhwK
 EiQjGH6vuAs7BsmpH5+/fnI2uAJshUIC3+E7MqTNRH/Vu7/IngUlamvDCYF68Uyzb0SE
 mj1+tii34Xu5SRjIwhMXzLfLgoZvvAVx+mR4+8bZxzaHMCgPFyyzgyD+MAP+l5jlb6Xi
 RBTvp2u8B9X6Kkawlbr9pbs/29W5IzJ7wtDy2rtWv4InrBit7NJwIRiBhZjZakBoSkxO
 bsVpihZeFmme2PjmYVCSJBsxh/0Jss41jSIYtr/GtVhI64UcdR4z4h4XiQx9bhbJycsC
 N8hA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793192493; x=1793797293; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fZg6f4KrLfn7joNSBQ6CYhCigv3VSj17jUoJg/q+lEk=;
 b=vXtNjArkY2FItXcKVWjlyfn+ew9EEj79P04EK0434EsQM+suaFih6QpSzHhwFMEJ8+
 U4iJEwUS46N7HGL83lG81pz8fYuXQ0uc4v9CxPKXDZjo76ToAa+7zv9UPN/FlaRL3yID
 voEWdUCaslIpcrZNjhEqMpLGaJl7gd0FTwQg0+1u0tUmTngKi4Nj3qzBkYX7CMRnHAO/
 vwxY1hbEXJr1kZK2bfWI+8aMqu5IYTs/Ya8ePLjyjxvpdLfZUe9AKZerZLz6Ldbkgop/
 /j5XcXG+csElz5STAQcwYzItmQwK8RLLHdWC862SEyF/Gg8l9bDCWJPgEv/CudFVkb79
 ZZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793192493; x=1793797293;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fZg6f4KrLfn7joNSBQ6CYhCigv3VSj17jUoJg/q+lEk=;
 b=Cg9ic/2jTMeBmoL9TVFpHahNv3MqVInufHbV5ILfBd9kkiuaj4z9Qm5kmXAbvATjrE
 ZnqBOZzTBfr2BVV1o14awPHnsyjtIRTfawIvNGy0KkcLo0w8SlKzbcAOixpsH31DvJHF
 wV4pBrjs5wfdKpk6r444PO8XfvZ/uXN/jqh2AHKps7iTltXK0Wjjw9eeQPhzrjxlbYwf
 WVc9998BKBr1zsDB8OTIy9XRehjJiZxj5ljF4EugqkHU9Ntj3COjBqBKA9wkHrhBkCmb
 JzH22+vaWJfj4Ji0zbV/QVZo+u++2VlegWFiupyhUWZXqFbN+1rmldF1VHgfMnvNk0g7
 mm7Q==
X-Gm-Message-State: AFq9FYJAscI6uJp9NozohOPIrH77xuxPdahqi7ezN1CaqZwyErK3sO6M
 ZhT6z3KQVlAAWTI71bKwbSx03P0uhDefScrPdDmEidV/S5Ez0sHnIdO8pcrHJ3K0hgMkGtcmdMN
 yK9FNI+tTj/9XfGPgUaDt0Xxs8gy1qW7Fd2q2/2NAapoP9Dy4Konhxo8hHg==
X-Gm-Gg: AYBFou0mGRg4wrco3gBydqAJY1YbWpN11xVD3u5h/uGTrkh2NEHi89hjWlOTkwlW//+
 yLgeZ5vL3/8lurSnQfhxR+WDpSE6vbtfPANyZz4R7REVs++goHMU++7bixCEzSaDCUYp8Yr7Y+I
 0zM7rB5HelN+2DVsiMfUs3ksrY2F+btxrlJ3T6nzTqGzsKfUVWUVpImgrZGoUETktRHZlXUpLtb
 24KbeqgmkvYUU+e9toPAGghdF9GhhoYl7p243rnsO2X6N3lpRNURxzqA2QecZVv7UusJk/34hjv
 g1PUQzqVEX81wQ9dUmXwVfBHtLwFsXBNyZG3W89xGZozQPKWUaY6dh66lpBxpuScgStrENHrB5e
 hb8OHiCKiR28yoJJSq5dibrb8SNB/zKK1FWugyrh06IIG0qB8PQN/sTdCf2LmP5Apl8CzVeiepH
 WhqQ8gZxPusZjriwJ8IpYD
X-Received: by 2002:a05:690c:ec5:b0:8b0:cd30:ce86 with SMTP id
 00721157ae682-8b1b5ca1240mr14369037b3.78.1793192491836; Wed, 28 Oct 2026
 06:01:31 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027174625.4025878-1-peter.maydell@linaro.org>
In-Reply-To: <20261027174625.4025878-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Oct 2026 13:01:20 +0000
X-Gm-Features: AclHuK_Z9vADds8jxMY9NyleyR7fnceQqPk0dvKETScacgyV7uKcn_L7sJ9XuG4
Message-ID: <CAFEAcA8+PtkOn=2FP_OTT2s=eL--4Y-51gCM3w2SOQn1WMDbxw@mail.gmail.com>
Subject: Re: [PATCH 0/4] net: Consistently pad short packets for all backends
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowangio@gmail.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 at 17:46, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The net core code design is that by default packets are padded out to
> the ethernet frame minimum before being handed to a network device
> model, unless that device explicitly opted in by setting do_not_pad.
> This avoids a whole class of bugs where network device receive code
> has to be very careful about handling short packets.
>
> However, at the moment we do this check manually in the network
> backend code before it calls qemu_send_packet() or
> qemu_send_packet_async(), and we forgot to do it in all backends.  So
> you get the padding for the slirp, tap and vmnet backends, but not
> for the "minor" backends like 'passt', 'socket' and 'dgram', or if
> you configure two network devices connected by an emulated hub.
>
> This series fixes this by moving the padding code to
> qemu_send_packet()/qemu_sendv_packet(), so that it always happens
> regardless of the backend.
>
> The main bug this is fixing is
> https://gitlab.com/qemu-project/qemu/-/work_items/2362
> but it's been re-reported multiple times for various combinations
> of network devices and backends.
>
> The whole series is cc stable because without the padding you can
> provoke various bugs in different network device models.

This has now been assigned CVE-2026-118490.

-- PMM

