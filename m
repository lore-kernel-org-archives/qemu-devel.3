Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A76C5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyTuf-0005Oo-HY; Mon, 24 Aug 2026 08:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wyTue-0005Od-DF
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:36:28 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wyTuc-00013b-CH
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:36:28 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cc1469c1b83so4512290a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 05:36:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787574985; cv=none;
 d=google.com; s=arc-20260327;
 b=MVo/Im06RRLtovfILZGOeRk0VDD9xNJkalyEmbf+9azeXil0pROiwmDuM+95unvC+h
 laGU93Jeb8R5Ibzs6Iy/HlFGGlbUQr7TnpE5r/KYaUXvrdLbw13HbAKiuXKQsXXb/u6Q
 qybPlD5JMiGLekWkCqVlztfdc1sKW0kCP955ASp3ROg5vQqdqAkqTc3zzfk9NfQMaA9I
 X3O6l2afllKyoljF/S+f6xO98s+mcBswHOtec9Zm6hQzLdrzB4eCOxqMcCyG7s0TUOiv
 VcoMJP9JNF+YClxu5rpRHI3pHfsMFYI7077gQNNe6qmw+jg4chGXcZPG9TPUKojn2OI+
 3CcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gqf35q94BR5FEhFG6nsYjPRC7TRHqSIYJ/Qw6G0hK/Q=;
 fh=2T99PgPMOlWfK2uJ+dhWpOkBVsvCbNgYg5NELY2BWtw=;
 b=EGoF5ibU0CgxG6UNpFYsOCCrhjN4M872Tw84JD1+ecEE0VgEnyy3ZHiR09xK1eJg0n
 XVZsMJUkog4evqSLJAvDUngdbypoBsH5Q7j7NBwyKdddTjC7zx5RbwJrhhHv9SgnTKrk
 ql3UIq1rJKOMgUYqKQOh3+ijRFt7JJ8WLaYpPIsK8NPIljoE/zscUeqCGsH8XiriSyAu
 JpJhBH7PL9svexBbvd8vwpt4vwRocLTarpGnknF3G8oP/WgKY1pUiQ3EsJkfIlJmqYh7
 4ynpe6PT+z5Sa90oscVzjBIno8KvXb5Vmw39ximjROGLnvYH8Z1XjWt9+6t+tiwzNwpa
 yMlw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787574985; x=1788179785; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gqf35q94BR5FEhFG6nsYjPRC7TRHqSIYJ/Qw6G0hK/Q=;
 b=SpacZ+RxdXUWvXSPOZIJI0gRG4EV1QbnnIkb7C3m333TO5Sn2+tki9btHbB8OhLVhM
 wu8Q/Uc+qGq6kfZV7CZ+uMxlVDY9lWwNOzr3EqMH7wYhSSCePvKzjjFRWrifdvE0cTjx
 Y8fvmFTiqOjoEpUgc8ukq+jQpSzc8+1ILZ57wyr15YYi6POozHnNmc+CNZ897/id8fji
 AOaQBD7+xA5XJGSuzWlnaI3CEHN3r2vuuoPe8fmU48b3AbaXWkWvkG1Jhht8MgFHmGgd
 WVFa7PrK38PqtBuMp8LLH8t07pEo/Ip0Qzj0v8NOofULCWg72IwztQYHSPEUbYnIdz2u
 BwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787574985; x=1788179785;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gqf35q94BR5FEhFG6nsYjPRC7TRHqSIYJ/Qw6G0hK/Q=;
 b=iTgPrR+BXQ0OaGpdTJAWsJbqXe6QN//HagepB6ZaKFKk1B+cWCmkYohLxyAzU5218d
 D9voYPpr20K6xrMb2BlrpI0VA3MNcbg1hiy+baEDEtapiBio6/Eb18tf98tJLFEGA73p
 6h9QepeXYHGA9HA2Yw9B5sbIzzg3VDnU1CeNtskU+QHsNMyX0jnyZiHkzH0+ijLZRuep
 K9zVyP4SRsI5sc2VDO8TE9DhmQPT+uwvGlsP0oAl7IFsfNtxWpAOW8HXke2VAjtt55/Z
 teC5HJuI2bprLij/SW/ZgTLDYz05HrITjm7X+LrYK6mwPN2JE4GKt1SdL+iJNSBn9IU6
 /VCQ==
