Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18A9EA71AA
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 23:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEbuC-0003uv-Ck; Sun, 19 Apr 2026 19:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wEbuA-0003u6-77
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 19:50:22 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wEbu7-0007do-Vf
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 19:50:21 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-65427236e94so323075d50.1
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 16:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776642618; cv=none;
 d=google.com; s=arc-20240605;
 b=TcHSZ/BDQrre83y3Co4BE0Gx227MIr+Gt7nMcpGxBouweOAlYAxjVlRLrcNLA8U4KO
 u/dSYwe12uhyK+m4JTsreePvZoHsFMV3vF5uIFAVOXajkVIC+P25WAOQlJVDbRmCA1ao
 CB44XyhDkefVyumQy1BUtNkQgbdJ2iWPqQtiMUDg1vnZ2QUQRZ+SRUfLz6yuvctiV+o7
 iSf4mhGgfQEpGxfA02oYO+ThyBOAzd+h/V+HRrTyjHAB80qfPmUHQ8JJxjwHYHmZ0YAh
 CqQ2qYNGdwN4S6PLfrgtn6W03feZJjk9//ce0xFjU+zHFatkzDFlOZlmUgsOPMfSDhgD
 svxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dUnekS1zRK/Vn2y1nVVk9tXJ583Or2LvK0InehKKAes=;
 fh=Uf1RRPwUCIbdHoEIwaKY+DMmrpHRpjOV3+12hXt9c3U=;
 b=PJFXX8Yyk1uzVSLMD0xdmeGj8uiGBb7LjkGNqwj9OPYRxwNMLI/4NcowHjuvJkizQg
 m/GItJZJEWPn7rM8tUolqWrX4yCRn9H2a32QqpfsnZXUIAOyapOaSc64fhDff6THc83D
 GSWy+RXsyUfXM2HYrhBpIWJboff2pAzfnI+cmOlI9/O848sIW7c4dl+3zoAfYCEzJ2xm
 EoAQSOsVtFApjSLcYTmlh1xBY5QuO4TJnXMIHfGzdfdaJLjy/zjbphQ7lRUoP6BbdABV
 MDBVmhv8RJnuoD9eENUWbuRtzqZvt9ykrkwoe6FxsFBbZweKJXr9e+xWBx3OUfuWJygV
 bBeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776642618; x=1777247418; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dUnekS1zRK/Vn2y1nVVk9tXJ583Or2LvK0InehKKAes=;
 b=hYl30SgaQv9d867OezkNNooCypRTHKu8UIc1O6/Atw7Mh1nl/5dJyvxkd6XrUcjGij
 7T0N/gFYTJya2o1k4UkpqkYIckKRJ6uxn/870Yjy4FFK3YVs87hNGLB6P2Por2YDf+yj
 tsWJZi08MvceLHvCix7u+aJoitZXccI2BTIShk4akKe04k/Jc85nt2WmDo3kETOVYVI8
 j8xU7HIHuwwoJtibDi8wy1fhZvq+8Np5mhmJdZSgGs3pcjQPHR02rHgiUTRu4WMfMN7/
 Yo6m17RDlp3D83O0xu4yrkqdYvUfq0achs12iQVhNYUODqgLFp9tsmyY3yDNNYGexIzZ
 UCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776642618; x=1777247418;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dUnekS1zRK/Vn2y1nVVk9tXJ583Or2LvK0InehKKAes=;
 b=WmxrPs5LsckrqSS4nz8DpU4SH5nmtbQ+6C6Bn/MAq/Ycc1F36bxyGIVCd0CR5YN/mJ
 ju5rpufDaebDgXaTscp1qYmy2IqhkwNL03MlF9eRPMEEEb3sX1n6VyZmXOo/NFcvvXdd
 Jo50XS7uKRx9qHJYgBpLx9VPD8VjUA4jfFnQH5wz9iHveVaJCVr5t878O27ZI65/lbOa
 u6ubQmz/Nz47ZvHuMNYRv55QXjZ3A5PCPJlCtT2HKmNxRmtHh+iGfPX4Min1zd3jcyTo
 AWIOZm76la+zhiRZ3u0IYzvTzYeL69Bj3rxXo53h6hzCqIva4kd2MrhFp7gYeVgUADO4
 uCwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qhHVfE3XPoU6vWt5pSDc9U6tun/UjQEIrtGzb4+/jKi06Yd0NFNxDnZ8T8UNuh/UTzLc3T5eL9NVn@nongnu.org
X-Gm-Message-State: AOJu0YyL09fp3oFPCLWQXJ6CRURG4yxfol27JF7KfTJqkA1kurCQ2BP0
 7x9GO3ZSfPnhCjHKAz3uTtfX/6kydCwdz8cFwbw15gyepVgjyT3RvoBkYwtoZo5WSR+F1CQaxxs
 ZM68yR+N+l2m/+pAzNqtbOAN0KBpZmJY=
