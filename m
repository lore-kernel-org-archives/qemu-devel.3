Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE81AC55838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrpit-0003UP-P1; Thu, 06 Aug 2026 00:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wrpio-0003JL-SJ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:28:49 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wrpil-0003Gi-B2
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:28:45 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-5283e3eff60so11015631cf.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785990522; cv=none;
 d=google.com; s=arc-20260327;
 b=ZL6JOxCFhAvpD4YJMpKQHMMeoYnDMfpPfaHWk+PhjV8ZQLRPQEjbT3kMQWMhk3Vm8P
 pYWBI6EGuR9v9vHmQ0fFhk/wg602Hk3gVD/aX6URsEPsLT4KdXWCkvUmGqTidnG2yt4d
 kHURtrWYq/DIfX/vLBlrsvemfSdDiH+l4hYq/vB8tFGIoSFHjqIMs8l3FCGHidGsycwY
 Xdlw5dNpcUoIitbiupl0nbIlV48im8su8zdXQ05g7gVqTM4LjdKEgezz84a7faA/hrbN
 EJUfZDMakjnIb8E1k0VSpbQ2xuwCLWOesWowlBGqCH/dyrhKxzibqUFWA3IKcO1zLQFJ
 3cuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7HTjUuWuz1hkJDPG/7b0LR7ioyQYvKyyRtXzOalkgX0=;
 fh=xsRg86ZwBm0LGRQZIEC1R+b8QTOodxCX7/oSmDWEnOY=;
 b=E/z6gabl8Q4ZuaKi8wiXgFEn6MvnvcPvj6QklSGmGyjK0yoHDeDxQMbFasGoBDCqLZ
 b3h5Kr1Ovrsmv7F17Qq/MmALtsZ7+CuQQW2mRn8oxYJtsto2D3Xn2MAEgavw3SE6L92x
 q9xyyIvYBcIWdMqQS/UrX8lrWNmUsizQ0AhoOCj6TcmjadkGuPh5BQcOcjd/5ByacvHI
 HxKLyII2WEtpEJ8rfhPTT/NtkSdBVH9FJHBgF+E7Nr5XfimTQhpBPeBNCrx4SqRiewd6
 r5X8lREPPRgrhbbRsIGev/VAt9D5LaoabrPK72/50raEnzFhUgsrfTsNuYfril53UeT8
 YOkQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785990522; x=1786595322; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7HTjUuWuz1hkJDPG/7b0LR7ioyQYvKyyRtXzOalkgX0=;
 b=J7vLlFFRc98MHHDwGqSruAUrNDw88tZUZ+84qr//00ljfCqot7AzU9vldx5lczRi5P
 ww3L4mdkBie7TFw2eeMalk1MOCThGdxRHTZ0eYwQAdNLDTK76GOPvTToqPHIqpY5h5hl
 XXgVPGRHN8UHnbpZygSPSZDyRbjrWnTn8PQ/CHrjRtOCFSY64sK1qzfBcwg3S5njw9xL
 3u2YjYCtWk6Fx6d/yS4p4ovhkCipMHIUY6uKE0o0vDvzxy16c4tlEfLtdfR9+JM4e0Rw
 tWbsE2dB+M66YHBcAGHOpEExEaIYkV6rGxE+jl05wzPJjU6Msacm38Xh1QgVXx3e6cuX
 ts3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990522; x=1786595322;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7HTjUuWuz1hkJDPG/7b0LR7ioyQYvKyyRtXzOalkgX0=;
 b=OAgtTlAyNNW62EtU73Pp+LriHUYxCC469/ooNsdwAwv41UKgZctoN4as6Rz03YBXfs
 mEMTvrNPIEWS1WmoIfdjXCWI/1VmijtMVfB56CrlWRzj5V5nsg44SQIkDL7XnZk35oSt
 Skc3/kBJcdKxCTeTewOWERO+IbOXvveyyx68DTQLaT1u/kasV7lkiBTZ1D03lOLmCsTW
 tpK+BERqKxNz5btNezlXDBsN4l3ai4cYa9MV5Qf0oiCZc682kthDfmXgtkPo9ATzGhws
 wskk3zNkdWyTl81+b4bQpeBiGHBAGV2qQ6tN2BQfMbcQec5zcj694ciO7dp4fenBM1tG
 hnXQ==
