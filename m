Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9129AC2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 00:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFikO-0005xy-4f; Thu, 15 May 2025 20:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFikF-0005rV-4F; Thu, 15 May 2025 20:16:11 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFikD-0003UJ-73; Thu, 15 May 2025 20:16:10 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-30e80f03760so236181a91.0; 
 Thu, 15 May 2025 17:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747354567; x=1747959367; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3b9I3cAShdsCHKqRoizkJ1rBrmCqhcVFQsEwjB+GgUE=;
 b=fxAJPxYVQIQAQl4WTOcGOKrpJeuUoflGBqIuf+JHR3jlPLu/0nUeMyEcBJqChLlQ//
 nefsDT5fQo7//5QIQYk5IoG+VRGuRZiVnPH8o8alAAQH6jr1G7vtSHMAuDcfTCL1KXHl
 SxePJdjXsWVuX+WAk2aQFfKUYZHT2m/tiUecESs67ys/2UKpNi4EA9uQ1leDlDQifJtM
 R8bA//VyhnV9qZqFhJLQNpKydZ8TIfdz26Y3Tafsp9UKoY2TeNbdSQN8tnf3bHhaqi78
 W23z6uOAtOKeekLzx10X2TkwehJ6VFOhe5Y4vRNY9CxleYCkSE+QSqNowXUxN4X8kTwF
 wTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747354567; x=1747959367;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3b9I3cAShdsCHKqRoizkJ1rBrmCqhcVFQsEwjB+GgUE=;
 b=kvtVV+VgB9Xc1w7vrarBUXXGDK4oe0YjDdwnizz7v1NKhiibC5L1s+opKFn+muRWqh
 pDO9kUMtDPBDUflxOxd11GCSsW8LUJrs6J+OylvgfjBaYilhzgh5eBFs3t/JA8zMwKci
 wAezPrxZELlxvUozJWL3pxTuKjM4KQvGhflWnOGFYFw9JggCnuECsndk2w2J4Emn9OYT
 864UZdN5fjkCcwzyH15kB7C2R2gJiMvWq6VoSqcWr5YqXbIMfYcX2yTpw/c2X6PBTNiU
 Ou7b1GvKXu6CTFL39vOi/UKkROZ7gE9vD2+J96gajitHGOz0Mb7BNTKIBvu5B0GSF1Jf
 Dy/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhrxf/bpdmZ6D4uB54UAGP+3bJTRCovFXibLO0V9CJNA/rE5VCzQoE0CswcHQX8DoScpcxoOv+vA==@nongnu.org
X-Gm-Message-State: AOJu0YwFAKcJb9vO6KtA8gjRJEhZGWGBwCGeuDm9nhQ/AEWbZsbYMO7R
 zCFsMC1t6/+FqBrgXWubdV/zoyhxBSRkor5qE4nsMFSPgMuofuVohu9FLUhe2A==
X-Gm-Gg: ASbGnct58247pfc/KyCS/WFWqhIvMoI3EICkN7AeQIid1cGh4fELVraUzS5RdFa7lSM
 NwlIywvhHEpEGYVOFwcPS6pyX5htYG8uugWQz9Q7SKlJ0Ul4BLY0qtPoX+g0MS8jucV/LVQ3yh/
 YbLHR9wBEXlLS4I9LzR46vk/MoO+eKPu/qBB8BAvzNLqf0yhd0gLO3gOze7DDDmG2dDv32hvZ+f
 bIIBYyJ5vrisLYD6iuzMZXx3f3LT1kqXJYfYVgN6O3kR7Df5zMAEinmyZMnoOX5ls52XWQkqC5j
 u7nwSEtECPhW/8DBPhFmYzCse9mfAhJ0sDj6PLnsl63ATvQ=
X-Google-Smtp-Source: AGHT+IHBUeURoEyCTS4KhiD1YOVV0WkkePTTo5eE6O+cJAQZGqNp/QxnXAilx3TOddycwSqgCVGUcQ==
X-Received: by 2002:a17:90b:4b82:b0:2ff:6f88:b04a with SMTP id
 98e67ed59e1d1-30e8314d95bmr672214a91.15.1747354566775; 
 Thu, 15 May 2025 17:16:06 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30e334254f5sm4108111a91.13.2025.05.15.17.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 17:16:06 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 10:15:59 +1000
