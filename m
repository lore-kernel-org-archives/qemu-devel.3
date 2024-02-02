Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B02EC47DB3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 13:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVtsx-0000H8-A2; Fri, 02 Feb 2024 08:47:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVtsv-0000Gl-5A
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 08:47:13 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVtst-0003ax-6Z
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 08:47:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B8202212F;
 Fri,  2 Feb 2024 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706881628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LDed/7SsdxFg8YHhxeS01pA85VtMJgolReJT9o73DX8=;
 b=1yaKgBN9C2W/WCLIumokHycqZNOMQG6x/aydPv+yBXHB+e9B5HRpaK5e5DWEmsJo/uuEWC
 MxzgxJsuwe+EufrRPcRljqHhrtl1VzHIbbobZQbUVQ1iChyWB5TzYm1TgH3h/34Ha6VsOF
 8idV2sMfh4GEGbjYXamU1BaBigc02Gs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706881628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LDed/7SsdxFg8YHhxeS01pA85VtMJgolReJT9o73DX8=;
 b=3Hi/Ra0m7WY3cu40DAqNJ0sa9mV1WRY+2tX0tINtT4l4oO51Lxkqwlno1rZGmj8laFZsSC
 MKc4BVgTq2UoPoCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706881628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LDed/7SsdxFg8YHhxeS01pA85VtMJgolReJT9o73DX8=;
 b=1yaKgBN9C2W/WCLIumokHycqZNOMQG6x/aydPv+yBXHB+e9B5HRpaK5e5DWEmsJo/uuEWC
 MxzgxJsuwe+EufrRPcRljqHhrtl1VzHIbbobZQbUVQ1iChyWB5TzYm1TgH3h/34Ha6VsOF
 8idV2sMfh4GEGbjYXamU1BaBigc02Gs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706881628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LDed/7SsdxFg8YHhxeS01pA85VtMJgolReJT9o73DX8=;
 b=3Hi/Ra0m7WY3cu40DAqNJ0sa9mV1WRY+2tX0tINtT4l4oO51Lxkqwlno1rZGmj8laFZsSC
 MKc4BVgTq2UoPoCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06E62139AB;
 Fri,  2 Feb 2024 13:47:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qITLL1vyvGXQFQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Feb 2024 13:47:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 06/14] ci: Add a migration compatibility test job
In-Reply-To: <CAFEAcA9=7NzEFLQxAxEWUzTRAZm87caC1ZhxeZkKyiP9Kb4k2w@mail.gmail.com>
References: <20240129030405.177100-1-peterx@redhat.com>
 <20240129030405.177100-7-peterx@redhat.com>
 <CAFEAcA9=7NzEFLQxAxEWUzTRAZm87caC1ZhxeZkKyiP9Kb4k2w@mail.gmail.com>
Date: Fri, 02 Feb 2024 10:47:05 -0300
Message-ID: <87eddvhtba.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,gitlab.com:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> On Mon, 29 Jan 2024 at 03:04, <peterx@redhat.com> wrote:
>>
>> From: Fabiano Rosas <farosas@suse.de>
>>
>> The migration tests have support for being passed two QEMU binaries to
>> test migration compatibility.
>>
>> Add a CI job that builds the lastest release of QEMU and another job
>> that uses that version plus an already present build of the current
>> version and run the migration tests with the two, both as source and
>> destination. I.e.:
>>
>>  old QEMU (n-1) -> current QEMU (development tree)
>>  current QEMU (development tree) -> old QEMU (n-1)
>>
>> The purpose of this CI job is to ensure the code we're about to merge
>> will not cause a migration compatibility problem when migrating the
>> next release (which will contain that code) to/from the previous
>> release.
>>
>> The version of migration-test used will be the one matching the older
>> QEMU. That way we can avoid special-casing new tests that wouldn't be
>> compatible with the older QEMU.
>>
>> Note: for user forks, the version tags need to be pushed to gitlab
>> otherwise it won't be able to checkout a different version.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> Link: https://lore.kernel.org/r/20240118164951.30350-3-farosas@suse.de
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> ---
>>  .gitlab-ci.d/buildtest.yml | 60 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 60 insertions(+)
>>
>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> index e1c7801598..f0b0edc634 100644
>> --- a/.gitlab-ci.d/buildtest.yml
>> +++ b/.gitlab-ci.d/buildtest.yml
>> @@ -167,6 +167,66 @@ build-system-centos:
>>        x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
>>      MAKE_CHECK_ARGS: check-build
>>
>> +# Previous QEMU release. Used for cross-version migration tests.
>> +build-previous-qemu:
>> +  extends: .native_build_job_template
>> +  artifacts:
>> +    when: on_success
>> +    expire_in: 2 days
>> +    paths:
>> +      - build-previous
>> +    exclude:
>> +      - build-previous/**/*.p
>> +      - build-previous/**/*.a.p
>> +      - build-previous/**/*.fa.p
>> +      - build-previous/**/*.c.o
>> +      - build-previous/**/*.c.o.d
>> +      - build-previous/**/*.fa
>> +  needs:
>> +    job: amd64-opensuse-leap-container
>> +  variables:
>> +    IMAGE: opensuse-leap
>> +    TARGETS: x86_64-softmmu aarch64-softmmu
>> +  before_script:
>> +    - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
>> +    - git checkout $QEMU_PREV_VERSION
>> +  after_script:
>> +    - mv build build-previous
>
> There seems to be a problem with this new CI job. Running a CI
> run in my local repository it fails:
>
> https://gitlab.com/pm215/qemu/-/jobs/6075873685
>
> $ export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v .0/' VERSION)"
> $ git checkout $QEMU_PREV_VERSION
> error: pathspec 'v8.2.0' did not match any file(s) known to git
> Running after_script
> Running after script...
> $ mv build build-previous
> mv: cannot stat 'build': No such file or directory
> WARNING: after_script failed, but job will continue unaffected: exit code 1
> Saving cache for failed job
>
>
> I don't think you can assume that private forks doing submaintainer CI
> runs necessarily have the full set of tags that the main repo does.

Yes, I thought this would be rare enough not to be an issue, but it
seems it's not. I don't know what could be done here, if there's no tag,
then there's no way to resolve the actual commit hash I think.

> I suspect the sed run will also do the wrong thing when run on the
> commit that updates the version, because then it will replace
> "9.0.0" with "9.0.0".

I just ignored this completly because my initial idea was to leave this
job disabled and only run it for migration patchsets and pull requests,
so it wouldn't make sense to run at that commit.

This job is also not entirely fail proof by design because we could
always be hitting bugs in the older QEMU version that were already fixed
in the new version.

I think the simplest fix here is to leave the test disabled, possibly
with an env variable to enable it.

