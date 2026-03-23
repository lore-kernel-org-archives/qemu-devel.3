Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12CED58CDC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 07:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ZP6-0003Zj-Pu; Mon, 23 Mar 2026 03:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w4ZOz-0003Yd-F6
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 03:08:41 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w4ZOv-0007Rm-DU
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 03:08:39 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35a09e0dd63so3333150a91.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 00:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1774249713; x=1774854513; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LI5DXV3oouboQF0d9YftaaQ54rAaiqWPU8A6yhB3CLQ=;
 b=WYqf2MTnjEHYd+SWMHLJVF73B+T2wrY/5Uu8av4G0hoB8zXHy816/bPJ4qhE6hYPKT
 Exlyq0QKV85TEUn+V8CGc0gbMnwF1twrLPvd9CVGOwyTJLbjwh99bVfii7V8A/02a21f
 MdfP3oZok0O/YI7j3IkoPgoL5VgcwnXL6ZJkAFpxcDXLAlV60frK9GY/JtsWVjOdrKO6
 YIuHmbWbar/cYp8bj+qw1ZpyNBAymLaoZUJk2I2HJNrwCXd+1Wn9qbKtDmE5O7YsV58S
 /29zIM9mSSsOYgipcDnW+HJ3hH8mYCctXXd5jO4UDq0C0220leK9BUqzwUQqGXN9A9yk
 OwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774249713; x=1774854513;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LI5DXV3oouboQF0d9YftaaQ54rAaiqWPU8A6yhB3CLQ=;
 b=OLnIjCrGiLCwkpaYKS/+K1HFD6eIuHYpr/VJ7/8c/sgA2Vx+OnpfiRlcC7JdAbx7zC
 14u8lFbRejQro+Csj//UisD2vxme2S4KAw4lRbPHm3HmzMuCMgdxHVoyTp1iANRVlh0b
 BCfKgPL38FErZFOKYueLX0gGKZcKj/LW6z7XNisuDC51DljoGGg0GOB3fY8fMYRKbTVS
 W0IZa9TTkKrcjnS2mNGZABEvVtu8XlCjrWEMiOosc7bsQz8ssv1hFFCDYrRO5hQfcgRX
 OyuCGYWLtQJX46KY5/v28+LRzdYo/8BJzuwQuD3iDCQmY5BpNQBaY/qwfOdA/V2bdJKP
 xCkg==
X-Gm-Message-State: AOJu0YxfNHah7VttBM9PJLQAgJvqB0LThP4KwPeRXa5c4lPjtSW1o5NA
 5E55zk7ZCiXVc+fYxPKrK1Bq5GX4r2uuYmH0QYhV6JnQsajCJ30h7IQ3jAeaoZXTThY=
X-Gm-Gg: ATEYQzx6h+BX9roz7yuYUdHfzdva9Z712z4meePYjZOqI1P9uzEMjvvbiW3+dSSPflA
 9aOdys6K/Fu/celkIgHcW1GpgbZWKMAor1nt0zDzrgQG2kSG4S2bN+ALYGnXy6nadToBmXVofqO
 dmgZYWzjzVFp48cyD9YLNwPiyK2HB+kZTEkBZJ3x/Zp65i7mt4cMA1qWiEDAy+1BT590U71ITtM
 VDjyYVNL1f8BwGgNhVhEBC1zWYquo3Nmf1abouda5/UVUDPq3fWalWNs07Jrat/3D0FC6WuVHjw
 H/uvEI9dWduVS5/1arYO8o9+HAZQsSryq9zg2UU2SU+sbDimhhFvEmNgiQGfiq9zJH7TIjW7v9y
 WLci2cLlYJiETZD0FeHyJc2W+uY3afKrwoZ3T7FT+pa2BnaXKvsj/bcFEGk6bvOUqYNqST42a+s
 rKM8s/UeC4qXJRxKrP/9LqkaXxwXXqkl7vf+f1c/vSTr7u0Dp/rq1RoQ6q3yHYQjFW
X-Received: by 2002:a17:903:11cc:b0:2b0:6263:6a05 with SMTP id
 d9443c01a7336-2b0827e9302mr111651595ad.51.1774249712895; 
 Mon, 23 Mar 2026 00:08:32 -0700 (PDT)
Received: from sifive.com ([165.225.234.181]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516512sm97721135ad.17.2026.03.23.00.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 00:08:32 -0700 (PDT)
Date: Mon, 23 Mar 2026 15:08:29 +0800
From: Max Chou <max.chou@sifive.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH 0/2] Fix probe_pages and vext_ldff issues
Message-ID: <acDljtkBJTxOMqfk@sifive.com>
References: <20260318013805.1920377-1-max.chou@sifive.com>
 <9843f984-b58b-422c-a823-11a497510709@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9843f984-b58b-422c-a823-11a497510709@tls.msk.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1029.google.com
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

On 2026-03-20 23:53, Michael Tokarev wrote:
> This feels like a qemu-stable material but I'm not sure about that.
> 
> Please let me know if these fixes should be picked up for the current
> stable releases of qemu, especially for 10.0.x series which is currently
> an LTS series.
> 
> Thanks,
> 
> /mjt

Hi Michael,

Yes, I believe this patchset should be picked up for the current stable
release. These patches address the issues that were introduced after
v10.0.0-rc0.

Thanks,

rnax

