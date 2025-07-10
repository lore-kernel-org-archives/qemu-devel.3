Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C331C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 13:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZrMJ-0004G6-2t; Thu, 10 Jul 2025 09:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZrME-0004F6-BB
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 09:30:38 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uZrMB-0008Kz-SP
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 09:30:37 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7086dcab64bso10020927b3.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 06:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752154234; x=1752759034; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zgezi+FSe3XHM6R/ExWXrw6SOu/e3F6PONr9bh0GJbs=;
 b=NFh83tQNE1pf7fXMQxOiSf+eSf8All2G2W1piXOcOx9ztwp1PNJwmb+KnCSDcAB7O6
 71ljhBXOtrm8hyk9QJ9PuP8wQlaQ6Bg9es2Ymd6BAJ9ARg3HiG8JuJR/ow53wOoQ0Jqd
 1tk1RmCUxk0SmBIvGINAlpRPjiHEheq5tohsKmXT7eTD4skTkElt1uKst5dSDKKkQH2Z
 3fPJnUYSvlroEZjf4/ksDwyhk5QDxTC8dhLEHw1NU7Lrls5Ud9Vx3Hj8KRfyLcx3ppq2
 DpmHURQMhSV+Fv6IjKCBND9F8oQNihAtcNYqd7ybDvbGPJXu1spf4ckaSqE1OYbYVZ3Y
 TOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752154234; x=1752759034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zgezi+FSe3XHM6R/ExWXrw6SOu/e3F6PONr9bh0GJbs=;
 b=omrwr7GI2Hyr/3tTKTZN6m1CO0/5tNFcCQiHojOVSPIcB5yvWLbVY/5TnWGPbewLSH
 /mrw8YgAKrs9LIJdsFN0eiaTqYI1jPB3Bu65I+n/c+4aZcRUOc+fmJNxp5CCudyP1iXo
 PBtB2XiMoldD9yHfVXzQd9lVodo2/8k9s3w1KI1HrgXzOM9J9EPM/THlvRME98zowfYj
 c6TXqjmwozYu3mSbnrUa+IlUK9eHjvArqtBKw6kx89JeksWGtxnvzA1ZQ7gpnDuIB6NJ
 8i2DQ6stQK7Swz6FvLGqFUGDrHdbPv7WN1KGibP3qUvtfl11i00ulEBKrTVcg7ou+7t7
 LuMQ==
X-Gm-Message-State: AOJu0YzoemSomih1sG+9OZDeRW4qNbRDTJ0La9Gz8XezhpL/mh/jZ2/4
 xXD/kD35FaPJcJpvMYqSsMTH9HrhBN4Z2sJ5w2lSka3vAt+zbqYhFqPLBhWXhjNaOXd0G4GsVL1
 y8PCYrFB5dydWo2uMWou9CRxcSfndN2tF+ceZsCXkSK4g0BrlcHwC
X-Gm-Gg: ASbGncsIp9IEnhJlc95NWiyQv24d7p8wtZmMaEaoYaL8l9P/c6fIbIRB6bkYAV8cViN
 w8kIJf/3XsHLX9PTttd8DoqDy0kGKEVipCE7IqmWO7iTmxdHXsqPzsktIJFEgwbnj6sY0uIxl7k
 70cj5gGvK/+F8jWhHkHPh/d5xm5RBjgIoU6Ibz98JCaZy2
X-Google-Smtp-Source: AGHT+IEkW9grMxnS/qKwFm9uHNoJy+7I8JaEtD1DOdZt4lRBlcdkAhqS8Q379G3vunQr0XW+YeXXZoJrAoRcVwvNXzk=
X-Received: by 2002:a05:690c:62c1:b0:712:e2b5:e61b with SMTP id
 00721157ae682-717c467e425mr41730677b3.13.1752154234014; Thu, 10 Jul 2025
 06:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1746438650.git.qemu_oss@crudebyte.com>
 <4719a2d59176a6c850e2b4f1af44cecd25430fce.1746438650.git.qemu_oss@crudebyte.com>
In-Reply-To: <4719a2d59176a6c850e2b4f1af44cecd25430fce.1746438650.git.qemu_oss@crudebyte.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jul 2025 14:30:22 +0100
X-Gm-Features: Ac12FXzqLEZhmQ3mAoNM_RRC4DGBKUMEwuJp2C3qwqN5ISefo5RSgXXz3CFG9NI
Message-ID: <CAFEAcA8Sc7t25KNzwnEAi=n8SNCAYDsFbs8P8hUKwWRxWzx_QQ@mail.gmail.com>
Subject: Re: [PULL 7/9] tests/9p: add 'Tsetattr' request to test client
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 5 May 2025 at 10:54, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> Add and implement functions to 9pfs test client for sending a 9p2000.L
> 'Tsetattr' request and receiving its 'Rsetattr' response counterpart.
>
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Message-Id: <20250312152933.383967-6-groug@kaod.org>
> ---
>  tests/qtest/libqos/virtio-9p-client.c | 49 +++++++++++++++++++++++++++
>  tests/qtest/libqos/virtio-9p-client.h | 34 +++++++++++++++++++
>  tests/qtest/virtio-9p-test.c          |  1 +
>  3 files changed, 84 insertions(+)
>
> diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
> index 98b77db51d..6ab4501c6e 100644
> --- a/tests/qtest/libqos/virtio-9p-client.c
> +++ b/tests/qtest/libqos/virtio-9p-client.c
> @@ -557,6 +557,55 @@ void v9fs_rgetattr(P9Req *req, v9fs_attr *attr)
>      v9fs_req_free(req);
>  }
>
> +/*
> + * size[4] Tsetattr tag[2] fid[4] valid[4] mode[4] uid[4] gid[4] size[8]
> + *                  atime_sec[8] atime_nsec[8] mtime_sec[8] mtime_nsec[8]
> + */
> +TSetAttrRes v9fs_tsetattr(TSetAttrOpt opt)
> +{
> +    P9Req *req;
> +    uint32_t err;


Hi -- Coverity warns (CID 1609751) that this function
passes by value an argument which is a 184 byte struct.
Is this intentional? Can we instead pass a pointer to the
struct?

This is only a test program and 184 bytes is not super
enormous, so if this would be painful to avoid we can mark
the coverity report as a false positive.

thanks
-- PMM

