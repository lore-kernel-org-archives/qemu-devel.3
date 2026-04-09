Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCA1E9DE7A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAlXG-00056h-7X; Thu, 09 Apr 2026 05:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAlXF-00056E-2R
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 05:18:49 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAlXD-0005jq-8l
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 05:18:48 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64937edbc9eso599250d50.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 02:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775726326; cv=none;
 d=google.com; s=arc-20240605;
 b=eslG45Ofw/F6Nwo0IB+Q6IOyjU7O5CSxlDDpgS85QYUrwIw75aUjMPySPidAPYcwzG
 Xcn0kz2N2K0Ih1QHtDOO79q9K6Y3Sk3xx9bKhbGZspfq/e1ttOvuGopXcgictpTXy+on
 uKuKHIxmnk8FnpHGB4agdO/AdSRXegPt25Ree5Wa79gTxngrc0Umhv0B/WNEgpmoVxoH
 w2MxqZSzgz2OpmDXGSR4YMjcX/AFloM0MqP95Ob23VLozJFnSiVCC0Yj7ITBj8Yeny2/
 57kJh0XxSmFpFy31IimPEM3sgUjqEyAX9EScEBMeH5KrT3mLawd2V62qyc9LagzVZGAJ
 DDqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BWegvmsqAEMLsVg7d+5gDL/Xyt4tYWPMAeL182yYasI=;
 fh=ZKds+nUgoQEsVQWyLb5eyl+oP68VH/5k4ombeful5ps=;
 b=W1yL9/x6Zpre4Fxms8njhjT1fRnLjnFtwl4RjJxlpr8CNNHoQuP2d4A5F/8ya5Hg3r
 Nq3o/j3I7ZjJ1WSnGXmvBW0AzoHXavzUNBpwZANFDxQybhDjDF1aQZRuZkwa0G2MKglY
 D4DDkj6/eIwEETJOAbPdcRngMVS09+Mtm1xxdVPTVu1AktAByOfvWNu0ClNrVQZNuxKD
 HSpUfesFZp2QcubZrumzJO4A//MkycKY61sjOHHqeMhEjeiPTf8Au+teVADdaYfHCCih
 NRZotoKWSYKZu9sd19vGP79LZQhTTDmtryqwN11zy/K9NzHg6a8lBS0zYe2jVWyD0AFM
 DR5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775726326; x=1776331126; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BWegvmsqAEMLsVg7d+5gDL/Xyt4tYWPMAeL182yYasI=;
 b=F0kclfwWQCauXZryBl3nwsZhBle4ki1f/5qNioc83LrCFtR4AeqFt/LpmuDt/D/KsS
 s8BC0Hl2LF0B3fzFS5ScxBb61hrWVuEF4ggp5LwQvh4T3IhluNC6+VpifRmldMPCJh5y
 dUfFUWtWgjBRUlnHRNHrX15hoNQXBf6g0KZBcK46co70fs4hRi4To7LjnTxrJhKfbqQD
 dZgIdv9tPDtfHtqa1w2izP4dfgf6b1Ta5EMYBY5GnILYHyK3CmRc2UdTPLBv8uJCQ8J3
 YOfdRoxoPTMIo7idP3PXinnkTXrGhPXnkNicV3pNGH5oZkSUOFpdL8Fv0WGCT/hnvwOO
 Egcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775726326; x=1776331126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWegvmsqAEMLsVg7d+5gDL/Xyt4tYWPMAeL182yYasI=;
 b=g6Emt40AB+GZY+PdHUFHUD9lUwIH3tW7lR4wD8tJkHUcc1XMdEZdFRaKc/mIgWWzfj
 naIYgIUZJnPF9X56FJv3f/6/0IsBFkxc9bDb2D6n2P6QZgOgC/wGT+v3kCNRK22xsj4c
 lZ4ynCEncgVlcEKRHAadVoI4qXckF0S29gBEua79NdzwDdubLdPhSLw6ElnOKQqpl1Rd
 lQMxk8c6ejpg6xTnRFJ7tUXaV+EajWC0DbwqFcYo5Y2K/MR3nMM6/pdMynq9f2okPaTh
 jTgAewQt/bWAWGi2rQXq5EjxW7jRKXq+CFbLZMl/3hJnhtRU2Ng6li+osRrnin/L5aa+
 p0fA==
X-Gm-Message-State: AOJu0YxOc5/3iDzXVBheRY8G5yYo/ic8a0/0rnK0NNNjAC2a0kAXf3pf
 VgoSDKT09srpKP7qWgujQAq0GHxZEkZ08h+caGWAFCYzLi0ts/RhAtzsScArN+1agRDDRkvRR9M
 +gG8oKffzPhD1q9cZVT5a7vANeGNLBf8APcyf8KGGDQ==
X-Gm-Gg: AeBDietMhnAZMYCtu9bHD2Zu1nv6j7o0hLAQdBt7EJf4jSQAdCOzuMCmZv4OHmbksSl
 yqBBP6TWSoc9vusRSM/CcF7w6nKVJ7wvnXvpbiJ5+uY88ZSvuJNHQWSiv3zZAWgxjvKJeX5ez3v
 dt9SRBe44PAJOZqNeOKe6Mga9Brg28Udlh5pfwphf9hUuN0fODqByopFZU01EE1jNU8Hjt5WZde
 1/PEI4r5dB8a+fx5PWWbJsKHm62hUeAXWnS6CM3yFbN33VugJ4zYYJPqnq6dMtpEevpHRHQ+X8u
 RxvTMW2KjRVdl8ySDDhJuUi0429Ahp9S9rqGz7Y4i/ah6tocP56cF2O/xl1sX7EmKUI=
X-Received: by 2002:a05:690e:120c:b0:650:2ff9:d654 with SMTP id
 956f58d0204a3-651875febe7mr2331592d50.26.1775726325932; Thu, 09 Apr 2026
 02:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260409-fix-unit-address-v1-0-946840930af2@iscas.ac.cn>
 <20260409-fix-unit-address-v1-1-946840930af2@iscas.ac.cn>
In-Reply-To: <20260409-fix-unit-address-v1-1-946840930af2@iscas.ac.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 10:18:34 +0100
X-Gm-Features: AQROBzD7PAoRbJQCon-foLQnsOtbREpfTbSOaPoZYJfzNgUoB0OdCB2YWscPhqs
Message-ID: <CAFEAcA-GMDdeY4bMQfJLVbHBdwqn2rr1K8=D3YytZXo+r3G7NQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] hw/arm: Fix unit addresses of FDT CPU nodes
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Burton <paulburton@kernel.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 9 Apr 2026 at 07:40, Vivian Wang <wangruikang@iscas.ac.cn> wrote:
>
> The node unit addresses should be based on the reg value (which is in
> turn based on MPIDR), rather than some arbitrary number [1]. Also, they
> should have been in hex, not decimal, as per de facto convention [2].
> Fix them.

Please don't fix multiple different things in one patch.

In particular, sbsa-ref is special: the "dtb" it produces is
not intended to be an actual DTB, it's just a convenient way
to pass a tiny amount of information to the firmware for
this board. We talk about this in the docs:
https://www.qemu.org/docs/master/system/arm/sbsa.html#board-to-firmware-interface

The firmware doesn't need the MPIDR in the node name, so there's
no real need to change this.

thanks
-- PMM

