Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0D8D44D57
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 12:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8evG-00028q-4o; Wed, 06 Nov 2024 07:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8evB-00027b-Kn
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:14:02 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8ev9-0008RE-6f
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:14:01 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 046C221D0E;
 Wed,  6 Nov 2024 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730895237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XWJQjAI8/sQKP+uUMU0nFiF+1C3bcU/+vFmqm6kz9WI=;
 b=lcFvwSSfEdcfMX+hGoMTREnjaauq/JO//QNANIFEfUlMtl5iDEwPKTgasxqH1+GzLKuoDO
 44RbNTBHgzvfmAvZXOzu2/GIYj9BdMIDce/Etk1QZgJQYQq7DVb4f795Ohk8Wv7Mb7TRiF
 +rI2hU5yygxcLubyBJag1IqD2woyfTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730895237;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XWJQjAI8/sQKP+uUMU0nFiF+1C3bcU/+vFmqm6kz9WI=;
 b=f1vCPg9/N5GxP+sI8z3hT6gr6FI4lGCYcUR18Kocu+cSHHFOu/K55Z9rYwJAzqnm+LSknz
 quBt9ZvXQhu6omCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lcFvwSSf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="f1vCPg9/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730895237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XWJQjAI8/sQKP+uUMU0nFiF+1C3bcU/+vFmqm6kz9WI=;
 b=lcFvwSSfEdcfMX+hGoMTREnjaauq/JO//QNANIFEfUlMtl5iDEwPKTgasxqH1+GzLKuoDO
 44RbNTBHgzvfmAvZXOzu2/GIYj9BdMIDce/Etk1QZgJQYQq7DVb4f795Ohk8Wv7Mb7TRiF
 +rI2hU5yygxcLubyBJag1IqD2woyfTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730895237;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XWJQjAI8/sQKP+uUMU0nFiF+1C3bcU/+vFmqm6kz9WI=;
 b=f1vCPg9/N5GxP+sI8z3hT6gr6FI4lGCYcUR18Kocu+cSHHFOu/K55Z9rYwJAzqnm+LSknz
 quBt9ZvXQhu6omCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 842EC137C4;
 Wed,  6 Nov 2024 12:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VPWvEoRdK2dbCgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 06 Nov 2024 12:13:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 06/22] tests/qtest/migration: Move qmp helpers to a
 separate file
In-Reply-To: <ZytKfYirP-R1mRNV@redhat.com>
References: <20241105180837.5990-1-farosas@suse.de>
 <20241105180837.5990-7-farosas@suse.de> <ZytKfYirP-R1mRNV@redhat.com>
Date: Wed, 06 Nov 2024 09:13:54 -0300
Message-ID: <87wmhg1rwd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 046C221D0E
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Nov 05, 2024 at 03:08:21PM -0300, Fabiano Rosas wrote:
>> We current have a bunch of non-test functions in migration-test.c and
>> some others in migration-helpers.c. In order to split migration-test.c
>> into separate test binaries, these helpers need to go somewhere
>> else.
>>=20
>> To avoid making migration-helpers even larger, move all QMP-related
>> functions into a new migration-qmp.c file and put it under the
>> qtest/migration/ directory.
>>=20
>> The new file holds everything that has as its main responsibility to
>> call into QMP.
>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/meson.build                |   1 +
>>  tests/qtest/migration-helpers.c        | 250 +------------
>>  tests/qtest/migration-helpers.h        |  18 +-
>>  tests/qtest/migration-test.c           | 237 +-----------
>>  tests/qtest/migration/migration-qmp.c  | 485 +++++++++++++++++++++++++
>>  tests/qtest/migration/migration-util.h |  45 +++
>
> I would have expected the header to be named 'migration-qmp.h' to match
> the source file naming, and not merge all of migration-helpers.h into
> it in the next patch which seems to partially defeat the point of splitti=
ng
> up the files.
>

Ok, I can change that.

