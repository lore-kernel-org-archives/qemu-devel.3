Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4380C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRuwx-0007HD-0m; Thu, 11 Jul 2024 10:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sRuwu-00078q-PQ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 10:39:08 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sRuwr-00072c-VG
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 10:39:08 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BDD9521A64;
 Thu, 11 Jul 2024 14:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720708743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Mvha77vOnJBm17OKcXz1M0UnJJFBdVAz5EzpYco5Vs=;
 b=woZ/UYK4S+7Sd8RJRaZlE+QBNXnZFMfOoClLskdYLAG9DKVzQtYcKAx3zzXzVCb3W2FRc6
 VnLFRdY7018LsEHT50Xuw+W5jcicd0Pi8P7f9iRMxcKlBVAyYElCuFFLs92O9tb+UgeOJB
 wmU7iCcj12P/z68Nov4NwVvm5wo3+AE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720708743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Mvha77vOnJBm17OKcXz1M0UnJJFBdVAz5EzpYco5Vs=;
 b=BENc/kTjw6f1Emw6TA7ROh7z4BdiQowXOsDM+TUc5fiKSOPf5tYWEEK0N+lfH3RUnOzhjK
 CoK2pvxIOyuIwdAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="woZ/UYK4";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="BENc/kTj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720708743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Mvha77vOnJBm17OKcXz1M0UnJJFBdVAz5EzpYco5Vs=;
 b=woZ/UYK4S+7Sd8RJRaZlE+QBNXnZFMfOoClLskdYLAG9DKVzQtYcKAx3zzXzVCb3W2FRc6
 VnLFRdY7018LsEHT50Xuw+W5jcicd0Pi8P7f9iRMxcKlBVAyYElCuFFLs92O9tb+UgeOJB
 wmU7iCcj12P/z68Nov4NwVvm5wo3+AE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720708743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Mvha77vOnJBm17OKcXz1M0UnJJFBdVAz5EzpYco5Vs=;
 b=BENc/kTjw6f1Emw6TA7ROh7z4BdiQowXOsDM+TUc5fiKSOPf5tYWEEK0N+lfH3RUnOzhjK
 CoK2pvxIOyuIwdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 466DD136AF;
 Thu, 11 Jul 2024 14:39:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RX1TA4fuj2ZaFAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 11 Jul 2024 14:39:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH 0/8] Convert avocado tests to normal Python unittests
In-Reply-To: <20240711115546.40859-1-thuth@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
Date: Thu, 11 Jul 2024 11:39:00 -0300
Message-ID: <87jzhsdmd7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-5.26 / 50.00]; BAYES_HAM(-2.75)[98.92%];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BDD9521A64
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> The Avocado v88 that we use in QEMU is already on a life support
> system: It is not supported by upstream anymore, and with the latest
> versions of Python, it won't work anymore since it depends on the
> "imp" module that has been removed in Python 3.12.
>
> There have been several attempts to update the test suite in QEMU
> to a newer version of Avocado, but so far no attempt has successfully
> been merged yet.
>
> Additionally, the whole "make check" test suite in QEMU is using the
> meson test runner nowadays, so running the python-based tests via the
> Avocodo test runner looks and feels quite like an oddball, requiring
> the users to deal with the knowledge of multiple test runners in
> parallel.
>
> So instead of trying to update the python-based test suite in QEMU
> to a newer version of Avocado, we should maybe try to better integrate
> it with the meson test runner instead. Indeed most tests work quite
> nicely without the Avocado framework already, as you can see with
> this patch series - it does not convert all tests, just a subset since
> it is just an RFC so far, but as you can see, many tests only need
> small modifications to work without Avocado.
>
> If you want to try it: Apply the patches, make sure that you have the
> "pytest" program installed, then recompile and then run:
>
>  make check-pytest
>
> Things that need further attention though:
>
> - All tests that use the LinuxTest / LinuxDistro classes (e.g. based
>   on cloud-init images) really depend on the Avocado framework,
>   thus we'd need a solution for those if we want to continue with
>   this approach
>
> - Same for all tests that require the LinuxSSHMixIn class - we'd
>   need to provide a solution for ssh-based tests, too.

These two seem to be dependent mostly avocado/utils only. Those could
still be used without the whole framework, no? Say we keep importing
avocado.utils, but run everything from meson, would that make sense?


