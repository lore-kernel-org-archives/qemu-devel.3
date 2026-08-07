Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7B2C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 19:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsQZn-0003Ly-FV; Fri, 07 Aug 2026 15:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wsQZf-0003JF-F7
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 15:49:47 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wsQZe-0004OP-2X
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 15:49:47 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-51bfe810293so20156641cf.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 12:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786132185; cv=none;
 d=google.com; s=arc-20260327;
 b=d7XHeCveW5aCBpHt4qfQpoKN2aY1sRznPnibCxgRZauyLJh0XEUvBsYNDMp5CaKwv7
 fxA8vZdCKSFvWxjzU+IPzYq0/VTJHlMdOMmxaDjdd/+KZhsAOmH1bLsexGRmyUJzVTxb
 clTxno9T/xP2HlF7+ksPGRFxLxOXhnUN+N3368HvaePCmy+VpB3Io46b9kLafItI9cFd
 ClA6cWZAbxoNhHjkw3Dht4v4PeZ6T1zzNlG2OV70tc6bYvMcC3MavSuTKZfgJN0Jw1zs
 a0aNXI6XhqirKHaO+3QLJjd/zaT8AGEBjlAuA8Q8uUcUY/e1PiFSesJ892bKPE94dnTk
 /htw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oa2+1M11/amWz20nSf71eFbs+AKd7wmkPXqSWC+J0Nw=;
 fh=azakwI4Xb9f6DnAcztET+ugSHXzSSw4voANLU4fk32Q=;
 b=IZz4wh/pE5pdfhgI8nrb+6isjUU6v/+hsu3Ko3jfytAfgqHinlOQr8ZdYsPOJEGiga
 zmABGIfwvGAnMzJeufsZHpHypX88ni9OZCnVK4awLp32ou2mE6t1QKu8znlfAnUWk4c8
 xJDuVynMbfIThsdb6y80u5952+HML+MMLcACdcMvI4LahjUdVbK0Xy6WKUCq1sP7R06V
 ccH7LKWJDLd/sv/nkkQVSb8dWbw+8j6kBcwuwSc1GUhVt04J4u5DIz6cKWtGSLKrUWRC
 3jta6ubfDFpVzI2uy1Rmv64JZ5mHhxoUdffz+78GRp75GN0Jm0jPhH+i+A6ufL3ApyIT
 tKIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786132185; x=1786736985; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oa2+1M11/amWz20nSf71eFbs+AKd7wmkPXqSWC+J0Nw=;
 b=cX7Qkkds13h81LDE+u/ZEvqGD5V/zn6Ww1YyHxE6S1Cd3XK14rmd620YH8sOpoVvTv
 0GWIsJlgX/1T3kEfqDN3kRCgw+mDX2F50bpkYK0m8qXEh+6i9abZfOvarqk1qVTKzdcB
 yqqJWJweKCGUr2tIkCTQRnBBVdv6ZqtoXRd4XBfhErreESmUCjm4CBxA9Kp7CQh7cZIv
 Z0QID/cZbTpbh9JI8A90mjmdorOlgw7ThPg5/izOLqqvfV7g6Hzeo85+44GfWUqJroRE
 FnOvlFquy3xjcS/hGWti0k+/N287yiGDDbKmaqxVYMTqiYYKa5TXcP21EJhLY3Z9d0C1
 f9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786132185; x=1786736985;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oa2+1M11/amWz20nSf71eFbs+AKd7wmkPXqSWC+J0Nw=;
 b=gOyQP7XZX6F4JasW8FZAbpGHQb8+pubmTLT9tg9QQVVXVsN8UgpZu8BCu/Gk9FHvEM
 W0OVAsKjf3jkk1ELUGMSceA7ESYiQCj+ShmqjnR3ytLZnMoAi1xSyjbuocbpIttjmPWJ
 oy9t1fzwYdVHAid8BmdXdoa8n4cFUdojuRoRz1IHPVXZgfBjZ1LNkJaBNAkHWDMfW/G1
 uUs4nJLMDQ0e0e8Shfq0qubuXILyLex4rMTGog2L/jgRqljIdQteQag9rkl+d8OveUOl
 exzjAKmoBBYCTvC7i5YR5pvlrUSS+ZGFyOju2NHaffwTytHkXhRLDoFpns9k8PHCPu87
 KihA==
