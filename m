Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD0BF433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 03:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDDl6-0004nx-1Z; Wed, 15 Apr 2026 23:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDDl0-0004nB-RP
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 23:51:11 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDDky-0004Ik-Hu
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 23:51:10 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b9c04152730so1104537466b.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 20:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776311467; cv=none;
 d=google.com; s=arc-20240605;
 b=TP4dqAiVe1YW1WxcAOJSDcID10xTRnaZgh+QFTG1X5HxGsINyip7bNtsqxqnoYuQ8Y
 1S5Aup4saqaEhHBK560GBWbB7tCLdlYlQILj65avH9Q+2LBcTeldvcmmr+K4hp2MAkjR
 AE7bFOANCr7hTyBj0p840YunDV2sUn9QnCW2xt+/o70vhQwdH42cpzFh3Bk/OJGOOBW3
 RoWIwzVAkrR4ftzsYI2kZfPVRtXJptegWqD8VC8goaGnG1WDMdINXor2cfrHxBe8Bm/n
 I92IlCpOgfiAIfdHz2Loq9BAgsvUbpw9mWTItmlDR6Mz3GIvMmMo6m7nwx4OED7Sa/nx
 pvUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=B7gPTtwEAXVyYJiGl/rRuUv/mMeU/AnDgl54+hREiBo=;
 fh=QVWHD7/AE5+s66f0ZH7KkKx7tUIoR56MqZsTq/mzPgQ=;
 b=LokfbmDbJb7QSyEkheA8+99SqByevaBIrOiQvkpejbsKWv2Yjao3CZYmAWwLnMmFsC
 +VrBdR6XC4JIK39jBWP+llFlMHxAVI4QxuPiyV7LXZl8fR3NgPaWRJ/GZOUwE+dE8UwM
 5oKMyh1qP+7OLJtVD23eZ53fhnZTPtWzMuLsyU4ooffi/sj7MWlyqnd8X3/dW1DvhwGU
 NCVVxfUvATJmXBojefXcYx3JtJ2uQ/NIHHKny60ha3TwJaWSaR7e7Ob7KLiuTZxvBLLE
 hwyugQptc/MKdkrZuw59wMgxu3iB9L37Fg2YftisNRIwXo67VXgMMqJRgK6wrdthvNQC
 G8kw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776311467; x=1776916267; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7gPTtwEAXVyYJiGl/rRuUv/mMeU/AnDgl54+hREiBo=;
 b=apTPiIuAR6yvzkJAGmN7u6G1F+vpGoN9ajysmd00tmsBPIRve9Zvv7qMZKwsN+JJnu
 OVPdSYOBTDFphetVRS6Kpj+IEHMCybjLJrXc5A+Fci0lPFcOLWfo4D4m/cTJ/75OdIAD
 cEqoEgpvlt8W+b63EsM39ihE1pV3hkTtHG4bEQjRVrjV/jf8dzTkrbqcf8kqRCqYFeqO
 H8Y3ZbsxEOmORH3I0Uk+TUn9eSteJevenR+QVjB4LNkY3Y/OGZukYVM0T4ZaefFQJT4m
 R/B9FANymf3Hm9VHB8CpXf3lda0OynS2mgV2u5wEWSkGC54UCGaDvcYk/H5uTAPzn8Nu
 qUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776311467; x=1776916267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B7gPTtwEAXVyYJiGl/rRuUv/mMeU/AnDgl54+hREiBo=;
 b=VZ3F4A1qqHZwc0HK0U5MTNonuzTH0+6pdpb82ANFvlyWK5wM6loTeKaeGBp4MItMqK
 NpvRvSXdBCNP9ObEYX0XKyj9NpWdmYBGqn+T8QGB2o7N55PM47zml9GlqjFKni3jT2F1
 mlDZefas8GjqOBOkL6kAfW7Q+FvauDx8io1nABVPNyk4gQjPTRS3kxnIoagBxyejpWmw
 BJfetnPz89+sC1nFCeN71Iw2fzJP8MQiGMCxPzEHFFeKzm761XyX5sxDzn0YBIQmQUwG
 Bo6C0eWQkOtD8wkiE8W09ML8z10kNTwJYD+GPeG+GApB6/JsH91IkcCaL6Nj1NITJswo
 22jg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+n9AYA44Aj53qFQi6eUmUN2ffb51Oy+Gmf3D8NrGoixl7sngCT0FjWFNjD0fNb3N3rPMoTRKJKKkKQ@nongnu.org
X-Gm-Message-State: AOJu0Yz6+gfhNFb4uIp+nLfnyaY6J+1mEIt0SZXTuzy7pJ8y4PRnnei9
 RtS/UlXsYnvh4URtW75z3e3AX1XiaDcZ+EN0nBkdQPzCPuZAyLBE+vqqOvdOTIgP2BiIUI3cnJ7
 k70AiIrOuF+W6uGm97DHDfQVR6G+1JVo=
X-Gm-Gg: AeBDiesp17fMgy8Kgbs+aB7p0zq7mdjZDD1jzDPOBB6syaWGxB69Hqz/scCBFafdqf7
 SM5gw4pVjUwjHEQYvEdKr8JTXNz2875Jxhoiu2CA3c/CzS75BQA0TsaTszBbZguTPR2OM8slMJY
 IB+h22/LDDJQxWxN6Q7WHmDL5yOFvQ3jFuZ4dLxZzkfbR/14OGCFRZMSd8D/YrB62iC4UGThyrb
 lA4JgXpMd9VanOoacbQS6Gite78WSklD/Nb/0pblBi96v4wk6L8fYtnossG5JZCtoyZtJAIpizn
 8/rpC0vlKoDO1Zg/CEY95MtdnMPCLnO4mcQWBQ==
X-Received: by 2002:a17:906:d104:b0:b9d:38b3:9bb9 with SMTP id
 a640c23a62f3a-b9d727cf2f1mr1094699366b.37.1776311466346; Wed, 15 Apr 2026
 20:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260415134826.1742308-1-chao.liu.zevorn@gmail.com>
In-Reply-To: <20260415134826.1742308-1-chao.liu.zevorn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Apr 2026 13:50:39 +1000
X-Gm-Features: AQROBzB0JkR3STceeTUWRq2eoJmdZ0Izq0w0kDaod7n4BA6im9d3Jq_HNtpR3KU
Message-ID: <CAKmqyKPeqzjYDvG9GfmQ37psGEiqmx+tFGR=YES87YUd-FA7SA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/char/riscv_htif: Fix format specifier for uint64_t
To: Chao Liu <chao.liu.zevorn@gmail.com>, munkhuu0825@gmail.com
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 tangtao1634@phytium.com.cn, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Apr 15, 2026 at 11:51=E2=80=AFPM Chao Liu <chao.liu.zevorn@gmail.co=
m> wrote:
>
> Use PRIx64 instead of %llx for uint64_t arguments to avoid
> -Werror=3Dformat warnings on platforms where uint64_t is not
> long long.
>
> This fixes the cross-riscv64-system CI failure:
>
>   ../hw/char/riscv_htif.c: In function 'htif_handle_tohost_write':
>   ../hw/char/riscv_htif.c:175:38: error: format '%llx' expects argument
>   of type 'long long unsigned int', but argument 2 has type 'uint64_t'
>   {aka 'long unsigned int'} [-Werror=3Dformat=3D]
>
> Fixes: d98f7a541c2c ("riscv_htif: reject invalid signature ranges (end <=
=3D begin)")
> Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>

Again, is it ok if I squash this patch with "reject invalid signature
ranges (end <=3D begin)" to maintain bisectability?

Alistair

