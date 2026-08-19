Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D15C5DF87
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfdt-0008EL-A9; Wed, 19 Aug 2026 08:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwdeW-00070O-ES
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 06:36:12 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jinpu.wang@ionos.com>)
 id 1wwdeU-0002eS-CJ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 06:36:12 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c20e4487bdaso9548666b.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 03:36:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787135767; cv=none;
 d=google.com; s=arc-20260327;
 b=cmwjAKDz3AIgN7zELI1aBI8aEfVa0m+M1Pmb4fYSwDuZ+pNsAHFrshcedrynH9HUVe
 s4n8tSHecnppHodYj4WI3tNLE49He3P33NX3uaNsUIw7SZo9xGwDEJoTA/chg7B1OFy8
 Un9a4VQiav0xbvuJDV7F+0YJGhvHioTavmG/d9LZa/4bndvSk/MXugd8LTPIwzzURoGF
 Vv/YnjvnRiREaQeQEaDhrawz+VJFE6Jx3ZP6iOLXFaMsBwcUma5TgpKmWCTIMxAdp09L
 Yp9XCuEQqmfixF3h/mf9wbJ8ZqD3qOrSnnA+jeVqRsGcdzyVb9WFK1jrHyfWHaxn1Rcw
 BnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iqAnK7mx6tY66v4nNIoAoWHA/MlvEqZU6WMpvEjCj78=;
 fh=QWNbaIaVQQou6IzIMV0ib5reMaT/Wr3DV7egi1JIcps=;
 b=kFNZV5E6Erv9yu1lQ4pU088+RnPDCJDo6k8vlvM6Qjd+sJIXnP3+acJ332lPBqvA1u
 awPZ5U1YrDndjSblknjuKomn4GQb0MEsjIFFt3q82mPYWxSiBBM89eqOzXEDbUvUeBB2
 Ho6qE6ZBOVhbeTlj5NCty69SzBtcDM2mxdvrMvC/GlasFBzCDTjFNMkAdG1tjLrjYd1p
 4WPryO3AF/BD3Vcm3MqaP4dG8isBPbgadpDUWS3P33twFiEtwzyJHgHFPRouJphOxzra
 r8GBsR8m0Tot637LfLukWbRvVVF8k/a36WqQOMvf2jIc6d7PtcuW+8yBZsvtuyYrh3zN
 PnCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google; t=1787135767; x=1787740567; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iqAnK7mx6tY66v4nNIoAoWHA/MlvEqZU6WMpvEjCj78=;
 b=RprahKsS2QmDPmqIr/1K6FDdqBN8j3FZUmNYw35yq8ksoLzkTadMEG6fVOtHC4zyT9
 IT/koz8BBDEL6ZvSbKBWtyxXCj4omGOAzuFuBx9vaC/4dgSQDwaSISA2hAwEAqY7hsRW
 9L3FVn0QohMnn+C2zqkn/XYo5BBTujPhDetYQ0sIF0Lj9rtF9HfMSZU2SupTLN7mEhfa
 ithQt7U6x6RX4objVtwY3QruYiPiHixhBbBqPL94+97eKv6iFOFMZGzhHdO6XPIdog30
 eARZAVEQxD+Gr7MdWIVSyZ93rJT72ZFkjYHfZ16uTdqe6Ft7OvWV5PY5GPEe/GOkO6U1
 y59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787135767; x=1787740567;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iqAnK7mx6tY66v4nNIoAoWHA/MlvEqZU6WMpvEjCj78=;
 b=YFSaL9utq8+SvQHMyUznhl40cm4NFLKPRRFZhscgigdBakobkzbISlqT2K+78K/GYt
 25RPI0W6YXFbiH065uGH9Uj7MQ3kQT6I6WTJ7tAAIbabQ6bIwCR3ODpfqIUQV/rf68aq
 teKX5HGKEntQBD746kpQyP8u0VEHqdInbiYLiRFkV8M/f5/cykgPuitXpF1vnyx3wij0
 JkrL/aHJ10WmXV25+Tqc7lYBw9wXB0fjRpjp9HYbWT7Xvnh2cvHzdvdL0jGdKJYTqIeA
 mVxBrnOqD/W3XjYamMGQSkIcHKHXlFJtyIODTgbZU4EtkGuVU1ILg50syiAK+IUIPblO
 YbyQ==
