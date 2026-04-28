Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E800FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHiVa-00039b-1a; Tue, 28 Apr 2026 09:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHiVU-000393-UH
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:29:45 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHiVS-0007N9-HP
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:29:43 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-12c8ccc7755so11961329c88.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 06:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777382981; cv=none;
 d=google.com; s=arc-20240605;
 b=BHTJeu+/z9VQcEscB/5l481frBWvmdeS67eEBiEpQzqmwJFOA874m/YZVReHaNJeYw
 ZjAPneH+Syy+ywlt6eZn2mzeCucPHN+tAM9tUCJBZPNr+ZhUcNRnF7LE0g+E3hZf7zAJ
 5YvB4vzLEYuUNg0iNCj4ir9aV7UqwvkVxsKKnCE+FKX3Ze1Q7dqFnIUwYVpyWZwYBJdx
 gAx6PJliRbQTtmkTygo+qUhEjpBsoCfB5FogMU8pybqPNiZ6dQP0kWQOvA/UDdRrQnkj
 N1rQWEVAMeG0mI2oypk6lH5jukVW7GdGykw1DGWkm1/Z9XzcJO0SHajQvYN78sljEpgv
 kMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1eupjgZMeQMHaFykA3gVnUcb5xXSgJwRwf8f6iVcpDE=;
 fh=D/CcNrtvbeWGY8nbdaeIwoQ6I3/FtQLwRmnEQ1zZwds=;
 b=FOfBR9GwzcoXYrcqOkqX8jlnNNccHhvkxkIrM/qn2Pq+mSuXh295laqJoAS08QC04D
 UL7JjycexA7h2kelGpjbeiQIJ2k/n0aYdaivdtS8Ap5HI7ZYoyE5DYhG2/FV89cqUgcv
 ZoX2x/zf3Jihetiw5HJsMRvikQejE3EN0YTN1vtPwNNp2dl8JCQA5uq/nUntQ+nsAvR4
 9WdFLiGj+w1tZvFxXOVR5bziS7xM8csar3vYFbEsSYrXw0G7SHkPlJiUhsZy63gkpyiF
 qCWQWW/sQRzNw4wrNe/qxia9bE4gSPX7L2l+W+DK3C116KSudz+jS2QkWBosDpdpAbYo
 S9Aw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777382981; x=1777987781; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eupjgZMeQMHaFykA3gVnUcb5xXSgJwRwf8f6iVcpDE=;
 b=n4QD81epjRWWitEZ4ylz4w5teIegHTv/u5QI59If7u3lTtEfPaUe6ynICRetx3FU0+
 IECt+SBZD065dCSOOcSOk3d9nFe5qz5thaINLzBKKvm9iwnVDLo9fagx/K+ozsRtbAaL
 JNY9hV5FOy3da8o2c2L4aon2UR900L0+tIXqKZquH3ZsqKt0lNBLbHwd9mz5sa31MOV5
 EIevVYpPju2asw/kWDV5I7onuidqaAsJxEPWZnJEBz4lGEzDz9Ukr208RgyI8l0rjXA0
 InGYSqGCNOhu0ghEkcgoFBuvg5w6oeZwWfeRQt93benkzo+wL23jHWVlwir7xwHxFLpQ
 8GIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777382981; x=1777987781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1eupjgZMeQMHaFykA3gVnUcb5xXSgJwRwf8f6iVcpDE=;
 b=tDmNi0RNvjBPg76tiF7hRpstmdUXFs3D3RIfK2DALEerZgYtu1e8OjiRXAc7Pvq2/A
 uW2z03cm2qlmfOlohOtY8g5wA8QL+/xNymB5+x/qvG7bqt7gxW4Ddc/PPrys6I4b9H29
 1LObwkYabybWGSHm2KOpLEpMunKZ/HsRisCytE5vJux+YFKmJS6Jcax5zQyMtHP88EOK
 RG23e0Mqxwc/hXFcVzYPAiap5KoiLadDkudVyNyBx47POifjX+HIynuf+pX352GAK4xs
 tQGG80hh638LVtW6ujU5RjofyTdSGKCYjCNXA9DPvXzfGWJxwrKdhvjpjI2OUcRKAOgU
 +Ckw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8EMj82NLo2/8tZNbPGOxf37ejcD92MFOmXStXt7Gp4cH0469w0xPB9ouTD+n+4Krql227rjMaksBTt@nongnu.org
