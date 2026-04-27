Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695FDFF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHHhp-0008LG-LC; Mon, 27 Apr 2026 04:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHHhl-0008Ku-9V
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:52:37 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wHHhj-00034m-6Q
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:52:36 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-2d96243c91fso16108557eec.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:52:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777279953; cv=none;
 d=google.com; s=arc-20240605;
 b=MCN7+7kJRrs+AtED3qN4onyyf/bbzG/fgyjMUCUXQOdAotMGrMIfMsOm1x5GXaeepR
 xQwErcgnr3awMmA1k5bBz8O6Tgj7fXmL155utUXv0h262F6D+Q+lMzD+5RDEEK+K99Jy
 g+TyQiqeG5AEV3kqP/NEFWexQzTXvTEmZgRuv9+pcZT///17SyQ6aDrQ3McftEeL5yv4
 Bfw+1O0ZeV+Ur/gQy/qBTiIfnPs8n/vS7o1jU9fLa4zDUeWva5NK40SRfsgPd2Uup1A6
 GeYxLyh9smx1PiOW4mStGAhTUolW5tz4maMh+xuoa7Rl7r3QFE7ecajkO6LmkTE9CDDN
 MjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9cFhZbLX8ef0LjfaC1F9+S9zUbn2kz0oE0tHz84oue8=;
 fh=J7xodIOyOPHWq8GF8g25obbnHQSf61KAqKmG2qSosJc=;
 b=ZCVTKRtt3S5eu56ooy/Rc/VJzNhAWweIeRRi5T2qXY4Dn6OmtagDA+H+coT4JEmPC1
 JhAeSnjEE588vFvK7YZWANUAUmND1ngek+CmYnkOuB7+ytVCZcdMxoQbeLXXFFu9ycUo
 TVoQ5+vUED5YQYMCLTAhBuOwtGwNBGn+qNmNtJaL9Yj+GblDgdLUia70otxn1lP+7W8B
 r3Nh1GTIlanTa/EJHgksh9TbzOF/2sPoVZmlJjuvGTL/aaZqSEleAj8lxhMew2kSK3fc
 a4dWak41By39EaCdCu+0SYVW5tGugD83il6Yo6Kmc3Qxqgl6ecdZs7i6emGUfuoV2yPL
 R1jQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777279953; x=1777884753; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9cFhZbLX8ef0LjfaC1F9+S9zUbn2kz0oE0tHz84oue8=;
 b=MdJW58BklK1xo422Z35jcFSNCwktD00gJBzy+j43uTT+D9HlDIxNqDEnSGn6rAqLrE
 fGeJcY9kVAogTKU734LqerVIwofPFRcjSX0R1DCOD8tfvQAzl07fVimUOmYMy45tbKuq
 VcZSUf47V7zexuuHiQG6RQyGBIEdiFikdDfFGbbqcBANHkewmghV62gIdvDeX5GqPjeJ
 Z4vTpxGpGFhqvzUReE3CQ2N0m2y+D9mVQ9WHMEKD7EGSzU09neJz6w7f80OOzzXxEoir
 n/AxZ2nam0RxdJosaOrIclTlEopMJ7YWMYjkHOsjz3mVh/Pi9xnFlPJZJAIP5/maeHUe
 Ynqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777279953; x=1777884753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9cFhZbLX8ef0LjfaC1F9+S9zUbn2kz0oE0tHz84oue8=;
 b=CXBPPpb3u/ACaoHCpkQBH5dVH4fnYRggVKhZeki7CSnT+idGcaZnD3AynPBVAMs3W+
 dD9/xfKPcR3cojcBFRN/wOEt7aClZutX9m4QjZdlL4iJ8YjP4OML//io5lcnHZ1e907Y
 dFpA2Yx9YaDVGnYdjx3F2BsdSq0FVRgulOhB47qispJ7/Y8NUdnrJhMmKYHPIiDG85wV
 v1iRTt54Y2ZmU+oLzSo3vlgG5/bbappQjVOtn7ieJXusE3UyvXmgYBD5iLL+nm9pgE/E
 /NsusdHHot3lpXSt4jD4xBvLG9Co+6qZCICq1sLJmRWVOUgqiOh8oTew/5qXrJb/G3Je
 cuww==
X-Gm-Message-State: AOJu0YwSXLupdXWqce/YfhE7QqVAEhB7PuHW5TkJg16R8qQaaQ3kNs8j
 Kw13tO3DxOwzQgJjhczV+x1rrEe0ByzscvI0463mgbLjTP94m+kRCXrqJ/B+IohRkuTRA8xWoY1
 C2DNrqPD72uMtdinnxQwwSHDSt+zfb+E=
X-Gm-Gg: AeBDiesByTYkjTZxWw2++DPsYLPA8uAmRsOy7zZXcWT7zHFvYYtItTdvwpfUmYXOr9Y
 WHAERSn+5bh7DRNcf9H4svKSY0RfTaK0DtYuvFUuRLuOtYCLDJDO9EYR/PyqFdCv7UkCvvotcDn
 4mxvWxY91ppp8r5RUvlCnjZ5CK0LNi36R5N7xfXJ9w/uWSN4TZ2LWKhhHQfW5HVnuV6deMPWkjT
 TA50jkt8xjT3i+qzFSgUlsVCh3G3NBfr6fizLw42+BNSfPJyhsp9C25avMCo87sdH2j3Z44+WKA
 Y76HF+MBL5B721cj/hGsyUyihK03G7OqN0G+onhmi331pwjHh1I=
