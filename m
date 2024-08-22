Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0620BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 12:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh7B4-0007EZ-AS; Thu, 22 Aug 2024 08:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sh7B2-00076U-FV
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 08:44:32 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sh7B0-0008Ea-Q5
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 08:44:32 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1528B201C9;
 Thu, 22 Aug 2024 12:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724330668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y6a9d8EfCCB8orXMpXL4YMdgYxlxcodnM1APqHacEo4=;
 b=01LHTwgzOFuKvq4jL8KU8OaXfsm4FtH3xtlNalE1iAskzL4Qy0041t5jKrnwZDOWk1Qp0h
 XFpdqlL4oWPJ0ACYUd0xyvXAA+fEX/xkUoIqdONUeEwPYiA5Bzt7XLC65fpZsTfgbiHyP2
 hqhM0L+7iUt2Ih8cmYJADqJhf93Ov1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724330668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y6a9d8EfCCB8orXMpXL4YMdgYxlxcodnM1APqHacEo4=;
 b=fQ8f38CmQR0o3OeNhWbjqUZSCUAVIWM2roRfSW2M54sJWhDvZ7/8b9BQKuAVAhsrtob5kz
 buGvfUoc3bZIvaBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724330668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y6a9d8EfCCB8orXMpXL4YMdgYxlxcodnM1APqHacEo4=;
 b=01LHTwgzOFuKvq4jL8KU8OaXfsm4FtH3xtlNalE1iAskzL4Qy0041t5jKrnwZDOWk1Qp0h
 XFpdqlL4oWPJ0ACYUd0xyvXAA+fEX/xkUoIqdONUeEwPYiA5Bzt7XLC65fpZsTfgbiHyP2
 hqhM0L+7iUt2Ih8cmYJADqJhf93Ov1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724330668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y6a9d8EfCCB8orXMpXL4YMdgYxlxcodnM1APqHacEo4=;
 b=fQ8f38CmQR0o3OeNhWbjqUZSCUAVIWM2roRfSW2M54sJWhDvZ7/8b9BQKuAVAhsrtob5kz
 buGvfUoc3bZIvaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92D66139D3;
 Thu, 22 Aug 2024 12:44:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yJu3Fasyx2ZhPwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 Aug 2024 12:44:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH for-9.2 6/9] tests/unit/crypto-tls-x509-helpers: deinit
 privkey in test_tls_cleanup
In-Reply-To: <20240820144912.320744-7-peter.maydell@linaro.org>
References: <20240820144912.320744-1-peter.maydell@linaro.org>
 <20240820144912.320744-7-peter.maydell@linaro.org>
Date: Thu, 22 Aug 2024 09:44:25 -0300
Message-ID: <87cym0zpzq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, imap1.dmz-prg2.suse.org:helo,
 suse.de:mid, suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> We create a gnutls_x509_privkey_t in test_tls_init(), but forget
> to deinit it in test_tls_cleanup(), resulting in leaks
> reported in hte migration test such as:
>
> Indirect leak of 8 byte(s) in 1 object(s) allocated from:
>     #0 0x55fa6d11c12e in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f12e) (BuildId: 852a267993587f557f50e5715f352f43720077ba)
>     #1 0x7f073982685d in __gmp_default_allocate (/lib/x86_64-linux-gnu/libgmp.so.10+0xa85d) (BuildId: f110719303ddbea25a5e89ff730fec520eed67b0)
>     #2 0x7f0739836193 in __gmpz_realloc (/lib/x86_64-linux-gnu/libgmp.so.10+0x1a193) (BuildId: f110719303ddbea25a5e89ff730fec520eed67b0)
>     #3 0x7f0739836594 in __gmpz_import (/lib/x86_64-linux-gnu/libgmp.so.10+0x1a594) (BuildId: f110719303ddbea25a5e89ff730fec520eed67b0)
>     #4 0x7f07398a91ed in nettle_mpz_set_str_256_u (/lib/x86_64-linux-gnu/libhogweed.so.6+0xb1ed) (BuildId: 3cc4a3474de72db89e9dcc93bfb95fe377f48c37)
>     #5 0x7f073a146a5a  (/lib/x86_64-linux-gnu/libgnutls.so.30+0x131a5a) (BuildId: 97b8f99f392f1fd37b969a7164bcea884e23649b)
>     #6 0x7f073a07192c  (/lib/x86_64-linux-gnu/libgnutls.so.30+0x5c92c) (BuildId: 97b8f99f392f1fd37b969a7164bcea884e23649b)
>     #7 0x7f073a078333  (/lib/x86_64-linux-gnu/libgnutls.so.30+0x63333) (BuildId: 97b8f99f392f1fd37b969a7164bcea884e23649b)
>     #8 0x7f073a0e8353  (/lib/x86_64-linux-gnu/libgnutls.so.30+0xd3353) (BuildId: 97b8f99f392f1fd37b969a7164bcea884e23649b)
>     #9 0x7f073a0ef0ac in gnutls_x509_privkey_import (/lib/x86_64-linux-gnu/libgnutls.so.30+0xda0ac) (BuildId: 97b8f99f392f1fd37b969a7164bcea884e23649b)
>     #10 0x55fa6d2547e3 in test_tls_load_key tests/unit/crypto-tls-x509-helpers.c:99:11
>     #11 0x55fa6d25460c in test_tls_init tests/unit/crypto-tls-x509-helpers.c:128:15
>     #12 0x55fa6d2495c4 in test_migrate_tls_x509_start_common tests/qtest/migration-test.c:1044:5
>     #13 0x55fa6d24c23a in test_migrate_tls_x509_start_reject_anon_client tests/qtest/migration-test.c:1216:12
>     #14 0x55fa6d23fb40 in test_precopy_common tests/qtest/migration-test.c:1789:21
>     #15 0x55fa6d236b7c in test_precopy_tcp_tls_x509_reject_anon_client tests/qtest/migration-test.c:2614:5
>
> (Oddly, there is no reported leak in the x509 unit tests, even though
> those also use test_tls_init() and test_tls_cleanup().)
>
> Deinit the privkey in test_tls_cleanup().
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

