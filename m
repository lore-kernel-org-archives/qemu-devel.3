Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B66EDA687
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRxX-0004EY-Cr; Tue, 03 Mar 2026 10:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vxRxT-0004E5-VH
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:46:53 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vxRxR-0006fB-P5
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:46:51 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1AEDD3F90C;
 Tue,  3 Mar 2026 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772552806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pGWywXP8vHe5YHVLWWjKFnuD1pi1PwtDRh4NiEF4jyo=;
 b=x09I16kyOfdl4mckpZ4CvSb84X/3lJOWHHtGiMMmmdxFTNzjxyZWNTHGQU1L3MqRQf7n5b
 dOX8IIWA1y6ZYPJrHqIe3Kl2gqtlP07yEKmGWB+inCwrhiLH1oSj1EUwk1R0NV86STsLjY
 /uuDltkuPP132tqAKuEpau1KCCZYCaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772552806;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pGWywXP8vHe5YHVLWWjKFnuD1pi1PwtDRh4NiEF4jyo=;
 b=QtvmBHfFMDsLV/00OwuzD/vwIlBlT15kAjf4uKOVRtUfu7sdsXKBSIOJ98drlkYttftT0P
 QeBtr86QBfhbLrBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=x09I16ky;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QtvmBHfF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772552806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pGWywXP8vHe5YHVLWWjKFnuD1pi1PwtDRh4NiEF4jyo=;
 b=x09I16kyOfdl4mckpZ4CvSb84X/3lJOWHHtGiMMmmdxFTNzjxyZWNTHGQU1L3MqRQf7n5b
 dOX8IIWA1y6ZYPJrHqIe3Kl2gqtlP07yEKmGWB+inCwrhiLH1oSj1EUwk1R0NV86STsLjY
 /uuDltkuPP132tqAKuEpau1KCCZYCaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772552806;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pGWywXP8vHe5YHVLWWjKFnuD1pi1PwtDRh4NiEF4jyo=;
 b=QtvmBHfFMDsLV/00OwuzD/vwIlBlT15kAjf4uKOVRtUfu7sdsXKBSIOJ98drlkYttftT0P
 QeBtr86QBfhbLrBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93ADB3EA69;
 Tue,  3 Mar 2026 15:46:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WEtBFmUCp2lzYgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Mar 2026 15:46:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: adityag@linux.ibm.com, berrange@redhat.com, peterx@redhat.com, Nicholas
 Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v3 4/5] tests/functional/ppc64/pseries: Inherit from
 MigrationTest
In-Reply-To: <fdac5b26-e8ac-4535-ad3e-8b158b3c051b@redhat.com>
References: <20260303134348.8890-1-farosas@suse.de>
 <20260303134348.8890-5-farosas@suse.de>
 <fdac5b26-e8ac-4535-ad3e-8b158b3c051b@redhat.com>
Date: Tue, 03 Mar 2026 12:46:43 -0300
Message-ID: <878qc83ogs.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[linux.ibm.com,redhat.com,gmail.com];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[7]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 1AEDD3F90C
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Thomas Huth <thuth@redhat.com> writes:

> On 03/03/2026 14.43, Fabiano Rosas wrote:
>> Make the PseriesMachine class inherit from MigrationTest so the next
>> patch can access migration routines without needing to instantiate a
>> MigrationTest object. This is just for cleanliness of the code.
>> 
>> Note that creating a separate class for migration wouldn't work quite
>> well because the class attributes of PseriesMachine would then have to
>> be exposed to that class somehow.
>> 
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   tests/functional/ppc64/test_pseries.py | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
>> index b45763c305..ce39e16a22 100755
>> --- a/tests/functional/ppc64/test_pseries.py
>> +++ b/tests/functional/ppc64/test_pseries.py
>> @@ -11,7 +11,7 @@
>>   from qemu_test import wait_for_console_pattern
>>   from test_migration import PpcMigrationTest
>>   
>> -class PseriesMachine(QemuSystemTest):
>> +class PseriesMachine(MigrationTest):
>
> This patch does not work (without the following one). You only import 
> PpcMigrationTest, but not MigrationTest, so inheriting from MigrationTest is 
> not possible here...
>

Ouch, sorry. I'll repost.

