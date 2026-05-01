Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DD2CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 11:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wImFr-0004Rr-Gi; Fri, 01 May 2026 07:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wImFp-0004RO-EZ
 for qemu-devel@nongnu.org; Fri, 01 May 2026 07:41:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wImFn-0005Nd-WD
 for qemu-devel@nongnu.org; Fri, 01 May 2026 07:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777635714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rc5UaK5DBFn3kJThVJPc+i62A7X0vRXUwIwOTZ+J9I4=;
 b=Czwm//hxcdXTuRZsRS34GOF5Fyqyjdmne21AqU5yNXxeBsALJKX5teUPvGvkPGhCv4LznA
 PLG/B/BDSfVJV6MgBCQ9RHXDTUs0SpjYZG2Kf+jLyaf9S7k99l5SXMJkGAzpmX4bW3AHrS
 3Gths6dcxrCuK5dXMUq86qTBHp6y35o=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-uN71C5xyOWqRmRa_uOn9vw-1; Fri, 01 May 2026 07:41:53 -0400
X-MC-Unique: uN71C5xyOWqRmRa_uOn9vw-1
X-Mimecast-MFC-AGG-ID: uN71C5xyOWqRmRa_uOn9vw_1777635712
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c7989b7cdd0so2208760a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 04:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777635712; cv=none;
 d=google.com; s=arc-20240605;
 b=KPvcqnNFTdufdzef+4v+i9J5bNMPx3auV7q3aHlkw3NlD8G4l5Vx5mQq6CP6ySudaH
 Nb5tmwISjD7vBkjLPyKEZ9WaP62sNoVFpww/Zqjc8DCc2jukWhNfZWUDu38nN+uVvpYR
 THLq69qhao9w17vOMWqGHKKCSL47nu9LIl4Cw1nbPqYCA+2DC92tJZHj/PoPUT0xapR3
 eFsCQOH8RkUo4ome0wuYm/EonaCcYjvNuT2EDWqdiOiUXqaBM5ocYyHj0O+ZZmTcLtVl
 QG33yWbsUcwQZXjEYkFmKksprkpLka6sBb6gLu1eg+mCKDznB6PjrQci0n3RNwBjsENj
 OcQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rc5UaK5DBFn3kJThVJPc+i62A7X0vRXUwIwOTZ+J9I4=;
 fh=4ZWcHei1al8MHWxiiWVKDV8qSzUI2Ji2Zw2//G2KLgU=;
 b=gCo+XZ4ey9JYESOlDYxAnfdtO/JrpOBfYgyumxuIV1LSweyvKMhJETUtEFNqMnAw2s
 LaFQC7LEqMfw/pxgUXbQ6ztcjrI1YEGK9xgX8yjxpnLj4nh+tgihMF/Ziynuuk4Xz7xS
 /Ggq/HKTB6p7TJHNlt/6fSPmmq+iBRlIaoKHxjVGsDu6AFtthNF/2rXIvPc9xAnH7CYD
 eNfsxUfYQjHqceY2DJj+rcYRadeeOyJsLi8YvKkvkNKw3ppVdv9/XGSCZTaLYaZ0Mj56
 lslXWOrSAGpcv7UNFjWOalmVTSyeGyuwCKW69LbeGNNLIyeJ0ZOkTmbqFgWCFubI/e/S
 U5Kw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777635712; x=1778240512; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rc5UaK5DBFn3kJThVJPc+i62A7X0vRXUwIwOTZ+J9I4=;
 b=XJaroYBm/5MbFDa9j8QCnZIZ+08e18dasnX5WvXwh1IKvqj0/cxwHMWH0HQuiuugd1
 m5zL/44rq0gPuJaxyqvf51q8YlC1Z9ZApKHIgdKthzNDNuKQrSwRV+AAx42H8T64N9yb
 KBEsV3PETte+YtVGFgGpzawPR0kcxyQ8NjfShrOlsfUX0wT7KzZrk3hc+GaI8J3OXIcX
 c5XuAYRy4Q44IvQl6CGtdGaXo78tRuxEcI8gR0p/E1jaMT0kMkbTSf8zj9m8u8F0gio2
 C/OlT1Z7Np1AI/uThOXLEsmzQV+BflH4GFu0RuQm23A0XO7VqPIdEoyWKhIe7Kdvc62e
 attg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777635712; x=1778240512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rc5UaK5DBFn3kJThVJPc+i62A7X0vRXUwIwOTZ+J9I4=;
 b=a0otrI/LfCDWfRqw0AkI13A0cJUqvpsfNG5739RAFiTzZPiBi/yeMl8y7MilH/lkt/
 QtYQf2p/YQ8WBKUr+rYA+rqZRoV6IiCUKHtKpBNzt4w4YL3N0EgxMSoLdxK7elIOTB/r
 +booXW67hVD6098nJECZIiUdul0EAlJ9OQut5TN/EPiTLAHm4bce9Doo540owkF6c4aM
 9WgHwbtB7AHw+imtgIo9FiV8VgeQWUsEinAz+tomyFljslsVpAB8S2zX1hcBFeD+PDuD
 qT7xgbO+KLzrOjD1d7J+55I1ie4zKp/gGydtB2wslaAlSYtM6GVjI/bt/MMkI1ztpxoN
 ePQQ==
