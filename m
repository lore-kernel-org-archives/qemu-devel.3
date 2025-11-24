Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92C2CFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 11:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNUPv-00079Y-Py; Mon, 24 Nov 2025 06:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNUPQ-00075V-Bq
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 06:07:12 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNUPO-0003xZ-Ap
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 06:07:04 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-63bc1aeb427so3295756d50.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 03:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763982421; x=1764587221; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UVYDXx/CpSbW0tAgz27enpYiZ3GMud9tEzwyPLPvFTA=;
 b=nS60qoYyzaUYQjIspucymypYeBTycFOJEzq1gr4dHec2BWYiDxTc3Ue6rFPPFJONUM
 VLqtZjnXoS5uj57epPzYWSjqfxBm+ybk7S/gJuHVDM+k6zm5htA+8QiVJ1pHXSLwswe5
 HPEZiEr6CfWUJUPEwoEQYo6L0dRRrtNx0BrIMPUrXhvpjEIgOC3/3MH33wYMVpx4bh98
 3ccoZzlSWLmGLxsk2OKDYwYGw9SJvFj4oCv3vpc+Vwll2AO9IZfHh28fE5PFLxb2OciK
 E73rzNujhpVBx1DPeX61zr7hDDTJ/ndMrpEtCN02im0gckUVchHtdv5fcQ+vEfIz6I5V
 IQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763982421; x=1764587221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVYDXx/CpSbW0tAgz27enpYiZ3GMud9tEzwyPLPvFTA=;
 b=FfOZf8Wma7ERP6yzD3bgIsaBx8yfet9dI0h6EQZG3YiJVZ5kSW6ehaIRbjhSoRL+qf
 ERrDsFhp2F2WK9ZRgSnLzlCYmh5nD34XNdymOr/d/EaV2ZqAY7MQq7aKK6I1rucSEpe6
 GsFH8RxVRqGsiXlUHny4OCw83w1mvnswoEcm8XWyykSUaCpstU+avT8OKyxK6Rhymy8u
 c6X2PjWSotD2thNHENavmeve0DKgwH9MVNymwGVjjD/xsMHr7ODjbYEBee4GJwL4KR7+
 9m48s0sI3W8bo12BHWzCBLQ/y+axaRaIukc5XRnRh8eEyG3ElYVMUFNFShR9yWWVXG6v
 jouQ==
X-Gm-Message-State: AOJu0YxPmnCgNTHX69dimb2dbAdcQIVzbhkMlX9q1Mn4qjviI0pX7fR7
 9lbX8GG2CBZqKbv3wiuMunXVfYfVyArfOIc1rYVzUhYTyeqCBxPeNgJLaRZzLuEb9T54ztmLXB8
 W1ZOk01g1EPbD6U0pWzUSej2MnQcE7Ow9q+gcOeiPKEpYblZdvrAY2mM=
X-Gm-Gg: ASbGncuYGpfyNeeYWFB0yDEhPoId5L8YClysDcs3uAFuQEOm4LcrpyiBGpCrEtyhuro
 /xP2sYDv1QTLEMszu4UmnIivx10ktmSC4x2/6sdhl5w7oTp2tqwuUEHJ9IZvmdhkUYWiF1NjQwt
 cLbrUmROLBFEff8QW+ihgYZFBlCFIpuVzPrnjaUkszyVRcAS1o5k4yIgZPXJPUtcs5J8yThMXOT
 5JFMNbfU/WEUif5pgiDXoDZIfMzF42v6BU/mHFkCiN7vxuQhWwO7s/B2eTxjMTdq+WOJcmQysmm
 Qj4C4Lw=
X-Google-Smtp-Source: AGHT+IH/H2ZD7TyKYhNh6Vv9kyf1K/f2W40BCELEubp6Vvrxv0sPqfEWHvNehYSqpNyEHR0BNeuDWmppgZcHHggc0aA=
X-Received: by 2002:a05:690e:128c:b0:641:f5bc:694f with SMTP id
 956f58d0204a3-64302af1699mr6789712d50.83.1763982420883; Mon, 24 Nov 2025
 03:07:00 -0800 (PST)
MIME-Version: 1.0
References: <20251107131044.1321637-1-peter.maydell@linaro.org>
In-Reply-To: <20251107131044.1321637-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Nov 2025 11:06:48 +0000
X-Gm-Features: AWmQ_bkpgEXkeonkzYqQKMaPK9ZMUWmwOurXtnuLIiJXAXcoahxMeroecQKPTz8
Message-ID: <CAFEAcA8Hi0LfjnDVGZ7SVRtSpaOPnNA0aMaBxba+MDewbeMd=w@mail.gmail.com>
Subject: Re: [PATCH] hw/pci: Make msix_init take a uint32_t for nentries
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

Would any of the PCI people like to comment on this?
It's been reviewed, I can take it via target-arm if you prefer.

thanks
-- PMM

