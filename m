Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DF6CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 14:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwM10-0000SH-8f; Wed, 10 Sep 2025 10:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1uwM0x-0000Rr-HN
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 10:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1uwM0s-0000U0-G9
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 10:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757515286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0NnmC6Lh5v4pZdMl8VvSdVEd96kDWwKqUqph1n3Tug=;
 b=dyvk1+ZOSASkqkLrVAq3MLzmzmG6AjhZZqpnILdqTt+sFmgfM/FEOFNPC4sSnVAOtTOvO3
 skebwTdeOJ3g6Xh94lfVqDZlkQC2gKS0oM+4fUzrerfaGN9tJfE3JgNlvRcoT6xmgdkAkx
 k57NgiWoEAFHY9PtuEmEok6Z4C+Ah84=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-FZqRuJw7MTypNjk7yYi41Q-1; Wed, 10 Sep 2025 10:40:13 -0400
X-MC-Unique: FZqRuJw7MTypNjk7yYi41Q-1
X-Mimecast-MFC-AGG-ID: FZqRuJw7MTypNjk7yYi41Q_1757515209
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8080713fa17so1449130385a.2
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 07:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757515209; x=1758120009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W0NnmC6Lh5v4pZdMl8VvSdVEd96kDWwKqUqph1n3Tug=;
 b=f3kCSTF9J/nXMA7gIX39G9JGytda2ERvuZRh+/EEgMuqfy8DMwU0FogR+7UsvPZSs5
 O/vQO1FPzE8Rg1e4FDyaYhop9k3CETmAzjp5+WlFcYJ231s+rZXTIWFM1k+mOoDIkvlO
 OHzXrlx3g7DazEMtGdVUsgZzCmoBzGZ5MhfCOywWD7GXtlkN4ABvG5NacD6gTYvUqNeE
 YX8ymUsIehoeE+LjrceMtvAQUJ7Ll9qyE8p5qFr0ZDCknPTg6UgGouMdMPdjyiuljEbo
 ReYr8kAT3QPWkmuypScRj5ylOSIUfgo7GIsN8eeOEclw/YgU1FcK6Jbb9bL/lU5G1q6m
 RgeQ==
X-Gm-Message-State: AOJu0Yw9Hg55FqAvlzIYg1BcnvB7I3epNVVTkHqpnoRegES19gzpbTg1
 sUzX7FZcEVyp/QHxteLasVNY4LJk6iS/iffnv2bSZBnT9/NEduX/3tjOCJqp3wT6PrN91hluRiv
 HkBcMHbi7QKSKiSsQ4/51wVEdn9+0pdjOk32Mtbl/K1hqEwsO0hPQ1p8SYMyVpEAukaF1jlEdGv
 YXNIoq137wLs07YjxgvBAYiUSYWOioUbM=
X-Gm-Gg: ASbGncupYWp2ny4V4enl7GviZffyWayy77NmHu524WWjuby76JqQU93n6O36mJ143JS
 uuIYqvdwg0MeNA6AscekUfBMd0b4hBlYGkMMS/b6n0lYri4sXBSDYpiNPCAcuEj7QNLYDgJxmqL
 1kwbMMMzk4G3cvgTXSo9s3z6iuyAkczmyrkbXI6h9V5AA8GYY0wXchK2Y=
X-Received: by 2002:a05:620a:3909:b0:813:a1a8:d4e2 with SMTP id
 af79cd13be357-813c39a167dmr1415887985a.74.1757515209437; 
 Wed, 10 Sep 2025 07:40:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXj+tvPS+3GMXelwQXFDP4hfDNSDdnw//gi2UueBMfreWysEfrzXsTfGWmIyhT9S4jOuQPdTezHG9JviU+WYg=
X-Received: by 2002:a05:620a:3909:b0:813:a1a8:d4e2 with SMTP id
 af79cd13be357-813c39a167dmr1415883985a.74.1757515208802; Wed, 10 Sep 2025
 07:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250910121501.676219-1-abologna@redhat.com>
In-Reply-To: <20250910121501.676219-1-abologna@redhat.com>
From: Kashyap Chamarthy <kchamart@redhat.com>
Date: Wed, 10 Sep 2025 16:39:50 +0200
X-Gm-Features: Ac12FXxMcycCUaP5UKacl-2FJuV8UTGFs03EUzbojKwGUQ2zGjdMAAhAM02q4ag
Message-ID: <CAJ=Wi4qhxwZH3d6gN4nJf0Ei3ECu9GFPZvhVjG_yu0zYkdnNww@mail.gmail.com>
Subject: Re: [PATCH] docs/interop/firmware: Add riscv64 to FirmwareArchitecture
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 10, 2025 at 2:15=E2=80=AFPM Andrea Bolognani <abologna@redhat.c=
om> wrote:
>
> Descriptors using this value have been shipped for years
> by distros, so we just need to update the spec to match
> reality.
>
> Signed-off-by: Andrea Bolognani <abologna@redhat.com>
> ---
>  docs/interop/firmware.json | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index 6bbe2cce0a..ccbfaf828d 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json
> @@ -85,12 +85,14 @@
>  #
>  # @loongarch64: 64-bit LoongArch. (since: 7.1)
>  #
> +# @riscv64: 64-bit RISC-V.
> +#
>  # @x86_64: 64-bit x86.
>  #
>  # Since: 3.0
>  ##
>  { 'enum' : 'FirmwareArchitecture',
> -  'data' : [ 'aarch64', 'arm', 'i386', 'loongarch64', 'x86_64' ] }
> +  'data' : [ 'aarch64', 'arm', 'i386', 'loongarch64', 'riscv64', 'x86_64=
' ] }

Thanks :-)

Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

>  ##
>  # @FirmwareTarget:
> --
> 2.51.0
>


