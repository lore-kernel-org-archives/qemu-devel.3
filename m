Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2218210ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 12:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w66Cn-0006to-Rj; Fri, 27 Mar 2026 08:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.ferst@gmail.com>)
 id 1w66Cm-0006tD-30
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 08:22:24 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matheus.ferst@gmail.com>)
 id 1w66Cj-0001rT-Nw
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 08:22:23 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2b0c30b517aso7154455ad.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 05:22:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774614139; cv=none;
 d=google.com; s=arc-20240605;
 b=EXnGfYuS4q8/lOvPqgrK0UzuFXbPw3KRkBnf1SbwDiLHjrnjEbloOVxh103vCryslb
 p47qQ7LyQ9ceEcrRXEqu5FzmkU5skNP72ZJeDOzacuyD/Ol4OWpPhtaIJuEOtaP+nbrZ
 egft9gCfgng3MpxZd1+R9xQEcnl+4t+PkkXGPLjrcz+nIgw+OHP3gtsJ2XiG0DgZOoqZ
 wbUMHFpOYtHkcWsnQm0hResCo+zHBFk4fP8NweXZTkzpvDNP4+8Cpux4K5Jc5M3oDKdS
 p0iMSSdgp+Waa72vPo8gEVfkY7z0cZye+UNd4rruEkHARJnICHbOGN6n6G5hW0HogGFF
 SJyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1reeSW271sS8RXp26F+ENL3p25eTYNB8+5dq0YAcjF8=;
 fh=1EIbEtoFFzgNE8bRYYvCWw1gN63zQFJWyRStO58GpTE=;
 b=dT640Am1O4ujzuP5qaN1YMCm3zp2RFeq5bWOACGbNpSn/kFfN1HJLi6qQWGxZ3JnuE
 VqOGar5eBqgCejNlnS4z3uR673kOYauada3BEIKAzgnRFynyYA0eZFa//8duFqdKZNEF
 IaCmO3mdZk2BPUQlLS7/lnTRFxfkBg9K5OuY6p1DySsfu9rkSwOmylJeC2AoF4I5WOaK
 tWlnVkiFOpPkz4EWEelIdnEGQEZcCuM4DxUriY21Tg+4jBMDIxSJ4DjjKujZo0tKt6w2
 xbpek4QTeXaCHnZ8CPgiQqdgGO5r1rj0JiP1gb67nC3ZDdkei4nU6TRimOKV+mVNfYAX
 dsXw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774614139; x=1775218939; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1reeSW271sS8RXp26F+ENL3p25eTYNB8+5dq0YAcjF8=;
 b=h0Xo5O9JM6g1rigL7dD/oTV5AtbrqFpbg3mvbjdXVyylh2V7nSkuTz+4HhSphT8n7I
 CcXQDkAXb3owdl0E3aUon57RHDF7zl38kklKBA5sYOUZjmzSyrIQwVJMHxqPpayPAY3A
 gZQ0U2YRFtuqcJSNwMReb2A8jzcysNM+GOyYrWARl8FSqnGDJb9wK8r+JWfHkA3AVXYv
 al8C08VXawbbX15aMkP744qyUw8UzzGNpNzr4mVwfWMJ4od9yCDznM1eCAY3aMtbcGt4
 WlIrxDZHwv98H8yP4Ucmdkx1d5e6oMSP28d/4hjFcS2EuIs39d5LTREy+wISgJnkyhha
 /OtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774614139; x=1775218939;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1reeSW271sS8RXp26F+ENL3p25eTYNB8+5dq0YAcjF8=;
 b=G6PgA1FlsOkX1hBQJysbq+l5UM+3cpSHi0aYqmJVETxx10zdgIm7J2gc1Z5J83H89o
 mPEDsuHUiV7F5lGfNpWta2PmkKeFBJdsC6fYQDfx49sljW0l/HgOnZsFDPsXAGm3mrHU
 UfIg26HmN7iqsZg+C18bryE+G/6rlC+M1tMI9TVtXYA8VzEEK39OM83X5DLrFcxXeaqV
 xUCLVgiJPZvJ0sqzLSv9TSbQoqleA12anDEVF5fzIdewshekSrrIeg64avZgy3IoIKpf
 W9ihRVW3mcegWBLymusB/psh5+pcmslcxU91AmUn9DxjCkykz+Og/GPRNFKmepY0+HsF
 f/3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFESVx5Ouo3D1Soh3xUHdyDKEVG7G0t+49aYYBNfYndFWs6HwSBDVhdTTdb6fILghhIpiydInt/1Dt@nongnu.org
