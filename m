Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6C2C5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJxD-0005VT-Le; Tue, 18 Aug 2026 09:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wwJxC-0005VJ-CA
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:34:10 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wwJxA-0000IU-9J
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:34:10 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-84e04df8c46so5108336b3a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:34:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787060047; cv=none;
 d=google.com; s=arc-20260327;
 b=oD6CfubUASv2aACBRt0T7u/Mdj/zrLoJ14zLWGqDUNDqZK7BvtQxcPCIc/Z4rwSJbS
 NNIE2OCwJp5Jw1g/M13feqIXgD0ZtWgcXtdgxzQG4Z38F9UwlbIbhdHK26pmavkAZTEy
 xLec19tQv2H3SXw+PoQS/rg+bxcccagQaSBhk0ZyuXIFbE/PO7MY6cv56BUnwm0hnyRb
 RFOfft8ewzJV7YN8cOPzLNJQclE1JQOmZgf7aErP1hgIqGyOrUZ7fJHobXv0mkRw75P7
 v+eX0sxF0SdH8atG0gnSRJQB6GvDvzCVd2Qu3AQMDhAv7GxWVTCF4RuEgNCc648eelnP
 +ztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Pt7778UMRQpYpSMexEqMgP/RDHcMyRhuwc2KVhnFAeQ=;
 fh=3Y4bGktH5ggMwpYRtZ21kBqAtp+bB/pZT/K2496c9g4=;
 b=cjDamjhel6I1K5RB8XiAvNw3XuCJBtGNYKr8MjesqX7WW2rtsAuIghCfJghkZujJtp
 Awtz2OJLcLWFBwyH/ufQvOmMrBjG8lPymYuqwtxq6QcRVeaPfk6I75AsRlZaH6WLmP3S
 hyQuVZFJdlVFWarFPMgZkwHOAFjLf1bWFjRwieFrTsPawU6xE+Lswxaur3ViBGNH/X/F
 1o15uBih2xL1I+65ruQyd3A1wZS/56WUg9f1XVQAkXTXu+ekfqAeiNtegXj/UC5FStpG
 MTXIyv2BIXWuq6eSMQuwe63xnGRxKJObBXGJqKte9wrFcwmHBoN6FGPdwEJW9DSHlEjj
 Va1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787060047; x=1787664847; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pt7778UMRQpYpSMexEqMgP/RDHcMyRhuwc2KVhnFAeQ=;
 b=DfogusKuQxDpqwYqSh0SP3yuwRIPnaL2uc7RWciLMs1MOFibWQ6e4sQ6bIMtK7krOj
 moGfySOM2Ewa209TCs/u4qokipsz3qG5MAcsPRLL05YYx2vZ4OHvjOBtO+cq4PA8DvIx
 tZBlRTz5WFFEm2pb2YMEHpG2dwemXjNPC4YChpPJ4M82BjO6y6iseItb7Q5e/DMritmy
 piSYzPrrtJj7rLOdcBrcsmmxJCcXX6LtFvQLyuaeEl38iMEsfI5r8YFebm2CDNbpps8R
 BB+nQj/xm+KMMilWNZymTIE6cjTWsNtaLlVCk+ccR8qVLNA85a6nwB6pQOBZM0ic/rzV
 U4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787060047; x=1787664847;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pt7778UMRQpYpSMexEqMgP/RDHcMyRhuwc2KVhnFAeQ=;
 b=nBim14yTmO+OXLx8VIhpsJMWfEcNMpaqUvdy/vx2K0UkqRlYPZxDGJlYI4bwUxYbQY
 069NCDGsVlXxNNc8xFD+4KxuHrKZUaQ9MlxHEPoOd5WwxiBOIcMiBd/j5uMLUXu8WrYR
 9Phxkgj7Hzpb3/teJ6MKJZToAgKbID6hU4QOtOt5QFrIEICzc8SR5sTFWF4g8VGFA8/i
 IYRQ84iVGFM5mju5sBCKiONKId6GKocDguDGLQ5bmqIGwyoueMeVxLlyONMqaJchr6oe
 n1DBjzKzbv/3otLna7lh0RFjfBGWypHnnLBdCckWmpkx5l42m295vX12b2y7XjTCM5jc
 WNNQ==
