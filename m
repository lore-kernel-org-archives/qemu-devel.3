Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966F3CD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 08:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKuQZ-0003xL-5g; Thu, 07 May 2026 04:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKuQY-0003vY-CQ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:49:50 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKuQS-0007uw-HB
 for qemu-devel@nongnu.org; Thu, 07 May 2026 04:49:46 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6587cee8b57so560295d50.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 01:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778143783; cv=none;
 d=google.com; s=arc-20240605;
 b=dGCVBa4veshjpxySfcyDsDkfoAeYbUzTZnYPVUASGppRrQIknnSze2o+o4SF+lrlaX
 vcY0C8ItEzE7EOOqhSt7fiMbqWA4zmoKQHkC3gw6AACtCYKRHrFNoVqkEQLAhMdvetcv
 2JmgfjIDvtPva/mfpukQPxcYlb+Ok+atpH+elMsGWG8WOzxdGLD1URPmrDrnNkJJWjVf
 mEDHBNt1BfNavSbK2ZSpds16RGljHEzGIJy1TP/Y3xerW3oaYLNq5soMgR65S91brVKB
 c4lt0oGvRyOdxK0hZerK/D3LZvfo9ghla/Bz/KyES7bLVStHMSTV4MOt753MicGIZJwA
 6ROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ebPu0zNX+2tOXD6OPdPXtFBlkPHw+PPitkfTsNSgsmM=;
 fh=mfg7oMYGemPoUnmFBZHENIERYVNJssHnRhsjr68iPcA=;
 b=aWe87vDQdI7U2Lb/kR+qPiAjjs+WmNs+yMIVGxmJmukrAY40XhyrUFoh6h+S64tGj4
 /1vumjflBYz38AypsKwB0/Ekl7nF08lIk46fIi2GCpE1guMEmtLzvS+gyJcNEW8O0z6V
 4uc05kDQX7Vm6T/UILwyEhUXwmmjkzmILolNvKxLZcq7aznDvl9qGeLUbFzjaXAoY3zE
 n+6iVrxyHNsrKnPzObW6SIVGQic3/DIahzoZv3k9DzwAOXcYoGwxLwRs0qZagCi1VO5V
 jz94ygwsAwghh2EcAk2Q5rdCA/2+hitcQviBxjlQs9vOrToGW4SwKW/XKNs2JGR4Br86
 ZN7A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778143783; x=1778748583; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ebPu0zNX+2tOXD6OPdPXtFBlkPHw+PPitkfTsNSgsmM=;
 b=skeomhmGaa7Kh17voLm9xj3JJhs3nmZq9Ihv6Stn5v6RK0GZneKOJxOxoezlj8Sjdd
 tUMJ0851wBY8EbTejrt14J1HSI/7itAombmLiJ4bgkeOjGTkuKq1TIsAfooJImS8AAnw
 m7Z02L2qXZaEqH2kw/IlLc55/VA5FY7H0mUfF+ANN8vDUsBXsfe77QkbPoIfDF7edDEs
 Lr9VRN9bMJQ6feZi7fYi6sKRtrjbdfSD702OxNNrIra1iAJ+H5JEjDXZSEg5kEHpzOEC
 Xj/CBFxNRXOt3BeQ0aIJu5ZZAcpU6NG14ah6ONAxRj7FXllSUDWLR6mnzLYxMMrd95VJ
 dReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778143783; x=1778748583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ebPu0zNX+2tOXD6OPdPXtFBlkPHw+PPitkfTsNSgsmM=;
 b=LweY6iOBn0WXfAnfkzaUCHvBnqo3C0YrjQgWrozmQQKRl03MJhZ2h5LUJMHjoA+26i
 MucDcvfK6/VOLriOK9CH29AEUGceJAP+VXB3qqBf6YM4kkr9hm+vYszeM6/x/RqFAJvn
 ZvLoEprTLw0PLdL8PUq1pXv2UaPQTf5R8HDBFeFxHRjc9PBAkHixqpwrOQWsdQpmwC1L
 yscyDe7Vjr29htlhvyb+z/i7lcSQYZwSaPFDSdBr/pzDbTYpM7MUyEFcRDG95eEQj4qA
 ijQ30wha+5N85EUS6QnYiJmhlZJtp08iayf+5UZh8RSEfkgF+TGFhAjE5nnvtN/fWxY0
 KMRw==
X-Gm-Message-State: AOJu0YyF15rU3VP6ifcmWKzwIf6wlstMDsb8ffWYbgnR0hF22/gOpOFD
 ZobJa4dfLQJaCBL6iLvDEQLQ+4z6OikdF6txZjlhBjxsjGM1cstgygew7pPC7bWJ91Yllt3/6O/
 oysLU9SqRKaLlWIN6Lmfa2JKxw13jvVqhYhEtnP7hAw==
X-Gm-Gg: AeBDievJHrlbvaY9QfMZSx/sjC34khXxNLeIFUfLbueNczazrGVR6dUyT1IKKtkXEkn
 e69ErOcZWZDENggKpFQe/OlRMGylpEtFFWzV3aqxq1A1/fyfXQ4EtrHpUxBcdcF1ckrck5W41se
 Y6NEnMgt4Ev2YFeB5Or12Ni1BqprFKJnnIKrPuEHv8z9G8W8axHMAjDbxglv/A2lF/sGGTwe9q7
 RUjNb2sVFy/f2vWtHumuEOd+iubiRHZ9w7u7sBbSjt5zRppO4UpAUpjFnNhQu6RBXzB0ei9MgFn
 6xm+aT2v0hk0Y6gOTROqt8gcZ5jhncB/F7MsH6o59/NWwzry2muy9DdfqVtj6Ro16DI9ttrjz0g
 9DA==
X-Received: by 2002:a05:690e:1285:b0:651:b37b:30ea with SMTP id
 956f58d0204a3-65c79998b41mr7921481d50.38.1778143782813; Thu, 07 May 2026
 01:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA93342r1oKDBDv=7LRoAqT4WpVEqRpb-ThM=OjJUZm=BQ@mail.gmail.com>
 <20260506152247.82336-1-munkhuu0825@gmail.com>
 <20260506152247.82336-3-munkhuu0825@gmail.com>
In-Reply-To: <20260506152247.82336-3-munkhuu0825@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 May 2026 09:49:30 +0100
X-Gm-Features: AVHnY4JCNLx1bdo--YUCzQWG4lULVjApA0P4_jadva91GTRILrIga_BsEyTaexk
Message-ID: <CAFEAcA8oYips2EPYN2_Cv0pVZ7xrpRVccfwfnTAxkVOSdMaR7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/usb/hcd-ohci: Clean up USBPacket before freeing
 ISO TD packet
To: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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
> ohci_service_iso_td() allocates a USBPacket and frees it after synchronous
> completion, but it does not call usb_packet_cleanup() first.
>
> Call usb_packet_cleanup() before g_free() so resources owned by USBPacket
> are released.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3463
>
> Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
> ---
>  hw/usb/hcd-ohci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index 8f4de0066e..40ebafb4dd 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -755,6 +755,7 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed)
>      } else {
>          ret = pkt->status;
>      }
> +    usb_packet_cleanup(pkt);
>      g_free(pkt);
>
>      trace_usb_ohci_iso_td_so(start_offset, end_offset, start_addr, end_addr,
> --
> 2.50.1 (Apple Git-155)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

