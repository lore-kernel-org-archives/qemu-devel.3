Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8C3C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 08:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUMqN-0006FI-7v; Mon, 29 Jan 2024 03:18:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rUMqL-0006FA-CU
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 03:18:13 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rUMqJ-0008Lw-Qk
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 03:18:13 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-42a4516ec46so21303641cf.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 00:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706516290; x=1707121090; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNXSfwPeN+wKRJUQQRfpigstoifqEUq/470KB2cI4qw=;
 b=lwy+k1NaerrbwfLMik0gKXJP/VjvgbZr2QZ0qfbLq/FJbhWMFP68+kyFeKzODlTeoW
 IOF/BmdjyWuad/9cAEgoQaS2Ye6303Pm+l5lJXdFhMmCNtFFbAl6nKniUOh6e5sb5nZq
 SRyBgw9FTe6NVl91nVTdCYVUpi+rDsfdRlJJMSlNLTvnVz7OgIIZLiXTXq1IesqUe/T/
 BzqX3dwxdLkud1J5IhwmAuIwtYZOMKfSLnEcGWQnSCfbl4atEGbkmR2/QE14SgC29pNI
 sR+BYEhNd24N/QPE4cJTaZBr6nIivePRwr7r7oHslyuAJ4GYC1xGwKmg0qr1uf59PpT8
 KroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706516290; x=1707121090;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sNXSfwPeN+wKRJUQQRfpigstoifqEUq/470KB2cI4qw=;
 b=mNY109LGeRVLaLj1NxUSfEvUI1q1MZ+wlBHqW2tOg/2xfjjYBosGTXcfWbxYX0Ve62
 KGw5hV0iAE+XvhHp0ePlrSZ8CnF/0GySC8cNKGuWJgycrL2GsmLmFSaVoRCMp/vj99rq
 v7+dQaNoGuqFjcl5ruqmNeuob951HZF5w6tyTMQmgPuoa5sYQOoFCviTq4TJaUPFTqzE
 uPLSSAvJKVSCU951vLtGQwf39TuLxPJxOwvJEKMTgn/JPpH6i0p0V8XqW0aKwBxqht50
 zQNQtWYLbUDVb/cPaeuRsua/KdXjSZC1otYw7pgWxBoSVu4vxQ3tFID15G4RP3spO+FX
 v0JQ==
X-Gm-Message-State: AOJu0YzAGNDq8d+cIlzcviegdLuXV/SsPgSRZLGFQ9R5BhxB4194T1dT
 ho9sZcgyBYO3b9+pfPdUSZw7kqaensJc6K1RL8B8LgcN0wPyEc78gNwa3Ydu/T8vwKjPSbTW3F1
 g9JuA5+7OUcytOfSrTDPjXYbPsaU=
X-Google-Smtp-Source: AGHT+IHRZzo6jbHdGyFEPxA+VuvMySC27AXBNVyWQqspEZaXBw59c6ksuI64j8jrQ4kCBlo1PtjBdRQbI9i1CVgdnx4=
X-Received: by 2002:ac8:5c16:0:b0:42a:941a:89be with SMTP id
 i22-20020ac85c16000000b0042a941a89bemr4166522qti.54.1706516289741; Mon, 29
 Jan 2024 00:18:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1706279540.git.manos.pitsidianakis@linaro.org>
 <947fcb0c386e77b5ef59f4a6ca48baeee0d1a980.1706279540.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <947fcb0c386e77b5ef59f4a6ca48baeee0d1a980.1706279540.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 29 Jan 2024 12:17:58 +0400
Message-ID: <CAJ+F1CJw7unr+Cxnc9uWGmgB9O4vvdPyZntFkb2keyRfX0EOUQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] hw/display/virtio-gpu.c: use reset_bh class method
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Jan 26, 2024 at 7:43=E2=80=AFPM Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> While the VirtioGPU type has a reset_bh field to specify a reset
> callback, it's never used. virtio_gpu_reset() calls the general
> virtio_gpu_reset_bh() function for all devices that inherit from
> VirtioGPU.
>
> While no devices override reset_bh at the moment, a device reset might
> require special logic for implementations in the future.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/virtio-gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index f8a675eb30..2b73ae585b 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1515,7 +1515,7 @@ void virtio_gpu_reset(VirtIODevice *vdev)
>              qemu_cond_wait_bql(&g->reset_cond);
>          }
>      } else {
> -        virtio_gpu_reset_bh(g);
> +        aio_bh_call(g->reset_bh);
>      }
>
>      while (!QTAILQ_EMPTY(&g->cmdq)) {
> --
> =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
>
>


--=20
Marc-Andr=C3=A9 Lureau

