Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86790EF3716
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzVrr-0007GB-10; Mon, 09 Mar 2026 04:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vzVrn-0007FW-Bg
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:21:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vzVrl-0005BD-8H
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773044488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8T0RtAIhJ0hHNJwcLwaz0lJFPxxXH4rC7B6VgVljHbQ=;
 b=Yedxn9OG4WW0yGhRaM91yaZiRp+mLCusP5SDOFhxmngfy6oB86VE7u7B06p7hHgXBNAiX+
 f01KuRicNlcfgSH5dyrPcxOIq6jvjxYYVfP/Zlx2TV6ILQWJH10I3F+SOYvGGqbgNu9f8H
 rkdlpERkqbeWH1qRDtJCiqbn6alcJoA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-ANLH4TYYMdSPDDrgAFCO7A-1; Mon, 09 Mar 2026 04:21:26 -0400
X-MC-Unique: ANLH4TYYMdSPDDrgAFCO7A-1
X-Mimecast-MFC-AGG-ID: ANLH4TYYMdSPDDrgAFCO7A_1773044485
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c73b1376f98so4349361a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 01:21:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773044485; cv=none;
 d=google.com; s=arc-20240605;
 b=db+neoAXiVOT16yS2GRDIvBko5oCdfzvd1CVbEdHPA3CTDU2sIismyW75IoHoRxTII
 rDjrTn+EYAy6+JWX2gv/nAw66sibnciUD/Ca1BTOTQjd8ozI+bmQhrw0izUEDYyDn3WO
 DBz/6qqQzuxAzNenRTCDDvZ2CUBCNyk+G6ealKygukWiJYjsbQBZy5C2vwxyPBhEqpni
 ujLIwGWNf4k4QkveLLfGLuLoi6CZrvsOYCgN1X3/ABsa1H5D5dljcHVKnHqFQIdTj5eI
 szKs5DCKWAEsztNgGqMqC7d62EiS9WDdiqvVbgEpeC8ZPQ1KpJe686q3pYyn6EUi/L1U
 wRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8T0RtAIhJ0hHNJwcLwaz0lJFPxxXH4rC7B6VgVljHbQ=;
 fh=Txa+6SPXAXKqcVk+OZf52DYcGaDMV5zKqhyTdNzhO/4=;
 b=ZDBuS4RrRvn7LKTdflg33JqKTnHbiK2N/AmbEipdrc7dhs+IJFLJb7u8KyiGpzfNbT
 YbROrdEMzsLKIfqmHY5lYx9F7yPj6hBgT+y5x/hfP5Sj5TIkLdiVxUlobsMUS0924WxX
 L42QJVHmpuKWYJM3eDTMu4iNQSDCa8FhoLcnFMMxqzkjQJ83j29fM+6zrht5Keif9pUE
 ntoxcUR4Qs93Wub4vFiKMLFb5TEfzkCzgEPwxmXlXIYJepIlILoav37VnYeQrX7nnkvL
 GJZGIZOewKEDL8J1yQ292hhgbdhBdReBZrYhE/VM3tk6RwkU6P7gJ4yWKA1NITKoATM+
 psLw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773044485; x=1773649285; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8T0RtAIhJ0hHNJwcLwaz0lJFPxxXH4rC7B6VgVljHbQ=;
 b=OEm0DwBU9GIVfUr9J0vNB4m2NgYFFTGPh2PQ0jFwGLFlf7i7DefsvacnQYhnUWMx2X
 MVPxLTEGJq+eOxiV6vwNuSB1g7sFQauwZctd+SkFGYTCrEuAvHg2Y+Xg5keOd21SbQjI
 2RQiPrmiknmfL2krG9phCtzMQ+TBLVPxJtERQH0Vw9GVuO5xJTViHXshHElMc6/6I0cR
 9ZudA1CXafMKrklRe145yDuck493bt8f5jzE0cdezir5pViMqdRP314P/UCpDfmC19EN
 QwA5pzGuP8Cla9IkKBRlz1gGVFJquiLSVsR4VtKpeqcKI9FYVkFf0qumemTMeFkSpeXo
 MPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773044485; x=1773649285;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8T0RtAIhJ0hHNJwcLwaz0lJFPxxXH4rC7B6VgVljHbQ=;
 b=J7ncj/ckaAlilcaFQczuyMbnbUOMlaajGenZtd68dV7Ba7x+OIYHTgbCHR4LYJ4vgq
 GBXVhTPyk+2Mi27eHUDMilYCA1HziVvkD2fUdRgYM6n4CdUSYJzZ8WESUoQF7drICDUl
 wiHDx+CZOMmTIb3DujDHCkhdFcXJXDfPVIPFYWllnbsKzeXW6z0uRvs5/JOfpLHCMpel
 +M5dxN6Gr4kDH8YS+PHMoRkb0QS5LcVFPRuVXrPIdKT3OhQf7c+KCHcvZ+eRXyBrr+B9
 Bbvbeg3TcWxFPGhWZ3aEVA0pd4l2aDXScqSrto5QzeRrt5Hv5Kscw5mj0RKPXouKu3Kp
 BGLg==