X-Gm-Message-State: AOJu0Yxb3h5E3/FcX5nNvewPM6ULvKCYI6rFUEFl55+LG9B1sCleC7Jh
 AUMa7LVhtyB6U7z1pFCqMxnLXhDdYwmL+RYVR31hziyd80q8jQaQGjFQv39BTabKD8SFn2Ec5U3
 gY0c0FxtQfZMyIpHTe7Exr4zQkDiIhPP8a+aZlmiwLg==
X-Gm-Gg: AR+sD12z5CoMFtJWq7XQzokJnIdzZejm9Y7qfqmTR718LuMUcHfDnxnVGraC4mfjDQ0
 5LOVa0YVzLdrpA844rqmnnVIAOk1J63bWh750fhN6/gIvxkhfNtSYlQMvf2udSTNk9eYADQLc4O
 bcLc5jfbX4+dg69RGS2Q3XsLC3kJaAOI4FP29/531Uja9cGMUMzjuF6XDB9LmTa19oxZw2agjFC
 v03kPhkfnfGbU3rK9s+gvI2aefiPusIuni0vou2kC4cMf9NKItDdFHIrM195EF8B8mKOhCr6a2a
 Z+I0y9zsC8ESmhyTpQqZGJZofyym1RSRs8CHXy3db20+
X-Received: by 2002:a17:907:97d0:b0:c16:604a:b2bd with SMTP id
 a640c23a62f3a-c242e25f3c9mr118515266b.3.1787135767112; Wed, 19 Aug 2026
 03:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-2-peterx@redhat.com>
In-Reply-To: <20260817202424.2901438-2-peterx@redhat.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Wed, 19 Aug 2026 12:35:55 +0200
X-Gm-Features: AcwNN1Uu3m5rfoRCp0ziAIWgFZlj6kfOcMuf42geNnavKGViMYUVqTk760J3OYM
Message-ID: <CAMGffE=7S4G4xi=4tbwUjaVUaFi+4472vjEVaqEiUHU9+Te2Mw@mail.gmail.com>
Subject: Re: [PATCH 01/10] migration/rdma: Introduce RDMA_CONTROL_NUM
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>, 
 Samuel Zhang <guoqing.zhang@amd.com>, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=2a00:1450:4864:20::62e;
 envelope-from=jinpu.wang@ionos.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Aug 2026 08:43:31 -0400
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

On Mon, Aug 17, 2026 at 10:24=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> Introduce this to say how many control messages we have.  We did it becau=
se
> we're going to remove the last one (RDMA_CONTROL_UNREGISTER_FINISHED) soo=
n.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
lgtm.
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  migration/rdma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 438419d189..62a509b236 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -144,6 +144,7 @@ enum {
>      RDMA_CONTROL_REGISTER_FINISHED,   /* current iteration finished */
>      RDMA_CONTROL_UNREGISTER_REQUEST,  /* dynamic UN-registration */
>      RDMA_CONTROL_UNREGISTER_FINISHED, /* unpinning finished */
> +    RDMA_CONTROL_NUM,
>  };
>
>
> @@ -235,7 +236,7 @@ static const char *control_desc(unsigned int rdma_con=
trol)
>          [RDMA_CONTROL_UNREGISTER_FINISHED] =3D "UNREGISTER FINISHED",
>      };
>
> -    if (rdma_control > RDMA_CONTROL_UNREGISTER_FINISHED) {
> +    if (rdma_control >=3D RDMA_CONTROL_NUM) {
>          return "??BAD CONTROL VALUE??";
>      }
>
> --
> 2.54.0
>

