Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20F6D44D54
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 12:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8fLs-0004lS-7j; Wed, 06 Nov 2024 07:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8fKn-0004HY-Pn
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:40:32 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8fKl-00029I-Tu
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:40:29 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9F2FA21E2F;
 Wed,  6 Nov 2024 12:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730896824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4RWr4Odl7bg1gJEqzLshTfhuBFzjmPIqC6ginQ1GCE=;
 b=epMjRJYwFVMmawAu3OH2EhQ+ax1Oin2q021FJA1F9fcREHc+uf6RBmALuQ0aNgSqQyTNv/
 GYp8OOjI4VrSdH9aYjjwJa4GXolebLzyqZzStpWDgJTGochjFoG19OHJRUq1FKuCm1ZvCB
 lkkVlBgC0zTe4PskQvji7jNzDPuaCTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730896824;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4RWr4Odl7bg1gJEqzLshTfhuBFzjmPIqC6ginQ1GCE=;
 b=v11F2t6vOf+ty8bJvk3wWPWd7FvEQGZhdTEz9zIMjBImVuYdn6/EEVA1SK87J0XeQYRcaa
 J/mhmwXhTpn7qDDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730896824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4RWr4Odl7bg1gJEqzLshTfhuBFzjmPIqC6ginQ1GCE=;
 b=epMjRJYwFVMmawAu3OH2EhQ+ax1Oin2q021FJA1F9fcREHc+uf6RBmALuQ0aNgSqQyTNv/
 GYp8OOjI4VrSdH9aYjjwJa4GXolebLzyqZzStpWDgJTGochjFoG19OHJRUq1FKuCm1ZvCB
 lkkVlBgC0zTe4PskQvji7jNzDPuaCTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730896824;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4RWr4Odl7bg1gJEqzLshTfhuBFzjmPIqC6ginQ1GCE=;
 b=v11F2t6vOf+ty8bJvk3wWPWd7FvEQGZhdTEz9zIMjBImVuYdn6/EEVA1SK87J0XeQYRcaa
 J/mhmwXhTpn7qDDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29A3713736;
 Wed,  6 Nov 2024 12:40:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gq0BOLdjK2e2EwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 06 Nov 2024 12:40:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 21/22] tests/qtest: Add support for check-qtest-<subsystem>
In-Reply-To: <ZytO8SLDAT2VRjly@redhat.com>
References: <20241105180837.5990-1-farosas@suse.de>
 <20241105180837.5990-22-farosas@suse.de> <ZytO8SLDAT2VRjly@redhat.com>
Date: Wed, 06 Nov 2024 09:40:21 -0300
Message-ID: <87pln81qoa.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

> On Tue, Nov 05, 2024 at 03:08:36PM -0300, Fabiano Rosas wrote:
>> Allow qtests to be ran by subsystem. Some subsystems, such as
>> migration, have a large number of tests and we could benefit from
>> being able to access them from make check without having to run the
>> full set of qtests.
>>=20
>> This adds the following make check targets:
>>=20
>> make check-qtest-migration
>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>> I did not include check-qtest-<arch>-<subsys> because meson generates a
>> long line that affects readability.
>
> Can you give an example of that ?  I'm wondering how much of a
> problem it actually is ? Personally when I'm running a subset
> of tests, I almost always want to limit to just one arch target.
>

Ok, you have a different use case, mine is just "run migration tests for
all archs, without bringing all the rest of qtest along". When I want to
limit to one arch, I use the 'QTEST_QEMU_BINARY=3Dqemu-system-<arch>
migration-test' syntax.

The issue is that meson always shows all suites in which a test is
present (quite uselessly IMO):

[1-8/8] =F0=9F=8C=91 qemu:qtest+qtest-s390x+qtest-migration+qtest-s390x-mig=
ration / qtest-s390x/migration-test                              0/480
1/8 qemu:qtest+qtest-x86_64+qtest-migration+qtest-x86_64-migration / qtest-=
x86_64/migration-test-smoke           SKIP             0.02s

vs:

1/8 qemu:qtest+qtest-x86_64+qtest-migration / qtest-x86_64/migration-test-s=
moke          SKIP             0.02s
2/8 qemu:qtest+qtest-ppc64+qtest-migration / qtest-ppc64/migration-test    =
              SKIP             0.02s


