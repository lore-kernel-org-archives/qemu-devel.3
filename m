Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587F1EF99F3
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 02:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr5fp-0006S6-3h; Fri, 13 Feb 2026 21:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vr5fm-0006Rs-Uu
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:46:18 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vr5fk-0006Yb-QD
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:46:18 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so240538466b.0
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 18:46:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771037175; cv=none;
 d=google.com; s=arc-20240605;
 b=W8t3/a3xtJYvf3+fhcaBdr6eIBANi1R4Kv5+Ht8EswZizXt1ZVW7OvhqHzB16wnpNb
 S+C9gmfRedlGVsa44FtcITCRaM92dnlbZS94swOJ3Riex3ps1IV9SkEFhRlU75dcSfJl
 7hI6nMT6+YAH4b4Ri1Sb+5t3dtt0CZcvNuhalpQDjsc+W/Dlz+/NHG07PVHLNx2IitiL
 IjrSlf3TeCBXDERnxvgXGH7Hp9aoB4Ia3Z3140oh8zqYMJXQaA5rVN6/kpZNdEVtjTmG
 X/v3UBwaLcGg+KRLr2fi4VJENx0GjH6R1/075Z2vzXCJxDTZY9vN/5C0DoM6/1o69sDw
 o1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gXw+9a1MtYw9rjC+ZAPDkltnLFijPKyk1wJ/vWEeMLQ=;
 fh=nbpNME/n1szgj2GMR3pTCKsMXVqEHJV9X2rsEb3nItU=;
 b=ZLVE650W3LimJwSCE1ajruXE8n7RkcjbzRWE6NYL2hH5kubmwqvHLITx4NY4dINL9Z
 7/D4QZCesj7lRVIAs9zuVohbZHGA/k6boQHZzGfR/MduPnhILBr/fDzqxpdjLBexbJ2V
 /2Y3kaHglJIVqWLF8odjS7G9Dvjiy27g7tb5JGIunTuPSm7LpHfbKOoBL/KQ/alQa7YA
 TCwlD2kq7Kx9WCrgK91Qj/czXwmNX+ne9CUfE1r9Qr/iI6NjfzVp6j9SzwkUMriAgwZ/
 zXfWqvkq6iV2P3dYRstR20uBXBJw2fkMKSBS57O2hMTKiMqaEcJbj5AVID5Z1S2qenzV
 nOqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771037175; x=1771641975; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXw+9a1MtYw9rjC+ZAPDkltnLFijPKyk1wJ/vWEeMLQ=;
 b=TTcKoEooJ3+gcXG7PzFTbW6RCxdoyRDTSaFDbFNEGLTd7cl1iSltMNhTZ6vOS/1i3P
 2zEndvwghjorkG9yynfsdZhHxEYM9lu/jWc+Ih7v+4tYDIPU3Mehw5HDJ8rT3Qkp9tCV
 s5JLE8l574por6sNpLaRDvTm1GcrCBkitNWCm0q/pLDCCrlLMcWs5Q7UyIc7sLaAHsiS
 9ic6W0ISGzjT0LZ6eb/LtUDJT5b+Y+eTQ6Y7zY5F4tE4oHZ0TdBfWu/Y/yvIB8o6GQfq
 3+RUM9CXcMnBeMENZy8AeLyvc0XV5syphV8A9tnO1ePJProjpWmY9Roi3G+aiEe5c9Fs
 MLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771037175; x=1771641975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gXw+9a1MtYw9rjC+ZAPDkltnLFijPKyk1wJ/vWEeMLQ=;
 b=r3EeY5l3gsUBXTwFSyDc0o7PXygi2wuHiPydTCyEIj8gjk+eE4JPW6S13NaNQm7pnb
 Ii95g6KDuKzDOD0PYJ+3hMIjS6INF/cXWw4hV54ttZikTIOq3IUmNU9IAQzODsthTw/o
 f6gowLL7yf3uyft3nalom0BV8eZuajZ6xQtDVbt34UtWejlZgGqDgAKwhUzm+N0rS2H5
 /8Rsj7v4NrJDxFWzqanDfdNNB75KrQQSqX5YF47+UEXZA5TGXgkOrXT6ecUo1Johup5b
 XOdgUhJRVM0RSRg+iPvpqnC70ACTzJdk80VqlpjZV7Ml+u+5mCcZIEeaoSOzZZdiyW1V
 2S+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPglJMp9Kq1uPePKhkiEeORSVQW//ws69TdmCOaVa5F+9xIVu6nVm5lh1bjHWPG/9+ihx/MwZHw0/i@nongnu.org