X-Gm-Gg: AeBDievUDBMvqAS60w9s53vYQY/WFZ/F1eg+DVC7QISjIJepjMhcacYF1RzUjTr8lLd
 WwXUNw/pm0OQjqTPQvxiREXj4hIlV9WPx/xYpxByvLCVhKTer7SWE7WvIB41w01SM7CQGH7hv/P
 ULJ9H3MBOYp8ohZ1gc8aNKKXvydfN/VSMAPEpy70hx2O/T58V8v1mlILkJs8xty+v2r54vZoDqh
 4aNihAlbe/rVl3c6lQ2Q/kylgVwhavqjFiQ1kGWvSfWV+PzN0UZBkSMOMUC7uM429a0ZEt61MDw
 8sSL08jL0gk1ToUptB3FVa2TYvMJsqhMV7Yx0eau9CWhcSESwtQreiR5tt8=
X-Received: by 2002:a05:690e:1685:b0:64a:d74f:2580 with SMTP id
 956f58d0204a3-653107bd0bfmr11073782d50.1.1776642618385; Sun, 19 Apr 2026
 16:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776438369.git.chao.liu.zevorn@gmail.com>
 <e1a977e38c934a7f383530067230a6201b8ccc60.1776438369.git.chao.liu.zevorn@gmail.com>
In-Reply-To: <e1a977e38c934a7f383530067230a6201b8ccc60.1776438369.git.chao.liu.zevorn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Apr 2026 09:49:50 +1000
X-Gm-Features: AQROBzDd8vT19_O-TGiagIJIimqtXIOjlznc_3e0h6RKAbAbi9Nk29l7N2JAIts
Message-ID: <CAKmqyKMipoe-YHVo5VGekUGG4uFJ7CEktipsOCSrSx=6b9=REA@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] target/riscv: add thead-c908 cpu support
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, Chao Liu <chao.liu@zevorn.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Conor Dooley <conor@kernel.org>, Peng Jiang <3160104094@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=alistair23@gmail.com; helo=mail-yx1-xb12b.google.com
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

On Sat, Apr 18, 2026 at 1:13=E2=80=AFAM Chao Liu <chao.liu.zevorn@gmail.com=
> wrote:
>
> From: Chao Liu <chao.liu@zevorn.cn>
>
> The C908 processor is based on the RV64GCB[V] instruction
> set, compatible to RVA22 Profile and implements the XIE
> (XuanTie Instruction Extension) technology.
>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Suggested-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor@kernel.org>

As Connor pointed out, he didn't add his Reviewed-by, instead he
commented about a missing extension [1]. On top of that I don't see
any instances of `Reviewed-by: Conor Dooley <conor@kernel.org>` in the
QEMU tree, so I assume there are none on the mailing list as well.
Which makes a copy and paste error seem less likely.

I do see that Connor's reply was sent from his conor@kernel.org address,
but manually stitching together a `Reviewed-by` and address seems
unlikely to happen by accident. Although it does seem like the type of
thing an LLM would do (see below).

> Reported-by: Peng Jiang <3160104094@zju.edu.cn>

I'm not sure how this can be Reported-by, it's not a bug fix. What was
reported? It seems like the Reported-by appeared in v3 [2] and wasn't
in v2 [3], yet I don't see anything reported.

The extra and unexplained `Reviewed-by` (especially using an odd
address as mentioned above) really points to this being LLM generated.
Especially considering that your reviews are LLM generated (those are
fine). Unfortunately that means I will need to decline the commits
according to the QEMU Code Provenance rules [4]. Note that it isn't
just the Code Provenance policy, it is also now really difficult to
trust these patches knowing that stray `Reviewed-by` tags could be
hallucinated and not caught before being submitted.

1: https://patchew.org/QEMU/cover.1764493931.git.chao.liu@zevorn.cn/c27edc6=
9ea6642f645d5e194bd5d4cd71e812841.1764493931.git.chao.liu@zevorn.cn/#202512=
03-squiggle-gentile-f27af704359e@spud
2: https://patchew.org/QEMU/cover.1765811173.git.chao.liu@zevorn.cn/ac82fb9=
f22366614c2be80d9fe200f1b5ce161ef.1765811173.git.chao.liu@zevorn.cn/
3: https://patchew.org/QEMU/cover.1764830405.git.chao.liu@zevorn.cn/fdd2cb5=
19a91a16c5b6e8931dda8301bf1c23c85.1764830405.git.chao.liu@zevorn.cn/
4: https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-ge=
nerated-content

Alistair

