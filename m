Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E77D3C52B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 17:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1UmG-0002Iq-2T; Thu, 17 Oct 2024 13:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1UmE-0002Hr-5g
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 13:59:10 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1UmB-0004Rm-Tu
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 13:59:09 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A112B1F82E;
 Thu, 17 Oct 2024 17:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729187943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/NPx3XdN5c6he8x44N2WGZgMJTEJ2TnREbCGdhPt2wQ=;
 b=y1yPsTxDkK6URisbCAbiHSL+6P5JBVttYrajA79rXOukDzEmU15IAZZQl8yF8BroV47RVl
 u0b9Wr1/y1nbf9XMACcbRVDb4UxVLdpq1XUKz3UZqd0G84xMHmNuNoIFBk/3Oaj5YRM4uu
 JcFHWL+z/0qlKMrjhYr5zOTTl969qUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729187943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/NPx3XdN5c6he8x44N2WGZgMJTEJ2TnREbCGdhPt2wQ=;
 b=+bJdH9ojpfZ26samGwhaJVeDSGX2eN8ba7bSSlkrOpD1nVm9MuLq1ICrBpBsztN2KaqY6a
 TUnG5wG5hpqJVDCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729187943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/NPx3XdN5c6he8x44N2WGZgMJTEJ2TnREbCGdhPt2wQ=;
 b=y1yPsTxDkK6URisbCAbiHSL+6P5JBVttYrajA79rXOukDzEmU15IAZZQl8yF8BroV47RVl
 u0b9Wr1/y1nbf9XMACcbRVDb4UxVLdpq1XUKz3UZqd0G84xMHmNuNoIFBk/3Oaj5YRM4uu
 JcFHWL+z/0qlKMrjhYr5zOTTl969qUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729187943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/NPx3XdN5c6he8x44N2WGZgMJTEJ2TnREbCGdhPt2wQ=;
 b=+bJdH9ojpfZ26samGwhaJVeDSGX2eN8ba7bSSlkrOpD1nVm9MuLq1ICrBpBsztN2KaqY6a
 TUnG5wG5hpqJVDCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29E5613A53;
 Thu, 17 Oct 2024 17:59:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U0NgOGZQEWceYwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 17 Oct 2024 17:59:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: yong.huang@smartx.com, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 yong.huang@smartx.com
Subject: Re: [PATCH v4 1/6] accel/tcg/icount-common: Remove the reference to
 the unused header file
In-Reply-To: <5e33b423d0b8506e5cb33fff42b50aa301b7731b.1729146786.git.yong.huang@smartx.com>
References: <cover.1729146786.git.yong.huang@smartx.com>
 <5e33b423d0b8506e5cb33fff42b50aa301b7731b.1729146786.git.yong.huang@smartx.com>
Date: Thu, 17 Oct 2024 14:59:00 -0300
Message-ID: <87o73i3923.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.24 / 50.00]; BAYES_HAM(-2.94)[99.75%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

yong.huang@smartx.com writes:

> From: Hyman Huang <yong.huang@smartx.com>
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  accel/tcg/icount-common.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
> index 8d3d3a7e9d..30bf8500dc 100644
> --- a/accel/tcg/icount-common.c
> +++ b/accel/tcg/icount-common.c
> @@ -36,7 +36,6 @@
>  #include "sysemu/runstate.h"
>  #include "hw/core/cpu.h"
>  #include "sysemu/cpu-timers.h"
> -#include "sysemu/cpu-throttle.h"
>  #include "sysemu/cpu-timers-internal.h"
>  
>  /*

Reviewed-by: Fabiano Rosas <farosas@suse.de>

