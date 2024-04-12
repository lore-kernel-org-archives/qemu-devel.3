Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54D1C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 14:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvIMy-00015j-9J; Fri, 12 Apr 2024 10:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rvIMn-00014v-53
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:59:01 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rvIMj-0000ay-WB
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:59:00 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D417C5FE42;
 Fri, 12 Apr 2024 14:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712933931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RnLugBNvvuXUFF4w2ZmKO4UDb9kbtfcLjnmWLJ3F+A=;
 b=qs/9BMCXbh4i/GUzcgk8K+Xofah8mSkS9xdCAYzKUdYZ8molSLIEwUouipcRIdo+mMSLJZ
 vHiUsFdeCXS+GsbB8V9k+ePy1GwcgPO0t7zrnDeskGUiU/VMc2NUy5ZnQSo7ye5BmaOw6i
 VGZakMRt8SoZijOYu1tNK9uCCxelObU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712933931;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RnLugBNvvuXUFF4w2ZmKO4UDb9kbtfcLjnmWLJ3F+A=;
 b=N4iaYmzAJteAJLxXNti7CKosUGjwy23MAxexN03+38PYsNGu6waxcLlNKxeEKK7b+omSHT
 doTiLg1yjTM7OOAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lhA1ONWr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=x+evAVMg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712933930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RnLugBNvvuXUFF4w2ZmKO4UDb9kbtfcLjnmWLJ3F+A=;
 b=lhA1ONWrtCDBlIQO1IqNlsUe0afjwKd0UAJLdIiPaKMqOsiFC12Lad57Hce1gDlY4idqb3
 khhBTq9EYbsfxbtzYCv22YJej3FUn8GBsYEyy8H95rLixTsWh7OjHbREUjon7ExV8ZVvRg
 iOEFeyZbKAHq8lXI6kIDsjGKLbLY4Cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712933930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RnLugBNvvuXUFF4w2ZmKO4UDb9kbtfcLjnmWLJ3F+A=;
 b=x+evAVMg2yJPjW0dVEkbFYWyRo6KthbWuXiqw6twUfnV4gdeoDq/oui3HjikYKqc7EGPVp
 +SHPxo+4XJD2qdDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 589DB1368B;
 Fri, 12 Apr 2024 14:58:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dHhQBypMGWbtewAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 12 Apr 2024 14:58:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 prerna.saxena@nutanix.com
Subject: Re: [PATCH 1/4] Revert "migration: modify test_multifd_tcp_none()
 to use new QAPI syntax"
In-Reply-To: <ZhlCcPTnW_-V85qR@x1n>
References: <20240410111541.188504-1-het.gala@nutanix.com>
 <20240410111541.188504-2-het.gala@nutanix.com> <874jc9v066.fsf@suse.de>
 <Zhan0Brg_CXzt79-@x1n> <8621e850-168a-454a-8f00-615f476eac31@nutanix.com>
 <ZhfzMt3t2oU7qt90@x1n> <e0f41009-a2bc-4302-82d5-c396d95a5cff@nutanix.com>
 <ZhgvAicT_36OLEBR@x1n> <87le5jbsbn.fsf@suse.de> <ZhlCcPTnW_-V85qR@x1n>
Date: Fri, 12 Apr 2024 11:58:43 -0300
Message-ID: <87il0mbpb0.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D417C5FE42
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Apr 11, 2024 at 04:41:16PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>=20
>> > On Thu, Apr 11, 2024 at 11:31:08PM +0530, Het Gala wrote:
>> >> I just wanted to highlight couple of pointers:
>> >> 1. though we are using 'channels' in the precopy tests for 'migrate' =
QAPI,
>> >> we
>> >> =C2=A0=C2=A0 use the old uri for 'migrate-incoming' QAPI.
>> >> 2. We do not cover other 'channels' abi, only have tcp path tested.
>> >>=20
>> >> So, the TO-DOs could be:
>> >> 1. Omit the 4th patch here, which introduced postcopy qtests with 'ch=
annels'
>> >> =C2=A0=C2=A0 interface OR have 'channels' interface with other than t=
cp transport
>> >> =C2=A0=C2=A0 (file, exec, vsock, etc) so as to cover different code p=
aths.
>> >> 2. Extend channels interface to migrate-incoming QAPI for precopy qte=
sts
>> >
>> > You can see whether Fabiano has anything to say, but what you proposed
>> > looks good to me.
>>=20
>> Ok, so what about we convert some of the 'plain' tests into channels to
>> cover all transports?
>>=20
>> - tcp: test_multifd_tcp_none  (this one we already did)
>> - file: test_precopy_file
>> - unix: test_precopy_unix_plain
>> - exec: test_analyze_script
>> - fd: test_migrate_precopy_fd_socket
>>=20
>> Those^, plus the validate_uri that's already in next should cover
>> everything.
>>=20
>> We don't need to do this at once, by the way.
>>=20
>> Moreover:
>>=20
>> - leave all test strings untouched to preserve bisecting;
>>=20
>> - let's not bother adding "channels" and "uri" to the test string
>>   anymore. The channels API should be taken for granted at this point, I
>>   don't expect we start hitting bugs that will require us to run either
>>   foo/uri/plain or foo/channels/plain, so there's not much point in
>>   making the distinction.
>
> Do you mean we can put "uri:" aside?  Maybe I misunderstood..

I mean the test name does not need to specify "channels" vs. "uri"
because that should never be broken to the point that we actually need
to go fetch those tests by name. We'd still have at least 1 test for
each transport with channels and (existing) at least 1 test for each
transport with uri.

>
> The matrix previously was (I think.. when this series posted):
>
>   [tcp, unix, file, exec, fd] x [uri, channels] x [precopy, postcopy]
>
> Drop postcopy as doesn't seem to have any special paths:
>
>   [tcp, unix, file, exec, fd] x [uri, channels]
>
> So logically we should still cover these, right?

Right, I'm just suggesting we convert some tests to use channels, one
for each transport, to test the channels API in full. The rest of the
existing tests as well as future tests need not have a uri (or channel)
variant. Just one of them is enough.

