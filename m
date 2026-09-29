Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF8FCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 21:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBfQ4-0000gE-Ka; Tue, 29 Sep 2026 17:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBfQ2-0000fl-G6
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:31:22 -0400
Received: from mail-lr2-x22.google.com ([2a00:1450:4864:38::22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xBfQ0-0004V7-SL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 17:31:22 -0400
Received: by mail-lr2-x22.google.com with SMTP id
 38308e7fff4ca-3a65fd1534aso24123531fa.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 14:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790717479; cv=none;
 d=google.com; s=arc-20260327;
 b=hNruEfeWvIU4pNIiJJ8omL26XRUmk+cPDF9ZqMXi9dPqdU/5NNWaZelROpojXBcao/
 2iYkYo+zQBGRJSMs8Lcei883Dv58pzss/Y0F9UmiIC/lVeWauTeGxk0f7pyHCS5RT3Ks
 QZO4rzpbbwE3zSZnyZvtra01F1SKGmERLzHl2+AR5MY2yhO2/xUpCxT03ENfhSYaIn59
 JMR7GWZo+gq4xPZ8fOgJo4qqnbAvwT9C51RzmejXcyD7e3knNQ77wbEa8BQcUOLhiikh
 rn7+uYnyEZBi2vtqtWnhmUYOkp1Mu20k6uF3Nzb10x5SH0nMmpyMCV66HBB7JaeyxL9Q
 FbZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1BrJwhUS3KCpnjaCxftkESMA0WZABC21flZCu7LuTd0=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=BHK2XIWvlPIqLgAGZ+ztXVGAqO2lveiBLVlVZRNH4AtHbvDiDjUX3R+CF8y75zIOIV
 X1VXlCwDBsC8v3YZtRe7dcN1hFQMvdKD7usgx+ejyg3B459F24iwMqBNH+n97zYfuto7
 TBMwo+nPRQuci3WXGBkSTbCqiGI5Sqso0+JXvRUB+L9McH7mTItDZ5SS+FaxqIV3rBHd
 i1uTAQwOLEh0CIjghS+tDjc42lbAV5BJm04W8Jb3BZWc3HWFI2s9EdrN5efNQ1QXcjNS
 ObYo9QtKSlrCDbncBF01l6lkIOzuGUAsd4/mxPbhGbQnctAwCKU+xNIUqU3ShHs/R/Nv
 /jZA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790717479; x=1791322279; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1BrJwhUS3KCpnjaCxftkESMA0WZABC21flZCu7LuTd0=;
 b=pZoEbqVn3vGbxWBbR000ksBT/bIv1bzz5Hc80DHSZh2fQuYH+5+ufMOgj++up4QyME
 n6jRMlVsh/4h2rGrp9ajkzHrb8TkLuoXHi/W1StdFSAkdqeq62eh6oAES5FapM+dlwvw
 FtD5qdgJI8ESMxya8qQeIZ+HG9B1ZjVasBJ8NUz91p5vvWPHAwxfbPhWgZ78ZJ3tMS72
 d6W2xspkhVt2mVgL0uZ3Bnr1pSAyeUiIJzRDbsGs/4H0mURZ7m1vc6nb2LQpIQfAXp3U
 2xf135lB8Bn/1c36ThHxEP3NDissYmFtSRb/bTUkuWgM7UrpL2vuQCa+pk3GKHuXt3Y9
 zD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790717479; x=1791322279;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1BrJwhUS3KCpnjaCxftkESMA0WZABC21flZCu7LuTd0=;
 b=wZ6PhE4bKckOV4av+Fme75p+xaYmAXQMDm/a0F9qnz92qfDyLKBTIOq9bJ+ADFbYQq
 Ud5XufHQKVggfAjLAiMyP36gjuTfDvzpKCEewlE+T5Z6vrPSTe3+MyMUVCZtHqT031bP
 hFwSGZDt6H3K1lUcT8DkVwZMvc6IHI00EtOwrxR3/RffWqN7HDnmGmk22Z2fyPFiOL6t
 RRKUIW+n8d+TTaKOtn+N2a3v9WUFaTnrJI49V2lNcIYFbnYPVrOTGzjxzHmRxoLTKU04
 CyQQQsqrg6qLOtd/ZF6ds8uMhbwSb3N1EIeJNlUr7QucAy36Czf7/gXasRlJOUhv7nvY
 xbKw==
X-Gm-Message-State: AFq9FYIu0qhSwB8hhNHvim2I5i3Q/7yDdH3TnmbuGzXP3QGhR0MpF1gM
 o25sSR4qFv7ma1VEVDPl0VFuO9ThDODCcjihBcyIY16LHaGLc0Pecu4xzO1TAxPl/7BKjjdOZ2U
 29c5ALwF2T8Kh8h6MbrHvxkc3CkuY1XBk2g==
X-Gm-Gg: AYBFou2yWIa4gnZVGD/RJXD6Y/uA+lxBP6EVAYxD2uGXsLFh7iflM93JerVBvzb74yE
 vS5CW+QLpREjsPCrqjjBw3FcVc1txD6NTE05su4ck9mJhzGBrqvPByuZKQixuZBlPTO/YWpf32D
 Ud1hO39KdpCiA2BcrKruA4LhShK+otrtefhYziUq7XNbxSJUVqsTFG80o0cbUVJIWL/xw3Hj06o
 Aeh7GEmLV8tJFgTRi/B8zjvl5aU4lMr0XjIpEaQT0P01gLt9h/JGju0KBclJ3lBvIjzESP2XcrY
 0QzkMyutViBrV4Xh/dUr5Y1B6tzPUmLpjop6+eZvcJW4Tn+nujB7l/d/xvgHNrM2AiRPHEoB7oO
 4eXDdJIL6gNnKBQ==
X-Received: by 2002:a05:651c:2104:b0:3a5:f982:9c62 with SMTP id
 38308e7fff4ca-3a7716e5b1emr1947161fa.1.1790717478356; Tue, 29 Sep 2026
 14:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-2-richard.henderson@linaro.org>
In-Reply-To: <20260927090011.10724-2-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 29 Sep 2026 17:31:04 -0400
X-Gm-Features: AclHuK8_tdJJFHr6hkXXy20EJ1o0hBDZOAla_W9LpJEHF9gAYeG8T_sOrgLABEc
Message-ID: <CAEdQ38Gen7yfgcPk9SMSjE0Di4Tz3U6QUC9hgXdCYCmKyvydRQ@mail.gmail.com>
Subject: Re: [PATCH v5 001/101] include/qemu/compiler: Add QEMU_*_NONNULL
 attributes
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:38::22;
 envelope-from=mattst88@gmail.com; helo=mail-lr2-x22.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sun, Sep 27, 2026 at 5:00=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qemu/compiler.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 4c49f52eb07..3661dc5fbaa 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -25,6 +25,14 @@
>  #define QEMU_PACKED __attribute__((packed))
>  #define QEMU_ALIGNED(X) __attribute__((aligned(X)))
>
> +#define QEMU_ARG_NONNULL                __attribute__((nonnull))
> +#define QEMU_ARG_LIST_NONNULL(...)      __attribute__((nonnull(__VA_LIST=
__)))

__VA_LIST__? Supposed to be __VA_ARGS__? Doesn't appear to be used in
the series, which is probably why it builds.

