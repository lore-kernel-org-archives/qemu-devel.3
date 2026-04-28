Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31D5FF886F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 05:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHbTR-0005GG-AS; Tue, 28 Apr 2026 01:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHbTP-0005G0-92
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 01:59:07 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <makovick@gmail.com>)
 id 1wHbTN-0004GA-GT
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 01:59:06 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso152236335e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 22:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777355944; x=1777960744; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/WkmntmYq1lL6k7YcNrMzZ0/534/DWxK37YNwawLpPg=;
 b=GD5XsfUPYbIrDiQXm89t5bHXkELVv1JsFvp+zzb0sskLxYMHerH3uxRGjY8K2rmQij
 icQoRblUpl1oDLnL1XRG5nhzSbI/GfkJfHaY7SP9RSyhktITrkiXlWMJj+af/uspR1dq
 d4xI4p7MZpK/pdm/sTNw82NJXOmD8PNesc4qrVUWqYtzEO3yu1kZAPssGMCv41weD1k1
 scYaKE09gDxOzvWJkXQmTzgbEV461EyKogOBmfx0/o07HoIhpFWF2pPEZiimPK5dyZdF
 chk/sOPXx+wadVRIfPVE9SQcYYScoHaE6eVz69WgMtH++sDNBT594bQyWDbRA6w1JkHk
 vlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777355944; x=1777960744;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/WkmntmYq1lL6k7YcNrMzZ0/534/DWxK37YNwawLpPg=;
 b=fVQdguxCNg0e4BmEFMOgaB3FnGDhBn6DFPXiOuY+aBgYRlXPJhzzzv6oVtyY07ItIA
 btESMYjrlGfRnJJwZO2yaY2TG0EIYYmh21nspQMdIr9X9sOsgpou/GP5s2u/1Z96/6Bw
 BbQqrcozXrceIv1awwM2BBVhjoD33TRy98Ye5Bd48IHdYM0OB6upGzGvKD0rsNzLf3A2
 cRcZ9G2jo3u2Gqhd8jHd0tzAFBA80ZOcRlxWTj6t+5UPhwj3fM0TLCjwPnyY8QepGA/C
 0D6j38mMUhLeVxuFDIutunObZAMa9fNiSXaMQq/kvmZd7yISZVkbeDSo6EE2TmefbmSQ
 aDLw==
X-Gm-Message-State: AOJu0Yz2Kooyb+B3o1VWKvu27Z/4NKyb7lj6CG/4AyITF6ZtJyxX1j/P
 c5fXGJQtg05k4aJ0wcTM5moSD1Xyw3U+SP5NTadgY3RG409mh5fVyER7
X-Gm-Gg: AeBDieu06UlfX2OYxjTBSpiTEtZQNKh3nrzzHOCc8BsRsjjp+pB+ftIT4r0Tk4WZU/y
 7Wjx2H1oDmbdWmONfIVQOIEDBnC16KmjQDXzTL/U3CCkJV3c4YGP91CK915UQWeN6YRCnrxtbfp
 +6eKbKNap/aztV7rguSqLzbLhKr53qZBvdJCpPhejKRzLLhshptfGRHoIbD/8HNJz6qwZfHsvry
 yTuy+nKMYAceETSiDz3KbzzDMm6baz7wfz9CFB5v1mqVjdfk+7eMEu60Ufl/9wMrk4o1Uw+/iXl
 Ed5cPoG1JW2vT3Sr95Ovv7ED2mwtzNfMjZRiyygvzlwEPydzYcP4iL3nN5Jb0yxIjaj/IEcmgUM
 9bkbndWshlbhxRRWmSG9NbWxfUldDaJNd2qDanmSGi4artgo6PmmJB3Oyo86mDjwZM/LhJ9qxKQ
 XjEPY3JuBmMSmfNavTXqXae1SPEaIluAzLMcECEPnw9h8UOrBQLDA=
X-Received: by 2002:a05:600c:8590:b0:489:1fa4:50c6 with SMTP id
 5b1f17b1804b1-48a77b19f8bmr16926915e9.20.1777355943498; 
 Mon, 27 Apr 2026 22:59:03 -0700 (PDT)
