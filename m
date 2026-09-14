Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2CEC88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62Lp-00026r-SB; Mon, 14 Sep 2026 04:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x62Lo-00026X-PJ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:47:44 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x62Ln-0007FJ-25
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:47:44 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-6713d20d375so1089416d50.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 01:47:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789375662; cv=none;
 d=google.com; s=arc-20260327;
 b=ZjMNKuCOjZCZupscM2edDNSxLcIHeQJ9mRD1XbE7/X9HMXo/CQ7z/4qVZlxeABikZQ
 CXNelU6p0YQw3gJ/ymoe92rQ/xhRVTJwjyq1s9VR2GwFsJu6asdoeMdv13Z/FFuN0Ufj
 pgFC1d67wcVlD9v6RvV1idIvc+02pUaEgULfbUcr/KVfw4Q6Gy49T+KMMf3H/6DdjVv1
 evGIr4fu9rhpcqzGROylgeivdQ+F9x8o4Du/FvDcNyHSJsWq6elV6x9wy1Y7zIMVqObQ
 E+Gpavml0SXP4ct1nnY2WLa83eiwwvItYVQQrSTn8ddKVLiBQKNiy9ys9imhgTgx1VWU
 fBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2JtW1O4fgmcvzaTWO6qEbTdakN4/wjXQB0I8Ry12PdM=;
 fh=OeH7OTjViatlmx0lFsRW36UoSyv0+l/u/cCvcQmcpa0=;
 b=ZGfdqYb4UJZIhNniuj9klo7GJBWn2Tkma8an8dT4eei5xB0ybS+vGRC1BWjs66JO+h
 8c2t4DejL/pUdYmakKDGS8P9tu8g/2aslrKOlB8efYEk0VtvuFAi2K8S5cOQSpfgPFXC
 yuUNjmFRctWxJvf5LMmkHfW3+t0mgeTLRjuFsZlnAocTAe/sFodOKC/DfHOCqmg2apzM
 txNritxskpqUnqs4SbWp/71tJvYvvpECMyxhFBRvfBKUR2YjvzWxSjQ/PJmgF8FovwuF
 7JwpZkpNYoL7VmgYEan/EUz93c/8R9dbe5q/mZ/0lG8mm8Xapv3uV/S2NiM4M0ifBft0
 1kfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789375662; x=1789980462; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2JtW1O4fgmcvzaTWO6qEbTdakN4/wjXQB0I8Ry12PdM=;
 b=NA60OuNsm42YRAs5nV7blkJ2sOWIiAJBt/g08ygGPeWZN7rQA+euaiUCVM3Iw0E3xu
 VO/4WTd09bV90l3iJ3zCBIPNUJgqRvEEr+8EeLeW/jHoUFeROywqmD73xLIVgnt2zsqX
 lXaExC3Or+oT5a5n8CWQMRf+cNDEmFavFB5vdfkzC+KirlRWcX/kV5EXus8OtufBuyF/
 UC49zGEQQ7fjygv2qfV0gEeqXK5p/6+oI6E++lIrzrh/sjxHgC2mT9KUxhHqbvNaIu+L
 RL0XEHlmViCZDAcCTRc/47cm5Bpub+r1wwVd+hBf4TVaSbe9IDEbPSVTiet0D8eyqYhe
 nw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789375662; x=1789980462;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2JtW1O4fgmcvzaTWO6qEbTdakN4/wjXQB0I8Ry12PdM=;
 b=qL2XqbacEQAJoU+r6WTXIGjltJz9uwgQ5PM+FSFWeLue0YE5wpKiyI3x1XHOj0vSap
 bUGOGYmgdbI1d5wT/lLRU6tBc7IiNLSesoglQFz24P/qZUo8f4kO+eoHsigJS0HfYvAo
 DN1jKvlfjvvND78UmY4YBEG2a7wQW4ekQzC1RMdUgbe3vwF4DjidExPYIEDPJjKV3ayx
 9KP6HJNq7I0mSH5wJ6a/qfgSU2AHV5D9vPHOnLFRgpHY7slLkacYxresoB+yjFUXV9oZ
 tSX5ynahQEF4G7MJd5hwrwgsNX1aDZqkUwwIKnTfuEZLxsRhc0IjqQVLCkVLFqlqgi8A
 lh5Q==
X-Gm-Message-State: AFuF++lI/C2ITWGfgBxolIzeVpB8b96Qrj3aprLddfW3pBwmhhBLQSem
 D59/83kxHhwtFyhX7J/e5v063pCeQRk8V+IQxy8psvZRb0GvhW38Lq0TrpRygCTfZKPp5c0hE2T
 UalStcH07EK5erNBrQIEqXf31T73/HDmqtzDSnXMDnw==
