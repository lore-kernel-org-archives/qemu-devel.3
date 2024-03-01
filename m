Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BEBC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6Jh-00031Q-RR; Fri, 01 Mar 2024 12:05:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rg6Jf-00031E-8s
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:04:59 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rg6Jd-0001pf-KF
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:04:59 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412bfacd146so11787245e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 09:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709312696; x=1709917496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U0SVkWZ287VsA2vaQE9YUgFxRLNSKhBj7D1UBCLlddM=;
 b=o66aR5jHTHC5UNDMvq39F8WuL7xHE7Rreo3ac2g7P76f7LRZqoQvt3NFV4w7P1coqp
 Y9eZV5Q+/iynUknqdI0TNDtNY7CDOchGw8sHet12VmZTMnp3kItT7hreL6nn1sb2CEnb
 Tl7KTBT3KUvNdP38q8U8eixPXD+JIDxSiZ4ALumlrMrtw/HeagbCU97w+BWdgwSGdVh5
 Z60Lry2AohAfRbk5Y/2GWvnFGru9XwvzbD9TKvlJ10v5we4qJLAdaayTR6pSUHJIUBm3
 mlzZYDn/+eAF7/bXNQvLVwBBIbPqXOU87Tim1PX5GkdXSBWzsWbMNdSiAUFxvaQv6DD7
 GjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709312696; x=1709917496;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U0SVkWZ287VsA2vaQE9YUgFxRLNSKhBj7D1UBCLlddM=;
 b=iCMmQpRz41x7T91pjRZTmaZXE/QyRvQV64AOMBA5buNn58Q18TeSOREdy+O9HL5/ic
 z4LWecU/xRdxvIDYDXPlQWPBFpGY29cqFWVZLnPikvE6DZP4DdGoE+CbVQ4aS4YEGvT7
 Ae6ctMWw5IEpe/Xr83/vs2wTScnA7Pnmp+dR6N43Yl7VwEN8pUnk6iw3hSCt6KNLSPv0
 5cHJjlYNNweZapqA08gTsczA6bWm9AVtnCiFNkenQ1FofssQoSr125+dn4c3Vjb+ehX5
 qB0ICdPkamNzE5mqV7mpPYEoyIYK9H/zwpHBI+f4BiteTUzsWXXV/C5FDNixybB/DMis
 8slA==
X-Gm-Message-State: AOJu0YzVrH1IjZ1E6O7lwe57em0nuZbh6FhM1wpSsmrxYdlLDIgojJ6/
 xDgbBsdk1wwWJ7UGRqxxWBdgwdYb97Bjw78ANxeqEkD/JwCFUwkbEjf6WP00ieU=
X-Google-Smtp-Source: AGHT+IFGINyKfhgM5wfVXiEgGby/TkVeggLc33mgqKsuVxQu/COGnXnJ0+0a16oyx2xbAaVW0cGQ3A==
X-Received: by 2002:a05:600c:3b07:b0:412:c7c3:cb19 with SMTP id
 m7-20020a05600c3b0700b00412c7c3cb19mr2749650wms.4.1709312695771; 
 Fri, 01 Mar 2024 09:04:55 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 jn3-20020a05600c6b0300b004128e903b2csm8902342wmb.39.2024.03.01.09.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 09:04:55 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB3155F881;
 Fri,  1 Mar 2024 17:04:54 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Vikram Garhwal <vikram.garhwal@amd.com>
Cc: <qemu-devel@nongnu.org>,  <sstabellini@kernel.org>,  <jgross@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu <peterx@redhat.com>,
 "David Hildenbrand" <david@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Subject: Re: [QEMU][PATCH v3 3/7] softmmu: let qemu_map_ram_ptr() use
 qemu_ram_ptr_length()
In-Reply-To: <20240227223501.28475-4-vikram.garhwal@amd.com> (Vikram Garhwal's
 message of "Tue, 27 Feb 2024 14:34:57 -0800")
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-4-vikram.garhwal@amd.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Fri, 01 Mar 2024 17:04:54 +0000
Message-ID: <87ttlp51e1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Vikram Garhwal <vikram.garhwal@amd.com> writes:

> From: Juergen Gross <jgross@suse.com>
>
> qemu_map_ram_ptr() and qemu_ram_ptr_length() share quite some code, so
> modify qemu_ram_ptr_length() a little bit and use it for
> qemu_map_ram_ptr(), too.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> ---
>  system/physmem.c | 56 ++++++++++++++++++++----------------------------
>  1 file changed, 23 insertions(+), 33 deletions(-)
>
<snip>
> -
> -/* Return a host pointer to guest's ram. Similar to qemu_map_ram_ptr
> - * but takes a size argument.
> +/*
> + * Return a host pointer to guest's ram.
>   *
>   * Called within RCU critical section.
>   */

If you end up re-spinning it would be nice to kdoc this function and at
least call out size as a return by ref and optional.=20

>  static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
>                                   hwaddr *size, bool lock)
>  {
> -    if (*size =3D=3D 0) {
> +    hwaddr len =3D 0;
> +
> +    if (size && *size =3D=3D 0) {
>          return NULL;
>      }
>=20=20
> @@ -2207,7 +2181,10 @@ static void *qemu_ram_ptr_length(RAMBlock *block, =
ram_addr_t addr,
>          block =3D qemu_get_ram_block(addr);
>          addr -=3D block->offset;
>      }
> -    *size =3D MIN(*size, block->max_length - addr);
> +    if (size) {
> +        *size =3D MIN(*size, block->max_length - addr);
> +        len =3D *size;
> +    }
>=20=20
>      if (xen_enabled() && block->host =3D=3D NULL) {
>          /* We need to check if the requested address is in the RAM
> @@ -2215,7 +2192,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, r=
am_addr_t addr,
>           * In that case just map the requested area.
>           */
>          if (block->offset =3D=3D 0) {
> -            return xen_map_cache(addr, *size, lock, lock);
> +            return xen_map_cache(addr, len, lock, lock);

I did wonder if len =3D=3D 0 will confuse things but it seems xen_map_cache
will default to XC_PAGE_SIZE in that case.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

