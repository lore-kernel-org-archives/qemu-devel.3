Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A00CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIU6V-00058E-Rw; Thu, 30 Apr 2026 12:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIU6P-00057Y-Ey
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:19:01 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIU6N-0003IN-SM
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:19:01 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-65006c99d38so1139748d50.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 09:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777565938; cv=none;
 d=google.com; s=arc-20240605;
 b=iRSgSupTtfw+dd5vSJeTZf/R4Lbys8YMhA038jSs+QPckNvG0gUs7vkS0UdWKtCsV8
 6qD3I2EnMxeqAQzD6ZKiQXx03WmhY9xI6WcWC2ZzZgIs8pSmn8nzc0xKTlr3gNKBVHFd
 IA0u7BDiLTSeov4iDAnC4NQV5CL95JwqgTZASkd3aG6vVkZI+pEp+md5x2QQjYBumwJI
 lO2IQr9HDKFjeJKoYMx6TgC0s2jKhle/2zS+NDQ+XENOvtBt6SWsnuese3ry14TzF690
 sAld320XsEMcibcL4eSJODJQ+aE3TmQjWGavrXcUT/YR5ARQtpFGTts5BodthS0Mwo5D
 hEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IWf6n2+rQx00tlBPS009bMm3BcgcawxuPrXZh+58IsM=;
 fh=D1BglRlJyEUKfawI0ZHvDE6D7YDMhtOop9g6laYss04=;
 b=GDWYuiFsNb1hVqn/JgjF0OgdeS+K02D84Tv4OW8g1x1Vii+mZFANk4rLYtwuGlX84w
 LUYahZYE3VMw/WWEJwz4Su+UuKHUw41DQMTsPwIV0hK4WQhxvQZH5GoFCIUTa1MZc8pw
 Usy6+GdyV4STymGPnnVeC1krUJzHydprLz9wi5yL0O3Fqb5aBoaYDBwVxB0VIQDLIIyk
 sgxZNQ+sgeH2qv+XF/xXCiD5j5Gqbu/woIqYzpek2eIGs271fOWFpfnZH9bzXInXrkbg
 HqRgSazSpSxD01sm+rBLKwZkMuBK6IszHiCSIdDJkuHzDz3ipQ6M73s1UCAbTA0Vgy6w
 Xglg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777565938; x=1778170738; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWf6n2+rQx00tlBPS009bMm3BcgcawxuPrXZh+58IsM=;
 b=orXTOQZdNxoP9mxmqlRQW/19yPOGgMa5pgY3geqDXps4LEbavH/AlbnR4172mo7yW6
 ywdwtP+Qjhjqx6rjeoQLtOuK2QLkt/8WGtnAVZm8LfkKH4jDWaTgpC3gchHcci0dXMXY
 B3ooyGT4D03ewPH/T8Jf7tAhA23+XHfu5y0ziGGqwjVtkKcbO/+XxgRbY2VXIXSCrbdm
 H8B+5dHaa4pDd6BpJ1yu/mqu+R+TUCgvvLir03q5MjmrN6fJrRebco7Il6DIlgej4vvD
 PtT0q0nvkpWJEzJYLFU4moyp8eVkrq5RO2peeeU9Qz+enDfgcUELfuEe7bQ+rdlzEKSd
 7eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777565938; x=1778170738;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IWf6n2+rQx00tlBPS009bMm3BcgcawxuPrXZh+58IsM=;
 b=mwdbjLBACpl1epYnmG4A/mj60YKdrWnoJLGb5is8AFbcZZwxMLcgubC+IH6upfiL0P
 I97zTroubc7BhAhXMjrw8kBIClAakSBEvvEBqP39WmPlArb7bpSnAiB847h+rSYHZTuX
 qXaN8769Fuz+k13zQWXNSKGoxajprCzGYTGGtk9+6nYXzfGKPz/qm2wA8VFLdegecjTw
 2wf3Brn0Sy8PT2eIiR3QtM5DZ9zipsyIqy18+RJGq8JkBgZJw2JqGEfDKGo0AVsDh3Xp
 NmU/KAEic+Adc1S+gVrsZpGcq5kBTYoPb0hytR94Kx/HYXQLIm4OM2U8U5l/pA8oev7T
 RJDQ==
X-Gm-Message-State: AOJu0YyNGKCNRJn1o7sZeV8RCfVv4houuc32nHqPfAvYj0j/LiywS8bb
 +gGbT+9Si8l2Y241f7/EWW6z746+iGVjrG+GSdOH91V/bmNwTxUd5S4UZGP5lmqaxuARH4nyZBw
 fpf3Epjs2LP64tfkxKvPh3AL+zgalH9M/oZg4c2FQ2CS13CcFTiWRdms=
