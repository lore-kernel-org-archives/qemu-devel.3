Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCB4C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x639w-0003RQ-Ay; Mon, 14 Sep 2026 05:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x639u-0003RA-Py
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:39:30 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x639q-0001KH-1X
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:39:30 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66c744a00edso2270437d50.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 02:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789378763; cv=none;
 d=google.com; s=arc-20260327;
 b=cT7yFe9x4HusFVRxRNL4SQVOFzX5DPXKW/EP9Faq1y+ShYmE9UFYJhObLf/6e5VB+F
 6sOGdvpiK14uSRydP1+SfXQM6rorAh6kNIqj3iGZWN4GGakyq90zlFaqOqgiyGUMACn/
 W9s266yYW2/xQuL26ulQqQIoTO7dEPEiD1a6k//+LQRIBYPUAcNeccKctqneZByninHc
 E/LQ/wAjmCo/2GFi+czkWynee/IVjP77DhewSDQYolSp7AcX+1jiuU8iEzqDuy+ReHRJ
 mW3tlogLJNxnz5InQWpT9O+omQvfT/I9cSmQQujqYwNdHGFjLk+nOOqCHVEPDmFQnxr6
 jEsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fdRPondpWT3eTsT/g/79qrZvAktNWvgP6JNHQb3qbPE=;
 fh=OeH7OTjViatlmx0lFsRW36UoSyv0+l/u/cCvcQmcpa0=;
 b=N+RTUYGRBeaqaQ8xBkkqjexOnHA+SJmzYaClKOA+TI4d4bAeJ49zXOnRwDah0RUqXN
 FHCBUQVLlmoWzaicp2FM86QX83Zkkq1xRxwvmgUG+90kaIcDlFpE5qGkhYe4E8kbn8Qc
 6+l7Q+bh+oANLhBcrJ3rb+I3M8XdLM4Cy+l/WSR/V4CZ8PBbiWBdGGUQ8cyPsAEwd5Fb
 3nDBx3gLjw2e0F2x4djp7xwvRQNRXSvFHvOrEutqUg/0QvDJgLCrFau0B2kzAU4gVPLj
 wt8jk0c05fwxGOwpMPCAXwbHQQzQ8OtCGVEOkqoBXkgIjjt8kz1V9Z/0F56mv/kMIRqu
 wE7A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789378763; x=1789983563; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fdRPondpWT3eTsT/g/79qrZvAktNWvgP6JNHQb3qbPE=;
 b=FfllZLii3BKV4UrTDB8gRMA56h/wVluk1fTQvIL77I0y19gT5IybA7K5HSZYc778gt
 xWseLPJlVTx0+PmzcRJ0lotft7w+CJ81ccP189cni10U2HLS4InFrU76AWOeJxRjtMaI
 VR4fLa27BYkHDCELjRjUIV/W7zMnKT5+J5SPgqFGBMy1EZHt7lLXtiRIJpHzMZshVLvK
 ImRdlz8dMq/AONY83PDjQfRCxcJzvTf1v1uAF0TYAxthyNkVUvIhBRjF/S5Cv7jzvmg7
 gbXt2MuwcN9I4QVAWJSbH0h8LFdb82vStXwQiPRWYvF9FLZN62x892LC8N10Xuuumton
 WnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789378763; x=1789983563;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fdRPondpWT3eTsT/g/79qrZvAktNWvgP6JNHQb3qbPE=;
 b=ECzp4DgVSJ9uLo7HI5X8KRxxjI1YLjzh+ouLT32UJOi5GU8Rgawkmy4Tr1QWbOx06H
 e5XaQ4sYKJLF2Nxz998L0NiYg8bs9MWhZf3MDW8QRAuGv90eDcfnck3eiCKrNqjYKocu
 t9ZIbxjqRZwRw0TdU9TrELhnOV1enrQ/pHqqYk6ImvI7yLDxDaME+3DeeosoMtAHHH8M
 07MIf/DW4RK1NqfKz6kDNZhq4xohRTt5WAYP4/sEqF2GsA9bZ7Rei1jxLWEIH20XPrkj
 s8QS+rZZlSTcnUePr4ioj5XtAo2syiSvLLDvNeeSjFsv0xEKTkB2tTighAukEOhQ0une
 LACA==
X-Gm-Message-State: AFuF++kHiW7SZO9kGMrgbXKgxxLy8S1QIx/36dqLExwgEO7b6XAx7I10
 ySSy7DShP4IZ2xSZt7n8RmrunX7Agn3mffPotyg4rXRoqXuJcj16W7WMTwiqyJNcx7/fhcfxJ2E
 encSo8YpfGd4xD8QFMvrgLNkBEPbHr15bAinewQNPxA==
X-Gm-Gg: AYBFou0dxDxPW4UqV6B9bgNAg4E3OqF2pnH9jeri3E0AJdhQvMRh6qp0a089+3JtD1a
 Wj//9eOVy1L0CJNIzCqALRni6+irOCYYHdBXLyiIgcmLwIoxjIT0v2ZPXGiHA+0Q4LdiXUaXA8H
 2/EzMRcbY1PD3tweDjHhwFUWW44rsH/udl+hxV74GtRdQrxaGvmpLBXIUfcoGz5h+HHtPXj/IiP
 OsPDr2PJSL4kZKMWVYev0/9WOxMLh5gng55tp3eENfeA1U9MWCkV/FkwIUDt7s1tdCvm44P+vNT
 ClQb727Tjz/htGQ5JbQXzobgazUPJf8tCuZhBd0OQR+XFa6KOHXHGOo8N2f1i+qKnM6GydPX8Qz
 2pJO8nH5v49mJSF31cpz9ZOamBq/aYkz0QBUCa1w=
