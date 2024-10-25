Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA08ED10399
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 15:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4MeO-00061k-Tl; Fri, 25 Oct 2024 11:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1t4MeM-00060v-96; Fri, 25 Oct 2024 11:54:54 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1t4MeK-0003lB-Q7; Fri, 25 Oct 2024 11:54:54 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e3d523a24dso1695570a91.0; 
 Fri, 25 Oct 2024 08:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729871690; x=1730476490; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EmNitsDmnY1x5cCTcNSoGI3ApEz86Deu5rvkm83X2t0=;
 b=VySR7QaYM/qx2C/b77g5H7dIhVx//gVhLxG7G4EGcABkOOopT9OPpO4b/8qYu0NM7K
 IpoCKhBAsGGoYOTiQ02IR1ALrnFOnqTQ4xEYkXmYg/0o5VUlOTcApOONU6J8JjfVQVHf
 Iue+BGPy6ARhXz6vE91UsXpcX1tQ/trLBitUToCfOP7yoE23l7ioL2/9/tBDeobq0IOl
 l9+lWBDSiWdq+I7W9BkDSaitY11cTQHMyiPValLXUdJPqjryogwGrvBGP81AoCd8YKiS
 BfAVu167iDgsbbOI4IaMDz5J0Q4zl9QlqQ2aYhNSBhSZWpmvnrVXRviwf9Uki3r9fK3b
 Kk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729871690; x=1730476490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EmNitsDmnY1x5cCTcNSoGI3ApEz86Deu5rvkm83X2t0=;
 b=b+NMynJXsMeKi//d4mwJHc6OsY8NQm0Q3/02pkMxgwKobaCOF18Ia03SjY9yZ6G9uO
 fyZoBvKYjaEy5PVht6qUK+vJXfN1TDoyYQRpbscdJRWOiWKhXvkO/yYsf73+ZDFEdaJ0
 OgWKk+pEsVc/3yYItZxWOWkqn+ETp05KjVXiQWm2Hw/BVpw0kaVOtiQ+/sYlWO7b524j
 Uolkem7+sMVLRgkm9L0YcRHb/Zz5oUJYpNjZzjMfr6ULcFQGKwoTs0Hs7v5my/lJYLAI
 6Et3MGi7EG9MqIG9l18Mr3SbCA1VskBE8Jnbcp8ZVa6b7ddudPimqv+ZT6Z4xkXi8lBi
 Hcwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiuyYf6UE/DwtOXcgoqjyDyg96Na1+zkunBX/GIMutpNs/gXaQX7PHR2A6BusgsGmmTmLGzUlrhrij@nongnu.org,
 AJvYcCWEaSx164aA0nKc+A9DtA/i4ZrJ1uYhw0B6KotowI3kha7/ZsMMvHxp3LRMxW5iLw89B8MIOVhXAS6Caw==@nongnu.org,
 AJvYcCXgLEofsEtRtqPdn8cm5PQ2/U1QPpytZk+9CcyNFnlK6RBZPSyKlJeoGdFnjkobPFRMLibT/LcQ0gg=@nongnu.org
X-Gm-Message-State: AOJu0Yy1Q+16U1+iy6hMOaQG0LEbQeyqHsAfj9F5fUFk+R0kY63qDXSg
 1tKNKjoX21ltnoEhqV7blQL4wQTkHXJt79PYalW4ORfPbfxEbr+kV7hgOXaGwKMFNI+7ENfV8fa
 oQ3t6DkBqMGfqyhQLAleTQTizC+Q=
X-Google-Smtp-Source: AGHT+IGmgu91ap8rnjy5z32bZYwPYzaTfW/kM34EqlqKrDdWiIg1yZPUxZYNjDPDBtvD0kjJnVbBMIcsPBNNcTN0mRY=
X-Received: by 2002:a17:90b:110d:b0:2e2:d5fc:2847 with SMTP id
 98e67ed59e1d1-2e77f710f93mr6733204a91.30.1729871690074; Fri, 25 Oct 2024
 08:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-15-peter.maydell@linaro.org>
In-Reply-To: <20241025141254.2141506-15-peter.maydell@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 25 Oct 2024 08:54:40 -0700
Message-ID: <CAMo8BfJT82ztbZfHwT8UkpJpaK-4H60MwOk2T_F_tptnLg907A@mail.gmail.com>
Subject: Re: [PATCH 14/21] target/xtensa: Explicitly set 2-NaN propagation rule
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-ppc@nongnu.org, 
 qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.866,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 25, 2024 at 7:13=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> Set the NaN propagation rule explicitly in xtensa_use_first_nan().
>
> (When we convert the softfloat pickNaNMulAdd routine to also
> select a NaN propagation rule at runtime, we will be able to
> remove the use_first_nan flag because the propagation rules
> will handle everything.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/xtensa/fpu_helper.c     |  2 ++
>  fpu/softfloat-specialize.c.inc | 12 +-----------
>  2 files changed, 3 insertions(+), 11 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

