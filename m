Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7370BD3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 10:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaAxh-000455-C3; Mon, 29 Dec 2025 05:58:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAxZ-0003zC-5L
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:58:48 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vaAxV-0002U7-JQ
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:58:43 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b72b495aa81so1497536766b.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 02:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767005920; x=1767610720; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjrG4udWPJtJybezA8KdZbBF9ykubHEE1gGY+G5UpDU=;
 b=sn5bADX1SUerxzOB/bmPNLu10D0az7y1ZLGQAN6OHwKk6EjgBZi7PDSz4ysdXwixPl
 WMYVd91Kd5CWxlhJXls66YdL1RzHwe3yrjusEUpwnEhJ22Ro3mmciqsTzBqGz8Mz1qzi
 D4mvqChvk9EU6hJs/HSlFV5cD7KMv2aKc/Iy/KMloUT1tUDS8Vb57+XM4KAWs2OFk5A1
 YTNdMv/JUcgjXdQoz2VX00I6BZhOF1SLAmrcmuHCO57xCTgViBAXDjd3rm9M3mwjh19z
 6YjuHMmUyRdngiLDd7YnEIQNfm5NKxtTbzdlPMq+xW4IXi1gcPjzUfyxuJO14DuBmgyp
 IV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767005920; x=1767610720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BjrG4udWPJtJybezA8KdZbBF9ykubHEE1gGY+G5UpDU=;
 b=mW2w3DjFvso1sV6U7er1FnJWNuF1JZtrEQ73v16fs5/SZ6nWMfmK4lxPcSVtAfXyzE
 qb1cJQnCMNj9B9ekGiHeZ4JSLMAiuFkT2PMz6gMb/WGl3ZRFGtKFzgkblDLum+eWp8QR
 CQku/SgY2St+SpVV6fUXJ/vTTunOZhdDkiuV0Xz/Dp5Tw9v5vweFCJ0GBGhhJlWNjjMv
 l6Kw4chlZWQtXq41UtoAzz0WVFUNJvGCSYYzieJgr/qYGepe/uSOm+8cVRMyVMxRpO5p
 joJAH40uKs2eM5wjWOuglFQZMUPNjXpdJ3TkujXEVGh5+1HcCQhdfJKWTMR8lfpObMv9
 v7gQ==
X-Gm-Message-State: AOJu0YxQEitw9CBA0Hz4jOlGDnIIkVs4ricG4oblSQOsvPgd/c/E5s/l
 IXHqgt2HKcz25+KuRYmk50gPKKlncH0w6b2TD0htM35/glwZm02zOv+cSg8nmAmskeGsLb4flCS
 WQAkyT3EiUrm/VH/WdE77mlMCNds2PFrdSDVAx91Xqw==
X-Gm-Gg: AY/fxX7zQWAuewN5rjPc+JQXM3NQftzIAffTU4Bc0OenYf/h7La16crPUxk3dzBau47
 ujEOzO6KTSLt6N+iKSvLI0AevnU7tIPqt9VR7VXSvZV2KsZODybpqVcwcVvOW/dVQF0MEgpWwLI
 mbK6QxJrsTyZDiacy/VtKtQ+Ldp8TOw0mIr9qgUdIV7v1l/R47vZ4yotGT4bBaGppRWRESYOve3
 X3SuzgeuCXgjR3rMDlLQgGCPhM/WAigXwDAu8rqRYlw5lPws53HMFH9JpbmIPnqQ0786hHQ/a78
 M30P1RRksKGbtvACxksoE/FVO3W7n69WxsF7ETE=
X-Google-Smtp-Source: AGHT+IGANR/O+QVgUQsdVhY1PLLLzclfCmyowyulxcUgTSMlDgLeAf4rRRywzts/kc6JHTvLtSXtyRPe65S3IVO+GVc=
X-Received: by 2002:a17:907:94cf:b0:b7d:1a23:81a0 with SMTP id
 a640c23a62f3a-b8037297276mr2801633966b.63.1767005919856; Mon, 29 Dec 2025
 02:58:39 -0800 (PST)
MIME-Version: 1.0
References: <20251224160708.89085-1-philmd@linaro.org>
 <20251224160708.89085-4-philmd@linaro.org>
In-Reply-To: <20251224160708.89085-4-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 29 Dec 2025 12:58:13 +0200
X-Gm-Features: AQt7F2o8od__89n4DcJqmiWsBmRN0LKp7i659sWzf2Z5jXob-mPTbVcXP3l4kak
Message-ID: <CAAjaMXZ7PCE5FkRfWmSmDCzJUdrb1OSO7fgA8K=POvFb71jKbg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] configs/targets: Forbid Hexagon to use legacy
 native endianness API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x632.google.com
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

On Wed, Dec 24, 2025 at 6:07=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> The qemu-hexagon binary is buildable without a single use
> of the legacy "native endian" API. Unset the transitional
> TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
> further uses of the legacy API.
>
> Preliminary commits allowing this final change:
>
>   - beb38fda0f0 target/hexagon: Replace MO_TE -> MO_LE
>   - fdcb7483ae0 target/hexagon: Explode MO_TExx -> MO_TE | MO_xx
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  configs/targets/hexagon-linux-user.mak | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/targets/hexagon-linux-user.mak b/configs/targets/hex=
agon-linux-user.mak
> index aec1a04d1b4..6763e2111d5 100644
> --- a/configs/targets/hexagon-linux-user.mak
> +++ b/configs/targets/hexagon-linux-user.mak
> @@ -3,3 +3,4 @@ TARGET_XML_FILES=3Dgdb-xml/hexagon-core.xml gdb-xml/hexag=
on-hvx.xml
>  TARGET_SYSTBL=3Dsyscall.tbl
>  TARGET_SYSTBL_ABI=3Dcommon,32,hexagon,time32,stat64,rlimit,renameat
>  TARGET_LONG_BITS=3D32
> +TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> --
> 2.52.0
>