X-Gm-Message-State: AFuF++ngxXCe7YHQuzlP8kk8tmymL6ErJjf6IHoP1Tnz/vzDvfnRum6u
 IVkZ++ym3J9mDpxUfZhT0gp1ZhJ2x2XfB4hoSDoSHWVt2vywaFSb5JNtlDAiO4JNvR0po0Nu9Ud
 slCEZqeQ6oKxFaZHkhMwtbOYeXa4IenDlVmHy
X-Gm-Gg: AR+sD10NQKz5+r1MUN64ndTkaNPj0QM763dVgiE2ljJ3X/VpUNeWO0mQdcxOYB1Vc6e
 lY7m9YtkBPHew+Wu1lS0eF9RBZD2GGs6kBrRxrnDfxYywU2uyR7aq9E+/1Gu9ylAmezoA5wsVvy
 kcimsBDOMXGYUTznqrUFusihW1c0zLw9XyDDX7V/o7mfAgBcDkRG4S+X2NBa35te1pSppeGyQHX
 4tBaNkFlluQTJTV+8xXU0BKPt42l61j+QpZ4Zxs54p/BedulNmSsSZw3B9fMmdbhbyd71iSsw5G
 EHGZvqozDhybdiDEicFEqenjpdfM0pJXm6JAKXtjhrlCZsPiWys1ZF8zbQ==
X-Received: by 2002:a05:6a20:394a:b0:3c3:791e:5e18 with SMTP id
 adf61e73a8af0-3cd2fe7a34cmr45964587637.7.1787574984685; Mon, 24 Aug 2026
 05:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260818121413.2660786-1-lucas.kornicki@nutanix.com>
 <20260818121413.2660786-5-lucas.kornicki@nutanix.com>
 <CAJ+F1CKuDAzTz2iC+acOKf2j1vW3iFE6jinTKL=AwWCu3-1KGg@mail.gmail.com>
 <43d32e1c-ae73-4863-87a5-98c2f6ee5fe0@nutanix.com>
In-Reply-To: <43d32e1c-ae73-4863-87a5-98c2f6ee5fe0@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 24 Aug 2026 16:36:12 +0400
X-Gm-Features: AcwNN1WNbVg4y2W1boyvilSKP6FCk6f1dsBrV5RS6Wt9jwS0OmSuDTa1JHuKUys
Message-ID: <CAJ+F1CL_Z2C_k5_40VT9P6t80Z56YBObQ1fiQpW3t_nO0h1JWg@mail.gmail.com>
Subject: Re: [PATCH 4/4] ui/vnc: notify client of clipboard peer status
To: Lucas Kornicki <lucas.kornicki@nutanix.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x532.google.com
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

Hi

On Tue, Aug 18, 2026 at 5:56=E2=80=AFPM Lucas Kornicki
<lucas.kornicki@nutanix.com> wrote:
>
> Hi Marc-Andre
>
> I quickly became aware of the shortcomings of my v1 series and I've
> already drafted a v2 where the cover is a bit more detailed and the
> commits were fixed to remove the Change-IDs.
>
> On 8/18/26 15:33, Marc-Andr=C3=A9 Lureau wrote:
> > !-------------------------------------------------------------------|
> >    CAUTION: External Email
> >
> > |-------------------------------------------------------------------!
> >
> > Hi Lukasz
> >
> > On Tue, Aug 18, 2026 at 4:15=E2=80=AFPM Lukasz Kornicki
> > <lucas.kornicki@nutanix.com> wrote:
> >> Introduce a new vnc message (VNC_MSG_SERVER_QEMU_CLIPBOARD_STATUS) and
> >> the corresponding feature/encoding.
> >>
> >> When a client requests this feature, the server will inform the client
> >> whether a guest clipboard peer is present. The server will repeat the
> >> notification each time availability of a guest clipboard peer changes.
> >>
> >> This change enables the VNC client to determine if a guest side
> >> clipboard peer is available for clipboard exchange and react to
> >> changes of its availability.
> >>
> >> Until now the VNC clipboard peer was only registered when
> >> VNC_FEATURE_CLIPBOARD_EXT was enabled. With this change the VNC peer
> >> can be registered just for the purpose of receiving peer status
> >> updates. This requires introducing a VNC_FEATURE_CLIPBOARD_EXT guard
> >> before the QEMU_CLIPBOARD_UPDATE_INFO handler which previously only ra=
n
> >> if VNC_FEATURE_CLIPBOARD_EXT was enabled.
> >>
> > The series looks good, but this extension is not documented afaict.
> > Can you make a PR for it?
>
> Sure. I've found this repo before but was not aware that it functions in
> any official capacity.

I dont think we should take the change until the rfbproto documents it.

thanks

