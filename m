Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941A2C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 00:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFiaj-0007rC-Sk; Thu, 15 May 2025 20:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFiaO-0007Jp-Ti; Thu, 15 May 2025 20:06:03 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFiaN-0002dl-04; Thu, 15 May 2025 20:06:00 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22e033a3a07so16467905ad.0; 
 Thu, 15 May 2025 17:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747353957; x=1747958757; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EeTm5CHCGJSCjvMhWXw6tYtjSC4W1TGUZWlJ+hKH5Es=;
 b=mySKE+VxbGao2HLyqOtRQ7AUMlNPUW1grIcIIvUQ7rAofscYke2VWI6sqFTGOvg6Mt
 KvnPftB9HrmqVx4zMlLy+ymCfw/xpqAvBVUwY7xdBgNSjbcsfuChGxfxGSA7KElnq9sf
 LU1i93n2Q/QI8JaRRxuGxo7FaZnTShEH8dHKfIF7Mq9vjXQHlAQmsswIOrFERoJaI4jz
 Va5tQQkfB2traEaGL3VCts+R7mDCPVnnyu1fpl+h54NG4P3fYSnweI/9qjXNdf/gCBDy
 Xwjc+/XiwXjjuRA5ss8nHNs8GAG0X3aXXFmDhQ0UHTrcSHROrcufUlaMfyLFFpAMPHqD
 GiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747353957; x=1747958757;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EeTm5CHCGJSCjvMhWXw6tYtjSC4W1TGUZWlJ+hKH5Es=;
 b=acHhD7dPBBpl7iXjucPDCA9YaeL8qR6Dsae1cLXPlQNQu0L+jOvJs+QH5vQGvh7AFz
 ubLxvX1lRB8E6UN0TaqsRona6XWUF8Lcyzy10a5Jc3Q40b/Xp8//2c3X9/9dZHBVu4uV
 a9FOMVzn+AOU3E3GWPX3ahmbg04nJVTwDHT6Pwl5RDByfFI2VfEamBUq+vFXRk6kMRer
 +JSlc8zelcH3cc+6wCDOegWJHV4cCy+3DoI+7nVITAWr9wr/byeGnnVsHLmDSBlRD1EG
 MaA0o0W0rpSykgqQrpwhzl0ocP9oxn/n818Fpt4ajO1El5imdAxKeCuqxeQ7zRWAiD9J
 BRUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/0R6sm+Rvu78lef9oEjc/Fq82sgs+iyr6JcWybqDqyoB7/y88fCtzHOyqr9juQmeHj/ubygoJ3A==@nongnu.org
X-Gm-Message-State: AOJu0Yz+MZRDvK/S50/QtWYQ7XTvED+38U12LfFN1VwY8xHc/9oSyf1s
 79rkY47yccMkhUJiAWrDik+t7J0/UC+DiyH0kzDxeif5QCzMOD8eXKRU
X-Gm-Gg: ASbGncuEUSivjBVlPb+D9HU+nSroyNVMhqTelnQeZYSLTj9dtq+eI0UYBtbCJH5i+vR
 WBJZx5D+NZtCSfs8r/IVcKQUkodCVjJwALEoRfLOdB+PlSHmkRsP1xBvu0pu7GGnPjF99IxZIgv
 f7jCw9bfqK8raeuu+r4p8G8y51EcniChzzJ+q9bOf0VMXb0uEwgv4hCfgaKOPh85AtX9aYfjKrZ
 Z3wwy3a+j5G3DyAvE17UdumfaoBEic7qlRSTVuY34adGYRzpF/GFD0AoNYRmL8414A1YIp0d+Uz
 W46lDIHDIRiJPsMkgStuEzRvcRW80hox20wUb1/uksmKbCc=
