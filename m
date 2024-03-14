Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B44C54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 16:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkoMm-0005Aq-2h; Thu, 14 Mar 2024 12:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rkoMk-0005Af-Fx
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 12:55:38 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rkoMi-00031G-Kl
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 12:55:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 187001F390;
 Thu, 14 Mar 2024 16:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710435334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Va8Ff8W60MH2/OX9Amrlru4JMeElDW4neFCyR6Towk=;
 b=T0uqRrFfgE4r7qvzH0n1nv3ExfI9JwTrvZoofO/sqqzVTgDt4l+617rZ/HrmCdS9Ap4Pzm
 eiOrlyMSRLXOtj8SnsD6BC9qmX8IypR948Z9E8LWqg2NVJww8/z/cLWL60M961YdmpK7Lv
 AV4F5rmVfJ6KpOnhoand1vg6Y0YhROo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710435334;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Va8Ff8W60MH2/OX9Amrlru4JMeElDW4neFCyR6Towk=;
 b=/laARfGY38MUTHLD+nbGXt/6n2BNGWp1BBUz34r1/BpRuf32sTAWrbRLQOwvBY1ecZ7Mxk
 snsqbKjJ0gK5oVCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710435334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Va8Ff8W60MH2/OX9Amrlru4JMeElDW4neFCyR6Towk=;
 b=T0uqRrFfgE4r7qvzH0n1nv3ExfI9JwTrvZoofO/sqqzVTgDt4l+617rZ/HrmCdS9Ap4Pzm
 eiOrlyMSRLXOtj8SnsD6BC9qmX8IypR948Z9E8LWqg2NVJww8/z/cLWL60M961YdmpK7Lv
 AV4F5rmVfJ6KpOnhoand1vg6Y0YhROo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710435334;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Va8Ff8W60MH2/OX9Amrlru4JMeElDW4neFCyR6Towk=;
 b=/laARfGY38MUTHLD+nbGXt/6n2BNGWp1BBUz34r1/BpRuf32sTAWrbRLQOwvBY1ecZ7Mxk
 snsqbKjJ0gK5oVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96FDE1368C;
 Thu, 14 Mar 2024 16:55:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9l86FwUs82XLRgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 14 Mar 2024 16:55:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v2 0/2] migration mapped-ram fixes
In-Reply-To: <ZfMWRBDN4wPQsOWI@x1n>
References: <20240313212824.16974-1-farosas@suse.de> <ZfMWRBDN4wPQsOWI@x1n>
Date: Thu, 14 Mar 2024 13:55:31 -0300
Message-ID: <87plvwvjlo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.985];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Mar 13, 2024 at 06:28:22PM -0300, Fabiano Rosas wrote:
>> Hi,
>> 
>> In this v2:
>> 
>> patch 1 - The fix for the ioc leaks, now including the main channel
>> 
>> patch 2 - A fix for an fd: migration case I thought I had written code
>>           for, but obviously didn't.
>
> Maybe I found one more issue.. I'm looking at fd_start_outgoing_migration().
>
>     ioc = qio_channel_new_fd(fd, errp);  <----- here the fd is consumed and
>                                                 then owned by the IOC
>     if (!ioc) {
>         close(fd);
>         return;
>     }
>
>     outgoing_args.fd = fd;               <----- here we use the fd again,
>                                                 and "owned" by outgoing_args
>                                                 even if it shouldn't?
>
> The problem is outgoing_args.fd will be cleaned up with a close().  I had a
> feeling that it's possible it will close() something else if the fd reused
> before that close() but after the IOC's.  We may want yet another dup() for
> outgoing_args.fd?

I think the right fix is to not close() it at
fd_cleanup_outgoing_migration(). That fd is already owned by the ioc.

>
> If you agree, we may also want to avoid doing:
>
>     outgoing_args.fd = -1;

We will always need this. This is just initialization of the field
because 0 is a valid fd value. Otherwise the file.c code can't know if
we're actually using an fd at all.

@file_send_channel_create:

int fd = fd_args_get_fd();

if (fd && fd != -1) {
    <new IOC from fd>
} else {
    <new IOC from file name>
}

>
> We could assert it instead making sure no fd leak.
>
>> 
>> Thank you for your patience.
>> 
>> based-on: https://gitlab.com/peterx/qemu/-/commits/migration-stable
>> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1212483701
>> 
>> Fabiano Rosas (2):
>>   migration: Fix iocs leaks during file and fd migration
>>   migration/multifd: Ensure we're not given a socket for file migration
>> 
>>  migration/fd.c   | 35 +++++++++++---------------
>>  migration/file.c | 65 ++++++++++++++++++++++++++++++++----------------
>>  migration/file.h |  1 +
>>  3 files changed, 60 insertions(+), 41 deletions(-)
>> 
>> -- 
>> 2.35.3
>> 

