Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE79C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 12:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgkW9-0007L1-OI; Sun, 03 Mar 2024 07:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rgkW1-0007KO-17
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 07:00:25 -0500
Received: from cockroach.apple.relay.mailchannels.net ([23.83.208.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rgkVv-0002mH-BN
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 07:00:24 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 633306C1EF5
 for <qemu-devel@nongnu.org>; Sun,  3 Mar 2024 12:00:16 +0000 (UTC)
Received: from outbound5a.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 63D526C15E7
 for <qemu-devel@nongnu.org>; Sun,  3 Mar 2024 12:00:15 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709467215; a=rsa-sha256;
 cv=pass;
 b=N3u84j3cBJwrA9zNkxWZQic32J40NeLtRItaB2Hm7mrDX3rnr8QDon4W3hiTRsYUqlSihf
 QkZSsbPCBXUxel23oWlPJHRkr9mPaFeIlmdIP6C62qLtIWgfOigLPx01oea8ATyJbwCq2y
 qj+/w97vF9GjGPuBHBo8S4gX/YsL2NAHix4or1DsRVDzuDza3Pt6arE7cXGQwYC+FW3N6f
 VDx3MSvw0fhhiJ6WsEIbONKs51S1TelxfDITE04OXTq2Akv1Xsign18+tbUz/NfDdzWRNS
 1FFK+Di7tS9UqVLvOvIiBuQlt1J2SAmkuGFcRN7D6WDMCswOYW+uLuo7SCUDrA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709467215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=WnLQSrbCpGtZDLpT73zBJnIVZj1NRPvpp+od93fF2UA=;
 b=tpTDAQGCEgp3w6PWoC7lhF1Mh6L6BpggdjnbElzflTB+sK8ocRu64tRiJgAK5WX46mmUyA
 X6AxvQ+PhaCIC/xGjGNJ+2tZ3RoycvTiohrw6GrfjlXUvLG5k9bB0GbXjyzu5vn/sFQZiD
 qURyNztojPaa/GVF1p9y11Q96AX9HmPgLywXOEJTjvF5SgWSEui2OK+WiWAyRNwsEWU8YL
 wLlBlUQYRRlIw52194q5QCGCbLxfapbvV6kIyQZzmgnRr5Dg5jyIa1Qxb7qUz78HV0FBXw
 +VTOkgy3fkcHMrrWd/oGUaJsGrPoCqoaOD4+uTgRi2o+M0ADnKk6W1UHXRAocw==
ARC-Authentication-Results: i=2; rspamd-7f9dd9fb96-8gmrz;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Snatch-Daffy: 7fad69ce787bb7ff_1709467215923_525168571
X-MC-Loop-Signature: 1709467215923:3627479265
X-MC-Ingress-Time: 1709467215922
Received: from outbound5a.eu.mailhop.org (outbound5a.eu.mailhop.org
 [3.124.88.253]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.106.138.70 (trex/6.9.2); Sun, 03 Mar 2024 12:00:15 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709467183; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=clhQ//2kngjSDv6vbZtlFFv/to1Ke+Hr0f9XEvIGYdNeF2q7IRGJRzXiL/N/JaDrtvTZwfVBleEwO
 cfuVrx/PW5vKiBsd338h8xqT93hDNNlamghRxOGpgPAGJA5y7gaLmIm//ubygXma5Sqn6aee/iRZft
 UIDd2N6WsO+6eK8Cighct+jp+J4U84sgkGqlU64h69j6sOO1D3M/5f+JI9oRPFMTqoqRRGYBNQQf/M
 sMdNCbYL2aGt0ctirFcboUN5MiduzUCNT8rqG7tlE8Kr5PDS71GWVBeRcv4hJSU11wKFb7Qh6WaTbO
 kkv93Thz3BK0vcghfrtTxJvV/SSDmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=WnLQSrbCpGtZDLpT73zBJnIVZj1NRPvpp+od93fF2UA=;
 b=QaIdO/TMGKSqb2Q+/8ia9Ds5LB+y23dLPQ0KkYoSEJRQZ9YVzSaRVcViyH1zX5xpWPtADP7BYH5QH
 AAXzD70ngniChLmMxN/SyvHELYcZbD1csMuUOHrPBDQE8iCNwuquADO5ozrJnA9n+kWrJv3HSTaGoE
 TQlmUttyjcRm1qpwnnKbbcOYCs56REMxeAKSoxg89V7y5SYoVAECMFSYJnymOCUyCVzXvozvDoX60r
 oVjG1Lb/mf8n2StgJHcnDDYWDZo0aaGw1s6m0/KOmjUWhJT+Ka8jn3GWlh9E3uVCnNCSu/jM3rf65X
 K20euxJtb4NzWw5skUik692kzEqMsig==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=NYfpdHCi; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=WnLQSrbCpGtZDLpT73zBJnIVZj1NRPvpp+od93fF2UA=;
 b=G83RkiUYbNgEKgxzQbm5E1A2cIknuLu4IEujEtaTBV2/637hq4EKwQZUBjwGoHE6L9DJrcXKdjald
 r7GegCSt0XIw65pV3IzYZOy/wPNU2EFoJpLbqhiROaSDGuFfZRH3wyOdGRXRCh6G3bYAiGabYCDaNA
 FwwDYvzzUF/I6jLY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=WnLQSrbCpGtZDLpT73zBJnIVZj1NRPvpp+od93fF2UA=;
 b=jrre/IyLosFmKVkdIUjIKF6fpn0t2CTaAYniVSr4tCQpHNZoXaw120aPXmoeFEr9o14nUN+5tXkib
 DrGUeT1tcClmZcVisgQ74roG1Xa4CgiiCjQR3Xe9vgXS6IOCusWVJ31Q6s9Vb6LGhGxxKVTssRWEaF
 heKdrNTPGQARtmsbpAE633hNgSp1GAtqoNM5TJNp/1GNQvYsT6u78FAJ/IwoxTwNwH6w0OC2MVfe8j
 kJKtQfTM0loC+i5NugF0bdrsgnXLfqV4cDSGsyMNUTg6rFLZB1D8KGULq0QFxAuSHewaNe8Ia2uQHT
 jh2SsvjaomTiMR58qNjnGBNTii4+PNg==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 81b2727c-d955-11ee-afff-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 81b2727c-d955-11ee-afff-eda7e384987e;
 Sun, 03 Mar 2024 11:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WnLQSrbCpGtZDLpT73zBJnIVZj1NRPvpp+od93fF2UA=; b=NYfpdHCiijLhHrvzVQ1xYtBRzP
 y5om5rBAhNcxz59whPU8tVFZm/eUKCN8oNMbHaQIOPGue0MvUMQtosrBIt8vY8HGB8tg2PxqFutr6
 iyJZPRdM47ogjcSSO5Fz+ypJi5oe4HRgTBJGxL8daAmKwxmGtvTLD1CD08W6f0Ro0L07D9x/9gRCJ
 g19CiP49OqYafb1Tp3elYl/JuuksxZfyLZ4nqH+IU5hMmyC+HB6pCQsMwbD5ytkrDaNNyE6r8szlP
 MS00l9jea3dc0nOU6hVgvoZA4C4lzdOh573c0SAxQl+XFF9NsZCpgipfPtcL56Ci+u7QS8AXO/RE0
 zCn6TaZg==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rgkVd-000vdT-2U;
 Sun, 03 Mar 2024 13:00:01 +0100
From: Sven Schnelle <svens@stackframe.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Fam Zheng
 <fam@euphon.net>
Subject: Re: lsi53c895a assert with AmigaOS
In-Reply-To: <20a8b781-fd08-4e2c-9916-8483b1e4a6c2@eik.bme.hu> (BALATON
 Zoltan's message of "Sat, 2 Mar 2024 23:58:17 +0100 (CET)")
References: <20a8b781-fd08-4e2c-9916-8483b1e4a6c2@eik.bme.hu>
Date: Sun, 03 Mar 2024 13:00:01 +0100
Message-ID: <87y1azv83i.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.208.37; envelope-from=svens@stackframe.org;
 helo=cockroach.apple.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> Hello,
>
> AmigaOS4 also has a driver for this card so I've tried to test it but
> it trips an assert. Does anybody have an idea why and how it could be
> fixed? Sven's recent patches don't seem to have an effect on this, it
> still happens shortly after it tries to access the SCSI device with
> those patches applied. (Unfortunately AmigaOS is not freely available
> so it's a bit hard to reproduce but I can do tests if needed.) I got
> the following traces:
>
> lsi_reg_write Write reg SIEN0 0x40 = 0x84
> lsi_reg_write Write reg SIEN1 0x41 = 0x04
> lsi_reg_write Write reg DIEN 0x39 = 0xff
> lsi_reg_write Write reg DSP0 0x2c = 0x00
> lsi_reg_write Write reg DSP1 0x2d = 0x80
> lsi_reg_write Write reg DSP2 0x2e = 0x19
> lsi_reg_write Write reg DSP3 0x2f = 0x00
> lsi_execute_script SCRIPTS dsp=0x198000 opcode 0x7c07fe00 arg 0x0
> lsi_execute_script_io_opcode Read-Modify-Write reg 0x7 AND data8=0xfe sfbr=0x01
> lsi_reg_read Read reg GPREG 0x7 = 0x7f
> lsi_reg_write Write reg GPREG 0x7 = 0x7e
> lsi_execute_script SCRIPTS dsp=0x198008 opcode 0x60000200 arg 0x0
> lsi_execute_script_io_clear Clear TM
> lsi_execute_script SCRIPTS dsp=0x198010 opcode 0x40000000 arg 0x198208
> lsi_execute_script_io_alreadyreselected Already reselected, jumping to
> alternative address
here ---^
> lsi_do_msgout_select Select LUN 0
> lsi_execute_script SCRIPTS dsp=0x198070 opcode 0x820b0000 arg 0x1981f8
> lsi_execute_script_tc_compp Compare phase CMD == CMD
> lsi_execute_script_tc_jump Jump to 0x1981f8
> lsi_execute_script SCRIPTS dsp=0x1981f8 opcode 0xa000006 arg 0x199000
> lsi_do_command Send command len=6
> qemu-system-ppc: ../hw/scsi/lsi53c895a.c:863: lsi_do_command: Assertion `s->current == NULL' failed.
>
> Any idea what could it be and what could be done about it?

Wild guess is that this is because of the 'Already reselected' line
above. lsi_reselect() sets s->current, and later when lsi_do_command()
is called it gets confused because s->current is already set. But i
would need the whole logfile to see why this is going wrong, or even
better AmigaOS (which is not free as you already mentioned)

Sven

