Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABDCC5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 21:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtXJ0-000069-1u; Mon, 10 Aug 2026 17:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wtXIr-0008UM-TB
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:13:03 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wtXIp-0005M7-KD
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 17:13:01 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-51c928bf172so15571441cf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 14:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786396378; cv=none;
 d=google.com; s=arc-20260327;
 b=dVhUBDdZFcECxKgo7jZn8i4lAE/th4FKUVnHUy3ztWkxdbJk4MtkTfiq6yvLrv0y9x
 ozL8/NNhbZsY/FwK04avLMoPFTnTgDhikYGaExsth8gAHFqS+1Q+eCei3ZxHD4oukI0F
 A2fpBHzue3eTlOoo64M2gNRMAOAVCiPZBDXzvxG0WzqE00RrZZLZju4Rqm8XGYn3hgub
 2val6C1H26kV4khHtcTKYQtfwpSbk2RhXAR9ZdiBl/sEIpVAQoFAdkSdRe0/Nq1mnhjl
 LzRkzNTP7KLVB1VoTERkIZHhNJZ2Pysb6p4lAXfe4uCEDBFGUC62hFk/tbiMMo86cmwp
 07eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8rb7mcmgz2NloesB3CUAU15K7LfiXfnLUABNUwSnRkg=;
 fh=zAf9Wul48xkTrIs6bAeEfpaQhknOU2iSq1CvwgfZtyM=;
 b=OwbuULDULKMJAGeKWNHwAO3LmyFxSzl/llRA19HJTPCySS8rtTXCxeTLY8svT33sk2
 rmmpqKS8kApE0O6jpCboU9rRacLo1hYrvD9k17dI97nPnIuWkjH4Pv2MpEkyWcfSLkFe
 aya4CdLI15/JbU0rojLx545qxfzXJVDTF6WOB8fArWln05CKVWEAZDO4HwzvD9ZV0qeb
 i2AmV9T9i5Uyn9TQhCyCpktLixUMST+sf96igiuDCzNC2X2dUHDSv2OGh1AYaefIBdtO
 Q9sTnlHrKHZHpuZosJtYO/d7eFXEul9ktFyp9pjFoFzOS8DQU2dozIo3+65McffoVmaS
 qpBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786396378; x=1787001178; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8rb7mcmgz2NloesB3CUAU15K7LfiXfnLUABNUwSnRkg=;
 b=iQvYvoL038HjwPG4Nk9fiD2L2pqx5Xj6uRG3lU7/WoTSwKdE6iVkS4jBbmx0o5aWrc
 LPTMxst99WZf2kLlRI8pnI7H9vylX5gvo76wWyJnc3ArHdV4bhw8AEm6+Kg1X0ISxR47
 NX7HcpMDfqBuFqxMZ8yN0I9me3pWBacSemwQzhSRb+GQvB0nJUT65aDSz2EB5s8W4/sb
 38nR9DLX0pz8FuDryZTISl2yTnO9snb4kALfoL18eEZ7TXWIj3G5M2859fQqyZLQ9ZMP
 cxUojXzALq3y2LxIyunIx1MYp8isha0qdnPIEkDjLWIGDCPsiiDZhe6zI8X3FVYBciEG
 eqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786396378; x=1787001178;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8rb7mcmgz2NloesB3CUAU15K7LfiXfnLUABNUwSnRkg=;
 b=m6whMkY8DSiWNX234vdFTNaRaFjro/FTG79i4YMFQctWlWrNXSdvZnsvZ9gWSHiGD+
 FZdlJkEH9L7wQSx3DEKHutUfDlo/v7iSzler6k2pq5lKrqOX0qCfCQ8woRkqxBojuZTG
 UaDQSwg4/Zli4zPAHU76neYLVHXjgWg3I19492l64ZdxXha7rIpfEMnoWuobwDkIckAx
 hOrRk5GH9zCimyhroiWg1IyvWB1fu6arG3tB66yOJH+qKYc58b0lwPrjI/ByienUd4MS
 HzV00vZZ1g+Al+3ftjPE8e7uLk58XWBjGWCnvmKji+SDJBGJ/iagQ4XojQpZVWM+KXTz
 NSYA==
X-Gm-Message-State: AOJu0Yya8eRokvte8AyJHWwYVmaWxPy8UOLHrzm2mU4cuq+ehYExq9Af
 /CN+FG7BzF9lbep6gkqwxn7PGVwdS2ofE5Kb60brzSWry8qoCU1c3ijpgKN9xXky+gnbbpvuWm1
 +zTMyGJ96ccxgiOPa/iLrKXIgYX8MfFc=
X-Gm-Gg: AR+sD12FPrfX3eD+HyGiyiejsEGRPbku147GeNc2NKM8f/1Ol3oEtJLq027M+IFyXha
 6qZjjTOUq5Yp9ze9BVBxkmVpbGt+KFNjaPfo91IW4xIXd0Suxq/FcdRu+nFLB0OIH7ZHLgZzCbJ
 XkgDb9rHQq4TCo0/uTAhqFDTYfVD2c0NuefoZZaghsTdiUhk5dxXLVUn7647f3rIXC3jZQpoxF9
 XIiTM4rVh8MQTIMqSKQWsAA63/nM5e994ag2cmNLtpgfseY1Exyaq5aXwXgWMZZISH9UIE8ORBr
 UBrSRlXJhB6l1kyuUem+zWnvarZqugDGL0nIVIpDdJfOuFVEy04lwZV3DTdH59quZTC/H1Bq/UU
 taA==
X-Received: by 2002:a05:622a:614:b0:528:3b9b:4f55 with SMTP id
 d75a77b69052e-52ce5f619f8mr466338621cf.6.1786396378418; Mon, 10 Aug 2026
 14:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-12-6b97c439eb28@gmail.com>
 <a0580312-28d3-4cac-82d3-20b211b7038a@rsg.ci.i.u-tokyo.ac.jp>
 <CA+spn3q7z8aPzLPMr1RtSzni4mM_16G=zGKytqC741iHE=dQkA@mail.gmail.com>
In-Reply-To: <CA+spn3q7z8aPzLPMr1RtSzni4mM_16G=zGKytqC741iHE=dQkA@mail.gmail.com>
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 10 Aug 2026 14:12:47 -0700
X-Gm-Features: AUfX_mx6rTanfPWvC6lR4aqwha51vytwdcQIBjN5UmvHYAunn8xg4ezcJ-_lA0g
Message-ID: <CA+spn3q8uPsn901CoKrhq3xO1X5DVc_KCBYpjz5vRTry=W2-Bw@mail.gmail.com>
Subject: Re: [PATCH RFC 12/15] hw/virtio/vhost-user: send isolation regions to
 device
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x832.google.com
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

On Mon, Aug 10, 2026 at 10:40=E2=80=AFAM Connor Kite <connorkite@gmail.com>=
 wrote:
>
> > >       int fds[VHOST_MEMORY_BASELINE_NREGIONS];
> >
> > This needs one more element for vring.
> >
>
> Good catch.  Fixed!
>

Actually, I'm not sure I can add an element here since the size of
VhostUserPayload.memory.regions is defined as fixed to
VHOST_MEMORY_BASELINE_NREGIONS, which is 8.  It seems
plausible that if this is a standard expected size, that adding another
region could violate some assumption in the back-end implementation.
However, I should be able to avoid the issue by combining the vring region
with one adjacent in the IOVA space when sending to the back-end.