X-Gm-Gg: AeBDieuXYeUddP0OzBVTiiwTKmRXnImWTdLlSjX0bw17SaVOxOWMujNbkkUWrwIbOb6
 soVU5F4QgVJTLZSB36SO2ETheK8kvE804VmtaoG9QZbcrKfegMjeFssAg6i0qb4xYPx6gIwgPkm
 WHyrGGUSJQpg6vuGS/6DlOjBia1JUjLXzCFLzN9WfofUruSZc8dI88FPftoPJ2toCtSfRIPOnlM
 RQCK+1S3nHNfFw3jyDLSHoNwcINP1HditWnMkyzen7rVNJ1xUn0lyMahKQbYZgm+o9tWpE6oVAn
 XGL+6McwbBoNRVKIov1C9aoqNCVDc3MD3P0j2PAjRlXsrJlGw35ai81ozXdPU6MFmhKvaotFRCK
 sRqs7fsqxxT3T
X-Received: by 2002:a05:690e:190c:b0:650:3e1f:907c with SMTP id
 956f58d0204a3-65c18503a47mr3017462d50.0.1777565938317; Thu, 30 Apr 2026
 09:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260430040753.3337-1-iyzsong@envs.net>
In-Reply-To: <20260430040753.3337-1-iyzsong@envs.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 17:18:46 +0100
X-Gm-Features: AVHnY4IIIorx1xkrEBS1R9K2W-QNLlsG2iNu5IcnwNcfXuKfCBUy22hqBemJxs8
Message-ID: <CAFEAcA8AUr3hOyTdDJhUpmRMDz59j2gyYrXcgYR1L5D7=tv4KQ@mail.gmail.com>
Subject: Re: [PATCH] hw/net/allwinner-sun8i-emac: Flush queued packets when rx
 is enabled
To: iyzsong@envs.net
Cc: qemu-devel@nongnu.org, =?UTF-8?B?5a6L5paH5q2m?= <iyzsong@member.fsf.org>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jason Wang <jasowang@redhat.com>, 
 "open list:Allwinner-a10" <qemu-arm@nongnu.org>
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

On Thu, 30 Apr 2026 at 05:08, <iyzsong@envs.net> wrote:
>
> From: =E5=AE=8B=E6=96=87=E6=AD=A6 <iyzsong@member.fsf.org>
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3459
> Signed-off-by: =E5=AE=8B=E6=96=87=E6=AD=A6 <iyzsong@member.fsf.org>
> ---
>  hw/net/allwinner-sun8i-emac.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.=
c
> index 9b7c67ae8e..7cc06b73c2 100644
> --- a/hw/net/allwinner-sun8i-emac.c
> +++ b/hw/net/allwinner-sun8i-emac.c
> @@ -727,6 +727,10 @@ static void allwinner_sun8i_emac_write(void *opaque,=
 hwaddr offset,
>          break;
>      case REG_RX_CTL_0:          /* Receive Control 0 */
>          s->rx_ctl0 =3D value;
> +        if ((value & RX_CTL0_RX_EN) &&
> +             allwinner_sun8i_emac_can_receive(nc)) {
> +            qemu_flush_queued_packets(nc);
> +        }
>          break;
>      case REG_RX_CTL_1:          /* Receive Control 1 */
>          s->rx_ctl1 =3D value | RX_CTL1_RX_MD;

Thanks for this patch; I've queued it to target-arm.next with
an expanded commit message.

I dropped the direct check on (value & RX_CTL0_RX_EN), because
allwinner_sun8i_emac_can_receive() also checks
(s->rx_ctl0 & RX_CTL0_RX_EN) and won't return true unless it's
set, so we don't need to check the same thing twice; so the
patch as I have it is:

@@ -727,6 +727,9 @@ static void allwinner_sun8i_emac_write(void
*opaque, hwaddr offset,
         break;
     case REG_RX_CTL_0:          /* Receive Control 0 */
         s->rx_ctl0 =3D value;
+        if (allwinner_sun8i_emac_can_receive(nc)) {
+            qemu_flush_queued_packets(nc);
+        }
         break;
     case REG_RX_CTL_1:          /* Receive Control 1 */
         s->rx_ctl1 =3D value | RX_CTL1_RX_MD;

thanks
-- PMM

