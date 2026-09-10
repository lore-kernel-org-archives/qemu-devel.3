Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF631C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4kaU-0005tf-4Z; Thu, 10 Sep 2026 15:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4kSI-0002sE-Ue
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:29:15 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4kS5-0004zA-9Q
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:28:56 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DCE1121E88;
 Thu, 10 Sep 2026 19:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789068473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HNui1jyn8aBMkRkBDcXEzNrNKS5AspSa2vFCW0MJ8Qc=;
 b=d+njVwrSgVnYCCRfdcT9k8GGEv3C75gATkm2eG4ce3pw7YKAoXGVqdnIBi+XD8CwirZuP3
 r55O9wDP/zFoOk/FTk3keBnQu8StqL9cuS1QRW9g+VgEfoYgsoQM30z5tWcaG6uydC6SPh
 /Po9JfLcmAHz0WjUwWM9EZmT/T7q2XE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789068473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HNui1jyn8aBMkRkBDcXEzNrNKS5AspSa2vFCW0MJ8Qc=;
 b=V2v5jVKyh8xY1do/y+XpB/vcwpJjO1G4ndbuUtlU9oTHkXIBKF3RAUQF427AjVoMB2PlOe
 3rCpLWXMZugYv1Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789068468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HNui1jyn8aBMkRkBDcXEzNrNKS5AspSa2vFCW0MJ8Qc=;
 b=eBxwMYL4srlvJTPQjY49RLSI/oQSiR4c3dbklEeM3WodMsoKERL548+YkY5gOksmkZzaue
 LsfLQmoTmG7XKlnpXy73AFk9xBT4PmnBPM4e1TPN3kUW7ZgrZcHIb1ULlAdlvVULLpa9S8
 08rrpMFmsk6QyW6XRGp2sJiMQF6Dotg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789068468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HNui1jyn8aBMkRkBDcXEzNrNKS5AspSa2vFCW0MJ8Qc=;
 b=RA63CkrNbnqZlE34oqI53HCMfFSqAh8hb0zZOMlTJAnam6Nu3Pg8UZaqkVn085HsLDaZFM
 c0PF2r4npJyUAZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B3841326D;
 Thu, 10 Sep 2026 19:27:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /jl6C7QEo2pkBQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 10 Sep 2026 19:27:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr .
 David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v2 00/18] migration: MigrationParameters changes
In-Reply-To: <aqLqe4jmPuHL7OeL@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260909214509.237309-1-farosas@suse.de>
 <aqLqe4jmPuHL7OeL@zhexu-thinkpadt14gen5.rmtcaon.csb>
Date: Thu, 10 Sep 2026 16:27:42 -0300
Message-ID: <87mrtoucsx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Xu <peterx@redhat.com> writes:

> On Wed, Sep 09, 2026 at 06:44:50PM -0300, Fabiano Rosas wrote:
>> Fabiano Rosas (18):
>>   checkpatch: Fix checking of newlines in error messages
>>   migration/options.c: Don't export migrate_tls_opts_free
>>   migration: Rename variables in qmp_migrate_set_parameters
>>   migration: Use QAPI_CLONE_MEMBERS in migrate_params_apply
>>   migration: Merge parameter structs instead of assigning one by one
>>   migration: Open code migrate_params_apply
>>   migration: Stop freeing s->parameters members individually
>>   migration: Use migrate_params_free during finalize
>>   tests/qtest/migration: Add a test for HMP
>>   tests/qtest/migration: Add a test for HMP completion
>>   migration: HMP: Fix bandwidth parameters
>>   migration: Change HMP 'info migrate_parameters' output
>>   migration: Use keyval input visitor in HMP set command
>>   migration: Use output visitor in info command
>>   migration: Rewrite migrate_set_parameter_completion using QDict
>>   migration: Add capabilities into MigrationParameters
>>   migration: Remove s->capabilities
>>   qapi/migration: Deprecate capabilities commands
>
> The new HMP test may fail when ran without userfaultfd privilege.
>
> $ QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --full -r /x86_64/migration/hmp
> TAP version 14
> # random seed: R02S0ff0d2920ac5e3bffdb3b5a776110e91
> # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-219499.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-219499.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -machine none  -accel qtest
> # Skipping test: userfaultfd not available
> # Start of x86_64 tests
> # Start of migration tests
> # Start of hmp tests
> # Running /x86_64/migration/hmp/parameters
> # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-219499.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-219499.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -accel tcg -nodefaults -S  -accel qtest
> # HMP command failed:
> # 
> # Error: Background-snapshot is not supported by host kernel
> # 
> **
> ERROR:../tests/qtest/migration/misc-tests.c:376:assert_hmp_success: code should not be reached
> not ok /x86_64/migration/hmp/parameters - ERROR:../tests/qtest/migration/misc-tests.c:376:assert_hmp_success: code should not be reached
> Bail out!
> Aborted                    (core dumped) QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --full -r /x86_64/migration/hmp
>
> We can either fix it (but I don't see easy way to wrap some TESTs to run
> conditionally), or drop the verifications for background-snapshot cap for
> now.

Thank you for testing this. I think I can just move the array into the
test function and check env->has_uffd in there.

