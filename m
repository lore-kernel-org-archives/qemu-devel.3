Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B77C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 17:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2BWO-0006QP-A4; Thu, 03 Sep 2026 13:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <namangulati@google.com>)
 id 1x2BWM-0006Q8-0o
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 13:46:42 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <namangulati@google.com>)
 id 1x2BWJ-0005a6-Vx
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 13:46:41 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cda5e048fso67085e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788457597; cv=none;
 d=google.com; s=arc-20260327;
 b=XoD3KlpGqbrB9V5v3wrMqa0DRwzB77kPW7tXbKAHTGX7sPu649z6XkeVMMUaxnHbq8
 MvT/d2dmXoVgCwkaw+RoKdjixoQpH7TVKZ/AY4N+2ylMDmUqEIHnI1Gg8+7M9rw3Myhn
 /7thYiHqC4kG17SjPOBx14stBHVdRwIYBuQwAljItfecvvzfQySGUc84Fo8TaMTXLdUp
 RYwY4BQXjAySZVWWd1qQkR9DPd4inU3kvyoSJ58U0yyQ0Wjz3TLfLnfMcdRXrp2kMi7P
 CQqRPCOd/wSk56oTMJmY1yaCbEhvbDs2VaBxKqoTFYDq9F+IAeRrkRR3ljmMbLMIWzTA
 uqmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2fowOpZTxi+xe2ayPxtDnOLoCmD9y/rEJY815q5aK6o=;
 fh=nuYir6uzwHJ/v0JB8oZskGPFAnguCSG8KREUxLN9qAI=;
 b=K5R0exRsNbl51E1Y2kMnvfQCnlbpql8qVnfDIKKbwTZwV34PhnjpkwbiKrHXvAzTbm
 642jOsA0gXDvzONwxg2fy1CFeN8WXHxBN1nf5FS5ra8gzCMsQDU1tf5TG0fvF/36BDV0
 t8cU8/RKV70K4MiZX/hu4mL7Qy25QgNAiMTRNcy523/Sbuk76XDSEHHAO0UsPx9NpkjU
 JQig4zdEvPaGZosj9tRcp/sRAHaVohzHDpulKKwPMmON5mYsNvEL1+9e7yQ41pFIrn/n
 pRkYYkZ7Pz9085Ldd9HKX5edbWIOUtU4Zzb1pGTtncxPuqv8YXWFndlSpjsdv21gRfV/
 qf1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788457597; x=1789062397; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2fowOpZTxi+xe2ayPxtDnOLoCmD9y/rEJY815q5aK6o=;
 b=oHX/K0OfZ4UWoxxsiwRkZemLT+94X9StZP9yHYuMd6TW+/kERciwMT9IGX1KrdF3Lb
 RGKxEmHvQowuvnZP5MHc9XMCDEpwMo5s4BckvctoyMJz2z1myLdKb2E5jWVk83w1uZL/
 ZF3yf2L0ccD9J3lSOJz2b5JLAx+PNFMEEUHN8qEqc7tzsK53y+HTjaSpAEF3eL4UGEbI
 cy6ftvMl1sp7ea4vGo0r8+vGfITO4Q/QujU4z0mkZaa6ul0b/TiyTE1ezMQEw4yk2b6U
 DzHHy7cr02vI3nGFk9pw18lVxbXnH+cttHPVDhgIrUhZzfezjUHLBIXYwIZgih82vw01
 xnDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788457597; x=1789062397;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2fowOpZTxi+xe2ayPxtDnOLoCmD9y/rEJY815q5aK6o=;
 b=iXA7do2opFjgC9o6671dDjjn8TuckeaWu6ObwnsrrbjrM3zsIPWLCLXYIM4qsnRm7n
 X3gNHl1osU8X+EWnW0MxWLlv4wyC2H4+N86iaBiFKk4rd8uCDBb/AYqWAgnEmNxZ8STJ
 S4jx72QtETVpdii3ZWfVH0puYi/bC13X0QeoaN1URAd4xBLf035H52PscMyU0DiC25Lt
 aK262bM3xs/mVtALV4iuWhWpoZHy7/7w3drddnYstncKHy8b592ihVLUvUIUCy75Ddqr
 WAI24gS+++NLSplGtYYMfBFIzLa01zQ2E8vxpdLpyB1yIKzSF3ubdxBJ+DuZ+DTEnIYX
 Ey1g==
X-Gm-Message-State: AFuF++m0DZPMbXp9hNeeE97MuXXkVzviqODSiC3uMQ481g+/FOoJ7i1B
 3h1seNF80T9Cpjjg+rMPYSrcdw1vzddK301Nca+GjlVqu180BIz98GaMcvdCuP1jM1s7ktgXciA
 QoBfidhZpQJEe+hlom2FzScgNiDqpuYQuVP9yS+I0aUuvz5g82fZHWiY8
