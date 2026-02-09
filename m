Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2CBE7E0BE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 10:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpOEB-0002QY-8o; Mon, 09 Feb 2026 05:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <buenocalvachejoel@gmail.com>)
 id 1vpOE6-0002Nr-EW
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 05:10:43 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <buenocalvachejoel@gmail.com>)
 id 1vpOE2-0001FF-T3
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 05:10:42 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-352de4c94adso557360a91.3
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 02:10:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770631832; cv=none;
 d=google.com; s=arc-20240605;
 b=X6BExJhS0z+aRehxG8FBiS7RCrKBK2w0dxiH1fo7XfCnu2yXahF5MUAa7keH1VkHWx
 cvZCab2VEEYQSGXngsY4xZUgYfK30gNBifR/Tv1vtu9nOSeGJXpB/bnDgFtD5Pl0NEHa
 8bsdhCJ+vFnj1YuLHC37AlQOWrB10iqUpV0oxpQllvDU5NnA7uSV4L3Ikk1XndTTPR3v
 qyUjsW/fwZoxLE7S8jxPyzMD25uqQpLzWUNc9KcQiu+QPFGe0YlBEgxnEecRtFn0gIfT
 Xzblyw1IP/rhnooZsAkK+9Ln5uN4cLUrHEBSSHEGejPtK4KxW7d+0M+EGmnfPY9SCnsD
 rXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=M1LSeqYuCU+fX8KAb8k3dUhuByviS47TZSWU5zVigQ8=;
 fh=abAjvIVq6GNlRbG6+RaUvVOE8RswVb0aLrLpbE8QBok=;
 b=iYauqcK4xFndSo6nTnCaRVyeA4OjupEB+x/9d923+g96xH35gBtb6LOHa5iAgWFYvc
 TFxX6l+GAPaZZJFlgBq8aLbqNUsC44SRvfiJp932057tkTHEP63MMP3du3MxzOazuaKZ
 i7Td94sEIuc2dpryl9QbwFjOlJalyKWgrC4wQrqFLErJ+GodmU6dfaBGpwowUMS3J9xE
 Yas1dzQ6RNX3zL1QiLJssrUVuUCGM7YSbe86VeMw2cB0DWDyLxGZ0PLQ1JtlUiuVPU0s
 BNOcguxIXswcex8qBF4kMq1lz3gSzrYJnetjkyXD9BSst2nLB2bv71aa42AfFWJisUME
 4yRA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770631832; x=1771236632; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M1LSeqYuCU+fX8KAb8k3dUhuByviS47TZSWU5zVigQ8=;
 b=CdkT70yQUxOVeeY6weYAG6TBZhpBDJOZb7V36NZROFJ5/vQBbyrkwIahbOZsW0G2mK
 vUpSNajsGXYAa2S0KCDi4+virqAFjfnxStYzMm3ni9yWLmK0zsmO3GWkoBKtdhLl+Rd1
 KFxJHUqDfeZVeGKpusQKKxbzfQ2ZeZIVW09WetI2NFD7Q2wKXCMP8oGR+exPpkFlLhsp
 kzSga3SyGfmaM6DtGAvIkYk8dfYJ5aD8ZYACGs8IRw1XW1wYuvXIAEK96iGpaCKmHFqt
 PaYtD1uuZJAjrou39mJi6zgevMTBdsAHElnDBOv5JVy0dwHuPoSKJxYUEmR4GzIIy43O
 WLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770631832; x=1771236632;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1LSeqYuCU+fX8KAb8k3dUhuByviS47TZSWU5zVigQ8=;
 b=Q5WmMjp1RZ4bV6kVsPPt6ScyFFBBvk9GF6YgPH/X9vqxCmk91pqlAbwHPwOLE3FsGL
 Gs0uEc83fGdBojdfuUzEE4MNJrnhSegcOr9KXHw3zucq/Ul1crNMKSAEwVLqR4g3Szpb
 DuUWfpAlAfQJQ3THsGl5LOniSXY7nUJnQ39vyRLKNpatAs+6ceJRQ0BICuUODp7zj0IT
 fs/EhZ0wIycu9IdaysDAasXMiMRErKcBsdr7qJVtPPMR3TOVEe/wM5c8OtirhDsdvSbG
 4OGUD3AqySQDquYtvx2fJnBLJI2AnmMIoX2fBPlpcKIOY0hzZIUSsXNVLV0a5Yt4Mr+P
 pHIQ==
X-Gm-Message-State: AOJu0Ywxd++bNku9NPxgj2TeGezgXkg9Bpo6w4uQSOKb3QVbGv4zEfir
 to9bn+OZIy7P+vSiS2QRUAq0Z8tkg5NayRJPHPyPXeX7LL7TXLmOPq4TyrdZ467aFgGVpolrRsK
 7FDdv1UYt96Qvw4c6PbZP6jnLzv7+zpjNrtq0
X-Gm-Gg: AZuq6aI1M6Um7XnVCIE/rD6J4ZA4TduN/74XMzymMyT4mNUoS5vODZQDE8Ee8z5IIUm
 l1sbE5cqRbt2D+ugzTHr+spX02B0KHfwsTAANnE9TWnG0Jy+6zR5N3JwajwDZrSsVWGwtNzb4dN
 8cxecuhS70DdHDz9OKWIvyfHNOceWLkORQK6ZN0kcH23I7GJZcSS3NkVxY9325HwPGFcdBjPTTX
 iLQEudqVUlfhCA2Vgsgv2iVjfX6pz/TpCqfP1m1/gkurGg54JRIxYhVl2Bidpt2cCsWMhcm9FPq
 btvyHElqXcBXVF/cXbshwimodkRw3w==
