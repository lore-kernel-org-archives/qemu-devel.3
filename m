Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBEDDC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 12:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh7AY-0005gA-He; Thu, 22 Aug 2024 08:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sh7AW-0005fX-BH
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 08:44:00 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sh7AU-0008At-HX
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 08:44:00 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 42B26224E6;
 Thu, 22 Aug 2024 12:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724330636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K4KUulQsDmIMNtNYZMmok7bOsopgMXpQ61QmeZ59xUM=;
 b=D0eVyhnbpQ7BqRW909YVcFn8Ib9Y73NyoVybfHXqthXzUdcvMVV5e9qR/oWin+skedlex7
 Jzdeg48OZ6s0/stwV90WiV2zOsIvaI5e3YP5vBUaJ/OaQbPqlFXSzP1boC/czvbKjbWWMo
 BIsy0zG6grFm5GgJaOo5XKuKvJQpfyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724330636;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K4KUulQsDmIMNtNYZMmok7bOsopgMXpQ61QmeZ59xUM=;
 b=nm2oKB+8b0ipSWt0hJV4eugEkIJUUxYGF92+hjTdYXkiu3PPxlLQQKg4DnWBCU6Mnxzx9X
 ZKBN77uLXkjS30Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724330636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K4KUulQsDmIMNtNYZMmok7bOsopgMXpQ61QmeZ59xUM=;
 b=D0eVyhnbpQ7BqRW909YVcFn8Ib9Y73NyoVybfHXqthXzUdcvMVV5e9qR/oWin+skedlex7
 Jzdeg48OZ6s0/stwV90WiV2zOsIvaI5e3YP5vBUaJ/OaQbPqlFXSzP1boC/czvbKjbWWMo
 BIsy0zG6grFm5GgJaOo5XKuKvJQpfyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724330636;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K4KUulQsDmIMNtNYZMmok7bOsopgMXpQ61QmeZ59xUM=;
 b=nm2oKB+8b0ipSWt0hJV4eugEkIJUUxYGF92+hjTdYXkiu3PPxlLQQKg4DnWBCU6Mnxzx9X
 ZKBN77uLXkjS30Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB76B139D3;
 Thu, 22 Aug 2024 12:43:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p6KdH4syx2YkPwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 Aug 2024 12:43:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH for-9.2 5/9] tests/qtest/migration-test: Free
 QCRyptoTLSTestCertReq objects
In-Reply-To: <20240820144912.320744-6-peter.maydell@linaro.org>
References: <20240820144912.320744-1-peter.maydell@linaro.org>
 <20240820144912.320744-6-peter.maydell@linaro.org>
Date: Thu, 22 Aug 2024 09:43:53 -0300
Message-ID: <87frqwzq0m.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, linaro.org:email,
 suse.de:mid, suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> In the migration test we create several TLS certificates with
> the TLS_* macros from crypto-tls-x509-helpers.h. These macros
> create both a QCryptoTLSCertReq object which must be deinitialized
> and also an on-disk certificate file. The migration test currently
> removes the on-disk file in test_migrate_tls_x509_finish() but
> never deinitializes the QCryptoTLSCertReq, which means that memory
> allocated as part of it is leaked:
>
> Indirect leak of 2 byte(s) in 1 object(s) allocated from:
>     #0 0x5558ba33712e in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/tests/qtest/migration-test+0x22f12e) (BuildId: 4c8618f663e538538cad19d35233124cea161491)
>     #1 0x7f64afc131f4  (/lib/x86_64-linux-gnu/libtasn1.so.6+0x81f4) (BuildId: 2fde6ecb43c586fe4077118f771077aa1298e7ea)
>     #2 0x7f64afc18d58 in asn1_write_value (/lib/x86_64-linux-gnu/libtasn1.so.6+0xdd58) (BuildId: 2fde6ecb43c586fe4077118f771077aa1298e7ea)
>     #3 0x7f64af8fc678 in gnutls_x509_crt_set_version (/lib/x86_64-linux-gnu/libgnutls.so.30+0xe7678) (BuildId: 97b8f99f392f1fd37b969a7164bcea884e23649b)
>     #4 0x5558ba470035 in test_tls_generate_cert tests/unit/crypto-tls-x509-helpers.c:234:5
>     #5 0x5558ba464e4a in test_migrate_tls_x509_start_common tests/qtest/migration-test.c:1058:5
>     #6 0x5558ba462c8a in test_migrate_tls_x509_start_default_host tests/qtest/migration-test.c:1123:12
>     #7 0x5558ba45ab40 in test_precopy_common tests/qtest/migration-test.c:1786:21
>     #8 0x5558ba450015 in test_precopy_unix_tls_x509_default_host tests/qtest/migration-test.c:2077:5
>     #9 0x5558ba46d3c7 in migration_test_wrapper tests/qtest/migration-helpers.c:456:5
>
> (and similar reports).
>
> The only function currently provided to deinit a QCryptoTLSCertReq is
> test_tls_discard_cert(), which also removes the on-disk certificate
> file.  For the migration tests we need to retain the on-disk files
> until we've finished running the test, so the simplest fix is to
> provide a new function test_tls_deinit_cert() which does only the
> cleanup of the QCryptoTLSCertReq, and call it in the right places.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