X-Gm-Message-State: AOJu0YxuJ6vI1YBg1UzX7nZgj+VnN745mkTNb4yI1g3+anUykqnAtR12
 G079cmD7xmofgkHepY7kIQ4w224ctjisieGpVUhBKYS+w31RoMhZVmsP/vlCN9e2nxk0nXig92w
 vddw1z/l47ysR1pJB7mWo0bBuGRms+Sc=
X-Gm-Gg: AR+sD12lvGaET4PPlNlYqCk/077NI86yT46COqq2ADSVIrN1p9TCZgW64oiWozcQG+r
 WXw5CaStgY6u+AghGOJiLuCKhvXrDmGt4OKzVrKnrzpZvm0KrkI/VdUBZfyfo6+UQ2GK5T8dk7I
 GCTEXETCy0T2NHrestmyoGEXf1M3MMaJTeU6FL+QYu2AYnX4qpWaN4cfE+P/TcfFwmPiW766kN3
 4tx66mQayrxn0AMPY+gNSfs7hmbGY+/WQ4NT85GxWPIpMdiTdoCgShKwGzvPwlXXDOtBFLTdalH
 eCBsRBneZJpFO23FsiwUrGcS8SL6hXCMUL1b+dn/khmjxzI0VSND0QLYZlx0sx+UJAIAo5T4NfN
 4qQ==
X-Received: by 2002:ac8:5808:0:b0:517:71d2:37d2 with SMTP id
 d75a77b69052e-52ce5e00f67mr121953401cf.0.1785990522167; Wed, 05 Aug 2026
 21:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-2-6b97c439eb28@gmail.com>
 <eb1d8424-206a-47f5-9ad5-a833a56bb3f3@redhat.com>
 <CA+spn3pLkHn_Wk+-xa-k2PKXdDSa-S9c1Dd94t=Kj5tajPyzSA@mail.gmail.com>
 <95fe9d1a-dab1-477f-948f-4a42a1e3f09e@redhat.com>
In-Reply-To: <95fe9d1a-dab1-477f-948f-4a42a1e3f09e@redhat.com>
From: Connor Kite <connorkite@gmail.com>
Date: Wed, 5 Aug 2026 21:28:30 -0700
X-Gm-Features: AUfX_myeq4cgveTvA9QN9nMYHZdXFkIN8zO2K-kwrIi3nII0KCENKjPycV7-1m4
Message-ID: <CA+spn3r=75BCypgw-D=MB7RA7EcET5QfvCtY10f+Azw+xMCUxQ@mail.gmail.com>
Subject: Re: [PATCH RFC 02/15] vhost-user: Add memory-isolation qdev property
 to vhost-user devices
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x82b.google.com
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

On Tue, Aug 4, 2026 at 3:46=E2=80=AFAM Hanna Czenczek <hreitz@redhat.com> w=
rote:
>
> On 03.08.26 22:32, Connor Kite wrote:
> > On Mon, Aug 3, 2026 at 5:21=E2=80=AFAM Hanna Czenczek <hreitz@redhat.co=
m> wrote:
> >> Should `vhost_user_vga_inst_initfn()` set up an alias for
> >> "memory-isolation", like it does for "chardev" now?
> >>
> > I am not 100% sure but I can test to see.  If an alias is needed, I sus=
pect
> > that would also apply to vhost-user-gpu-pci, right?
>
> Right, that makes sense. (If your testing confirms that it=E2=80=99s need=
ed.)
>
> Hanna
>

Testing with both vhost-user-gpu-pcu and vhost-user-vga, the
memory_isolation property is getting
properly set in vhost_user without adding an alias.  In both cases,
dev->vdev refers to
a VhostUserGpu, which has the memory_isolation qdev property set as in
other vhost-user front-ends.

Unlike most vhost-user front-ends, vhost-user-gpu does not define a
"chardev" qdev property.  Maybe that
is why the "chardev" property needs to be aliased?  However, I don't
understand why "chardev" is not a qdev
property as vhost-user-gpu already makes use of many of them.

Best,
Connor

