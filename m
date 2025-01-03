Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4EEE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 12:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTgpy-0006Ku-2W; Fri, 03 Jan 2025 07:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTgpt-0006H4-UX
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 07:31:30 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tTgpr-0006Js-3W
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 07:31:29 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B260B1F38E;
 Fri,  3 Jan 2025 12:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735907483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D+8SdstKKkj0A6jc0kTccmb4KGF4pOgVmqBvX5cvqrI=;
 b=ROzBBjNSILFo2Pu33newsp+qn2Bac00rW2bBZJ4uNIAfMtSo2dk+HAUU/L67eozbce4cbZ
 8FLUaWFUfPFAf2u0MVe8+3oXR5pTjyMHG8F4LoImjAef3cdt7WyJSQWOBNQ5a3Lac/QkWd
 5DJCTKBWAlTXr0NdoiHVzQjUVSyMzfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735907483;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D+8SdstKKkj0A6jc0kTccmb4KGF4pOgVmqBvX5cvqrI=;
 b=Dcs6ZguomaJTSkNC99B9rB3QzyUO1hIKo2WmnPLqipMUZdPp4iXdvla5Vkd9pyBcUNZvNe
 jFU1O/S2c5QtUTCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ROzBBjNS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Dcs6Zguo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1735907483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D+8SdstKKkj0A6jc0kTccmb4KGF4pOgVmqBvX5cvqrI=;
 b=ROzBBjNSILFo2Pu33newsp+qn2Bac00rW2bBZJ4uNIAfMtSo2dk+HAUU/L67eozbce4cbZ
 8FLUaWFUfPFAf2u0MVe8+3oXR5pTjyMHG8F4LoImjAef3cdt7WyJSQWOBNQ5a3Lac/QkWd
 5DJCTKBWAlTXr0NdoiHVzQjUVSyMzfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1735907483;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D+8SdstKKkj0A6jc0kTccmb4KGF4pOgVmqBvX5cvqrI=;
 b=Dcs6ZguomaJTSkNC99B9rB3QzyUO1hIKo2WmnPLqipMUZdPp4iXdvla5Vkd9pyBcUNZvNe
 jFU1O/S2c5QtUTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 381B4134E4;
 Fri,  3 Jan 2025 12:31:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A5ZaO5rYd2fvPQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 03 Jan 2025 12:31:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3] tests/functional: Convert the migration avocado test
In-Reply-To: <20250103074308.463860-1-thuth@redhat.com>
References: <20250103074308.463860-1-thuth@redhat.com>
Date: Fri, 03 Jan 2025 09:29:09 -0300
Message-ID: <87jzbc84iy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: B260B1F38E
X-Spamd-Result: default: False [-4.38 / 50.00]; BAYES_HAM(-2.87)[99.46%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Thomas Huth <thuth@redhat.com> writes:

> Now that we've got a find_free_port() function in the functional
> test framework, we can convert the migration test, too.
> While the original avocado test was only meant to run on aarch64,
> ppc64 and x86, we can turn this into a more generic test by now
> and run it on all architectures that have a machine which ships
> with a working firmware. To avoid overlapping with the migration
> qtest, we now also test migration on machines that are not covered
> by the migration qtest yet.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Fabiano Rosas <farosas@suse.de>

