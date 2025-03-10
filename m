Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D37C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 08:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trYAk-0001y1-Cs; Mon, 10 Mar 2025 04:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trYAi-0001xf-13; Mon, 10 Mar 2025 04:07:36 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trYAb-0001MF-0Q; Mon, 10 Mar 2025 04:07:35 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-225477548e1so22463035ad.0; 
 Mon, 10 Mar 2025 01:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741594045; x=1742198845; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hg3p+h3VS23GeS4/YoeM6cYtw5REEjNnhHU6Dci9Hfw=;
 b=BAEV/gvsCjzad05eQJSlm9w2LLjFn9Ku0qz+71tru+Dlw+I8lBJq1OmohaMdGBLYU1
 /hy3fbOjuFbr0Gvs2Hg5hg6fNJSNaHL6Yy5ml/mnMdHe8tjashktQyz9845o7RaCQSCJ
 bwJ3djQF5Jp2kia4lXCpFN66eLlg4Ew/b1ifVvwKfTJcwSEnUYWsFJhPS3ErmFG0G8if
 KjOIB068/dzyevp4eCJx7ViNTwK1FV9RcE78ijrEdnNJT62BdSExZun0w9vK1dW3ZH8F
 CHVFwS9O577uRR+o6awpkDkL9pQyWzT6rDtG0EsDq0YDiUNCXb1SJjEmrcWL26k+A0Ms
 efVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741594045; x=1742198845;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Hg3p+h3VS23GeS4/YoeM6cYtw5REEjNnhHU6Dci9Hfw=;
 b=VnzppBhEsOoCmnVN4wXqiXQq+dMFJlol78FifnLVM49xSZx58YWjQDNUlcTDeGzT40
 NfmT4+iYV1O4XpORrhsAyLyJfF85cbk3CyJhOXYjhUa7UmfZPatjfBNsVtTo0g4Anbz+
 qtgGT656TnqXApLA61BNsoKd9xLBb07/tPHE/4F1ISnhv7xvFfUlrQA42udYll2ukNH9
 Z0n8Z1E/3ZNQm2wTOV7WSvRHe96HsPr7cRvNKehjw4YTTr3/Du5D79tMhUaP5V9+ubrQ
 k8iBEOsVEJGnG4NXPyaMMjrufe6gHYhrPHYGh4KHyjYm1oAzMjJp0Ogm3i7T+34X1QAw
 /4jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5oIZ3uQHc7FH0bbvR13743PdF41GkPp/3h1zZhOe4a9NIFwE/2bX/vPXj5QF9IsOh8Rj2vtKnX8dc@nongnu.org
X-Gm-Message-State: AOJu0Yz3zA7Ro4/+/7NHiLlT1k8V4cT3qoz0mVMc6cRWel+r3Cnsd8TT
 baYRSkJhRT3VcyVBwzbzQBhy5lukzoUncS3hZ81m2y1wHZfd15hE
X-Gm-Gg: ASbGnct1hCWwD1dsq18jidC5jJPkXXsmBIBE8cmatj69ukFlDHPjMgf7ZnzOE/mGYrZ
 lHMn73c+q7N8TVJZjyIbdxfJhanHBWc5p67v1fG5J8oZbX+ctdkHlExmp1XouR0J/17g5ijh02O
 +EpCPg7/e1VfLUhVrtXyjqI8zcWNiHyv6CmOrCH9wOyBDgteLwUnp3pQP7GIYuVgBCdxJGwni58
 ObdDIZXuO73c2bRW+B7thYbcTrkQlj5aOwPOn+b9/CZpwPqvdIbZwu1NpmMJ8X2cUFHiV3xVNtF
 /QeTFRLWxSp7j5+xwk0VaPdQduxjVu/asLKCa3k3
X-Google-Smtp-Source: AGHT+IERwXP0zj6Tt4aMY5UVsnD7nk7RnQcjNKRvggeFJ1VrXSbSnxXOwWj/3mMdseVWfyQ03wbZ2w==
X-Received: by 2002:a17:902:e810:b0:223:432b:593d with SMTP id
 d9443c01a7336-22428c07537mr201585025ad.42.1741594044611; 
 Mon, 10 Mar 2025 01:07:24 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a918e5sm71279595ad.167.2025.03.10.01.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 01:07:24 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 18:07:18 +1000
Message-Id: <D8CFK7Z5AJF8.ALT8MMH6EYYT@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <milesg@linux.ibm.com>,
 <danielhb413@gmail.com>, <david@gibson.dropbear.id.au>,
 <harshpb@linux.ibm.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 12/14] pnv/xive: Support ESB Escalation
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20241210000527.9541-1-kowal@linux.ibm.com>
 <20241210000527.9541-23-kowal@linux.ibm.com>
In-Reply-To: <20241210000527.9541-23-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

