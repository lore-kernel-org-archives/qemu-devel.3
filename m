Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDBFC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 14:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuXlX-0000XW-A3; Tue, 18 Mar 2025 10:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1tuXlC-0000T3-RB
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 10:17:40 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1tuXlA-0008Lk-GG
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 10:17:38 -0400
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9C5CC21DC8;
 Tue, 18 Mar 2025 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742307454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgqYHFMWDlWRd6a7zp84Cg/iwVVnSsSrNWrAwngDHLE=;
 b=uIOOYuGlYQ6R5qE0Gl7vmzfRpQRDHeA2kzp+R8poRWTCzWsyPovYzPiv1OJvmm3hUMQwCN
 9WIgTmQvoUGS01MufoehlkIZ+JdQ1ZCXVq0tDejpHd2hbcL+hO1/7W/7AI8LyyFEENXXj8
 ejVc2EsECv8/oJxoOJol0lxumEn5Wmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742307454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgqYHFMWDlWRd6a7zp84Cg/iwVVnSsSrNWrAwngDHLE=;
 b=n5GbxxuZfJun40TABx/0mEbT6pia4a7hvfehCO/qV7h9q5X2KHkDzgaZwhDw8CQh1YYr76
 4PuQkng219c7uCCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PMPZ0t4g;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kqSNWDmF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742307453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgqYHFMWDlWRd6a7zp84Cg/iwVVnSsSrNWrAwngDHLE=;
 b=PMPZ0t4g/rzMsMBauKlwBb/2UBmDZDUB/6OLkgGiSOEHci3zZijftor+v0zw8MzEZtEt/B
 UA4Fr6oDRSA/n+kMQx1J6lkvVlMfUZY12ozCAbPWBqiMyaQqQ9DD6MlbyuaQcDJSp4jPa+
 nl31MCJ9k1ZM5TkyLk3klSUdDRejE00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742307453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgqYHFMWDlWRd6a7zp84Cg/iwVVnSsSrNWrAwngDHLE=;
 b=kqSNWDmFfLXrlrVP9eSseCiMASu9CHHcTjMsZ+fu9UVErqLDeSwI7IrA0H4pPhV0fRtnwt
 bqe2taWFCtOn1DCQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 6E2154A0561; Tue, 18 Mar 2025 15:17:33 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org
Subject: Re: Generic way to detect qemu linux-user emulation
In-Reply-To: <Z9l7J0oZ8GAEqaMP@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 18 Mar 2025 13:54:47 +0000")
References: <mvm1puuiqvu.fsf@suse.de>
 <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de>
 <CAFEAcA_-fODgkxLLCNf3XHBU=EvGgKx4qcE_PqNt8-4jwqnqVw@mail.gmail.com>
 <Z9lf7lniMWzoy6uS@redhat.com> <mvmmsdih5zi.fsf@suse.de>
 <Z9lqcQGdIsjUHeVJ@redhat.com>
 <CAFEAcA9r0GKWG2_w20HxbXz+MhdsraxCa=RvzaVYO+gd2DEY4Q@mail.gmail.com>
 <Z9l7J0oZ8GAEqaMP@redhat.com>
Date: Tue, 18 Mar 2025 15:17:33 +0100
Message-ID: <mvmh63qh18i.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.59 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; RDNS_NONE(2.00)[];
 ONCE_RECEIVED(1.20)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmx.de];
 FREEMAIL_CC(0.00)[linaro.org,gmx.de,nongnu.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_ONE(0.00)[1]; DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 opensuse.org:url]
X-Spamd-Bar: ++
X-Rspamd-Queue-Id: 9C5CC21DC8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=schwab@suse.de;
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

On Mär 18 2025, Daniel P. Berrangé wrote:

> That would get the synchronization behaviour of Linux vfork,
> but I'm not sure it'd get the performance benefits (of avoiding
> page table copying) which is what  Andreas mentioned as the
> desired thing ?

For an emulation performance isn't a thing, what we need is accuracy.
The current issue I have right now is that the MozillaFirefox package
fails to build because posix_spawn behaves unexpectedly.

https://build.opensuse.org/package/live_build_log/openSUSE:Factory:RISCV/MozillaFirefox/standard/riscv64

[  666s]  4:55.15 Traceback (most recent call last):
[  666s]  4:55.16   File "/home/abuild/rpmbuild/BUILD/MozillaFirefox-136.0.1-build/firefox-136.0.1/security/nss/./coreconf/werror.py", line 80, in <module>
[  666s]  4:55.16     main()
[  666s]  4:55.16     ~~~~^^
[  666s]  4:55.16   File "/home/abuild/rpmbuild/BUILD/MozillaFirefox-136.0.1-build/firefox-136.0.1/security/nss/./coreconf/werror.py", line 10, in main
[  666s]  4:55.16     cc_is_clang = 'clang' in subprocess.check_output(
[  666s]  4:55.16                              ~~~~~~~~~~~~~~~~~~~~~~~^
[  666s]  4:55.16       [cc, '--version'], universal_newlines=True, stderr=sink)
[  666s]  4:55.16       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[  666s]  4:55.16   File "/usr/lib64/python3.13/subprocess.py", line 474, in check_output
[  666s]  4:55.16     return run(*popenargs, stdout=PIPE, timeout=timeout, check=True,
[  666s]  4:55.16            ~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[  666s]  4:55.17                **kwargs).stdout
[  666s]  4:55.17                ^^^^^^^^^
[  666s]  4:55.17   File "/usr/lib64/python3.13/subprocess.py", line 579, in run
[  666s]  4:55.17     raise CalledProcessError(retcode, process.args,
[  666s]  4:55.17                              output=stdout, stderr=stderr)
[  666s]  4:55.17 subprocess.CalledProcessError: Command '['/usr/bin/ccache /usr/bin/gcc', '--version']' returned non-zero exit status 127.

A real posix_spawn would have set errno to ENOENT.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

