Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02D3EF3717
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzeGg-00039Q-RN; Mon, 09 Mar 2026 13:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzeGE-0002qm-Ae
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:19:21 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzeG0-00065l-0x
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:19:06 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso14722698d50.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773076742; cv=none;
 d=google.com; s=arc-20240605;
 b=M2dgGcF+hHNeDHm/IgOJSBKwXFLar/8YAjiA2DL+pCwq3uVszqm4MzAid2zZu7U+dW
 H34Jvp3JZo52SgpselzX4cm8fw/VdexgRO5oGI6d/PyIHRarp7eJiE6RUaSul+xz2woc
 PAR09IHAoHIfGLusAO2O+sTy0810xax52zSXRdVJb25B1/y8kKqTxNLQ4Q64IT2Kev0f
 jaMX4I/wj3CaEAlBEREbwVMAX9VyvQWIV0Ukg+Kzm5aTtCOCOYQKkGOY6iOA0GXDgEGE
 Crk7etPAHQbzHROyhf9czyN/unVD/kCFGRF9pwunU+AihOz4cIJGYSCM5QiTSGkA04Yi
 lHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GYpFmHBT46R/83E68UmtkaJSh+72l/my4RpOp9Za3ew=;
 fh=6kJ3CohSxQ+7EgnARanNFMAgatAnP0uu5SOkx3O7QGs=;
 b=bPRFd1T/E+U+nckj14yz/SLRXfr6RH/4oVaGNrXGx9500ZAy9adoT+oLDWzHxvlkcj
 yDgYZHSTcIXuHC/ffscHKCRACPAo30MyLDPABGYpUkwt6B3uRCO1umUBSY8HAA7xAp2m
 yCjJk5Dw2+E/DnrQYM003pbZhhk4kug7A//rBE7z8d0CYD/3SN9FjpT89SSXRbRmpXso
 /e3jSkWBc3cAK//uXxb2hCuYbQ3c7Rd4nMPIE3Qe9u7B6Aa0wLmy/PUjwQsR22SUFU5Y
 4jglxgDPHwfzGn7s+wGSSwFK/VQ2czy6eQTKDA55EbApWreRTSpIS4u3TvpFu6VF+6Zk
 QRRQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773076742; x=1773681542; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GYpFmHBT46R/83E68UmtkaJSh+72l/my4RpOp9Za3ew=;
 b=lsHTEz6cBN1jDKEntoZk3LFpwvN6c8eqH6i6SJtDtu5tWOdKAt2qMrN6B916q5PK59
 r4XJOZ0bZwBahSAaqGDxRJxvTaTqpksPr3F1dQQUwubMacM9F3tYGZmmwGgu/SfhtfzD
 DkXrZENXP0F+MElUu+50NC71x8bSx9mOrBfsrXbZGq2nTy2IhPEPW89mw4HhZp1pz4Bp
 nnZSwSwWWcAbmclZw5WZR7yaDS5j9kezSVf+L1W2u5xNbAyXbBiPFRKhPid4z7Nf0xpn
 dnkfAlKDLLvkJtmjQUhhr8ybU/UvM6cZ/KjXtnFlk0pGW9j+ixptxqcssuPi07/6MAiy
 wFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773076742; x=1773681542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GYpFmHBT46R/83E68UmtkaJSh+72l/my4RpOp9Za3ew=;
 b=Iop/thGo6grIj9SCMXx/a0P5cM/B0oWX0Qie9tbriMyIo5l/erHh9fI+WPEmrRMKec
 LdTabnjeFGBnyA7iQQK1VA1bfXihRCPfjZ5ddS1MPRydATL7/z8xgD4oZIQFlPxaIrgM
 KJeC8pF/LVYkNrnYQdhRHtWAkvy7veo3veZj3yNjkzYIS7ac6j2Vw7iZZN5K7wUVRNyc
 Zw2HYSBY1A3iYpGhyJOHkMUQ4ow4vk8GgWJQVscVFhvjUVJy5R3ZwhRFFNCL0zLy5Zmy
 sGy3pj/47GECJ3vmAeFZG/K9M2FUGPXmcGugkc7WRrqsBBSerEb6ric5UdNjcdwWZVnz
 W5Mg==
X-Gm-Message-State: AOJu0YwbR3dmPpK1AS2aP18kqKnl0au17IC/LvW/MKE6/XXiLZjAdG1K
 7H9PPkGhdNCQVivGWjqpwM342OCiudm/Eckg80x2qjVO1eUMkW+tkx3RB4x19/6pf3/ZRIS9+e1
 FWmZdhhbrCFSnUdVR4iUHyi34C2pDoxvPYvv0xzxUQQ==
X-Gm-Gg: ATEYQzyvgey/pIFB5Arw+S28Tf1kTab/GSYiRRe3a8qchfbSRyCJOn2BdQauJkk116k
 WRCXqD3T0yAd/nr7XO8iOUaIWMIoRMdh/jFKgm73ghHFn0dqzUDto3GBwWAbmSB39ERxogZDRTL
 jBHMiIa7yorp+lrYUopN7IP1x+uEU4ZLU7lnIxYvbe5l1TvT+n+p4eb7/2FkAWMTR72soKoAraw
 05NLwvXb4eTGwfYzyqap5S+nuJD+M+9JmsgdGiIvMjIALpCbMrKCWutJxBqD6BTzvbGqd0gSVm5
 Bu6gf26+5IRldjTu9GbZBzDofeY5JNvtjhv5YehRB2UFbd5uJR8injNxBsIzW9A2hLM=
X-Received: by 2002:a05:690e:42c9:b0:64c:ec30:9dd8 with SMTP id
 956f58d0204a3-64d5a2545fcmr265568d50.47.1773076742155; Mon, 09 Mar 2026
 10:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260309130730.20526-1-farosas@suse.de>
In-Reply-To: <20260309130730.20526-1-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2026 17:18:50 +0000
X-Gm-Features: AaiRm53O3Ba-9ugEemErdjGtAyKxjCWB_MISsSzmugW9GhB6A4M3mgvcFMHATsY
Message-ID: <CAFEAcA-kDs5i0ZwUQRe89iFzVWjbnjZC9cLv30BUvcQxMQ87+w@mail.gmail.com>
Subject: Re: [PULL 00/22] Migration patches for 2026-03-09
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Mon, 9 Mar 2026 at 13:08, Fabiano Rosas <farosas@suse.de> wrote:
>
> The following changes since commit 1ae4271ab8dbfbf5dc28b36baa7f3fd5fd2215e1:
>
>   Merge tag 'pull-11.0-virtio-gpu-updates-060326-1' of https://gitlab.com/stsquad/qemu into staging (2026-03-07 11:22:16 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/farosas/qemu.git tags/migration-20260309-pull-request
>
> for you to fetch changes up to 161e6039759a77debee9434ee55a086c8a85ed60:
>
>   colo: Reuse the return path from migration on primary and secondary side (2026-03-09 08:53:34 -0300)
>
> ----------------------------------------------------------------
> Migration pull request
>
> - Fix for races when migration starts again after a failure
> - New maintainer for COLO: Lukas Straub
> - COLO cleanups and bug fixes
> - COLO multifd support
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

