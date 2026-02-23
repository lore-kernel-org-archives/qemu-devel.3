Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2ABEA4FBA
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 12:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuVSl-0001uh-1d; Mon, 23 Feb 2026 07:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuVSd-0001sx-H4
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 07:54:53 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuVSb-0004OH-RJ
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 07:54:51 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64ae5f0777dso3870303d50.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 04:54:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771851288; cv=none;
 d=google.com; s=arc-20240605;
 b=ZuZooDu/vEHVrLTYCgQYCebJede3tbGCPCyOu3XicZwzqfhxWB77MCeUCVWS+ogRbB
 oQVumlL/LVkjHHmqrITRMCZWREqIpqOcfPCKjJsV83K3A9+1VZr7rV3//Wp+FBu6c+HH
 eIAAEmQJt4i+nnASaO0uSkzGJst55z/gbQbRF5aj9uPCU3z0T60SScBQlhSEMghYT3aq
 zuCLQOBhBADSE1sXgHiMn4FkOmtfgojOkhgrxRPV+d3c0jCL8vDNxMsg3z3hRxKzUquv
 pKcDuYrXjSku8DXDrn/NENUrM+B/i+LvvhQ52nEkrogjYAmEh7rup+ve/sx8Pckv17Di
 iTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E866oXhIkLAr76uuZwByzzVSn0J4cbqAu5Ex6C4iawU=;
 fh=a48Yz94NrSN1VfxXFKxdHg5tRcnTkBUqJPewYKl8hN0=;
 b=Eh0MEnnI/PpstPrJPeN/UiHEsfls3/FrzhNfRo5dngorJIrh/ZFp02hSEETh9uMKto
 28blCZTuVdabtJKilqd/uhkAFGf/kWAuk0DpGt2jMO/sXLY8OcqKdGTa77g3bzWZpZ8K
 zI349KtCPzX4stKuZlaJDtwdivS3fMOJSqaTMML8bUGOtUK1P5aLkZUFc/ktki9PvE3d
 9w7HvFsoP8qmJ/U8EAZG/OEX+AZL/iEKhd3ZyE0RGq6+NxkNV8yhcnIZphbhZIwC1t8a
 UjCgS7KW9VWvMAZwvMpdhNd1MHTEG/n2n7DO5NjWOUuHlHuWPydXUe6KWW4Hv2mLOGA/
 urQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771851288; x=1772456088; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E866oXhIkLAr76uuZwByzzVSn0J4cbqAu5Ex6C4iawU=;
 b=JL12VpHqFa3NBVFdpSgo+kFaGUwodaS4ajOERB1Kzfv+bOL/WD5nvL5i7krbzfUN/p
 DwTp2ak5P6Ll4hm9G9xp+bXzmvrYW+ybKHL3jQ5++71CSCspgq3yMvr83HIa5z2aqg78
 3wTr101NF+yW0xuRaKjXnrHk2OWRLhyl5PRP4WZ67ZcI4GxzN8qAtWCAKP9SdXzEhNGi
 AH+zigrs0vCpKhHrnmLg4KrIK2g8K36lmFZ3wssRW3tzR4zab1RTmjuqqzQEd20R3LIJ
 S7nSEC4/WkFnoyPFpT3mjkM6/hq4e1/0cwC7m5RBh9Ac7OYW5PEKQNDF7i5UE6baoJ8Z
 fkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771851288; x=1772456088;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E866oXhIkLAr76uuZwByzzVSn0J4cbqAu5Ex6C4iawU=;
 b=llp4rnwxs291vJt76Bt/CcU6W85iPPZh5cs2oT3mXZmZObnFb+iO0HlPTHoGnrt1Pe
 akkALP0WPiVwmdO88iwnerwnl0HgTi6VTx6FxDC+VJqx+yFnQga6ezOtU5yh/UVNyAcK
 LwwJF0JvRMCZ4HyNxzfkme/z6Wr4YhEW4m4L6fvzNq9cUfpt2Vm0op2KLQL+M11IHbnf
 bZcXrVEbttxkemvynMolpdPpxMuzC33M0eNv2GihCS7/Qxc0QFHG91fTe0+V/LD3tQjq
 AdSvBdJYPZBt9GdFKonUdQhkz81il7VrzNrTcNxf0dJr8u8L+UzOIjWxQ33hVJSg7kI2
 NjmQ==