X-Gm-Message-State: AOJu0YxE+RxAlcXC3/jEUMsGvd7xhg4QpYKEpKAsgikijJ+ScYb4w6/X
 Bf1lKy9nI/HaMiU3lVSZ0NVpLrsoxYU+YvDrXWXYxQHsoAaExAfThlgxSzJEFaHDXb789PH64mu
 YmlNnkyitgFC0+EObypR16Y8FlTKjw7o=
X-Gm-Gg: AR+sD11qAqYqj1Yt4ecfjo5OPzARsyXiuVGEI0pcC7ds24PliSgmIgnGMFxk6qHr3mN
 d3u3seIZVeYF0tMsc4+JzI2LiopMZpbYABcslBpSJ7YTnm12pjU+QSI5mZrFXsAHj2H7cojQaaS
 YzfbmVzM7/NK6Nc0MVjwPqmSrEtGiJdrIdJjn8VtslUCRRGILlG+1478aJwdSWkoy3IeowVxaJc
 JYbs81p+aYC67d2bF1OS2kvVOWBUw9JvBuF7Vsvu5rWAa2Ni0PPsQU//LE89NoVEWBF98/PeiSW
 tgGgUIgdmfw/i34dkE2ojanYmdYCzDbahaQfefL+nQ6weyEPauuqvDoHSWLTzj5UCHKG0rUOT5R
 egVnI2VduJE4PPQ==
X-Received: by 2002:ac8:6542:0:b0:528:f72:a986 with SMTP id
 d75a77b69052e-52d20aa158amr42855501cf.44.1786132185015; Fri, 07 Aug 2026
 12:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-9-6b97c439eb28@gmail.com>
 <3fa5a8c6-a803-4b28-a45c-26a71dd99b7d@redhat.com>
In-Reply-To: <3fa5a8c6-a803-4b28-a45c-26a71dd99b7d@redhat.com>
From: Connor Kite <connorkite@gmail.com>
Date: Fri, 7 Aug 2026 12:49:31 -0700
X-Gm-Features: AUfX_my2rO0hUcLEmIPzvmjdKfkHE3vbYKhjrn3aDfg0wC4qV_6jHYQibz9VYjs
Message-ID: <CA+spn3ocMhWx_0wK_b0oNGxphnBw3gJQqYd9XR9D3Bq3bETKFQ@mail.gmail.com>
Subject: Re: [PATCH RFC 09/15] hw/virtio/vhost-shadow-virtqueue: specified
 vring placement
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>, 
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
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Aug 3, 2026 at 5:48=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> w=
rote:
>
> On 24.07.26 00:30, Connor Kite wrote:
> > By default svq vrings are placed in an anonymous memory map. As svqs
> > will be leveraged to enable memory isolation in vhost-user, it is usefu=
l
> > to be able to place the vrings in a shared isolation memory region.
> >
> > Adds the option to specify vring placement by providing a vring base
> > address before starting the svq.
> >
> > Signed-off-by: Connor Kite <connorkite@gmail.com>
> > ---
> >   hw/virtio/vhost-shadow-virtqueue.c | 22 +++++++++++++++-------
> >   hw/virtio/vhost-shadow-virtqueue.h |  3 +++
> >   2 files changed, 18 insertions(+), 7 deletions(-)
>
> I would go beyond Stefan and say that I do really ask for explicit
> bounds checking on the area.
>
> Besides that, `vhost_svq_stop()` still always calls `munmap()` on `desc`
> and `used` and that must absolutely not be done in case a fixed location
> was provided.
>
> Also, it would be nicer to have a function to set the base address
> instead of having to modify the svq object directly.
>
> Hanna

Got it!  I now check that the last address in the vring area is not
less than the
first address.  vhost_svq_start now returns an int so that success/error ca=
n be
communicated to the caller.

I just moved some existing changes to vhost_svq_stop forward to this patch =
to
just memset the vring area to 0 if static location is used and vring
pointers are not
null.

vhost_svq_set_base_addr has been added in to remove direct adjustment to th=
e svq
base address.

Best,
Connor

