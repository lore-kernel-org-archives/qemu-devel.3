Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94361C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 19:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpCUK-0002SI-QY; Tue, 26 Mar 2024 15:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rpCUE-0002Rl-1u
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 15:29:31 -0400
Received: from chocolate.pear.relay.mailchannels.net ([23.83.216.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rpCUB-00049p-GL
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 15:29:29 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 37E36100C2E
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 19:29:25 +0000 (UTC)
Received: from outbound3.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 53AC7102C7C
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 19:29:23 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1711481363; a=rsa-sha256;
 cv=pass;
 b=qgorXnoJH3JUOPjwOKwgxRFmPg+6A7+xqoNvx017MQUJZ5YQ57N22rc6hj9O/JJWp5a8Vt
 3l4mDuN4HHxY5tqLwVfrpRWIXAiqXMbsrvLNRL3B7gviWRyhoJ9lrVvTMKnGkEs0xv6KmX
 7Ek3QbT11wgQfetJEdq73L2gyUWLYwCblWn0uct9A0SYLdAFCRvwy8lTNCEXEeMdQ6ORe2
 FG6CuZPhsuGErZDXvovI/SdS8ngffCEd8vhawZ8ZweD91efSOW6lSRrDIf7vmDu4X+0zS5
 wfIKcQ0RjsDDdWiBAYKbCq7J/5k4w0wA4wfZqv2xRNY3JnIaqNm33uSQv4cx6Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1711481363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=DXLcv0gky//stTdq036V89c5HRd4m4ZGebixrEtKDQw=;
 b=rmVOYl9jf/qSfq0TGSWN/fW27KqkbgKddwCjvMqve0Aj1T8Htxye7D4t2psOoJDjfDaIbb
 tb1desksqKTvY7Fx7YFxJBCeaK923XF/Og+8Dux3XUAIyrMQ7K4cHKwQXqxxOwmO/wDda9
 vRahFkOqk9pUNj2aPbxvIq9ITiwSw00IyHZkrcNDJLAze6vJAWv3phezHQwSsClgNB+OuD
 ODKaWHHWxleygy+SGwkjkc3TzyUZ/KKIGbdMvzNKHBxO+eMQOOoMMVwFGg4QhS7sRL1mQC
 Q3TVdc60Xhy4ZND5XS9HG0VquIqV4Tynv3tPFtuKYEKHQCLAbmBBMNf0RUvkIQ==
ARC-Authentication-Results: i=2; rspamd-699949c56f-4gx9g;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Average-Suffer: 0f7186786668fe09_1711481363852_3910163047
X-MC-Loop-Signature: 1711481363852:752409531
X-MC-Ingress-Time: 1711481363852
Received: from outbound3.eu.mailhop.org (outbound3.eu.mailhop.org
 [52.29.21.168]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.112.72.244 (trex/6.9.2); Tue, 26 Mar 2024 19:29:23 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1711481325; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=VdUaB29pE7sv3SpDaxC/FzFk3Bn8zt1jYNb1N4aCG0Z5+J9LIv0se+MNT9hh+bq1RQYEw/mWED9Pu
 T8YnHpGHUqhK9zn2UmGkmcZrs6VLG/3AWlSc15RVBmZGePgwa+1GvtzoYHCRdi/rz9VkhMEhxuWU0z
 e60demq/VPJrtXi/A4BRftVIEmp7vahd9VdSKfi6FYM8bk36hxNcVIFQ++3bUfb+5fyCjgzQPfMhlk
 afLVtHtIxU/X2E4Cd3ciOqALSKVK8WE2iM86NHku3IMsXG/5IEoBASqL5DXXQg8IwGxo0LSki8sYrN
 UZRDcvSt3wpg850KR0/s8YZ7nwEKyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=DXLcv0gky//stTdq036V89c5HRd4m4ZGebixrEtKDQw=;
 b=c+Md5a4yz4PAxVQmaBEPAfKlod50RtnfJk3leX8ev7pzcNb3zoy8eGlI2ihvuZ5l6qx03XD7v2WO0
 xd/OiyH3yXeupWE104Ku5wVekHYy13yfCni/w7ZthdMAPh9BOmFdyBET8/HSnWl/5dWcwXAkSjT4tm
 yuvBCI6XKaJClTV9oTALD7zR5a9dlGX8ZbpVq1gJ+6B2nBTvpgk3YTgnSJr16114yilQYxuzcbOf33
 IkeE4EuhJEEJ08+r142U7d2XAP86UpJ2rWnOKKFucZD3eLdpavHxDOk/K9Q7Kf1l4T8IutBZyKajML
 3YiRprPEvNpLVBvZThHw6iFgVuIeUsg==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=aOGCsNXK; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=DXLcv0gky//stTdq036V89c5HRd4m4ZGebixrEtKDQw=;
 b=DreSEqCvO+RdoB5YDQV2YWo2c5FtwnCP49padVzXHp5iSLIrq50IS3ahUlOZepiJgNuhHH34vf0rS
 St4siw86hjEYCEfGDcJ5/y225LbG2WG5t5eq7ZICxHoD5GMhJ7Pq5IGZDRl3K9j8GiaZNmolH4ROEC
 SIH2Pzbha6G4Vxsg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=DXLcv0gky//stTdq036V89c5HRd4m4ZGebixrEtKDQw=;
 b=h08u9nYtTUhWI2j4cIoIIz/2LvOHUsizUWbBwzlN3ZtHr54wP+S2dQNsezSCfesI8p3Jvx8Gu03bC
 lL1h+EKLUj2sCKX7RtpSFzsj7JAiUreETToQa4yVRc+ozaYXcrLk3eMWBKUJ2ZB7O78MyjVuP4iN6b
 6529D7OpVSM1F7hyASFEaXtKigME66fR3wgDlWc3e3TmZ/vznGOrjOP7/Ppkbg+48SQQbEXRtdbjwl
 XQmpmEqv8hzQnh3X9G+Gywj8eJTOltX4ijdBoomRmtL06SC4IpXrjCSxHMU7LQX/q84etBvdyOvBnA
 i2EQxMmTynq85CQ9Hqzb8fShOKBjtng==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 0e0e28ec-eba7-11ee-b2b1-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 0e0e28ec-eba7-11ee-b2b1-eda7e384987e;
 Tue, 26 Mar 2024 19:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DXLcv0gky//stTdq036V89c5HRd4m4ZGebixrEtKDQw=; b=aOGCsNXKuyj9FQ3tznWYjGtX/J
 /e+OxKvDvE9EPr0DgotBfpvLaFYv0iU5/r9F73l3SFNOaRNS6+hu0UYZtpdNmvyC7slC0EQoCiWFW
 vB0LweJHNU0dRlHjAZldlhMu+eJminOkuklIZOb42P8OwEZ6EDFK/oz1d4FFZFkazafga2dp/ZHII
 6CllcjZNDkADz856tBL3LbKuPOqjw5V51tdDR34s+tYrJdCnknXlZ1HYaY6nhQJ1zEjyLbqy0Pro2
 RZrGBIBjqLeUzKqqT/JO+apYoQ46X01bq0i1q34mqDWqA8S2A5T6iQgv3Dcb8a4CwLFaHT6Gad6Lf
 3l06+vCA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rpCU2-005lj9-31;
 Tue, 26 Mar 2024 20:29:18 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH for-9.0] target/hppa: Clear psw_n for BE on
 use_nullify_skip path
In-Reply-To: <20240326183501.333914-1-richard.henderson@linaro.org> (Richard
 Henderson's message of "Tue, 26 Mar 2024 08:35:01 -1000")
References: <20240326183501.333914-1-richard.henderson@linaro.org>
Date: Tue, 26 Mar 2024 20:29:17 +0100
Message-ID: <87plvgeqr6.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.216.35; envelope-from=svens@stackframe.org;
 helo=chocolate.pear.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Along this path we have already skipped the insn to be
> nullified, so the subsequent insn should be executed.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Sven Schnelle <svens@stackframe.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/hppa/translate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 143818c2d9..8a1a8bc3aa 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -3948,6 +3948,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
>          copy_iaoq_entry(ctx, cpu_iaoq_b, -1, tmp);
>          tcg_gen_mov_i64(cpu_iasq_f, new_spc);
>          tcg_gen_mov_i64(cpu_iasq_b, cpu_iasq_f);
> +        nullify_set(ctx, 0);
>      } else {
>          copy_iaoq_entry(ctx, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
>          if (ctx->iaoq_b == -1) {

Tested-by: Sven Schnelle <svens@stackframe.org>