X-Gm-Gg: AYBFou1lehq+oQ7BAqt1a8Dp/hB1khH4v+GiQd2efzrFk8bnUDCnKiXo/rfZ7fuLbzM
 mncg9gWXGPcYiusLCilLFjiVRJMVbyUY12+YoeucTLAq5uUeaN1qrPUF6IZZzeT/Xexw8pHz0RT
 j0dASIEOpCcb89XCYiYGegFrR/wo5JjbrkwlJfQugwu3U9HbToEDav93G7+YZoIcCTIYo2FJrI6
 1vm335mKJlpN2NVlrM/8quQjhfq4Wh7JvfNKsQuHZexbBWZFupS8xqP4aQk750ApGzPrIlgKbzg
 lQkX8j/FF43xBawHaQaWAfx7/PU5DJ6K2rtvRhIxH0cVf7MW5I9UtrHLGOohjSv+knVzz7qU+wC
 aBpJH2E5+DPNLPdwPKxmFQDHLcBNsTXbuDQplrRY=
X-Received: by 2002:a05:690e:13cd:b0:66f:c1be:84e5 with SMTP id
 956f58d0204a3-6714e1f3d49mr257397d50.83.1789375661733; Mon, 14 Sep 2026
 01:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1789117222.git.mst@redhat.com>
 <5ec2a0b21fe5b8e1419a94a753636088d6b0409b.1789117222.git.mst@redhat.com>
In-Reply-To: <5ec2a0b21fe5b8e1419a94a753636088d6b0409b.1789117222.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 09:47:30 +0100
X-Gm-Features: AcwNN1VQzahoYUiYg-O9ILDj06boDEz0-hkdAWq9-lzYBOCVxe6YgXx-Q7tgjhQ
Message-ID: <CAFEAcA9sG8ijHjbJ6g8m0JZfpkAQ_Ow_Qxd2ep8Lui2Qe2L7hQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Fri, 11 Sept 2026 at 10:01, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> When QEMU restores pending virtio requests from a migration stream, it
> calls qemu_get_virtqueue_element(), which calls virtqueue_map() and
> virtqueue_map_iovec() to re-map the saved DMA fragment addresses into
> the destination address space.  If the addresses in the migration stream
> are corrupted, and as a result dma_memory_map() returns NULL or a
> shorter-than-expected length, virtqueue_map_iovec() calls exit(1),
> terminating the destination QEMU process instead of failing the
> migration cleanly.
>
> Convert virtqueue_map_iovec() and virtqueue_map() from void to bool.
> On failure, virtqueue_map_iovec() unmaps any entries it has already
> mapped and returns false; virtqueue_map() similarly cleans up the in_sg
> entries if out_sg mapping fails.  qemu_get_virtqueue_element() now
> checks the return value, frees the element and returns NULL on failure,
> allowing the migration restore path to propagate a clean error.  The
> callers in virtio-blk, virtio-serial-bus and virtio-scsi that invoke
> qemu_get_virtqueue_element() during load are updated to check for NULL
> and return an error code.
>

Hi; Coverity points out an error in the error handling code
added here (CID 1686764):

> -static void virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
> +static bool virtqueue_map_iovec(VirtIODevice *vdev, struct iovec *sg,
>                                  hwaddr *addr, unsigned int num_sg,
>                                  bool is_write)
>  {
>      unsigned int i;
>      hwaddr len;
> +    DMADirection dir = is_write ? DMA_DIRECTION_FROM_DEVICE :
> +                                 DMA_DIRECTION_TO_DEVICE;
>
>      for (i = 0; i < num_sg; i++) {
>          len = sg[i].iov_len;
> -        sg[i].iov_base = dma_memory_map(vdev->dma_as,
> -                                        addr[i], &len, is_write ?
> -                                        DMA_DIRECTION_FROM_DEVICE :
> -                                        DMA_DIRECTION_TO_DEVICE,
> -                                        MEMTXATTRS_UNSPECIFIED);
> +        sg[i].iov_base = dma_memory_map(vdev->dma_as, addr[i], &len,
> +                                        dir, MEMTXATTRS_UNSPECIFIED);
>          if (!sg[i].iov_base) {
>              error_report("virtio: error trying to map MMIO memory");
> -            exit(1);
> +            goto err_undo_map;

If dma_memory_map() fails on the first iteration, we will jump
to err_undo_map, with i == 0....

>          }
>          if (len != sg[i].iov_len) {
>              error_report("virtio: unexpected memory split");
> -            exit(1);
> +            dma_memory_unmap(vdev->dma_as, sg[i].iov_base, len, dir, 0);
> +            goto err_undo_map;
>          }
>      }
> +    return true;
> +
> +err_undo_map:
> +    while (i-- > 0) {

...but since 'i' is an unsigned type, that will mean that "i--"
here underflows to an extremely large value. This loop will
then iterate many times unmapping random things.

> +        dma_memory_unmap(vdev->dma_as, sg[i].iov_base, sg[i].iov_len,
> +                         dir, 0);
> +    }
> +    return false;
>  }

thanks
-- PMM

