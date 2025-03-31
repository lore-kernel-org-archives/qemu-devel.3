Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BF1C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 11:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzDmy-0005Mp-6g; Mon, 31 Mar 2025 07:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tzDmo-0005MS-Bx
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:58:38 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tzDmm-0001i9-Sl
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 07:58:38 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5ed43460d6bso7237265a12.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 04:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743422315; x=1744027115; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X9Q7+iUbtcz4D8sgeN/GGFaG6En9fHJBF79dOt02J4w=;
 b=g+o56oIzgE5Zh/fETWmWjma2okMFXbrshcDVcIpj9iphe06Yc1sWE0crUsKZVVErIy
 swR3GnCH9PmZomHpohjI7q6QybVnBSPlqsX8OV3jbFYS6sHVZheOSIczWPhywxX7UoAu
 ivc0OJT/pL1BtvdfjBWvKnxEq3OMhESjZ/di9zxKfHxFf+VsIeHBj/A09H21X/no38tP
 rTPXktx0BLVoDGnez8ERmuwTSnk1DL1Ff7sKhP3w+8JmuFA9Y7Scsc9iTcKADkTFaRAc
 wOllzdhdaAM6w37+Q+FLlIWxGui9HTi1/sDrvN+cCieLRXZYPY2y2n+R9XcpCCr830kR
 9QBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743422315; x=1744027115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X9Q7+iUbtcz4D8sgeN/GGFaG6En9fHJBF79dOt02J4w=;
 b=mcrrV+E4WSC3ISKV1PvZdN7Kd+rD53bC5pc1QGjnu+RUD2F/oUGqSiNzUO52iJXk8Z
 xOKfVgZVHXIpHtlyBmG0QS+iD4hx4M7hLagcTEQE2X3/5sD7tmDl1bH7Zel0eHUO+5sK
 e2HSEO1+obKzjRbVIBRq4Ssv4tsYonE48uiVIvbDxnfRtr3zuMPRVFCsh2oy+2wH7iFC
 4U9w4+RZgu6Axb/rVONDF9CqWxMv6Orl0ifnCVjrP1sd++QyPF5OzEqbpSxfrrxX6BZI
 OzXelPI7pEjhDt40zFPQLF6VJqzW97Smt/ivBmD6z+IEP3M73THCUH8ySyma3IXfiVXo
 CwIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtHvTuwPHJ0SGeRkNLzhXP/IrGLIJlwNqoosGRX6WMbhvTITP1HCDNAES2Hn4+/OkNEn+Y6w4ClJPS@nongnu.org
X-Gm-Message-State: AOJu0YwvkZmJce3t5AdadKCMxuVkqWr0BZbgtODzLohrDmxp3eBW6m2q
 7PY9oxslapmrwKF0AhVVxS4CuUx9cm/wGxEQGiSEDdisBjM9LBnNh70Vbt7LVCZnMmxBPldTDqH
 aycLEKPSk2k10B63R3NQs9HNJZAQ=
X-Gm-Gg: ASbGncsUqLtCA6NQyqK9GDujd3GlDvMJud0WyZNroVVIBNzxfa13mof7DSPm+m15SHY
 Cia8gWqZYZFDrzj9thDX4uwzkF9Xatnx/6Qd/Hv14vzN4iEDABcvKWjRwW8HXqH0fzAbXt2UPxE
 Zj1+YGVLeTQrAmex71ZwKc1ZXD
X-Google-Smtp-Source: AGHT+IGy7Xu6Anpk2z1hi3r7BFyjZr5WkbkZ7E1zWPgd3Xn7tT0ysnhJgmUhtpYj2Rdcdmo0ylQvFkgCjJdMe5YpsGk=
X-Received: by 2002:a05:6402:550c:b0:5e6:1996:7902 with SMTP id
 4fb4d7f45d1cf-5edfdf202acmr7177157a12.32.1743422315112; Mon, 31 Mar 2025
 04:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <87semtpjrt.fsf@draig.linaro.org>
In-Reply-To: <87semtpjrt.fsf@draig.linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 31 Mar 2025 07:58:22 -0400
X-Gm-Features: AQ5f1Jrh7cJ41M7IZDFLhZnOnEyKOHsHEvoy67545u1aYg910saCB7EF4uInz3k
Message-ID: <CAJSP0QW6=SvLwkuTsZTKqCH9OQJdH8XV32hDZ9Z4o6AbCbOqiA@mail.gmail.com>
Subject: Re: Central repo for VirtIO conformance tests?
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Rust VMM <rust-vmm@lists.opendev.org>, QEMU Devel <qemu-devel@nongnu.org>, 
 virtio-comment@lists.linux.dev,
 VirtIO Dev List <virtio-dev@lists.linux.dev>, 
 Bill Mills <bill.mills@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matias Vara Larsen <mvaralar@redhat.com>, Sergio Lopez <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x532.google.com
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

On Mon, Mar 31, 2025 at 6:39=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
> The unikernel utilizes rcore-os's no_std VirtIO drivers to discover and
> initialize a range of VirtIO devices.

https://github.com/rcore-os/virtio-drivers

I noticed that VIRTIO_F_VERSION_1, VIRTIO_F_RING_PACKED, and hardware
device support are missing according to the readme. Those are
important features for real-world test coverage.

Or is the idea to use the unikernel for low-level device
initialization and the Linux image for tests that do I/O?

Stefan

