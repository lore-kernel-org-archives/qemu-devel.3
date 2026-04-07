Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD859FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABVh-0007JP-KC; Tue, 07 Apr 2026 14:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wABTj-0003Pl-NP
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:47 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wA4Ed-0000G0-Ap
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 07:04:44 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-2cd339aeab4so3594324eec.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 04:04:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775559881; cv=none;
 d=google.com; s=arc-20240605;
 b=agyR4bAt3bBUEMs5cqX3F1R3uk49gTwZub+d5EIY9gaaFzjZtqj9iFyNvAuLsO7LKo
 53ITqglhYoOoIUNHzLdm+ZjjOcHh+jM29KlcRrxSgz/m1rGxKpDXqZso/MRD9fG476Hy
 MbvvOVBIElgwb2HnVPiAmdwsfwzYT/P4V6Qyp9miuuA76x1qPzQCIanfOO4VXMOij4Ya
 +bxoIk54QdQdSG8TNtfxfBsa8/zoPP/EgVVOpFKkat/HJWt5YeTFSLQBrdJmO8F9CXZn
 YWwHsFl+8mucIFCqUTtB0LjJEAHqbzsc4oovSI1Iubc6X13SWSbfcuFCxWwTkloNhMft
 LEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=o0JvVJzms3rwdEfr3B7aHFbyg1oD+Eh9757f9pxNpp8=;
 fh=d56RIs5MME7L2k1f4uJ9zAAS8qff8nLQEYFQrPIN9/Q=;
 b=OUoQuOPj0bndutg7UbjDMuDGCi9WmfOrvD0707lD6uFLfhNPQNemlP1rAcWhq8rn7E
 D5NhFbpGPZULWyk8FPCMSoC88x1Jtr2pQkNSkRZK+4oKN9MSgs4Z0EGQX6JaX8E6tGOM
 IAlgwH6RBthzrATdqZNvB1CdiLoiGZETPBe8nixFWHUbXysnYoce2A4Sp37d/qtKU0F6
 uQTVmiao9NZQ9I/vDFtHVXFh84K+DrnJegrup+lYpU8ArmMDpeSWJeP0Dlx/YBFCMnvD
 swzqjZ5eTERNDTf+NlsKCvD+X1+yIJ19VwxfJKvff/m9AFWRTtrxCME9akFyD70+N/fJ
 oZoA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775559881; x=1776164681; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0JvVJzms3rwdEfr3B7aHFbyg1oD+Eh9757f9pxNpp8=;
 b=gyXGxI7lEoWzaUl395COpchtzmH5IMZ4w5zIIh4W+KxlDTxC3IJ4tl3nPmz3owNYmm
 bzIj01GjehNf33afGPMipiU1vYeTu/LlstvFGSDJE3T5UFLja8Liz58hqpr0l57d9Iax
 56Im1+Gq41h4fQ8GVYmz8Yt31fOfOrcT3jlKvjhzkcKipo2/9brsKs9hRlLs065KhUB5
 lNeoKWuVKpG0RoLuGayDZz86rCQTIOXzx+C+UgzP/goxbnGyxQ3bQ6yZpLf4WdKDjvkT
 Fge96w3LvnHriqWCQyG14U5eesbyAeVu0SMciYQaOEedabPIxn/rwqIxOehcr8TAv0yV
 jtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775559881; x=1776164681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o0JvVJzms3rwdEfr3B7aHFbyg1oD+Eh9757f9pxNpp8=;
 b=CcsH/gVgNqlTW0fcJyGXptSBlTBo5Ac7JahoTYfJN5FDa3m+GSJFb9vWtw4KfRDZZg
 4HrebTJ1LQuWR3FCLZrdBgO20Q4wYvJBpsE76GeMqb2WmQIjSoRkKjXG9OGvlK7S5NUl
 Fz+y4TDZUxl7pSDxvFF2tg3jGyLjX3OHF6g2e74cpMAGEg674D0Gl9VdyhKfaYXN8KH1
 vcLKfYq/tMISpadyfuRFYlurgP7BK5el76YYrmhfLpZPTu5jTh65bqtxqNLV0w3uVR9U
 xcUoVIDnkyv/AxSEYL7X16tAIICQCEGGJC9a/sHlAzNoEVV/LqFiVeLyQK+EREtyPSvI
 ODNw==