X-Gm-Message-State: AOJu0Yw90zPDfFbGaP+NMYIR0lsPIW4wRFFmGNV+WxO0Cr1qzWNUHB4f
 TDAYKAPZGwBZakDsFDQcSmMMq0yXQXiVJMAVWaTJyxKFEZbfB+120ceWFxwm3OrSGm0GcOlOva2
 Bk/tKDjGw+jHvCHlRvHoV1X+Wwz1R9VZcHTZYe6UY+++xMaskL1a/74FhGyepxN6j0agaU4RqWI
 XR3+ne5JNOedL/8tZOfsbNjYz+Hsr12Hc8rFV2GYA=
X-Gm-Gg: AeBDieuG3n4X++scHAX16se00NbWiJOSscR/EsOw7gHpoZOzy9x/Nmhkd/T01Jfvu4x
 2+GkIynVM0KvWBluHm0LOgaQmxUxp5X/mfEUeavlC+vye2SSR3nqsBhZvv/DC4UlZp0cQLzaU2X
 v1STBs7Ezt+VUkuIlETBwHvBV3mbQn6GNJL4QinSTyyPAQgDChOIygvFAcqHXcUn1/yJ/NNIY2O
 mA7TId62PYJVJNqmR643H1oCW/+XiEH1RoqdemFDjPJKJCzMoHSLO2Ng2lM3Ou9c139ui0fU6h+
 RJDBCe9VsNM6qaDwqONMymDHIbik+O84udk=
X-Received: by 2002:a05:6a20:5493:b0:3a0:adc5:52c1 with SMTP id
 adf61e73a8af0-3a3cf566c0bmr7896582637.11.1777635711911; 
 Fri, 01 May 2026 04:41:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:5493:b0:3a0:adc5:52c1 with SMTP id
 adf61e73a8af0-3a3cf566c0bmr7896561637.11.1777635711423; Fri, 01 May 2026
 04:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260501-clipboard-assert-fix-v1-1-e549243e4583@gmail.com>
In-Reply-To: <20260501-clipboard-assert-fix-v1-1-e549243e4583@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 1 May 2026 15:41:39 +0400
X-Gm-Features: AVHnY4LZ0M41lUfIHnpuUMGAzrWWPrg0_BQQZmMPDdj5LW_rgC1EvuYcs3eN76E
Message-ID: <CAMxuvay3C0rdWthOB_-oPUoCzHFcy9wF5MR7hCTUt4jcKjUQxA@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: Fix GTK assertion failure introduced with
 clipboard fixes
To: =?UTF-8?B?SmluZMWZaWNoIE1ha292acSNa2E=?= <makovick@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 1, 2026 at 12:10=E2=80=AFPM Jind=C5=99ich Makovi=C4=8Dka <makov=
ick@gmail.com> wrote:
>
> gtk_clipboard_request_targets actually returns n_targets =3D=3D -1
> when targets =3D=3D  NULL instead of zero. This result in failed assertio=
n
> within GTK:
>
> qemu: Gtk: gtk_targets_include_text:
> assertion 'targets !=3D NULL || n_targets =3D=3D 0' failed
>
> Extend the check to require non-null targets and positive n_targets.
>
> Signed-off-by: Jindrich Makovicka <makovick@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> Hi,
>
> with my latest gtk-clipboard changes, I introduced the following GTK
> assertion failures due to unexpected n_targets value returned to
> callback from gtk_clipboard_request_targets
>
> qemu: Gtk: gtk_targets_include_text:
> assertion 'targets !=3D NULL || n_targets =3D=3D 0' failed
>
> from
>
> gboolean
> gtk_targets_include_text (GdkAtom *targets,
>                           gint     n_targets)
> {
>   gint i;
>   gboolean result =3D FALSE;
>
>   g_return_val_if_fail (targets !=3D NULL || n_targets =3D=3D 0, FALSE);
>
>   /* Keep in sync with gtk_target_list_add_text_targets()
>    */
>
>   init_atoms ();
>
>   for (i =3D 0; i < n_targets; i++)
> ...
>
> GTK actually returns -1 instead of zero when there are no targets,
> triggering the assert. The following patch extends the check to
> non-null targets and positive n_targets to be on the safe side.
> ---
>  ui/gtk-clipboard.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
> index 463ed4e905..ea9444be70 100644
> --- a/ui/gtk-clipboard.c
> +++ b/ui/gtk-clipboard.c
> @@ -175,7 +175,7 @@ static void gd_clipboard_owner_change_targets_receive=
d_callback(
>  {
>      QemuClipboardInfo *info =3D (QemuClipboardInfo *)data;
>
> -    if (n_targets) {
> +    if (targets && n_targets > 0) {
>          if (gtk_targets_include_text(targets, n_targets)) {
>              info->types[QEMU_CLIPBOARD_TYPE_TEXT].available =3D true;
>          }
>
> ---
> base-commit: 3d626609ccae61a2e552bccd59c7a0931bab8261
> change-id: 20260501-clipboard-assert-fix-cc2bf8672eba
>
> Best regards,
> --
> Jindrich Makovicka
>


