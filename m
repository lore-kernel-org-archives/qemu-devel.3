Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13009CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMjY-0004Tk-Hr; Wed, 24 Jun 2026 08:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wcMjO-0004QE-F1
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:29:26 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wcMjI-0003ub-Oa
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:29:22 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6978f1eeb87so1594306a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 05:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782304159; cv=none;
 d=google.com; s=arc-20240605;
 b=UFwEOEr9V0sOfBPqiHs7vG7Lpq7LSi/BH1YaRMiGepFqPLgz2bveFzgOgRtHQ5RSXm
 eMZyaoWvaW5rlI+748n7D53iLFTFx0OUJCR1JIf8VzSuCcTxB+vdQQZverab2XFppCNU
 8pMSG8M1ysHteC44W/SeWkB9hGnxWlBbQTIpghX98aDxHm4UK1AmqpA8+wu5uoj9ykn6
 ArkQgfhPRGXOjswGbnKjTZjleIxl1KUv9603dO7czVvBwqbTzsXqHqShzTq+7XFRyUPy
 pB9HYUA7pPC21HOwiwbKI2/UuREfq0TXLTW74G75NKJ1k/2scc2dQFEUd9IGEsgbZh0x
 b3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lQySPlWEqPU9+4gudR76dXsMImRBFIHR1erjqT6cx8c=;
 fh=L13I1QiNH9dHsCTdmInrmkJyi8gzrG45ApZ/w/4mM4w=;
 b=eN9/I7SnbxejIPH0+zWnisKCourujvrqgrU4z0H3ygJHuk6OqZHgIPM2r8/NvSax8p
 eKBCR/xzo82Jh80VRlfdWOdVvgyY2ZrOu9GgJq7QS4Dmz1zXkS4FE9L0LsWu0al0ODzG
 LnGAe09Zj8mPqYts8a22H3H96ExO7GE4oEHafiLV1KEO3C3UmDvUsy7TkFJWlkBsTIV7
 IUeE+wsFvSva8DEGn36gcQvcoeHb2hOGb7PgYHU6A9K3zeHR/VSbMfDaLOZC4evCRY8O
 4rZuFf2LqHvqwg7bcWJaJr4Ej8lVZp5YSMFs+Bg7OanVXZvdsTzvhM29TqbcSbcS30jI
 +JqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782304159; x=1782908959; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lQySPlWEqPU9+4gudR76dXsMImRBFIHR1erjqT6cx8c=;
 b=ox9ttX+7KnIndiTq9lkO9wZPP6LdD8ZwX9cg3pSIUdQ7wDtOHgfwvc5Yec9VFl/d90
 Z1xY/zG7PqJVBKAxpO8EAy1AcydUKDpqiDcm3bKTgJ43jGRmFOo03DTT0AWZbSjfREkf
 M2driS+Q61TLRXztNppQ4HjLdIQdZwB0iPznvYJ4KGX6UcVGSoOgaxVfnwGIMQaFwY/1
 ehWqtoxVNY0TKT9iZGWtwU0iqdkMZDvPvfGr3lHyPO3y/Wp5fOqqG0Hs3Pk8vTTdeWhm
 znwFoFAT9kqTxWo5vSSYlQiiQY+VJDDJToig9CSyi6D79LIqs5ZZzmuf3rNwfiVnCdyf
 rO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782304159; x=1782908959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lQySPlWEqPU9+4gudR76dXsMImRBFIHR1erjqT6cx8c=;
 b=EsgxlcBHxntCu8r6uVaqn1FGi5fzr9KFQz1ouThwMDl8USvbbis3hqL95pyAtFxbOQ
 +0PTRxA0j9A8AwUowwExSzVw1kaWbF1IaAuizMK40MrtH0YmJBx9ww7B5YbX8UEGHOYc
 wHkv9KxCiZGODneamvpQ02S8ZTm/cTOQ6cSzxhGqByY53/yrRYtffz6ioCWZqzbJr+4p
 bAhJDrQ2ymr5brHi9SyBPzaQFJhkhxgNRId8l7+mO4gUp3f5iZP53JoqXUSZJ0xJiRCP
 QGiNlSVRjPh8kv/XeNOG6hTfU93HOzfu0RloUJxVR/U5GVpBR6cMlRDntUm1L0ucum4c
 9iXw==
X-Gm-Message-State: AOJu0YxpAkWgp+xNmL1VBADojdIfIClzPLRYAb2oqKLvqhf70ZSB/gkz
 +b6cLNHUvuHpZEx4+L71Zg+TF8m62acTePU6/oF8/VpnBXV8hkO2pO0MctFOqTxXbJ4aLtPNZQ6
 bBcF3uCgwqE8hDcXOqwV9V/RAy57m4wQ=
X-Gm-Gg: AfdE7cmpplDu+D0c0+h8ZcdRogY36m0zArz+sxoP8zd7uC7K5FZyYmXtd/eXmqbWRhG
 yrVNlgzggbAm5ZP2iEVIlFolqXr3KHtP+x1PAwpDqytjq7VfMBWHPplWH/Pt/n9jJPhgLqFCCdM
 4GhibfUyO1uMrIEK/lmCe4PMXZrKL51IbWLwTSZltyhyVt8wjtPQ/U8vdCy5bgg7RoOjH/7E9iv
 zrJe7dSlqwnVF+ZurBPQsdT0kNSoXwPHv4bAo0GBAyf3qAkmHdZnyHnOhX4DAAaZ1T4biC4i7M9
 z9btzIp5AUskPZye5ftXNJ4gUZfZ7qo=
X-Received: by 2002:a05:6402:a51b:20b0:68c:627d:fc2b with SMTP id
 4fb4d7f45d1cf-697f3a9dcf1mr1092898a12.16.1782304158438; Wed, 24 Jun 2026
 05:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260624054832.610697-1-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260624054832.610697-1-brian.cain@oss.qualcomm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 24 Jun 2026 08:29:04 -0400
X-Gm-Features: AVVi8CeWFcgS8oHB_DE4oeLHBW9E44pEK9mwc0X1KRB3EYkKHNadGktKEOpYUV0
Message-ID: <CAJSP0QWEAvwfxrh_A6KBuV16t_GUsHx3oh_FvX_hSQGJbj6kVA@mail.gmail.com>
Subject: Re: [PATCH] tests/docker: add flex and bison to emsdk-wasm64-cross
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x532.google.com
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

On Wed, Jun 24, 2026 at 1:48=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> The hexagon idef-parser requires flex and bison as host build
> tools.  Add them to the emsdk-wasm64-cross container image so that
> wasm64 builds including hexagon-softmmu can find them.
>
> Link: https://lore.kernel.org/qemu-devel/CAJSP0QVk6wsOnPAspC4YfXRp90saKib=
QfD4Mk-44-RQo0k=3Dz3w@mail.gmail.com/
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/docker/dockerfiles/emsdk-wasm64-cross.docker | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker b/tests/d=
ocker/dockerfiles/emsdk-wasm64-cross.docker
> index 8a924816f92..5debbc77d08 100644
> --- a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> +++ b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> @@ -19,7 +19,9 @@ ENV CXXFLAGS=3D"$CFLAGS"
>  ENV LDFLAGS=3D"-sWASM_BIGINT -sASYNCIFY=3D1 -L$TARGET/lib"
>  RUN apt-get update && apt-get install -y \
>      autoconf \
> +    bison \
>      build-essential \
> +    flex \
>      libglib2.0-dev \
>      libtool \
>      pkgconf \

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

