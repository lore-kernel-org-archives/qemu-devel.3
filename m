Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A432CFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHHda-00075H-Iz; Mon, 27 Apr 2026 04:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wHHdX-0006xs-Kf
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:48:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wHHdV-0001qf-PM
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777279683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KYAMeVT7lgF7XKOYiAQw2Qedp7gFTb1zs/HnvodzvtU=;
 b=VNsHdL+E6VOMIjYK7ZkvuM6KWZqK9jp4hailIMonPqncWR7b697xJx1JJR4DAEVmF9y8Ip
 28Pvb+mM6w7TpUuYN5KdSCbe+yQrhh7P4TgHROH+GNkPfX+d3we0tm9x3ET4bXvns9r83s
 fBih9vDxVNZokdJg1TNUZGK8RLxYAKA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-Ow-7f0UqM3uDy9xWsIwOLw-1; Mon, 27 Apr 2026 04:48:01 -0400
X-MC-Unique: Ow-7f0UqM3uDy9xWsIwOLw-1
X-Mimecast-MFC-AGG-ID: Ow-7f0UqM3uDy9xWsIwOLw_1777279680
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-358f058973fso11956015a91.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777279680; cv=none;
 d=google.com; s=arc-20240605;
 b=ZSp+YwgzZ2HyinoLmnUX/miHyFQAVBcW1msVi0vZryI16+FDAiJcjQ5d2TBSCDNGsY
 U5yqGO/SqypGo7j1GbYuQggbAvwxLIS0EYvgK3lKfGyNW0GMHr0uXdqEY7aMkehGkJGN
 J27U5RZI03Gj8LMKB0Xh3skBPGiSr8CWuNeY3q7VWT9s1gyyWpz9H5Vj2fN5RrarTFnE
 IiOuetJv+clDkYWgwIVav2z2UMJ5QvCn6mETHBw8XvmUQzHNJRrBX5gEtH5BNukCmibX
 +mTlIc1c71wrHdGHQTmjz9bKNBReo90jCoFBCEUngHIzs7vviCTvFnUzMc1rQQR2GGtj
 r02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KYAMeVT7lgF7XKOYiAQw2Qedp7gFTb1zs/HnvodzvtU=;
 fh=J7xodIOyOPHWq8GF8g25obbnHQSf61KAqKmG2qSosJc=;
 b=aVisVYCWTSl0WosGckcblPbfeMz2U/OBONriAe0gNiLreFnI62nU+y2p5pZxDGvw8m
 baizUyCViwqceNpotZPAmrRvZPSWekvBniSlY3af1Rg6o1kfa1Ig7gphHogs8kst28qu
 UrZF2EoYvP7lNaetTr6fOqX/CJp8aaFQy23kNnA+HKoF9mSiX4D17ICsh1mJF2WC9kby
 mytl4iRUZBik1wA2Wg9AllILM+vwBc0K090xDyDGeMSr9bR4Q+KoP5NJ/PWjOiT0iyvV
 I8uR0yLVVcOR4JX7/dxi8ioov+dVpUKO9mR1+vOHz4jkhWmkymkt7xxacVr3hkHptBBA
 99xw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777279680; x=1777884480; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYAMeVT7lgF7XKOYiAQw2Qedp7gFTb1zs/HnvodzvtU=;
 b=QCqO5vAE7vJfQf1jfyv/ZGMB/YBQn9iSaSbzOoxuncG6Qm7tkaohx6FOY16/dLuZpz
 CKMi6VkjntdG7q5Dfz9v9FDWc7yVuEURvtKQfk6rG+fLyX7R2uZ2sMY470FfgM6Ww/HW
 5i6N+366bONqtTAD+37L8dfEEjTQfc5y+VaARUpRbqmYQiMft2RtRAwxWuXE6WiPtgE+
 kPWf9LhoJylS2yQx1/td0sebAbdmQv0Foy09q5YuSx2QkoBft3BzkkjXjwqnTSd89lrx
 bFJg1yI0KlMceoYrWV65wRGQ5kecNj2lSjzjv6W58zQ9C5roPIdtjIj4dp7Vsmkhem7Z
 d0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777279680; x=1777884480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KYAMeVT7lgF7XKOYiAQw2Qedp7gFTb1zs/HnvodzvtU=;
 b=W8QuDdxDWgl8/23e4Nkjg8yIYSAQ97jDwHTRWqJmYipw6TgnDLn6pCCF5T4jRhbBjZ
 Etxad59s6391747EpheMefbK84x2FySqAjDRavg2SPPFoE5d+4Eb2YMZLV0unw/O+IvR
 K5f70vr47+SAIKhWHlcpRqqOHMQ4SAif2NIRK2N3jHkMQT2ApcBR89//HVGLMHpGsXZD
 4ghccmauXVXhIAXbkfy+SoLrEnK85TemwbKNNqpKuIAgzRsq+sDZDLWUfZDyP9aOwvPO
 /3PSgYzbcYakE//cWAtcAmhsoAYlheP/S+RERQKz3t4OcVhpW6IphSetH4kxYo92CZx4
 GS8Q==
