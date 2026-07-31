Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA56C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 09:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpj62-0001QR-J8; Fri, 31 Jul 2026 05:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpj5y-0001Pr-Mz
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 04:59:58 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpj5x-0006Ub-8U
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 04:59:58 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66896892b6cso906840d50.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 01:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785488396; cv=none;
 d=google.com; s=arc-20260327;
 b=DEy04YNWAeHBotFaUyYlrHsfT3rC5+gvRydy+zjIcb0xWg05P8P8OVq7toT84WopUH
 TrObT0OvLdjBmCoWb5jRPQ2q3kQ5pYOHf3Y0oQl+UeoBKMMYPAMpBnD9stCZg7r57Xow
 0ByqdRvH1shHAPGdCmZw12RGFHIav8thUOmEOtTQYhRB+S+lG8qAkmiAtIfqLw0v19Xd
 sorsPaqVl4ZfMfUBAm9J4nvtKmzKKFYfIo9PJRM+7zWOuDbx6f5CN2+cbvKZ6Ot+YAtN
 WJGbDELBAA5Xht8FdbxHCbiOqYeGQ6i4Ax7gieBiA0FEOlzeZZ6TDJao7ECS3u8YQuJs
 8OzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IsydLot76w3eidElrGPmDpd4sMHiEGvBOFtffxfRRVk=;
 fh=eRUqeC8DPT7cnb4jpGU743my6BNCpePU8WoTBlruAIg=;
 b=LGKqezrBPyEjMN9ao3Iqg7835Ui3T6VlnyEch+WaGzy8ONyVMgRnoYeSn4gs6P7IwS
 6AkRvqVxbQIqga9vj8QR2mVU4OlYhv6dSAH+e4pITcRu5IrVJlSDdlDwwUhvYYvrCnVv
 x1Xa+E3UCX7/s5+F+siIPhJWRjAoOlZHE36G9JpuavxRx0CwmuLsVxGmfpGv/9z7dMGB
 aeEhQ3hz5g9vH2h6YvZit0tUOFhcatYj/ZBki8obqVjqxlGdXZ5IgDmSvXZX6DuVnaT1
 Z15UIh9DETbrpsgWJ2tjwNp+Zkg1W07XWiY+bRcFfGRdIkSr87k9uZQA4EaJ4SH5/W0N
 mCoA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785488396; x=1786093196; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IsydLot76w3eidElrGPmDpd4sMHiEGvBOFtffxfRRVk=;
 b=wEbjqmStcxu1bL+r8DDoVYp/0PSlmDBS+o0E1nAcPXnh982tnkMJ/tZYAHjOjZWJZI
 j73P5kdPv479R/d2b3qSZ/gtmhQQg1cTLi5Ao0SUrtfeabYRztK/7w35wlcUbHILmVQS
 jSXe8MXUUKX4y+1YsS4q4cPcjqxdCzylfUv7kZ4GdD4nN9dcovWQDEgA2tOYNapxdvk0
 KYL9TnCIh2ufYX+UU3gBu1uFpN7ljoWmEC3iy/WfrIWT2IqBqq6t2L5rsd5nNMTGKLsi
 ybnClpIdQyi3zPzzTS+JS7JHelwwLYUsYn9/DtSU3Ef3L+0hPutAjkvXG0EnQ/kJMuvm
 lacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785488396; x=1786093196;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IsydLot76w3eidElrGPmDpd4sMHiEGvBOFtffxfRRVk=;
 b=I7k1B8p60TZVnPGlHc5E5p7Z0x1caduck1NnJHN75YZrKm1nqVHspMrkGL7uj10qDO
 K5u87gvYBJ/5PreIGOdSr92F/Azcn9h8ndMC8NMQkro2DeFCCKuMyncxRV+RMiWDz17G
 2Zvcqz6ARXoI/VZAz8NFMxgnO6WihFTI7rys2UCA0B2Rzydr9I/Eo4xXJzJWlP88w9iI
 Pb5jLJCzUnktYBYEzF2KZqvPoFKGdjXteBb9rL4u6Q0BACQbUz06Yn+GYS/ahJkKu1H4
 bGTKKm7Tf+vYraqneGpWQzV/4zuTk4hJGlAnKguiZMfGgLYa/An9UQYSc3jDkxwTrBio
 D56g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6gHDT359VUECWbUT8w9WNpt7aD80sWkXoqp2aQB0g25xs1PzNwnUeF5PIuBftv6Z9b0herN1GWvCq@nongnu.org
