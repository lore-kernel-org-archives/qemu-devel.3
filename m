Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E772CC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 15:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdAI9-0003VK-8t; Thu, 22 Feb 2024 09:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rd6Z3-0006tB-DZ
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 05:44:31 -0500
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rd6Z1-0006WY-HJ
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 05:44:29 -0500
Date: Thu, 22 Feb 2024 11:44:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1708598654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjbDWuFJ81UXR1RyBPAkcnHfofF5Icts5BWudkMNPHg=;
 b=3CEhM6byRrFLUlK12QuTbT2nLQTOwnsrdr4vjnmndyqg1hlj7rrNh5V0SbHiYu9pcBRzmu
 HBy3/3Q0IfG3vDToSIiTcGsray78LYPltZ8gcLZabdFSDgCvdbAfKrCBH+AkWgtBmWakyK
 4QUZ5I3bUoMElgFTbVb/hFOwbwgXM2ndyzg9o14asYzkvZp4WXu9YSD9oLNlTvJnHUIe49
 8meCOaV4qPlTfWLbumqL1fNpt8ZDzfwMcIJQHg809fQMRT3YUE4wdvN/D9+n4kGMjFQ6Pu
 iot2qhTXuicmuSWfa5vSaP7YSVgZCmSM25DMOYcJ3twmuVybf6U5u8x14bBLNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1708598654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gjbDWuFJ81UXR1RyBPAkcnHfofF5Icts5BWudkMNPHg=;
 b=2gd2GdmCXlvUFh2h8l/f0NEV8vEYLcjM/IJhnCh/b4jEroVFhrfFkiGA2Xz77qpaJjtVNT
 EgnnvkYYfMbGZ+CA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Nicholas Ngai <nicholas@ngai.me>
Cc: qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@gnu.org>, 
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] net/slirp: Use newer slirp_*_hostxfwd API
Message-ID: <20240222111726-198aca86-5ac7-4177-a7d7-3aeb1808add1@linutronix.de>
References: <20210925214820.18078-1-nicholas@ngai.me>
 <8143f015-056c-6362-2d3e-7fed66aaffe7@ngai.me>
 <20211005235613.kuwbfixvp74sv5en@begin>
 <807f262d-bc28-865f-dda5-2e503f5ebf31@ngai.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <807f262d-bc28-865f-dda5-2e503f5ebf31@ngai.me>
Received-SPF: pass client-ip=2a0a:51c0:0:12e:550::1;
 envelope-from=t-8ch@linutronix.de; helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 22 Feb 2024 09:43:15 -0500
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

Hi Nicholas,

On Tue, Mar 22, 2022 at 06:58:36PM -0700, Nicholas Ngai wrote:
> Pinging this. It’s a bit old, though the patch still applies cleanly to
> master as far as I can tell.
> 
> Link to patchew is
> https://patchew.org/QEMU/20210925214820.18078-1-nicholas@ngai.me/.
> 
> I’d love to get https://gitlab.com/qemu-project/qemu/-/issues/347 addressed
> once libslirp makes a release with added Unix-to-TCP support in the hostxfwd
> API, but this patch is a requirement for that first.

I'm also interested in this PATCH and a resolution to issue 347.

FYI your patch triggers checkpatch warnings, see [0].
Maybe you can resend the patch with the review tags and the checkpatch
warnings cleaned up.

Also it would be useful to know how the patch changes the version
requirements of the libslirp dependency.
(The version requirement should also be enforced in meson.build)
Also the commit in subprojects/slirp.wrap should be high enough,
which seems to already be the case however.

It seems it requires libslirp 4.6.0 from 2021-06-14, which is only
available from Debian 12 or Ubuntu 22.04 and no release of RHEL.


Thomas

[0] https://patchew.org/QEMU/20210925214820.18078-1-nicholas@ngai.me/logs/testing.checkpatch/

