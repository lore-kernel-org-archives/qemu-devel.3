Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A798F3D311
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 15:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyAqV-0003y0-Kt; Thu, 05 Mar 2026 10:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyAqN-0003xI-Nh
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 10:42:33 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyAqL-0007QZ-RL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 10:42:31 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b9419e561fcso61801066b.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 07:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772725344; x=1773330144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vc1OU23X0Mtg23wCLwbVaW2tiUjYg/yy7n5MUbPGdZA=;
 b=fHe2k1L/7APnjGDugFm+Luu3Lc1dU10PN4wOz1MXaIoDUsR58dZ323ystxfceNBo5s
 dP3BoJLVc5fHDY9/WihyyuDxPxfHrjmpXAJhDdzHPn2KjdW6/9MMf/8K3vMqhsa4agT5
 lykr+UI6mrEB9PlC/FSOVpd8U4LLIk+U5Sc7PHpKiXcMbtMYCsGceEuhWGRD+EP3TKpn
 8R0UyPMcMk5g43rgsv+QtduGL1nhiGLwrULo/zz/cpep6K41w0GPjz+AHQyzHMfcYZRC
 jwEp2g7TOhh5V564rv/YBV2zHQs5zovt+9xI8OcIBEctvMPjJsPQym+JQS7CRDs/ddEn
 NvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772725344; x=1773330144;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vc1OU23X0Mtg23wCLwbVaW2tiUjYg/yy7n5MUbPGdZA=;
 b=nruA7K+zjgIBQFw45lCuL5+fgPouz4qAY/cQwhW0NOzl8SEIvYaTKdD70mOMUJBBAC
 dfe0wxMkdpnakBVdCPNf+HDCrsY0QZg9jtxBuffZzDakms6zYp8YJGwz6IynXbkTHj2h
 VF47aAD33kTN1cCf8qkyhBYmxoyBh+QkfnnauLec9CBpk//WLbmFPybW9LQI/RMUJ9+o
 IHiGF1HIt6jY6m/wEISVoX+Ky49nNY9LON/m6wbVlg557N2hHmUJwatumofMWe3IFVZp
 4VvteuVrgCDzS0VTJFDgPpFTBZWlbsnzmnpkcvMWSKBLKSiMV+IL1nWIeNnOeZLlb+qY
 8bhQ==
X-Gm-Message-State: AOJu0YzTFPzlC7anA4Pu7OIw9DLDaTJUCJC07AytuR0Uyh++752taCSI
 cCQW3K8gOti9rlL2NJ3S8A7omGPuM3CdOLuaV1e+sGjeZ882cGMG1E7VexsP5VFPoGU=
X-Gm-Gg: ATEYQzyGGTItBeFZF0YQqZzk+iDs9+lZHIE7YrEnutz7y3HWO3pS5bnROWk3PcULQF+
 1x0TiUxJ9sTdYgIJyb+X5JTi2oHQ2ZLTQnaknGd3Xb2ZVoOwYRnOmRrEYpaN97w1S96H0bbUZzX
 pLHxmmCRH3athYcPeEtUXmElLuUgQhMYink8r6YhWdPT5Ts4rxeNQ69qpQhfTI66Z892rIUu+bq
 4i4j7ssA91AQQ8bf71+88D5leO92L/iscjRRXiLc8aljGDnFnpjcwax57qjN+Wv9OqPpCGXZDFl
 l6rN2QNNvy/1z557KrycHK6b2EeTLb/SeHX1wXYFYsvwo3lkF3LP4yrGJqJANF3cVAVRo9QDaMv
 CDMzmXQ76/KKZYrB4+B52qSqtwBeKSEC1LZpnORN4YBLonJaEP6CVAimkue2RhZm+OYzTaKkYqL
 nJgUNeLN7dKLvrTge/b/+ByYwzEczBjHDQEw==
X-Received: by 2002:a17:907:9607:b0:b93:50c8:d126 with SMTP id
 a640c23a62f3a-b93f15d92eemr361260566b.60.1772725344156; 
 Thu, 05 Mar 2026 07:42:24 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9411ee04easm93852166b.63.2026.03.05.07.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 07:42:23 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 726D25F809;
 Thu, 05 Mar 2026 15:42:22 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>
Subject: Re: [PATCH] tests/plugins/tcg/mem: Don't access unaligned memory
In-Reply-To: <20260305120104.1254578-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 5 Mar 2026 12:01:04 +0000")
References: <20260305120104.1254578-1-peter.maydell@linaro.org>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Thu, 05 Mar 2026 15:42:22 +0000
Message-ID: <877brqnuzl.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In commit eb3f69cac62670 we removed the dependency of this
> mem plugin on the QEMU headers, but in doing that we introduced
> undefined behaviour when the plugin accesses unaligned memory.
> This shows up if you build with the gcc or clang address

ubsan

