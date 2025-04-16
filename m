Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB79BC369BA
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 18:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u57xN-0000b5-Ul; Wed, 16 Apr 2025 14:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u57xD-0000MB-5h
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u57x7-000393-Mr
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744829859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZcRZwiN6j/slUai9WeqVIDyBWThPVlYrO/NlF8t7qTA=;
 b=SczOYlkGA03JRsV21bf7hKoDCSLOuuJ23G+5TKXbAqcJOyqpO/lR0V8jpulBP3zMB5p7E0
 1/fZL0ZQzbcpzbrr/G5BYKEmCehQ1LZetaTjvTE/A8b9MVIz78kBgXarZctYgRdKfS341n
 q3x4a967KKovMc38YE7QMrlQAGBGvqs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-t1gQflfuMO2MARHaqqexEg-1; Wed, 16 Apr 2025 14:57:37 -0400
X-MC-Unique: t1gQflfuMO2MARHaqqexEg-1
X-Mimecast-MFC-AGG-ID: t1gQflfuMO2MARHaqqexEg_1744829856
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912d5f6689so3973873f8f.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 11:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744829856; x=1745434656;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZcRZwiN6j/slUai9WeqVIDyBWThPVlYrO/NlF8t7qTA=;
 b=TI9IxftfPjN4tWkJr4rfP3mMG8b036w3IZ+y+5aAxBn42y8cUseXpnJqW4dUoxi6HF
 Djc2pXv9/e30+t/Ufcux+Kd1T6c0V4qcNLc+p4ZxMGNIkujUcbbb3WjcGxy6jcyTbRxr
 anf+nB3x7fenybcI8YnYCfupJtQ03f4GJPiNxM/5SBUnvdi45PmaFP97+CHsdkCfuFR8
 dkASa94JNOn24yLzpOrACDhVj2VWDEBCbQsNBRn7SU/4GSt/tGAPhSSv2zqe5dUPIKh/
 WCb/+qV8oh0qgQZh/3eD8pQvQqdPwz+42OqjsmKVmqUGDJUuzQL2+OrzCX6RZ9nfvYGL
 3Iow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvzvUKsd+W1lY4DvRjD9YH2Pq8rza6KQxX+Zv8vA1GR1EE+ZtLAOCvVjeMSoebWewY1gVdHNkp1DgE@nongnu.org
X-Gm-Message-State: AOJu0YwgeSRC3ZbXXf5Oruu7/i+izz8ZqD4Z0Y+jPeo3QRTS5CbTPgrO
 +oPQGUoLywaUWOzxfIXHtaT/Bvqz407djtZ0VMrocCucBa+Wxh4j1iPZats96CW6YL3shxu7ITA
 AA+lgbSZM8XuvTy/Ay8PFArh1g/lxzzDvMcpxNkD2RVSv9r2umuRt
X-Gm-Gg: ASbGncsqxqHmcAaEhRimX2+nmY8+Md8Dsg2wbZ1fxw61vuAb+4eBMYQyPAEsbqf0BQl
 PXmIUO44GseFfESd65Dc3LVFI+C1lOdT/cpmS9aFEn75w9Bs09518PY+v3CYUn4ueP5xigE6C1k
 Hk0rEnOQmsCPt2zNiobXw1FbcuMEbNI13i9VNeU9+MKLEaIlAJ6LLbEM3sY3boVMtmPeSwkEZei
 tlyjSChyv5UvLQhUKF3SijT6tliBeu6ZLAojquG65UIjqONwJgfkwEit/tGloiYcSmvbNCOhTa/
 e7zdRg==
X-Received: by 2002:a05:6000:420d:b0:39e:cbe3:17c8 with SMTP id
 ffacd0b85a97d-39ee5b13951mr2286164f8f.12.1744829856035; 
 Wed, 16 Apr 2025 11:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcACzB5If9KHN35K9dcOboSe/iy/DdLor86VdvbK4EVDU1TJDT0KuBGasCo6bbYr066jigcQ==
X-Received: by 2002:a05:6000:420d:b0:39e:cbe3:17c8 with SMTP id
 ffacd0b85a97d-39ee5b13951mr2286148f8f.12.1744829855664; 
 Wed, 16 Apr 2025 11:57:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf445515sm17421436f8f.89.2025.04.16.11.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 11:57:34 -0700 (PDT)
Date: Wed, 16 Apr 2025 14:57:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 0/3] virtio-gpu: fix blob unmapping sequence
Message-ID: <20250416145701-mutt-send-email-mst@kernel.org>
References: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org>
 <87v7r5clft.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v7r5clft.fsf@draig.linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 15, 2025 at 07:46:14PM +0100, Alex Bennée wrote:
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
> 
> > A hang was observed when running a small kernel that exercised VIRTIO 
> > GPU under TCG. This is an edge-case and won't happen under typical 
> > conditions.
> 
> Should I (or MST?) pull these into a tree for 10.0 or should they be
> grabbed for when the tree opens with a Cc qemu-stable?


Let's just agree who takes them, then it's up to that maintainer.
You wanna merge them?

> >
> > When unmapping a blob object, its MemoryRegion's freeing is deferred to 
> > the RCU thread. The hang's cause was determined to be a busy main loop 
> > not allowing for the RCU thread to run because the kernel did not setup 
> > any timers or had any interrupts on the way. While fixing the RCU thread 
> > to run even if the guest CPU spins is a solution, it's easier to fix the 
> > reason why the MemoryRegion isn't freed from the main loop instead.
> >
> > While at it, also restructure the 3 stage cleanup to immediately respond 
> > to the guest if the MR happened to have had no other reference.
> >
> > PS: The hang can be reproduced by running this unikernel with TCG 
> >
> > https://git.codelinaro.org/manos.pitsidianakis/virtio-tests/-/tree/8c0ebe9395827e24aa5711186d499bf5de87cf63/virtio-test-suite
> >
> > v1 to v2:
> >   - Add patch by Alex to prevent double-free when FlatView is destroyed 
> >     from RCU thread.
> >
> > Alex Bennée (1):
> >   hw/display: re-arrange memory region tracking
> >
> > Manos Pitsidianakis (2):
> >   virtio-gpu: fix hang under TCG when unmapping blob
> >   virtio-gpu: refactor async blob unmapping
> >
> >  include/exec/memory.h         |  1 +
> >  hw/display/virtio-gpu-virgl.c | 60 ++++++++++++++++++++---------------
> >  2 files changed, 35 insertions(+), 26 deletions(-)
> >
> >
> > base-commit: 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro


