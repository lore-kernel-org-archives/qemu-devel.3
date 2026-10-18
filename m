Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B25BCCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 10:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIOBk-000446-NR; Sun, 18 Oct 2026 06:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIOBZ-00040v-Pr
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:32:15 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIOBV-0000mu-Kf
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 06:32:11 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6740e7ae219so962687d50.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 03:32:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792319527; cv=none;
 d=google.com; s=arc-20260327;
 b=fG6uht52ibfAPkdhBi0OcVrr2DVs2n/ZGbLE8NbpgHQHBel+VQEBrP0GfbA5jHY3ok
 vgx7BuzLCDHOIYlV2BSeNwVGd250COkxU1x8+AXn5Wueyf+KnSRRs8aMhIpX2WH/cKts
 tLvxqM7zWPEK9npq1frivCkZNx2ywJktHaF6fedPM/C/gI9pYkaW92Aul7mqINWiXKHP
 dmJ8FSbRIFjm9F1s9b1JaMjQBxTOf3z+R0ZyqHmlbSumQwrCp4PulwW8hymY2Y4/ubcN
 aykEZwLLOVkQ8KHF9YKHvmyYiTxRLPM01zo/q1ZvH8aySob10VG9ZIjWZjgGOBUcx8Bz
 9R9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lcEW4VMJH7C14Mw21bAq04bF7/0PUzlQO6qT/Ox5pAo=;
 fh=dHN1FZJpb1BHRtRBDcpEyrvNB3hUuCjyQs5YK6bCL1Q=;
 b=MgPWKqLd2glspMWLG7bRhzot940Vh5QsUH95G5Ss1qtiBoVzKFKKrIAS/xzVcu6lqD
 8fBnrvtBiFEVu8mXacJfD6zhZ4rbxaUK8GJvDpGVi2D4khHVUTuzNS01PUYeE/vX4w1g
 XSCW56uE023SW1f58OkJWs2XEaz6iQ0XGbW45jPPu09+NHHEiPlxl06X4ZCiD38KtpVu
 2wtsWqEpP2VHzPKxKWgTR+g8uoWMFV05gwE9LipiAQl1qCGph3cIQSwYOAiqUPOwII4X
 g8Ivfr1PaI+i9bSU+Emb/RCoH6/0q8CVumF19MPIMsDHDSOZSOliD2y1u1ptz5mDfJ8P
 vsFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792319527; x=1792924327; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lcEW4VMJH7C14Mw21bAq04bF7/0PUzlQO6qT/Ox5pAo=;
 b=so+M4oTLaazKjpZMd33L53osHIp0CqpbFPinn07h9elvs85OZlek/Xyc5hDlTypKVm
 /+/dFfMDuHD6Vt6YA3rh1UYKhMmhXEBKwJs1uCdOFhjngWFVQbmBKrMMbd5M2OvKxhec
 g3etXPWG6K1gdXKLqcEiJ/sKdzHsbT+q96D+Y18u8TOIcgpgfiseWrb4t7Rm0HcsKdh9
 3iaNGHJxB8tulAnX3Zb7O5iSR69QFTg5QW/wsVOHGMI7EkfM4o9Ll8ROjbncJg7Nv7ai
 91uiFpDCDIq1KMnk811JbzAnH2XGZmcjm6B3x4AI4ntMfVdn3razBR6RCXpUjYRSuzwr
 BPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792319527; x=1792924327;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lcEW4VMJH7C14Mw21bAq04bF7/0PUzlQO6qT/Ox5pAo=;
 b=DAGwRJBehO0jQFoV7MwD1AzbYoGTykRdDkYf0EczfHgFd6wO8yJH5cKqlYf0UFG9V1
 py6wChTAeJaBhmNUVN7h219L9WP/Jf311GCrBkV+DifVZiFhOOy0WjgVRGbQiG+0n11D
 H9lZNxoZiq8UM0hWYEIPvHME4Ms+yelfcjeXDJ7HwIrcW9goi09lL217U2IzqWfDxqcl
 NGtQ4JZ8Y66+EW8k3wXP4Mo9xaViLeHfhFcdKNvxeraF8zp9JI/RRFQdtZwVWVXD91gZ
 5k+GPQYHEWBlkAg3VKftX/M909TBpVNRZYx8hBqCAqTAZwRGHWjhdzeBz+awAtU0aKOA
 0d0A==
X-Gm-Message-State: AFq9FYIU0ApAyXWxduAk5TUTaZ2HKSTscMGOoPec/VNUqSXYPlQtt7Y9
 Usj4fsp7OW3FK+YMFxtMQ6taehhiWjDDcbMMvlC8XYxVYpwSLJRDdSmYVW9PK0ZDwKMOcFwbRO6
 JlZt5JSmpMzDFgegyqF0s4VzzjHpy/ULG7qmFw47ulA==
X-Gm-Gg: AYBFou30zDjVDVJikwbXvivAEAXox7g2p/e/eXDPwG1JGl0VCpl8S9HB5K7SzbGOBbc
 zYPEX+qJ+cy3Qzf2Z3ElVNxzPq8zwJcMGlCOwAImp0SXQ8x1CyFJ1nGBb/fOXpFE7kZV5Xavz6t
 VoLY7Epg93a0AX0ENmcAWhPgGro0HHvfi3MMVswFFgnzFRYv19HlOwsQAJQqR/ovzUAUiCI4lDs
 jCgoX+KjLo9sox4dKWJMApSmyZdkKdvZTZ709zOMQWNhJnavb5wiROCwl/LeX1HcVa/ZvUfpuk8
 tQAN3QlmPqGN2+IxPB5lFeCz74m6vli/bMmeN+ue0t1lZhhtYm2hHgH5pm3zYI8/JCR9KMjrV3V
 6SahViNULN5hOSrnknl4jF4SWQvYIK5wLX2TXGXc=
X-Received: by 2002:a05:690e:140d:b0:677:c29d:4fa8 with SMTP id
 956f58d0204a3-679ca93d449mr1197415d50.138.1792319527184; Sun, 18 Oct 2026
 03:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260918101158.42101-1-corvin.koehne@gmail.com>
 <20260918101158.42101-6-corvin.koehne@gmail.com>
In-Reply-To: <20260918101158.42101-6-corvin.koehne@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 18 Oct 2026 11:31:55 +0100
X-Gm-Features: AclHuK_ruOOP20mY6liXAyFeL6oD7GvtR3FA8ZLG4oIa-kBkFcwnwWIO2hWKTbM
Message-ID: <CAFEAcA_92gWL-yJsPxswU94hENMYRowV5ZJ8mVGHxAbFYbacKw@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] hw/arm/xilinx_zynq: Make PS frequency configurable
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, Corvin Koehne <C.Koehne@beckhoff.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Yannick_Vo=C3=9Fen?= <y.vossen@beckhoff.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Fri, 18 Sept 2026 at 11:12, Corvin K=C3=B6hne <corvin.koehne@gmail.com> =
wrote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> Add ps_clk_freq to ZynqMachineClass so derived machine types can set
> their own PS clock frequency instead of using the hardcoded default.
>
> Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
> ---
>  hw/arm/xilinx_zynq.c         | 3 ++-
>  include/hw/arm/xilinx_zynq.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