> sanitizer and run 'make check-tcg', in numerous warnings like:
>
> ../../tests/tcg/plugins/mem.c:167:27: runtime error: load of misaligned a=
ddress 0x7f1f300354b1 for type 'uint16_t' (aka 'unsigned short'), which req=
uires 2 byte alignment
> 0x7f1f300354b1: note: pointer points here
>  00 00 00  00 01 02 03 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f  10 11 12 13 =
14 15 16 17  18 19 1a 1b 1c
>               ^
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../tests/tcg/p=
lugins/mem.c:167:27
>
> Fix this by rearranging the data reads and writes to use
> memcpy() instead.
>
> Fixes: eb3f69cac62670 ("tests/tcg/plugins/mem.c: remove dependency on qem=
u headers")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

with the extra clarity on the sanitiser:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  tests/tcg/plugins/mem.c | 71 +++++++++++++++++------------------------
>  1 file changed, 30 insertions(+), 41 deletions(-)
>
> diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
> index 7d64e7018f..f3992abc8f 100644
> --- a/tests/tcg/plugins/mem.c
> +++ b/tests/tcg/plugins/mem.c
> @@ -123,6 +123,9 @@ static void update_region_info(uint64_t region, uint6=
4_t offset,
>      bool is_store =3D qemu_plugin_mem_is_store(meminfo);
>      RegionInfo *ri;
>      bool unseen_data =3D false;
> +    void *val_ptr;
> +    unsigned int val_size;
> +    qemu_plugin_mem_value swapped_value;
>=20=20
>      g_assert(offset + size <=3D region_size);
>=20=20
> @@ -144,61 +147,46 @@ static void update_region_info(uint64_t region, uin=
t64_t offset,
>      }
>=20=20
>      void *ri_data =3D &ri->data[offset];
> +
> +    swapped_value.type =3D value.type;
>      switch (value.type) {
>      case QEMU_PLUGIN_MEM_VALUE_U8:
> -    {
> -        uint8_t val =3D value.data.u8;
> -        uint8_t *p =3D ri_data;
> -        if (is_store) {
> -            *p =3D val;
> -        } else {
> -            unseen_data =3D *p !=3D val;
> -        }
> +        swapped_value.data.u8 =3D value.data.u8;
> +        val_ptr =3D &swapped_value.data.u8;
> +        val_size =3D 1;
>          break;
> -    }
>      case QEMU_PLUGIN_MEM_VALUE_U16:
> -    {
> -        uint16_t val =3D be ? GUINT16_FROM_BE(value.data.u16) :
> -                            GUINT16_FROM_LE(value.data.u16);
> -        uint16_t *p =3D ri_data;
> -        if (is_store) {
> -            *p =3D val;
> -        } else {
> -            unseen_data =3D *p !=3D val;
> -        }
> +        swapped_value.data.u16 =3D be ? GUINT16_FROM_BE(value.data.u16) :
> +            GUINT16_FROM_LE(value.data.u16);
> +        val_ptr =3D &swapped_value.data.u16;
> +        val_size =3D 2;
>          break;
> -    }
>      case QEMU_PLUGIN_MEM_VALUE_U32:
> -    {
> -        uint32_t val =3D be ? GUINT32_FROM_BE(value.data.u32) :
> -                            GUINT32_FROM_LE(value.data.u32);
> -        uint32_t *p =3D ri_data;
> -        if (is_store) {
> -            *p =3D val;
> -        } else {
> -            unseen_data =3D *p !=3D val;
> -        }
> +        swapped_value.data.u32 =3D be ? GUINT32_FROM_BE(value.data.u32) :
> +            GUINT32_FROM_LE(value.data.u32);
> +        val_ptr =3D &swapped_value.data.u32;
> +        val_size =3D 4;
>          break;
> -    }
>      case QEMU_PLUGIN_MEM_VALUE_U64:
> -    {
> -        uint64_t val =3D be ? GUINT64_FROM_BE(value.data.u64) :
> -                            GUINT64_FROM_LE(value.data.u64);
> -        uint64_t *p =3D ri_data;
> -        if (is_store) {
> -            *p =3D val;
> -        } else {
> -            unseen_data =3D *p !=3D val;
> -        }
> +        swapped_value.data.u64 =3D be ? GUINT64_FROM_BE(value.data.u64) :
> +            GUINT64_FROM_LE(value.data.u64);
> +        val_ptr =3D &swapped_value.data.u64;
> +        val_size =3D 8;
>          break;
> -    }
>      case QEMU_PLUGIN_MEM_VALUE_U128:
> -        /* non in test so skip */
> -        break;
> +        /* none in test so skip */
> +        goto done;
>      default:
>          g_assert_not_reached();
>      }
>=20=20
> +    /* ri_data may not be aligned, so we use memcpy/memcmp */
> +    if (is_store) {
> +        memcpy(ri_data, val_ptr, val_size);
> +    } else {
> +        unseen_data =3D memcmp(ri_data, val_ptr, val_size) !=3D 0;
> +    }
> +
>      /*
>       * This is expected for regions initialised by QEMU (.text etc) but =
we
>       * expect to see all data read and written to the test_data region
> @@ -213,6 +201,7 @@ static void update_region_info(uint64_t region, uint6=
4_t offset,
>          ri->seen_all =3D false;
>      }
>=20=20
> +done:
>      g_mutex_unlock(&lock);
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

