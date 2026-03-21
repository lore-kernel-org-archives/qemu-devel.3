Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9602E1099B3C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 04:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3nmp-0000Vk-9k; Sat, 21 Mar 2026 00:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1w3nmm-0000V3-G3
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 00:18:04 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1w3nmj-00008i-5p
 for qemu-devel@nongnu.org; Sat, 21 Mar 2026 00:18:03 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2aae146b604so15538905ad.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 21:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774066679; cv=none;
 d=google.com; s=arc-20240605;
 b=YHgnOVpvwpZdXHxznpeYraWaTAT/KqgbRuonLxYNNWUrgpPGeTr109PNaRGGYNk0HC
 0rM3zzX0lqvPE3Lrgx6VkN01qpkY2Tf3MPavTvMlsMXLYG+YTNIt7OKocGqAWlG357TI
 xD98og2fflQVCJMBZSmP4ycXNqlWJeTcybG7G90jsUCV4EXsdE0Qj+JQvA4zCWInOTci
 /MoIjQUzEE00QXTdPMrlcNFuCRhEgLXSJeV8R+FXlz+kmpr/7ea8Dxf5kMH7WA6FyfqS
 Psz3VpkK4mK7HjCRGO7ykclqfTCcCTcSrE7Vepu7OMvRNWgcMBwNkPZSL5et3oTH+B3a
 9SVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/71rvbLJqzxExEGJYa5W00IAvP4YfCGLkNzIzZ5mQIs=;
 fh=X0JCVnag0TcRr8vxCgHEt345nm3uKbFVdK/gX0Q5lvg=;
 b=QYzVePX9QSwzrX0owqzCNaPJ05ULLxOdIQJ+8nZsWO4/U/uUfVF8VpPuXIbf2sBEuG
 GwnO6e50F0xS/mtcw0/l5lURk1u/UXmMiW+tH49oEqHdGXL/tpqgHtkQSBqCRKBODfEq
 aaZSDf7Yv61+pmQr1n89onwkdbfsZM8d5eNWEPNkq4RcM8q6rWbPP/G4Ndxq3XD/9gBf
 4x6bDgKgX0ojwSOAm16boRycyE7nKvXo8NMGD5s3rqTVxnfZAddhxGQitNwmQ8bTlBsv
 LvhNMe3RZIzNaycZyDT3s5oaIwH4oAB9NqgUpOy0RbpLX+wFpZOeEkmTbpPazm4zD48j
 AIBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1774066679; x=1774671479;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/71rvbLJqzxExEGJYa5W00IAvP4YfCGLkNzIzZ5mQIs=;
 b=mTFhHOmj9bviQB0pwbQucij1Bu+1y+uzGZsmCrlDA0qHTyoF+vvkiKRHrPazTNRokH
 mZKDd9yg6MIimBh4LEevNGV4eI8+XZ95vBG60SRM8MHIVYswpYNmbOvlz+3vFPvrwzmX
 +Og8YYziZhf16MljoQLBmgZejj23nIlpGGm05IPe6XzgX4TYPbClN/IDSQx/1etVN+uG
 R4B3dCV6QrQblB0f6s921IKcvJZqgApkQ32+1V5NhGSubg+0oWmUcobTmjq+RCnQN0Lh
 XNpEDlGmm4UOm0zxI9bz48P5++vIMnBcdsHRHT8h6n/qehog3gJdYaOhd24As20LnIfd
 swkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774066679; x=1774671479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/71rvbLJqzxExEGJYa5W00IAvP4YfCGLkNzIzZ5mQIs=;
 b=ARgiHSO7ZQQTd3b78nLfmHXuyHDDbqePwUVYaohftwSxYiWj2ByzXh9zj/2HdpJyjG
 7UqjTJDD4Kwvh3TxrV7CqOW28TSDKJ+baUlRz0GKJMH8GLp2SZdm/io9VCCYsVDQpxOt
 hR2XXRvGQBbsiZC6tHFu6Xwn5h1tE5FfVkplIQue+RMZz9akZl4h7+YNiguJ3RPtXFdZ
 1bJwS5QmOo2nlblre8q90YBuViZHar7olpWRa+yNaT1fUhNPjyt8GZXAmMDR1qIy39n9
 ytqMCXCbq+WO/sYkMqjDFiC3+cs5QUzz7j+31U0x0f7fJ+KDltNpzIOvdcdGTmF8CigS
 xYeg==
X-Gm-Message-State: AOJu0Ywa2rRQUELPem2zt90KqygOPvA0Rx8J+7v1VbFb30k4najudEsE
 nLyCemMAAPwxQQJKnY9uNpdfgvYLRkq0P9X0xfGQRHJrbvRaYQ4hyZx0x0sXAM5fhS7+bJhU4x+
 ac3PiHQTgD84Xos0WHorvHgZ15H7eEQDYeODIV4hryA==
X-Gm-Gg: ATEYQzyuzJTGPguMXoxZEMY919oq+jMSq1BE6jY+1s9xKhCSBYESVrAXZgL4DvwBvfk
 Ma1waSf98A7Oft0ZqF3JfJITbbPZXmy5jTDMfIb3L7BFeJDb0FFa0dhNmQHByAjj6tQyDjuqVSY
 Ze8AhgpgbhTNtidWADS2r6G6dlNdJKb/fBNVU86aCZFoEFi8u32MfcezFpzmT9iAkHJpyiEz3Kb
 XVSAIrFI+uYY88z7rX634TZLo+IjERgiXVXaauSX/DDbVdSexICIE8ltp+fu+K7dKFU+kzJnruo
 G+bWVqSQXDE7dC3orNxIVgbFFx1wyaL/KoIIuA==
