Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B22D13C3E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 15:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkOp1-0007Bk-GN; Mon, 26 Jan 2026 10:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vkOox-00079W-Pu
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:48:07 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vkOow-00036Z-B6
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:48:07 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6734233712;
 Mon, 26 Jan 2026 15:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769442484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F2g50OiKgG/Zj/V7v5fwTN1iGkryNxd4nmKL7VqClk4=;
 b=XjhBOJI6qyPeJwFiGp118E633jpd4YFzbP51Cv/bUlcXb7w3a49WD8qM6isuqUppGtqaWr
 I5HDxjtZYfAhBqi6iGtvMjYbszwUc/m3WI4xD0c3ZQaX+tVtv48HFGlYne6Iv0m5k369yj
 lTyAaAinrXtwQbcmyhgOHZWGUG866vE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769442484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F2g50OiKgG/Zj/V7v5fwTN1iGkryNxd4nmKL7VqClk4=;
 b=9QFnw48e38ejQSzs9ahLgCS+AhYUevk2R/CF95iiWTYJRT/C0ZNLo4ZqsEFZJgspty679F
 yYy3WbmNGgEYbvAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XjhBOJI6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9QFnw48e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769442484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F2g50OiKgG/Zj/V7v5fwTN1iGkryNxd4nmKL7VqClk4=;
 b=XjhBOJI6qyPeJwFiGp118E633jpd4YFzbP51Cv/bUlcXb7w3a49WD8qM6isuqUppGtqaWr
 I5HDxjtZYfAhBqi6iGtvMjYbszwUc/m3WI4xD0c3ZQaX+tVtv48HFGlYne6Iv0m5k369yj
 lTyAaAinrXtwQbcmyhgOHZWGUG866vE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769442484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F2g50OiKgG/Zj/V7v5fwTN1iGkryNxd4nmKL7VqClk4=;
 b=9QFnw48e38ejQSzs9ahLgCS+AhYUevk2R/CF95iiWTYJRT/C0ZNLo4ZqsEFZJgspty679F
 yYy3WbmNGgEYbvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD452139E9;
 Mon, 26 Jan 2026 15:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bqnUIrOMd2lwbgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Jan 2026 15:48:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [REPORT] Double deletion of output directory in functional test
In-Reply-To: <652b1544-e008-441d-8d15-b31856b0359d@linux.ibm.com>
References: <aXOGKb88Yho2jb_o@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <652b1544-e008-441d-8d15-b31856b0359d@linux.ibm.com>
Date: Mon, 26 Jan 2026 12:48:00 -0300
Message-ID: <87h5s8gytr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 6734233712
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

Aditya Gupta <adityag@linux.ibm.com> writes:

> +harsh
>
> On 23/01/26 20:07, Aditya Gupta wrote:
>
>> Hello,
>>
>> I notice a test failure with ppc64 functional tests, which only occurs w=
hen
>> tests are run in parallel ('make check-functional-ppc64 -j8').
>>
>> I believe the issue might be with the generic migration testcase. The fo=
llowing
>> backtrace happens on error:
>>
>> 	Traceback (most recent call last):
>> 	  File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 421, in=
 tearDown
>> 	    super().tearDown()
>> 	  File "<SRC_DIR>/tests/functional/qemu_test/testcase.py", line 238, in=
 tearDown
>> 	    shutil.rmtree(self.workdir)
>> 	  File "/usr/lib64/python3.11/shutil.py", line 742, in rmtree
>> 	    onerror(os.lstat, path, sys.exc_info())
>> 	  File "/usr/lib64/python3.11/shutil.py", line 740, in rmtree
>> 	    orig_st =3D os.lstat(path, dir_fd=3Ddir_fd)
>> 	              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> 	FileNotFoundError: [Errno 2] No such file or directory: '<SRC_DIR>/buil=
d/tests/functional/ppc64/test_migration.PpcMigrationTest.test_migration_wit=
h_exec/scratch'
>
> Git bisect points to this:
>
>
>  =C2=A0 =C2=A0 f4e34d0fd56c25dd0c90722ed80a83a175160a6c is the first bad =
commit
>  =C2=A0 =C2=A0 commit f4e34d0fd56c25dd0c90722ed80a83a175160a6c
>  =C2=A0 =C2=A0 Date:=C2=A0 =C2=A0Fri Jan 9 09:35:19 2026 -0300
>
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 tests/functional: Add a OS level migration t=
est for pseries
>

I see, the test I added imports PpcMigrationTest which causes it to be
instantiated by unittest and the setup method races with another test
that uses the same class. I'll send a patch.

>
> - Aditya G

