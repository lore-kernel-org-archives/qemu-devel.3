Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE89CCD585A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 11:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdRuC-0004gO-DB; Wed, 07 Jan 2026 06:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vdRuA-0004fx-HA
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 06:40:46 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vdRu8-0004JZ-RD
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 06:40:46 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b8010b8f078so318319166b.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 03:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767786043; x=1768390843; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bio3I+oN+xeX+wDsKlhhmMv3fGe4z0OAOkp0Yrtp37c=;
 b=ZpOLlHUUAVR7nnQvLQyORWWjGErzwIkymo0ciZEUTXdZCEY8Hbj1uinKG+Vkprr9Cf
 qrwzOi7KivsOmsglgr8mC8beK0etedt4+Z0pPf1FKV12GCKBXVDCoCiwH6dVerBD95rp
 0MkE8nhL+ki8JFa2mIIuCx4wKQdem8idzUSIlUW74ELCxs3SmgNeUSvORr7MXEts1I/+
 vZQKKXKiHogi5g+GNA7vXQIZHET/x0hVvenA0UnHx9tKaDOMShtmSGP+84CmCOIlglkg
 A2M1um+JDu85no0/4sykG1qrhts9oR22nUZTUps4ZnkVen92QNTHyws5pDh0yH07+ATg
 XEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767786043; x=1768390843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bio3I+oN+xeX+wDsKlhhmMv3fGe4z0OAOkp0Yrtp37c=;
 b=ryyVR+1CeaPN9/3INvX6EHYmHvUuVwZSqjIhysxBYG+xNfioSF2AZqJzJQK4c3Ky8t
 s3Kna/OPjZwrx8jykjC4sWH/QqWyIjVfJy0/0s+s+gi9WDeXKXNWkeQqnU1vCOZDegq0
 F0xkVyPvK3HiwspsGxClyHupe9f3tQbbdANozdz0aFSgxvUEnVE+sJtJG62hwcTEKf1h
 GhMxjh/XH5szAjEJCvcCKoMJs4l33RIFKFM/I2J+7LNYlgIXYwIAFxhaOh6ZNDqev+Zp
 dSNyDLwyxJgvbsAKOTKeR5D+cNuK4v93cMOfOyJdpSxU/hxnMqmoXLKfsZ9ihm9bXz/5
 BHuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/3KUepg4s3WamVmsnfiNHFFBI9/sb1LFi3DVI5w9VGsxlRCZDtKgb+6J6PQAAAJx2juSzHfSojj69@nongnu.org
X-Gm-Message-State: AOJu0Yw/YL4r4kyKjbpbkuvY4nqg9PFb8blJLNaWpLc95PfL0V8K3GCF
 gSvfUeCkHKyYicsiy6l7v1gOslXjW9crkz469MOo1PKviTBXN6YtbrosKoGLKOgTEdkARGclP4C
 0hF7cQf0BvCiCXBJzYUxYOMP4Tnw3zxA=
X-Gm-Gg: AY/fxX6mtheWrWV/5o/e9MTtfwkvThitFDp/iraI4l3M6oYGN0x2SXkOSjx3qq8EqWd
 ku/IdEVUX/per4EbkLQ9qZH1MFfxYbhPGXOtL65RVFV+whaYtMW5+IV2KqNeJHm8xFsMnufSwhG
 xC5kOIi+ziRMqJxmbZrz/CdQitgjQl38hsQC2BT1ZE4c794ABZO2bIb3vKZkK257J7/nT+A8Cke
 5gCpPllu2QCsuhPtLYi2qeM1Hi7vYFcF2zGugpWJhsiu/I2SbR9m6lcIHcaWnQvv5ZUQqA=
X-Google-Smtp-Source: AGHT+IGlTmpXOmCXpBGlQM+JpXa3GhsLXMEV31i46dzjQMpqybneGadkdIdl+Z91uXfk3OovJuIY70tMcPnsZ8BoFaw=
X-Received: by 2002:a17:906:c146:b0:b76:277b:9a5b with SMTP id
 a640c23a62f3a-b8444d4eb4amr202974866b.6.1767786042685; Wed, 07 Jan 2026
 03:40:42 -0800 (PST)
MIME-Version: 1.0
References: <20260104075412.1262-1-jasowang@redhat.com>
 <20260104075412.1262-4-jasowang@redhat.com>
In-Reply-To: <20260104075412.1262-4-jasowang@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 7 Jan 2026 19:40:06 +0800
X-Gm-Features: AQt7F2rYZ8J-EL5iXOr63ZKOVeADHjhBy4XnnQ0FjmJizqVSwPjCr-uagXrgZEY
Message-ID: <CAK3tnvJwUfEUEVxLVoo_wvZPO7aizF6bL+ivQA18aZxzRk2fPQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] tests/qtest: Add test for filter-redirector rx event
 opened
To: Jason Wang <jasowang@redhat.com>
Cc: lizhijian@fujitsu.com, qemu-devel@nongnu.org, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62a.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, Jan 4, 2026 at 3:54=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> Add a new test case 'test_redirector_rx_event_opened' to verify the
> handling of the CHR_EVENT_OPENED event in filter-redirector.
>
> The test simulates a scenario where the backend character device (socket)
> is disconnected and then reconnected. It works by:
> 1. Connecting to the redirector's socket (triggers CHR_EVENT_OPENED).
> 2. Sending a packet to verify initial connectivity.
> 3. Disconnecting (triggers CHR_EVENT_CLOSED).
> 4. Reconnecting (triggers CHR_EVENT_OPENED again).
> 5. Sending another packet to verify that the redirector correctly
>    re-registers its handlers and resumes passing traffic.
>
> This ensures that the filter-redirector can recover and function correctl=
y
> after a backend reconnection.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Very meaningful detailed description.

