Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCEDCAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 14:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0hZK-00030s-78; Mon, 22 Sep 2025 10:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alessandro.ratti@gmail.com>)
 id 1v0gk0-0004NV-FB
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:38:04 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alessandro.ratti@gmail.com>)
 id 1v0gjy-000847-45
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:38:04 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-71d6083cc69so44036577b3.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 06:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758548279; x=1759153079; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Osjmw+mo0WRJAWhqe4sRjIUj/l0VUlkt9NMApqW7j8w=;
 b=CeXYtliQErdA8sLGh5wd/RY7Z9nsvR19ZGUkT8MAf+wWL7DE0eLEsIb4gM+nEiRKX3
 EJa7wp06QVxn0C/96CCu2GDY2aWfzr/VdvYwGpJMKpF8CV1JIy+NwVMNOy3q5GleRfJE
 75xx7+S7oGwpmmbMNqcfvnyWKf6a+2TPF/6x+p9v1+lWdLbCzHfz1TLTbhrrhTFVrd2P
 P0S+1Y0n91ByrcEP71IUiBXRrJZVdLmUUZL84jrRP/MbbBLlcFDhbS6C+Vj1Xnr947Xa
 /zn48QFNbrq2Kf32lEU2TCuDVe06eoT/opxsmDueJeWC+LDUngCtf32uPg5vmXNrEwJB
 ucRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758548279; x=1759153079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Osjmw+mo0WRJAWhqe4sRjIUj/l0VUlkt9NMApqW7j8w=;
 b=saQCCr/jqb/4ZgBx//3GS/pz7Apu9wuUFgevwVx//7pEUrTBZq9xeQun/X+ktWO0la
 4xX1TgLWPeolvAkNs2+KkalOen3zU5pMXUh/lt9yh6wAnQ4dwxVvsI04Fo01dZ75r+vf
 kMDVpDXrbAKfxVj4eaCNx5wgfvXOowVNxxBedFXICiF92velidiBYMkl2VQcBlkF4h9+
 tigTi7M/41+2vzbXE1gSDEkdymYDRjj6f7MBt93BZqCqy9pV0+DjbYWPgFFkIkTdsVmX
 5Q/qCr7UyI/t6YDmx7TNoUxeslNqwk0ajaaPN6W6hv1uvB0z9JjENnGZcVjVVaczdYGR
 sXWg==
X-Gm-Message-State: AOJu0YwLOofVjjk3AVUz6pHanaZkwfIuIW/b3tEjnCvVVw8rCb/P0MDQ
 Qifxn5OHWZAKQdtN0F/y7gv2eepHbK26brPSja3YMqEygwJ7i+/VtCSWmy3LmEqqoKTbrCY0ymN
 5TOTR+KjclAi7DnBiBKBX0JnkbMh1khR5OxNI
X-Gm-Gg: ASbGncsOm++NVEb9tDkK5wcPTGEgDQemsHmSGVLvNfnxiNjIxc7p+Rj5/zmdzrVFEbl
 gvqOeJgfxNljidd5+72R+0PR4/2vLzGc5+/7UPDlWGevGPsqTbS/ms0V6mVs0pROWAyJn9I5Q8V
 Ik+82cNXgkabL/XEbBqm2t7too8+UbSzFsmH3HBUwl/LbZ2+6G7dTzbsv2PrZv6W/SXBoyApfPO
 K18CUGfbkPKi1kG
X-Google-Smtp-Source: AGHT+IH+Z5GEHFgKrFt3Q7AB3kZYA+c6Y9pq5hPXdADUDmXMjmE+vCpBmTBU6QP8Rxv9LQcjurCHgzKQPGHMtg64H+w=
X-Received: by 2002:a05:690c:4882:b0:73a:27e7:e736 with SMTP id
 00721157ae682-73d3fc9d810mr107963557b3.50.1758548278865; Mon, 22 Sep 2025
 06:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <87a52wqa03.fsf@draig.linaro.org>
 <20250915162643.44716-1-alessandro@0x65c.net>
 <20250915162643.44716-2-alessandro@0x65c.net> <87h5wulqm2.fsf@pond.sub.org>
 <aNEpVhkZ2r5e2Z9X@redhat.com> <87wm5qoig7.fsf@draig.linaro.org>
 <877bxqk6vp.fsf@pond.sub.org>
