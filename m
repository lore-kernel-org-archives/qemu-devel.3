Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5D6C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 23:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxCP1-0006Qw-4t; Thu, 20 Aug 2026 19:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wxCOy-0006Q5-MC
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:42:28 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wxCOx-00035N-4c
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 19:42:28 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-9371bcf1f8fso19309585a.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787269346; cv=none;
 d=google.com; s=arc-20260327;
 b=GL9E/RaSm7yF6y/8tWTWzmrKlJuRtiMqMZ5ackByjIppqx95l+58eCsT1h4pXv/MSE
 qoH83OGi2UhvhVfcCuHbpuYjT1b1j+bp+2zA7dh6kudmdRhGLiS3MzvPuWSTW3g9zYAg
 hJkyqOxttlmhqqLRVG7dAW2oiagp77h2I89jlrjpIyAMUdcCz6i3e6Et8Ae0q6rC4xJY
 YXzTu9GjnZIu7e7g99ZZKt69Mrlj6UKSx2SW22XYCd/7zvkuSARGkRWa0fuUiC99Pyfp
 A81t3rxQ3jM/frJTYpoMFTjQQLlfugWAzvg9DkjsiLzMzNrlFOibpb7hxHbXRiCbZ1br
 bOmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hF8HEpAhh9KuOZv/WIlDvc/Bwcys5cjfJE8nSa9pxU4=;
 fh=zAf9Wul48xkTrIs6bAeEfpaQhknOU2iSq1CvwgfZtyM=;
 b=r2z5AvnzW5tITJIrxqIyPaDRXjSpozEQNwkGysbF0+CtNnwoFXJosEvTyo2+kl4lCM
 M0lXtfayUTU1kTTQIx1To8T596jfyuxMfDI7rDbVBPyOgWQqnxoXD7CZ0PcKwsVugb4s
 ccNP/REElllC2G6BLAZ/c6QLmRLQMAUEqPFPCvPREjweXpC7X282PlJMazAWCCkfeFLp
 93ae5wja8F98s8s6C4ad+yN/q1X5sOUXecTq2GqoH5bGkgkplYK9JS4c3muXLFTYaG4q
 /CtA5rPVN6it39Ki7DQqqKEG7SvDik1hsFl5lx9bTOOJpSgUR4p/dNimpRqDcAP0QBAK
 yIgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787269346; x=1787874146; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hF8HEpAhh9KuOZv/WIlDvc/Bwcys5cjfJE8nSa9pxU4=;
 b=qpAyEGPRZ1T3VtjFsWw1S4QmbYTEBeeGA92O/iDP34/9HSOXL9d1MU9xMulquNSDWk
 GR3fO/WyJHIpFGRAPGX+N/kl7amqaXVK7jcLIgMlTCRmrJaYcm09RYtx29N+fiP+FDW4
 RwbVEY+y4ks61X3QX68DGLVZM7mNeaJKvdZsmkLHD+LKblMPF+bctNIhqYb8DOcm5kfY
 h9syUaCEygPXFo+DARLam+7tYLrpFOnNqlaVeB8kX4rdPXHUpPJOBRkKBV0uqpFItBZW
 eOHHNQ9SBfGxgULrZOQh0YZMGnf/h2dU4++tCsNZk7eLPssH3VgA5V67sRiSgPWrn3qu
 XyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787269346; x=1787874146;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hF8HEpAhh9KuOZv/WIlDvc/Bwcys5cjfJE8nSa9pxU4=;
 b=DOCte6vZoKb9uAD45h0ZiZaA5UXDrJqjLFZJlfu0T/tfjxT3KEdtpIfzJtkCv/JToh
 /fGB5M8jeKfWdP8BGF3ja9Ku6v6OOsM6fclZleAXnenb2NzWq09TT+qD9pV+D+oQaLA1
 fDgmWBI9+6mUH1SGqIhBQzBhxZO3OAQPKqYhX+JQ5fKWryzhwF43ubnN9Ci/+ymQXE2T
 RqNsNf0egsWR7Uu1rX7t2Z93QsmbPrABRS7tzE03ynJY0y9H7aTfQjeN7+NwEkyjH6l2
 +7BwuHw4rjFZ4Jl/Lar6pr8P3bBNKsGLNx3hAj90cCfqBEz9krrQdfe91A9BnbwmqpCV
 OITA==