>
> >> Change-Id: Id0897a24fae103288c399f73e808ed6c07018359
> > What is this? Is it a gerrit thing?
> Yes, I forgot to remove the commit-msg hook and they got regenerated
> right after I removed them :)
> >> Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
> >> ---
> >>   ui/trace-events    |  1 +
> >>   ui/vnc-clipboard.c | 31 ++++++++++++++++++++++++++++++-
> >>   ui/vnc.c           |  6 ++++++
> >>   ui/vnc.h           |  8 ++++++++
> >>   4 files changed, 45 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/ui/trace-events b/ui/trace-events
> >> index 917d116d90..d2fe153b7d 100644
> >> --- a/ui/trace-events
> >> +++ b/ui/trace-events
> >> @@ -48,6 +48,7 @@ vnc_msg_server_ext_desktop_resize(void *state, void =
*ioc, int width, int height,
> >>   vnc_msg_client_audio_enable(void *state, void *ioc) "VNC client msg =
audio enable state=3D%p ioc=3D%p"
> >>   vnc_msg_client_audio_disable(void *state, void *ioc) "VNC client msg=
 audio disable state=3D%p ioc=3D%p"
> >>   vnc_msg_client_audio_format(void *state, void *ioc, int fmt, int cha=
nnels, int freq) "VNC client msg audio format state=3D%p ioc=3D%p fmt=3D%d =
channels=3D%d freq=3D%d"
> >> +vnc_clipboard_peer_status_send(void *state, bool present) "VNC server=
 clipboard peer status state=3D%p present=3D%d"
> >>   vnc_msg_client_cut_text(void *state, void *ioc, int len) "VNC client=
 msg cut text state=3D%p ioc=3D%p len=3D%u"
> >>   vnc_msg_client_cut_text_ext(void *state, void *ioc, int len, int fla=
gs) "VNC client msg cut text state=3D%p ioc=3D%p len=3D%u flags=3D%u"
> >>   vnc_msg_client_ext_key_event(void *state, void *ioc, int down, int s=
ym, int keycode) "VNC client msg ext key event state=3D%p ioc=3D%p down=3D%=
u sym=3D%u keycode=3D%u"
> >> diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
> >> index 67f710f6ed..4ecc4489e4 100644
> >> --- a/ui/vnc-clipboard.c
> >> +++ b/ui/vnc-clipboard.c
> >> @@ -26,6 +26,7 @@
> >>   #include "qemu/error-report.h"
> >>   #include "vnc.h"
> >>   #include "vnc-jobs.h"
> >> +#include "trace.h"
> >>
> >>   static uint8_t *inflate_buffer(uint8_t *in, uint32_t in_len, uint32_=
t *size)
> >>   {
> >> @@ -224,6 +225,23 @@ static void vnc_clipboard_update_info(VncState *v=
s, QemuClipboardInfo *info)
> >>       }
> >>   }
> >>
> >> +void vnc_clipboard_peer_status_send(VncState *vs, bool present)
> >> +{
> >> +    if (!vnc_has_feature(vs, VNC_FEATURE_CLIPBOARD_STATUS)) {
> >> +        return;
> >> +    }
> >> +
> >> +    trace_vnc_clipboard_peer_status_send(vs, present);
> >> +
> >> +    vnc_lock_output(vs);
> >> +    vnc_write_u8(vs, VNC_MSG_SERVER_QEMU);
> >> +    vnc_write_u8(vs, VNC_MSG_SERVER_QEMU_CLIPBOARD_STATUS);
> >> +    vnc_write_u16(vs, present ? VNC_CLIPBOARD_PEER_PRESENT
> >> +                              : VNC_CLIPBOARD_PEER_ABSENT);
> >> +    vnc_unlock_output(vs);
> >> +    vnc_flush(vs);
> >> +}
> >> +
> >>   static void vnc_clipboard_notify(Notifier *notifier, void *data)
> >>   {
> >>       VncState *vs =3D container_of(notifier, VncState, cbpeer.notifie=
r);
> >> @@ -231,13 +249,24 @@ static void vnc_clipboard_notify(Notifier *notif=
ier, void *data)
> >>
> >>       switch (notify->type) {
> >>       case QEMU_CLIPBOARD_UPDATE_INFO:
> >> +        /* ignore the update if client does not want ext messages */
> >> +        if (!vnc_has_feature(vs, VNC_FEATURE_CLIPBOARD_EXT)) {
> >> +            return;
> >> +        }
> >> +
> >>           vnc_clipboard_update_info(vs, notify->info);
> >>           return;
> >>       case QEMU_CLIPBOARD_RESET_SERIAL:
> >>           /* ignore */
> >>           return;
> >>       case QEMU_CLIPBOARD_PEER_UPDATE:
> >> -        /* ignore */
> >> +        /* only guest side peers affect the status we relay to the cl=
ient */
> >> +        if (!notify->peer_update.peer->guest) {
> >> +            return;
> >> +        }
> >> +
> >> +        vnc_clipboard_peer_status_send(vs,
> >> +            qemu_clipboard_guest_peer_present());
> >>           return;
> >>       }
> >>   }
> >> diff --git a/ui/vnc.c b/ui/vnc.c
> >> index 656768f9c9..9e44a20311 100644
> >> --- a/ui/vnc.c
> >> +++ b/ui/vnc.c
> >> @@ -2191,6 +2191,12 @@ static void set_encodings(VncState *vs, int32_t=
 *encodings, size_t n_encodings)
