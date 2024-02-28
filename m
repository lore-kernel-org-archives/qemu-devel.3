Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB27C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIPR-0008Gy-Io; Wed, 28 Feb 2024 06:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIPP-00083d-Cm
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:47:35 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIPN-0002Rp-MK
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:47:35 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412b6a3326cso1590025e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709120852; x=1709725652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBlfxNw3gAKpxrdSQ9Qug4ldN7qkY9TndOwoeLSAcIA=;
 b=LnJXySRHJK8urjVsCOROaA5yNartJiLauFOanI7GkeokTcaYp+M+GynYV8aNhdut+O
 eEgjW85bmK0ZRXSFlG1JiFsWC8m5OlMGW1Z/gVgAFShh0PRR8xZYRmWBaAAMqEypcbIf
 /MQ+E9g9+lRrPsO4Ffi3/WDRWFMGtPJG4sWmfYruxOm3/6sGFLAfDb1GmxE4JwU+MckR
 3DvZafmA0fdMmQv3m4E4Po2RhZzOq2lkqXhLzo2n3MsrxOPwedV46mr0hrQfH8Jl6ku/
 PDD2JBTUl37wWDXV6wjqcnhM3Nc0f/Dd0fqq7MLYMaSZqwL4ykuCpMS6/NJKa7VyYFYj
 Cfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120852; x=1709725652;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MBlfxNw3gAKpxrdSQ9Qug4ldN7qkY9TndOwoeLSAcIA=;
 b=TJBx71oe97pXbRAEcBA9pSwnwRD2Pr34E86052PfUk0UrQADZlw5e5+YtTh4UeKavW
 0m9fth8Sw8bL+5LZMBi9BYr+V84WNYf5v6MNJznXEnpTSfdaBh1+01WcUR4Feuvxsmgd
 1CMn1j7yKgcmgIFieNbnTLGPOiZuJJM0oKZCSMMdo1CLK+baqrE9Ern/XNB+qr56zpNf
 tJELmAZrzIwiyYaMlI3qZmkFtm6o6Oec7zQLu3lZRvZgxdv4BRibA1u1EgdZ3XiKv/8M
 eJHlArpSra9VU1O/0hFdDtZ0+k9FX3TrTTAeBnqjtSZUPCYTzIENB/49qHVxr927gsgx
 CfHg==
X-Gm-Message-State: AOJu0YyEuqLgGcnrewXzT4or9LmHZmfs1GI4/9ESqVeebZ98hAeotimS
 g9e2zmla9rxMorC3qDHB+1NvaMf5GMdlTrO5KVToVSf2V/ow9uqr7nAGhqY0614=
X-Google-Smtp-Source: AGHT+IHieIOuCNIOBc2G/kBji2uPgrMFKDRkuLZkqLwZY6K7zXvJp+lgqMDWPUx9I3U/U7Tzlh7j4w==
X-Received: by 2002:a05:600c:1988:b0:412:aec6:484f with SMTP id
 t8-20020a05600c198800b00412aec6484fmr2125123wmq.15.1709120851988; 
 Wed, 28 Feb 2024 03:47:31 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l18-20020a05600c1d1200b00412a30cd127sm1962513wms.7.2024.02.28.03.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:47:30 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 291D05F7A0;
 Wed, 28 Feb 2024 11:47:30 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Joe Komlodi <komlodi@google.com>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  peterx@redhat.com,
 david@redhat.com,  peter.maydell@linaro.org,  marcel.apfelbaum@gmail.com,
 mst@redhat.com,  philmd@linaro.org,  roqueh@google.com,
 slongfield@google.com
Subject: Re: [RFC PATCH 3/5] memattrs: Add user-defined attribute
In-Reply-To: <20240227222417.929367-4-komlodi@google.com> (Joe Komlodi's
 message of "Tue, 27 Feb 2024 22:24:15 +0000")
References: <20240227222417.929367-1-komlodi@google.com>
 <20240227222417.929367-4-komlodi@google.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Wed, 28 Feb 2024 11:47:30 +0000
Message-ID: <87h6hsbyjx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Joe Komlodi <komlodi@google.com> writes:

> These are used to represent implementation-specific data.
> These are based off of AMBA-AXI user signals, but can be used in any
> implementation.
>
> The length of 4-bits is arbitrary.
>
> Signed-off-by: Joe Komlodi <komlodi@google.com>
> ---
>  include/exec/memattrs.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> index 942b721be8..a38645f881 100644
> --- a/include/exec/memattrs.h
> +++ b/include/exec/memattrs.h
> @@ -64,6 +64,8 @@ typedef struct MemTxAttrs {
>      unsigned int target_tlb_bit0:1;
>      unsigned int target_tlb_bit1:1;
>      unsigned int target_tlb_bit2:1;
> +    /* User-defined bits represent data that is implementation defined. =
*/
> +    unsigned int user_defined:4;
>  } MemTxAttrs;
>=20=20
>  /* Bus masters which don't specify any attributes will get this,

This reminds me of the concept of MACHINE for impdef bits I proposed in:

  Message-Id: <20221111182535.64844-1-alex.bennee@linaro.org>
  Date: Fri, 11 Nov 2022 18:25:15 +0000
  Subject: [PATCH for 8.0 v5 00/20] use MemTxAttrs to avoid current_cpu in =
hw/
  From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>

which I unfortunately ran out of steam on. Surveying the list I see
there are other patches for MemTxAttrs for IOMMU ids so I wonder if we
are going to run out of bits soon.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

