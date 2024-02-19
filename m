Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1ED4C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 11:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc2Cw-0007eu-ME; Mon, 19 Feb 2024 06:53:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rc2Cu-0007eQ-Pd; Mon, 19 Feb 2024 06:53:12 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rc2Cs-0004Ig-1A; Mon, 19 Feb 2024 06:53:12 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3D4914E6012;
 Mon, 19 Feb 2024 12:53:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 0hkZR4P8xTx6; Mon, 19 Feb 2024 12:53:05 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 479F24E6003; Mon, 19 Feb 2024 12:53:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 461F47456FE;
 Mon, 19 Feb 2024 12:53:05 +0100 (CET)
Date: Mon, 19 Feb 2024 12:53:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-block@nongnu.org
Subject: Re: [PATCH 5/7] hw/ide: Move IDE DMA related definitions to a separate
 header ide-dma.h
In-Reply-To: <20240219104912.378211-6-thuth@redhat.com>
Message-ID: <7294464f-c11d-ea4f-df55-117ae46b9d0c@eik.bme.hu>
References: <20240219104912.378211-1-thuth@redhat.com>
 <20240219104912.378211-6-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 19 Feb 2024, Thomas Huth wrote:
> These definitions are required outside of the hw/ide/ code, too,
> so lets's move them from internal.h to a new header called ide-dma.h.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
> include/hw/ide/ide-dma.h  | 30 ++++++++++++++++++++++++++++++
> include/hw/ide/internal.h | 27 +--------------------------
> 2 files changed, 31 insertions(+), 26 deletions(-)
> create mode 100644 include/hw/ide/ide-dma.h
>
> diff --git a/include/hw/ide/ide-dma.h b/include/hw/ide/ide-dma.h
> new file mode 100644
> index 0000000000..fb82966bdd
> --- /dev/null
> +++ b/include/hw/ide/ide-dma.h
> @@ -0,0 +1,30 @@
> +#ifndef HW_IDE_DMA_H
> +#define HW_IDE_DMA_H
> +
> +typedef void DMAStartFunc(const IDEDMA *, IDEState *, BlockCompletionFunc *);
> +typedef void DMAVoidFunc(const IDEDMA *);
> +typedef int DMAIntFunc(const IDEDMA *, bool);
> +typedef int32_t DMAInt32Func(const IDEDMA *, int32_t len);
> +typedef void DMAu32Func(const IDEDMA *, uint32_t);
> +typedef void DMAStopFunc(const IDEDMA *, bool);
> +
> +struct IDEDMAOps {
> +    DMAStartFunc *start_dma;
> +    DMAVoidFunc *pio_transfer;
> +    DMAInt32Func *prepare_buf;
> +    DMAu32Func *commit_buf;
> +    DMAIntFunc *rw_buf;
> +    DMAVoidFunc *restart;
> +    DMAVoidFunc *restart_dma;
> +    DMAStopFunc *set_inactive;
> +    DMAVoidFunc *cmd_done;
> +    DMAVoidFunc *reset;
> +};
> +
> +struct IDEDMA {
> +    const struct IDEDMAOps *ops;
> +    QEMUIOVector qiov;
> +    BlockAIOCB *aiocb;

Doesn't this need to #include something to define QEMUIOVector and 
BlockAIOCB and some of the DMA and IDE types not defined above?

Regards,
BALATON Zoltan

> +};
> +
> +#endif
> diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
> index 642bd1a979..d1d3fcd23a 100644
> --- a/include/hw/ide/internal.h
> +++ b/include/hw/ide/internal.h
> @@ -9,6 +9,7 @@
>
> #include "hw/ide.h"
> #include "hw/ide/ide-bus.h"
> +#include "hw/ide/ide-dma.h"
>
> /* debug IDE devices */
> #define USE_DMA_CDROM
> @@ -316,13 +317,6 @@
> #define SMART_DISABLE         0xd9
> #define SMART_STATUS          0xda
>
> -typedef void DMAStartFunc(const IDEDMA *, IDEState *, BlockCompletionFunc *);
> -typedef void DMAVoidFunc(const IDEDMA *);
> -typedef int DMAIntFunc(const IDEDMA *, bool);
> -typedef int32_t DMAInt32Func(const IDEDMA *, int32_t len);
> -typedef void DMAu32Func(const IDEDMA *, uint32_t);
> -typedef void DMAStopFunc(const IDEDMA *, bool);
> -
> extern const char *IDE_DMA_CMD_lookup[IDE_DMA__COUNT];
>
> extern const MemoryRegionPortio ide_portio_list[];
> @@ -340,25 +334,6 @@ typedef struct IDEBufferedRequest {
>     bool orphaned;
> } IDEBufferedRequest;
>
> -struct IDEDMAOps {
> -    DMAStartFunc *start_dma;
> -    DMAVoidFunc *pio_transfer;
> -    DMAInt32Func *prepare_buf;
> -    DMAu32Func *commit_buf;
> -    DMAIntFunc *rw_buf;
> -    DMAVoidFunc *restart;
> -    DMAVoidFunc *restart_dma;
> -    DMAStopFunc *set_inactive;
> -    DMAVoidFunc *cmd_done;
> -    DMAVoidFunc *reset;
> -};
> -
> -struct IDEDMA {
> -    const struct IDEDMAOps *ops;
> -    QEMUIOVector qiov;
> -    BlockAIOCB *aiocb;
> -};
> -
> /* These are used for the error_status field of IDEBus */
> #define IDE_RETRY_MASK 0xf8
> #define IDE_RETRY_DMA  0x08
>

