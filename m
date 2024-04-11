Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA5FC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 19:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv0IY-0005ZZ-B1; Thu, 11 Apr 2024 15:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rv0IW-0005Xi-A8
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 15:41:24 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rv0IU-0002V7-OH
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 15:41:24 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 914525D466;
 Thu, 11 Apr 2024 19:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712864480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dR60/7dgmjyGmUq58mXfEII1qn2Sqwvt3JT0XX49U3g=;
 b=ZDSiMIv4x+2n3y/tJgCKdUDzV9sWBmNXv7vIy20x8qZ4fNBAMOTwT3HrTloVEWUMW5u54F
 FhM29yztK+arSk+fGIYW4jjGxCFgmg7ydu0zxVeeljXEihqZiBK/gDsseSqRWWozBIxOEN
 qZBSWtna/trdXSh+reM42ft4aP8/L4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712864480;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dR60/7dgmjyGmUq58mXfEII1qn2Sqwvt3JT0XX49U3g=;
 b=tZTxJBxTFrxYc0sPzivDO3Qk0KyxEucZTcuP9Vr39DFZooGV5XZqRRJ10rwC0kQl5IPGfK
 Z/aRH26Yt6DO8QBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1712864480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dR60/7dgmjyGmUq58mXfEII1qn2Sqwvt3JT0XX49U3g=;
 b=ZDSiMIv4x+2n3y/tJgCKdUDzV9sWBmNXv7vIy20x8qZ4fNBAMOTwT3HrTloVEWUMW5u54F
 FhM29yztK+arSk+fGIYW4jjGxCFgmg7ydu0zxVeeljXEihqZiBK/gDsseSqRWWozBIxOEN
 qZBSWtna/trdXSh+reM42ft4aP8/L4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1712864480;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dR60/7dgmjyGmUq58mXfEII1qn2Sqwvt3JT0XX49U3g=;
 b=tZTxJBxTFrxYc0sPzivDO3Qk0KyxEucZTcuP9Vr39DFZooGV5XZqRRJ10rwC0kQl5IPGfK
 Z/aRH26Yt6DO8QBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16DB013685;
 Thu, 11 Apr 2024 19:41:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tD/UM988GGagKgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 11 Apr 2024 19:41:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, prerna.saxena@nutanix.com
Subject: Re: [PATCH 1/4] Revert "migration: modify test_multifd_tcp_none()
 to use new QAPI syntax"
In-Reply-To: <ZhgvAicT_36OLEBR@x1n>
References: <20240410111541.188504-1-het.gala@nutanix.com>
 <20240410111541.188504-2-het.gala@nutanix.com> <874jc9v066.fsf@suse.de>
 <Zhan0Brg_CXzt79-@x1n> <8621e850-168a-454a-8f00-615f476eac31@nutanix.com>
 <ZhfzMt3t2oU7qt90@x1n> <e0f41009-a2bc-4302-82d5-c396d95a5cff@nutanix.com>
 <ZhgvAicT_36OLEBR@x1n>
Date: Thu, 11 Apr 2024 16:41:16 -0300
Message-ID: <87le5jbsbn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> On Thu, Apr 11, 2024 at 11:31:08PM +0530, Het Gala wrote:
>> I just wanted to highlight couple of pointers:
>> 1. though we are using 'channels' in the precopy tests for 'migrate' QAP=
I,
>> we
>> =C2=A0=C2=A0 use the old uri for 'migrate-incoming' QAPI.
>> 2. We do not cover other 'channels' abi, only have tcp path tested.
>>=20
>> So, the TO-DOs could be:
>> 1. Omit the 4th patch here, which introduced postcopy qtests with 'chann=
els'
>> =C2=A0=C2=A0 interface OR have 'channels' interface with other than tcp =
transport
>> =C2=A0=C2=A0 (file, exec, vsock, etc) so as to cover different code path=
s.
>> 2. Extend channels interface to migrate-incoming QAPI for precopy qtests
>
> You can see whether Fabiano has anything to say, but what you proposed
> looks good to me.

Ok, so what about we convert some of the 'plain' tests into channels to
cover all transports?

- tcp: test_multifd_tcp_none  (this one we already did)
- file: test_precopy_file
- unix: test_precopy_unix_plain
- exec: test_analyze_script
- fd: test_migrate_precopy_fd_socket

Those^, plus the validate_uri that's already in next should cover
everything.

We don't need to do this at once, by the way.

Moreover:

- leave all test strings untouched to preserve bisecting;

- let's not bother adding "channels" and "uri" to the test string
  anymore. The channels API should be taken for granted at this point, I
  don't expect we start hitting bugs that will require us to run either
  foo/uri/plain or foo/channels/plain, so there's not much point in
  making the distinction.

