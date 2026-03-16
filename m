Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CBBF46441
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 09:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w24gn-0004rc-GV; Mon, 16 Mar 2026 05:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w24gh-0004r6-V0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 05:56:42 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w24gf-0000wn-Oa
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 05:56:39 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64c9a398bc7so4809708d50.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 02:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773654995; cv=none;
 d=google.com; s=arc-20240605;
 b=eLU6mPVfyk9B7tTOC5+QfUlmDyo2THRGjc7D/evpyrBKtANofOdY2+k/dAgjjIzy9Y
 zVz8Xrsee8pENBGvjxHqdMypTWSJEt22U83TM69TJ5zd7lf7ITyLeqrz+Pe+g3JEkoD7
 7n/00xWCSWnGgLr5i2PZIjmsP5xjALV87h3YugO5cZ7BLcb8eDOJo/+LNSrP2450gDsQ
 9oM7qIKK8eZwuwEMMAhR7E6UPn8FBHpHb4MU9U0BHiJ1lUfQMUKkU/W2lqJG7pzIXPTX
 KxT/yHulKhmBBsZD8Ke3BxOxtyXdTbbQGzWigYyc42o4rT9L/4LlmaHxdpXh+w4Apuzy
 hUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KkfMqEbSN0b4tBTG5XX5O2XWTCXUDmhSWV8JPWl4tRI=;
 fh=q4FOwaLWKjdhqaH6fRkTBrgQvOYFgSH4SJFe4z07d1Y=;
 b=A9Hw0sFL243OvIJi57TDXlHSOwhAD2JXQm82nESZHtiiAfKzahZ4HkDzNgTjwCpiUt
 0s0cqhHmaG684HoEG2QXvoAsjYG7yeyfSC2wsGXRyFKIglQsUqG682y4yIaPxVoreykT
 NxoxwNqEY3WBTjLAdc67xPn3ujj+qaUF5eXN98ukAEhT51H7W+ZQqqk9imPF5vzsm6QI
 21FRxi7S7EMfDwwIyFH5c/6qIQwahzZ8n03YKDMUVYIKOU0D087HXGiPhGc22wdywFob
 vGsHqr1OBqHIgWaLCAYCCnED5Wu64+fr4APq/MJBn9O3Mp0aIFvIqxNXHFv76SEywTr4
 d4GA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773654995; x=1774259795; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KkfMqEbSN0b4tBTG5XX5O2XWTCXUDmhSWV8JPWl4tRI=;
 b=FKCJh1tQhIMyL6itbBgxjurttxKViEhlu3O7H3DHsloqA5qh/QYvpSJSbM6aqbfW7P
 nv4Qs97o4jbiKBg/zs7lwlqBNSuKNKpzqc3ml8Sj9xvoIdgBr3m/bY5IXsDLIsL1SgGY
 RxNSUHWV2H0akWcub5R6Smrkq8tszkg5zTQGaTyGQVvOzjapOjb7o4pt1u5vkVltSROg
 qcyHRiqSa9PPBZSIVytG3ooNPEWis50eeangJIpiOhtlyQkBF/DtlHKxGzr12+oNXnRM
 FGp/ylqiTdxlq0rK6NQUkqNqvFndKG3vPvCLortvaDUgkD8laqBWYwSlwEQJ6yRfjRf6
 Or8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773654995; x=1774259795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KkfMqEbSN0b4tBTG5XX5O2XWTCXUDmhSWV8JPWl4tRI=;
 b=Pn0Ab86pY2Oo1XgxHSPsX3gGWqYvofwf2m0ZfT0Ua+QObS18lk+oqFWmbME8BntcqD
 S9OqukU1F/ff+8N+0/E0125xwHNgLmXSBV/AYJMCrU1cUURY4IFnm1+k8tz2j4SnUpnY
 PiZFEJQ5sBHS+g0mMCf3My6CS0/mgOXKS9oYjDyYspVrrnKRUrjZGJEA+/QbofLNJbmT
 fkPdzsR0z2j7iUNxex2xnDsME3uni3T/5Rx1+iFu9ns9V8gbmjJbFIciEXbITo8QT3+X
 y8gcwFajKM5qcXXuUQOB0jzrGXIYzERTEvgFkEijLhVE34NwNuqxgRwRmAmt1n2YoeYM
 Jvtw==