On Fri, 7 Nov 2025 at 13:10, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> msix_init() and msix_init_exclusive_bar() take an "unsigned short"
> argument for the number of MSI-X vectors to try to use.  This is big
> enough for the maximum permitted number of vectors, which is 2048.
> Unfortunately, we have several devices (most notably virtio) which
> allow the user to specify the desired number of vectors, and which
> use uint32_t properties for this.  If the user sets the property to a
> value that is too big for a uint16_t, the value will be truncated
> when it is passed to msix_init(), and msix_init() may then return
> success if the truncated value is a valid one.
>
> The resulting mismatch between the number of vectors the msix code
> thinks the device has and the number of vectors the device itself
> thinks it has can cause assertions, such as the one in issue 2631,
> where "-device virtio-mouse-pci,vectors=19923041" is interpreted by
> msix as "97 vectors" and by the virtio-pci layer as "19923041
> vectors"; a guest attempt to access vector 97 thus passes the
> virtio-pci bounds checking and hits an essertion in
> msix_vector_use().
>
> Avoid this by making msix_init() and its wrapper function
> msix_init_exclusive_bar() take the number of vectors as a uint32_t.
> The erroneous command line will now produce the warning
>
>  qemu-system-i386: -device virtio-mouse-pci,vectors=19923041:
>    warning: unable to init msix vectors to 19923041
>
> and proceed without crashing.  (The virtio device warns and falls
> back to not using MSIX, rather than complaining that the option is
> not a valid value this is the same as the existing behaviour for
> values that are beyond the MSI-X maximum possible value but fit into
> a 16-bit integer, like 2049.)
>
> To ensure this doesn't result in potential overflows in calculation
> of the BAR size in msix_init_exclusive_bar(), we duplicate the
> nentries error-check from msix_init() at the top of
> msix_init_exclusive_bar(), so we know nentries is sane before we
> start using it.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2631
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Technically this fixes an assertion, but only if the command
> line is daft, so I didn't think it worth backporting to stable.
> ---
>  include/hw/pci/msix.h |  4 ++--
>  hw/pci/msix.c         | 10 ++++++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/pci/msix.h b/include/hw/pci/msix.h
> index 11ef9454c13..551a2bcfe73 100644
> --- a/include/hw/pci/msix.h
> +++ b/include/hw/pci/msix.h
> @@ -7,12 +7,12 @@
>
>  void msix_set_message(PCIDevice *dev, int vector, MSIMessage msg);
>  MSIMessage msix_get_message(PCIDevice *dev, unsigned int vector);
> -int msix_init(PCIDevice *dev, unsigned short nentries,
> +int msix_init(PCIDevice *dev, uint32_t nentries,
>                MemoryRegion *table_bar, uint8_t table_bar_nr,
>                unsigned table_offset, MemoryRegion *pba_bar,
>                uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos,
>                Error **errp);
> -int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
> +int msix_init_exclusive_bar(PCIDevice *dev, uint32_t nentries,
>                              uint8_t bar_nr, Error **errp);
>
>  void msix_write_config(PCIDevice *dev, uint32_t address, uint32_t val, int len);
> diff --git a/hw/pci/msix.c b/hw/pci/msix.c
> index 8c7f6709e2a..b35476d0577 100644
> --- a/hw/pci/msix.c
> +++ b/hw/pci/msix.c
> @@ -318,7 +318,7 @@ static void msix_mask_all(struct PCIDevice *dev, unsigned nentries)
>   * also means a programming error, except device assignment, which can check
>   * if a real HW is broken.
>   */
> -int msix_init(struct PCIDevice *dev, unsigned short nentries,
> +int msix_init(struct PCIDevice *dev, uint32_t nentries,
>                MemoryRegion *table_bar, uint8_t table_bar_nr,
>                unsigned table_offset, MemoryRegion *pba_bar,
>                uint8_t pba_bar_nr, unsigned pba_offset, uint8_t cap_pos,
> @@ -392,7 +392,7 @@ int msix_init(struct PCIDevice *dev, unsigned short nentries,
>      return 0;
>  }
>
> -int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
> +int msix_init_exclusive_bar(PCIDevice *dev, uint32_t nentries,
>                              uint8_t bar_nr, Error **errp)
>  {
>      int ret;
> @@ -401,6 +401,12 @@ int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
>      uint32_t bar_pba_offset = bar_size / 2;
>      uint32_t bar_pba_size = QEMU_ALIGN_UP(nentries, 64) / 8;
>
> +    /* Sanity-check nentries before we use it in BAR size calculations */
> +    if (nentries < 1 || nentries > PCI_MSIX_FLAGS_QSIZE + 1) {
> +        error_setg(errp, "The number of MSI-X vectors is invalid");
> +        return -EINVAL;
> +    }
> +
>      /*
>       * Migration compatibility dictates that this remains a 4k
>       * BAR with the vector table in the lower half and PBA in
> --
> 2.43.0

