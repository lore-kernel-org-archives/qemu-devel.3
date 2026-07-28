Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83E8C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woj9S-00084o-Lp; Tue, 28 Jul 2026 10:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1woj90-0007t9-Vi
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:51:00 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1woj8v-0002oG-Ku
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:50:57 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-5218927884fso41716521cf.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785250251; cv=none;
 d=google.com; s=arc-20260327;
 b=P4BOuyJHoXzIRBZ77BzKtKk72dfOx6uVNfMRiGRON+3o4BQp03GoRg4WNM2uTFZye1
 bOWuyRlMJxaBIvuhVxsmoi6CrFsI+9VNntHu/XBmTxDGTnxL6R30YkR/KMdInN6FtFLq
 IgluVEgPhSlw/PScUjNL28M3F7mXbaxFCXhDKoG5dpjYojONMZpFkBv4UGamcnoNlRjX
 cVlrBhUwnp24JM0rP8AOPJnD3cZjMe3Ti8SXp7r6NgzCOzd2vxGEo7n3miIy9rrNNyQg
 irRYXQhNH2anCUeWwA3Z+uPcemjas3OTxsDHcoZK6uAR4NT/9szQpTS1WMpCNE7IxUi4
 yj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8V82S70hOOVVM3hCCAMIvqx2miKyqpXj+SGwb2HfEt8=;
 fh=AkOt2fq4GIRXClWkmlySLREFOatt5xHcmdf+pzltvjs=;
 b=XuvgmR6/0wNnEyn2UGbaoK0mBVH/8kP0o/PBmbYerVlBr7NsQm+8XACC6iPGF09zUM
 5s7VNfNLMGYyRNS3maT/abzuT6dccoihOKoXVHAWGzNL1Bv6hnCNmRcAw1+0JtRPbjM5
 39pRq94E1WrqGRg2ml2x4rPdRkgyTOwCHeBY6+Yumy6onBhRT0iGCdzP82glFJ5i3E4b
 neoiYk4DWA+HfKMEdGoMY3nmNjIG3AOt9nOJwaV+833pAABKbQax6YPD7mgopiE0r3vl
 oqlCuKk/+q99lcj9zlX2jgQEmfoIfuadb/oBNAL8L+cRBUU7QE0BkJmYQcAPywEzGeyM
 K4+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785250251; x=1785855051; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8V82S70hOOVVM3hCCAMIvqx2miKyqpXj+SGwb2HfEt8=;
 b=G7tUxSdVM5GzUtHBvuNkbymB67D7UEOkNtoXQ6OOjY5Bm4J+nozZfWHS//58738c2y
 /+IguIG+OUz0QH6PfqYdspDbFcF2+TC0xvofVI7Wnul4f1usSaXO8+HAH9ddJMM8+bkF
 brOsF8A5HUyIoyPWaGoSXbgyh8rFM4cIJMlgYtykG1/Z8Hb2Pn8LE2zUYizRfAUDS7Wv
 CKjVMRRr0o0xgdPmSU+6KHGb4v5iJZihb/R0EOkipGxTnFqSSOPk/mPnKsL39y8NFJAN
 HyCTH8qXov9assAWr/XlYjaM0hVZwVNWN9sL244o+IblZOhaCQdPz2S9nY3i5zQo2qFg
 aa6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785250251; x=1785855051;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8V82S70hOOVVM3hCCAMIvqx2miKyqpXj+SGwb2HfEt8=;
 b=dQQxfdmgZkKcBmdnLrvV2DnIUIXQi+pnVFAnGa+LVVpyPZqFszFzwagL1pXuJTGkjG
 hnvW2pey82+anliEzgYToZdf9IX7VhdCadG/8MSQhNZNkrLnST+MKRd5tNKDdcWJ6pi4
 t+KHq8nxcOwQ1z6vTwvzZFeFDzWOfaEXox0vQcRqwBZPqPNlQZskxn03Jh4aFEoXfK05
 jVqiWxcpz8wnO38PP1WkR4Zvl1MU6LRcOqU3Z2mGlzqmYL6QlrLIP0Wq/wBLPd5lbth7
 Q7cF4duK87A8G7VEzTynq8xr+vUlFgyR5KPLt+dJUUPSKHZql5dBcTtQ1gTVQGYLOBEZ
 7w3g==
X-Gm-Message-State: AOJu0YxwH2BOJWPXgTYhj9LvF+A2rjiPbkIWoQjkcp2q2eUYZtvuHPzH
 Bk7+H7RTlYt02dva1rRdV9pd5CyMkz5rTU/6VeE61pHTkG2eCJzz3RmA9fyzzpwXaMo3BTUowjb
 2X2MvH426QxdosAwyXIDVir33N/+ccTw=
X-Gm-Gg: AR+sD13j4HrMiWn0ue3QvM01d2qV/lLHPtvJtn9NuQZPrYxV3M2upmBL0kLdgnuMggd
 BlKK2HqK6du1WWAU0Nc4Tw+S3sPoYSUPdNmnQS0/lI/p4qbps6BcwRpSNDrSRu1xS7Wum7kbbvF
 5PzmHHFcOfb+q81OcAYx17RSZQSWKwGPsKWMK3XSWHO1zlkmRJ/E67IoVq7HDEAWAngOByqu/bg
 awBghmtcXojoz/re4+IxBpV2XwKD745GF+wJwX6PZ/awQUar/vzcsCX5VD7EA7uRhVrEOLdongm
 xG64qb3E7jqLnIcBq0Q=
X-Received: by 2002:a05:622a:8ce:b0:51a:8c86:bd4a with SMTP id
 d75a77b69052e-529d714ba9fmr28796611cf.71.1785250251043; Tue, 28 Jul 2026
 07:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <905f74aa-8367-4843-915a-8817b3d236b1@gmail.com>
In-Reply-To: <905f74aa-8367-4843-915a-8817b3d236b1@gmail.com>
From: Connor Kite <connorkite@gmail.com>
Date: Tue, 28 Jul 2026 07:50:39 -0700
X-Gm-Features: AUfX_mzzxYt661ys1X2DW_QadGUCq94mbsDtuWfpra2rKx2_1jRG39Gj9jKKP2A
Message-ID: <CA+spn3p519J-ZPFUiiHZYy05n6p=8Eu-sgvkAQJYBcg=WvOXMg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/15] vhost-user: isolated memory
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 28, 2026 at 12:08=E2=80=AFAM Demi Marie Obenour
<demiobenour@gmail.com> wrote:
> Does this approach work for a generic vhost-user device, as opposed to
> one that knows it is a block/network/etc device?  Also, how much overhead
> is there compared to the normal case?

The idea is for this approach to be agnostic to the specific device in use.

As noted on the cover letter, I am still working through some rough edges o=
n
the implementation still, but when the project is more stable, I will be
benchmarking the effects of memory isolation on performance.

