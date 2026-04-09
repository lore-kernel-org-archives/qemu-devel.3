Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B680E9DE7A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAlUa-00044K-EV; Thu, 09 Apr 2026 05:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAlUY-00043S-GV
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 05:16:03 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAlUW-0003mh-48
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 05:16:02 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64f48a5c3d8so699360d50.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 02:15:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775726159; cv=none;
 d=google.com; s=arc-20240605;
 b=MPU/MMHGnfxE9W8VpKDMkYMZ0o07iTiCjuudmChzcIO5SUx/GlD2n886UyHb3ZDLB4
 BNRjbPjjretVQLD9IR2pAkS9u4xX2JNrBHEXZofWMjbJfubLJyNvyTDBaDq+4nnzXs5k
 SDFIfmga5wOpMCjcaF4a2ptQ+LeFlrJ10MasT+xO2S6OuIDp8EoOkiGRM0HC38A60Fe8
 HHnnxym6JRubpkkgdniK/WkWR1IzP9xkL7afPm+Ls3r8Ay8PcH90jj8t/GLp7coHMrEi
 nnaMLx5dvia5Q0B8JLoO3VCESIhinXK7rU29OoSg9IkSO4nYdzfZ3XBl/k3izRkd046I
 lWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ji/MitblkuNDNICVUIyixzUQa1KXUQq1gYxLKB6hZuA=;
 fh=ZKds+nUgoQEsVQWyLb5eyl+oP68VH/5k4ombeful5ps=;
 b=EpR8u0PEKhUojz7XeaWv53wwJHh3EXBhI1XI4CDbTR4nJrWNoU1Z58Y+ObgwPH0tGr
 1q1NQQt1Wc1IF/e3ll7heMsFOdZ/fZD2J8VKwtzOIXeIgjGPbWi1SSLhmqhhz8jzgR00
 nzH76qQ9VqqiGbBkRFrl8QLITTtpJZa7wZnZXORvMF2Tf6VRTPxzvFd/Vj6yAaVAEFc+
 zTO/pTc1bwQLQTh6kPRJAkdbk4zGcINy+pAEQgLAfQZ7y7a1RKnPUSktRpq14Lo9N1Yu
 4C/uY056xoZVVvWMq1mqmzD3r0yneOFJsNaojwN2zQV2dAyVcldwh3xcvh45wVYL5LDd
 FrLA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775726159; x=1776330959; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ji/MitblkuNDNICVUIyixzUQa1KXUQq1gYxLKB6hZuA=;
 b=ZfdejXVEBNmfdFd7UDHOGytu8uOyMi39+iddlhRiuTYH/CIMW1krTBDGSsG65m5S3F
 PigYUdlrKOAanN3SWElDFNbRjprdL1kYzeYmRnDqHvj9L0FkdZ9m2xUBa+6YbyjwMnG/
 Q9CbPyti/Ao33LRLvXzXB4HbERDyOlt11uqm3oRYrKsjsSOcq4cu4CnvIYZBfe8FcuFu
 V6IxqZqlKsB2OFygKwKyarDOC5/Wc9PifbqlhPuhSnd6ylT7JSOfhgMb13onLmTdrjjD
 SNjAhxCElbc46ANFJABGTVc2FPR4hOWy0pZ+mTEc7O2ymBsXACtX3NX1UFvClQZW9g4C
 FcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775726159; x=1776330959;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ji/MitblkuNDNICVUIyixzUQa1KXUQq1gYxLKB6hZuA=;
 b=P05/iaM+FyyzWsXgX7DmxtD57632IjzhjsPQt7GDn9BYXiK4dxYyQjiyP46CAyUkOa
 TwEf55vPuW0fmzadF1lfMmu0YR4XMhEn8yQg8aDECHgC1oqXYu5aHFQPr4pAbfrU5VNb
 nhbynBRq971Tl4LcBrBhfdOlvHureke0wNfeTlICSM+wAeJxo4K+7Dc7bmnc/1tJsBuB
 JTLSPqUlPwfltD/xVPT/sm6auDjo7V0dG4u678kcAwJHjW3sAQHuI43ktUOCZVmj8+uQ
 49jyyGgqoPsP2yFhIXg3CKxQbt1pUOosrJX8RSvYPTRWm5wB40OFCGeQ0WpLFnsDKAU2
 5EOQ==
X-Gm-Message-State: AOJu0Yx7cqysEUUcrKMq5HoDbUeCuOlR23jK5TPFzWM4LdmOeoNFWYhk
 pyoLvRCnhV1EON6lz/2kd1uw9sCiOkFoHZtDKDHnRUKkWgOR4pcoHXDh/AsnoxQPYUP779l1DLR
 67rss/9rr5LRFPp1l1H4Pzmu9iTmGnYZZFvlqlvKpYw==
X-Gm-Gg: AeBDiettutlXTE65AY/aFRSqK/SKcLhXY9u933iCFXWeSsfvQ1i/7+62pNaw1lVVwn8
 GY8fpv7KPjLsWdBTzh8Ooivd/pvCdqh5TpkHKvYt51aDAvM0cL4Mkm3PhOfitFKSDvHyXblNu8y
 JQnjEOmr2XkVg3PE63OMUy71cRxdlqBei87g0dkXmir001Ex6SJI2POzPN0K6pxW/oNFpJYQqo9
 gbBDqc/xdvjJgRFoDzEwhMMWRw5tavD5B54s2deP5cZkqiNMD57aB3cSy6EiO8cC+TRTOswN1ex
 /TJehREUvsrMdbgIW9yLsM1nrSjM4hjmey/jfPHYlZBaEgjofyRkYnHsi851KJhS44Y=
X-Received: by 2002:a05:690e:130e:b0:650:389f:8b7e with SMTP id
 956f58d0204a3-650486eaebamr23879047d50.18.1775726158753; Thu, 09 Apr 2026
 02:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260409-fix-unit-address-v1-0-946840930af2@iscas.ac.cn>
In-Reply-To: <20260409-fix-unit-address-v1-0-946840930af2@iscas.ac.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 10:15:46 +0100
X-Gm-Features: AQROBzB4l51zZE1yVUUrjpAWGI--TBOlN6G9MYpFsp-7-zOFWBnSppEokR8Mjhc
Message-ID: <CAFEAcA8MsNRCXp2xKzB2goiQeXbSM0qEZurx9ZV1C2X=4avMBQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] hw: Fix unit addresses of FDT CPU nodes
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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
> Apply some pendantry to the node unit addresses of /cpus/cpu@*:
>
>     / {
>         cpus {
>             cpu@??? /* <- here */ {
>                 reg = <10>; /* Equivalently, <0xa> */
>             }
>         };
>     };
>
> According to de facto convention, as confirmed by DTSpec maintainers,
> these unit addresses should be in hexadecimal [2], i.e. cpu@a instead of
> cpu@10. Currently apparently everything uses decimal which is wrong.

Who counts CPUs in hex, though? Decimal works fine, so it
seems to me more sensible to say "you can use either base".
These are just node names, there's no particular obligation
to use any specific name format.

-- PMM

