Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CBFD44D57
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 12:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8euC-0001DA-IT; Wed, 06 Nov 2024 07:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8euB-0001Cy-Ms
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:12:59 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8euA-0008Ha-0E
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:12:59 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3726F1FB4E;
 Wed,  6 Nov 2024 12:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730895176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LJHHhjvJ0OHmwr7R29JLx9sqHm3dyeRsNIgmYquj+Xs=;
 b=AiKVmExlBdr+2MtFib2P5zNRnWl/ZMGlotNEkpd7Nf8N1XVLRiQ9JH8B3wRKsUJKLkXnS2
 pN2kiRLsDbxA4Np1f5eTGLHZP74bq20iIkh45ssJiMeqEWKv00wjPCIaZDlb2l/y2jXEVB
 BaWALgrElhgQn+uP9IOvxp8kxDDeP/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730895176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LJHHhjvJ0OHmwr7R29JLx9sqHm3dyeRsNIgmYquj+Xs=;
 b=IewFlZBGudAgsRMU3t4ULb6ocnfaAt1AIhViQBVRqdsW5N/XrV69GbmhaWxSW2iPHzsVPi
 v141XtwsgQV3goAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AiKVmExl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IewFlZBG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730895176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LJHHhjvJ0OHmwr7R29JLx9sqHm3dyeRsNIgmYquj+Xs=;
 b=AiKVmExlBdr+2MtFib2P5zNRnWl/ZMGlotNEkpd7Nf8N1XVLRiQ9JH8B3wRKsUJKLkXnS2
 pN2kiRLsDbxA4Np1f5eTGLHZP74bq20iIkh45ssJiMeqEWKv00wjPCIaZDlb2l/y2jXEVB
 BaWALgrElhgQn+uP9IOvxp8kxDDeP/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730895176;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LJHHhjvJ0OHmwr7R29JLx9sqHm3dyeRsNIgmYquj+Xs=;
 b=IewFlZBGudAgsRMU3t4ULb6ocnfaAt1AIhViQBVRqdsW5N/XrV69GbmhaWxSW2iPHzsVPi
 v141XtwsgQV3goAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1C87137C4;
 Wed,  6 Nov 2024 12:12:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bEHOHUddK2f/CQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 06 Nov 2024 12:12:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: Re: [PATCH 03/22] tests/qtest/migration: Stop calling everything
 "test"
In-Reply-To: <Zys3F6326kF5W2Br@redhat.com>
References: <20241105180837.5990-1-farosas@suse.de>
 <20241105180837.5990-4-farosas@suse.de> <Zys3F6326kF5W2Br@redhat.com>
Date: Wed, 06 Nov 2024 09:12:53 -0300
Message-ID: <87zfmc1ry2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3726F1FB4E
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> On Tue, Nov 05, 2024 at 03:08:18PM -0300, Fabiano Rosas wrote:
>> Test frameworks usually prefix "test_" to the entry point of the test
>> code. Having every function prefixed with test_ makes it hard to
>> understand the code and to grep for the actual tests.
>>=20
>> Remove the "test" prefix from everything that is not a test.
>>=20
>> In order to still keep some namespacing, stick to the "migrate_"
>> prefix, which is the most used currently.
>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>> note: I would prefer the prefix "mig_" to avoid using "migrate_" which
>> is a verb, but several functions such as migrate_qmp() would have to
>> be given an entirely new name to keep expressiveness and I want to
>> keep this a mechanical change.
>> ---
>>  tests/qtest/migration-test.c | 410 +++++++++++++++++------------------
>>  1 file changed, 205 insertions(+), 205 deletions(-)
>>=20
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 04890e0479..a40451df1e 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>
>> @@ -919,9 +919,9 @@ struct TestMigrateTLSPSKData {
>>  };
>>=20=20
>>  static void *
>> -test_migrate_tls_psk_start_common(QTestState *from,
>> -                                  QTestState *to,
>> -                                  bool mismatch)
>> +migrate_tls_psk_start_common(QTestState *from,
>> +                             QTestState *to,
>> +                             bool mismatch)
>>  {
>>      struct TestMigrateTLSPSKData *data =3D
>>          g_new0(struct TestMigrateTLSPSKData, 1);
>> @@ -964,23 +964,23 @@ test_migrate_tls_psk_start_common(QTestState *from,
>>  }
>>=20=20
>>  static void *
>> -test_migrate_tls_psk_match_start(QTestState *from,
>> -                                 QTestState *to)
>> +migrate_tls_psk_match_start(QTestState *from,
>> +                            QTestState *to)
>
> My inclination is usually to go from most general, to
> most specific, left-to-right. I think it is also worth
> distinguishing these functions as hooks, which would
> suggest:
>
>   migrate_hook_start_psk_match
>
> That makes it easy to identify all hooks by grepping
> for 'migrate_hook', or identify all start hooks by
> grepping 'migrate_hook_start', or all PSK start
> hooks with 'migrate_hook_star_psk'.
>

Sure, I don't have a preference, as long as it's consistent.

>
> With regards,
> Daniel

