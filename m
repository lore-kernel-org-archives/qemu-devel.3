Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5323ECD8CA7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWYBY-00030y-97; Mon, 08 Jun 2026 07:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWYBN-0002yy-7j
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 07:30:20 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWYBI-0002lF-OL
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 07:30:15 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-66061993121so3784146d50.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 04:30:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780918211; cv=none;
 d=google.com; s=arc-20240605;
 b=iNkkGKWtAIMOY1ELQC0DomUSFUNVjkf/4Ziitj+rk0ZLFWr4bxFIDt1PI7Rjf6sVV+
 Z4/8GflFoYjtJz77xzhSVTyuuObTwL0CzQP3xTp/rxcx4NFHivsm+SD3bpBI4jrhPBYM
 bTYCG52S0Ta6T0khQma74IlcwA9zQmI5glxJKpGQqqMQAZ8xfXJohYO34CoNgF3ec7HC
 vTKroytZOoZRn0pJX0UHQi4AmE4eTAeKnJEjfW4Cb/SadnXP2FNHshZmnoQ6mW0wep6V
 KGIn4CvcznM9n2zLuOsze7JzX2ewujug9abwpCaXps39wY3liPSv8hWOt6qV/hsI6Db2
 Rbtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1ueGsDALS4AP0w1VBX/rFc+tviXwIg+/d7pbPlcyXSM=;
 fh=mfg7oMYGemPoUnmFBZHENIERYVNJssHnRhsjr68iPcA=;
 b=krjWgHvrKgOoyk33/TknIVTn7CiUwGoTwUxlltPGghWuoqGB0KN+j3WxgaEpYSm4ph
 vxAi5IQO2FPMjHcuBTrWgbLIXZ+bhQxVsw3LzsQWgX4qwcVnwhccMA4QDgGTT7AVzi5O
 RiHfwuxfmT8z+AsjrIj9fx7mPI8o1GxWFj5rHvIYV5XaC8sD1x7NLlNhYpI2iaTz3DJe
 Cy3SYi1bokTys35Skf7H/DghCSBg2MVkN6nwuSarWbypjsXh/eIPgIBKYn/Glq5fAjpm
 Xa2Q3wZ5NcClPNiJr5ebZYJ+2wUXGi8bF3uKbA8ym1ge2kdNZWhD39Wk0PfjoRwz0pCH
 Fbeg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780918211; x=1781523011; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1ueGsDALS4AP0w1VBX/rFc+tviXwIg+/d7pbPlcyXSM=;
 b=DlJ/X1P7ZMAecJZcidRUTbxdwdW/wq57t4/wcGkHjy6gS7qV775+ms0ZSZcACA96HN
 OS0ehcHTXsNtVOptjCgnI2deYrFmcRIds5JbNMjrDJlOnVSOcywvMKkrJzHZmiq/JxqU
 1ogl3w1hjuoO65M9LO76cMafIEuq+p6QCCVWRA9MgV94AR+RSgxN10JTBDF9cMYjVFfi
 dBpDx7+MEOy3D25qHuhHTH3r1NIq2FmzFo+3CbxKa5eN7MqYfssFp2uNTC88R8bsQbri
 sNzsUHJFzDgtrQxZtao0W+ZRYYnCt+DhPqZPJZi/O9tApZq/wqLU8g+A+OIAWIqeJeym
 gRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780918211; x=1781523011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ueGsDALS4AP0w1VBX/rFc+tviXwIg+/d7pbPlcyXSM=;
 b=CB18PQv1t1aif3U5XcpAONqXF9n4uO1OKMJDTAF1vPoINI1as75ZoFxf+SdX1odzYv
 +OnKObfLsqQQaUgPOZusXZAHSgQzsHah/HP6tV1ZCaAW0hLj6iXXQmYqbxZ/EiB8fQ+z
 uferrG0QfJoMPvjbBCEcNJ3u2NxUZfd4eMQejY06GKJSsg8RIAzXITdNWf99LVqjkbBh
 5lFqExOhYYJh9eJs9ErsS1d6vaKJQWyWLZeNB6NJ1fXs5tBOHO+xoPzQgc2zC9DXp2rV
 8Q1TS9MzVzXfQ5zWIY4VDaryNNxSXzBi9bwPyhUF1oUyu94uqUmw5lI+uqBMAh0B9+VR
 ZF1w==
X-Gm-Message-State: AOJu0YwZhrQglZgQD88hzTm0AoK9qvyD+gze3SqRa5Gio9709p8X/tl0
 YseVNj2XakwLzHAyjsGfaWRoBWzcIBAi69DnIP2uwiPgT0f8L0kqYBu+ldvN2UB3F9Dank/EdUe
 4DGBzOq8236P8Edz/NEBqpkGlg+n3OZIFFTxmglKMYg==
X-Gm-Gg: Acq92OHS7qSjV/5biAbqVWkhVmQnAPjASCKTrlfJqsvFjVbF1b3RG8NJmYKySDLXQCg
 J3EzgHMjoEW6aOKZEIH2BETBBISsbO5BLbvaFJ+Ioj4Gy4CxasNGugqivQ9XpPdbSXFl+03JAga
 6NUt6GHurqJpUkoTxosvwDUmeSDaMsX2mJ1AaYj+aJ0/6QCVgMuAQeefFECbzJE+LkJVyQA6SXx
 s7RQaVEmrr1V0pgTJqDjobE2P5+djBUnZtqNktUxKNZEsRfMXxT6T0ZMSmrvux6RCFmAxgSFSwg
 /o5tlEQL2JhVHqdzHolcas2a+pYPNsavXBDh7jwHiL3hDl6LPUjKl0wtEbUNSMQE7uCdrrl6gEw
 5MQ==
X-Received: by 2002:a05:690e:134e:b0:660:60a9:2b35 with SMTP id
 956f58d0204a3-66106f903e6mr11993739d50.57.1780918211412; Mon, 08 Jun 2026
 04:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA93342r1oKDBDv=7LRoAqT4WpVEqRpb-ThM=OjJUZm=BQ@mail.gmail.com>
 <20260506152247.82336-1-munkhuu0825@gmail.com>
In-Reply-To: <20260506152247.82336-1-munkhuu0825@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 12:30:00 +0100
X-Gm-Features: AVVi8CdAjcG7GHLAu1rCjH_KKIoY43E1A-2v3p7SQQ9qPVhyFS_ieqRpILLyzXg
Message-ID: <CAFEAcA9v+AShcRTr34C-oDNuWH42W0zxS6mzkW_WO65_xCfgvQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] hw/usb/hcd-ohci: Fix ISO TD USBPacket handling
To: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Wed, 6 May 2026 at 16:23, Munkhbaatar Enkhbaatar
<munkhuu0825@gmail.com> wrote:
>
> This series updates OHCI ISO TD USBPacket handling.
>
> Changes since v1:
> - Split the original patch into two patches.
> - Replace the USB_RET_ASYNC handling with an assertion.
> - Keep usb_packet_cleanup() only on the synchronous completion path.
>
> Munkhbaatar Enkhbaatar (2):
>   hw/usb/hcd-ohci: Assert isochronous TDs are never deferred
>   hw/usb/hcd-ohci: Clean up USBPacket before freeing ISO TD packet

Since nobody else has picked these up and the main user of
OHCI USB is arm boards, I've applied these to target-arm.next.

thanks
-- PMM

