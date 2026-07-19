Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C713EC4450A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 08:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlMYy-0003uF-45; Sun, 19 Jul 2026 04:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wlMYw-0003tf-Co
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 04:07:50 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wlMYu-0006bK-Ma
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 04:07:50 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-ca957432c7fso6332348a12.1
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 01:07:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784448466; cv=none;
 d=google.com; s=arc-20260327;
 b=ihSXCKujyhH0Gr02DeP7Mgyqy3r7UtdX8rpAVE6BINqdnGkbxpfsbQKo7pbgtzK4xd
 F8vQL9QiqB3ccsNq/HGrkFyj5ht/VL2UHaUaunX7PzndediG6dQcvwGa367s3IWdxWxX
 OJHcCtlIUWLgzRT+zEs3vDyKJPHabRkCzPILgOIEo1xxNxlkX4yOtZtVh1NtCBBoXNzx
 +VMv9W4kH0mv2atacQ3ZucrUHg5b2Eyjby1PwPI/5sT43JP29qd3XR70D5waSG0eqyD4
 jSIxwBKL3c2ekm9nwE/ZfFRocITH5v35/1Wz7gg8isCpUqmbB7MIk9IpQV3HyaFbitVH
 N2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lVZAhDhvQqNmjYSVsLhXUYFsOV7vdu5poCFuHphZ6pc=;
 fh=y1thu0tJf6haPURRJ3KBvtOw9jdQnjuebMC7DFZSAh0=;
 b=Vogrb0/FN9DckeGqf4d9hb9UgHmRXDeXRZiYZ8+NKBqZ0isp6DTpvgjM3VOTw3+9pf
 x9It9O3Tz8TdI3A58SrMxG8fbTb2P6wB5jXV+h3ieEKk3do0LSmU1ZkIQTRzEeC6pvat
 A80Oecfn1OB3Dlr+umyQLvsCIdsYqCHSthdLrHKVisYvaFp6z7Gz0FvvNmF7BkGVrzwR
 HrqqMNsuNcDDOvhuRu1DOowi0aoBqy0nQhr02jBWdB4uSwc6dRFUXyvAu0Rq332BCtPj
 MW4R05qZm9qg4CSqYjDAxhNMsc+YqY0NiqZxmfsvSxsKAg2+d1GuTH2MpACI2tJLYjma
 tz+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784448466; x=1785053266; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lVZAhDhvQqNmjYSVsLhXUYFsOV7vdu5poCFuHphZ6pc=;
 b=SCvK1P4oyQR6KBAx5ZyB1eCvaHsOBc5oe3cS2iIlYe/f7MkZ4aV23y1/6se91FxmSr
 itnm3cSuio11lOUddUbF8GOgKyQ7l7SXs73IvUKYbdj0nJ4LjdA3+17yZvSo9A+1y1Mm
 N+BtpgGJOwrN6Mb2b2mdPVFvc+0UthC8X4vin2WAJoqVNSBU6+L+01+Ee39BrX3RnYkp
 GYRSuweyPiOEA6UGAgjEkYmeyG27pSJ3ub0it0T5IDiz6Pz7B/teEkUyfer6D6og4faH
 /+2XnxErAJ5qUWZHpNF7b9w07h/pzBOcmO88PEoiGpFlcQ81WrsicVVVxaUALb2FePkg
 ixbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784448466; x=1785053266;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lVZAhDhvQqNmjYSVsLhXUYFsOV7vdu5poCFuHphZ6pc=;
 b=hYF8wtA/jNR2/mPX14mmUL/svQJKfrA3zCvD3mQwpBLXWx1eLF85x1+hHxD9EsME/z
 vxhIHHgsqKsRLpOgpctMMDbHQlh63vLzUlN5KVzkVg7yZ9kbSSgVy9h7dbji3w8jrnwL
 E8+8IFO8Sfhc62gz7bS+PWlp94MqRV569zrfP13vYIqNru+ZmbgX1o3VyUWNbbOP/esT
 Rk5XaAtekg5gth2AE0ET6FK/kcOIbUK/0LCTiBd0yBbQCxM19qH0ltXRPMcLGZSIFcps
 SeOOozzOJqdwGzfbmgVn8aqBbMOW9NuzrDP2RZwS33UDQVsMt31O9XH6aDxbXVqq2HrO
 J2sw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpj5E3ewLGWJY19MENcbSoV3OIYQES+oiau92uyUWQ2VJgNfXK1s3nH00Z0X3P5SUTa1hRgc6J0bInm@nongnu.org
X-Gm-Message-State: AOJu0YxkGXPlEjsxW70hoPD+FWnfI6/B9f0F6mxFGi00zfrshkSxH+CK
 O+DjWDgf4Ql5Ag/8Bx3TddG6hW7hZLNvVlbB0QDWsovskHuIoLJbxOyIFIFKd96RhIoW+8H6Gi4
 hPiP2AslWetnXpBq8ObS4F2QiF1k29jDPyyhqWVBi3A==
