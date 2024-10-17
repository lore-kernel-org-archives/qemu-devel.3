Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E03FD3C522
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 16:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1TNf-0007Vq-R6; Thu, 17 Oct 2024 12:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1TNd-0007V9-UW
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:29:41 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1TNc-0001K6-7K
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:29:41 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B796421B88;
 Thu, 17 Oct 2024 16:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729182578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZL7VD++A2u5yANofml/EK7BaK/dgiXYg5I2ZDkGQTI=;
 b=F8TLtexUOxlvR7KHne34JEcmDqxyptyzLbhBFLjQDZTWGJ6kh9qyu/8Io6iC6Upi1LYdTp
 9+Cpukmpgw/o9TZN352+rCh+CV9FbrZGGveevuCrIkxaKSVDgBU5MdTQtb9Oju97I1fMsF
 a3enQSCBDcTV7cZiNlNtd6aXvxZuRDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729182578;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZL7VD++A2u5yANofml/EK7BaK/dgiXYg5I2ZDkGQTI=;
 b=Xyot93eHuNeYUDvRxLh9UdrL5vyI4OMr9ybuSry7UBSgrZEPsQoCNGdKqPLNhA1qqtjhDc
 AQbd25FiQFPR/WCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729182578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZL7VD++A2u5yANofml/EK7BaK/dgiXYg5I2ZDkGQTI=;
 b=F8TLtexUOxlvR7KHne34JEcmDqxyptyzLbhBFLjQDZTWGJ6kh9qyu/8Io6iC6Upi1LYdTp
 9+Cpukmpgw/o9TZN352+rCh+CV9FbrZGGveevuCrIkxaKSVDgBU5MdTQtb9Oju97I1fMsF
 a3enQSCBDcTV7cZiNlNtd6aXvxZuRDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729182578;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZL7VD++A2u5yANofml/EK7BaK/dgiXYg5I2ZDkGQTI=;
 b=Xyot93eHuNeYUDvRxLh9UdrL5vyI4OMr9ybuSry7UBSgrZEPsQoCNGdKqPLNhA1qqtjhDc
 AQbd25FiQFPR/WCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41D2513A53;
 Thu, 17 Oct 2024 16:29:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aEyVAnI7EWczSwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 17 Oct 2024 16:29:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 4/4] ci: Add check-migration-quick to the clang job
In-Reply-To: <ZxEl4zYgHLoLeHCT@redhat.com>
References: <20241017143211.17771-1-farosas@suse.de>
 <20241017143211.17771-5-farosas@suse.de> <ZxEl4zYgHLoLeHCT@redhat.com>
Date: Thu, 17 Oct 2024 13:29:35 -0300
Message-ID: <87r08e3d74.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> On Thu, Oct 17, 2024 at 11:32:11AM -0300, Fabiano Rosas wrote:
>> Recent changes to how we invoke the migration tests have
>> (intentionally) caused them to not be part of the check-qtest target
>> anymore. Add the check-migration-quick target so we don't lose
>> migration code testing in this job.
>
> But 'check-migration-quick' is only the subset of migration tests,
> 'check-migration' is all of the migration tests. So surely this is
> a massive regressions in covage in CI pipelines.

I'm not sure it is. There are tests there already for all the major
parts of the code: precopy, postcopy, multifd, socket. Besides, we can
tweak migration-quick to cover spots where we think we're losing
coverage.

Since our CI offers nothing in terms of reproducibility or
debuggability, I don't think it's productive to have an increasing
amount of tests running in CI if that means we'll be dealing with
timeouts and intermittent crashes constantly.

>
> Experience shows us that relying on humans to run tests periodically
> doesn't work well, and they'll slowly bit rot. Migration maintainers
> don't have a way to run this as gating test for every pull request
> that merges, and pull requests coming from non-migration maintainers
> can still break migration code.

Right, but migration code would still be tested with migration-quick
which is executed at every make check. Do we really need the full set in
every pull request? We must draw a line somewhere, otherwise make check
will just balloon in duration.

>
> Any tests in tree need to be exercised by CI as the minimum bar
> to prevent bit rot from merges.
>

No disagreement here. But then I'm going to need advice on what to do
when other maintainers ask us to stop writing migration tests because
they take too long. I cannot send contributors away nor merge code
without tests.

Do we need nightly CI runs? Unit tests? Bear in mind there's a resource
allocation issue there. Addressing problems with timeouts/races in our
CI is not something any random person can do.

>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  .gitlab-ci.d/buildtest.yml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> index 34d3f4e9ab..37247dc5fa 100644
>> --- a/.gitlab-ci.d/buildtest.yml
>> +++ b/.gitlab-ci.d/buildtest.yml
>> @@ -442,7 +442,7 @@ clang-system:
>>      CONFIGURE_ARGS: --cc=3Dclang --cxx=3Dclang++ --enable-ubsan
>>        --extra-cflags=3D-fno-sanitize-recover=3Dundefined
>>      TARGETS: alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu s390=
x-softmmu
>> -    MAKE_CHECK_ARGS: check-qtest check-tcg
>> +    MAKE_CHECK_ARGS: check-qtest check-tcg check-migration-quick
>>=20=20
>>  clang-user:
>>    extends: .native_build_job_template
>> --=20
>> 2.35.3
>>=20
>>=20
>
> With regards,
> Daniel

