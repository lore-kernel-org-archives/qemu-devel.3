Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0C2C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 00:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFijl-0005S4-Vy; Thu, 15 May 2025 20:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFije-0005Qa-P0; Thu, 15 May 2025 20:15:34 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFijc-0003P6-RG; Thu, 15 May 2025 20:15:34 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso2120499b3a.0; 
 Thu, 15 May 2025 17:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747354531; x=1747959331; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tXq37WJ2NYbiXeqNu8LviZUJ1fe9pNWi2RNotunKkA=;
 b=EB0SXup8GKzEqBgaSqQSEjaY2v3/hsOX3Bot3y/kyEEXHz+YKZvdwxNam5ynD8/q12
 mUUv5o0vS0jxx6tUqJ2ZaxY9Rbf+V2g3zylSSvpQkOnDScXtdWbw1KCck7Wu/MJ2SAA/
 Y4RlYQ9XxjgXcVEc7DsfcIPse+u0UNuvxgIT5fgsEdE8+htTqw0TMrFOqShOGFhX6rUO
 x8xUpuPXoV1psxUoA7xPVZXx3XaIJqWrhM52UygQziC2ZyeJ8IJhvlLZpi4zLPX7pSxV
 Af82mdBId4yRNaG3GrAy9d/9EC2+1XB6mOjyP5aR4cXnBY5VjqfvzxSEwc1E5pVN+Taj
 2Awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747354531; x=1747959331;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2tXq37WJ2NYbiXeqNu8LviZUJ1fe9pNWi2RNotunKkA=;
 b=LHgiD7DZk0/YtCvb8I8ymqulFxD23d0OOPa0kYwQXLkpxECtkJpRFFVGduoNKDWNCV
 QfEzPY2KF0XrYbCdVcbBoJvT8ZawtAxYID9MhPQoRdjyz6tfcreFxHyZtTOpAMp8JVwU
 KX8M4PIGmh4gjN2jpFk/oJYo4LltOwx4+SWIAOR5di6yA7CtM67LPnYCPphviO+uibXL
 5qkaeGg1Z78MUvKBCqv1RorkrJENVGiQB/5N63plXjuuLCSX9IPYPlkMEVnFjvA6ME1J
 mG/Oa5LopItATpSsIa8ht7hoOK0NkH46NtRyhwyKVRjHrchOvA96q7YWD9tt4q+2R3HZ
 AHkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQTGynTUBn+nWJ5m7LZYfGeGXnKE+byUdy8qfJtevp8ImYN+Btss5IOsBK6S9WPiXUPxTMTfy8Cg==@nongnu.org
X-Gm-Message-State: AOJu0Yz8orDpKqIwMe2BRFZeCvWIa3AjbIS0SJdvPQtjaw7ai1BfTA32
 y/y2YW+AoUt+S2+fwhdBQb8GW53Xx07GbW1s+szwfBjE8OcSF7SqCCso
X-Gm-Gg: ASbGncs8rZ8qC9c6iX4veAKixMpvQJrEI5vklfUlYVPGU9/0jDInYNqcoJmBqE6Hokc
 HXJ0vOWZpak3E4zwcRxs7tUJx5UTvgLANicpfERmzMNkr1chKEP4PJZ7nUhJZZIzMNe9uY+fjtW
 310EfbPlPpmSt1C3/d9O5VpOHnohkNjedaHQslvvJhsqXSWmfzT2oB/OX78yccNMcRzWBmQjiDD
 SjJMeAp0S9XVUuYvURKH7DALRaNMPhVVH65kBnXsFB4vJMYfEFc9PJOS7HBVW9ipFwJqNR1ZDFW
 WiepH0EmhgmLmuX2X/5wSrs4NbYsW+WD2xUY57InnuCUwsU=
X-Google-Smtp-Source: AGHT+IECj2OWt1Suk3ssre6Vvs1+tT2GPu8m+9Kh5n0wThhRvPLFaNqrCIxOX9WUKSDBGsQd3JsraQ==
X-Received: by 2002:a05:6a21:6d82:b0:215:dbb0:2a85 with SMTP id
 adf61e73a8af0-2162166420cmr1611673637.0.1747354530834; 
 Thu, 15 May 2025 17:15:30 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb0a9893sm473842a12.72.2025.05.15.17.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 17:15:30 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 10:15:25 +1000
Message-Id: <D9X5HF9BNKZC.1AETY0CDNWTAF@gmail.com>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Michael
 Kowal" <kowal@linux.ibm.com>, "Caleb Schlossin" <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 10/50] ppc/xive2: Fix treatment of PIPR in CPPR update
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-11-npiggin@gmail.com>
In-Reply-To: <20250512031100.439842-11-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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
> According to the XIVE spec, updating the CPPR should also update the
> PIPR. The final value of the PIPR depends on other factors, but it
> should never be set to a value that is above the CPPR.
>
> Also added support for redistributing an active group interrupt when it
> is precluded as a result of changing the CPPR value.
>
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>

The second paragraph in there I believe was my fault when splitting
the patch into this one and the previous. I will remove the second
paragraph from this changelog and with that,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  hw/intc/xive2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 2b4d0f51be..1971c05fa1 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -995,7 +995,9 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8=
_t ring, uint8_t cppr)
>              }
>          }
>      }
> -    regs[TM_PIPR] =3D pipr_min;
> +
> +    /* PIPR should not be set to a value greater than CPPR */
> +    regs[TM_PIPR] =3D (pipr_min > cppr) ? cppr : pipr_min;
> =20
>      rc =3D xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx=
);
>      if (rc) {


