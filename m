Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19629C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1womZx-0004e4-EI; Tue, 28 Jul 2026 14:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1womZt-0004dD-Np
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 14:30:57 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1womZq-0006cp-C5
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 14:30:56 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-51c01089e8aso1099461cf.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 11:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785263453; cv=none;
 d=google.com; s=arc-20260327;
 b=feGKadu5qV2L6/1V/epsSANrnqmetsTJkuxagLbOn6hvEotgOXXoU8r2jCj3/OpaxA
 DePn+rJ8PHFk5F6S48U/5Ik7G9uv7w51irqsxbEqW4VjO6K3cx27aLiWi3CydDBavyoc
 c4Fsr+05ba3xoXdWjDSPtv3psIKBq9WjRNiCMl2cAf5GGyDpKOOXBUu3w/FlhN6dmDyK
 w3w+oO808H+NZaM6h2o73rxiU8Q6IMnQuww3CTd+tTUlZ41hrdzojBvYKTxP+gqyYVZk
 o0cH35hDV5i/SPAVZr79IldGTxF/ab+gUte4Q3+kCqIDGwwAMlnXjcfW/WBAWo/peB4U
 Vkew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L4hFpOdjenD5OV2dCOq+Wa8hv0asqxCOzVyOz5Gf4CQ=;
 fh=zAf9Wul48xkTrIs6bAeEfpaQhknOU2iSq1CvwgfZtyM=;
 b=kfP92VwEDRjR1T6iRy6HVqXCFFaUEh+zI6k6BsYsk+8pyoLZ8yt/1pSxaYocnVOEC5
 SIdgIRUVoEUMBIM3OSGF64sBKsd1okfUl81BtbZ0eRkevIWBvHuNptkWe+jekgw6NtxY
 yI9kkgBtQoIe/9ecQFJb7dWcNwyWsw7ln/eXZOmYBkXogFsi/+07Ieio5YrLt8ig6tXt
 QD+yzU2eJOm6RpNcm7mgd/hfEt8PNKYl30hDxD8PCwUTBMpd+HrL8fFUenkkz1y5OZ/d
 Qh6v8Qa3DbTRtmyCL0C3QIB4HGizKWeAPRNVHT5KQu0NaVMJau/QhoGpra98AgjqbsUQ
 3o/g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785263453; x=1785868253; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L4hFpOdjenD5OV2dCOq+Wa8hv0asqxCOzVyOz5Gf4CQ=;
 b=jVPdKh1DgW1EiLq4WCAAIjlSV4Cpuin7Ov6KSs3/6svk/icoHpirubKLXW39M6HV18
 PBRui3G0c7UWhz7spvBBbQT2XBRz67IzUTC+rZ3vNwv81Jzt83LJF4BmR1Y+oEYazgFF
 raF4SFrlbI8py4QC16ASWaJ6Fbklgoy6eYCIRsFGquK1xm8hSI3uBrJcgN9BgHGbdlD5
 pt+a9rSlzGogVMJQdtD4sWJFj67ZAv6TmxPv1jI8ErrvDoj1+/qykqob8peeM7zP/Ts5
 OAwnSZi59/E/CSyF5YHkCm9ArrH63azTqhUl64vygOubx3AwRJV8DGECFNX3H73p3pBe
 v3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785263453; x=1785868253;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L4hFpOdjenD5OV2dCOq+Wa8hv0asqxCOzVyOz5Gf4CQ=;
 b=NZQS1nr4Li5DHrkp5I8ZLRZJEhxi6BdFb/bSbkEOG0bgwqFmlwodxWS2OUoIh5Gj1i
 RxFagEXXJk/0RbFjWzJhZuIT4dWDP+98jvRBM1K/mdmoIJ+6rnN4mSqCc7VUIfMQfp2T
 9xm7g1cjfOsgBVsALiVXQxZblrJEkQaZeEG51ZIUFtN9kpiETJEdeDKJX53qaBI8wDXH
 Fsx7ieoJ4DqSMveHAfSjDLV2wKar7cq1vJs8rd4SQMerkxvM7/aa+7U1pn+LAmjFYmu0
 HFfeoB1nvt3epkYhnhGPF6Sv+Y5h3zC7CF2HxB1CHT8EOKLB0Eix9NplEgy8pgMzygfm
 sxHQ==
X-Gm-Message-State: AOJu0YweXUC3pqqZI7kitt89RRa6xoRNmGsgWDmk1x0t6mU1fCjjsEL9
 MGC+om+DqWX8SOe6kME8+3yrJvG3VppjWaPsoyVFyn983xkU9th5bfOuYFbgngu979GOZWdhxL5
 0Bj8wyQHG5NSi0BEMPNxigcrViSH5Its=
X-Gm-Gg: AR+sD11BOruHweduRfDOCpHTx5kv4R2NHy0Zfr0V8G4oVq/IgFTVpObDQGatx63EeY9
 uYQ6Pr0FaeB1sqzrvVj5niGFXGQuQNx2b7ntUKpvACWspOymU0z9zBCoGrRZo2zaoX1HWHHYZFk
 dGTNjpr6+Z/qUsSPnZ+6X4SblsV/X2isSUmYCfJFT0BxoPylRC2nIN7u0Nca+WSLFsL9fR45m0m
 mDnEzUzohiakZ+ppM1RPxW5H2TtAcNZXOgCJtpOs8IC2bwRLc7zJP03Bw9gt0fNgWHtTDcZIoeJ
 HdfQlNzAh6MlfycIwzTlufcXCf4MbBk=
X-Received: by 2002:a05:622a:5b04:b0:527:f0a:ccbc with SMTP id
 d75a77b69052e-529d70b6cb5mr32460691cf.18.1785263453238; Tue, 28 Jul 2026
 11:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-2-6b97c439eb28@gmail.com>
 <283bc630-2538-469b-a296-7da57d2e4c3a@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <283bc630-2538-469b-a296-7da57d2e4c3a@rsg.ci.i.u-tokyo.ac.jp>
From: Connor Kite <connorkite@gmail.com>
Date: Tue, 28 Jul 2026 11:30:41 -0700
X-Gm-Features: AUfX_mwW719DYHtdwo6QFm09jpiQQxLRyjTxCixfhvRfmX2uXr1nq7-HqPgd6Tg
Message-ID: <CA+spn3pModAB5vom-x16hLbnUhR0BbMqfk3aX7KK7RZ5SJ8jMg@mail.gmail.com>
Subject: Re: [PATCH RFC 02/15] vhost-user: Add memory-isolation qdev property
 to vhost-user devices
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x835.google.com
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

On Fri, Jul 24, 2026 at 3:57=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/07/24 7:30, ConKite wrote:
> > In support of future work to add a memory isolation mode to vhost-user =
devices, a
> > qdev property, "memory-isolation", is added to all vhost-user devices. =
This is
> > simply a bool representing whether the mode is active or not.
> >
> > Signed-off-by: Connor Kite <connorkite@gmail.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> This and the next patch add interfaces before implementation. Perhaps
> it's better reversed.

Agreed! I will move these for the next rev of the patch series.

Thanks,
Connor