X-Gm-Message-State: AOJu0YymxTly/zXsY6IQKpz61JiCBi/RDkmJTNQaYB/G4k6XFiSIEPEl
 dJ4W2c3M8QLODiQf/BvO9VTy/h814IyKvr0J9qbGU8cmbshCcDNMSCFEAEO/ylXv0JDZS5LJajn
 NyUgIj+fJ47Hb5qVSiQMbfuFVZWw+JT0=
X-Gm-Gg: AZuq6aKX3v5kC2ggNWhSrW+d6Rbr8KpVGETYnC5pAtk1mU2t6ko7sUn5TY1stkuG4oa
 XpaBA03WjL8UkSmEnRZ/5pBQJe5Pda4W6G1sq/M4CIWpQD9+MU0kzGXWdFQd5TRu8eFOZKTaKB5
 Q7WgIxeND4LEg8hZxx+z+6yL7JG3l+con+Wts6ybvPcVcssE4Mifgcx8/eDHQ3uJcbVBxREz9eF
 BeUpc9IenGVX7F0LuAQd95hV4z5U9oa8WnNTUlEpXul5my1KxZP3AA98KPpezkqAnFTLmm8h7EF
 Rbp9BGn4
X-Received: by 2002:a17:907:1c2a:b0:b8a:f2cb:8088 with SMTP id
 a640c23a62f3a-b8fc3c46515mr69301066b.33.1771037174843; Fri, 13 Feb 2026
 18:46:14 -0800 (PST)
MIME-Version: 1.0
References: <20260207134728.1495932-1-lulu@redhat.com>
 <20260207134728.1495932-2-lulu@redhat.com>
In-Reply-To: <20260207134728.1495932-2-lulu@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sat, 14 Feb 2026 10:45:38 +0800
X-Gm-Features: AZwV_Qj2JWpXTYh-0ldLXA9_Ae3Ii5YgOiEC3wWJrAdn2ny8TKPN4Z7PjOKJ2lQ
Message-ID: <CAK3tnvKxsumtqbF6z6_3v5jWWwAeUg4sdYsXNY9Jha9tXYR6ag@mail.gmail.com>
Subject: Re: [PATCH 02/12] net/filter-mirror: add enable_when_stopped option
 for filter-redirector
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, lizhijian@fujitsu.com, 
 qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x633.google.com
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

On Sat, Feb 7, 2026 at 9:47=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> From: Jason Wang <jasowang@redhat.com>
>
> Add a QAPI option 'enable_when_stopped' for filter-redirector that
> allows it to continue receiving data from netdev when VM is stopped.
>
> When enabled, a VM state change handler activates the netdev's
> read_poll() when VM stops, allowing the netdev to continue reading
> data and passing it through filter-redirector to the chardev output.
>
> This is useful for scenarios where filter-redirector needs to
> process network traffic even when the VM is paused.
>
> Usage:
>   -object filter-redirector,id=3Df0,netdev=3Dnet0,queue=3Dtx,\
>           outdev=3Dchardev0,enable_when_stopped=3Dtrue
>

It seems this series is trying to address previous VM migration network
related issues that Juraj Marcin mentioned.
Add CC to him.

I've taken a quick look, and this series lacks support for
filter-reply and filter-rewriter.
Could there be a reason for this?

Thanks
Chen

.




> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  net/filter-mirror.c                  |  38 ++++++++++
>  qapi/qom.json                        |   7 +-
>  tests/qtest/test-filter-redirector.c | 106 +++++++++++++++++++++++++++
>  3 files changed, 150 insertions(+), 1 deletion(-)
>
> diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> index aa2ab452fd..e1a0650abd 100644
> --- a/net/filter-mirror.c
> +++ b/net/filter-mirror.c
> @@ -21,6 +21,7 @@
>  #include "qemu/iov.h"
>  #include "qemu/sockets.h"
>  #include "block/aio-wait.h"
> +#include "system/runstate.h"
>
>  #define TYPE_FILTER_MIRROR "filter-mirror"
>  typedef struct MirrorState MirrorState;
> @@ -41,6 +42,8 @@ struct MirrorState {
>      CharFrontend chr_out;
>      SocketReadState rs;
>      bool vnet_hdr;
> +    bool enable_when_stopped;
> +    VMChangeStateEntry *vmsentry;
>  };
>
>  typedef struct FilterSendCo {
> @@ -251,6 +254,7 @@ static void filter_redirector_cleanup(NetFilterState =
*nf)
>
>      qemu_chr_fe_deinit(&s->chr_in, false);
>      qemu_chr_fe_deinit(&s->chr_out, false);
> +    qemu_del_vm_change_state_handler(s->vmsentry);
>  }
>
>  static void filter_mirror_setup(NetFilterState *nf, Error **errp)
> @@ -282,6 +286,18 @@ static void redirector_rs_finalize(SocketReadState *=
rs)
>      redirector_to_filter(nf, rs->buf, rs->packet_len);
>  }
>
> +static void filter_redirector_vm_state_change(void *opaque, bool running=
,
> +                                              RunState state)
> +{
> +    NetFilterState *nf =3D opaque;
> +    MirrorState *s =3D FILTER_REDIRECTOR(nf);
> +    NetClientState *nc =3D nf->netdev;
> +
> +    if (!running && s->enable_when_stopped && nc->info->read_poll) {
> +        nc->info->read_poll(nc, true);
> +    }
> +}
> +
>  static void filter_redirector_setup(NetFilterState *nf, Error **errp)
>  {
>      MirrorState *s =3D FILTER_REDIRECTOR(nf);
> @@ -331,6 +347,9 @@ static void filter_redirector_setup(NetFilterState *n=
f, Error **errp)
>              return;
>          }
>      }
> +
> +    s->vmsentry =3D qemu_add_vm_change_state_handler(
> +        filter_redirector_vm_state_change, nf);
>  }
>
>  static void filter_redirector_status_changed(NetFilterState *nf, Error *=
*errp)
> @@ -437,6 +456,22 @@ static void filter_redirector_set_vnet_hdr(Object *o=
bj,
>      s->vnet_hdr =3D value;
>  }
>
> +static bool filter_redirector_get_enable_when_stopped(Object *obj, Error=
 **errp)