X-Gm-Message-State: AOJu0YwWrUJg1sm+uiuFwuSfRfFe/LW/0ybYfNRlU9kge8mevKiHFYRn
 A8T+tkIRHijyoQIOe5iGWr4Z2m8TW/Co113jMLIUzTFY9oS2o5h8SO1Sexpk38f5ZJgmLhXoiUY
 BIihvtyo8j5afDprIk14M1Dk8lKGMkvneztfnl35X8pX1WidCFotE/BFBSgNNKtsEhmrXEd0paK
 oo/0j00HPOKGaRRMcJfm21oVccUArR7i0=
X-Gm-Gg: AeBDiev5eX2Mz2kSE+D3O2WZBOzpB3QHb50Ewdrr4ws4Sq+T2e0bzpqTrWMm+OU4FbG
 CFg62xLhK/lX0Lk5ipvskfec3EsLqyAQNxFFf+/0j5VIHVP4fTETA9OED1sLocMsJzWnSrsLNvu
 GtscmjxfpHphL+x+ov50PlzJdeBUxV78w3hwM6iKkvwobaGsCA47xK1/KacvKzCtA8XQWdpKvZl
 /5leJ31mMJvTjcFXdkjCHr9GN33gEBROB6xEE8GO8vlD2SFUsrEg5s/3PEnZemJQJAstsWelOwz
 LSJWf9wq5kcIuVNmtzCGC4itxcx/HiCLklI=
X-Received: by 2002:a05:6a20:2591:b0:398:9ae9:7110 with SMTP id
 adf61e73a8af0-3a08d6f1419mr47326938637.11.1777279680289; 
 Mon, 27 Apr 2026 01:48:00 -0700 (PDT)
X-Received: by 2002:a05:6a20:2591:b0:398:9ae9:7110 with SMTP id
 adf61e73a8af0-3a08d6f1419mr47326909637.11.1777279679850; Mon, 27 Apr 2026
 01:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260426-gtk-clipboard-v3-0-09555aaeda34@gmail.com>
 <20260426-gtk-clipboard-v3-1-09555aaeda34@gmail.com>
In-Reply-To: <20260426-gtk-clipboard-v3-1-09555aaeda34@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 12:47:48 +0400
X-Gm-Features: AVHnY4LZBEkyUXosxFDANdarO4XicP59bVskNq0XkCz1fSzbMQPo8wSGKretgYc
Message-ID: <CAMxuvawm5Rpq2E5VbtrugJ3MZsWT1kPahJZR4=SZy-y+wgk9dw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ui/gtk: Use non-blocking clipboard retrieval
To: =?UTF-8?B?SmluZMWZaWNoIE1ha292acSNa2E=?= <makovick@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Apr 26, 2026 at 11:52=E2=80=AFAM Jind=C5=99ich Makovi=C4=8Dka <mako=
vick@gmail.com> wrote:
>
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

could you use gtk_clipboard_request_targets instead?

lgtm otherwise

>          break;
>      default:
>          qemu_clipboard_peer_release(&gd->cbpeer, s);
>
> --
> 2.53.0
>


