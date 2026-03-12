Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3C1105A576
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0e1q-0003wC-0R; Thu, 12 Mar 2026 07:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w0e1k-0003uw-Rn
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:16:29 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w0e1e-0007lK-6H
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:16:27 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c70e27e2b74so342772a12.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773314180; x=1773918980; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fmwCiKOCWISEVRto2kbTtfBL6HyGBUtDCFUQrpc3qhc=;
 b=mh/1vHZMb18HjLRuubCBFaaiG65cu9CWbJBHh5XWvvKprvs2yd811A85+p1n3pcx0L
 IwcESsho5PmPlRUGk0CLXjTF+ZUDpuxN2eM1nJP9lcWmIadelF88DJ1lz5AVTpBAfDk4
 CLZ7/ORRWXdouB8PpzCGLke49nemhe8ZNnU1Y4tAJkhoEDNxT6cFY53cYR/7aIExvgrq
 ffnDUPNoQbAisxRIwN7zBF1e6BBBpJhFVpMyi+Vm7QuzqxIBAGxCbhT/TlKWdNzJPEyz
 MHnSDUq0Oym67aZrhUcSmP6pEgRnUcnbXLSbdzjno4MiuWfeqf8Cr55EMvBwRPpDjIFq
 Gb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773314180; x=1773918980;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fmwCiKOCWISEVRto2kbTtfBL6HyGBUtDCFUQrpc3qhc=;
 b=viYccfE2GUriIdcCjovM3bwFIimZA9mXHOXreOt+gH2u+37HKB0GyEoce5B3jG7Ads
 879Bt1h6Ihe5smCLKXrKL606Ez7kbR4ULvDL/8RMe9pMDziAH+GsNe6C5fdFMWUIYHwS
 UJbye5UfGlsJE0O7wtICPsnGkMohU7tHPFOlKktelxnpXtKfebRNFI75zGjwLKPjHB3x
 ZTZ52L0DK3cwCcE//+whJMcV2CNIfm7Dk0mmW0N1q6lRiaKN0KhgX2NeOjTx0jPcSnKk
 V/TiduSEmVPP1oRYaMp9Jax3S9N6Lsff4epU628PiNdZv3csIdd0RLkRU50DViBnN4oH
 nSwg==
X-Gm-Message-State: AOJu0Yy6lMq2Twn6a0Azs+SzkPyg8Uq5IsXhugYuuoCij5UHrMY6sk+z
 1ASpYcziYYqyqCru/KD2Vuk9zHGC2n29BCSM9gsDIwGqA07mxkynRgEJOZ0kvdeG4Mo=
X-Gm-Gg: ATEYQzxABfKMQjWujEl6CkmvnQ8h9LNoCrXCKzLzROLo0dKYBsG28v68cHBaM4Bmv5P
 w1OzhXLcyjYDBq+N9Cygn3Z4WrvvvX4mWM3PciZjpn+Uvaz1z9D2376k6DXzcq/+l9VRbaQ+uRF
 NgD9FmdqFfmyHEZsnJ2PhOV+lj7JYIE2n8Q7gmf6ryhKM3OPQVZJfwUabedArgGQt5I2fOYxjR1
 C3T2ZpY0a2jiYA90/5K6rjhT9Vx9ixRGhbTovC2HDLEme5MaJ4f9B+CQI9KIMyoNwOvXvTJaHsj
 DcGHwOrpbnvq5Sz+fRMUCGCRHmgj7+gGBGaTzkFp8dCSVVZ4n/Nd/QO6JRK6i8R07TqPm7BnBOY
 9AHX7tQ0e9uUt//T4+vJvKHZjNE54lwx/VQJPTLc26u0j6/XITDcROKVN7LQA/Nsku27bVNhHaa
 VP/S8f78CJYeXMiV3C00aCmvoT4ntp/lHr7HoBaRzqSIvguL5yG0/PUW6LS/aX19vt
X-Received: by 2002:a05:6a21:9d84:b0:398:9ce9:6de5 with SMTP id
 adf61e73a8af0-398c60e4360mr5733880637.43.1773314180231; 
 Thu, 12 Mar 2026 04:16:20 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73cdf204afsm5058326a12.10.2026.03.12.04.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 04:16:19 -0700 (PDT)
Date: Thu, 12 Mar 2026 19:16:08 +0800
From: Max Chou <max.chou@sifive.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [PATCH v5 0/9] Add Zvfbfa extension support
Message-ID: <abKfuTO7zg5d67E8@sifive.com>
References: <20260306071105.3328365-1-max.chou@sifive.com>
 <CAKmqyKP7VKi21xfMAiKi9nmAGaaNdrtH9u=6ktCbWBk7kiRoJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKP7VKi21xfMAiKi9nmAGaaNdrtH9u=6ktCbWBk7kiRoJA@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x536.google.com
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

On 2026-03-09 14:51, Alistair Francis wrote:
> On Fri, Mar 6, 2026 at 5:13 PM Max Chou <max.chou@sifive.com> wrote:
> >
> > This patch series adds support for the RISC-V Zvfbfa extension, which
> > provides additional BF16 vector compute support.
> >
> > The isa spec of Zvfbfa extension is not ratified yet, so this patch
> > series is based on the latest draft of the spec (v0.1) and make the
> > Zvfbfa extension as an experimental extension.
> 
> It's not only not ratified, there isn't even a draft spec. A personal
> GitHub repo without any tags or releases is not enough for us to take
> this unfortunately.
> 
> >
> > The Zvfbfa extension adds a 1-bit field, altfmt, to the vtype CSR in
> > bit position 8.
> > The Zvfbfa extension requires the Zve32f and Zfbfmin extensions.
> >
> > Specification:
> > https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfbfa.adoc
> 
> Overall this looks ok. Once a draft spec is released we can apply it
> 
> Alistair
> 

Hi Alistair,

Thanks for the review. You asked for a pointer to the standalone ISA
spec repo for Zvfbfa — I want to explain why that doesn’t exist and
where the spec lives instead.

RVIA changed the ISA development workflow: new ISA specifications are
no longer developed in standalone repositories. Instead, they are
developed as forked branches of the base ISA manual repo
(riscv/riscv-isa-manual) and merged into it upon ratification [1].

For Zvfbfa specifically, the official spec artifact under this new
workflow is a PR against riscv-isa-manual [2], incorporating the spec
text [3]. The PR notes that the spec has passed internal review and
ARC review, as documented in the tech-unprivileged list thread [4].

PR #2743 is currently open, meaning ratification is pending but not
yet complete. Under the new workflow, merge into main of
riscv-isa-manual is the signal that ratification is finalized. If you
prefer to wait until that merge happens before applying this patchset,
I completely understand. Alternatively, if you are comfortable
accepting it as ratification-pending, I am happy to address any
remaining technical comments.

Please let me know how you would like to proceed.

References:
[1] https://lists.riscv.org/g/sig-documentation/message/275
[2] https://github.com/riscv/riscv-isa-manual/pull/2743
[3] https://github.com/aswaterman/riscv-misc/blob/main/isa/zvfbfa.adoc
[4] https://lists.riscv.org/g/tech-unprivileged/message/1031
    https://lists.riscv.org/g/tech-unprivileged/message/1085
    https://lists.riscv.org/g/tech-unprivileged/message/1109

Best regards,
rnax


