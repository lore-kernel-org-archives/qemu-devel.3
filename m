Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83168C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1womUG-0003Kc-Qi; Tue, 28 Jul 2026 14:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1womUF-0003I3-JV
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 14:25:07 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1womUE-0005V5-3r
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 14:25:07 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-51c0ecfaee7so1202821cf.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 11:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785263105; cv=none;
 d=google.com; s=arc-20260327;
 b=FiRAQOshfmiJRjHDKQiyj7BsxXjrNitTInk2JbLVXqsyHJU75vvgh+PE666RmWdKYd
 9bFI5CAWEMDLvwUI4Sg2eIHj0WFhUYnrjdNZQNwpLC96oztVEzHFp+efMZZFJ/JBrxZF
 gkJX5M6J8NfFmnTwnfpbZNEaAtYIa9ZoDpPKCjhV8PT2qwdOPCRvxZnyQe8Gq1+PbgCY
 GlLLOkh1/Na/bYQRE348lvwWknBL6Sve3KUHipHfitDZ4f8Hsr5iXOtCTQOAv1Z5iq2f
 hI3OjzjEjR+NKvz9U7WaJQ+1ZU8XfsOE7WUW7oS8x7gdT0T2IOlSAiMh6TPIQGJqCsSw
 Lu6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yw/O6SQwJLjpZ7378AMJ71CoM2jdC0JRf6nC/TAnmgE=;
 fh=KDk387A1+PRrP73gRLCRtBl8PbehjOWW2KJG+BrFQO4=;
 b=IThf0DgMbtkSdaNqM3hpVKF20x5gY7fZ4iwTTlsP+In6PjnLDnSfKOcFKnmVOrKYNN
 0iDnXpt/V6i3MbhztZvd4leTBwCUV98Jq8Nc07km7DA8S+LIWyAIa5BfNjteIzW/Wdwj
 I4NCeoQH7NLXwaCqE2m6HvLxP70fLXbSbWBIeGQbOUemWiZe/Vo+ztQOO5yOE+zXCEYY
 dI2vGKIGZFOg7s8Gfo2tBCRQRxZonlMm7tvEU7pxrhi59zvK2QSwMphqYr8Xuh6bDf0n
 zs4ohyiGFVLKeS6tQVye/i2aZjyc346g7jLt1f8961p7UDKmFP8m59py74SXwJkmW56Y
 7RyA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785263105; x=1785867905; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yw/O6SQwJLjpZ7378AMJ71CoM2jdC0JRf6nC/TAnmgE=;
 b=RP1iOdpPisupQQQ678TSNPiWJkakZx0OTmy5dJSOC1VYTv4z+GzFqeh/rNVQARRKxh
 KFKh1+7DBBk3R7tJns+CT9xP8ohRfbOHMJQnITlauGq1eZxZti/RPkT7HMJEsLQoPp/U
 KC+SLblSR8S8uXDdJkZzHyKnJqg6Rc0T1/aJ+ApSrHc4becWtTP/aJPAuqpDztf6OzPz
 9K4L5Fruay1sZgepHcc6D6FCMfYC4l5TN4hvSvd39Hn9HfHYbZ7takjviOUTFyqZnb+W
 5Zl034NOyOMkSm44rCHzwMyQ9NZmr4uJlk1HxdZqTSd5IULwiouEADk6FuI6+FxG+ekM
 JDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785263105; x=1785867905;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yw/O6SQwJLjpZ7378AMJ71CoM2jdC0JRf6nC/TAnmgE=;
 b=Sj5XIi/ybB2Mg/GK1mKGnIoOJvXHK8+PZvC73g9+mO+nwklRWZy1qJeSQy9RV76vrt
 XNVgbCBQ248cQUSbwAb3MamwVq69kQewOFVGVAIkpIlADH6VR+uYMIdPKHdqVGbn/ApI
 OHZ3AN7zIpC4zpDcrMulpBdrul+m7KbEYyLScLb4rbD/j+8sGC4jejMnSWi/v5zVoqjr
 qB+Gn5UJNvxNu03yi2sDCw0GU6UJLSCI6/CglTZL5H1tiPY8KMw1c/q0upGoXnyh6hPA
 Ks4OQt+nkAvo+6rSMkfsHRsbY5XNbCMFUIgWPUjYMZlyS8t7UJNJq12yLSsOViWTx/Tp
 8SDw==
X-Gm-Message-State: AOJu0Yy41PLdEbk0sW+LQgyhBkZtdUZQlFuUp58KJ0ZGINFVWlkSQKUq
 QnCDIdGBCtwh9+SucFUj2CXcN+TUrMj9t4a/7XPEdR8SDpAr4bJuMTOCFA5T1LZ0V0bStcUnxiG
 tEmxeKcsfHeAMpNcxzklWjuI2/n1NCBw=
X-Gm-Gg: AR+sD13iws9KKMPT31KSkz8j9GIMdXtnRc3vl1ektU56jpd6lS8cvngfjAAT6BnbyTk
 7ifMZzxtpyQiGwKP9iPYUvLIPwBQf/5nKRseXT3T7nUfqFQ6+SArPKaMmQPWVhu1ZhF82B6Fw+6
 7rcwEC8HJAS1pWTUp6xTc5x4zw2ubvntJ4KCIwilouAQp1UAYzNb/VTvHFK6ySuDIvH3Dscb2s3
 nsWDt9VdTxZ60ijmrbfBji4AZ81U9wCZB4tlz4uj4bKBFacXGFSJZoNPobBA0Yo8sBOIR9yxEQl
 xZ+DZjXiYk0IHQ10Mvkk
X-Received: by 2002:ac8:5913:0:b0:51c:857f:9c12 with SMTP id
 d75a77b69052e-529d6f9df1fmr34798741cf.4.1785263104714; Tue, 28 Jul 2026
 11:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-6-6b97c439eb28@gmail.com>
 <20260727190757.GE371693@fedora>
In-Reply-To: <20260727190757.GE371693@fedora>
From: Connor Kite <connorkite@gmail.com>
Date: Tue, 28 Jul 2026 11:24:52 -0700
X-Gm-Features: AUfX_mxdl45Zem6osR1ajKoHrgb8A0mkuybo1B5FEZIrW6w-mTKndp87VL8pkVw
Message-ID: <CA+spn3pPNuAL=6qAfN7CGXnitoudv_JD+HUna+4cU--c_qoN4g@mail.gmail.com>
Subject: Re: [PATCH RFC 06/15] util/iova-tree: g_tree_foreach wrapper
To: Stefan Hajnoczi <stefanha@redhat.com>
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
 Milan Zamazal <mzamazal@redhat.com>,
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x832.google.com
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

On Mon, Jul 27, 2026 at 12:08=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Thu, Jul 23, 2026 at 03:30:05PM -0700, Connor Kite wrote:
> > Add a wrapper to iova-tree to call g_tree_foreach.  Provies a means to
>
> Provies -> Provides
>
> > execute some function on each node of the iova-tree.
> >
> > Signed-off-by: Connor Kite <connorkite@gmail.com>
> > ---
> >  include/qemu/iova-tree.h | 13 +++++++++++++
> >  util/iova-tree.c         |  5 +++++
> >  2 files changed, 18 insertions(+)
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

This is fixed on my end now and will be included in the next rev of the ser=
ies.

Thanks,
Connor