X-Google-Smtp-Source: AGHT+IFOe5dTaBln/Ndi4dUytqCmNFv1IKQXEvH6SFs7vraTNAO++nM2/d8rzKoQmUb/7r9XF5dhdw==
X-Received: by 2002:a17:903:2285:b0:223:3bf6:7e6a with SMTP id
 d9443c01a7336-231d44e391emr17028755ad.12.1747353957103; 
 Thu, 15 May 2025 17:05:57 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97dadsm3403775ad.141.2025.05.15.17.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 17:05:56 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 10:05:51 +1000
Message-Id: <D9X5A3I88C2Q.29RV6YVBVYJ27@gmail.com>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Michael
 Kowal" <kowal@linux.ibm.com>, "Caleb Schlossin"
 <calebs@linux.vnet.ibm.com>, "Glenn Miles" <milesg@linux.vnet.ibm.com>
Subject: Re: [PATCH 17/50] pnv/xive2: Support ESB Escalation
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-18-npiggin@gmail.com>
In-Reply-To: <20250512031100.439842-18-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

On Mon May 12, 2025 at 1:10 PM AEST, Nicholas Piggin wrote:
> From: Glenn Miles <milesg@linux.vnet.ibm.com>
>
> Add support for XIVE ESB Interrupt Escalation.
>
> Suggested-by: Michael Kowal <kowal@linux.ibm.com>
> [This change was taken from a patch provided by Michael Kowal.]
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> ---
>  hw/intc/xive2.c             | 62 ++++++++++++++++++++++++++++++-------
>  include/hw/ppc/xive2.h      |  1 +
>  include/hw/ppc/xive2_regs.h | 13 +++++---
>  3 files changed, 59 insertions(+), 17 deletions(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index de139dcfbf..0993e792cc 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1552,18 +1552,39 @@ do_escalation:
>          }
>      }
> =20
> -    /*
> -     * The END trigger becomes an Escalation trigger
> -     */
> -    xive2_router_end_notify(xrtr,
> -                           xive_get_field32(END2_W4_END_BLOCK,     end.w=
4),
> -                           xive_get_field32(END2_W4_ESC_END_INDEX, end.w=
4),
> -                           xive_get_field32(END2_W5_ESC_END_DATA,  end.w=
5));
> +    if (xive2_end_is_escalate_end(&end)) {
> +        /*
> +         * Perform END Adaptive escalation processing
> +         * The END trigger becomes an Escalation trigger
> +         */
> +        xive2_router_end_notify(xrtr,
> +                               xive_get_field32(END2_W4_END_BLOCK,     e=
nd.w4),
> +                               xive_get_field32(END2_W4_ESC_END_INDEX, e=
nd.w4),
> +                               xive_get_field32(END2_W5_ESC_END_DATA,  e=
nd.w5));
> +    } /* end END adaptive escalation */
> +
> +    else {
> +        uint32_t lisn;              /* Logical Interrupt Source Number *=
/
> +
> +        /*
> +         *  Perform ESB escalation processing
> +         *      E[N] =3D=3D 1 --> N
> +         *      Req[Block] <- E[ESB_Block]
> +         *      Req[Index] <- E[ESB_Index]
> +         *      Req[Offset] <- 0x000
> +         *      Execute <ESB Store> Req command
> +         */
> +        lisn =3D XIVE_EAS(xive_get_field32(END2_W4_END_BLOCK,     end.w4=
),
> +                        xive_get_field32(END2_W4_ESC_END_INDEX, end.w4))=
;
> +
> +        xive2_notify(xrtr, lisn, true /* pq_checked */);

Sorry I forgot to squash in a fix for the issues here. These should be
_ESB_ constants not _END_, and we believe pq_checked should be false
here so the ESB state machine is run.

https://lore.kernel.org/qemu-devel/D8CFK7Z5AJF8.ALT8MMH6EYYT@gmail.com/

I think we took discussion offline after that but that was the
conclusion. I will sqash that fix in here. With that,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

I also wonder if Mike should be author of this patch since
that's what the note indicates? Or co-author? Better give your
Signed-off-by too, if so.

Thanks,
Nick

