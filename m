Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A737EC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 18:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0lbb-00085h-1B; Fri, 04 Apr 2025 14:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u0lbW-00085J-1R
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:17:22 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u0lbU-0007MD-AM
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 14:17:21 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A35A11F385;
 Fri,  4 Apr 2025 18:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743790632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5CMMvNKAqHdB0HX75jYBvOQ6zMh62sXmnq8VG/m1ae4=;
 b=1ArN7AcibmIlLe+5FRTvgPpO9CgyWxPPEIBpuAykcqumQ24XfA7z77Yy6KKsGYYuyfnWFu
 pXavrxf/CFK92b3RnuZMnJoJENfwPjPXCClLz/JOFr7IKHVL35IZFFuD6MxXRlsTkcoe+N
 RfK0wc0assyD3S8cnXuXcF3cJPtdTOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743790632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5CMMvNKAqHdB0HX75jYBvOQ6zMh62sXmnq8VG/m1ae4=;
 b=PXJYc8fAYdgspC0fKflinQ57ZHx2wU9z/fv3oWP/7bg4EZec/i6ckkP4Ebz781S4I2v8aE
 hPBS2XNLjT5/iIAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1ArN7Aci;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PXJYc8fA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743790632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5CMMvNKAqHdB0HX75jYBvOQ6zMh62sXmnq8VG/m1ae4=;
 b=1ArN7AcibmIlLe+5FRTvgPpO9CgyWxPPEIBpuAykcqumQ24XfA7z77Yy6KKsGYYuyfnWFu
 pXavrxf/CFK92b3RnuZMnJoJENfwPjPXCClLz/JOFr7IKHVL35IZFFuD6MxXRlsTkcoe+N
 RfK0wc0assyD3S8cnXuXcF3cJPtdTOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743790632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5CMMvNKAqHdB0HX75jYBvOQ6zMh62sXmnq8VG/m1ae4=;
 b=PXJYc8fAYdgspC0fKflinQ57ZHx2wU9z/fv3oWP/7bg4EZec/i6ckkP4Ebz781S4I2v8aE
 hPBS2XNLjT5/iIAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 182A51364F;
 Fri,  4 Apr 2025 18:17:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mwFaMici8GcXLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 04 Apr 2025 18:17:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: corey@minyard.net, qemu-devel@nongnu.org
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] hw/ipmi: Move vmsd registration to device class
In-Reply-To: <Z_AAPdpBWQjXq6fJ@mail.minyard.net>
References: <Z_AAPdpBWQjXq6fJ@mail.minyard.net>
Date: Fri, 04 Apr 2025 15:17:09 -0300
Message-ID: <87v7rjkd0a.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: A35A11F385
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.43 / 50.00]; BAYES_HAM(-2.92)[99.67%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Corey Minyard <corey@minyard.net> writes:

> It's the right way to do it now, and it handles multiple instances
> properly.  I need multiple instances for some testing I'm doing so this
> is the right thing to do.
>
> Tested by doing:
>
>    (qemu) migrate -d exec:cat>filen.mig
>
> before and after the fix, then:
>
>    scripts/analyze-migration.py -d desc -f file1.mig >file1.json
>    scripts/analyze-migration.py -d desc -f file2.mig >file2.json
>    diff file1.json file2.json
>
> with no differences.
>
> Signed-off-by: Corey Minyard <corey@minyard.net>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

