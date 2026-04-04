Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17336E88D86
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 06:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8uh9-0003Wq-5Y; Sat, 04 Apr 2026 02:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w8uh4-0003Vp-A8
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 02:41:18 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1w8uh2-0001JB-MG
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 02:41:18 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2c54c68db4dso4868244eec.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 23:41:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775284873; cv=none;
 d=google.com; s=arc-20240605;
 b=gxkcybTJpcqrclb78Zu+URl4C+EanQoT6xlyA7IGrI3SARkQOMc+/WDJ1m9sVOHuYE
 FXgBAwD1E31XikX+ownR/wF2mYc1lBlvV/4gfLy1fa03q6Pqdrm6W+4lnXGL5Hzs9fDx
 dubugPb9UA5KE/Ga8UxwdELQartMGTjv3RkDKx9frGY8WnxqmORXmluFkuOHpnESXJMb
 Ds2pCsgKLTsVt4ZHOZs3fCrKJkc5BHY8XeL7qL6t0D+mECU53UvMYmu8564gvLXNj+nd
 uV5ydWhQlfZguKg2O8XqAg31h4d9srNYdJB1qUf/ibdMmYrqVg5LaO9sj3w/BWhMzjXu
 JvtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FoZzeIOI0VQbdJixNjAZK1WwHH2d9CGtoGzMA0pxnoI=;
 fh=Q7XtkoBaIRprj2egR9gZfD+Xq81r3yLZVwpAJCPXcuc=;
 b=Sq1V26YEflmxCqgyAmH5rx1/NYAEWpI0aK+flH3usFjMD+h0z31/18t/E8fsrz9MG4
 TuptiEwqkCWtYfdemXNi4ksLgJGKPYBV1A2Wn51W/3liYss9s7d97IKChsOkS3I5yPKP
 9z2OWb59Ev4cAdg+1cbwSP0VhVsYmXYaVGhogRok4u5GW+GIVTs5bqpMD6+C5CzeKwhb
 CtAtPygFo3FOVM900jANh5MpoFDGJACEiatb1A7oagWolNzjRqqRepEEyUdSNFwhzBd9
 Co0F3KGJ4dxcK/OXERfY8/zYflfQ49YlC9vaSGbTRWtgozAGso+CIAvP1GJJn8sUGOWY
 UuOg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775284873; x=1775889673; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FoZzeIOI0VQbdJixNjAZK1WwHH2d9CGtoGzMA0pxnoI=;
 b=RcIjazMYzlb1GMpk4eZdLCBiuqL7+jFLOloEoERpCjRYeNdCj89CT34rXSoJF/EuIZ
 2h79JVMM1E70yLal8y/nx+g1WcjX/TQo2UMWX8usemS+aAB+vN/VWFqvh16rdhft8hAf
 OvqwPCeBEQ02YGUqxnQETlR2aHkRHSFl67v3toALbjfaXi6cBXkO8nlDLaUWmU71OBNN
 04yjRFls8cUWWay3CjjGAp749iZBHt3DH+jJ6I5NROaJcIWx6w0q8nI6vfs/51H7JUB3
 uFaFSRKEkvFxTetn6oI9wSjnm9dz0d5Fod9FX+gV6RxZaEi22qJoRPmwHn90WVQ+qo4C
 +S0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775284873; x=1775889673;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FoZzeIOI0VQbdJixNjAZK1WwHH2d9CGtoGzMA0pxnoI=;
 b=ROxtBQtlZyBBu1cHobQ0EXeYUTFT2Yn6O3AFri0GfljMJq2hpLNbEzzfp3MNsCVOxK
 W7C+50pHUC/0/8FZ2POHEnQr/f12LdNYPDG0bWEJrjlBiME3+iY56LEJd+qcD6veHKgX
 5wdZuv0pbPY52qJT9gBWjpxfHBFwXib3y7N1TgrKWnB/MrdOOfTKJqsJS3Dev6pMRTtg
 pRImUm+DBEduDnbaluLgI4pnu88UtR7+E3alZad1uMluC9v5uGfnkwGebs4WkVHP7Ybi
 EJdS7DF7BUbQIQYTg6AckS5ctZECYo2ZHEf+USoktECiGm6JdIIQt5rI1sMOBPYassFg
 tCAQ==
X-Gm-Message-State: AOJu0YxLvI1qi5QN0SGLUzVsUMfGBumUm4Szqlr9n6goxbvx+HAYE3ZE
 8JDYxFUpOs/8t8mRn/BX+K7dElwHi2LkEgO7YA4d21Lai7qWzvc+5WfSq4NiMVi84wkQ9ev26Kn
 v8wI+6nHkK+q9nbmWGUjIf7Nl2nB4hDKSBzpEKHo=
