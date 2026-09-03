Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98170C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2D9K-0008Og-AR; Thu, 03 Sep 2026 15:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x2D9I-0008O8-O8
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x2D9G-0002gW-UH
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788463857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jLjONFJJ7E9KY/BqSG37ywmPhdTkGGZSVTXFn8MY2LI=;
 b=WO/UQOUriYfP7qtIHwzwMohUBjz94f+lr+djNgv+kl/9gyE2Ip67MrnWsupfojnDhpwTJN
 pPLZHSAHrBC2T8xfjKjaG6v6aliSholwPv0dzUunKmpxCpqtAhYl56jlys3HtwvXcRkk9+
 3P3p6MwAcWuZWyvwyTnBv+toqHsgmzM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-_N7HpwibNfyKPkB9i44Kwg-1; Thu, 03 Sep 2026 15:30:55 -0400
X-MC-Unique: _N7HpwibNfyKPkB9i44Kwg-1
X-Mimecast-MFC-AGG-ID: _N7HpwibNfyKPkB9i44Kwg_1788463854
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso238217a91.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788463854; cv=none;
 d=google.com; s=arc-20260327;
 b=oLlzl6aonV4WYvP/yHAPNWLH02yznic58STqvYw3taxLCvS/vqI3ItsVpSrANbl+Qs
 zfFXG+4y2L/GuvLab/NrBn/jbc1GPDnWBjy0V8reLsBzmcsIH7N5DQa3R6J6L0iZYWk4
 CJpol3y66PwQ6/sBKIu0ust/bKqnqkZBM+jiPS9LsQdpSVMkK0WB0MMrBsTIdNfz+2xP
 q3907di5eGT2Jn+OFn+qYXx6OlTT0Rq37zt3DkmjBQgM5ENP28V4hnas1CSk3w4Imf8W
 LFqdlk6bDsFJiF+O2IDxTUijeA5gPwy6icIQtIlIQQrkGY02Dzg93uU4d2eBSowyff/s
 dS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jLjONFJJ7E9KY/BqSG37ywmPhdTkGGZSVTXFn8MY2LI=;
 fh=gC6cEwCIoMqii6+cjmGB0+3fq9atRcrJzdCKulDoX84=;
 b=Lifnf1mjR45E6nhRnhiXRlHpxoxaJ33Ys8zbaZBVXV6Yr28m4XxnvLaLwbJ/FoFoeK
 Za6juCF++zdLEr4ukbyFl9aEKWOoMsirEd/Z6kfUaqaZG33u0CDTD/RbzsK6Dn5uTvSn
 FZ4SHYeeG/4tKN+tm5A6DvdpQ53U2+Os9XSIZFVFBldDZrkLDc2GaN3lmpAv73AXd02r
 y+RaTfXAupJ/ORkxx0VDPDyYnPbg3UX6302PxNn+h6sq0sA5rgIdBk9csvPInGtF+YOH
 9L31oIrGGBDX75Vh9fKSoa/q9j4ZY9o5nlUlNArOmfDg+UcuUHbPxRwq1BtDXIgA6tPr
 CbYw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788463854; x=1789068654; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jLjONFJJ7E9KY/BqSG37ywmPhdTkGGZSVTXFn8MY2LI=;
 b=ISHf7xxYnNl+dG8l9LL6BmdRhmJH2g0t0jkS9AYQ3BAE9AMDyOBPVCcDSp+70+HwMF
 NZUQbmbWaP3RYiBOMBDo9OuS8levioYlPeX8HdSLvLXVJB1cNbRyL0JNnEc8BmEgABod
 9SOQCnjbq95QRKywrKx2n2fxqydxwDc4SMTxfeoSTgrr7fFiXKCtq0RFgoWU5Gb3qdYT
 46XPukkPfHWWNDlams6xyt9DhZQJ/XoOkya9NRBHeRSx1NyjRJRHgAYfCg6MwI3Wb1oC
 dAonXJb0Fvu1V+zrGlfMUtDbwSRh2BsiG7Xw+PzArvoN56zXl2K7FE6jseA9EKrVvlQj
 5qiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788463854; x=1789068654;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jLjONFJJ7E9KY/BqSG37ywmPhdTkGGZSVTXFn8MY2LI=;
 b=L2rRCUzvdoEmUuQqADEd2YsIBvSUNxqLOdd0/8shdb2MFqx3eT0uXzoRBqzVbZUX8W
 mduhSkaniH81QowiKtVfXiL1H9LB/VSI/hggAhkPtVHOODsmCC9xoFPWTAqKOhZ2Utpq
 faIR/x27cZRIjHEaFppnXeqNe6HptSycqTheBSI8ThjPMeOZFqqNW1bJWNAFkrWwEIFr
 1CsigPsF1O7sZ2/ajgk0fi2yRZKJxhwcwVkkTox96g1er1ljQI88leWTEQBIO5IadGz1
 FziEcv2ALrWZVjSkvS9UkKNvYfMDxQ+PS/fnacclA8RmUaT4KvZfr7sdjrcipH6WTx6h
 HeSA==