X-Gm-Message-State: AOJu0YxwaIJwLMQDtD0B3vL3X/dEUEIg7TnqbMvIKvzrD8j4iekebMQx
 H2kBeuleXwDKrGR4wyNBu8lyyCz0oyofSn0VfkiFzYSQVn5jkvmu5JgtmJypOu3fudmxEnIKIaQ
 T8WH3sBlgdvZCE5Bs2ik1CIsc4DXzDtA=
X-Gm-Gg: AeBDieuzYJ1MWV0rapr9SWJy9xsew7liQvQj+j5P2ny/r75pKwkS3zt7WILle8lhnY2
 6GR94T73jTuxLZNm1z50Qmu9CTC0G9H6ydZ7A7RJKouYpg+3ErVq6SCrQLOdSiWTHbswn9N5z4a
 XqZSZI3yJgT71RNuhkjaH457v3RHaRw0yPNLtRCXdSxZX2PLfmalR3F+nMB4MwJqLv14hjVfGzT
 GTGrtPFdxjZAPdHURUjfnU7tJ0JQsNjKU92awgxdP7ztnZjj7L0+rEwUN3iuchOcMLRCCH1Zadr
 E0X7QxsdsgEUlTF3FU1+UUxMGZ1m8M9VpMnrPVju0MWR/6HkNrs=
X-Received: by 2002:a05:7022:ec18:b0:12a:6a64:81ee with SMTP id
 a92af1059eb24-12ddd9438damr1426908c88.3.1777382980552; Tue, 28 Apr 2026
 06:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260427154441.1918536-1-rkir@google.com>
 <20260427154441.1918536-2-rkir@google.com>
In-Reply-To: <20260427154441.1918536-2-rkir@google.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Apr 2026 17:29:28 +0400
X-Gm-Features: AVHnY4Ku_OSO9hPHyBj08MfQfOQyRmCpZnF_KX-Gbewxxo3v-3TqdUu1R3Lgg3M
Message-ID: <CAJ+F1CJqa26nXaUUYU0co8DZmnFJCr4Mq2RysDXjuLhiUh9Epg@mail.gmail.com>
Subject: Re: [PATCH 1/2] qom: improve use-after-free debugging
To: Roman Kiryanov <rkir@google.com>
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dl1-x1231.google.com
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

On Mon, Apr 27, 2026 at 7:49=E2=80=AFPM Roman Kiryanov <rkir@google.com> wr=
ote:
>
> This patch invalidates dead objects so their usage will
> lead to more predictable results (crashes or asserts).
>
> Change-Id: I1dc36dbc1030c2e41c937f08baa97b2e81d44c82
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>  qom/object.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/qom/object.c b/qom/object.c
> index f981e27044..240e36c39e 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -613,6 +613,7 @@ static void object_property_del_all(Object *obj)
>      } while (released);
>
>      g_hash_table_unref(obj->properties);
> +    obj->properties =3D NULL;

That makes sense (I'd g_clear_pointer for a safer one-liner instead)

>  }
>
>  static void object_property_del_child(Object *obj, Object *child)
> @@ -670,6 +671,8 @@ static void object_finalize(void *data)
>
>      g_assert(obj->ref =3D=3D 0);
>      g_assert(obj->parent =3D=3D NULL);
> +    g_assert(obj->properties =3D=3D NULL);
> +    obj->class =3D NULL;

This one I am not sure is placed right. If the goal is to revert the
object_initialize_with_type() effect, perhaps it should do more, in
object_deinit() ?

>      if (obj->free) {
>          obj->free(obj);
>      }
> --
> 2.54.0.rc2.544.gc7ae2d5bb8-goog
>
>


--=20
Marc-Andr=C3=A9 Lureau