X-Gm-Message-State: AOJu0YxsyX9vl+S3cW+GiqAixl9+7oZvZtvMAbT3dOuP92hmRrnoqho/
 hEHDfSzxjAKBzpVlu69SoA7jjp4hmxynYVug/sSDxUey7BuVWJ8/ryF62LUWnmLDwy0QvIIRufE
 wswBXOlEnGTdvY5D8a8nUVM85EflPaRPnHaTL3Ykn+Q==
X-Gm-Gg: AR+sD13yjcHXl7SNZpcrJptj0QdxC9MTgvTWw3iyxfPnWQmvToA+ghmfpypumfmAXQu
 gUWKZN32d15O8cT8U+G4xdmzbAo/TAsJKSsbXdBN5ch1tqKXa6kahVbRxLavJ3rL5hSfY9FcRHp
 iWEgCBMooKzboPWiSQdbWharJl5jIYqmnEergIrNq9S6YpuJnWqJkysZGl8Wrb8XrOp0JFhYWwN
 AWyyNVBNrdROR0tIt2ueDEIyP8Kapl6U42QbYLP3l2AH5MnGHRVdyF8RxLct6kqt9neLi9KW7CP
 VMxA5TchbFL+p1Bhe13M/zWXrWnTPck0z64GGDB0YU9957MU16e66swpgmjqVlcXbNkWOTBUP65
 9JWH9xWMEwyigixBVLQrUCSKZLjrwqf/gKHiLDsE=
X-Received: by 2002:a05:690c:4807:b0:80c:76fd:f732 with SMTP id
 00721157ae682-81fcc026845mr7407087b3.26.1785488396054; Fri, 31 Jul 2026
 01:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260730205846.19479-1-stefanha@redhat.com>
 <20260730205846.19479-2-stefanha@redhat.com>
 <eef9784f-5e68-4f1a-ba12-85ad4128116d@oss.qualcomm.com>
In-Reply-To: <eef9784f-5e68-4f1a-ba12-85ad4128116d@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2026 09:59:44 +0100
X-Gm-Features: AUfX_mwgJ7FMSI5Sa--UvMnht7cK8I1xFB-yWuZ909qxzFa9jyxO6z7tQ5Cx9hI
Message-ID: <CAFEAcA-3zzanALJtPpOnd6iiVsgz9f9Ek5EHtQqQC5-6=0XogA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] virtio: make virtio_add_queue() queue_size an
 unsigned int
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 virtio-fs@lists.linux.dev, Hanna Reitz <hreitz@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Alexander Graf <graf@amazon.com>, 
 Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-block@nongnu.org, 
 Greg Kurz <groug@kaod.org>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Amit Shah <amit@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 31 Jul 2026 at 09:35, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hi Stefan,
>
> On 30/7/26 22:58, Stefan Hajnoczi wrote:
> > virtio_add_queue()'s queue_size argument is a signed int. The
> > vdev->vq[i].vring.num and num_default fields are already declared as
> > unsigned int, so change the virtio_add_queue() argument's type for
> > consistency.
> >
> > A note on consistency: the VIRTIO specification defines queue size as a=
n
> > unsigned 16-bit value.
>
> Why not use uint16_t then?

That's a bit awkward sometimes for a function like this that
is doing a bounds-check on the value. If a caller passes it an
argument that is a bigger type, then this function sees only
the lower 16 bits, and it might pass the bounds check, but
then the caller thinks the queue size is larger than this
layer of code thinks it is.

As a concrete example, the virtio-scsi callsite passes in
a value that is a uint32_t value settable by the user via
a QOM property, and it relies on this function to do the
upper bounds check for it.

-- PMM