X-Received: by 2002:a05:7300:6c05:b0:2d4:2cc8:67e with SMTP id
 5a478bee46e88-2e47a106ccfmr24187499eec.23.1777279953188; Mon, 27 Apr 2026
 01:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260426-gtk-clipboard-v3-0-09555aaeda34@gmail.com>
 <20260426-gtk-clipboard-v3-1-09555aaeda34@gmail.com>
In-Reply-To: <20260426-gtk-clipboard-v3-1-09555aaeda34@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 12:52:21 +0400
X-Gm-Features: AVHnY4IwHFeZN28CPsM1Ii2EWRrSWJKBsLJVk8kU5vwaj3Bd8-Ndw7kEpvTLr7Y
Message-ID: <CAJ+F1CLwkT9EJLFNDoW1Z6B7adrL=hr_3xUHE9m4K9K1AG=WJw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ui/gtk: Use non-blocking clipboard retrieval
To: =?UTF-8?B?SmluZMWZaWNoIE1ha292acSNa2E=?= <makovick@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

Hi Jind=C5=99ich

On Sun, Apr 26, 2026 at 11:53=E2=80=AFAM Jind=C5=99ich Makovi=C4=8Dka <mako=
vick@gmail.com> wrote:
>

Could you review & compare with the previous lost patch ("[PATCH v4]
ui/gtk-clipboard: async owner_change clipboard_request")

https://patchew.org/QEMU/20231206142243.510068-1-edmund.raile@proton.me/

thanks

> Signed-off-by: Jindrich Makovicka <makovick@gmail.com>
> ---
>  ui/gtk-clipboard.c | 52 +++++++++++++++++++++++++++++++++++++++---------=
----
>  1 file changed, 39 insertions(+), 13 deletions(-)
>
> diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
> index 65d89ec601..691784697d 100644
> --- a/ui/gtk-clipboard.c
> +++ b/ui/gtk-clipboard.c
> @@ -136,26 +136,54 @@ static void gd_clipboard_notify(Notifier *notifier,=
 void *data)
>      }
>  }
>
> +static void
> +gd_clipboard_request_text_received_callback(GtkClipboard *clipboard,
> +                                            const gchar *text,
> +                                            gpointer data)
> +{
> +    QemuClipboardInfo *info =3D (QemuClipboardInfo *)data;
> +
> +    if (text) {
> +        qemu_clipboard_set_data(info->owner, info, QEMU_CLIPBOARD_TYPE_T=
EXT,
> +                                strlen(text), text, true);
> +    }
> +    qemu_clipboard_info_unref(info);
> +}
> +
>  static void gd_clipboard_request(QemuClipboardInfo *info,
>                                   QemuClipboardType type)
>  {
>      GtkDisplayState *gd =3D container_of(info->owner, GtkDisplayState, c=
bpeer);
> -    char *text;
>
>      switch (type) {
>      case QEMU_CLIPBOARD_TYPE_TEXT:
> -        text =3D gtk_clipboard_wait_for_text(gd->gtkcb[info->selection])=
;
> -        if (text) {
> -            qemu_clipboard_set_data(&gd->cbpeer, info, type,
> -                                    strlen(text), text, true);
> -            g_free(text);
> -        }
> +        qemu_clipboard_info_ref(info);
> +        gtk_clipboard_request_text(gd->gtkcb[info->selection],
> +                                   gd_clipboard_request_text_received_ca=
llback,
> +                                   info);
>          break;
>      default:
>          break;
>      }
>  }
>
> +static void gd_clipboard_owner_change_contents_received_callback(
> +    GtkClipboard *clipboard,
> +    GtkSelectionData *selection_data,
> +    gpointer data)
> +{
> +    QemuClipboardInfo *info =3D (QemuClipboardInfo *)data;
> +
> +    if (selection_data) {
> +        if (gtk_selection_data_targets_include_text(selection_data)) {
> +            info->types[QEMU_CLIPBOARD_TYPE_TEXT].available =3D true;
> +        }
> +    }
> +
> +    qemu_clipboard_update(info);
> +    qemu_clipboard_info_unref(info);
> +}
> +
>  static void gd_owner_change(GtkClipboard *clipboard,
>                              GdkEvent *event,
>                              gpointer data)
> @@ -173,12 +201,10 @@ static void gd_owner_change(GtkClipboard *clipboard=
,
>      switch (event->owner_change.reason) {
>      case GDK_OWNER_CHANGE_NEW_OWNER:
>          info =3D qemu_clipboard_info_new(&gd->cbpeer, s);
> -        if (gtk_clipboard_wait_is_text_available(clipboard)) {
> -            info->types[QEMU_CLIPBOARD_TYPE_TEXT].available =3D true;
> -        }
> -
> -        qemu_clipboard_update(info);
> -        qemu_clipboard_info_unref(info);
> +        gtk_clipboard_request_contents(
> +            clipboard, gdk_atom_intern_static_string("TARGETS"),
> +            gd_clipboard_owner_change_contents_received_callback,
> +            info);
>          break;
>      default:
>          qemu_clipboard_peer_release(&gd->cbpeer, s);
>
> --
> 2.53.0
>
>