> >>               vnc_set_feature(vs, VNC_FEATURE_CLIPBOARD_EXT);
> >>               vnc_server_cut_text_caps(vs);
> >>               break;
> >> +        case VNC_ENCODING_CLIPBOARD_STATUS:
> >> +            vnc_set_feature(vs, VNC_FEATURE_CLIPBOARD_STATUS);
> >> +            vnc_clipboard_peer_register(vs);
> >> +            vnc_clipboard_peer_status_send(vs,
> >> +                qemu_clipboard_guest_peer_present());
> >> +            break;
> >>           case VNC_ENCODING_COMPRESSLEVEL0 ... VNC_ENCODING_COMPRESSLE=
VEL0 + 9:
> >>               vc->worker.tight.compression =3D (enc & 0x0F);
> >>               break;
> >> diff --git a/ui/vnc.h b/ui/vnc.h
> >> index d8b0070396..6e8fa66e9c 100644
> >> --- a/ui/vnc.h
> >> +++ b/ui/vnc.h
> >> @@ -422,6 +422,7 @@ enum {
> >>   #define VNC_ENCODING_DESKTOP_RESIZE_EXT   0XFFFFFECC /* -308 */
> >>   #define VNC_ENCODING_XVP                  0XFFFFFECB /* -309 */
> >>   #define VNC_ENCODING_ALPHA_CURSOR         0XFFFFFEC6 /* -314 */
> >> +#define VNC_ENCODING_CLIPBOARD_STATUS     0XFFFFFEC5 /* -315 */
> >>   #define VNC_ENCODING_WMVi                 0x574D5669
> >>   #define VNC_ENCODING_CLIPBOARD_EXT        0xc0a1e5ce
> >>
> >> @@ -466,6 +467,7 @@ enum VncFeatures {
> >>       VNC_FEATURE_LED_STATE,
> >>       VNC_FEATURE_XVP,
> >>       VNC_FEATURE_CLIPBOARD_EXT,
> >> +    VNC_FEATURE_CLIPBOARD_STATUS,
> >>       VNC_FEATURE_AUDIO,
> >>   };
> >>
> >> @@ -507,6 +509,7 @@ enum VncFeatures {
> >>
> >>   /* QEMU server -> client message IDs */
> >>   #define VNC_MSG_SERVER_QEMU_AUDIO                 1
> >> +#define VNC_MSG_SERVER_QEMU_CLIPBOARD_STATUS      2
> >>
> >>
> >>
> >> @@ -541,6 +544,10 @@ enum VncFeatures {
> >>   #define VNC_CLIPBOARD_NOTIFY   (1 << 27)
> >>   #define VNC_CLIPBOARD_PROVIDE  (1 << 28)
> >>
> >> +/* guest side clipboard peer status */
> >> +#define VNC_CLIPBOARD_PEER_ABSENT  0
> >> +#define VNC_CLIPBOARD_PEER_PRESENT 1
> >> +
> >>   VncDisplay *vnc_display_new(const char *id, Error **errp);
> >>   void vnc_display_free(VncDisplay *vd);
> >>
> >> @@ -637,6 +644,7 @@ void vnc_zrle_clear(VncWorker *worker);
> >>
> >>   /* vnc-clipboard.c */
> >>   void vnc_clipboard_peer_register(VncState *vs);
> >> +void vnc_clipboard_peer_status_send(VncState *vs, bool present);
> >>   void vnc_server_cut_text_caps(VncState *vs);
> >>   void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text);
> >>   void vnc_client_cut_text_ext(VncState *vs, int32_t len, uint32_t fla=
gs, uint8_t *data);
> >> --
> >> 2.43.0
> >>
> >>
>

