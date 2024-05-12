Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A6DC25B4F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 16:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Bkw-0002DS-IY; Sun, 12 May 2024 12:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1s6Bku-0002DG-6W
 for qemu-devel@nongnu.org; Sun, 12 May 2024 12:08:57 -0400
Received: from bactrian.cherry.relay.mailchannels.net ([23.83.223.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1s6Bkr-0003ow-T5
 for qemu-devel@nongnu.org; Sun, 12 May 2024 12:08:55 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 583327630AF
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 16:08:49 +0000 (UTC)
Received: from outbound1.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id B6E617626FF
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 16:08:48 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1715530129; a=rsa-sha256;
 cv=pass;
 b=lfC4RXDxauqXDN6lh++gJveEWplLBTptBuWjZb05VZbV8/f4te9Zw1eI6VY1yQ9utb/7bd
 yykY/idboj2Qd32Ytj2lqafQctR+y/2LazcqGF8ZKd7mDKfssjsUMtzs64z4+vThiYp9iU
 A8iglPgsUxgqo+QcsDJ+/6xzmIF/MPZRL7FYknKcEFjO3rkhNx5JM7mF2s2mMpfqqJw1Fy
 xQpj6Fw4f9amQnAgCGq/WmTN7dPcaTRwq7+Nc7SFe3eeoyTOYcV5NVnlUhlGL8M9VBnMxE
 CNAI0JsWTTv9EySDOImZ0ec6IzTSp1bleYONkAS6FtOzEB9TI5heHjIutS3VhA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1715530129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=D6A8ryl9wdE6A8gjzfy+/t3vAvdxENVJQZjv27wuTC0=;
 b=xovKpIty9VinqVhcEyTQjBNrPQFWf596H7ZD5UoE5to7bXTG52tz6DZkMB2Z01hQJvYZ30
 6EzjYUzLSbU+zNRHrnXKnJ05RYFHy+hooK7shdQNmAUps1Nq2A76oawroam76l9bDeMcSQ
 nl8NzalVhK1m03XrY3gpDPAMu1WtVjprjkzBNC5R7x/ncav+7PrnHSOzQpcR0CX+JgzOo3
 MC0LMeBFfTFKQ4UkzmzSlV4PfhzIjRf+rNKXnbm04ocfhswFlUm9Uv2pAgYUhXDXdO8TCU
 csUmH8qqyUp+C24FGdJUPCrPz8s/482Dk+xVVgsTGOArsGugeJiiuFuS2ea4bA==
ARC-Authentication-Results: i=2; rspamd-68bbddc7f5-qjdxh;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Junk
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Coil-Snatch: 1cb0f8485c9bc67e_1715530129231_1193868879
X-MC-Loop-Signature: 1715530129231:1394076708
X-MC-Ingress-Time: 1715530129230
Received: from outbound1.eu.mailhop.org (outbound1.eu.mailhop.org
 [52.28.251.132]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.107.48.229 (trex/6.9.2); Sun, 12 May 2024 16:08:49 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1715530124; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=FwAq2bhXa9tL8s1A2O3//rQXnygmj4Swef/zJgMK49sRZqcupR5XQfMJ9b6Ch0VhoN9PrcHpyBNIk
 3KABu8oLKd1W/3rWn9/R+wFudVLJjzjeRkZp8O7846Hm2oJAmBb0hqDF6Z88P50bPKpsJODoJ0Kn5H
 PQO5EYTLa+0pT759XHOQUhdVnZ84Xe6A4/qJUdoKbh+3VInCBRVfy7oMVz5iVQQCvHnhn3hP5M4OFf
 xMU35MtAdpttU9VGJ8OPT4t+jxJDQLl1cLcwaNlLhkc57ZF8yZ05GFdmCZYbwIrVbHIFqfOmsbsaih
 AOd1VH342/6cJWWpEfeuZ/uMmeC+Sgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:dkim-signature:dkim-signature:
 dkim-signature:from;
 bh=D6A8ryl9wdE6A8gjzfy+/t3vAvdxENVJQZjv27wuTC0=;
 b=ogDWd/lh609GptSg/GKI9Gml1G4WkTP70wyXcpOqfSVyZKmaiwjh/TNJyOPXe1L0U/WXuXBr3f2Ze
 5I4blLJ6AUfF/m8hf+ixvd/YRW36JrMnrVScQopVjfc27eInka1SR3CvuPUkuKS6nhrK1Y8yX6YBCr
 G50fOHij7zt1+HLgIIq0gEgO+5+VDXktzvKiBaveBWms9doi48rIakNAyCe6kPFA7NiANNMoGhccd0
 xeP8NGrwP6ojn08sEVeLk25eS9YlD1xGXseL2rezK7wQOnM7dyNy7KEScxFFfsr+d7xgB+WzTPKJ+m
 8eDcAPT91zv5kQeEvwbXoltPX5AN+Fw==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=ddbT9RUP; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:from;
 bh=D6A8ryl9wdE6A8gjzfy+/t3vAvdxENVJQZjv27wuTC0=;
 b=NVyZjaj2Bv5OQtgpHmrCZUJ8wkYGfBrXg30MjGzHlxO+I9j7eB7cleWLf6lziU8CZuQrxDPtyRWTZ
 vpzD9tHniQCFaYxm57vbCQYFbAR4ucNJJ8Cl+qzKv6j2BOQylzQrbqfgJSEjxQpObcxDyECawov/xq
 JmEsh+yW0gGn73Dc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:content-type:mime-version:message-id:date:
 references:in-reply-to:subject:cc:to:from:from;
 bh=D6A8ryl9wdE6A8gjzfy+/t3vAvdxENVJQZjv27wuTC0=;
 b=sNuYLxbNLFOvZGGkZP8FB2YWw2CaXbpqarqqLnSlwjZoc+QAVGCHTEB+ketP/mMPKHi4PHohOoXbG
 xZyxdx43q6zIclOpwfDl6LWt/MUavqJ+qBP5n4ec1iS/BteNDuXFKPRbgLzeCGE5hF7sZj8JV0WqpY
 lcP6E0JSlk92LLfbd2HqAFusfaE/gfslxCj1dRS+jKBxn/Jtb1KHnZE2g+pvgEc8jFvO5p5NF9AlR1
 1LX6A27BK5dLQqq4Sblp1QCzTl9LnfjZ+a8LiNc9plv09Wx2V4N9wm0r2I9IcnZGflUOBNFLAAw2KD
 rqNHroTOvKGRmSEsNp9GbdX4PYDQTyg==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: e5bd767f-1079-11ef-9401-afa6fccf0072
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id e5bd767f-1079-11ef-9401-afa6fccf0072;
 Sun, 12 May 2024 16:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D6A8ryl9wdE6A8gjzfy+/t3vAvdxENVJQZjv27wuTC0=; b=ddbT9RUPm1YC9ndnVAVG4ucUou
 +TAJchuGLqVgS6OfL6qSoWhOYfyAWYitEQv/9JuqN+LzudXYZK0U6nRVEHYn3FS1jODvbjTkXjoR0
 UU8viUSDgZAWurttPcy1FlEsa1aj8THkheMDhuPt1gsK7eNiy/QISknyKxtSWJ5/rr/YDW87H1CsZ
 9E/MAq+gCzP34SffS9j4MgZs/5VWBGOZV+xjLcKT+UGGtH//Y3kukFXdpVMa9E9+t/YKLku43fwm2
 kazm5yQo21eHzOZ0kAWHLNjwIRXYAizFt/0ZCwsayewV+g/TQUImqu8kYGHo3rb7VuotgPKvISzB5
 5kRs9/1g==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1s6Bke-004VBg-09;
 Sun, 12 May 2024 18:08:40 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 00/45] target/hppa: Misc improvements
In-Reply-To: <9e271098-ce7b-46ad-9eb8-b49b912eaa49@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 10 May 2024 16:48:14
 +0200")
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
 <9e271098-ce7b-46ad-9eb8-b49b912eaa49@linaro.org>
Date: Sun, 12 May 2024 18:08:35 +0200
Message-ID: <875xvjovwc.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=23.83.223.9; envelope-from=svens@stackframe.org;
 helo=bactrian.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Cc'ing Helge & Sven as I'm going to skip this series.
>
> Suggestion:
>
> -- >8 --
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1b79767d61..be7535b55e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -254,6 +254,8 @@ F: target/hexagon/gen_idef_parser_funcs.py
>
>  HPPA (PA-RISC) TCG CPUs
>  M: Richard Henderson <richard.henderson@linaro.org>
> +R: Helge Deller <deller@gmx.de>
> +R: Sven Schnelle <svens@stackframe.org>
>  S: Maintained
>  F: target/hppa/
>  F: disas/hppa.c
> @@ -1214,6 +1216,7 @@ HP-PARISC Machines
>  HP B160L, HP C3700
>  M: Richard Henderson <richard.henderson@linaro.org>
>  R: Helge Deller <deller@gmx.de>
> +R: Sven Schnelle <svens@stackframe.org>
>  S: Odd Fixes
>  F: configs/devices/hppa-softmmu/default.mak
>  F: hw/display/artist.c

Please don't add me as reviewer - i'm only looking in irregular
intervals at hppa tcg in qemu.

