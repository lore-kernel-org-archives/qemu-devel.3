Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CFDC5DF97
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 03:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyLNM-0000BF-Fy; Sun, 23 Aug 2026 23:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1wyLNK-0000Aj-Tk
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:29:30 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1wyLNF-0001jV-Sp
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 23:29:27 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2ceeee8c46bso6393305ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 20:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1787542164; x=1788146964; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gW4/EZVhjXWiC12MFKyJb7aywhdXSmswIbcklE+XDgI=;
 b=BlFizvkBqwiD5uyxx1MNU6SIjGjBcCf9vMHbHIpG1Ez4QlwJk2QCJscI6SM22If4Dw
 9ja+NaIWYdNRsD5pCFj35gFSLAZqFdDPO8zVM8Ya5PvxPGQpA39CBUKO2waxD/Xv/y4D
 Yr/eOAAHleqFqoX0Yc1Em4xHszZLMxJH/zsr6f/o2Ps62gwxMlAH7eZG8JFlKRFMBZrd
 RMHzXinuy/XJVOJjqcIvxnkKMaohQ+gH5KRvNQlFgYyy9LstCzaiZu/pHRFhtZqzY9lL
 d9y4qzHuelPnJYZ/oqKlp2o6JPHU+gF89tlBXl9Z7rDW7BHa3qvP1xRQGwpv1s4ph+v7
 v4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787542164; x=1788146964;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gW4/EZVhjXWiC12MFKyJb7aywhdXSmswIbcklE+XDgI=;
 b=K+8KgipxSEWkUMbKoIU+UNi5UMkVDxxG+qNLzSrForxPkYmlf6PzZSKieF0N0O0sSx
 oIhRPTYwxmgp1eT/jy+OlYa4QYUhymfOiBzQVSWCPNSjAsr6i01eUWeHKyX5w871RMy4
 vSCT7/hzVggoXQte0zI4qR01sWnb2D5eFx9mh2Dw3W6QcLBlKYnKIp0GWVR2+iEBOKsr
 v2ft2m32WZZ1dYwdzkbyHPkn8TI35XCpwT5TrUX4bgTh+L0wh75AuC+iEzpDAqktWNB2
 KlZ5xgw/q85NemrMHgVtM+pgpZET6u0q0/35xb3jLGO7Wjh+/QL1gJLlJR/GGP8mZqpr
 ORLg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqYHlvCw/8Bc6HScpaaNmKFP6E8Mit8HQBtDZDWf2MF4hUqHvI1tMAIWsSoLhnYhjHAnOF3LVZ+BEcY@nongnu.org
X-Gm-Message-State: AFuF++kSHoj9RCOaTHj1u6f8Gi/MgeesuPinE/T8SLKY6ABoZoLFTkum
 x0MbEIm22zK2byv3aFXZDACQLIrFizMzxt1WGbA8sRe1p6s42w+oHYAK2IVe368hh7M=
X-Gm-Gg: AR+sD122bWe+6vFmYUaUM7xJa4+G6eoC+nhM8Vn8SPY2TC/Ygl93QQkuYxSIym4smu6
 6VHgLh214Thwy6KqWjwqzXyd+W2aUVUxl04/nooSjxvTMGTruChEek9wPhPOUYygQUS66QXJaTJ
 RBy0SZOjupB6x/uwZWZu9SyTpB0/zDXZ0/VsUk8jSJ2T4OexM2Gwt9KBlvJBiOkZrURd1o4/U4l
 bPu9yYwhy2moxh74Ig7CLYJYoZfPx1RyeI7aeGreregkbHgdrhsFXgwirWUfukIA8imYAuEXY9+
 5TL+uz4Kxw+6hQXJBvvn5lipIGdNZZpOYGIQkUNursOLxXWrCVPYvxyhdJvVLCwh80o7l4Vogzn
 Z7KQkeqqxqABlnp8z04Y2tLXecz3uwVK6BYCX2Q4Bbsih2riBDol9i6PpykyO/Z7zit67e8O0Ow
 FLNCFq6QozrqU0IsagOyDTYnRtCFiJxnW49pM/p5MSTfVo7VEou9PhShC35ftpBTe6uSrjEgwLu
 GrsRHF1eKZ+Z85S
X-Received: by 2002:a17:902:f709:b0:2c9:d298:6c0a with SMTP id
 d9443c01a7336-2d64b047823mr216922115ad.2.1787542164383; 
 Sun, 23 Aug 2026 20:29:24 -0700 (PDT)
Received: from [172.16.1.33] ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d37d9sm22480750eec.14.2026.08.23.20.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Aug 2026 20:29:23 -0700 (PDT)
Message-ID: <debde646-6ec3-47de-92ec-ff9d1ce56ed3@oss.tenstorrent.com>
Date: Mon, 24 Aug 2026 13:29:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/riscv/aia: Check for invalid IMSIC configs
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260824030509.18078-1-joel@jms.id.au>
 <20260824030509.18078-3-joel@jms.id.au>
Content-Language: en-US
From: Portia Stephens <portias@oss.tenstorrent.com>
In-Reply-To: <20260824030509.18078-3-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=portias@tenstorrent.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 24/8/2026 1:05 PM, Joel Stanley wrote:
> Assert that the IMSIC layout will be valid before creating the devices.
>
> aia_guests is a command line parameter but the machines that allows it
> to be set (currently only virt) should be passing the correct stride for
> a given number of guests. The assert helps catch bugs in future changes
> and shouldn't be triggerable by an invalid user config.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   hw/riscv/aia.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
> index c33a3b32bd45..c1a5982856c5 100644
> --- a/hw/riscv/aia.c
> +++ b/hw/riscv/aia.c
> @@ -43,6 +43,10 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
>       /* The RISC-V Advanced Interrupt Architecture, Chapter 1.2. Limits */
>       g_assert(num_sources <= 1023);
>   
> +    /* Prevent IMSIC MMIO regions from silently overlapping */
> +    g_assert(s_imsic_stride >= IMSIC_HART_SIZE(imsic_num_bits(1 + aia_guests)));
> +    g_assert(m_imsic_stride >= IMSIC_HART_SIZE(0));
> +
>       if (msimode) {
>           if (!kvm_enabled()) {
>               /* Per-socket M-level IMSICs */


Reviewed-by: Portia Stephens <portias@oss.tenstorrent.com>