X-Gm-Message-State: AOJu0Yyo+6d/fmSkTejBln0uBqeFvipC2YYlzcfHEgm/2H+M8G1SKj31
 ZFx9C0thh63IqcULjpwttFEGAv0JvM79fucZ1emzJC/nTXHfBFei03QNIGp89BemiISMcSp6Uqr
 NvmA3rAdmRssc9EgRNCqszs1s76WEn5BL0AXgpviei/ROrG+SVa6KIzOsCvUY6dI7uWGg2Kcv2Z
 fGvYh7j8TDNnJZSiGAsjBDDGGoWfz7zfQ=
X-Gm-Gg: ATEYQzwDJLW+QNXUCpjxbjBAj/BJls43iN6NOdAIfX6ZAbgPkob5zDxYkZQtVOskrd2
 Vr3bXhRoMZvCSAtF3ymaFMRy4PA2JKNKltTTNlu9jncOCWHqjzlbP66br1poCHEx3/OGzkh6qJC
 SqG9JAlZTQs+cXEOJjgBHKNcXip7cJoBC6803ozvgIwgsmMYq8gWa1pMmVDse0RtU3YjshRv8w8
 uEVd8rm
X-Received: by 2002:a05:6a00:2e1f:b0:827:17b7:58cf with SMTP id
 d2e1a72fcca58-829a2dc16famr9114997b3a.23.1773044485530; 
 Mon, 09 Mar 2026 01:21:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e1f:b0:827:17b7:58cf with SMTP id
 d2e1a72fcca58-829a2dc16famr9114977b3a.23.1773044485089; Mon, 09 Mar 2026
 01:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260304173857.2705296-1-eperezma@redhat.com>
In-Reply-To: <20260304173857.2705296-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 9 Mar 2026 16:21:13 +0800
X-Gm-Features: AaiRm50MtGIcCS5H0gQEKbKNfnbdbr_S9NIZ6-u-vAeUaPnGYc5H5-ABFFmYoQs
Message-ID: <CACGkMEuykEy3Rt_oEw1kGLbvh5ZRv-fW-GFU3SN7qNWcc8mi5Q@mail.gmail.com>
Subject: Re: [PATCH] net/vhost-vdpa: enable vqs before DRIVER_OK if no cvq
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Maxime Coquelin <mcoqueli@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 5, 2026 at 1:39=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
>
> VDUSE do not forward the enable message to the userland device at the
> moment, leaving the dataplane disabled.  As there is no functional
> difference if the device have no CVQ, enable them before DRIVER_OK in
> that case.
>
> For devices with a control vq, keep the enabling of the dataplane after
> CVQ so QEMU can restore the device configuration.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Fixes: 6c4825476a43 ("vdpa: move vhost_vdpa_set_vring_ready to the caller=
")

Once we add cvq in the future, it looks like we need to bring this back?

Thanks


