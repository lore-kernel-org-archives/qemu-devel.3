Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7EBEB1041
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzu8A-0002J4-O8; Tue, 10 Mar 2026 06:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vzu86-0002Il-JY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:15:59 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vzu84-00088v-DR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:15:57 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6617f0bcad2so7308701a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773137753; cv=none;
 d=google.com; s=arc-20240605;
 b=QXJUefFrI3OGqc+TB+6M6qdRI9d0dvHljgNI9Iy5Pw3QAqUxC/sHa01VzbvcDIn8t/
 JWjtdIcqcgx87aLA1EgttbeaEmoMvn8ZyXick/Fq8J3DEtei5Js/0JwrfsY957gjdVBp
 0Crmq0bH37EnJVfSK0QM5nXknjtTcMgm3jkxOLQ25IN2OfAdtNSQGVEZA29vnhVy2vmA
 xYZptjN44ZIK0M4k1u5blVdmMjy8ljwzdvwF4SCdpYiJCTg1+EJjp8FhflzVPwPSKYhB
 J4rxUbaWKIJuCWCPGloKCrmv6su3deUtfIiBsYQfDDpXe2V13eBczgMovOLoy8Zr3xFq
 aiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eFMQRaTOPTytbVUi59YQgQlVI8iB7+5R1eZ8nL4HV74=;
 fh=aYT0Dte32zScO0z23mE8usKARXq3g0LPBKVr7DfkjMg=;
 b=IK3b7TywscaQW1lucF0sfw2fJ/ME3vjOYW6xoPa6LOZGvF5T3XCMcFxzzS4jim1+3c
 EWCcBc2bfExFTx5z3ZhIXF7CJ+G4MX2rcd8jWh/czKMrVKb0o0Mr8qurETk2Vt0zqXob
 DuZZLh4qN8hY/Kpe2WQoqYOIGO1gYg7emCk3bfVNEBz/DeWekOm85DHLpcEs6hD6IilX
 sPjpGokYs0uZjsnZ7o0DFoNsgG7L9c0a7SKLb43VvhLuWf3fTfio1xbnLEoYlH/A8nV3
 /o3Y6nS9zLmbukWaUHRDaFrsJqpUXyn7VZ4Pjr6LvFh7TrN2KfBhHS0eMN4T5UjGStO0
 KjCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773137753; x=1773742553; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFMQRaTOPTytbVUi59YQgQlVI8iB7+5R1eZ8nL4HV74=;
 b=izjIfimfzal7BwhIKxGa8OZ4RUt7fxFJKBgSZ4wPVMAGeGO+ggeTkBhkRa+6Uj+HNQ
 w0k9PXNwSQruJFnSnvI41GsmgOTESei7+XkGpbvNaXvnBW0jaH5sqNiE1H5ZY3VDrDJO
 3JvGyNspXFVLfUOc+gC8BVlcK+Wt1AYBRzG55JC0BbcjjK5ftWgIUOMFL0nah1nTf6Y9
 TG8f4QMeDATTNLcI6ef+feBHl9CJIxtMsrOx9gxm7EUJzV64z99RkLyljWhJnBDT0e8W
 HTEzKX2v7LH7//Ln3OiCReJFcWKk5s3Cw0WudHxwKNRXAPqZnrziVS3vn0b/Xtztualn
 Kv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773137753; x=1773742553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eFMQRaTOPTytbVUi59YQgQlVI8iB7+5R1eZ8nL4HV74=;
 b=lMgcbcaVbZNjI5pr1rKrIuAorynHtl+CiOi2RaxYMHRtKhZV+kl+vvleigC17V+qzh
 51i81zsq7p694oNqSwj+kmVSF+e1QC7hmyjfM+oZz2pSBGNcbRN0yiDb4eBs1OnYZQwI
 Fi9IFLKbli7sbeVARu8w6LoWcZZBmwvf3S2AJA2ndZyHLjkz+09xq1zDb4bm7cs/tg8/
 a46YWcVtEr0v2YUs/I/7/YwI/iy6JYS7wYIY+wCT/Io7X+qvq3VaKPhRiPq5PDNf8soi
 m+7jFxRCODKP6ZH+LitGPifEUunehU9+C1yQRLQS+MpYsPUqmG+LXkNdbBJh9Nl94Ilr
 5cwQ==
X-Gm-Message-State: AOJu0YzK3E+fz4GQBmtOZKOpURN56y+y5O3/MRdTXI4zlMrDmLC8QodT
 9Hi00YNugs6VqhiEHuGc8fqGSZm1i3yuqPcc6lERXmWv7F6UDz3/WJp+rbkVb+fWxEFThEBDkJt
 6qGtJr8BdCrixneCjkRebT/PNo1S9HPg=
X-Gm-Gg: ATEYQzznviAn9yQrHKRByG0e5Wu8pcRskR9wINU4LNllSqyHtZLBvm46T+7QCOtud1N
 1uiDeWHOMyh3qjbC4nyWcc8+fsFlLfD4P/Xzze92Mp1UIknvMSuH973mukOSev2gS+Hlsev6LkB
 yHEsJX3vy0IQeCcVWICvgmUCMd0TXaq5tTff5V4u7YAeaWulaNEAtueYX/Oh/3cZpu5/QCBGl0N
 bl3ZKGzCWN7vFsFN9MNUEqwzvMra4MpUCcAj7KPmf7FuD3lJ+Ufnx3bqMh3B6X4j8mRYfGmPwj1
 8xPacvQ=
X-Received: by 2002:a05:6402:902:b0:662:811d:60fa with SMTP id
 4fb4d7f45d1cf-662811d66aamr1935604a12.0.1773137753460; Tue, 10 Mar 2026
 03:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-8-zhangckid@gmail.com>
 <20260309084422.GG39949@fedora>
In-Reply-To: <20260309084422.GG39949@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 10 Mar 2026 18:15:16 +0800
X-Gm-Features: AaiRm51H2w25jHJdmQiEKcTDRgOlehGSo91uKH_rhYK1EqGdUVn5h0TuQPkt3Wo
Message-ID: <CAK3tnvJmGEdr93pDDZdFk=0jUYHYChgchR4xtP6JpDVxBv2MCA@mail.gmail.com>
Subject: Re: [PATCH V5 07/13] net/colo: track IOThread references using
 path-based holder
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52a.google.com
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

On Mon, Mar 9, 2026 at 4:44=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Thu, Mar 05, 2026 at 10:24:53PM +0800, Zhang Chen wrote:
> > @@ -1434,11 +1436,17 @@ static void colo_compare_finalize(Object *obj)
> >
> >      qemu_bh_delete(s->event_bh);
> >
> > -    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
> > +    /*
> > +     * Use the device's canonical path as the holder ID to track IOThr=
ead
> > +     * usage and ensure the AioContext remains valid during the device=
's
> > +     * lifecycle.
> > +     */
> > +    AioContext *ctx =3D iothread_get_aio_context(s->iothread, NULL);
>
> Should NULL be path?
>

Yes, here code in the finalize function need to waiting for the
coroutine to complete processing
Or do you have any other suggestion?

Thanks
Chen

> >      AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
> >      if (s->notify_dev) {
> >          AIO_WAIT_WHILE(ctx, !s->notify_sendco.done);
> >      }
> > +    iothread_put_aio_context(s->iothread, path);