X-Received: by 2002:a17:90b:254d:b0:354:c3a4:394 with SMTP id
 98e67ed59e1d1-354c3a40b5emr4872145a91.6.1770631832052; Mon, 09 Feb 2026
 02:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20251221105340.2699327-1-buenocalvachejoel@gmail.com>
 <CAPDLHD5HGNAu1=JD=V-9YQMpR_8-tWjONex2jj4ZFHbNe9qVcg@mail.gmail.com>
In-Reply-To: <CAPDLHD5HGNAu1=JD=V-9YQMpR_8-tWjONex2jj4ZFHbNe9qVcg@mail.gmail.com>
From: Joel Bueno <buenocalvachejoel@gmail.com>
Date: Mon, 9 Feb 2026 11:10:20 +0100
X-Gm-Features: AZwV_Qj4FuDMIrhdWN8N875D7CpXTm10Mp401XaOYVt5nJQOjYlEf617f9J03cE
Message-ID: <CAPDLHD4XhjpmiJPNJi5kO20bbe51=RBgDoy1LF2wJ7sCaLbCzQ@mail.gmail.com>
Subject: Re: [PATCH] hw/block/m25p80: Fix Winbond Fast Read dummy cycles
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>, 
 "jsnow@redhat.com" <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000060a788064a61596c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=buenocalvachejoel@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000060a788064a61596c
Content-Type: text/plain; charset="UTF-8"

Adding jsnow, I forgot to initially add him! Also, bumping again. Thanks
and sorry for the bumps.

On Wed, Jan 7, 2026 at 12:29 Joel Bueno <buenocalvachejoel@gmail.com> wrote:

> Is there any feedback on this patch series?
>
> On Sun, Dec 21, 2025 at 11:53 Joel Bueno <buenocalvachejoel@gmail.com>
> wrote:
>
>> The Fast Read (0Bh) instruction requires 8 dummy clock cycles
>> according to Winbond datasheets (e.g., W25Q256JV Section 8.2.12).
>> However, the current code adds 8 to needed_bytes, which represents
>> bytes, not clock cycles. Since 8 clock cycles equals 1 byte in SPI
>> communication (1 bit per clock edge), this results in 64 dummy
>> clock cycles instead of 8.
>>
>> Change the Winbond case to add 1 byte (8 clocks) instead of 8 bytes
>> (64 clocks), matching the existing implementation for SST flash and
>> the datasheet specifications.
>>
>> Signed-off-by: Joel Bueno <buenocalvachejoel@gmail.com>
>> ---
>>  hw/block/m25p80.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>> index a5336d92ff..21c2118b33 100644
>> --- a/hw/block/m25p80.c
>> +++ b/hw/block/m25p80.c
>> @@ -1001,7 +1001,7 @@ static void decode_fast_read_cmd(Flash *s)
>>          s->needed_bytes += 1;
>>          break;
>>      case MAN_WINBOND:
>> -        s->needed_bytes += 8;
>> +        s->needed_bytes += 1;
>>          break;
>>      case MAN_NUMONYX:
>>          s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
>> --
>> 2.51.0
>>
>>

--00000000000060a788064a61596c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Adding jsnow, I forgot to initially add him! Also, bumpin=
g again. Thanks and sorry for the bumps.</div><div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, =
Jan 7, 2026 at 12:29 Joel Bueno &lt;<a href=3D"mailto:buenocalvachejoel@gma=
il.com">buenocalvachejoel@gmail.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex"><div dir=3D"auto">Is there any feedback on this patch serie=
s?</div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Sun, Dec 21, 2025 at 11:53 Joel Bueno &lt;<a href=3D"mailto:bueno=
calvachejoel@gmail.com" target=3D"_blank">buenocalvachejoel@gmail.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">The Fast Read (0Bh) instr=
uction requires 8 dummy clock cycles<br>
according to Winbond datasheets (e.g., W25Q256JV Section 8.2.12).<br>
However, the current code adds 8 to needed_bytes, which represents<br>
bytes, not clock cycles. Since 8 clock cycles equals 1 byte in SPI<br>
communication (1 bit per clock edge), this results in 64 dummy<br>
clock cycles instead of 8.<br>
<br>
Change the Winbond case to add 1 byte (8 clocks) instead of 8 bytes<br>
(64 clocks), matching the existing implementation for SST flash and<br>
the datasheet specifications.<br>
<br>
Signed-off-by: Joel Bueno &lt;<a href=3D"mailto:buenocalvachejoel@gmail.com=
" target=3D"_blank">buenocalvachejoel@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/block/m25p80.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c<br>
index a5336d92ff..21c2118b33 100644<br>
--- a/hw/block/m25p80.c<br>
+++ b/hw/block/m25p80.c<br>
@@ -1001,7 +1001,7 @@ static void decode_fast_read_cmd(Flash *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;needed_bytes +=3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case MAN_WINBOND:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;needed_bytes +=3D 8;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;needed_bytes +=3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case MAN_NUMONYX:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;needed_bytes +=3D numonyx_extract_c=
fg_num_dummies(s);<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>
</blockquote></div></div>

--00000000000060a788064a61596c--

