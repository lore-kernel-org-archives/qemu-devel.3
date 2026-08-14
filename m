Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9A4C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wumWg-0001OA-GN; Fri, 14 Aug 2026 03:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wumWf-0001NF-8x
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 03:40:25 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wumWd-00010Q-Vd
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 03:40:25 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-836eac5682bso10642217b3.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 00:40:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786693223; cv=none;
 d=google.com; s=arc-20260327;
 b=X8avmLnUjpzb8QoI8G5AK/2u2OeMVS/lgqrLzZzjiap0vZS3aO+2VxJEGdix8/JPLP
 +tbbLQlrXXBTvTp71CLOaNrjHEQyEJHzJRWdRrJZVBHcFyvSOzG0wVk25F/JS9CruqYR
 rX+YEiimpfmvB89J6Cix7DGIJDNZCHVRnpdNuXqrOd1oMKb5DEehXLdl6LsyXXxQbdsv
 2y5C2uB+ECkhC3tKFwy5SoFsuOgDN6GUrXJ64LZ1wE03lJfyTNIi4rNtml8kkxGiHwW7
 fhnf/Tq/ZFtZOklRtnpjaaoVzAHhS9ZqR6JQCXdWZ0uqf8gWZQ0fyM4bThe806ODPEe1
 oCKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wf3t5Nxr0W46HeKJ3HAfpjaNb3rD6s3WM3jNXgJHBFc=;
 fh=DvywU1YRUhG1v1NPt1cQxypEN9Sw7skuH1UPJUFElts=;
 b=S6RyJC5iKVVArvxzl/d44wbN4uVvReN6v+sAZkomVWyCs4jtgIOTkS3qc9SonNbYW9
 OgEshWesIcjLylNPSVV3kEjW+B24zhn1ms9fSi+98IeqJgPToc3bzNN+ZF2jpFydq47H
 gbgiZ1fX/x/Zc5oAUixbLmXnIdQ59JmPtBrIyIF3zioC0Xhe8WJo3aqCHFICtvi4q6DO
 nUZnXtOixAnOxAID76B9AAd27xylK61w8dlw4jw7SjnNv6dsEOwHWcA5cc6Xns7NCDRi
 UGX2l1fTBeSsPDsNHZ3Xk6Dq1Ko4KeA+1qI58mS+b2gnONyBTQ4TrPhb1EeRInnrzy+G
 D41g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786693223; x=1787298023; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wf3t5Nxr0W46HeKJ3HAfpjaNb3rD6s3WM3jNXgJHBFc=;
 b=LKx0rYT/kUkIWLSx5JIMJgHC1XWM0IqlxDLafayfAjCEfrHznxs5z+zErHyCNtoG68
 rcorIqu+NbO457xiKXHJzV25Fr28j4AZx3cZobg9l6b4iiV8QqsVmIbBv/twK7GRyp5F
 AocWR2jaQTyLLcaW5+p7W+N2gTQV1JdU3FFio95Kf8pBkOOJh3qj5yQ7IUmBfE4zm3CY
 A2cCwIUVXfC1BJkvp216spzxun8LMkqgMZuCC6uz73YZrQwobtQtvkCNh/xnN+k9D0C9
 toxGgGmvPhHifaYiExdK+h6wDWVKnWbgH4x+cb7w9gaT4hZoqWTJkRyhFt9vsqlyeo4v
 HS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786693223; x=1787298023;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wf3t5Nxr0W46HeKJ3HAfpjaNb3rD6s3WM3jNXgJHBFc=;
 b=cHk/U6mwHJJMAqrda0yuWo5MUmV1kM0qucXy/B6rVlrywKnmhoe2/tRzCncTLvkWg8
 6++O5prQH8ENRmhoQgyq1o585DjLRkqwbixIukQFtYidW+R/qFs4U+JICHKACXR9i02o
 N3nr2vcMTptVv+dgLV2hoSCDeMpAfAsuoobwS6p6JQBhWh+RCRc7gkv1ECyoveLbz5oZ
 nlS9oLmLsFLjcfCW/cLyJ2Co+9aJMEHZKY8CdvZ5AhC1JJSI8kNGKIL0t/3L5t4IHqpj
 DcgUPsElEveNxPLJwfAu1VxnkrwpusL4poh/guqUpw4oa5eymQ5CM7Fxob7X4/UwfeB4
 oi8g==
X-Gm-Message-State: AOJu0YwTzYU318Q2MBTzEaIGsN497JQZUX4w+SX+IZgu+tQr4+s0if/c
 U+sk4jjVNUvoe4TaVXkXv8eOcmxKEkbrK44/O/52cgvWm8Rwc+ufvEjap30hkqSoV7FizgcjLIT
 S/daZA2G0CpEXN61WBBUZQjFgWmKRag8=
X-Gm-Gg: AR+sD12Gwsa8RAJZ0/bNKDDMAtJcPlhVgJiElSS2aCZu+xqn7GHA8q6aBCNTDPRg8IX
 oTX8bVXQE7yZBonIWgl2hhZ/odsrm+0RaMP/7ppEU7ngC5SkhnU50z1uEGBCHYvXcJBlyTW4OQI
 SsCSjIExfz5NaVmBIRSyF9EpfJQt2b2+hrwTyzpgUQd4GTAIKQ1Yd1vre4wOKOCRxJppDJPhhbB
 00iubHERH1Qc1unmbY7/ztd9dmkQXWL02C1q9FZTKlQTjVNc1ZUzJQSc4tdPtsXLsUVYKs78kUQ
 XHVrQwPES/8iIeHvgKfaqH3qQ8Wyz8R+4swsHLBevjkpNTVw8wTwsgY=
X-Received: by 2002:a05:690c:64c1:b0:81e:5d2e:7a2d with SMTP id
 00721157ae682-8370d7e6391mr20033067b3.1.1786693222730; Fri, 14 Aug 2026
 00:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260813133643.20380-1-rao232328@gmail.com>
 <20260813133643.20380-4-rao232328@gmail.com>
In-Reply-To: <20260813133643.20380-4-rao232328@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 14 Aug 2026 15:40:11 +0800
X-Gm-Features: AUfX_mwAeBc1JotGnGXlm8v2JTmJ_L6KEDhLK_N_vJQhs_WeVecDJES3ciQ8lDk
Message-ID: <CAEUhbmWtJRdeBAE4FHXLQm4Ow=tKYhnyGrQotsgXmbKHWTBVyA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] tests/qtest: add k230 dwapb timer test
To: raoyi <rao232328@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com, 
 philmd@oss.qualcomm.com, pbonzini@redhat.com, lvivier@redhat.com, 
 farosas@suse.de, caojunze424@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Aug 13, 2026 at 9:37=E2=80=AFPM raoyi <rao232328@gmail.com> wrote:
>
> Add qtest coverage for K230 DW APB timer including
> free-running, periodic, interrupt mask, disable
> behavior, current value, dynamic reload, and
> multi-channel scenarios.

nits: please make sure the commit message width is about 70 characters per =
line.

>
> Add timer test file to MAINTAINERS.
>
> Signed-off-by: raoyi <rao232328@gmail.com>
> ---
>  MAINTAINERS                         |   1 +
>  tests/qtest/k230-dwapb-timer-test.c | 274 ++++++++++++++++++++++++++++
>  tests/qtest/meson.build             |   4 +-
>  3 files changed, 278 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/k230-dwapb-timer-test.c
>

Other than that,

Reviewed-by: Bin Meng <bin.meng@processmission.com>