X-Received: by 2002:a53:ac93:0:b0:671:2228:1240 with SMTP id
 956f58d0204a3-6714e1a22c8mr282130d50.90.1789378763241; Mon, 14 Sep 2026
 02:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1789117222.git.mst@redhat.com>
 <5ec2a0b21fe5b8e1419a94a753636088d6b0409b.1789117222.git.mst@redhat.com>
 <CAFEAcA9sG8ijHjbJ6g8m0JZfpkAQ_Ow_Qxd2ep8Lui2Qe2L7hQ@mail.gmail.com>
 <20260914051629-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260914051629-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 10:39:11 +0100
X-Gm-Features: AcwNN1Xn2kHH4dFA4_Hxq8mdErFaZ7o4oFQnBCFhm1QfyFWNU98ALjUCLYKEbH0
Message-ID: <CAFEAcA-kLWfQTXn1JuaoJ2srhZF7xSGkdvBTO=K=F9L1k_2zkQ@mail.gmail.com>
Subject: Re: [PULL v2 01/75] virtio: fix exit(1) on DMA mapping failure during
 migration restore
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Mon, 14 Sept 2026 at 10:17, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Sep 14, 2026 at 09:47:30AM +0100, Peter Maydell wrote:
> > On Fri, 11 Sept 2026 at 10:01, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > When QEMU restores pending virtio requests from a migration stream, it
> > > calls qemu_get_virtqueue_element(), which calls virtqueue_map() and
> > > virtqueue_map_iovec() to re-map the saved DMA fragment addresses into
> > > the destination address space.  If the addresses in the migration stream
> > > are corrupted, and as a result dma_memory_map() returns NULL or a
> > > shorter-than-expected length, virtqueue_map_iovec() calls exit(1),
> > > terminating the destination QEMU process instead of failing the
> > > migration cleanly.
> > >
> > > Convert virtqueue_map_iovec() and virtqueue_map() from void to bool.
> > > On failure, virtqueue_map_iovec() unmaps any entries it has already
> > > mapped and returns false; virtqueue_map() similarly cleans up the in_sg
> > > entries if out_sg mapping fails.  qemu_get_virtqueue_element() now
> > > checks the return value, frees the element and returns NULL on failure,
> > > allowing the migration restore path to propagate a clean error.  The
> > > callers in virtio-blk, virtio-serial-bus and virtio-scsi that invoke
> > > qemu_get_virtqueue_element() during load are updated to check for NULL
> > > and return an error code.
> > >
> >
> > Hi; Coverity points out an error in the error handling code
> > added here (CID 1686764):
> >
> > > -static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
> > > +static bool virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
> > >                                  hwaddr *addr, unsigned int num_sg,
> > >                                  bool is_write)
> > >  {
> > >      unsigned int i;
> > >      hwaddr len;
> > > +    DMADirection dir = is_write ? DMA_DIRECTION_FROM_DEVICE :
> > > +                                 DMA_DIRECTION_TO_DEVICE;
> > >
> > >      for (i = 0; i < num_sg; i++) {
> > >          len = sg[i].iov_len;
> > > -        sg[i].iov_base = dma_memory_map(vdev->dma_as,
> > > -                                        addr[i], &len, is_write ?
> > > -                                        DMA_DIRECTION_FROM_DEVICE :
> > > -                                        DMA_DIRECTION_TO_DEVICE,
> > > -                                        MEMTXATTRS_UNSPECIFIED);
> > > +        sg[i].iov_base = dma_memory_map(vdev->dma_as, addr[i], &len,
> > > +                                        dir, MEMTXATTRS_UNSPECIFIED);
> > >          if (!sg[i].iov_base) {
> > >              error_report("virtio: error trying to map MMIO memory");
> > > -            exit(1);
> > > +            goto err_undo_map;
> >
> > If dma_memory_map() fails on the first iteration, we will jump
> > to err_undo_map, with i == 0....
> >
> > >          }
> > >          if (len != sg[i].iov_len) {
> > >              error_report("virtio: unexpected memory split");
> > > -            exit(1);
> > > +            dma_memory_unmap(vdev->dma_as, sg[i].iov_base, len, dir, 0);
> > > +            goto err_undo_map;
> > >          }
> > >      }
> > > +    return true;
> > > +
> > > +err_undo_map:
> > > +    while (i-- > 0) {
> >
> > ...but since 'i' is an unsigned type, that will mean that "i--"
> > here underflows to an extremely large value. This loop will
> > then iterate many times unmapping random things.
>
>
> I apologize, since when is 0 > 0 true?

Whoops, yes, I misread the code here. The loop counter will underflow,
but we never use that underflowed result. Coverity complains just
because it sees an underflow at all. I've reclassified the issue
as false-positive; sorry for the noise.

thanks
-- PMM