X-Gm-Gg: AfdE7cljxNPz9NSt3ZZiGnwviqVLg9TkRuhfZYL2Yb5hmtEc9IM93yJvsmJiuU5bAbv
 BjY1k7rUG1CMyYt+11cyEME70zz6l1qsxm3Q87qZeis0Kc7B1Ls6AY4hDXEJl3eq0I36X90hbFQ
 O4Jo5y+d4eJ8ZvFBdxm3m3Uf8miRELfFn+I0ZsPTENMLbY1NsY3NRVuDQN7oKrcZdmm2skX0v7V
 5a6hCULLvrWbKNp+EyTES18xNFrMjtwGwzeTkLNWQBxVb41rHjj7KmNN/CTLXNlLaLya5+HVA/v
 s04JQhcHf4OSgkuE6Q==
X-Received: by 2002:a05:6a21:2c11:b0:3c0:9c19:6592 with SMTP id
 adf61e73a8af0-3c3ada36c4fmr10160617637.76.1784448465907; Sun, 19 Jul 2026
 01:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
 <a6f014be-7f31-4f53-a3f4-9b1ea437d7e7@tls.msk.ru>
 <a12f0dfc-2487-4ff9-be0b-149451e80032@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <a12f0dfc-2487-4ff9-be0b-149451e80032@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 19 Jul 2026 12:07:34 +0400
X-Gm-Features: AUfX_mzuzYb9cTzvH4TLaenSz7Ho2RpmkJm_iDLLdBLUeGPOvi67tlkPMJPrDkE
Message-ID: <CAJ+F1CJe4Xci2wfRXg3umPw+cEb9vO9XPDDopiS8Xa9+ajaeHw@mail.gmail.com>
Subject: Re: [GIT PULL 00/15] Various UI/security-related fixes for 11.1
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi

On Sun, Jul 19, 2026 at 11:51=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/07/19 16:33, Michael Tokarev wrote:
> > [Resending with the correct email of Akihiko Odaki, please excuse the
> > duplicate]
> >
> > On 7/17/26 14:52, Marc-Andr=C3=A9 Lureau wrote:
> >
> >> Various UI/security-related fixes for 11.1
> >>
> >> ----------------------------------------------------------------
> >> Akihiko Odaki (3):
> >>        ui/gtk: Narrow DMA-BUF critical section
> >>        hw/display/virtio-gpu: reject strides exceeding INT_MAX
> >>        hw/display/virtio-gpu: Check pixman_image_create_bits() results
> >>
> >> Marc-Andr=C3=A9 Lureau (12):
> >>        i386/tdx: fix uninitialized variable warning in tdx_check_featu=
res
> >>        ui/vnc: fix OOB write in vnc_refresh_lossy_rect
> >>        ui/vnc: validate color shifts in SetPixelFormat
> >>        ui/vnc: use RFB wire types for client message handlers
> >>        ui/input-barrier: fix off-by-one in keycode bounds check
> >>        ui/vnc: fix out-of-bounds write in lossy refresh dirty marking
> >>        ui/vnc: validate SetPixelFormat field ranges
> >>        hw/display/virtio-gpu: fix dmabuf_fd leak on remap failure
> >>        hw/display/qxl: fix TOCTOU in cursor chunk data_size handling
> >>        hw/display/virtio-gpu: validate stride against width on scanout
> >>        hw/display/virtio-gpu: cap submit_3d command buffer allocation
> >>        hw/display/virtio-gpu: handle migration iov allocation failure
> >
> > Hi!
>
> Hi Michael, Marc-Andr=C3=A9,
>
> >
> > Is there anything in there which should *not* go
> > to the stable qemu series?
> > (besides fixes for code which is not in releases, if any)
> >
> > It feels like everything in this pullreq should be picked up
> > for qemu-stable.
>
> The hw/display/virtio-gpu patches are generally good for stable, with
> one exception:
>
> "hw/display/virtio-gpu: validate stride against width on scanout"
>
> This patch doesn't account for the late feedback I sent here:
> https://lore.kernel.org/qemu-devel/ec997fca-6dc4-4268-9269-0e4be676b0fb@r=
sg.ci.i.u-tokyo.ac.jp/
>
> Marc-Andr=C3=A9: My apologies for the timing, but please check the linked
> thread.
>

Tampering with migration stream is still being discussed, in the
meantime the patch fixes malicious guest gpu usage. Can you send a
follow up patch?

> Michael: You may holding off on that specific patch for qemu-stable
> until we clear up that edge case, but at least it's not harmful. I think
> my patches and the other virtio-gpu patches are ready.
>
> Regards,
> Akihiko Odaki
>

