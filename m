Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B329DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 09:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we8Qk-0005Yr-52; Mon, 29 Jun 2026 05:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1we8Qi-0005XR-4I
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 05:37:28 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1we8Qg-0005va-KC
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 05:37:27 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-664db84f074so669181d50.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 02:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782725845; cv=none;
 d=google.com; s=arc-20260327;
 b=a3TgjAP4sLWvHBzfUr5mlY2HbkNCNJDL3VjK9bWmYbbRrOIjKUsze/Wkk4iVhAOsOa
 7q945SEdCI9pLY17B2Zjp/z9WtM5Tf8Csp00+agr7qMDBm/t2z7UoeLisgV6Bvrq3Cu3
 vmFp9jycjBnswmz8LyVC7jWoFlY86ZDX2l8jvGS5LHf7bHFfml3olA+xiK/TnC9w4K4p
 8/zhmp6kXwckM2lPS0O8kjep+0JZIGEHxsTKWmxr6s6638AyKYBWKFUPujYFHyldMpGa
 +6Fv5BL1vRIUfw01L4t7raj6SBmbps6pHW7xK7aGuP1/nB4T+pLgaMfQvHdD1c9f0C0R
 aO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=P7AVEPFLnRY/5u2ut8KHApVZxd4dZGS7HtC7IqvLc4k=;
 fh=wbWaoUxNiwPApdcl50AWTHimfnuCZP/jZKspepjhfYA=;
 b=FJKEQtjlzszb8Yk63nFIuIoG2/1jhS+LUTqUggbhHkMzt+9ezB/5aNP20AzuhOCHHX
 X4hxsfB2EwLLm21XcJ+l3t9xvlKDRd1xmT6zBdXHjylxs6HuxfLrSX9zY5HmZ33alU0u
 0kXg8CkBshWn1h7vSdSD5/jM4J5nT0BnT12gLVj1mjlMcQJDDvFV7g7zG4/i58CmCU9u
 FFdPKksY6iVFdbcU9vB80pVuWBKM8IU4oPsfFH6bNFRZ7BX6jcIKwJXSVIFdBtG7trrj
 jNk5zUmChkujq/DxfCSt2MV2Bg6grGTKrLH5mQQ0Xj2SsFP+cIUi0B84IVCWp3172c+k
 MHRA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782725845; x=1783330645; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P7AVEPFLnRY/5u2ut8KHApVZxd4dZGS7HtC7IqvLc4k=;
 b=uHBo7e9bgSbEhcU0cc4F1DzjY5e0xxTUl0oBEnTt+0Vs6v//lZ3gJ6+txWoPRR/qiR
 +Pdj7ECfSkJymgTzUks0E+cIpQ84XUDSXXH6dat9JGBOAmUbAR7GEjDHwc9LEj6lLCm/
 ESKY3Yz9jkEBSka1nNNjb3KESsAIi9drVPqXazk5SQdanBpkA/X15jeN9VmNFqzCcWwd
 tSw/6TfL47Llf1nAqnlKvwVODam+rjrGbcFIfSZUQ7cKav/kYVdiHi88a7o9acul77Vd
 m5AmD4JeT/mj1eWbXg5xBJLor+581QO5ED495sTddihMU10jknQsiH0s3IdOZeprnXp3
 noIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782725845; x=1783330645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7AVEPFLnRY/5u2ut8KHApVZxd4dZGS7HtC7IqvLc4k=;
 b=CLE/x63PuKwvvq5oxZdPNdqgjnkBPg/jmpzeF/5GFk+iFIr2d3wwpRImDzkoJ3YD3k
 zN+u1zEco3XvnsV+ZPPaev7gXbn4pc+z7IzQ08T/ileR6bwf2cnTSScDspgTbWR83siQ
 kLx9jTyht1les/5lwlYEIPG+bMbdvk0KC5pFl+rUgth0tvoVrucCJ9OCmj1qku925My7
 bbdFgVUn+qwMfI2cMoqr+lzTOd6nhca/8ak4DoNtR/V4XuO0fGm7TWqq6wt/E3QVRHCZ
 VbxNQ5eO54GgY80+OWWyOj8F0x5/mH/jq0B1ZTXF+VBWCQCjI8nVngtoUJ6/riiJ2izD
 xoWg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXyhy1Dhi+1OYZxWOTH3YRejoHSg3ZyDZ7e7XwXmlA3K8MqzU+mb8J0XKh+QptVhkRioAByNjZkG4y@nongnu.org
X-Gm-Message-State: AOJu0YwbInhKo0WcHDH4k+i0kK5p5yA2jWlQU655BDlHCoXKvjsPq3aj
 VdARUOG8Nkpf3zQquwJFs9gYkJJEY6CFpRaano5vV7O2srtEpejLVQUq7UESGtraU2ZqpWM2wgB
 xu9a/2SvszNPe/JQa7oqTL8Lz/fpjxJsWmil+5l82ZA==
X-Gm-Gg: AfdE7ckx3zvm4+6cFalkkmWGcMOyzOVvvlvfXnrmzIsY2rW9r0hHPruNYXuVeyU3H23
 SF2WVEuXJVOivxS8LWWLAE08dR4OyLKa22SicKJ8eU0MGELn0NXX/y7LsLKNVijNu4KuwtH8BBf
 7LodtKo0qDjck+Q1KvxK3iWRUcAj1FdzfRGxqavwm1mVjAFyF4/BR3RdBFpJ7bmddgrEfzFZN8u
 l6+/PfWrkYicRDqsRCZk5AqY4pd5XjAl5slZ/TWMqociTFXy9mAkgwDhuAOBWX6JCGaQOXldq9I
 5j3zpEu3kZmfWewhBlpnOz4/Mf1JYsHZ3Lt9g8Im4OjKMqhLd23l2LO4
X-Received: by 2002:a05:690e:d03:b0:664:e5c5:5b52 with SMTP id
 956f58d0204a3-664e5c563f0mr951436d50.14.1782725845181; Mon, 29 Jun 2026
 02:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_AB4D09097B1EC06F8C6CD11DF2C14E8A6D05@qq.com>
In-Reply-To: <tencent_AB4D09097B1EC06F8C6CD11DF2C14E8A6D05@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2026 10:37:13 +0100
X-Gm-Features: AVVi8Cfpo_Ay-T8EpJ4TF8hVnJqiba_UhYymKnRddg84THXEYUgpynKV6IIiVZA
Message-ID: <CAFEAcA9qpbF+hFpuYpqZrepozryA=ZuDhHLijYAZucumfAMkGQ@mail.gmail.com>
Subject: Re: [PATCH v1] riscv/virt: Add secondary UART
To: Yanfeng Liu <yfliu2008@qq.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Sun, 28 Jun 2026 at 08:06, Yanfeng Liu <yfliu2008@qq.com> wrote:
>
> This adds secondary UART device to RiscV virt board to simplify
> multi-core bare-metal development as Virtio needs comparably
> more work.
>
> Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> ---

Just a note that for other architectures we have seen the
addition of an extra UART cause breakage for previously
working guests, usually because they took the approach of
"find the first UART node in the DTB" and/or because
different software at different levels of the stack was
looking for the UART in the DTB differently and so you
ended up with e.g. UEFI outputting on one UART and the
kernel on the other. A particular trap is that the order
of nodes in the final DTB ends up being the reverse of the
order in which they are added in the code in QEMU.

Compare commit 5d8a250f9068 (openrisc) and e7100972f2 (arm)
for descriptions of some of the things we've run into and
the measures we've taken as a result. It's possible that
not all of these will be relevant for riscv but it's quite
likely that some will.

thanks
-- PMM