X-Gm-Gg: AYBFou0G57vYoZ/nA2IuKbOCtGHI35o2NM4kCWkEpFCJgu55ul6/IhGYGWvoAwE5pUs
 lVuMwugWCmpXb56YRG/x51SDbA6hW6HDbde3SAV/dzZw3SeH8c+d0INRRyIwa9u0jZZCi1bAFtG
 oscFqzHr1OWFP28xdcPgNq82Erm2BAwMK13J4BAyIERzQAieofV+sO7SMu7ctdkmK94mH4peTt3
 EKekrHt1QQoEbI9A73auHgkF+Q2RColZEd6Cb0qWRnf9dKlvfv7w/dbDSB2VSEW1Kq6+lRrUCwZ
 xU7QIQuU10egFL9x6tO1jKR6buIZcVbplwjMYZ0pv40h9ybAg6IrJ6vz8a9ip3ToEUU/FvcS/tA
 =
X-Received: by 2002:a05:600d:864f:20b0:49b:8f5e:51f6 with SMTP id
 5b1f17b1804b1-49cf76fc502mr27305e9.3.1788457596932; Thu, 03 Sep 2026 10:46:36
 -0700 (PDT)
MIME-Version: 1.0
References: <20260826050039.2068138-1-namangulati@google.com>
In-Reply-To: <20260826050039.2068138-1-namangulati@google.com>
From: Naman Gulati <namangulati@google.com>
Date: Thu, 3 Sep 2026 10:46:24 -0700
X-Gm-Features: AcwNN1UdUr736Z_xW003M2B3Cgny2tMgbCnoT3w8AWCjVfYXNc9QJlK14Ejny-A
Message-ID: <CAMP57yUuJUrpPtvf6Nf5SoDZ7Z+dfXFmHB-0AJ+vhzysjvgxYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] vfio-user: support multiple FDs backing region
 mmaps
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Alex Williamson <alex@shazbot.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Matt Evans <matt@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=namangulati@google.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Gentle ping on this series incase it got lost in the noise :)

On Tue, Aug 25, 2026 at 10:00=E2=80=AFPM Naman Gulati <namangulati@google.c=
om> wrote:
>
> This series extends the vfio-user protocol specification to allow
> servers to pass multiple file descriptors for different sparse memory
> areas to be mmap'ed within a single device region.
>
> This extension is intended for exposing paravirtualized PCI devices via
> a vfio-user server that may have multiple unique sub-regions in a BAR
> backed by some mmap'able buffers sourced from distinct file descriptors.
>
> This change introduces a new capability:
>   VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS
>
> Unlike VFIO_REGION_INFO_CAP_SPARSE_MMAP (which maps all sparse areas
> from a single open file descriptor), this new capability defines an
> array of sparse mmap areas where each area contains an index into the
> array of file descriptors.
>
> When all sparse areas share a single file descriptor, servers may
> continue to emit VFIO_REGION_INFO_CAP_SPARSE_MMAP and send exactly one
> file descriptor in SCM_RIGHTS for backwards compatibility with older
> clients.
>
> The extensions in this series also lays the groundwork to make use of
> the in-development series [1] extending vfio-pci to return distinct
> dmabuf FDs for discrete regions of a device's BAR. A vfio-user server
> may choose to return dmabuf FDs for various regions of a device's BAR to
> map a vfio passthrough device into the guest, in order to retain control
> of the device and be able to revoke mappings passed to the VM.
>
> libvfio-user server side changes WIP on github [2].
>
>
> [1] https://lore.kernel.org/all/20260715174737.15287-1-matt@ozlabs.org
> [2] https://github.com/NamanGulati/libvfio-user/tree/multi-region-fd
>
> ---
> Changes from RFC:
>   - Refactored the get_region_info callback to keep vbasedev constant
>     and take in a VFIORegionFDs* out parameter to store the received fds.
>   - Link to RFC: https://lore.kernel.org/qemu-devel/20260811233930.401797=
-1-namangulati@google.com
> ---
>
> Naman Gulati (3):
>   vfio-user: add multi-fd region mmap capability
>   vfio: mmap sparse regions backed by multiple FDs
>   vfio-user: implement client support for multi-fd region mmap
>
>  docs/interop/vfio-user.rst    | 71 +++++++++++++++++++++++++++++++++--
>  hw/vfio-user/device.c         | 66 ++++++++++++++++++++++++++++++--
>  hw/vfio-user/protocol.h       | 20 ++++++++++
>  hw/vfio/device.c              | 49 ++++++++++++++----------
>  hw/vfio/region.c              | 41 ++++++++++++++++----
>  hw/vfio/vfio-region.h         |  8 ++++
>  include/hw/vfio/vfio-device.h | 32 ++++++++++++++--
>  7 files changed, 249 insertions(+), 38 deletions(-)
>
> --
> 2.55.0.860.g4b6b3295ed-goog
>