X-Gm-Message-State: AOJu0Yz3H7J/FWKSvS5gkMyiZPLvjn9L9vJ650zB7bAWGn36c5MueSYs
 HF8pFy6bd3WC3bi3vZtFbet4g59R7kXDBaJiaJNrj7O8AgpI8qsWCRqJe29e/E76dtc2H67HSWr
 GWw8oFYfvT7Bo85ojxj6j/DLoDAjXEYZDdM/vlF4=
X-Gm-Gg: AR+sD13qUwypHmTVXRzofUXQNq9qtIbNvlFQAduoKwIY9sGclQkzQfH/v9Sz1gNe32D
 uTBnk0KKweyaCyBX15uUFgPMRWHvpjUI2DUgyHLT911f9cO5Dz/YA4H7o/6VGxGI9axXfTgtoTk
 lPGDt0CSiVj2bqm/NImb9GenivgkTkpWdRaeQk3jcxasONQAHQioUwbZ+hM+tpUs+E/l6qiooQO
 Nf3BsGohJhbV9tjXgO6gF3AJDZ4fOHEMQENQrHk47MA/t0yZ4oWrF+/rCQU8kHQXy5zsZ5E9Ue2
 twr215LtNM3OlhBA9glUcbQOnwqZgneEDv8tdz/pGhZGvZGvUq+defMNpvG1+SJ1eVyCdr+6ahy
 J
X-Received: by 2002:a05:6a21:3384:b0:3c3:64cb:9b99 with SMTP id
 adf61e73a8af0-3cc719c78e4mr46409482637.6.1787060046431; Tue, 18 Aug 2026
 06:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260818121413.2660786-1-lucas.kornicki@nutanix.com>
 <20260818121413.2660786-5-lucas.kornicki@nutanix.com>
In-Reply-To: <20260818121413.2660786-5-lucas.kornicki@nutanix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 17:33:54 +0400
X-Gm-Features: AcwNN1V4Akh5t-8OiIHssrJi-yCbG8vUDZSABuSebarA-k5PbGfjGveDRPlUb5M
Message-ID: <CAJ+F1CKuDAzTz2iC+acOKf2j1vW3iFE6jinTKL=AwWCu3-1KGg@mail.gmail.com>
Subject: Re: [PATCH 4/4] ui/vnc: notify client of clipboard peer status
To: Lukasz Kornicki <lucas.kornicki@nutanix.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pf1-x42a.google.com
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

Hi Lukasz

On Tue, Aug 18, 2026 at 4:15=E2=80=AFPM Lukasz Kornicki
<lucas.kornicki@nutanix.com> wrote:
>
> Introduce a new vnc message (VNC_MSG_SERVER_QEMU_CLIPBOARD_STATUS) and
> the corresponding feature/encoding.
>
> When a client requests this feature, the server will inform the client
> whether a guest clipboard peer is present. The server will repeat the
> notification each time availability of a guest clipboard peer changes.
>
> This change enables the VNC client to determine if a guest side
> clipboard peer is available for clipboard exchange and react to
> changes of its availability.
>
> Until now the VNC clipboard peer was only registered when
> VNC_FEATURE_CLIPBOARD_EXT was enabled. With this change the VNC peer
> can be registered just for the purpose of receiving peer status
> updates. This requires introducing a VNC_FEATURE_CLIPBOARD_EXT guard
> before the QEMU_CLIPBOARD_UPDATE_INFO handler which previously only ran
> if VNC_FEATURE_CLIPBOARD_EXT was enabled.
>

The series looks good, but this extension is not documented afaict.
Can you make a PR for it?
https://github.com/rfbproto/rfbproto/blob/master/rfbproto.rst


> Change-Id: Id0897a24fae103288c399f73e808ed6c07018359

What is this? Is it a gerrit thing?

> Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
> ---
>  ui/trace-events    |  1 +
>  ui/vnc-clipboard.c | 31 ++++++++++++++++++++++++++++++-
>  ui/vnc.c           |  6 ++++++
>  ui/vnc.h           |  8 ++++++++
>  4 files changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/ui/trace-events b/ui/trace-events
> index 917d116d90..d2fe153b7d 100644
> --- a/ui/trace-events
> +++ b/ui/trace-events
> @@ -48,6 +48,7 @@ vnc_msg_server_ext_desktop_resize(void *state, void *io=
c, int width, int height,
>  vnc_msg_client_audio_enable(void *state, void *ioc) "VNC client msg audi=
o enable state=3D%p ioc=3D%p"
>  vnc_msg_client_audio_disable(void *state, void *ioc) "VNC client msg aud=
io disable state=3D%p ioc=3D%p"
>  vnc_msg_client_audio_format(void *state, void *ioc, int fmt, int channel=
s, int freq) "VNC client msg audio format state=3D%p ioc=3D%p fmt=3D%d chan=
nels=3D%d freq=3D%d"
> +vnc_clipboard_peer_status_send(void *state, bool present) "VNC server cl=
ipboard peer status state=3D%p present=3D%d"
>  vnc_msg_client_cut_text(void *state, void *ioc, int len) "VNC client msg=
 cut text state=3D%p ioc=3D%p len=3D%u"
>  vnc_msg_client_cut_text_ext(void *state, void *ioc, int len, int flags) =
"VNC client msg cut text state=3D%p ioc=3D%p len=3D%u flags=3D%u"
>  vnc_msg_client_ext_key_event(void *state, void *ioc, int down, int sym, =
int keycode) "VNC client msg ext key event state=3D%p ioc=3D%p down=3D%u sy=
m=3D%u keycode=3D%u"
> diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
> index 67f710f6ed..4ecc4489e4 100644
> --- a/ui/vnc-clipboard.c
> +++ b/ui/vnc-clipboard.c
> @@ -26,6 +26,7 @@
>  #include "qemu/error-report.h"
>  #include "vnc.h"
>  #include "vnc-jobs.h"
> +#include "trace.h"
>
>  static uint8_t *inflate_buffer(uint8_t *in, uint32_t in_len, uint32_t *s=
ize)
>  {
> @@ -224,6 +225,23 @@ static void vnc_clipboard_update_info(VncState *vs, =
QemuClipboardInfo *info)
>      }
>  }
>
> +void vnc_clipboard_peer_status_send(VncState *vs, bool present)
> +{
> +    if (!vnc_has_feature(vs, VNC_FEATURE_CLIPBOARD_STATUS)) {
> +        return;
> +    }
> +
> +    trace_vnc_clipboard_peer_status_send(vs, present);
> +
> +    vnc_lock_output(vs);
> +    vnc_write_u8(vs, VNC_MSG_SERVER_QEMU);
> +    vnc_write_u8(vs, VNC_MSG_SERVER_QEMU_CLIPBOARD_STATUS);
> +    vnc_write_u16(vs, present ? VNC_CLIPBOARD_PEER_PRESENT
> +                              : VNC_CLIPBOARD_PEER_ABSENT);
> +    vnc_unlock_output(vs);
> +    vnc_flush(vs);
> +}
> +
>  static void vnc_clipboard_notify(Notifier *notifier, void *data)
>  {
>      VncState *vs =3D container_of(notifier, VncState, cbpeer.notifier);
> @@ -231,13 +249,24 @@ static void vnc_clipboard_notify(Notifier *notifier=
, void *data)
>
>      switch (notify->type) {
>      case QEMU_CLIPBOARD_UPDATE_INFO:
> +        /* ignore the update if client does not want ext messages */
> +        if (!vnc_has_feature(vs, VNC_FEATURE_CLIPBOARD_EXT)) {
> +            return;
> +        }
> +
>          vnc_clipboard_update_info(vs, notify->info);
>          return;
>      case QEMU_CLIPBOARD_RESET_SERIAL:
>          /* ignore */
>          return;
>      case QEMU_CLIPBOARD_PEER_UPDATE:
> -        /* ignore */
> +        /* only guest side peers affect the status we relay to the clien=
t */
> +        if (!notify->peer_update.peer->guest) {
> +            return;
> +        }
> +
> +        vnc_clipboard_peer_status_send(vs,
> +            qemu_clipboard_guest_peer_present());
>          return;
>      }
>  }
> diff --git a/ui/vnc.c b/ui/vnc.c
> index 656768f9c9..9e44a20311 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -2191,6 +2191,12 @@ static void set_encodings(VncState *vs, int32_t *e=
ncodings, size_t n_encodings)
>              vnc_set_feature(vs, VNC_FEATURE_CLIPBOARD_EXT);
>              vnc_server_cut_text_caps(vs);
>              break;
> +        case VNC_ENCODING_CLIPBOARD_STATUS:
> +            vnc_set_feature(vs, VNC_FEATURE_CLIPBOARD_STATUS);
> +            vnc_clipboard_peer_register(vs);
> +            vnc_clipboard_peer_status_send(vs,
> +                qemu_clipboard_guest_peer_present());
> +            break;
>          case VNC_ENCODING_COMPRESSLEVEL0 ... VNC_ENCODING_COMPRESSLEVEL0=
 + 9:
>              vc->worker.tight.compression =3D (enc & 0x0F);
>              break;
> diff --git a/ui/vnc.h b/ui/vnc.h
> index d8b0070396..6e8fa66e9c 100644
> --- a/ui/vnc.h
> +++ b/ui/vnc.h
> @@ -422,6 +422,7 @@ enum {
>  #define VNC_ENCODING_DESKTOP_RESIZE_EXT   0XFFFFFECC /* -308 */
>  #define VNC_ENCODING_XVP                  0XFFFFFECB /* -309 */
>  #define VNC_ENCODING_ALPHA_CURSOR         0XFFFFFEC6 /* -314 */
> +#define VNC_ENCODING_CLIPBOARD_STATUS     0XFFFFFEC5 /* -315 */
>  #define VNC_ENCODING_WMVi                 0x574D5669
>  #define VNC_ENCODING_CLIPBOARD_EXT        0xc0a1e5ce
>
> @@ -466,6 +467,7 @@ enum VncFeatures {
>      VNC_FEATURE_LED_STATE,
>      VNC_FEATURE_XVP,
>      VNC_FEATURE_CLIPBOARD_EXT,
> +    VNC_FEATURE_CLIPBOARD_STATUS,
>      VNC_FEATURE_AUDIO,
>  };
>
> @@ -507,6 +509,7 @@ enum VncFeatures {
>
>  /* QEMU server -> client message IDs */
>  #define VNC_MSG_SERVER_QEMU_AUDIO                 1
> +#define VNC_MSG_SERVER_QEMU_CLIPBOARD_STATUS      2
>
>
>
> @@ -541,6 +544,10 @@ enum VncFeatures {
>  #define VNC_CLIPBOARD_NOTIFY   (1 << 27)
>  #define VNC_CLIPBOARD_PROVIDE  (1 << 28)
>
> +/* guest side clipboard peer status */
> +#define VNC_CLIPBOARD_PEER_ABSENT  0
> +#define VNC_CLIPBOARD_PEER_PRESENT 1
> +
>  VncDisplay *vnc_display_new(const char *id, Error **errp);
>  void vnc_display_free(VncDisplay *vd);
>
> @@ -637,6 +644,7 @@ void vnc_zrle_clear(VncWorker *worker);
>
>  /* vnc-clipboard.c */
>  void vnc_clipboard_peer_register(VncState *vs);
> +void vnc_clipboard_peer_status_send(VncState *vs, bool present);
>  void vnc_server_cut_text_caps(VncState *vs);
>  void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text);
>  void vnc_client_cut_text_ext(VncState *vs, int32_t len, uint32_t flags, =
uint8_t *data);
> --
> 2.43.0
>
>

