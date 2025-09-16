Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67551CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 09:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uySSe-00035H-Ce; Tue, 16 Sep 2025 05:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uySSd-000355-7O
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 05:58:55 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uySSb-0006je-CI
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 05:58:54 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b046fc9f359so797701866b.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 02:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758016730; x=1758621530; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5GDkCc8k9k8NvhxDKxnlZQ3BFcIIh0HOlG5+a9C5M4U=;
 b=IGuuwws41QW+VUPXq6VuJAP8SDmEOIvx8eXPJDhTn6YZ/Wv6fRZvu3riwCbwrLyCVE
 N4e4Xab3jMEOKzNOqi9+nAfNrnsdWgVgmERQOfloXJcQ+cQdDvtp2Ay/yuwsS4mw6gf0
 zhjy09wfKUyhglFePjP7PosHVRGrBAsWYyRRm7v8dbvhD2QK0CRd+2SdSy9AllDekLha
 Z7EBdsU/cZlNT/gaw7wRC7dMVk8tvwYe+fI6luG/wDTQi8lM7AZjrpGSMOJJawfyRIBm
 ju0/IW5S6rkSOkbsO+Xs39+lCNIp3fXIcFnUwymwefaoUxAB7NnYoDopBo/B7rOkTub4
 e3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758016730; x=1758621530;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5GDkCc8k9k8NvhxDKxnlZQ3BFcIIh0HOlG5+a9C5M4U=;
 b=n199/Df0ivU77MM8FGp/qHnD7odlWIQ7tkvE979dV5uck84pbxYw9OA+akcdz9O6dY
 zI5xF0hzgC79LxIQHHbL+mnSqdILPBYb2OD/Y3uRkbjmqckjSAARG+gRnCbfFSl3UJQM
 BiUidvfGBansJ2f0RLQUXmDEJbHEBUObZx2J2a7HIFUuNf3lembIaOs0pHtRyxJBAoTW
 aLH8ucx7VYf/ZGaqjRcPK+7+04HOWv7NnRg7yy4iP9UZGcgYWY+9mCrXV7RZyDsyqzOo
 ZymkB7QnIbvdcnd86mMJPeKoONgCgoQvww+UnMzVaadyk7y+x3BNh65CsMFbY3O15hRT
 u36w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLBlqIyi2WyGrmGPSozg9QIUGD1/KjUfChIAzzlP3xs4HEsKZ8dsLUCEMxqfiUzy0h51ZR3i0HP3yy@nongnu.org
X-Gm-Message-State: AOJu0YxTHA/6LfjTG+RYy7YGVhDtrXKSCXm2ZS2JBRrm0tncVC+0QjRq
 DNO7IDUSb1/6REr4HsKNWnpBuDI3qyUkcVvQi/svuoNUYE3d1bOyKB0wLCcAQ3oQNGWgANLrUH3
 f1s58AyMm2kCEhJZhVUxsIG6P2ldhxElCxc4+JWNJ4w==
X-Gm-Gg: ASbGnctiNLBMox3v+1lcDJfa4vLvsmAAp0e9+iaQ0U98H/s/QbnQoLqZcy/B/Kbrd4o
 RxyOAf5xk4oMk3/QfGvDiqaU1JQ7H/4lY1kW1p5T+E5ii3fotidFCpPx5zhgq165rxwGZpgK23X
 FElC96iqzzofGEesAuLyCkiAYltLyyWvEwCnQs/EzDtDl5ucAy/Yl1ktoiVQph3T0a7sf0Zc8GT
 upVtmQ9
X-Google-Smtp-Source: AGHT+IFX/ZsZkHs8lk8Q1qDqAsE1sFXK/zM+wXxC1inQzbcsyPLZ4K3a5hFSCu2yNI5oGzcVB2HuS97lr15u6CRa9ns=
X-Received: by 2002:a17:907:8689:b0:b04:1edf:a42b with SMTP id
 a640c23a62f3a-b07c3547602mr1669266966b.11.1758016729944; Tue, 16 Sep 2025
 02:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
 <20250916085557.2008344-2-zhao1.liu@intel.com>
In-Reply-To: <20250916085557.2008344-2-zhao1.liu@intel.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 16 Sep 2025 12:58:24 +0300
X-Gm-Features: AS18NWCNHuNDQnKhCbIgHEo1BBKmYfCOZUrnzeN10t1afUnCXFE2AgCl0HRaxh0
Message-ID: <CAAjaMXaLvSV=nfd8m4Q-RPTx4jpWisDpeH6J6rgTke4Mox=8pw@mail.gmail.com>
Subject: Re: [PATCH 01/12] subprojects: Update .gitignore for proc-macro2 and
 syn
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x633.google.com
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

On Tue, Sep 16, 2025 at 11:34=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wro=
te:
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  subprojects/.gitignore | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/subprojects/.gitignore b/subprojects/.gitignore
> index f4281934ce11..9d579f72d121 100644
> --- a/subprojects/.gitignore
> +++ b/subprojects/.gitignore
> @@ -16,7 +16,7 @@
>  /libc-0.2.162
>  /proc-macro-error-1.0.4
>  /proc-macro-error-attr-1.0.4
> -/proc-macro2-1.0.84
> +/proc-macro2-1.0.95
>  /quote-1.0.36
> -/syn-2.0.66
> +/syn-2.0.104
>  /unicode-ident-1.0.12
> --
> 2.34.1
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Maybe we could change the entries to match any directory with a version, e.=
g.

/proc-macro2-[0-9.]*/

