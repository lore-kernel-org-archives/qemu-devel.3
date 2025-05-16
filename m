Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDC5C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 00:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFihJ-0003hA-Uc; Thu, 15 May 2025 20:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFihI-0003gi-EG; Thu, 15 May 2025 20:13:08 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFihD-00037I-Jy; Thu, 15 May 2025 20:13:08 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-af523f4511fso1140237a12.0; 
 Thu, 15 May 2025 17:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747354381; x=1747959181; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ne21q6MHswON5FDJKhgq3EjzjVFDznh1HEP17vjaZS4=;
 b=WYl9+Z0rpJYWVuCF8bMXtobAM62pvI3vLA+1mdETQEJ0D0oaxQiVh+9MAIbeF+wjp4
 5DcVvppJ5dNYdydP+KRJTelWhZOlrOZIM0Bam3ExSdskyyc2Csk3WTLd4UkRSIHPXqY3
 ER/y8oF/uQt0RQJCxKBOcxCJrJkJAXz3Fx1uO7ayC1HTADdUv5Y/ioSsuOLZTB06WV7k
 4TJanIiKf4NdOEE9KAtIS1J6dZiXpd3OoYJ9AdvStjtHnamZVOamF6V325Y3usln9uXa
 Xvf+4OSAce/ucWaQbfKDEdfAE0OuMojLTR8P0DoLFLkCITXOo3a0MBOTf15oQzU2wxP2
 Ouaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747354381; x=1747959181;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ne21q6MHswON5FDJKhgq3EjzjVFDznh1HEP17vjaZS4=;
 b=K99Jje+RnmgQuT2EhXF216gphKJNGsJxinZsLKS1yCzZ5aakMbOZzgh+lMDcm5Eoli
 rX7kHO96jANFxHQfeXfrnlyPPpcRVkYvQJA8qEVa6iKvh/vFj84Kk9PvvDu4XnONlHNV
 lRvo4eNc4EClO9LJqWDGJyz5EdL5YAhIdjioxdbrJ2fbPlO31yt7FS8pvdjM6IsFPHU7
 Yk2X/higLjo9Mm+jfbJcEZ5XVdKzoFq2XC0vqjXt9Ky1JREYNO/V0fzBMYcc/sV3YRa5
 dz08pD5DDUuTqv1sR8wpPAohz8dyzrX4my2vdZIb5jPX/02B24Oyyi55PDnDjouQVwp7
 8xxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuiIGaKAjgYlj8dMMiQ9VUtA8pX+KT5qf5pnvXGLv60fpcND/SHDgkTO24uDyJaRvNMv0QbHNNZw==@nongnu.org
X-Gm-Message-State: AOJu0YyuQUSMGg+pzcJgZLPNL1BfaYthOQwnNVP7HyBbaWdShpNHFed2
 C6S/dKwdWPBcbSNJcKC36pCKit/nARaepbUUyGe96362edS4KmZq8ipH
X-Gm-Gg: ASbGnct3iPvOH2CwdE+HKd47ZYztyOq/+72FLiN1B84WZGNlTXJnAR9PhnS2zf6P0Mx
 EoISUc0ITGbokpNTPazeiYZKDy1rC1SnMh6OvZSC1zzavzvMxnOC55DEx6YcPSe7eobcQbAlhyW
 sbUiqipanUnk4mPwMHWhVcxqPTav4DD46t+jhQZt/43Q9enDBcfp9mYQcpqOtCQ6PDWq1ia4sCc
 4H/5Aospz7MO7CxfmEfVFyZgBDoQDyaH/mMfsK0hC1BBpNnr4NhIg9P+RxaU6TkzunJYEJlXPld
 Z/8nwsBW5x0Tu/H7L9pdOUdUCSw5l17TzGMLwy7RIe+QDF8Y4LMa/S9c6Q==
X-Google-Smtp-Source: AGHT+IGTFTaNdoQEMnhsTQe3/G2uiMzr+9ucfCcWm7YGGQVkQm35IwIY/cB3XrPZEEScFgtSgZsvQg==
X-Received: by 2002:a17:903:19c4:b0:220:e655:d77 with SMTP id
 d9443c01a7336-231d452d0e3mr16460925ad.36.1747354381486; 
 Thu, 15 May 2025 17:13:01 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4af1b75sm3550085ad.85.2025.05.15.17.12.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 17:13:01 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 10:12:55 +1000
Message-Id: <D9X5FIL3F1DM.2FXXJ4YPTA41U@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Michael
 Kowal" <kowal@linux.ibm.com>, "Caleb Schlossin" <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 09/50] ppc/xive2: Fix irq preempted by lower priority
 group irq
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-10-npiggin@gmail.com>
In-Reply-To: <20250512031100.439842-10-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52b.google.com
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
> From: Glenn Miles <milesg@linux.ibm.com>
>
> A problem was seen where uart interrupts would be lost resulting in the
> console hanging. Traces showed that a lower priority interrupt was
> preempting a higher priority interrupt, which would result in the higher
> priority interrupt never being handled.
>
> The new interrupt's priority was being compared against the CPPR
> (Current Processor Priority Register) instead of the PIPR (Post
> Interrupt Priority Register), as was required by the XIVE spec.
> This allowed for a window between raising an interrupt and ACK'ing
> the interrupt where a lower priority interrupt could slip in.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Fixes: 26c55b99418 ("ppc/xive2: Process group backlog when updating the C=
PPR")
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>  hw/intc/xive2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 453fe37f18..2b4d0f51be 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -1283,7 +1283,7 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int rin=
g, uint8_t priority)
>       * priority to know if the thread can take the interrupt now or if
>       * it is precluded.
>       */
> -    if (priority < alt_regs[TM_CPPR]) {
> +    if (priority < alt_regs[TM_PIPR]) {
>          return false;
>      }
>      return true;


