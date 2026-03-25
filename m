Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C685109C028
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Q2H-0008Or-Lr; Wed, 25 Mar 2026 11:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w5Q2G-0008Od-JK
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:20:44 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w5Q2F-0003Dq-2I
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:20:44 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9825ba7e8dso347644266b.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 08:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774452041; x=1775056841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9oqfb+UbnqnD+mZVlNT/KVysKSkfBG/2rW7oLCdP+o=;
 b=twA2e6jsjeeU9UE8HyoccERu7bZoO8/UR8j4BhG/xHuaieLB5Bzd4Mc+TJ22eY7a3t
 AOhmCPfObC/gFTBYeR4uRPNuWHz00hWt2+Wjwubn8W+az6Z1lRgtKOOOiJ5Mz83vWt0T
 NSpnZpiWvVOkmOKATmMw+w2a3A5pz+yjgsvHTwo2gRjeilx1PB8x9cOd9mw2mDhn+SFi
 rKE91a6k30qzmOSmAXxtgRXSihee1cHo9He64eiFMJBYFm7P9dvCLnIcA9FH3+VOMtki
 KXpn4poN4+6xNeWGg89b5f6YcUxi8pWW2WibpktRxstSGzCGVhvadRMKLonIUblR7JDJ
 7DfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774452041; x=1775056841;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g9oqfb+UbnqnD+mZVlNT/KVysKSkfBG/2rW7oLCdP+o=;
 b=AwrzSXYkGukbWhiNCURj+Dt0D4Fz8ii1GAbp5CudvU65isE4CqbJy5UNp0Leb5x0Do
 xBbpNsVsiEaKNy3HFIgXDevvUNZUwqZg2a1xPGZw0M+KXbUtJn3bZ2rii1ecVFfDDTUq
 m8DTX6Nca/KhVYqL2lfgsyOAWXvTTC8szsuGmcuG1I5O7+aTMWabFStMZ1s1I3Sxwoh1
 WCbkfYQG7Wwe+Z33xosTck/v+HkPdPkylzBaIKOdqHfd88VXOUzSlGHrdeI5mhYKlxr/
 vqIAqu5b05hAcCH9o4PJq4juK7SfVRdvmM09CS5mUCcd3eqHBPkCDqc6Ifx7eifWVHRI
 7f3g==
X-Gm-Message-State: AOJu0YznKXCAuD5pK2MToP4ZFf//HS8EMFOrRCW2izqTWks34VZvJE+4
 +VKkXU70c4smgDqHNc6CaIHLX7X3Jhu8zN0ee9xY8ttoo8Q8r/hpvhXEgE6NT15K4wwpHdOd9cP
 uN4u54uc=
X-Gm-Gg: ATEYQzwzYUs/365ndffwEOLmh3BSCKRNK41C9V4RLDGELoNCobwAZUHyJzfdyOfbOyn
 7nNkjnR5veRYMGEu0aaeSyw9K4g3LHAfd/9hrD7TUNf8SLyRRr+xPj/s/KvMfBQmBCSFU5hiXCm
 2xPHNwO0uVXD7Jfr38T5MVcFIU0OPZ4OrFfGXijfIk/1ZZTLc6/w8ZpBR1zCI3E9IpWi5Q9PH/w
 7L5PVPGLF3GAYPTQqrJwFj+OrAFHpyScx/CqybpTymHEfUqiSaaezvJhM5zZgXYSCuwaBWkmFLx
 o4xHsID1iWmtaOGdSeKq75HV98LOpJ8f9eBx80AokFgFhMHd/yvwl9TBfuGOCsxXQXn9igeiFFR
 5PnNtC7LoNaOMQRYNuPffffS4DKJqseTe7Z2Ydn4Nn5ggcqD5HrJa4CGshnC7sVwn3zEcElUMYP
 Ljrd5GTF2N014AfG56XGm92kE=
X-Received: by 2002:a17:907:1999:b0:b97:89b5:d7a0 with SMTP id
 a640c23a62f3a-b9a54288647mr271153566b.48.1774452040942; 
 Wed, 25 Mar 2026 08:20:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b98b20c8c7bsm223934566b.63.2026.03.25.08.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 08:20:40 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8C1C35F878;
 Wed, 25 Mar 2026 15:20:39 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 3/3] tests/tcg/plugins/mem.c: fix endian swap in
 update_region_info
In-Reply-To: <20260325024252.3369186-4-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Tue, 24 Mar 2026 19:42:52 -0700")
References: <20260325024252.3369186-1-pierrick.bouvier@linaro.org>
 <20260325024252.3369186-4-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.14.0-pre3; emacs 30.1
Date: Wed, 25 Mar 2026 15:20:39 +0000
Message-ID: <87qzp82awo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> value returned by qemu_plugin_mem_get_value() is always in host-endian
> order, so we need to convert TO target endianness and not FROM it.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/tcg/plugins/mem.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
> index 1ee257f855b..6b0732dc0fd 100644
> --- a/tests/tcg/plugins/mem.c
> +++ b/tests/tcg/plugins/mem.c
> @@ -154,20 +154,20 @@ static void update_region_info(uint64_t region, uin=
t64_t offset,
>          val_size =3D 1;
>          break;
>      case QEMU_PLUGIN_MEM_VALUE_U16:
> -        swapped_value.data.u16 =3D be ? GUINT16_FROM_BE(value.data.u16) :
> -            GUINT16_FROM_LE(value.data.u16);
> +        swapped_value.data.u16 =3D be ? GUINT16_TO_BE(value.data.u16) :
> +            GUINT16_TO_LE(value.data.u16);
>          val_ptr =3D &swapped_value.data.u16;
>          val_size =3D 2;
>          break;
>      case QEMU_PLUGIN_MEM_VALUE_U32:
> -        swapped_value.data.u32 =3D be ? GUINT32_FROM_BE(value.data.u32) :
> -            GUINT32_FROM_LE(value.data.u32);
> +        swapped_value.data.u32 =3D be ? GUINT32_TO_BE(value.data.u32) :
> +            GUINT32_TO_LE(value.data.u32);
>          val_ptr =3D &swapped_value.data.u32;
>          val_size =3D 4;
>          break;
>      case QEMU_PLUGIN_MEM_VALUE_U64:
> -        swapped_value.data.u64 =3D be ? GUINT64_FROM_BE(value.data.u64) :
> -            GUINT64_FROM_LE(value.data.u64);
> +        swapped_value.data.u64 =3D be ? GUINT64_TO_BE(value.data.u64) :
> +            GUINT64_TO_LE(value.data.u64);
>          val_ptr =3D &swapped_value.data.u64;
>          val_size =3D 8;
>          break;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

