Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EDDCA0FF2
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Aug 2025 13:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usiNe-0004q2-96; Sun, 31 Aug 2025 09:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whitebox@nefkom.net>)
 id 1usiNa-0004or-24
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 09:45:58 -0400
Received: from mail-out.m-online.net ([212.18.0.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <whitebox@nefkom.net>)
 id 1usiNX-0001gT-I1
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 09:45:57 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4cFCvL1Tzdz1sFPP;
 Sun, 31 Aug 2025 15:45:50 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4cFCvL0XgQz1qqlS;
 Sun, 31 Aug 2025 15:45:50 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id 6xzpIGRs1cO2; Sun, 31 Aug 2025 15:45:39 +0200 (CEST)
X-Auth-Info: qQISpiNJ+8uBbF9Wlg+I5lnlTG1/IWh3/9USidXCK9LQvW39jDbuhdyOJ7DsAoHD
Received: from igel.home (aftr-82-135-83-140.dynamic.mnet-online.de
 [82.135.83.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Sun, 31 Aug 2025 15:45:39 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
 id 5274B2C19AF; Sun, 31 Aug 2025 15:45:38 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Luca Bonissi <qemu@bonslack.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Laurent Vivier
 <laurent@vivier.eu>,  qemu-devel@nongnu.org
Subject: Re: [PATCH 1/7] Add termios2 support to linux-user
In-Reply-To: <4bfb150f-7f5a-459b-808f-b0d1abc3b830@bonslack.org> (Luca
 Bonissi's message of "Sat, 30 Aug 2025 15:14:56 +0200")
References: <4bfb150f-7f5a-459b-808f-b0d1abc3b830@bonslack.org>
Date: Sun, 31 Aug 2025 15:45:38 +0200
Message-ID: <87y0qzzjst.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=212.18.0.10; envelope-from=whitebox@nefkom.net;
 helo=mail-out.m-online.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Aug 30 2025, Luca Bonissi wrote:

> @@ -5887,6 +5888,85 @@ static const StructEntry struct_termios_def = {
>      .print = print_termios,
>  };
>  
> +#ifdef TARGET_TCGETS2
> +static void target_to_host_termios2 (void *dst, const void *src)
> +{
> +    struct host_termios2 *host = dst;
> +    const struct target_termios2 *target = src;
> +
> +    host->c_iflag =
> +        target_to_host_bitmask(tswap32(target->c_iflag), iflag_tbl);
> +    host->c_oflag =
> +        target_to_host_bitmask(tswap32(target->c_oflag), oflag_tbl);
> +    host->c_cflag =
> +        target_to_host_bitmask(tswap32(target->c_cflag), cflag_tbl);
> +    host->c_lflag =
> +        target_to_host_bitmask(tswap32(target->c_lflag), lflag_tbl);
> +    host->c_line = target->c_line;
> +
> +    memset(host->c_cc, 0, sizeof(host->c_cc));
> +    host->c_cc[VINTR] = target->c_cc[TARGET_VINTR];
> +    host->c_cc[VQUIT] = target->c_cc[TARGET_VQUIT];
> +    host->c_cc[VERASE] = target->c_cc[TARGET_VERASE];
> +    host->c_cc[VKILL] = target->c_cc[TARGET_VKILL];
> +    host->c_cc[VEOF] = target->c_cc[TARGET_VEOF];
> +    host->c_cc[VTIME] = target->c_cc[TARGET_VTIME];
> +    host->c_cc[VMIN] = target->c_cc[TARGET_VMIN];
> +    host->c_cc[VSWTC] = target->c_cc[TARGET_VSWTC];
> +    host->c_cc[VSTART] = target->c_cc[TARGET_VSTART];
> +    host->c_cc[VSTOP] = target->c_cc[TARGET_VSTOP];
> +    host->c_cc[VSUSP] = target->c_cc[TARGET_VSUSP];
> +    host->c_cc[VEOL] = target->c_cc[TARGET_VEOL];
> +    host->c_cc[VREPRINT] = target->c_cc[TARGET_VREPRINT];
> +    host->c_cc[VDISCARD] = target->c_cc[TARGET_VDISCARD];
> +    host->c_cc[VWERASE] = target->c_cc[TARGET_VWERASE];
> +    host->c_cc[VLNEXT] = target->c_cc[TARGET_VLNEXT];
> +    host->c_cc[VEOL2] = target->c_cc[TARGET_VEOL2];
> +}
> +
> +static void host_to_target_termios2 (void *dst, const void *src)
> +{
> +    struct target_termios2 *target = dst;
> +    const struct host_termios2 *host = src;
> +
> +    target->c_iflag =
> +        tswap32(host_to_target_bitmask(host->c_iflag, iflag_tbl));
> +    target->c_oflag =
> +        tswap32(host_to_target_bitmask(host->c_oflag, oflag_tbl));
> +    target->c_cflag =
> +        tswap32(host_to_target_bitmask(host->c_cflag, cflag_tbl));
> +    target->c_lflag =
> +        tswap32(host_to_target_bitmask(host->c_lflag, lflag_tbl));
> +    target->c_line = host->c_line;
> +
> +    memset(target->c_cc, 0, sizeof(target->c_cc));
> +    target->c_cc[TARGET_VINTR] = host->c_cc[VINTR];
> +    target->c_cc[TARGET_VQUIT] = host->c_cc[VQUIT];
> +    target->c_cc[TARGET_VERASE] = host->c_cc[VERASE];
> +    target->c_cc[TARGET_VKILL] = host->c_cc[VKILL];
> +    target->c_cc[TARGET_VEOF] = host->c_cc[VEOF];
> +    target->c_cc[TARGET_VTIME] = host->c_cc[VTIME];
> +    target->c_cc[TARGET_VMIN] = host->c_cc[VMIN];
> +    target->c_cc[TARGET_VSWTC] = host->c_cc[VSWTC];
> +    target->c_cc[TARGET_VSTART] = host->c_cc[VSTART];
> +    target->c_cc[TARGET_VSTOP] = host->c_cc[VSTOP];
> +    target->c_cc[TARGET_VSUSP] = host->c_cc[VSUSP];
> +    target->c_cc[TARGET_VEOL] = host->c_cc[VEOL];
> +    target->c_cc[TARGET_VREPRINT] = host->c_cc[VREPRINT];
> +    target->c_cc[TARGET_VDISCARD] = host->c_cc[VDISCARD];
> +    target->c_cc[TARGET_VWERASE] = host->c_cc[VWERASE];
> +    target->c_cc[TARGET_VLNEXT] = host->c_cc[VLNEXT];
> +    target->c_cc[TARGET_VEOL2] = host->c_cc[VEOL2];
> +}

That fails to copy c_[io]speed.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

