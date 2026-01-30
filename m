Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107A7D49C92
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 11:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlmHs-00025j-AW; Fri, 30 Jan 2026 06:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1vlmHo-000242-VD
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 06:03:36 -0500
Received: from mail-yw1-x1141.google.com ([2607:f8b0:4864:20::1141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1vlmHn-0004VA-EJ
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 06:03:36 -0500
Received: by mail-yw1-x1141.google.com with SMTP id
 00721157ae682-78fdb90b670so18237657b3.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 03:03:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769771014; cv=none;
 d=google.com; s=arc-20240605;
 b=lV3A7+Qf9GkxMcSA865IFVIfRUCUxbI9BT5jrOvpj+RPxW9BCi34+PTNFxUfAe0/w2
 mpASTdT1t3nyV6ZwbeWiODbAzK3Vty0CIjsXldXV0egMKFR0m+/oDWT5ysU+x80iXU4u
 uIvBlVPjuGSqcSPrwFv2jUMWvKzJwVB7M3HpLOLo964jMuSAppLiF5tM0h2+GSKjr+7j
 3d/FfXpojNCyYpJYb8BP0Jx3VZ7FfKuJv+kRxq8gLkJ2xNhQ6MWJEz4xrXu7prAuqVRv
 jlrEvSHteb6U5PtQFAp8c63C9PYuFm1gXN42YlhlezHHLpIiOGS+2DNDp7SvQzvPlvDc
 eZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bPK3XofH6l8W+BXoYHETOkHyF+6BUZl/toK3hKE7jc8=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=d32dh41Qt3QfPMQOZzTPMGGBjju3B1aVAO5ttduk+Dkbd8ELgsj2G3u5V5tsd5amlE
 Auvtie9LbProJ2vOZeUjAh8DnspK3lHd8dqYiF+d+nx4+6nMChoa+7vj5DhcpcURsbWz
 6qndySJB6bTpx7mF0G3IcLuYeKP8yntkm1wnkh9XpPG5U35kpQ43ddq0yk5vkHHFSpRa
 4KyOX5j1V37oNtCtu2io8FEva0lkPv9ZZhZ34gsVFtOgI0fCWfIQU6/STw7+MRGV04hK
 EwlG/r/gq3gDLbDcHKKFlonmN2cQctz6RVP2Yuo0ddRE90HZ/1EKfieh1d8Gz//XmEk8
 ccaw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769771014; x=1770375814; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPK3XofH6l8W+BXoYHETOkHyF+6BUZl/toK3hKE7jc8=;
 b=R8kOE2H6WYPIELJBrnb72mw5kObQiEJAZRVSEPaqlDt81UtJM9w6GIMf9TcARMT4Zj
 71z8NsmfBfVM3UPtj9Scq5aASTnS/vjJi3kHvCfeYH8WcCuurM0SCuAqp4wijJRdQV0p
 9p81GPuFfaXjUjfBkDcunxG1N4a/h17XzwXlkFuyXjbXl7ibrVwwjZzOdOpkON68MBhR
 LlBWBEX7Rb2kdrzJtqtGhqRHD4+dDgm29At2rAbqXSXLMHY86pZr33v2AYoJ2nCDOU5c
 TDpgAc15wiWsYjMenA8tsXZFZjxNR0BxYO238pR8QQ/fekKFNYFQ87bZItxat6aNYQKE
 1DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769771014; x=1770375814;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bPK3XofH6l8W+BXoYHETOkHyF+6BUZl/toK3hKE7jc8=;
 b=bkiuJdB68upVCstAh9abyK6AqJTouiaI8keQ+bIkZ4BqeELl2XQtxaFidwZDXZoeCt
 WwgbdXUi0ZEVxEJQyEZbBJDbjoZC0s/ibyLDqImEJKXza4xl1YNXlFO1aUXSXKnqkmiu
 bi54VtVLo+YHnwpix74PoaTH1DEUk5GIszcNsaTOSNKvGgwADsL67qKR6E18h4UOLOM/
 A2eqEENN0h+k5vxVvdrae4+JD80xrUdD2u9W0R6jj4BZ1mrz9bNbBDhAAFR52OBsvFvu
 pJl4W0sfD7PDR2PaxgHjM7sw0HLGTlgHgmCybhiIGafGtl0iPph+eaVs+U5lMn+ihViB
 iWiQ==
X-Gm-Message-State: AOJu0Yym2HHV3y1rwsXiPxBZhraqQjmPYVqvYMjGWPg49a+4nOQj/wQY
 M8SSrTlU0CCDlGQsxTaqm3XBlfUw+Ph2jjOifhh9JVcxAqJrEKQe64ZSGlEUNVJmGp5OZOilfeJ
 /FsRNg7bU61Q8iJ8dxplue27Yj9FTNAFaUPgS
X-Gm-Gg: AZuq6aK37CMwsoSHt1kf44UyyQdbfCJJ6F2T765z6g1tpoSzAyKIFVnB5zRtD2tFvN0
 D3oDHNQjxD5jJgmXTH+JvjSy/hxHvoBPbZJkPWUIs3/5ybsjXg8ncHs/B6b79TUCCGqnR76s9pv
 rK+968xRTCbwApcH2AP1l4GWyp2oYNGi+bn3keV7mD0lEmcFit3aJJ1tSm0v53XbBY/3He70WCB
 UHkceVNfyz00R/w0OpCJknrLrmB4+Kk+kc4IbPTovKs8PvG2fbE4ykJ38DXe7s1An9Ru7A=
X-Received: by 2002:a05:690e:4089:b0:63f:abf6:1cc with SMTP id
 956f58d0204a3-649a83a5768mr2063820d50.13.1769771013794; Fri, 30 Jan 2026
 03:03:33 -0800 (PST)
MIME-Version: 1.0
References: <CAHhgW4UH=_65pZJEACBXh7J0XN1SH1HFS_e_FCN8Zm2sKa1sww@mail.gmail.com>
In-Reply-To: <CAHhgW4UH=_65pZJEACBXh7J0XN1SH1HFS_e_FCN8Zm2sKa1sww@mail.gmail.com>
From: Yodel Eldar <yodel.eldar@gmail.com>
Date: Fri, 30 Jan 2026 05:03:23 -0600
X-Gm-Features: AZwV_QjD_4P6xcpWcUaDdkr8FFvFvnSt8N6rivTFCr3HVOw2YmPOB44PCXxzZu0
Message-ID: <CAHhgW4X-R-Pm1ZV20UuBPbCtnSmp5r1HkwMjWMZ7KuVX0Cp63w@mail.gmail.com>
Subject: Re: Wiki Account Request
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1141;
 envelope-from=yodel.eldar@gmail.com; helo=mail-yw1-x1141.google.com
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

On Thu, Jan 22, 2026 at 1:30=E2=80=AFAM Yodel Eldar <yodel.eldar@gmail.com>=
 wrote:
>
> Hi,
>
> Can an existing wiki user please create an account for me?
>
> username: yodel
>
> Thanks,
> Yodel

Ping?