Received: from holly.home.arpa ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773e7c26sm30372275e9.9.2026.04.27.22.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 22:59:03 -0700 (PDT)
Message-ID: <b6edce93663c531df35d2f995a736c9bdfb46dae.camel@gmail.com>
Subject: Re: [PATCH v3 1/2] ui/gtk: Use non-blocking clipboard retrieval
From: Jindrich Makovicka <makovick@gmail.com>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P."
 =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 07:59:02 +0200
In-Reply-To: <96a72d0c9fec24f3c710ecacfe8ab36e2d006d3b.camel@gmail.com>
References: <20260426-gtk-clipboard-v3-0-09555aaeda34@gmail.com>
 <20260426-gtk-clipboard-v3-1-09555aaeda34@gmail.com>
 <CAJ+F1CLwkT9EJLFNDoW1Z6B7adrL=hr_3xUHE9m4K9K1AG=WJw@mail.gmail.com>
 <96a72d0c9fec24f3c710ecacfe8ab36e2d006d3b.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=makovick@gmail.com; helo=mail-wm1-x333.google.com
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

On Mon, 2026-04-27 at 21:26 +0200, Jindrich Makovicka wrote:
> Hi,
>=20
> On Mon, 2026-04-27 at 12:52 +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi Jind=C5=99ich
> >=20
> > On Sun, Apr 26, 2026 at 11:53=E2=80=AFAM Jind=C5=99ich Makovi=C4=8Dka
> > <makovick@gmail.com> wrote:
> > >=20
> >=20
> > Could you review & compare with the previous lost patch ("[PATCH
> > v4]
> > ui/gtk-clipboard: async owner_change clipboard_request")
> >=20
> > https://patchew.org/QEMU/20231206142243.510068-1-edmund.raile@proton.me=
/
>=20
> The GTK part of this patch is basically my v2, with both paths using=20
> gtk_clipboard_request_text .
>=20
> Then there is the serial number checking I am not familiar
> with.=C2=A0However, qemu_clipboard_check_serial seems to require info-
> > has_serial set to true which is not done in this patch (only info-
> > serial is set) so this half of serial number check is effectively
> > no-
> op.

I think the change below should work if we want to be safe from out-of-
order clipboard events, but I'd rather leave it to someone who has
experience with this feature (i.e. vdagent or dbus dev)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index 3e6ce3cb48..321f02e656 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -149,6 +149,7 @@ struct GtkDisplayState {
     uint32_t cbpending[QEMU_CLIPBOARD_SELECTION__COUNT];
     GtkClipboard *gtkcb[QEMU_CLIPBOARD_SELECTION__COUNT];
     bool cbowner[QEMU_CLIPBOARD_SELECTION__COUNT];
+    uint32_t cb_serial_owner_change;
=20
     DisplayOptions *opts;
 };
diff --git a/ui/gtk-clipboard.c b/ui/gtk-clipboard.c
index 463ed4e905..6a3b0dbb32 100644
--- a/ui/gtk-clipboard.c
+++ b/ui/gtk-clipboard.c
@@ -143,7 +143,7 @@
gd_clipboard_request_text_received_callback(GtkClipboard *clipboard,
 {
     QemuClipboardInfo *info =3D (QemuClipboardInfo *)data;
=20
-    if (text) {
+    if (text && qemu_clipboard_check_serial(info, true)) {
         qemu_clipboard_set_data(info->owner, info,
QEMU_CLIPBOARD_TYPE_TEXT,
                                 strlen(text), text, true);
     }
@@ -202,6 +202,8 @@ static void gd_owner_change(GtkClipboard
*clipboard,
     switch (event->owner_change.reason) {
     case GDK_OWNER_CHANGE_NEW_OWNER:
         info =3D qemu_clipboard_info_new(&gd->cbpeer, s);
+        info->serial =3D ++gd->cb_serial_owner_change;
+        info->has_serial =3D true;
         gtk_clipboard_request_targets(
             clipboard,
             gd_clipboard_owner_change_targets_received_callback,

Regards,
--=20
Jindrich Makovicka