On Tue Dec 10, 2024 at 10:05 AM AEST, Michael Kowal wrote:
> From: Glenn Miles <milesg@linux.vnet.ibm.com>
>
> END notification processing has an escalation path.  The escalation is
> not always an END escalation but can be an ESB escalation.
>
> Also added a check for 'resume' processing which log a message stating it
> needs to be implemented.  This is not needed at the time but is part of
> the END notification processing.
>
> This change was taken from a patch provided by Michael Kowal
>
> Suggested-by: Michael Kowal <kowal@us.ibm.com>
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  include/hw/ppc/xive2.h      |  1 +
>  include/hw/ppc/xive2_regs.h | 13 +++++---
>  hw/intc/xive2.c             | 61 +++++++++++++++++++++++++++++--------
>  3 files changed, 58 insertions(+), 17 deletions(-)
>
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index 8cdf819174..2436ddb5e5 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -80,6 +80,7 @@ int xive2_router_write_nvgc(Xive2Router *xrtr, bool cro=
wd,
>  uint32_t xive2_router_get_config(Xive2Router *xrtr);
> =20
>  void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checke=
d);
> +void xive2_notify(Xive2Router *xrtr, uint32_t lisn, bool pq_checked);
> =20
>  /*
>   * XIVE2 Presenter (POWER10)
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index b11395c563..164d61e605 100644
> --- a/include/hw/ppc/xive2_regs.h
> +++ b/include/hw/ppc/xive2_regs.h
> @@ -39,15 +39,18 @@
> =20
>  typedef struct Xive2Eas {
>          uint64_t       w;
> -#define EAS2_VALID                 PPC_BIT(0)
> -#define EAS2_END_BLOCK             PPC_BITMASK(4, 7) /* Destination EQ b=
lock# */
> -#define EAS2_END_INDEX             PPC_BITMASK(8, 31) /* Destination EQ =
index */
> -#define EAS2_MASKED                PPC_BIT(32) /* Masked                =
 */
> -#define EAS2_END_DATA              PPC_BITMASK(33, 63) /* written to the=
 EQ */
> +#define EAS2_VALID         PPC_BIT(0)
> +#define EAS2_QOS           PPC_BIT(1, 2)       /* Quality of Service(uni=
mp) */
> +#define EAS2_RESUME        PPC_BIT(3)          /* END Resume(unimp) */
> +#define EAS2_END_BLOCK     PPC_BITMASK(4, 7)   /* Destination EQ block# =
*/
> +#define EAS2_END_INDEX     PPC_BITMASK(8, 31)  /* Destination EQ index *=
/
> +#define EAS2_MASKED        PPC_BIT(32)         /* Masked */
> +#define EAS2_END_DATA      PPC_BITMASK(33, 63) /* written to the EQ */
>  } Xive2Eas;
> =20
>  #define xive2_eas_is_valid(eas)   (be64_to_cpu((eas)->w) & EAS2_VALID)
>  #define xive2_eas_is_masked(eas)  (be64_to_cpu((eas)->w) & EAS2_MASKED)
> +#define xive2_eas_is_resume(eas)  (be64_to_cpu((eas)->w) & EAS2_RESUME)
> =20
>  void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf=
);
> =20
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index c29d8e4831..44b7743b2b 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1514,18 +1514,39 @@ do_escalation:
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

Probably don't need that comment there, it's quite a small block
already with a comment.

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

In my XIVE spec, AFAIKS the N=3D0 ESB block/index layout at W4 is
different than the N1=3D1 END block/index. I won't change it since
this looks the same in our downstream which is tested, so I might
be missing something... Could perhaps use a comment if so.

> +
> +        xive2_notify(xrtr, lisn, true /* pq_checked */);

Is that really right? The escalation should bypass the PQ state
machine?


> +    }
> +
> +    return;

No need for this return.

>  }
> =20
> -void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checke=
d)
> +void xive2_notify(Xive2Router *xrtr , uint32_t lisn, bool pq_checked)

This can be static.

>  {
> -    Xive2Router *xrtr =3D XIVE2_ROUTER(xn);
>      uint8_t eas_blk =3D XIVE_EAS_BLOCK(lisn);
>      uint32_t eas_idx =3D XIVE_EAS_INDEX(lisn);
>      Xive2Eas eas;
> @@ -1568,13 +1589,29 @@ void xive2_router_notify(XiveNotifier *xn, uint32=
_t lisn, bool pq_checked)
>          return;
>      }
> =20
> +    /* TODO: add support for EAS resume if ever needed */

Comment is probably unnecessary with the UNIMP log.

> +    if (xive2_eas_is_resume(&eas)) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "XIVE: EAS resume processing unimplemented - LISN =
%x\n",
> +                      lisn);
> +        return;
> +    }
> +
>      /*
>       * The event trigger becomes an END trigger
>       */
>      xive2_router_end_notify(xrtr,
> -                             xive_get_field64(EAS2_END_BLOCK, eas.w),
> -                             xive_get_field64(EAS2_END_INDEX, eas.w),
> -                             xive_get_field64(EAS2_END_DATA,  eas.w));
> +                            xive_get_field64(EAS2_END_BLOCK, eas.w),
> +                            xive_get_field64(EAS2_END_INDEX, eas.w),
> +                            xive_get_field64(EAS2_END_DATA,  eas.w));
> +}
> +
> +void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checke=
d)
> +{
> +    Xive2Router *xrtr =3D XIVE2_ROUTER(xn);
> +
> +    xive2_notify(xrtr, lisn, pq_checked);
> +    return;

Also return unnecessary.

>  }
> =20
>  static Property xive2_router_properties[] =3D {

Thanks,
Nick