X-Received: by 2002:a17:903:283:b0:2ae:6205:2345 with SMTP id
 d9443c01a7336-2b0827b59e8mr46085265ad.35.1774066678888; Fri, 20 Mar 2026
 21:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260321004836.500390-1-npiggin@gmail.com>
 <20260321004836.500390-2-npiggin@gmail.com>
In-Reply-To: <20260321004836.500390-2-npiggin@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 20 Mar 2026 22:17:47 -0600
X-Gm-Features: AaiRm51jySqlfp86N046jO9V1USKzBRZ2YkuOa3KzLygeU61yhnjO_4Y7wK4eAw
Message-ID: <CANCZdfq+iybMORb=_zNCdmSGgFMc87FN_6njavohifLY_vpnkg@mail.gmail.com>
Subject: Re: [PATCH 1/3] bsd-user: Fix unlock_user API usage
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003409d5064d81161b"
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=wlosh@bsdimp.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000003409d5064d81161b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 6:49=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com>=
 wrote:

> Fix errors in unlock_user() calls:
> - unlock_user() with len=3D1 instead of len=3Dwritten
> - unlock_user() with len=3D1 instead of len=3D0
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  bsd-user/bsd-misc.c | 2 +-
>  bsd-user/bsd-misc.h | 2 +-
>  bsd-user/bsdload.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>


Reviewed-by: Warner Losh <imp@bsdimp.com>


> diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c
> index 3e1968718f..eac3edb8ac 100644
> --- a/bsd-user/bsd-misc.c
> +++ b/bsd-user/bsd-misc.c
> @@ -95,7 +95,7 @@ abi_long host_to_target_semarray(int semid, abi_ulong
> target_addr,
>      for (i =3D 0; i < nsems; i++) {
>          __put_user(array[i], host_array + i);
>      }
> -    unlock_user(array, target_addr, 1);
> +    unlock_user(array, target_addr, nsems * sizeof(unsigned short));
>      return 0;
>  }
>
> diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
> index 13e40d9cde..13abc7e3b1 100644
> --- a/bsd-user/bsd-misc.h
> +++ b/bsd-user/bsd-misc.h
> @@ -211,7 +211,7 @@ static inline abi_long do_bsd___semctl(int semid, int
> semnum, int target_cmd,
>          break;
>      }
>  out:
> -    unlock_user(target_un, un_ptr, 1);
> +    unlock_user(target_un, un_ptr, 0);
>      return ret;
>  }
>
> diff --git a/bsd-user/bsdload.c b/bsd-user/bsdload.c
> index 5b3c061a45..9ea3b93825 100644
> --- a/bsd-user/bsdload.c
> +++ b/bsd-user/bsdload.c
> @@ -30,7 +30,7 @@ abi_long memcpy_to_target(abi_ulong dest, const void
> *src,
>          return -TARGET_EFAULT;
>      }
>      memcpy(host_ptr, src, len);
> -    unlock_user(host_ptr, dest, 1);
> +    unlock_user(host_ptr, dest, len);
>      return 0;
>  }
>
> --
> 2.51.0
>
>

--0000000000003409d5064d81161b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 20,=
 2026 at 6:49=E2=80=AFPM Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmai=
l.com">npiggin@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">Fix errors in unlock_user() calls:<br>
- unlock_user() with len=3D1 instead of len=3Dwritten<br>
- unlock_user() with len=3D1 instead of len=3D0<br>
<br>
Signed-off-by: Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmail.com" tar=
get=3D"_blank">npiggin@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-misc.c | 2 +-<br>
=C2=A0bsd-user/bsd-misc.h | 2 +-<br>
=C2=A0bsd-user/bsdload.c=C2=A0 | 2 +-<br>
=C2=A03 files changed, 3 insertions(+), 3 deletions(-)<br></blockquote><div=
><br></div><div><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mail=
to:imp@bsdimp.com">imp@bsdimp.com</a>&gt;</div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
diff --git a/bsd-user/bsd-misc.c b/bsd-user/bsd-misc.c<br>
index 3e1968718f..eac3edb8ac 100644<br>
--- a/bsd-user/bsd-misc.c<br>
+++ b/bsd-user/bsd-misc.c<br>
@@ -95,7 +95,7 @@ abi_long host_to_target_semarray(int semid, abi_ulong tar=
get_addr,<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; nsems; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__put_user(array[i], host_array + i);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 unlock_user(array, target_addr, 1);<br>
+=C2=A0 =C2=A0 unlock_user(array, target_addr, nsems * sizeof(unsigned shor=
t));<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h<br>
index 13e40d9cde..13abc7e3b1 100644<br>
--- a/bsd-user/bsd-misc.h<br>
+++ b/bsd-user/bsd-misc.h<br>
@@ -211,7 +211,7 @@ static inline abi_long do_bsd___semctl(int semid, int s=
emnum, int target_cmd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0out:<br>
-=C2=A0 =C2=A0 unlock_user(target_un, un_ptr, 1);<br>
+=C2=A0 =C2=A0 unlock_user(target_un, un_ptr, 0);<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
diff --git a/bsd-user/bsdload.c b/bsd-user/bsdload.c<br>
index 5b3c061a45..9ea3b93825 100644<br>
--- a/bsd-user/bsdload.c<br>
+++ b/bsd-user/bsdload.c<br>
@@ -30,7 +30,7 @@ abi_long memcpy_to_target(abi_ulong dest, const void *src=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -TARGET_EFAULT;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0memcpy(host_ptr, src, len);<br>
-=C2=A0 =C2=A0 unlock_user(host_ptr, dest, 1);<br>
+=C2=A0 =C2=A0 unlock_user(host_ptr, dest, len);<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>

--0000000000003409d5064d81161b--