X-Gm-Message-State: AOJu0YzBOYdvTZpjO1gtlYK2VIy8YAbxDKSxamZUMXaLd97/ymjyAbPe
 CEyk/VnhjYa9CdqqbBChw1Wz8hwgZ2JHpJEBMaZqa9lwof4Zfp9CEzvP+mQoriFXGoQg5jAEJc8
 3yC+wZ7OYPpmWj7+OS9hU91qyFk6YIvE=
X-Gm-Gg: AR+sD112st1pFNkUqrfGOn8vk60HTRMDLZzJVDeVPLntbe89arfMJcivjobIyWhAjmP
 c9BR/MDAK+ZE7HYuHAwAiPvzPiaEqvt6MvgRm8X5IapjX1godL1eMa+2C/4PONp365td/RmpaZX
 8HSZJ65iBR013TPxa8wrVdT69FuadzRR0OT2CzyfhJibvoPKerHcaGpmXh2IddqUgcXVYv0WOzI
 /jQqCRAuxI0FLknhTypGa7HAhoWqRerNCfYI+matjx2QfUIVHI/Jc+NOdNtnItQ2hR2XuJVoE2Q
 ysx0Gd7P+bvqHRe6jWtkRo52dBur+rjwvbFZn2TWc+MOsvsTOD8201xHuUFDHUccqac/BxW1g8X
 gvls=
X-Received: by 2002:a05:620a:a80a:b0:936:cddf:3df1 with SMTP id
 af79cd13be357-937395bf953mr174780185a.44.1787269346054; Thu, 20 Aug 2026
 16:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-4-948aae960abb@gmail.com>
 <b6f79ec9-7842-47ff-b210-855036712547@rsg.ci.i.u-tokyo.ac.jp>
 <CA+spn3rouMQ=yG1m2fS=vm40c-zWWMZPK+yk0K_ip5iXzLZWow@mail.gmail.com>
 <5d8e3d91-de60-4747-88d1-e135e3c6e7c1@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <5d8e3d91-de60-4747-88d1-e135e3c6e7c1@rsg.ci.i.u-tokyo.ac.jp>
From: Connor Kite <connorkite@gmail.com>
Date: Thu, 20 Aug 2026 16:42:14 -0700
X-Gm-Features: AcwNN1U2GZyCGCclv-n-yhFlH9oRms5bYiv7MVJbaEJR9547b1OyH-XBjKMUqlo
Message-ID: <CA+spn3o18uuZqfyGE+R2QGZ6KRoTJ9hmK7HyEQ6cg4wxN9QPsw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 04/13] hw/virtio/vhost-shadow-virtqueue: used
 callback
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=connorkite@gmail.com; helo=mail-qk1-x72c.google.com
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

On Wed, Aug 19, 2026 at 10:15=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
>
> Skipping event_notifier_set() only suppresses this guest interrupt, and
> disabling SVQ notifications only suppresses backend call notifications;
> it does not stop backend ring processing. The error should be propagated
> with virtio_error().
>
> I looked into the virtqueue_fill() and virtqueue_flush() calls in the
> existing error path. The virtqueue_fill() call detaches the element and
> publishes it to the guest. Detaching the element is necessary and should
> be done in the new error path too. On the other hand, publishing the
> failed element is wrong and should not be done.
>
> virtqueue_flush(vq, i) is still required to publish and account for the
> preceding successfully filled elements.
>
> Regards,
> Akihiko Odaki

Thank you for the explanation!  I was not aware of virtio_error.  This
error path will now follow the following order:

    if (r < 0) {
        virtio_error(svq->vdev, "Vhost shadow virtqueue error while
handling used element.\n");
        virtqueue_detach_element(vq, elem, 0);
        g_free(elem);
        virtqueue_flush(vq, i);
        return;
    }

One thing still seems a little strange here about how vq->inuse is
modified by these operations.  The count provided to virtqueue_flush
in the svq code is the number of elements that have been added.
However, depending on which type of flush occurs, the value of
vq->inuse is decreased by either this count (virtqueue_split_flush) or
the number of descriptors in the flushed elements
(virtqueue_packed_flush, virtqueue_ordered_flush).  Also, the
virtqueue_detach_element always decrements vq->inuse by the number of
descriptors.

I'm possibly just misunderstanding something, but this seems like
vq->inuse could potentially end up in an incorrect state.  Maybe that
doesn't matter in this case once virtio_error gets called...