Reviewed-by: Zhang Chen <zhangckid@gmail.com>


> ---
>  tests/qtest/test-filter-redirector.c | 96 ++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>
> diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-filt=
er-redirector.c
> index da0c126314..5540c232c0 100644
> --- a/tests/qtest/test-filter-redirector.c
> +++ b/tests/qtest/test-filter-redirector.c
> @@ -385,6 +385,100 @@ static void test_redirector_init_status_off(void)
>      qtest_quit(qts);
>  }
>
> +static void test_redirector_rx_event_opened(void)
> +{
> +    int backend_sock[2], send_sock;
> +    uint32_t ret =3D 0, len =3D 0;
> +    char send_buf[] =3D "Hello!!";
> +    char send_buf2[] =3D "Hello2!!";
> +    char sock_path0[] =3D "filter-redirector0.XXXXXX";
> +    char *recv_buf;
> +    uint32_t size =3D sizeof(send_buf);
> +    uint32_t size2 =3D sizeof(send_buf2);
> +    size =3D htonl(size);
> +    size2 =3D htonl(size2);
> +    QTestState *qts;
> +
> +    ret =3D socketpair(PF_UNIX, SOCK_STREAM, 0, backend_sock);
> +    g_assert_cmpint(ret, !=3D, -1);
> +
> +    ret =3D mkstemp(sock_path0);
> +    g_assert_cmpint(ret, !=3D, -1);
> +
> +    qts =3D qtest_initf(
> +        "-nic socket,id=3Dqtest-bn0,fd=3D%d "
> +        "-chardev socket,id=3Dredirector0,path=3D%s,server=3Don,wait=3Do=
ff "
> +        "-object filter-redirector,id=3Dqtest-f0,netdev=3Dqtest-bn0,"
> +        "queue=3Drx,indev=3Dredirector0 ",
> +        backend_sock[1], sock_path0);
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
> +    struct iovec iov2[] =3D {
> +        {
> +            .iov_base =3D &size2,
> +            .iov_len =3D sizeof(size2),
> +        }, {
> +            .iov_base =3D send_buf2,
> +            .iov_len =3D sizeof(send_buf2),
> +        },
> +    };
> +
> +    /* First connection */
> +    send_sock =3D unix_connect(sock_path0, NULL);
> +    g_assert_cmpint(send_sock, !=3D, -1);
> +    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
> +
> +    ret =3D iov_send(send_sock, iov, 2, 0, sizeof(size) + sizeof(send_bu=
f));
> +    g_assert_cmpint(ret, =3D=3D, sizeof(send_buf) + sizeof(size));
> +
> +    ret =3D recv(backend_sock[0], &len, sizeof(len), 0);
> +    g_assert_cmpint(ret, =3D=3D, sizeof(len));
> +    len =3D ntohl(len);
> +    g_assert_cmpint(len, =3D=3D, sizeof(send_buf));
> +    recv_buf =3D g_malloc(len);
> +    ret =3D recv(backend_sock[0], recv_buf, len, 0);
> +    g_assert_cmpint(ret, =3D=3D, len);
> +    g_assert_cmpstr(recv_buf, =3D=3D, send_buf);
> +    g_free(recv_buf);
> +
> +    close(send_sock);
> +
> +    /* Verify disconnection handling if needed, but mainly we want to te=
st Reconnection */
> +    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
> +
> +    /* Second connection */
> +    send_sock =3D unix_connect(sock_path0, NULL);
> +    g_assert_cmpint(send_sock, !=3D, -1);
> +    qtest_qmp_assert_success(qts, "{ 'execute' : 'query-status'}");
> +
> +    ret =3D iov_send(send_sock, iov2, 2, 0, sizeof(size2) + sizeof(send_=
buf2));
> +    g_assert_cmpint(ret, =3D=3D, sizeof(send_buf2) + sizeof(size2));
> +
> +    ret =3D recv(backend_sock[0], &len, sizeof(len), 0);
> +    g_assert_cmpint(ret, =3D=3D, sizeof(len));
> +    len =3D ntohl(len);
> +    g_assert_cmpint(len, =3D=3D, sizeof(send_buf2));
> +    recv_buf =3D g_malloc(len);
> +    ret =3D recv(backend_sock[0], recv_buf, len, 0);
> +    g_assert_cmpint(ret, =3D=3D, len);
> +    g_assert_cmpstr(recv_buf, =3D=3D, send_buf2);
> +    g_free(recv_buf);
> +
> +    close(send_sock);
> +    unlink(sock_path0);
> +    qtest_quit(qts);
> +    close(backend_sock[0]);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      g_test_init(&argc, &argv, NULL);
> @@ -393,5 +487,7 @@ int main(int argc, char **argv)
>      qtest_add_func("/netfilter/redirector_status", test_redirector_statu=
s);
>      qtest_add_func("/netfilter/redirector_init_status_off",
>                     test_redirector_init_status_off);
> +    qtest_add_func("/netfilter/redirector_rx_event_opened",
> +                   test_redirector_rx_event_opened);
>      return g_test_run();
>  }
> --
> 2.34.1
>