X-Gm-Message-State: AOJu0YxBml1lS9W7xVpN+ayKDncMVZUjV8AVLGVcRbQ36tvCFK++GmZG
 PxdbfAfZ1ZZb9EimL1DoMM57sPWu+y7fqwPxMRSc1dvjNjZjrmhJ+ioF5UVQNCk7vREMjdRrZKW
 AVamN7C7KPq5C1VNcso6eynoqd4Z2FWNOLNveizqaLg==
X-Gm-Gg: ATEYQzwdXeTJHuCsjchMI+/4YfAxH8rgjVgsKnYlFvOCW9lR1BWeGd656y/igTk3527
 x1MSTzbIHJc4iesvm3Q28KOUDrgIU3Rtoizovgjvx+QyAY2Rv/Gv8mTF+2fFBgjOZv0isVNa6dD
 pwrVWC3aNIWnFnCCLo5ohqTLR+rGO22Sh12i0nM4MT5Cq7OXrxZNdPsLTTWiF4aWdv+N+4svoOs
 N57Q34HZXe8YL77UTJ/Y4Sevv6OesBGdKIy8p0Pi11euCA2Dix1T0W5vZz70FhkomWNV9D1Od42
 oOUAmMUCCy0bOdPO36ZI7qJnfztph4jzS8k6hRYOte7B/A+K5DGoUklBXMmBIP9gQkk=
X-Received: by 2002:a05:690e:128a:b0:64e:6b5a:c781 with SMTP id
 956f58d0204a3-64e6b5ac8d7mr10870880d50.6.1773654994906; Mon, 16 Mar 2026
 02:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260313182957.28432-1-farosas@suse.de>
 <20260313182957.28432-4-farosas@suse.de>
In-Reply-To: <20260313182957.28432-4-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2026 09:56:23 +0000
X-Gm-Features: AaiRm53KEjFoNUViNMWA_pnP3XDYr6zqHtyigj80rPj2mMq6GVRECES0C7ys1ww
Message-ID: <CAFEAcA-2mcfjsngURah2jGvz0kib+-JYCGWjUPGWF8W262HJYg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] target/riscv: Don't leak general_user_opts
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Fri, 13 Mar 2026 at 18:30, Fabiano Rosas <farosas@suse.de> wrote:
>
> The global variable general_user_opts is being assigned twice, losing
> the reference to the previously allocated g_hash_table.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  target/riscv/cpu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e56470a374..afccfc2935 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1099,8 +1099,6 @@ static void riscv_cpu_init(Object *obj)
>                              "riscv.cpu.rnmi", RNMI_MAX);
>  #endif /* CONFIG_USER_ONLY */
>
> -    general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
> -
>      /*
>       * The timer and performance counters extensions were supported
>       * in QEMU before they were added as discrete extensions in the
> @@ -2751,6 +2749,7 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
>      cc->tcg_ops = &riscv_tcg_ops;
>  #endif /* CONFIG_TCG */
>
> +    general_user_opts = g_hash_table_new(g_str_hash, g_str_equal);
>      device_class_set_props(dc, riscv_cpu_properties);
>  }
>

This doesn't look to me like it's sufficient. These hash
tables are used to store the values of CPU properties.
Those are per-object, not per-class, so surely the hash
table needs to be in the object, not a global ?

There are also other hash tables in the TCG riscv code
with the same problem (using a global variable to store
property info that is per-CPU, not global).

thanks
-- PMM