> +{
> +    MirrorState *s =3D FILTER_REDIRECTOR(obj);
> +
> +    return s->enable_when_stopped;
> +}
> +
> +static void filter_redirector_set_enable_when_stopped(Object *obj,
> +                                                      bool value,
> +                                                      Error **errp)
> +{
> +    MirrorState *s =3D FILTER_REDIRECTOR(obj);
> +
> +    s->enable_when_stopped =3D value;
> +}
> +
>  static void filter_mirror_class_init(ObjectClass *oc, const void *data)
>  {
>      NetFilterClass *nfc =3D NETFILTER_CLASS(oc);
> @@ -463,6 +498,9 @@ static void filter_redirector_class_init(ObjectClass =
*oc, const void *data)
>      object_class_property_add_bool(oc, "vnet_hdr_support",
>                                     filter_redirector_get_vnet_hdr,
>                                     filter_redirector_set_vnet_hdr);
> +    object_class_property_add_bool(oc, "enable_when_stopped",
> +                                   filter_redirector_get_enable_when_sto=
pped,
> +                                   filter_redirector_set_enable_when_sto=
pped);
>
>      nfc->setup =3D filter_redirector_setup;
>      nfc->cleanup =3D filter_redirector_cleanup;
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 6f5c9de0f0..b1fe55944c 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -488,13 +488,18 @@
>  # @vnet_hdr_support: if true, vnet header support is enabled
>  #     (default: false)
>  #
> +# @enable_when_stopped: if true, activate netdev's read poll when VM
> +#     stops to allow filter-redirector to continue receiving data
> +#     (default: false)
> +#
>  # Since: 2.6
>  ##
>  { 'struct': 'FilterRedirectorProperties',
>    'base': 'NetfilterProperties',
>    'data': { '*indev': 'str',
>              '*outdev': 'str',
> -            '*vnet_hdr_support': 'bool' } }
> +            '*vnet_hdr_support': 'bool',
> +            '*enable_when_stopped': 'bool' } }
>
>  ##
>  # @FilterRewriterProperties:
> diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-filt=
er-redirector.c
> index 5540c232c0..fa958bb0a5 100644
> --- a/tests/qtest/test-filter-redirector.c
> +++ b/tests/qtest/test-filter-redirector.c
> @@ -385,6 +385,110 @@ static void test_redirector_init_status_off(void)
>      qtest_quit(qts);
>  }
>
> +/*
> + * Test filter-redirector works when VM is stopped (TX direction).
> + *
> + * This test verifies that when VM is stopped, the filter-redirector
> + * can still receive data from the netdev because the VM state change
> + * handler activates the netdev's read_poll(). Data flows from netdev
> + * to filter-redirector and out through the chardev.
> + *
> + * Data flow: backend_sock -> netdev (read_poll) -> filter-redirector ->=
 chardev
> + */
> +static void test_redirector_with_vm_stop(void)
> +{
> +    int backend_sock[2], recv_sock;
> +    uint32_t ret =3D 0, len =3D 0;
> +    char send_buf[] =3D "Hello!!";
> +    char sock_path0[] =3D "filter-redirector0.XXXXXX";
> +    char *recv_buf;
> +    uint32_t size =3D sizeof(send_buf);
> +    size =3D htonl(size);
> +    QTestState *qts;
> +    struct timeval tv;
> +    fd_set rfds;
> +
> +    ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, backend_sock);
> +    g_assert_cmpint(ret, !=3D, -1);
> +
> +    ret =3D mkstemp(sock_path0);
> +    g_assert_cmpint(ret, !=3D, -1);
> +
> +    /*
> +     * Setup TX path: netdev -> filter-redirector -> chardev
> +     * Data sent to backend_sock[0] will be read by the netdev,
> +     * passed through filter-redirector, and output to sock_path0.
> +     * Enable enable_when_stopped to activate read_poll when VM stops.
> +     */
> +    qts =3D qtest_initf(
> +        "-nic socket,id=3Dqtest-bn0,fd=3D%d "
> +        "-chardev socket,id=3Dredirector0,path=3D%s,server=3Don,wait=3Do=
ff "
> +        "-object filter-redirector,id=3Dqtest-f0,netdev=3Dqtest-bn0,"
> +        "queue=3Dtx,outdev=3Dredirector0,enable_when_stopped=3Dtrue ",
> +        backend_sock[1], sock_path0);
> +
> +    recv_sock =3D unix_connect(sock_path0, NULL);
> +    g_assert_cmpint(recv_sock, !=3D, -1);
> +
> +    /* Ensure connection is established */
> +    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
> +
> +    struct iovec iov[] =3D {
> +        {
> +            .iov_base =3D &size,
> +            .iov_len =3D sizeof(size),
> +        }, {
> +            .iov_base =3D send_buf,
> +            .iov_len =3D sizeof(send_buf),
> +        },
> +    };
> +
> +    /*
> +     * Stop the VM - this triggers our vm_state_change handler
> +     * which should activate the netdev's read_poll()
> +     */
> +    qtest_qmp_assert_success(qts, "{ 'execute' : 'stop'}");
> +
> +    /* Wait for VM to actually stop */
> +    qtest_qmp_eventwait(qts, "STOP");
> +
> +    /*
> +     * Send data to backend socket while VM is stopped.
> +     * The netdev should still read the data (because read_poll is
> +     * activated by our vm_state_change handler), pass it through
> +     * filter-redirector, and output to the chardev.
> +     */
> +    ret =3D iov_send(backend_sock[0], iov, 2, 0, sizeof(size) + sizeof(s=
end_buf));
> +    g_assert_cmpint(ret, =3D=3D, sizeof(send_buf) + sizeof(size));
> +
> +    /*
> +     * Data should arrive at recv_sock even with VM stopped,
> +     * because read_poll is activated.
> +     */
> +    FD_ZERO(&rfds);
> +    FD_SET(recv_sock, &rfds);
> +    tv.tv_sec =3D 5;
> +    tv.tv_usec =3D 0;
> +    ret =3D select(recv_sock + 1, &rfds, NULL, NULL, &tv);
> +    g_assert_cmpint(ret, =3D=3D, 1);  /* Data should arrive */
> +
> +    ret =3D recv(recv_sock, &len, sizeof(len), 0);
> +    g_assert_cmpint(ret, =3D=3D, sizeof(len));
> +    len =3D ntohl(len);
> +
> +    g_assert_cmpint(len, =3D=3D, sizeof(send_buf));
> +    recv_buf =3D g_malloc(len);
> +    ret =3D recv(recv_sock, recv_buf, len, 0);
> +    g_assert_cmpint(ret, =3D=3D, len);
> +    g_assert_cmpstr(recv_buf, =3D=3D, send_buf);
> +
> +    g_free(recv_buf);
> +    close(recv_sock);
> +    close(backend_sock[0]);
> +    unlink(sock_path0);
> +    qtest_quit(qts);
> +}
> +
>  static void test_redirector_rx_event_opened(void)
>  {
>      int backend_sock[2], send_sock;
> @@ -489,5 +593,7 @@ int main(int argc, char **argv)
>                     test_redirector_init_status_off);
>      qtest_add_func("/netfilter/redirector_rx_event_opened",
>                     test_redirector_rx_event_opened);
> +    qtest_add_func("/netfilter/redirector_with_vm_stop",
> +                   test_redirector_with_vm_stop);
>      return g_test_run();
>  }
> --
> 2.52.0
>

