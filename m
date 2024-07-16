Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44959C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 08:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTdAc-0007VB-UL; Tue, 16 Jul 2024 04:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1sTdAb-0007UD-RC
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:04:21 -0400
Received: from snail.cherry.relay.mailchannels.net ([23.83.223.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1sTdAZ-0005Jx-R4
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 04:04:21 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id BEF7B842FFD
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 08:04:16 +0000 (UTC)
Received: from outbound5a.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 79FB0845A7F
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 08:04:15 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1721117055; a=rsa-sha256;
 cv=pass;
 b=PNbmKQAiHu4WsMVUukFb+EXjEdujwGOLGwrmPaBgZa1DZFIRJ9yu4zZjJUcUcBjvjhyUza
 74YsAeOGNpt1Rp0YVHCVnpGvDU7eYpOnPoBr6KhJvAZU/JCl74xd1PIrwKyPV2hx+YD1z3
 4gbFsAkJ/QYs7nLITFjFSJnkXTxfh57vSVynvQcYQuJLz9NZ5wGBT8fJVc5OvKDRD2BB4Y
 Rdwz2O1UOuQSy15solENl0p6N0k7fjjHK3IvzMp/43sE3Z8+A9DnaFZRjG4i8em3+sG3GA
 7j2cKPluS2La/vHRgj+DPSJx2y936MCKHITn714Yho73L2jF0d3167kOy1QeWw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1721117055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=VThQtfi6u0YeGA7dJ0ARBY34MIZ7BfQM5rYxotaDey8=;
 b=gXheTYUiQqbIj0X+wf0gzhltTvYPIbLkIX4IYjQEm+a7z+yAfC3V7+AijuwE8PqUVbowbP
 FrkrbqdRDB67DWvN2w66AqjZl5fWyrjfG/TGPZZstyFUzzhb62Dythfsbw5ef64UVQFxrG
 MjOd9XcFQS20odXxQmlXnT9xHUucUyW9F1b5hgrd3yxHzX3ayvbHNa9tWn+D7OcN7JRtXW
 xi8tIvfzvQHtqCJjm0edTgqynjwevJ6SpmY3aDwPzxbHQmKLv2pDmvmTB7H3HTptfalQav
 S56boMMqDPohgrDVAE9SSsoIVg48KhnvLH0r2eqX87u5oxF7H00sqWz8wcV33Q==
ARC-Authentication-Results: i=2; rspamd-585d4c99d7-w4tzv;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Junk
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Abaft-Ski: 651d879478eef413_1721117056650_2154801834
X-MC-Loop-Signature: 1721117056649:3154525098
X-MC-Ingress-Time: 1721117056649
Received: from outbound5a.eu.mailhop.org (outbound5a.eu.mailhop.org
 [3.124.88.253]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.115.121.17 (trex/6.9.2); Tue, 16 Jul 2024 08:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1721117042; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=KHGIkuTPEnIHENN10Juua+EIOa6w7jfhpQAwl3JVCOFolerzeuUWCzbmx7ozThZIBphOC4XarbWQD
 wrG86jW9tGs4YKwXQ7jAQjTzRxUv27jsnl4+1GrUuh7RY36WbhZ6NQ735YODKzazzcFaQICAiKQ4nM
 MopLX0n306wPWIepA1AoPwax80LGHL3UT3blL/3wtd/zsC9F5pH2q9MpDkTufsUsmswCjC1x2IX8mU
 jjai/fy8bkiOFd4guwKJ1o9edciTYEpBxpVJLqy65d0YsjY2vAhz58p2YFMhGVCmYlhUDpupQ5y6Dv
 j4tyZgXQBC/q3b1yaO8ywV6HqzOo3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=VThQtfi6u0YeGA7dJ0ARBY34MIZ7BfQM5rYxotaDey8=;
 b=VTTeMhozxYQFm2BrTwMvGm4xA7gYDwHO4LU9vavgwe5xWuy6SueRxaNUQ3NzkieLXLODglxaQQ3jV
 Wscwnhw5w6s5uOaCD8nwuHVEmjeipVOBP2Za7AtrN45PYbTPt/goEdZL7QV51lyxDD0OX/u/brqJW2
 yypJRExLFcl6yjTt3S1l2GQW8EYPKX71nqtltAOj8rdNscUUFvpVKqHUIDWndktrPQZ+ilGbZwmzkF
 EK7rb+q3OBSBVxg+lsOWiEVvcycq7IzvkidD+Z1voymfqpBFHkBqVUPBfZS0GqWABTSFiQFbxEIlel
 GtWeVyh9EYZbnmD7xwxkBe/3ik4TddQ==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=Ugx9CyxQ; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=VThQtfi6u0YeGA7dJ0ARBY34MIZ7BfQM5rYxotaDey8=;
 b=Y1GjgH+H/DQzUT2VOvxmMARBeiFIfLDNOdNRuMJ8bzI1SF3ZOsZg0+XuJk5P4orhsr0qFrsRO3a91
 CdiCRg7Z4+goV7xZxmmPw2QOtWGkael020hJo7XbET5fNRQdkf609l6NE+Uf/K1/EcWjLf+i2mtSfS
 5eC3DT5lmIfByNQ8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=VThQtfi6u0YeGA7dJ0ARBY34MIZ7BfQM5rYxotaDey8=;
 b=k/rHXcnuzD3ifgTYQ3w7jcI296L/Rt0BF6NhldicfFj7s+3mWKdLwoyTjBzoxDoMvxGhQzHcyyHvH
 HxZhVgwn8fx1LZWjzyyS6LoY9AtoDh+IcGMFeF5/xnBpN3D11w5YcAKDeKr2blBW4cUrqZMENSLEBj
 9Lf8LIjzXhcosNJF4y+ZS3p+EUQ2ItaIxU+Z3IIoYW6pXo09De1u1IIONQEOQT1o4sPhfqwwfCeorm
 EtXfXFxgbbZ3L0YNFkmC5dZfwOd8eooSOdBL9lk1iDec2WDpd5BDL1BonYg2CwtfZcf3FyDlZML5Y3
 8hx/pcEi1JsImCaj+dkk34m80LxTYhQ==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: f4013d1e-4349-11ef-9bb3-25ccbfd3c7c9
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id f4013d1e-4349-11ef-9bb3-25ccbfd3c7c9;
 Tue, 16 Jul 2024 08:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VThQtfi6u0YeGA7dJ0ARBY34MIZ7BfQM5rYxotaDey8=; b=Ugx9CyxQUq4AijJUy7I8tEFrvL
 YIPyD4wucdellOtZKe8bh5pW0TcVdfIa9wZe+N2sAKLAJflxKFRUDkx8GhHkhMzXFsbDJtIDufQcJ
 PlGP7oiZr/b8PlaNtIfZiG8YlH5K4nAUOxRVzqLovQ+6gnoez2lYflIZPOMh9pB/L0xlhpgDYn2Hc
 +iiBuIpNxkKKgrBPeIzU6w5cydgB8gC10A/o0+o7WvBPfQU1oCOTO+NN+r4+Ln9ubPO92biSrFLvW
 3+As+GCkPsKFPk/x5mWWI3XDwdtz8VWx/ZSIDLCO/wmJaDciJQQM4Wo7AANH2wa1f9Qm0dgTPanvZ
 YRNr8bEw==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.97)
 (envelope-from <svens@stackframe.org>) id 1sTcjA-00000009NrN-2HnG;
 Tue, 16 Jul 2024 09:36:00 +0200
From: Sven Schnelle <svens@stackframe.org>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org,  qemu-stable@nongnu.org,  fam@euphon.net,
 pbonzini@redhat.com,  peter.maydell@linaro.org
Subject: Re: [PATCH] hw/scsi/lsi53c895a: bump instruction limit in scripts
 processing to fix regression
In-Reply-To: <20240715131403.223239-1-f.ebner@proxmox.com> (Fiona Ebner's
 message of "Mon, 15 Jul 2024 15:14:03 +0200")
References: <20240715131403.223239-1-f.ebner@proxmox.com>
Date: Tue, 16 Jul 2024 09:35:59 +0200
Message-ID: <87r0bteqlc.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.223.170; envelope-from=svens@stackframe.org;
 helo=snail.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fiona Ebner <f.ebner@proxmox.com> writes:

> Commit 9876359990 ("hw/scsi/lsi53c895a: add timer to scripts
> processing") reduced the maximum allowed instruction count by
> a factor of 100 all the way down to 100.
>
> This causes the "Check Point R81.20 Gaia" appliance [0] to fail to
> boot after fully finishing the installation via the appliance's web
> interface (there is already one reboot before that).
>
> With a limit of 150, the appliance still fails to boot, while with a
> limit of 200, it works. Bump to 500 to fix the regression and be on
> the safe side.
>
> Originally reported in the Proxmox community forum[1].
>
> [0]: https://support.checkpoint.com/results/download/124397
> [1]: https://forum.proxmox.com/threads/149772/post-683459
>
> Cc: qemu-stable@nongnu.org
> Fixes: 9876359990 ("hw/scsi/lsi53c895a: add timer to scripts processing")
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  hw/scsi/lsi53c895a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index eb9828dd5e..f1935e5328 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -188,7 +188,7 @@ static const char *names[] = {
>  #define LSI_TAG_VALID     (1 << 16)
>  
>  /* Maximum instructions to process. */
> -#define LSI_MAX_INSN    100
> +#define LSI_MAX_INSN    500
>  
>  typedef struct lsi_request {
>      SCSIRequest *req;

Fine with me - i just picked a random number assuming it
works. Obviously i was wrong :-)

Acked-by: Sven Schnelle <svens@stackframe.org>

