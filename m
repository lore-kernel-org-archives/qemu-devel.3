Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8519DE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1BI-0002gG-Pj; Thu, 19 Feb 2026 05:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vt1BH-0002fu-57
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:22:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vt1BF-0000u2-CW
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771496562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yJkzZnKalF45Pz6HFbwjWkY4LJjd3xQCCaEX+kz9ErI=;
 b=SIEQWOQdi9t8kg76K1Ly1OlcT7UfWNU7fIQ+yt10aALOQyIi/3cWcTubWSJSAWFBYMgSJR
 NeGaJWr5/AuVRJHMwIlaj46eWfFIqf5mp/4aR3QiC7fArpmpRPEK5HLbscXGQ5Fpz3z2AH
 qRgxFHTBVja9adiU/Hmyaeg3hev2X3c=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-idOSdWNsM8K9ZE8jjOj9GQ-1; Thu, 19 Feb 2026 05:22:40 -0500
X-MC-Unique: idOSdWNsM8K9ZE8jjOj9GQ-1
X-Mimecast-MFC-AGG-ID: idOSdWNsM8K9ZE8jjOj9GQ_1771496560
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c6de1ee12a3so561251a12.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:22:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771496559; cv=none;
 d=google.com; s=arc-20240605;
 b=AEWLzrIH1v9Lhr3WOFsmVla+aMmePaO5cuwiL2qNr65xRot/RkUgC09WWRjEfDJpKG
 trqNQFJNN7ttCGSc7d4Mq8XSi9FnSyK9Gy0uGtGF/QLZ7P8mWWFVB1bvHRevpJCT61Z0
 nolOaCOz5B69Tgu9jtB+SANjujrKOfVtlwQhDH3JJAFQX+EPeAtloMEKFkLANT5PHFfv
 SsYSNAsddWyfjVD6NZyv1Elf0YOHIg62EY/rH8Mjq6q7tTudtkxXXe+UqD7bu/fk30N7
 SYsR5gebHZYX9v1gMEejcbZMoXoTPSiftDqobV4x3CQhl429v40IOJpRGKUIYotkSEEt
 bRRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yJkzZnKalF45Pz6HFbwjWkY4LJjd3xQCCaEX+kz9ErI=;
 fh=tCZ3QIqVZhWLy+GSVt/ftMC7Y8JwqiOZVFrcJSZIwLc=;
 b=hLSNYhdC3ZcXxUYuCxL92p2v24EezpjusJSuuhdd+U2pqGexyRQePx0Z1FEImKy5BL
 XM9UPVC3GSxu9m+k3ZZJFUgkQwDu/DL2ST4YxGkZY32Oj8PRVH0nYXwfGy/2ZDFA6ItS
 5mJSodvG4N9KKF5zEjrpzn7fqfV/2okrinYuce3ZzXgE8DNtU2IyFOKKIySGDGzkFQ2A
 sxbeO9zZH5Lxa2cKNwAcXdWBAIpo2UKS2nw/BN5x8ASQhaW1DWZQkIsrS0DuwOXGWJrm
 63hOC2CXkq7wEnRcS/+QoK/dInLJ4A0i6jwenQRveXDvRtZ69M9nC7yjoe/5DLbvwd7o
 KFPQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771496559; x=1772101359; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJkzZnKalF45Pz6HFbwjWkY4LJjd3xQCCaEX+kz9ErI=;
 b=kGpOwdDNgl9OgEBeHP8F4AUnmKhjE1FDxIiPDA3pgIp5dxrLfabD05LSt03F/9peWE
 TcofW5RKoqKcvlCcNOA7+BgTta5uiwxyCMW7+d12ITt9rDUA6a3b0YyP3xkZhhQCHcIM
 AJTVSZ5tbwPM0WAIK+RwzCs2O7RKIfoInw5x4LejLGNFs9x66kXxXhkyCwtajZR8Qz5X
 G4rVhTG62/wsFplq3Gcb7nf3muYcFli8j1TMn+qVsbHGTDrvToSHAmoYgphHZZwuPjRA
 KfvJjTG8Kb2YC+cEke/XpcJ2f9DHERJdcQShCcGGGQBICY0b9g2E+Lve/lqGOgOWwyZn
 vs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771496559; x=1772101359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yJkzZnKalF45Pz6HFbwjWkY4LJjd3xQCCaEX+kz9ErI=;
 b=cEBXe7wXEXEC0SXFIeL8YiJE1sXC8z8VfKuu/pE6c+/OmN1lKaNLIwf2C/RSBNqiii
 FQIdRo8jDz3QU31TFjPXI41YTIdrLezVEPM5pvyKzsX4i77U4akbUMscyT9Y2TexzWtt
 7WWee8zp4Zgg4EwB5nDHw/PlD5qlGLMj6laHJUy9FtmIA06VLa3domuOBq3H8b6YHE7E
 Xx0KQXONKnkUIDvs9H0LepbXw7j7/dOOnK3CL/QbWqHjIwVaw3NTB72XLK7Fuqcy7qqB
 nxGqZlesIeaqxYJ1VQIVJZVOS0PZb+It6Sd7rhjxvQPPNuGNYOTy4o3s6YhG4WJfXB7b
 Wdgw==