X-Gm-Gg: AeBDietxVIBdCNfTZlbwBXZy7wj9WIzQPpsf+yqb7jwpziNY+9tzTNPAwuHI9FEpSC8
 RrVdEvkQfHBZ+NWrCUr6hIsqnM9d/pfw68JoY4Xfs026lYwEuhsPs57d6yTPabeNut/NpBg9YSt
 5cBfHQ+CL0O7qubymXZKTxAIU7H46SVI2y91/vnosX2Rw85xX461DHRhaLN/uygmeIbzlrEdhm+
 yKrhTeoN6pDzjPRy3zo3iOw0arshrzSC6R+EvgT6E4EnmcjcMiSB5911dKdRj36Hi1643eiIA5L
 6qdXZ8wpFFjRluCbFI1gHgzYVFtYtFDpWBLp9hRj4VK1YpljBg==
X-Received: by 2002:a05:7301:1003:b0:2c4:a862:2368 with SMTP id
 5a478bee46e88-2cbf9afd7f2mr2766187eec.2.1775284873094; Fri, 03 Apr 2026
 23:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260402105150.274595-1-phind.uet@gmail.com>
In-Reply-To: <20260402105150.274595-1-phind.uet@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 4 Apr 2026 10:41:00 +0400
X-Gm-Features: AQROBzCub7VShCZYUX6rHuwfrLj5j5MGK2q40lW7oCiHcFieThaCogdqc7AHgCM
Message-ID: <CAJ+F1C+JxRRmaD+GZ_=F=kh3sjjr_f+Us8LQoGVPSn5Ue_MzLg@mail.gmail.com>
Subject: Re: [PATCH] util/readline: Fix out-of-bounds access in
 readline_insert_char().
To: phind.uet@gmail.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Thu, Apr 2, 2026 at 3:01=E2=80=AFPM <phind.uet@gmail.com> wrote:
>
> From: Nguyen Dinh Phi <phind.uet@gmail.com>
>
> Currently, the readline_insert_char() function is guarded by the cursor
> position (cmd_buf_index) rather than the actual buffer fill level(cmd_buf=
_size).
> The current check is:
>         if (rs->cmd_buf_index < READLINE_CMD_BUF_SIZE)
>
> This logic is flawed because if the command buffer is full and a user mov=
es the
> cursor backward (e.g. by sending left arrow key), cmd_buf_index can be
> decreased without descreasing of buffer size.
> This allow subsequent insertions to increase cmd_buf_size past its maximu=
m
> limit of rs->cmd_buf.
>
> Because in the ReadLineState struct, cmd_buf[READLINE_CMD_BUF_SIZE + 1] i=
s
> immediately followed by the cmd_buf_index integer, once the buffer size i=
s
> sufficiently inflated, the memmove() operation inside readline_insert_cha=
r()
> can write past the end of cmd_buf[] and overwrite cmd_buf_index itself.
>
> The subsequent line:
>         rs->cmd_buf[rs->cmd_buf_index] =3D ch;
>
> then writes the input character to an address determined by the now-corru=
pted
> index.
>
> By providing a specifically crafted input sequence via HMP, this flaw can=
 be
> used to redirect the write operation to overwrite any field within the
> ReadLineState structure, which can lead to unpredictable behavior or
> application crashes.
>
> Fix this by adding the guard to check for buffer fullness and ensuring th=
e
> index remains valid.
>
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>  util/readline.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/util/readline.c b/util/readline.c
> index 0f19674f52..6b1de1094a 100644
> --- a/util/readline.c
> +++ b/util/readline.c
> @@ -84,7 +84,8 @@ static void readline_update(ReadLineState *rs)
>
>  static void readline_insert_char(ReadLineState *rs, int ch)
>  {
> -    if (rs->cmd_buf_index < READLINE_CMD_BUF_SIZE) {
> +    if (rs->cmd_buf_index <=3D rs->cmd_buf_size &&
> +            rs->cmd_buf_size < READLINE_CMD_BUF_SIZE) {

Why change rs->cmd_buf_index < READLINE_CMD_BUF_SIZE to
rs->cmd_buf_index <=3D READLINE_CMD_BUF_SIZE ?

otherwise, good catch

>          memmove(rs->cmd_buf + rs->cmd_buf_index + 1,
>                  rs->cmd_buf + rs->cmd_buf_index,
>                  rs->cmd_buf_size - rs->cmd_buf_index);
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