Message-Id: <D9X5HV4ELQMG.2A172BOYBHB1F@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Michael
 Kowal" <kowal@linux.ibm.com>, "Caleb Schlossin" <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 18/50] pnv/xive2: Print value in invalid register write
 logging
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-19-npiggin@gmail.com>
In-Reply-To: <20250512031100.439842-19-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102e.google.com
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
> From: Michael Kowal <kowal@linux.ibm.com>
>
> This can make it easier to see what the target system is trying to
> do.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> [npiggin: split from larger patch]
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  hw/intc/pnv_xive2.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index d7ca97ecbb..fcf5b2e75c 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1197,7 +1197,8 @@ static void pnv_xive2_ic_cq_write(void *opaque, hwa=
ddr offset,
>      case CQ_FIRMASK_OR: /* FIR error reporting */
>          break;
>      default:
> -        xive2_error(xive, "CQ: invalid write 0x%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "CQ: invalid write 0x%"HWADDR_PRIx" value 0x%"=
PRIx64,
> +                    offset, val);
>          return;
>      }
> =20
> @@ -1495,7 +1496,8 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwa=
ddr offset,
>          break;
> =20
>      default:
> -        xive2_error(xive, "VC: invalid write @%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "VC: invalid write @0x%"HWADDR_PRIx" value 0x%=
"PRIx64,
> +                    offset, val);
>          return;
>      }
> =20
> @@ -1703,7 +1705,8 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwa=
ddr offset,
>          break;
> =20
>      default:
> -        xive2_error(xive, "PC: invalid write @%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "PC: invalid write @0x%"HWADDR_PRIx" value 0x%=
"PRIx64,
> +                    offset, val);
>          return;
>      }
> =20
> @@ -1790,7 +1793,8 @@ static void pnv_xive2_ic_tctxt_write(void *opaque, =
hwaddr offset,
>          xive->tctxt_regs[reg] =3D val;
>          break;
>      default:
> -        xive2_error(xive, "TCTXT: invalid write @%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "TCTXT: invalid write @0x%"HWADDR_PRIx
> +                    " data 0x%"PRIx64, offset, val);
>          return;
>      }
>  }
> @@ -1861,7 +1865,8 @@ static void pnv_xive2_xscom_write(void *opaque, hwa=
ddr offset,
>          pnv_xive2_ic_tctxt_write(opaque, mmio_offset, val, size);
>          break;
>      default:
> -        xive2_error(xive, "XSCOM: invalid write @%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "XSCOM: invalid write @%"HWADDR_PRIx
> +                    " value 0x%"PRIx64, offset, val);
>      }
>  }
> =20
> @@ -1929,7 +1934,8 @@ static void pnv_xive2_ic_notify_write(void *opaque,=
 hwaddr offset,
>          break;
> =20
>      default:
> -        xive2_error(xive, "NOTIFY: invalid write @%"HWADDR_PRIx, offset)=
;
> +        xive2_error(xive, "NOTIFY: invalid write @%"HWADDR_PRIx
> +                    " value 0x%"PRIx64, offset, val);
>      }
>  }
> =20
> @@ -1971,7 +1977,8 @@ static void pnv_xive2_ic_lsi_write(void *opaque, hw=
addr offset,
>  {
>      PnvXive2 *xive =3D PNV_XIVE2(opaque);
> =20
> -    xive2_error(xive, "LSI: invalid write @%"HWADDR_PRIx, offset);
> +    xive2_error(xive, "LSI: invalid write @%"HWADDR_PRIx" value 0x%"PRIx=
64,
> +                offset, val);
>  }
> =20
>  static const MemoryRegionOps pnv_xive2_ic_lsi_ops =3D {
> @@ -2074,7 +2081,8 @@ static void pnv_xive2_ic_sync_write(void *opaque, h=
waddr offset,
>          inject_type =3D PNV_XIVE2_QUEUE_NXC_ST_RMT_CI;
>          break;
>      default:
> -        xive2_error(xive, "SYNC: invalid write @%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "SYNC: invalid write @%"HWADDR_PRIx" value 0x%=
"PRIx64,
> +                    offset, val);
>          return;
>      }
> =20


