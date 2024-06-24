Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D22BC3064D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 15:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLlFv-0006Mp-Nm; Mon, 24 Jun 2024 11:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sLlFu-0006MU-MR
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 11:05:18 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sLlFs-00049Y-1U
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 11:05:18 -0400
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:10:168:4:11])
 by smtp-out1.suse.de (Postfix) with ESMTP id 63BC621A62;
 Mon, 24 Jun 2024 15:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719241514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y/opaRpqQvduDGTVmVdtXAMCcqyFx1G2cSr/45vby4c=;
 b=hlM8oE06u4Cv16DwKHy9ZHF0KWj9C0m2wH55votJlHlzHj8iAj/ejkrDGnZScvi1zLU4yU
 MHgPltThEGOfjBCAtYhpCl4iRTOoxz6XsgluKLf7WY9AwBkQgTPHMTtk+WTUL22ZnN7xI1
 Umm/byLgl/TAA0TyX6IqQEvFFgwGTeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719241514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y/opaRpqQvduDGTVmVdtXAMCcqyFx1G2cSr/45vby4c=;
 b=9GOG4J1A0h6GhmQuRYQaKx4Qy3Som8fCaGcNcvA0aQQMV2zxV+Nz10gnFRWm+eoGEoUv8a
 AOAT/lLh8slxGJAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hlM8oE06;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9GOG4J1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719241514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y/opaRpqQvduDGTVmVdtXAMCcqyFx1G2cSr/45vby4c=;
 b=hlM8oE06u4Cv16DwKHy9ZHF0KWj9C0m2wH55votJlHlzHj8iAj/ejkrDGnZScvi1zLU4yU
 MHgPltThEGOfjBCAtYhpCl4iRTOoxz6XsgluKLf7WY9AwBkQgTPHMTtk+WTUL22ZnN7xI1
 Umm/byLgl/TAA0TyX6IqQEvFFgwGTeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719241514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y/opaRpqQvduDGTVmVdtXAMCcqyFx1G2cSr/45vby4c=;
 b=9GOG4J1A0h6GhmQuRYQaKx4Qy3Som8fCaGcNcvA0aQQMV2zxV+Nz10gnFRWm+eoGEoUv8a
 AOAT/lLh8slxGJAw==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 4934F4A03D4; Mon, 24 Jun 2024 17:05:14 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: linux-user crash in python test
In-Reply-To: <CAFEAcA_ntKQpvtrzYubvsWKy+e3R==ZfUB=TeqDc7rnbT7oiww@mail.gmail.com>
 (Peter Maydell's message of "Mon, 24 Jun 2024 15:26:44 +0100")
References: <mvmjziepgn8.fsf@suse.de>
 <CAFEAcA_ntKQpvtrzYubvsWKy+e3R==ZfUB=TeqDc7rnbT7oiww@mail.gmail.com>
X-Yow: But was he mature enough last night at the lesbian masquerade?
Date: Mon, 24 Jun 2024 17:05:14 +0200
Message-ID: <mvmfrt2pej9.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.39 / 50.00]; BAYES_HAM(-2.99)[99.96%];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; ONCE_RECEIVED(1.20)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 RDNS_NONE(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.969]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; MX_GOOD(-0.01)[];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)];
 FROM_EQ_ENVFROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_ONE(0.00)[1]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Spamd-Bar: /
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 63BC621A62
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=schwab@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Jun 24 2024, Peter Maydell wrote:

> Just to check, does the python you're running this on
> have the change from
> https://github.com/python/cpython/pull/110659

Yes, this is python 3.11.9.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

