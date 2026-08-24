Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BEFC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyTqN-0003x0-B3; Mon, 24 Aug 2026 08:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wyTqM-0003wn-Cu
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:32:02 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wyTqK-00007Y-NI
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:32:02 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e9ecb1e13cso5392273a34.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 05:32:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787574719; cv=none;
 d=google.com; s=arc-20260327;
 b=T0JO0mOatvJCy8E+TYQfgxPMWZnS9nrAKM5s47k4NfxAuIlZ6+8bLjFVmWqzY+mktw
 17XOu/eZDPP81dRAPgVxyxApJJqaOZ7FM+u/iPJwtyh85wopeoeSTvfRS+sBxvjpXwyJ
 FMmDxwXMDI1tSAVpsPvjL19KnkkfjGS7LYGI6gJVNuNKkTH0ZbzbLc+F5HtwYmjpOP9b
 8xg9kHHTIgESNrLlgxJH/w+D9WT8xo04qDL4Fk6g7ew63GzesYOsRKrbkFesmtTSPg58
 ZzpC20bM8KzmSXrSjTE0DCfFOcGBuzuNxdHXnBTai+qokEvbqCDbJP7uwGQDP84RYKBO
 kzEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PMfOd7Gs71810BUwIEpoDKXhNRgNqKXmkiI5aziWUso=;
 fh=mIOXeRzeGdvQtOcnNRF1rDF60F8mPf4CHSUieHC9aE4=;
 b=Nx8PydneYb6O2nbus+DSIaOoyY3NkHidHImDbTbHpJWwE71cMOFMgKO0uyIbbfryei
 QZuAyzMsyAb8BHxnbh8sObDnEUN4FRlVCXoywW8q7Z9IyK+KaY0eXr68ZGOT3DSgspxv
 7m8AQMTPOPjXxjPDoFK6AYDqCtduif+qGy7TK2XSgaSo9wwVm1amcG3fA9P7jz0fSHTW
 FFdvSHE8qZuRI11KhPnI170qNKot9fIP0ofkztuVj8TXcwrkos1dlqtIc5gsmkEvMPeN
 2qHeVdo8BBiN2jodbaSX/D3zcAAb0JmU1l1KNTY609nV9FqzpJUjA7lE1Lz+HCHJHyEY
 V9xw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787574719; x=1788179519; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PMfOd7Gs71810BUwIEpoDKXhNRgNqKXmkiI5aziWUso=;
 b=M5uaMK/r1Jpiv4GBUvJgHOsmqhUbcVQYyVQ4eE7ElKg5Pm3j2qCIeou7TXeMSyO0Cz
 hieccxuC8k4V5/aDqBg0KHd/vZF2+QsuKIWPaQ2Bxbyy6Ymm970x7VvlfC58kYGBt6X2
 FV9RFZLeXmiSyqF2u8JaisENY+pKKJtjj0Rzy4aN80/HQbNia4J0cl43kcDifnYUz8rC
 VcdPQC166cWWu2brNgu4Ahct/wu48nt32Ztse+ehJ8NeJ79ZPnp3LoueDa6m/tSfy7g2
 f4BY2AtL+SKQwuQkBUHTXB2q21tR8tNnGeTNjvhQk1zQ2uBwP/mJdywGt1SbQFl32Cn9
 LDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787574719; x=1788179519;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PMfOd7Gs71810BUwIEpoDKXhNRgNqKXmkiI5aziWUso=;
 b=XQ/nGUWejfbn4NcsuRtVLLzXqciWkrtoFvIRy+nriQEZAQkvgqWHq2RR+sAzHFOSH3
 RFCBHzDBh8a37AuJBUnIk7ZR+BUo8PNgap8PMXl/lKrtWdaR8SrxfhR9j9AZuNFa/BhQ
 tcl4JtcMvEG0mkLzRON46CgQxirOlYTFF6aRVSiam7qN7bWdniHxNS4Teq3s3K/Fc/N5
 35XQwc3G2EImRkrWdxsErDwNKzgtOknFPBRRKOGveMVlQcoSQqi9aKzNrjb0E8TUsI8y
 8KfkQl6Fwx1+uXaJT+wu5k6WECkezZFUhUWEaXqzIIEDl66z8+jZCd7yHNDDxvCO0JBW
 nbGA==
X-Gm-Message-State: AFuF++kUfF0sUPmSXXOLJsYNbbb6RuC2EHsZqS1hbRDBRmFudP1ED/iX
 xTj1mH3S0Pv2grO1WAWvgVZp34KNBkvtnC2X6pPWZnRNOZWYgWm/SBYo1XTu++R2Cm+QbGqfydn
 x95RHNTf3qow8vFKnImhXaad2TmX6U1Q=
X-Gm-Gg: AR+sD11f5wtc9I9a6lDlFNmB93gwCo/mXNbDCYOrRfo3Bw1fX/vTzIJ0Cn54IToMhM+
 dfBtlIoZFPAwwaV5LQKPZvM1BiWTdwznzgsGxhxnrYVyHrqgJtwVjxZyW5ITPooRnp9xSjiwX4M
 8h0T1LAr85Ofovf55jkHMhTGYSlbg/sv7WkARI974r+V571Nw7/2XgQS7MLartx6BsKm5i60aCx
 R6GedV22xUdyjqEwlRIavIXKD5i0nWrbraa5ApeDco1tJyRETWLC44Ce9DBpytf4kYZGCN7HTkT
 Nybnyp/1fdpaB0/ilxCW4bAUWwciHsaB2PIa5LT3pA3k+Q==
X-Received: by 2002:a05:6820:1629:b0:6b1:7ee2:6d42 with SMTP id
 006d021491bc7-6b17ee28ef3mr6315226eaf.27.1787574719206; Mon, 24 Aug 2026
 05:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260603141137.1108963-1-farosas@suse.de>
In-Reply-To: <20260603141137.1108963-1-farosas@suse.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 24 Aug 2026 16:31:47 +0400
X-Gm-Features: AcwNN1UW-LbqTzty_n1U6LZmZbsmHawdGhCe1SaiUj-Zs5BgKQx2tyx7NBhCiNg
Message-ID: <CAJ+F1CJfLSX1=aKWfwMNot_Li-JOhDFz5WLZ4KfoDT2eYj2C2w@mail.gmail.com>
Subject: Re: [PATCH] chardev: Don't unregister yank upon async path connection
 failure
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jun 3, 2026 at 6:12=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wrot=
e:
>
> Commit 5c102ac9 ("chardev: Consolidate yank registration") has moved
> yank registration in the tcp_chr_connect_client_async() path to after
> the connection is successful. If qio_channel_socket_connect_sync()
> fails early, there will be no yank registered to be unregistered in
> the error path, leading to assert.
>
> Remove the now-extraneous unregister.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 5c102ac9 ("chardev: Consolidate yank registration")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3528
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-socket.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index e064b105c5..99e01a4875 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1128,11 +1128,6 @@ static void qemu_chr_socket_connected(QIOTask *tas=
k, void *opaque)
>
>      if (qio_task_propagate_error(task, &err)) {
>          tcp_chr_change_state(s, TCP_CHARDEV_STATE_DISCONNECTED);
> -        if (s->registered_yank) {
> -            yank_unregister_function(CHARDEV_YANK_INSTANCE(chr->label),
> -                                     char_socket_yank_iochannel,
> -                                     QIO_CHANNEL(sioc));
> -        }
>          check_report_connect_error(chr, err);
>          goto cleanup;
>      }
> --
> 2.53.0
>
>

