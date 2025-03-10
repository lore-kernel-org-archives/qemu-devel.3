Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDD4C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trecM-00027x-SN; Mon, 10 Mar 2025 11:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1trec8-00022M-6d
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:00:23 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1trec6-00055M-4S
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:00:19 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 71BEE1F387;
 Mon, 10 Mar 2025 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741618814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FKIj5ahfcwF7PtWoFFei8wOioIbURtYulKxbN8cwDp8=;
 b=l3URDviXPannmkmUifZEAVnUBF0W2X0baHkQB4DgvnixwCUrCDZNrIKUXhjuIZZ16+iKHx
 aqWtoHzRDzWm8X2ZwXL2/lP/1PNlsVgPc8QwoViF4lH6fYwOMREd/26Hn+a4cwsT/WRtbU
 oPC1tXVonM2Wur5QvDQFvR4M1npHgxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741618814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FKIj5ahfcwF7PtWoFFei8wOioIbURtYulKxbN8cwDp8=;
 b=nGrsX+pgbyOCb/uq/AI7Eu1PtgxtPLGmKlihiOpDJmayeg1s1zu5QsA3tGhkYXKBiJcsRR
 IenyJdtOMgQrxhCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=l3URDviX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nGrsX+pg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741618814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FKIj5ahfcwF7PtWoFFei8wOioIbURtYulKxbN8cwDp8=;
 b=l3URDviXPannmkmUifZEAVnUBF0W2X0baHkQB4DgvnixwCUrCDZNrIKUXhjuIZZ16+iKHx
 aqWtoHzRDzWm8X2ZwXL2/lP/1PNlsVgPc8QwoViF4lH6fYwOMREd/26Hn+a4cwsT/WRtbU
 oPC1tXVonM2Wur5QvDQFvR4M1npHgxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741618814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FKIj5ahfcwF7PtWoFFei8wOioIbURtYulKxbN8cwDp8=;
 b=nGrsX+pgbyOCb/uq/AI7Eu1PtgxtPLGmKlihiOpDJmayeg1s1zu5QsA3tGhkYXKBiJcsRR
 IenyJdtOMgQrxhCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBC7A139E7;
 Mon, 10 Mar 2025 15:00:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AQz/JX3+zmf7QgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 10 Mar 2025 15:00:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "stefanha@gmail.com" <stefanha@gmail.com>
Subject: Re: [PULL 8/8] migration: Add qtest for migration over RDMA
In-Reply-To: <e9d7960d-f6ca-4322-a469-0d953d7dbfa7@fujitsu.com>
References: <20250307181551.19887-1-farosas@suse.de>
 <20250307181551.19887-9-farosas@suse.de>
 <4ce8e8e0-3aee-41dd-b1fb-ac9398b0c1d6@linaro.org>
 <e9d7960d-f6ca-4322-a469-0d953d7dbfa7@fujitsu.com>
Date: Mon, 10 Mar 2025 12:00:11 -0300
Message-ID: <87h641szgk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 71BEE1F387
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_EQ_ADDR_SOME(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:mid, suse.de:dkim]
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

"Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org> writes:

> Hi Philippe,
>
> Thanks for your testing.
>
>
> On 08/03/2025 14:00, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi,
>>=20
>> On 7/3/25 19:15, Fabiano Rosas wrote:
>>> From: Li Zhijian <lizhijian@fujitsu.com>
>>>
>>> This qtest requires there is a RDMA(RoCE) link in the host.
>>> In order to make the test work smoothly, introduce a
>>> scripts/rdma-migration-helper.sh to
>>> - setup a new Soft-RoCE(aka RXE) if it's root
>>> - detect existing RoCE link
>>>
>>> Test will be skipped if there is no available RoCE link.
>>=20
>> Is it? Runing as user I'm getting:
>>=20
>>  =C2=A0 RDMA ERROR: RDMA host is not set!
>
>
> It's unexpected behavior.
>
> It implies that the script terminated successfully with an exit
> code of 0(there is a RDMA link), yet failed to display its canonical
> IPv4 address.
>
> Stefan also mentioned the same error...
> https://gitlab.com/qemu-project/qemu/-/jobs/9350004599#L5590
>
> I couldn't reproduce your error.
>
> Could you share the output of this script with a normal user,
> $ scripts/rdma-migration-helper.sh detect
>
> if your had a rdma/RXE link, please share the output of its ip
> $ ip -4 -o addr show dev <NIC>
>
> Where the <NIC> is an interface associated with the RoCE(RXE), for example
>
> $ rdma link
> link enp2s0_rxe/1 state ACTIVE physical_state LINK_UP netdev enp2s0
>
> then the <NIC> is enp2s0
>
>
>>=20
>> Apparently called via:
>>=20
>> qemu_start_incoming_migration()
>>  =C2=A0 -> rdma_start_incoming_migration()
>>  =C2=A0=C2=A0=C2=A0=C2=A0 -> qemu_rdma_dest_init()
>>=20
>>> =C2=A0 # Start of rdma tests
>>> =C2=A0 # Running /x86_64/migration/precopy/rdma/plain
>>> =C2=A0 Command 'rdma' is not available, please install it first.
>>> =C2=A0 # To enable the test:
>>> =C2=A0 # (1) Run 'scripts/rdma-migration-helper.sh setup' with root and=
 rerun the test
>>> =C2=A0 # or
>>> =C2=A0 # (2) Run the test with root privilege
>>=20
>> Could this might be the issue, should we skip if not root, as calling
>> the script in "detect" mode makes the new_rdma_link() method to succeed.
>
> It's expected the 'detect' should succeed and print a IPv4 address
>
>>=20
>>> =C2=A0 #
>>> =C2=A0 ok 1 /x86_64/migration/precopy/rdma/plain # SKIP No rdma link av=
ailable
>>> =C2=A0 # End of rdma tests
>>>
>>> Note: Remove the newly added RXE link by executing 'modprobe -r rdma_rx=
e'
>>> or by specifying 'clean' within this script.
>>=20
>> qtest_add() provides both setup() / teardown() methods.>=20
>
> This may require a minor refactor of the migration-test framework to
> enable support for setup() and teardown() methods.
>
> Let me see...
>
>
>
>> Test leaving system in different state seems bogus to me.
>
> At this point, I'm unable to refute. It indeed dirty the
> It indeed might dirty the system.
>
>
> A palatable compromise might be that, regardless of whether one is a
> root user or not, this test is only supported on hosts with RDMA link.
>
> Otherwise, it will provide an SKIP warning.
>
>       # Run 'scripts/rdma-migration-helper.sh setup' with root and rerun =
the test
>       # Optional: run 'scripts/rdma-migration-helper.sh clean' to revert =
the 'setup'
>
> For local users, they can independently use this script to set up and cle=
an RDMA,
> as they are aware of the modifications they have made to the system.

Yes, let's skip it unless the user has very explicitly set things up.