X-Gm-Message-State: AOJu0YzxIPRRPVRSaV9bM3+7bNjFiMyXRespvhXUwzObfMHh0g//FMPy
 +0q3ZgLGuYiuTu6+39Ib34C1WLFFFhbKHvuwy6bjb/HHSj8Fh29R6+Pshg1T4mLWgkIG1cbqC4L
 S8b36JtjUKAVK7oa9kHITYCfnweZZYJA=
X-Gm-Gg: AeBDieucozhoYHAAsM18jYVKqGS3/e1a3kVv8jQln2OLPJuC1tLrmiWFU2rbUo3XEuI
 6uh4oD33ACYn8K42T+PVLZJLvKLn+RhEYXyJmtIBM1HV3Xv27jrhpFQTVzidgdsx5AUZZi11z36
 Wmykgi+hVMBAVj3yj2v2cQKn4w7jIzB4Im0GlCVpakAKCRBJxvEt7yU634/k+OjzJQ7kkvhrho7
 TEOJXLAVdOdGnHi0GY0VckrsY52i2CXQpBIsVumk+eSuHvZenx0Xd7AQGvcEOv28N3cjyFB6bnX
 VsX9hqdTbT+sQq+VDo+q1Rl5zX8ORbYfIQan6xTf7pGInJWYoA==
X-Received: by 2002:a05:7300:dc88:b0:2c5:b23e:48a4 with SMTP id
 5a478bee46e88-2cbf69984ebmr7808018eec.0.1775559881132; Tue, 07 Apr 2026
 04:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260406050454.284873-2-phind.uet@gmail.com>
In-Reply-To: <20260406050454.284873-2-phind.uet@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 Apr 2026 15:04:29 +0400
X-Gm-Features: AQROBzDRBD2epdYPy98FV4rYVhYGs0O02M2WrR4a69p03IZMD_A-wC9OeMYokxQ
Message-ID: <CAJ+F1CLrs7ph8WE-xunN=xSQMYFeimfHB_F7+RxgroSdvRwyNQ@mail.gmail.com>
Subject: Re: [PATCH v2] util/readline: Fix out-of-bounds access in
 readline_insert_char().
To: phind.uet@gmail.com
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1333.google.com
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

On Mon, Apr 6, 2026 at 9:05=E2=80=AFAM <phind.uet@gmail.com> wrote:
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
> can write past the end of cmd_buf[] and overwrites cmd_buf_index itself.
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
> Fix this by adding the guard to check for buffer fullness.
>
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  util/readline.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> ---
> V2:
>   use assert() to check the value of  cmd_buf_index before the
>   insertion.
>
> diff --git a/util/readline.c b/util/readline.c
> index 0f19674f52..e2664e48ca 100644
> --- a/util/readline.c
> +++ b/util/readline.c
> @@ -84,7 +84,9 @@ static void readline_update(ReadLineState *rs)
>
>  static void readline_insert_char(ReadLineState *rs, int ch)
>  {
> -    if (rs->cmd_buf_index < READLINE_CMD_BUF_SIZE) {
> +    assert(rs->cmd_buf_index <=3D rs->cmd_buf_size);
> +
> +    if (rs->cmd_buf_size < READLINE_CMD_BUF_SIZE) {
>          memmove(rs->cmd_buf + rs->cmd_buf_index + 1,
>                  rs->cmd_buf + rs->cmd_buf_index,
>                  rs->cmd_buf_size - rs->cmd_buf_index);
> --
> 2.43.0
>


--=20
Marc-Andr=C3=A9 Lureau

