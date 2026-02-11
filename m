Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D549AE9E2E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 11:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq8TR-0000eA-93; Wed, 11 Feb 2026 06:33:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vq8TP-0000e1-EY
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 06:33:35 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vq8TO-0005WY-2s
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 06:33:35 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-50334dd44d2so59600391cf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 03:33:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770809613; cv=none;
 d=google.com; s=arc-20240605;
 b=aK7lHq2GWaFnzJkiNPP006gkshGSwXYEoKhG9I4h0QI9ntH2pP+jCcyhp9s/hmlyzi
 gYpCqHeXN8mVDuYXe+9gu/uKc/KED77U//94R6Xe+BMKJ7scPho5tEzgZjtKP/073z7v
 Z+Gyj8eNFeRipItwNldP7ejIAKa9Ak7SF9f57NBs5QKgTAzouwc2z2dGH8UAXZIQTHuE
 atv+LpTt/m8NgSlWSdyVVLL7e9gOdxA1Fu6xFWqgQffIuEZEO35iDA3E2kM4dkWkouCf
 uv349jC4y33pKHMlrBc33lHhVmRo+4TeordK9zx9T8sVj5SS7CALoM6wgZrAqgj8mwGB
 BMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CFghyKa76hm62Z3ZkWLd4IWXrZ+FSppTSCau4eu5pIQ=;
 fh=w8U77HbcpXmFyETHaPZ38FIW3y5k7+neTomqA1KfMSc=;
 b=f6y+/4kYClkfUJ0TwYpRD1VoLVEnHaqyBSLp9ozmVjBz8W/djjo1zmRaHnOyCNYhaT
 YZSdLusYcvk7bmybf3hJ8274JHyYQE/JofEnpUA/Tc/TiDwDo2ups79twXf87NJWR4lc
 uXOJ6UtfhaocJNFNrcuybm09SoCvXPDdvizPAL0QXnaPfvW5W82wtGC3aBG1aGTv26R/
 DkF+BgSKftkvamnx9Sxb2csytRjkw8X+KiR+wLkYl2WICxcc2KPkxREPyDDLDc0G37G8
 EDrI+o35vtBHdT/IMTV5wosCB/KlD1Fsw2p/NREZ/XiQzRXSt79iQVjh43O+iA4ahRIj
 NedQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770809613; x=1771414413; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFghyKa76hm62Z3ZkWLd4IWXrZ+FSppTSCau4eu5pIQ=;
 b=jSjbT8l1Eq5iu8UtDEq8ObGTQG17PYu9M5IPDqsp1URnEUyV+HUvDmu3gTYoCqLK/f
 M7WgZbjIy05Yhi4bDAQjgNKBxDuwb8pSgUNH21bNki4rKGaWXBKU3W1wz9EfK7qQRkZt
 esREkI2v5b47T7gDPxB9dASBx8zXOCzYWfRcBUUfu/319W4RzJjuAyZrf6A956vXSrjn
 jHDqMkU7vscZtawk825F1Yx7hirVUkCpGOHMeGRi5vnFbZ200YNg4Onjd817cfYr00C3
 MvpW+oIJJ0fyulkZ8wnM/3ebvDo2lxj9xZcPhweElfM2jIaLZIjl6xWn2wui00/qtEip
 ua6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770809613; x=1771414413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CFghyKa76hm62Z3ZkWLd4IWXrZ+FSppTSCau4eu5pIQ=;
 b=m/xMYTicfFCuw6aqulgjDXjQ+zcqV/BNotXBWEmZ/6/c3MlVQG+Ej5d/w86PlGcqEg
 449y/yDGHPdZikmXt+JdDzZbpkouSNlQ0RX4vF/i+E+ROPehSQInnVW9U+uNp5ffosDu
 ZQ0+vVLbWv0PPPXEizRBdbfQNHtI1p1FMtn7j+yWlBy+CRWdVC6DhIQ3wreHuLxzZSG4
 g7s+6ePwm4OqiQaGIJYzNYiTL5E3wUR2cB8tkdvVMC67i7iYVTvAc69jHofhMEivBljA
 zgoFd/pKyRFUB5Sny+zWWMwrJK1iv7vAqNBJX64WTfW7z5E6x6He/0GUyLT2XgpsZ+t7
 3VyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGG9v54AFufHRFDQsHfxgn5Qe4DdPOmXaT0hmKiZ5e9Kp9pPtVNc/liVEYWtrXKRJm9M+nukFjQq3R@nongnu.org
X-Gm-Message-State: AOJu0YytbVj6tCDZFTUZyfWr1t3epNG2dQZmjWVgUC9MNgb+7biJ+wQM
 bNUx3Mt9Idxtdbg7mANCJgNQ1lygMH55Um9CPnV9pn44iCc2Wb6pZDb1DX/NBe4YA9Pshunm+YS
 ebWTBFzAD3IB6MLISuDcc0WbY6P8NHsY=
X-Gm-Gg: AZuq6aLrPMY83WVfotSawfhhNPfz/pmQg69jWwuNexu10n3fvJRt+qdpJKIuV7vylyJ
 AsE6zGuSly7qGbShijQ3LhWN0Rh0rnn9LcZgtm/PNameT6KH4cUygnjnAr1YaNvvDsP4Cvkd0QN
 KHFLHrCH1x6ILsxjnWnUvoqKxabCjICwW25v2x4RiwaD2mQlzhXfXZjjg/dzaJHBlKvK5xGIkiU
 cAo1KdR3jUS2+XedFKV+HootLMrSI2AoD1M05sV+HKXUYrgRMnHoz/lFsrUQSQuyfIpFq8WufP9
 p4QGqmE95/WHjBvHdhKHManOoX3VuKSMThuqmsU=
X-Received: by 2002:a05:622a:206:b0:506:70e:96fe with SMTP id
 d75a77b69052e-50681036651mr36318451cf.18.1770809612687; Wed, 11 Feb 2026
 03:33:32 -0800 (PST)
MIME-Version: 1.0
References: <20260201173633.413934-1-vsementsov@yandex-team.ru>
In-Reply-To: <20260201173633.413934-1-vsementsov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 11 Feb 2026 15:33:20 +0400
X-Gm-Features: AZwV_QjylWZQnHyhVqTNyuOqvpUTXmxg8paY6V7Ujm1xUdwyEG_ERClLKhz8nIQ
Message-ID: <CAJ+F1CKiEn624oxst3pKrC7KF64vU6eZ1+ztgWaLd=Pxk3160g@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] char: add option to inject timestamps into logfile
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, 
 berrange@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru, 
 qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
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

Hi

On Sun, Feb 1, 2026 at 9:38=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Hi all!
>
> The ability to correlate the QEMU log and the guest log can be useful
> for investigating problems. So, I suggest an option to inject timestimps
> into logfile while writing it.
>
> v3:
> 02: fix s/Returns/Return, add r-b by Markus
>
> Vladimir Sementsov-Ogievskiy (3):
>   char: qemu_chr_write_log() use qemu_write_full()
>   error-report: make real_time_iso8601() public
>   chardev: add logtimestamp option
>
>  chardev/char.c              | 73 +++++++++++++++++++++++++++++--------
>  include/chardev/char.h      |  2 +
>  include/qemu/error-report.h |  6 +++
>  qapi/char.json              |  6 ++-
>  util/error-report.c         |  3 +-
>  5 files changed, 71 insertions(+), 19 deletions(-)
>
> --
> 2.52.0
>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--
Marc-Andr=C3=A9 Lureau