X-Gm-Message-State: AOJu0YybvYyaK3irBCzzcF9mHh2Sd4HSFJaFZlsdTW5kzq0HMxpGYbrm
 mfr5ZFzTWEoA8ZeeR9kwcgPbh1dfwfOHIAgkGr/IXH76YsvV9WosCf3LJ8l43RMjVG5zWq00gRM
 +aNxPQuS9NSRbBvmrUhl0uMxJ63iuwFrzJRtOyRKfJw==
X-Gm-Gg: ATEYQzxGT4PKUkuW1lqSVLDL30HMs1ToaH7hEkz86+Tg6sVFeP8T3RkZrOXyOxJQB5w
 6tiq5YPUdFinPtw31JYmZ3HVbO/2/1nMdsJPlWT0KsyqKIVd3st0GU19isTWxv08n85xyJH7oPV
 2HiMWWb3ABJWJO37nv2nZ3lmLbvTwKPomHgrWGIdXTo01xmaa23GcmMoj5V6imCymP4mOsv2EKk
 pYF4u7fPhvJ6YAxQr669NliTm1IH0CsdiBRLRzAEef9fOozFhxHhlTtsw/qyfkiVt5VIycZlH2+
 JsOLxnDKx6F4tqYfAdIrbcGL3hYrQJdf3yxiCtW/0mCaI9dmt56YA628Zeo7TbHHwW0=
X-Received: by 2002:a53:b009:0:b0:64a:dce4:8416 with SMTP id
 956f58d0204a3-64c787d6f5fmr5530718d50.18.1771851288524; Mon, 23 Feb 2026
 04:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Feb 2026 12:54:36 +0000
X-Gm-Features: AaiRm51PNRv1gwXv7pyTuCTv-c-OBJqx8o36HcM5bsHK_T_29s1h6oKJKrZ06B4
Message-ID: <CAFEAcA8QGU=Y=RmW9tGx8Jp=YzvFok_41K6ijFNuWXM7tV+K8w@mail.gmail.com>
Subject: Re: [PULL v2 00/85] Audio patches
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 23 Feb 2026 at 09:46, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit 07f97d5da04a9f97e273de85c76f5017d8135a=
6e:
>
>   Merge tag 'pull-target-arm-20260219' of https://gitlab.com/pm215/qemu i=
nto staging (2026-02-19 10:36:06 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/audio-pull-request
>
> for you to fetch changes up to 8699fab503fb06ecb8ea21ec1af99d85f28b4508:
>
>   audio: fix leak of audio capture name (2026-02-22 13:54:40 +0100)
>
> ----------------------------------------------------------------
> audio cleanups
>

Hi -- this has a conflict on merge:

diff --cc hw/audio/virtio-snd.c
index d5d430ad65,8b94914646..0000000000
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@@ -1276,12 -1259,11 +1277,20 @@@ static void virtio_snd_pcm_in_cb(void *
                      return_rx_buffer(stream, buffer);
                      break;
                  }
++<<<<<<< HEAD
 +                to_read =3D stream->params.period_bytes - buffer->size;
 +                to_read =3D MIN(to_read, available);
 +                to_read =3D MIN(to_read, max_size - buffer->size);
 +                size =3D AUD_read(stream->voice.in,
 +                                buffer->data + buffer->size,
 +                                to_read);
++=3D=3D=3D=3D=3D=3D=3D
+                 size =3D audio_be_read(stream->s->audio_be,
+                         stream->voice.in,
+                         buffer->data + buffer->size,
+                         MIN(available, (stream->params.period_bytes -
+                                         buffer->size)));
++>>>>>>> 42769ad0c1871228f1f4ee3d2bf41ed71389df01
                  if (!size) {
                      available =3D 0;
                      break;

Could you fix up and resend, please?

thanks
-- PMM