X-Gm-Message-State: AOJu0Yykht/MrbuXyT/tUr2Tf8MByc6r58lvpLS3tMdK8yEsDPIld7OP
 vmiOmb2nByOdBTdZHp2H9KeVeG/qwIgsyZjBjbg15Q+tGhkLyV2DKwwpaEquvc3ROIbvBOYbbv/
 Xn2/lBX0FzjlGOEWoNCXar3yuT6/AH/a3J21LLIwFa8INR3jxIIzUUbnEF3Z0bvRcuIP7xU5tTU
 SZlhfH7q1cfVk41/vVGQodtfKq09Eojhs=
X-Gm-Gg: AZuq6aINxUHPgSP1XykhKCNbveUitL6HaIyG1cwaB90umiIapMiDAHU2eul7//xnKoD
 yoI7Iq4d4e0F3Gmq3C+dBHxy43cEpPxQKtqvltspS9TOfTXBmQtHanEBpWYSYiVFDvtb/bTzPsB
 7SwygInuyUAo+WuL9rMDMBB7KNnztzmk9rD/NyWYPzNh4yJkrxMFycTIHR2yucUYf46plssnxGZ
 ohcGGG1AhOBncBal7BIsPudjQnRUd59fzIQyP0=
X-Received: by 2002:a05:6300:8a8a:b0:38d:f084:e351 with SMTP id
 adf61e73a8af0-395123258cfmr1868553637.80.1771496558691; 
 Thu, 19 Feb 2026 02:22:38 -0800 (PST)
X-Received: by 2002:a05:6300:8a8a:b0:38d:f084:e351 with SMTP id
 adf61e73a8af0-395123258cfmr1868537637.80.1771496558313; Thu, 19 Feb 2026
 02:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
 <CAFEAcA-Gg5pJW=SYV0xQX7tBz8XwVJT0pUbnJqwoBzhZ4Fwx+g@mail.gmail.com>
 <CAMxuvazA6Cay33qNT=Y9jN+TgxSTkKZdNfSORkQBG=Nr_0ok9Q@mail.gmail.com>
In-Reply-To: <CAMxuvazA6Cay33qNT=Y9jN+TgxSTkKZdNfSORkQBG=Nr_0ok9Q@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 19 Feb 2026 11:22:27 +0100
X-Gm-Features: AaiRm50106XQ1T4XSMxU4s0yUfHFTVac0y4Op7B6pelhfVBYHQZqYqYTggPiZbU
Message-ID: <CAMxuvawjL=OV=doW5jqRBTBRhcF5DARUtgCN9hj4nyox_051Tg@mail.gmail.com>
Subject: Re: [PULL 00/85] Audio patches
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Benn=C3=A9e=2C_Alex?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 19, 2026 at 10:48=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Thu, Feb 19, 2026 at 10:13=E2=80=AFAM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
> >
> > On Wed, 18 Feb 2026 at 09:03, <marcandre.lureau@redhat.com> wrote:
> > >
> > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > > The following changes since commit ece408818d27f745ef1b05fb3cc99a1e7a=
5bf580:
> > >
> > >   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into st=
aging (2026-02-13 10:30:08 +0000)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://gitlab.com/marcandre.lureau/qemu.git tags/audio-pull-reques=
t
> > >
> > > for you to fetch changes up to 671f6b05e8939f01621250446d6d9a71c77582=
54:
> > >
> > >   audio: fix leak of audio capture name (2026-02-18 09:56:43 +0100)
> > >
> > > ----------------------------------------------------------------
> > > audio cleanups
> > >
> >
> > Hi; something in here seems to be causing the replay tests
> > in the functional-test suite to fail. I've tried retry on
> > the jobs several times so it doesn't seem to be an
> > intermittent or infrastructure thing. Examples:
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/13179297572
> > https://gitlab.com/qemu-project/qemu/-/jobs/13179297533
> > https://gitlab.com/qemu-project/qemu/-/jobs/13179297557
> >
>
> Good catch, this is related to "replay: remove dependency on audio/",
> changing the replay format.
>
> I didn't realize there were scripts (scripts/replay-dump.py) checking
> it (QEMU_CI=3D2 don't run those tests?).

The following patch should be enough. Do you want me to resubmit?

diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 097636570dd..081aaa36c5e 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -395,6 +395,9 @@ def decode_end(eid, name, dumpfile):
                   Decoder(39, "EVENT_END", decode_end),
 ]

+# EVENT_AUDIO_IN has changed
+v13_event_table =3D v12_event_table
+
 def parse_arguments():
     "Grab arguments for script"
     parser =3D argparse.ArgumentParser()
@@ -413,7 +416,10 @@ def decode_file(filename):
     # see REPLAY_VERSION
     print("HEADER: version 0x%x" % (version))

-    if version =3D=3D 0xe0200c:
+    if version =3D=3D 0xe0200d:
+        event_decode_table =3D v13_event_table
+        replay_state.checkpoint_start =3D 30
+    elif version =3D=3D 0xe0200c:


