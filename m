Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30563D65543
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 18:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tG05J-0002lL-Bx; Tue, 26 Nov 2024 13:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tG05D-0002kh-SG
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 13:14:44 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tG05C-0000Ru-7A
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 13:14:43 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 866501F74D;
 Tue, 26 Nov 2024 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732644877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N42LN8S8RvGxpMikneG48ZcGSuNu5S9F2MxkVAFJ0Ho=;
 b=Az1QgkjZlHPnhBSdmH0gJmDsnmosx17c3EDysrs5FpB6QQeG0gOgozbuLiURGaAcpMbAYA
 3PzLnnD+dRwe1fOrtPuKfscpgU8Btd+nZO7kB16Fk0b63Hi/ZXf/4Pvyc/w9jX7apQc8yj
 RBhFYds7Ql24gYcqamgOlGyZZwGKH4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732644877;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N42LN8S8RvGxpMikneG48ZcGSuNu5S9F2MxkVAFJ0Ho=;
 b=2W/ShMWaRrBwy5OnETmhn9xhNcdpecJfw1PKHYs8ZfJEwb9162cMqy3QkKF3JlV8tZMalr
 gTAHLz/O0zZk+1Bg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Az1QgkjZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="2W/ShMWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732644877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N42LN8S8RvGxpMikneG48ZcGSuNu5S9F2MxkVAFJ0Ho=;
 b=Az1QgkjZlHPnhBSdmH0gJmDsnmosx17c3EDysrs5FpB6QQeG0gOgozbuLiURGaAcpMbAYA
 3PzLnnD+dRwe1fOrtPuKfscpgU8Btd+nZO7kB16Fk0b63Hi/ZXf/4Pvyc/w9jX7apQc8yj
 RBhFYds7Ql24gYcqamgOlGyZZwGKH4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732644877;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N42LN8S8RvGxpMikneG48ZcGSuNu5S9F2MxkVAFJ0Ho=;
 b=2W/ShMWaRrBwy5OnETmhn9xhNcdpecJfw1PKHYs8ZfJEwb9162cMqy3QkKF3JlV8tZMalr
 gTAHLz/O0zZk+1Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AF2E139AA;
 Tue, 26 Nov 2024 18:14:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id w0OBMAwQRmezQwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 26 Nov 2024 18:14:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, Dmitry Frolov
 <frolov@swemel.ru>, lvivier@redhat.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qtest: add TIMEOUT_MULTIPLIER
In-Reply-To: <8da5c689-3116-42c1-b215-fbb50f35f49c@linaro.org>
References: <20241113094342.282676-2-frolov@swemel.ru>
 <87bjyij0q2.fsf@suse.de> <8da5c689-3116-42c1-b215-fbb50f35f49c@linaro.org>
Date: Tue, 26 Nov 2024 15:14:34 -0300
Message-ID: <87v7w9n9px.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 866501F74D
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; MID_RHS_MATCH_FROM(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 11/13/24 13:13, Fabiano Rosas wrote:
>> Dmitry Frolov <frolov@swemel.ru> writes:
>> 
>>> Some tests need more time when qemu is built with
>>> "--enable-asan --enable-ubsan"
>>>
>>> As was discussed here:
>>> https://patchew.org/QEMU/20241112120100.176492-2-frolov@swemel.ru/
>>>
>>> TIMEOUT_MULTIPLIER enviroment variable will be
>>> a useful option, allowing non-invasive timeouts
>>> increasing for a specific build.
>>>
>>> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
>> 
>> Tested-by: Fabiano Rosas <farosas@suse.de>
>> 
>> and queued for qtest.
>> 
>
> Hi Fabiano,
>
> will a PR be sent for 9.2 release, or later?

I queued this for 10.0, it doesn't actually fix anything (only allows
testing to proceed when the variable is set in the cmdline), so it's too
late for 9.2.

