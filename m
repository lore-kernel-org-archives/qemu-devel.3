Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B05CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 13:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wInvF-0006Bv-CW; Fri, 01 May 2026 09:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wInvD-0006BF-LZ
 for qemu-devel@nongnu.org; Fri, 01 May 2026 09:28:47 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wInvC-0002zU-0B
 for qemu-devel@nongnu.org; Fri, 01 May 2026 09:28:47 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-65c24be9e4bso1384514d50.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 06:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777642124; cv=none;
 d=google.com; s=arc-20240605;
 b=NQiBtojFrpTDo9G7+qq8i/ixAZ9UgzEAfgwOkTO8Vjcz/eHYWEt40vw+X7xPyal4tH
 ChUy4c1HgXO4+3AepAuEHfzOevvKeugeriUn6fHIVcf3PjS+xmKTY3bAvWUTtIzq9o2u
 aJX0PPloCkRIb6Ansby8ZV6EeHxkPfu9hvpn1TK86ENx0G43j7nDAS+85BocEC1EdVvc
 BEDKnjJC+0V/VBErzknODjoPh0QqGlHI7sMgByCs9nUgbaAIxqvb4EaaFDcc1ydAtgtT
 gMbEi6MsA+r4SELEm9IZPLsJV2V5CeAvQ0CCjyTkUuv88zeFw5F2U3+nGmKwVnm7adfd
 Y6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6HdEIBYTqYsTBbl38Zf9ztU78ZHfZx5WSQrso/ZvwU4=;
 fh=CYUs5UyuHQuhWKgF/5VTGqc5eFdEakTEptBvGkonpNg=;
 b=LROItiVHvXvFaoMt8pertuIY7jl5P4ceKI0b+vve6ccrEnKRCp3uAAiD1fcsHkONR5
 SF9xZQLFRh/UyYFPPhowspHl5dejzQajFRK/USCPw03FdWzw3zdvd3rgIFeIoks8lU9o
 /hhXrMmKXYgH1WR+cUfNAbKPQm2TggmYGjpxW7zauApiTbNU49o9aqOIpE+tAJj9F2Xl
 oYL6q1uYx1E0hqHtq2ZgOC3jv0E+3LEYUASXlGxPom7x00Yka9KSzQjI+WePhhYOy/rZ
 L/Za1Vh6MfBbcMXEtGjjcOtoKQev5+SN3EQ2AJ6P6mSJAcSqJHUG9qp0TVcp2pmuxiYm
 Ikdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777642124; x=1778246924; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6HdEIBYTqYsTBbl38Zf9ztU78ZHfZx5WSQrso/ZvwU4=;
 b=rnKMgqU2KdRxerAjmunL8C6LVERc1saFn1pihYty9gqiz6QaygsIQTWebNUpOZY68w
 s9Jip0JfwjITAiX9dTRAkJsbMZ76KFTgDdEg/X0QlE2m+XgWdRGhahHHjE7a0qhXXFbS
 olMZaxH2jpvBwv69NEJeuDqvYZrHsp5V6McKofvl1GEFEmU/5V5JJySwLYLWgTJ6xYQl
 Sz0USLW988N+6Zs27Wi39Ay7Jt8N3awhXbPkS/crYAG1h/TZGTlvaeq9x8dNPZozlnaT
 S5Tvdk1fWJFN6IZLhJymWRzBfB0aKurewKpRmifGQnU32DN2zzJCnSxMa7Q0nRzM/P6g
 O7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777642124; x=1778246924;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HdEIBYTqYsTBbl38Zf9ztU78ZHfZx5WSQrso/ZvwU4=;
 b=rit6XGAGAADQZXigUSsryw9s8upzTTBS+zgceB7Jg0RsIktqku/kR2e+2pZ3nh15iz
 /WfN2Q2ciel3ickWT/eLA/jIJz4RTIVhnNw81mGXnwbcPq0SVfBUKpHJP9eDoLLkXP/U
 86GyADsD5vAv3Mpm/n6mThy1kdiyAkfek14zhWC04u97HHKxEXNcpK7QgPLTFLf6PG2O
 335YgjP/CYCobSj7pQBTV73i6WzERwnwCh+ByZvEDU86xP7PcW32hVsTu6NPvlglgGdj
 gjB3Shlis8cHf3cmc8PkSNnTkWDhLMip5mUB72xBFWdP0S5YqgQgdAmCtZaAYqPqXlyY
 wHqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9YWBpO8YL2279Gsd66C0OZlWiburgppapsaRDv4nOYr5r75yEqVAYtRnbGYBSVy/6Au6/yYoSw+oRA@nongnu.org
X-Gm-Message-State: AOJu0Yzr49skRh0Ja+2QCuwr/KTC5NovayHNr76PGaeT1W05ntBzu0k+
 bx/cFuri1tsLdWRJ0pULSHTP6JyhcJ0aAPruYzLCCEkAHxwLo/Gc8mbnMO2n9HFyldbHrBSIp/r
 FTifY+kFonwC8pacguhJuvbYm1v7KRoPdx6XAA1Bquw==
X-Gm-Gg: AeBDietNuk3hZ9rONbyFJTKKVl8gu9QKRd5o3rqgdGm/guUZzUr2JNe0HTUXFS70eIM
 fbrrB4BvldJX7Meem3myGDuoUshID81ucdWUn+yDvRxMsRfY20IpJMtFTOq4JaYFMRDZlAth9Oq
 h/WPj+yhQf0bX4z0n3lQWwFWv6o1QPlxzWRc1dR39po0snbUU8xKtTOr7L0+iqSu1Uaq8pYetUS
 8jYb7YobjVfoR9OiLIzkQNSYfUIQp3gjRExp1XjXfOVhmuRQ+riZqnA5Xz1loFh4KW+EF5XzTb8
 Yoec3dRuhTei+uNE4Tw5js5AMKIhk/zpS8WTVP9ShSHYTz1VVI05HQuZr0ONVyAqf+mMlkg0j10
 KhQ==
X-Received: by 2002:a05:690e:13cc:b0:64e:e896:a7c with SMTP id
 956f58d0204a3-65c18fc1160mr5887495d50.55.1777642124526; Fri, 01 May 2026
 06:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260430052218.771358-1-alistair.francis@wdc.com>
 <20260430052218.771358-2-alistair.francis@wdc.com>
In-Reply-To: <20260430052218.771358-2-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 May 2026 14:28:31 +0100
X-Gm-Features: AVHnY4JTbCl4pdCrdsoxGdXQ_ppQ0VUck9Ai1MSsJc_35ntVx5SI3PzBJfRa6cU
Message-ID: <CAFEAcA886dgJ8Rj9uDDQwJRTxeMjJj4QouVUDYQ=L1Tzjx_vWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: Remove spike as default machine
To: alistair23@gmail.com
Cc: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Thu, 30 Apr 2026 at 06:23, <alistair23@gmail.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> In QEMU 10.0 we deprecated the default spike machine, let's finally
> remove spike as the default and require users to specify the machine.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  docs/about/deprecated.rst | 19 -------------------
>  hw/riscv/spike.c          |  1 -
>  2 files changed, 20 deletions(-)

Generally when we move something from "deprecated" to
"dropped" we add an entry to removed-features.rst
(often more or less the same text that we take out of
deprecated.rst).

-- PMM

