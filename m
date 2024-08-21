Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B53C52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 21:02:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgsRw-0007fr-8B; Wed, 21 Aug 2024 17:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sgsRu-0007er-8o
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:00:58 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sgsRr-0001nu-Nl
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:00:57 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 60454200DA;
 Wed, 21 Aug 2024 21:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724274050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WyOAzO3YOelsQeo8whsGklqadmdZQ7xLINdcnBNhSjE=;
 b=Nb7S+QsRpEf/OtXdvJdbK/Qbe0+b1N5LGg2rYj9wb9nc69JNFnSB3pPg1RI0dvjBcPWr5A
 07uwQMLxJ+vZpjj9V8QuLCvaavX7R0GaYgAP5jbdSW8Swlrw2gMzb0L36GWh1SSVvAewFo
 JFQiG9p+15hd7i5x5vrJFPJ3WT2qcps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724274050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WyOAzO3YOelsQeo8whsGklqadmdZQ7xLINdcnBNhSjE=;
 b=6jqU2SXwSXi3DhLBtBZ8SPLouwY5eVWDYM4NI6SQU1SpyB7UdQ1b6uuKCZZDllMsKdLUa1
 VBmbMcInyIAYkhBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nb7S+QsR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6jqU2SXw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724274050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WyOAzO3YOelsQeo8whsGklqadmdZQ7xLINdcnBNhSjE=;
 b=Nb7S+QsRpEf/OtXdvJdbK/Qbe0+b1N5LGg2rYj9wb9nc69JNFnSB3pPg1RI0dvjBcPWr5A
 07uwQMLxJ+vZpjj9V8QuLCvaavX7R0GaYgAP5jbdSW8Swlrw2gMzb0L36GWh1SSVvAewFo
 JFQiG9p+15hd7i5x5vrJFPJ3WT2qcps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724274050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WyOAzO3YOelsQeo8whsGklqadmdZQ7xLINdcnBNhSjE=;
 b=6jqU2SXwSXi3DhLBtBZ8SPLouwY5eVWDYM4NI6SQU1SpyB7UdQ1b6uuKCZZDllMsKdLUa1
 VBmbMcInyIAYkhBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF0B413770;
 Wed, 21 Aug 2024 21:00:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mH76KIFVxmZnKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 21 Aug 2024 21:00:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH for-9.2 1/9] tests/qtest/migration-test: Fix bootfile
 cleanup handling
In-Reply-To: <20240820144912.320744-2-peter.maydell@linaro.org>
References: <20240820144912.320744-1-peter.maydell@linaro.org>
 <20240820144912.320744-2-peter.maydell@linaro.org>
Date: Wed, 21 Aug 2024 18:00:47 -0300
Message-ID: <87zfp5zj40.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 60454200DA
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> If you invoke the migration-test binary in such a way that it doesn't run
> any tests, then we never call bootfile_create(), and at the end of
> main() bootfile_delete() will try to unlink(NULL), which is not valid.
> This can happen if for instance you tell the test binary to run a
> subset of tests that turns out to be empty, like this:
>
>  (cd build/asan && QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --tap -k -p bang)
>  # random seed: R02S6501b289ff8ced4231ba452c3a87bc6f
>  # Skipping test: userfaultfd not available
>  1..0
>  ../../tests/qtest/migration-test.c:182:12: runtime error: null pointer passed as argument 1, which is declared to never be null
>  /usr/include/unistd.h:858:48: note: nonnull attribute specified here
>
> Conversely, because we call bootfile_create() once per test
> but only call bootfile_delete() at the end of the whole test
> run, we will leak the memory we used for bootpath when we
> overwrite it.
>
> Handle these by:
>  * making bootfile_delete() handle not needing to do anything
>    because bootfile_create() was never called
>  * making bootfile_create() call bootfile_delete() first to
>    tidy up any previous bootfile before it creates a fresh one
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

