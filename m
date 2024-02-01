Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC000C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 23:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVgCp-0000aS-KB; Thu, 01 Feb 2024 18:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rVgCg-0000Xg-6U
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 18:10:42 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rVgCZ-0003Up-L2
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 18:10:38 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a354408e6bfso448961766b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 15:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1706829032; x=1707433832; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eNZ7MKiicg2Ou2NqE/YMLDKvR4Fq9GTpuzKjLeAck9o=;
 b=XHyAc8rYCLzMexIHss6ocucKw+HpIZzp60dpILiwwPywXeohK7n8+Js+N9ZUqiXOYW
 elXdiuTmeQ0t1/Y4mFd/GriFcEKg5mveW6tu5/1SvmRaqf/ojIfhOBK0slqHyziUvi8F
 6R01YldlH37WsLMJSLRF5LXHO4Ru+ooYesSjcHKSTUSWtymoxFD7hUuzV3Df0fubVumr
 YRkjJxAPFkiCmo6zfcyUEgiugU+37DFLPtLKB8U/D9uWlqj+u51uhC6KTuSvXUslhmKP
 9s9QPFq5/oKtBDiFWTMO9lXBjn+zgi+lh7wRPGNEVQ0XDAFsCct+tQiPkZEHxQPK3FDy
 UbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706829032; x=1707433832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eNZ7MKiicg2Ou2NqE/YMLDKvR4Fq9GTpuzKjLeAck9o=;
 b=U9DALAIz1vzz78zVjq8nEGEUpFy4LQp+QOEYPKgOOA0OYp2aqIvibBlPJ679nCFVO4
 h65XDRUtYj2Jx0PlZvGY3WkbMgk5vzD8WboJBC3tRdTwy37zqBNJCJMxUxM/Rgsin8jZ
 qqo7ZAgP7urphgvlLgkhWchJUp8J+8wTe3MLbz0ATyL8hqwU8Yxin6lCsjaeqx7fxByo
 FTaIfTBpKB7JqpZlikwDXc3ZRezmyMdwiCHlF1Ls7tSaw0cYcNNwwAfY7rX/Wm2agbKl
 RHo9vE9VGBem6MOEN4XB8xhmV/k13Tiq0T9L7Ph1dB4ratJI+FGKXpFk3GenRCNHtRir
 68Rw==
X-Gm-Message-State: AOJu0YzBXyh0Uu7gLwwxM8wek3i6IPXzFTZkSSR/U60ykkZHQoHgoU6A
 ugRySo5IL98Fd7VsPFEpPMl1n1pZpPwsk5QVJH89awfXx3ofocsnutANAHKgmuuAAVHMkiDHUT2
 Osiy+SnmYObFf7hW9+7dGgh37tJE9z+M/wIPmHg==
X-Google-Smtp-Source: AGHT+IFYjLS1BsIM6EAZEfAMXdexMZXl6ffD7XNVBDYv0WIbgcfK4jNy1mFmcb3FKaltHxZ2KaTbJCIK4SdDKFZSaPI=
X-Received: by 2002:a17:906:6bc1:b0:a26:f7ea:7cb6 with SMTP id
 t1-20020a1709066bc100b00a26f7ea7cb6mr329748ejs.16.1706829031811; Thu, 01 Feb
 2024 15:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
 <20240104004452.324068-16-hao.xiang@bytedance.com> <ZbsrEcDbm_F4U0Hj@x1n>
In-Reply-To: <ZbsrEcDbm_F4U0Hj@x1n>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Thu, 1 Feb 2024 15:10:20 -0800
Message-ID: <CAAYibXgasZU96zKmg688xKTBBUdUjOB4TvpQCbm=A5qq2AeBwg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 15/20] migration/multifd: Add test hook
 to set normal page ratio.
To: Peter Xu <peterx@redhat.com>
Cc: farosas@suse.de, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 31, 2024 at 9:24=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jan 04, 2024 at 12:44:47AM +0000, Hao Xiang wrote:
> > +# @multifd-normal-page-ratio: Test hook setting the normal page ratio.
> > +#     (Since 8.2)
>
> Please remember to touch all of them to 9.0 when repost, thanks.
>

Will do.

> --
> Peter Xu
>