X-Gm-Message-State: AOJu0Yy6PW1nSmBGY3lORqv5UfjQZDDOKcoG7P7debrIVItQ7knm/0y6
 3HhHkWvm/2NdSJ4WmjwUD2y2It/RmfPMXmZduPqr+vs4WfYUYdPcrq+2hNhJwH8an+gbq2gaWd2
 jmTtd/nu0vfL5eddhPYQtUpOUQXoZndI=
X-Gm-Gg: ATEYQzym8l8vK0pVXTEZrjzEwfqwQnnWaTo96ITbOEL5iwScfjiokljAoKhd96pmjDE
 1bo0BnCklmtHL/GNOIKQvrSm44gP79+61phNJv1h2g0vdLy196s5IfZLPap8BgKig29ZJfKPjVi
 7D0WzTR1YAyjGsucoFZUA+xT2Zj54zRCUvIxRbJtfh4HVJYZze3mKneEon0X9QDFdwQ77qWItYi
 Qc1rAxqYt3OPIAMNO2198Bevxp4TaJdyswDf63JkH8Ps2X9ivvhO7SD6rr8Bneg3TqbDcM4psZl
 v4Lt1pmgakuydX+9NHhlBe2ygFICxHRzgEIwpwdg
X-Received: by 2002:a17:902:d541:b0:2ae:4cb8:484a with SMTP id
 d9443c01a7336-2b0cdcaa6d7mr26980745ad.17.1774614139271; Fri, 27 Mar 2026
 05:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260313194849.859579-1-matheus.ferst@eldorado.org.br>
In-Reply-To: <20260313194849.859579-1-matheus.ferst@eldorado.org.br>
From: "Matheus K. Ferst" <matheus.ferst@gmail.com>
Date: Fri, 27 Mar 2026 09:22:07 -0300
X-Gm-Features: AQROBzAcxgo-sEA_GTBpj1hp6gYJA2owEX7QBkAxgsXzIbM1Q8faUL5ioPytQno
Message-ID: <CAOrDodHP9wmqk9ZG48vDfGW_e2WqYWbBQRFL+cEzLP4cJ82MVw@mail.gmail.com>
Subject: Re: [RFC PATCH] net/tap-win32.c: fix segmentation faults when
 multiple -netdev tap are used
To: Matheus Ferst <matheus.ferst@eldorado.org.br>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, sw@weilnetz.de
Content-Type: multipart/alternative; boundary="000000000000627d69064e008d63"
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=matheus.ferst@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000627d69064e008d63
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping

Em sex., 13 de mar. de 2026 =C3=A0s 17:19, Matheus Ferst via qemu developme=
nt <
qemu-devel@nongnu.org> escreveu:

> The static declaration of tap_overlapped does not work when multiple
> "-netdev tap" are used, tap_win32_overlapped_init will be called with
> the same struct but a different handler, and the already running thread
> with tap_win32_thread_entry will have the semaphores and free lists
> changed under its feet.
>
> Make tap_win32_overlapped_t a member of TAPState to be allocated with
> qemu_new_net_client, and move out the tap_win32_overlapped_init and
> CreateThread calls from tap_win32_open to tap_win32_init.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3314
> Signed-off-by: Matheus Ferst <matheus.ferst@eldorado.org.br>
> ---
> I'm no longer seeing the segfaults with this patch, but I only have
> connectivity when using the e1000 or virtio-net-pci devices. With
> virtio-net-device (as shown in the issue with aarch64) I cannot ping
> anything when two interfaces are used. I'm not sure if it's a problem
> with this patch or a different problem, since it works with the other
> devices.
> ---
>  net/tap-win32.c | 47 +++++++++++++++++++++--------------------------
>  1 file changed, 21 insertions(+), 26 deletions(-)
>
> diff --git a/net/tap-win32.c b/net/tap-win32.c
> index 38baf90e0b..af20c62868 100644
> --- a/net/tap-win32.c
> +++ b/net/tap-win32.c
> @@ -114,8 +114,6 @@ typedef struct tap_win32_overlapped {
>      tun_buffer_t* output_queue_back;
>  } tap_win32_overlapped_t;
>
> -static tap_win32_overlapped_t tap_overlapped;
> -
>  static tun_buffer_t* get_buffer_from_free_list(tap_win32_overlapped_t*
> const overlapped)
>  {
>      tun_buffer_t* buffer =3D NULL;
> @@ -589,8 +587,7 @@ static void
> tap_win32_free_buffer(tap_win32_overlapped_t *overlapped,
>      put_buffer_on_free_list(overlapped, buffer);
>  }
>
> -static int tap_win32_open(tap_win32_overlapped_t **phandle,
> -                          const char *preferred_name)
> +static HANDLE tap_win32_open(const char *preferred_name)
>  {
>      g_autofree char *device_path =3D NULL;
>      char device_guid[0x100];
> @@ -604,7 +601,6 @@ static int tap_win32_open(tap_win32_overlapped_t
> **phandle,
>          unsigned long debug;
>      } version;
>      DWORD version_len;
> -    DWORD idThread;
>
>      if (preferred_name !=3D NULL) {
>          snprintf(name_buffer, sizeof(name_buffer), "%s", preferred_name)=
;
> @@ -612,7 +608,7 @@ static int tap_win32_open(tap_win32_overlapped_t
> **phandle,
>
>      rc =3D get_device_guid(device_guid, sizeof(device_guid), name_buffer=
,
> sizeof(name_buffer));
>      if (rc)
> -        return -1;
> +        return INVALID_HANDLE_VALUE;
>
>      device_path =3D g_strdup_printf("%s%s%s",
>                USERMODEDEVICEDIR,
> @@ -629,7 +625,7 @@ static int tap_win32_open(tap_win32_overlapped_t
> **phandle,
>          0 );
>
>      if (handle =3D=3D INVALID_HANDLE_VALUE) {
> -        return -1;
> +        return INVALID_HANDLE_VALUE;
>      }
>
>      bret =3D DeviceIoControl(handle, TAP_IOCTL_GET_VERSION,
> @@ -638,34 +634,28 @@ static int tap_win32_open(tap_win32_overlapped_t
> **phandle,
>
>      if (bret =3D=3D FALSE) {
>          CloseHandle(handle);
> -        return -1;
> +        return INVALID_HANDLE_VALUE;
>      }
>
>      if (!tap_win32_set_status(handle, TRUE)) {
> -        return -1;
> +        return INVALID_HANDLE_VALUE;
>      }
>
> -    tap_win32_overlapped_init(&tap_overlapped, handle);
> -
> -    *phandle =3D &tap_overlapped;
> -
> -    CreateThread(NULL, 0, tap_win32_thread_entry,
> -                 (LPVOID)&tap_overlapped, 0, &idThread);
> -    return 0;
> +    return handle;
>  }
>
>  /********************************************/
>
>   typedef struct TAPState {
>       NetClientState nc;
> -     tap_win32_overlapped_t *handle;
> +     tap_win32_overlapped_t tap_overlapped;
>   } TAPState;
>
>  static void tap_cleanup(NetClientState *nc)
>  {
>      TAPState *s =3D DO_UPCAST(TAPState, nc, nc);
>
> -    qemu_del_wait_object(s->handle->tap_semaphore, NULL, NULL);
> +    qemu_del_wait_object(s->tap_overlapped.tap_semaphore, NULL, NULL);
>
>      /* FIXME: need to kill thread and close file handle:
>         tap_win32_close(s);
> @@ -676,7 +666,7 @@ static ssize_t tap_receive(NetClientState *nc, const
> uint8_t *buf, size_t size)
>  {
>      TAPState *s =3D DO_UPCAST(TAPState, nc, nc);
>
> -    return tap_win32_write(s->handle, buf, size);
> +    return tap_win32_write(&s->tap_overlapped, buf, size);
>  }
>
>  static void tap_win32_send(void *opaque)
> @@ -688,7 +678,7 @@ static void tap_win32_send(void *opaque)
>      uint8_t min_pkt[ETH_ZLEN];
>      size_t min_pktsz =3D sizeof(min_pkt);
>
> -    size =3D tap_win32_read(s->handle, &buf, max_size);
> +    size =3D tap_win32_read(&s->tap_overlapped, &buf, max_size);
>      if (size > 0) {
>          orig_buf =3D buf;
>
> @@ -700,7 +690,7 @@ static void tap_win32_send(void *opaque)
>          }
>
>          qemu_send_packet(&s->nc, buf, size);
> -        tap_win32_free_buffer(s->handle, orig_buf);
> +        tap_win32_free_buffer(&s->tap_overlapped, orig_buf);
>      }
>  }
>
> @@ -716,9 +706,11 @@ static int tap_win32_init(NetClientState *peer, cons=
t
> char *model,
>  {
>      NetClientState *nc;
>      TAPState *s;
> -    tap_win32_overlapped_t *handle;
> +    HANDLE handle;
> +    DWORD idThread;
>
> -    if (tap_win32_open(&handle, ifname) < 0) {
> +    handle =3D tap_win32_open(ifname);
> +    if (handle =3D=3D INVALID_HANDLE_VALUE) {
>          printf("tap: Could not open '%s'\n", ifname);
>          return -1;
>      }
> @@ -727,11 +719,14 @@ static int tap_win32_init(NetClientState *peer,
> const char *model,
>
>      s =3D DO_UPCAST(TAPState, nc, nc);
>
> +    tap_win32_overlapped_init(&s->tap_overlapped, handle);
> +
> +    CreateThread(NULL, 0, tap_win32_thread_entry,
> +                 (LPVOID)&s->tap_overlapped, 0, &idThread);
> +
>      qemu_set_info_str(&s->nc, "tap: ifname=3D%s", ifname);
>
> -    s->handle =3D handle;
> -
> -    qemu_add_wait_object(s->handle->tap_semaphore, tap_win32_send, s);
> +    qemu_add_wait_object(s->tap_overlapped.tap_semaphore, tap_win32_send=
,
> s);
>
>      return 0;
>  }
> --
> 2.43.0
>
>
>

--000000000000627d69064e008d63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>ping</div><br><div class=3D"gmail_quote gmail_quote_c=
ontainer"><div dir=3D"ltr" class=3D"gmail_attr">Em sex., 13 de mar. de 2026=
 =C3=A0s 17:19, Matheus Ferst via qemu development &lt;<a href=3D"mailto:qe=
mu-devel@nongnu.org">qemu-devel@nongnu.org</a>&gt; escreveu:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">The static declaration of tap_=
overlapped does not work when multiple<br>
&quot;-netdev tap&quot; are used, tap_win32_overlapped_init will be called =
with<br>
the same struct but a different handler, and the already running thread<br>
with tap_win32_thread_entry will have the semaphores and free lists<br>
changed under its feet.<br>
<br>
Make tap_win32_overlapped_t a member of TAPState to be allocated with<br>
qemu_new_net_client, and move out the tap_win32_overlapped_init and<br>
CreateThread calls from tap_win32_open to tap_win32_init.<br>
<br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/3314" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/3314</a><br>
Signed-off-by: Matheus Ferst &lt;<a href=3D"mailto:matheus.ferst@eldorado.o=
rg.br" target=3D"_blank">matheus.ferst@eldorado.org.br</a>&gt;<br>
---<br>
I&#39;m no longer seeing the segfaults with this patch, but I only have<br>
connectivity when using the e1000 or virtio-net-pci devices. With<br>
virtio-net-device (as shown in the issue with aarch64) I cannot ping<br>
anything when two interfaces are used. I&#39;m not sure if it&#39;s a probl=
em<br>
with this patch or a different problem, since it works with the other<br>
devices.<br>
---<br>
=C2=A0net/tap-win32.c | 47 +++++++++++++++++++++--------------------------<=
br>
=C2=A01 file changed, 21 insertions(+), 26 deletions(-)<br>
<br>
diff --git a/net/tap-win32.c b/net/tap-win32.c<br>
index 38baf90e0b..af20c62868 100644<br>
--- a/net/tap-win32.c<br>
+++ b/net/tap-win32.c<br>
@@ -114,8 +114,6 @@ typedef struct tap_win32_overlapped {<br>
=C2=A0 =C2=A0 =C2=A0tun_buffer_t* output_queue_back;<br>
=C2=A0} tap_win32_overlapped_t;<br>
<br>
-static tap_win32_overlapped_t tap_overlapped;<br>
-<br>
=C2=A0static tun_buffer_t* get_buffer_from_free_list(tap_win32_overlapped_t=
* const overlapped)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0tun_buffer_t* buffer =3D NULL;<br>
@@ -589,8 +587,7 @@ static void tap_win32_free_buffer(tap_win32_overlapped_=
t *overlapped,<br>
=C2=A0 =C2=A0 =C2=A0put_buffer_on_free_list(overlapped, buffer);<br>
=C2=A0}<br>
<br>
-static int tap_win32_open(tap_win32_overlapped_t **phandle,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 const char *preferred_name)<br>
+static HANDLE tap_win32_open(const char *preferred_name)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0g_autofree char *device_path =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0char device_guid[0x100];<br>
@@ -604,7 +601,6 @@ static int tap_win32_open(tap_win32_overlapped_t **phan=
dle,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long debug;<br>
=C2=A0 =C2=A0 =C2=A0} version;<br>
=C2=A0 =C2=A0 =C2=A0DWORD version_len;<br>
-=C2=A0 =C2=A0 DWORD idThread;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (preferred_name !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(name_buffer, sizeof(name_buffer)=
, &quot;%s&quot;, preferred_name);<br>
@@ -612,7 +608,7 @@ static int tap_win32_open(tap_win32_overlapped_t **phan=
dle,<br>
<br>
=C2=A0 =C2=A0 =C2=A0rc =3D get_device_guid(device_guid, sizeof(device_guid)=
, name_buffer, sizeof(name_buffer));<br>
=C2=A0 =C2=A0 =C2=A0if (rc)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return INVALID_HANDLE_VALUE;<br>
<br>
=C2=A0 =C2=A0 =C2=A0device_path =3D g_strdup_printf(&quot;%s%s%s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0USERMODEDEVICEDIR,<b=
r>
@@ -629,7 +625,7 @@ static int tap_win32_open(tap_win32_overlapped_t **phan=
dle,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 );<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (handle =3D=3D INVALID_HANDLE_VALUE) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return INVALID_HANDLE_VALUE;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0bret =3D DeviceIoControl(handle, TAP_IOCTL_GET_VERSION,=
<br>
@@ -638,34 +634,28 @@ static int tap_win32_open(tap_win32_overlapped_t **ph=
andle,<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (bret =3D=3D FALSE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CloseHandle(handle);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return INVALID_HANDLE_VALUE;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!tap_win32_set_status(handle, TRUE)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return INVALID_HANDLE_VALUE;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 tap_win32_overlapped_init(&amp;tap_overlapped, handle);<br>
-<br>
-=C2=A0 =C2=A0 *phandle =3D &amp;tap_overlapped;<br>
-<br>
-=C2=A0 =C2=A0 CreateThread(NULL, 0, tap_win32_thread_entry,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(LPVOID)&amp=
;tap_overlapped, 0, &amp;idThread);<br>
-=C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 return handle;<br>
=C2=A0}<br>
<br>
=C2=A0/********************************************/<br>
<br>
=C2=A0 typedef struct TAPState {<br>
=C2=A0 =C2=A0 =C2=A0 NetClientState nc;<br>
-=C2=A0 =C2=A0 =C2=A0tap_win32_overlapped_t *handle;<br>
+=C2=A0 =C2=A0 =C2=A0tap_win32_overlapped_t tap_overlapped;<br>
=C2=A0 } TAPState;<br>
<br>
=C2=A0static void tap_cleanup(NetClientState *nc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TAPState *s =3D DO_UPCAST(TAPState, nc, nc);<br>
<br>
-=C2=A0 =C2=A0 qemu_del_wait_object(s-&gt;handle-&gt;tap_semaphore, NULL, N=
ULL);<br>
+=C2=A0 =C2=A0 qemu_del_wait_object(s-&gt;tap_overlapped.tap_semaphore, NUL=
L, NULL);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* FIXME: need to kill thread and close file handle:<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tap_win32_close(s);<br>
@@ -676,7 +666,7 @@ static ssize_t tap_receive(NetClientState *nc, const ui=
nt8_t *buf, size_t size)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0TAPState *s =3D DO_UPCAST(TAPState, nc, nc);<br>
<br>
-=C2=A0 =C2=A0 return tap_win32_write(s-&gt;handle, buf, size);<br>
+=C2=A0 =C2=A0 return tap_win32_write(&amp;s-&gt;tap_overlapped, buf, size)=
;<br>
=C2=A0}<br>
<br>
=C2=A0static void tap_win32_send(void *opaque)<br>
@@ -688,7 +678,7 @@ static void tap_win32_send(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0uint8_t min_pkt[ETH_ZLEN];<br>
=C2=A0 =C2=A0 =C2=A0size_t min_pktsz =3D sizeof(min_pkt);<br>
<br>
-=C2=A0 =C2=A0 size =3D tap_win32_read(s-&gt;handle, &amp;buf, max_size);<b=
r>
+=C2=A0 =C2=A0 size =3D tap_win32_read(&amp;s-&gt;tap_overlapped, &amp;buf,=
 max_size);<br>
=C2=A0 =C2=A0 =C2=A0if (size &gt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0orig_buf =3D buf;<br>
<br>
@@ -700,7 +690,7 @@ static void tap_win32_send(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_send_packet(&amp;s-&gt;nc, buf, size=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tap_win32_free_buffer(s-&gt;handle, orig_buf);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tap_win32_free_buffer(&amp;s-&gt;tap_overlappe=
d, orig_buf);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -716,9 +706,11 @@ static int tap_win32_init(NetClientState *peer, const =
char *model,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0NetClientState *nc;<br>
=C2=A0 =C2=A0 =C2=A0TAPState *s;<br>
-=C2=A0 =C2=A0 tap_win32_overlapped_t *handle;<br>
+=C2=A0 =C2=A0 HANDLE handle;<br>
+=C2=A0 =C2=A0 DWORD idThread;<br>
<br>
-=C2=A0 =C2=A0 if (tap_win32_open(&amp;handle, ifname) &lt; 0) {<br>
+=C2=A0 =C2=A0 handle =3D tap_win32_open(ifname);<br>
+=C2=A0 =C2=A0 if (handle =3D=3D INVALID_HANDLE_VALUE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;tap: Could not open &#39;%s&=
#39;\n&quot;, ifname);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -727,11 +719,14 @@ static int tap_win32_init(NetClientState *peer, const=
 char *model,<br>
<br>
=C2=A0 =C2=A0 =C2=A0s =3D DO_UPCAST(TAPState, nc, nc);<br>
<br>
+=C2=A0 =C2=A0 tap_win32_overlapped_init(&amp;s-&gt;tap_overlapped, handle)=
;<br>
+<br>
+=C2=A0 =C2=A0 CreateThread(NULL, 0, tap_win32_thread_entry,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(LPVOID)&amp=
;s-&gt;tap_overlapped, 0, &amp;idThread);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0qemu_set_info_str(&amp;s-&gt;nc, &quot;tap: ifname=3D%s=
&quot;, ifname);<br>
<br>
-=C2=A0 =C2=A0 s-&gt;handle =3D handle;<br>
-<br>
-=C2=A0 =C2=A0 qemu_add_wait_object(s-&gt;handle-&gt;tap_semaphore, tap_win=
32_send, s);<br>
+=C2=A0 =C2=A0 qemu_add_wait_object(s-&gt;tap_overlapped.tap_semaphore, tap=
_win32_send, s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
-- <br>
2.43.0<br>
<br>
<br>
</blockquote></div></div>

--000000000000627d69064e008d63--

