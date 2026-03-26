Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6341310A62FF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 14:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5mAb-0003Jh-KE; Thu, 26 Mar 2026 10:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5mAa-0003JV-EE
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 10:58:48 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5mAX-0006Ih-Dt
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 10:58:48 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64ad79dfb7cso1125117d50.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 07:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774537124; cv=none;
 d=google.com; s=arc-20240605;
 b=TY82W8E4MMyMId7c8Ap+YOkq3ruXKJs+EbJgeGC03OTV+lKr6Bv1xJdLGALhkm5Jpy
 Eqa0J+zwFpWXHW40SVG5uQ5XC9o7IsiXCHg7zFUu2tUFTcYBfh/f6ShVdYYqZ+Ve7Fqd
 MyWQxDTlYhicz1BPkhm+6T3J8FFK5Q9W9e5T/SSR2M8lO0ify4QwiLb6RBfTRUBZcbhp
 khsEAEZoS7vaRX/EYBFghO3Tf4osgP2gJFiuVY3FDWTyJiNLQRUpAblFv+OCmOYusydO
 fZPRMIq3yxYnpsxWPymxZkcr3FkX3sVpR8eFzHsyvucC2QkTT9mpHvIgdFLQl5mdFN/e
 bOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GLFRCHpiGkAWWMWLAHlkZiq8ZWK/XLpYnyLtRgU0xsA=;
 fh=Ka5Fm2uGNoMN6LvftSCwVWZ6LDxGZumgYDW+5kU6bEI=;
 b=LqObdio2STGDZLFNpcuEEzBGVYFYwbrS/ga8GjBpE/9faYsLJpAfr6yplr9RhNQlsd
 eMbRdVyK8JSe0/g3baKqeKHn4FJe8qy+/0tdSBBeTmthP/l6uSB/HuIifbVoHzTVgiNP
 UiXJA9GTf1EKuORmCUi8flTyb3irtKuhrEfwaCMfqQUablZbr/Ted4TuqlvESReqimVh
 kEcU7X89417qufQmNMzbvoFqJjILCNCqS6RRaIWuonFZJ6RXFTufdRfZVLNtctVFR5ss
 HESU2cTnVEJWpBMrZtv5wkaEYkO0Zd6ZSnakpDbFeMeLIYA3KJ+cI7kWxSzf1LxqLw1q
 9aPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774537124; x=1775141924; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GLFRCHpiGkAWWMWLAHlkZiq8ZWK/XLpYnyLtRgU0xsA=;
 b=sLZ91SnGBg7aE9Lc619lirLgDwe5Lz3RgAPHy9UdQ7rRRyP9ZjHG9j3AKRdBEK4Ca6
 JSxb+sacBGDZ2Vh2fw98dV6MpjiKnDb9LH2M9CCCbrWVGuLg5n6OmqiMK/azckSvpRlD
 fQXxMc8Xl1D3hPBnoi1b25scNkV4BcAFUhW6Z4aUdLJzPPOhRlv4xWWeVMqe+CEweaLH
 QX787WsCow4C/Sw5XWOijIXol50cXBx4Z7pSy2H3fhDuQ15T29McZmJgNsuPc64BVcOF
 7c09iwkhWj0vUN0BMtQPjiL3qyh+AqSZCC86/5ntNY6bwl332OsSQVKAf2Eee1PBOSP3
 9MpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774537124; x=1775141924;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLFRCHpiGkAWWMWLAHlkZiq8ZWK/XLpYnyLtRgU0xsA=;
 b=mhTjxo92A02of41H24nFOnuQ4J6rQ+9AB00K5+H1NAXkLCJduXYUgIIMoTSX5Wlwy4
 cC8JivxuFF2kq+YnzhWXD1bklywZxNlKbMPm1QYo7LGLKJRBkM0i4cFwNVpFdSCAzp2a
 P0GLhmbaulijoBn1hp2FKbMevC6bStSrU0F9Infa5r8f0uDPCJD9mAJmwn+c3fIMteQz
 iShu8Yy4lPz/1wGNHEqh/4ApSEN/FykNX35xO42AOi2QCVvUxnxSQP6J8dQG84O66zQy
 sr+Zb9iOQNNMezMktAYT8cQE6BwgW6mOu9JadfjJRpEAPofcb8uSbD4yJibA6zPR536w
 qIdw==
X-Gm-Message-State: AOJu0YwVQG+MboRaoL4CQJcBR+eYOFcUxUN8+cO4OkEp2b7tYdk6XgVf
 8/eudyPgz3KLLKJTEftwwo0CtIf3sX70t/grJDP9E7m5P5yKIPpTKLS3gNBZPWqCuYfAmPQb3gg
 ziEnpW9yCo0wvcwWcvRsPNAIlhDSs/6EDb2bz/YpEcA==
X-Gm-Gg: ATEYQzwpWrVb8ty2lYgvMWDg2k8veAhBDycxKL8gWpPsMR5wNnI234ISfhQImZPfRO0
 gQuJ+RPOVfThGxJXU9GNCmEZkCI/Thow4Zk4W2SSlqg7wu0hbJfl2zH4mmuv1wwmC5Ai0CiZC54
 Z/NYlmrv1sAVXUi2XBZS/0GiNVqK81NayBTGLzGFwoB8AciikrHLduNR4jKYNttdwQw4CfIOQkD
 JXGjhIiWnGPypYfOMAcwbiS8qfpSF2VaxMNWGug+dhlrCxaKYECABn3UFqsBQlDde39ibjg6O1J
 zbrB41196bSJRSLX00KNF9SmHsGpxvwUG+DHUbPg/xndJVkhWd92+h1bKvLsBad8Q18=
X-Received: by 2002:a53:d017:0:b0:63f:7de1:7acf with SMTP id
 956f58d0204a3-64ee60a9cd8mr7028281d50.22.1774537123785; Thu, 26 Mar 2026
 07:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260325215222.3678982-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20260325215222.3678982-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2026 14:58:32 +0000
X-Gm-Features: AQROBzDZuhu_fHo2R78L6cpwq6CTqiu40BDKlQBD6qQ40Qdqdx4Xc-gkI5sL19k
Message-ID: <CAFEAcA_dQkQYxkakZ1=FTKSGCAgYAR9CYeeJUkNPmy_HB40E1Q@mail.gmail.com>
Subject: Re: [PULL 0/3] plugins: fix endianness for qemu_plugin_mem_get_value()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Wed, 25 Mar 2026 at 21:52, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> The following changes since commit 007b29752ed06e467d3c830bc2c17a8851f8bcd3:
>
>   Merge tag 'for-upstream' of https://gitlab.com/kmwolf/qemu into staging (2026-03-25 09:16:13 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pbo-linaro/qemu tags/pr-plugins-20260325
>
> for you to fetch changes up to e074c90947a162f795fe85a46e98922c887d6985:
>
>   tests/tcg/plugins/mem.c: fix endian swap in update_region_info (2026-03-25 14:51:15 -0700)
>
> ----------------------------------------------------------------
> Changes:
> - [PATCH 0/3] plugins: fix endianness for qemu_plugin_mem_get_value() (Pierrick Bouvier <pierrick.bouvier@linaro.org>)
>    Link: https://lore.kernel.org/qemu-devel/20260325024252.3369186-1-pierrick.bouvier@linaro.org
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