X-Gm-Message-State: AFuF++kte62CcYg6QVUO3a+yG7X2PZi2IW1ETKWIN6CbN9UeAVJ17fiY
 LxcMc2so7YPcLDl/D7wKDEuAmCJA9R2AeQBSB4mDgYJFggTdFDOCGWNahU4u3C78AQTueQRU4va
 /yDflmZIJqneK1XsZqG2OpPT0BWNnKZF0oPyB4qdXMK+lcVumkcd5oPmTaynvsuMb60P+Cyel4Z
 JlHovVwCNgZVWuPVYX06axZYjj07V4SUBCt4eE+9YqyA==
X-Gm-Gg: AYBFou2brsyhp7jcA4e9YenL1y1fOofY4v3DF0I/ICez3GeCJ5oNbs/6SrVbJsG+hnf
 9mSHbQfhIhfzDcxH6PFsz2FXp6asXoI2ck0wVKHxi9he6aO66XhFYoNbi0uYnGRo4TV5/Jrmy/y
 0NfZkugaXkYUfE4YBVevF2lmn/BPh5yjnRjIMN+xMOtqdo5Mr0vPMAw86rohTY/AiLYfH9guky3
 SqfAqArAA7WCqX0B9c41pPBFQGtDOix1n+7vQxJzO7jE2D5qJtOPIuFrdxerFX64cyaHyEW20/t
 hg==
X-Received: by 2002:a17:90b:3d89:b0:396:5fce:8e24 with SMTP id
 98e67ed59e1d1-39b260d2ea8mr1144681a91.4.1788463854417; 
 Thu, 03 Sep 2026 12:30:54 -0700 (PDT)
X-Received: by 2002:a17:90b:3d89:b0:396:5fce:8e24 with SMTP id
 98e67ed59e1d1-39b260d2ea8mr1144569a91.4.1788463853870; Thu, 03 Sep 2026
 12:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260903192647.2677279-1-den@openvz.org>
 <20260903192647.2677279-2-den@openvz.org>
In-Reply-To: <20260903192647.2677279-2-den@openvz.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 3 Sep 2026 23:30:42 +0400
X-Gm-Features: AcwNN1Uo2M8_-g_kmMqrJ1atQ0AP-rJqjlS7ZbqZTfa9Vh2WfE44v982Xjvs-x8
Message-ID: <CAMxuvazYTFb+U7-+geii6ErFcfdrFOZ1tkYxEbmX+St179g9Dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/display/qxl: hold ssd.lock while replacing
 ssd.cursor
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 3, 2026 at 11:26=E2=80=AFPM Denis V. Lunev <den@openvz.org> wro=
te:
>
> From: Denis V. Lunev <den@openvz.org>
>
> qxl_spice_reset_cursor() unrefs qxl->ssd.cursor and installs the hidden
> cursor without holding qxl->ssd.lock. Every other writer of that field
> takes it: qxl_render_cursor(), display_mouse_define() and
> qemu_spice_cursor_refresh_bh().
>
> The unlocked path runs on a vCPU thread, reached from ioport_write() on
> QXL_IO_DESTROY_PRIMARY and QXL_IO_DESTROY_PRIMARY_ASYNC, and holds only
> the BQL, which the SPICE display worker never takes. Unlike
> qxl_hard_reset(), it leaves that worker running.
> spice_qxl_reset_cursor() does round trip through the dispatcher, but the
> worker is free again as soon as it returns, so it can enter
> qxl_render_cursor() and unref the same QEMUCursor a few instructions
> later. Both threads then drop one reference for what is a single
> reference, freeing a cursor that another user still holds. The store to
> ssd.cursor races the same way, and a guest that keeps this up also ends
> up waiting forever in qxl_fence_wait().
>
> A guest reaches this by switching QXL mode while it also updates the
> pointer shape.
>
> Fixes: 958c2bceba06 ("qxl: fix cursor reset")
> Cc: qemu-stable@nongnu.org
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

thanks

> ---
>  hw/display/qxl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 384b8767b8..c4f547e88b 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -294,10 +294,12 @@ void qxl_spice_reset_cursor(PCIQXLDevice *qxl)
>      qemu_mutex_lock(&qxl->track_lock);
>      qxl->guest_cursor =3D 0;
>      qemu_mutex_unlock(&qxl->track_lock);
> +    qemu_mutex_lock(&qxl->ssd.lock);
>      if (qxl->ssd.cursor) {
>          cursor_unref(qxl->ssd.cursor);
>      }
>      qxl->ssd.cursor =3D cursor_builtin_hidden();
> +    qemu_mutex_unlock(&qxl->ssd.lock);
>  }
>
>  static uint32_t qxl_crc32(const uint8_t *p, unsigned len)
> --
> 2.53.0
>