In-Reply-To: <877bxqk6vp.fsf@pond.sub.org>
From: Alessandro Ratti <alessandro.ratti@gmail.com>
Date: Mon, 22 Sep 2025 15:37:47 +0200
X-Gm-Features: AS18NWB083YEHMdwZW_wFb4-92bMlu0ZXzPYaSvgrxJoNEhPpiHeJe6gSwU290Q
Message-ID: <CAKiXHKe07RKxBUCqfTFYkaGRj6T-avnS4C5=WcUqevD9eBQ4_g@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: Add function name to error messages
To: qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Alessandro Ratti <alessandro@0x65c.net>, philmd@linaro.org, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=alessandro.ratti@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 Sep 2025 10:31:04 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 22 Sept 2025 at 14:29, Markus Armbruster <armbru@redhat.com> wrote:
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >
> >> On Mon, Sep 22, 2025 at 12:37:57PM +0200, Markus Armbruster wrote:
> >>> Alessandro Ratti <alessandro@0x65c.net> writes:
> >>>
> >>> > Replace virtio_error() with a macro that automatically prepends the
> >>> > calling function name to error messages. This provides better conte=
xt
> >>> > for debugging virtio issues by showing exactly which function
> >>> > encountered the error.
> >>> >
> >>> > Before: "Invalid queue size: 1024"
> >>> > After:  "virtio_queue_set_num: Invalid queue size: 1024"
> >>> >
> >>> > The implementation uses a macro to insert __func__ at compile time,
> >>> > avoiding any runtime overhead while providing more specific error
> >>> > context than a generic "virtio:" prefix.
> >>>
> >>> A need for function names and such in error messages suggests the err=
or
> >>> messages are crap.
> >>
> >> I pretty much agree. If we take that view forwards, then I think our
> >> coding guidelines should explicitly state something like
> >>
> >>  "Function names must never be included in error messages.
> >>
> >>   The messages need to be sufficiently descriptive in their
> >>   text, such that including function names is redundant"
>
> I'm in favor.
>
> > Ahh I missed the fact this ends up as an error_report. I think having
> > function names in debug output is fine.
>
> No argument!
>
> > It does however miss important information like which VirtIO device is
> > actually failing, despite having vdev passed down to the function.
>
> Yes, which device failed should definitely be reported.
>
> [...]

Hi Markus, Alex, Daniel,

Thanks again for the thoughtful feedback and for helping me see the bigger
picture. I now fully agree that adding function names to error messages (vi=
a
__func__) doesn't really address the core issue, and I appreciate the
push to rethink how error reporting can better serve both users and develop=
ers.

I've taken a first stab at improving one of the messages in
virtio_init_region_cache(), following your suggestions.

Here's the updated call:

---8<--- Example diff --8<---
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -240,6 +240,7 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n=
)
     VirtQueue *vq =3D &vdev->vq[n];
     VRingMemoryRegionCaches *old =3D vq->vring.caches;
     VRingMemoryRegionCaches *new =3D NULL;
+    DeviceState *dev =3D DEVICE(vdev);
     hwaddr addr, size;
     int64_t len;
     bool packed;
@@ -264,7 +265,10 @@ void virtio_init_region_cache(VirtIODevice *vdev, int =
n)
     len =3D address_space_cache_init(&new->used, vdev->dma_as,
                                    vq->vring.used, size, true);
     if (len < size) {
-        virtio_error(vdev, "Cannot map used");
+        virtio_error(vdev,
+                    "Failed to map used ring for device %s - "
+                    "possible guest misconfiguration or insufficient memor=
y",
+                    qdev_get_dev_path(dev));
         goto err_used;
     }

With this change, the error output now reads:

    qemu-system-x86_64: Failed to map used ring for device
0000:00:04.0 - possible guest misconfiguration or insufficient memory

This feels like a clear improvement =E2=80=94 it gives context (what failed=
),
identifies the device, and hints at likely causes.

If this is more in line with what you'd expect, I'd be happy to submit a ne=
w
patch focused solely on improving a few key virtio error messages in this
direction, starting with the worst offenders in virtio_init_region_cache().

Thanks again for your time and guidance =E2=80=94 I'm learning a lot from t=
his process.

Best regards,
Alessandro

