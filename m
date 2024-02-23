Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85072C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 14:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdWd7-0008Qy-2G; Fri, 23 Feb 2024 09:34:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rdWRP-0003vH-NY
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 09:22:19 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rdWRO-0007QD-0H
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 09:22:19 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5586D1F79C;
 Fri, 23 Feb 2024 14:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708698136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rFl5yzktf5HUlYVWtBAvteQR2gUC7/3MKNZiD55SCT0=;
 b=MPLEppLB5fLUvuK6TRmhrnBD6thQ4J5FZ2EwTuH2LhwnoToSj5HMxW7iXr0urWep9KjE1A
 FsWTx9R3za8ePAWtvFpIcc/CTzxuv3qZpxABG5oakc18KnHUZHjt7l88Y9vQ8Cfmx75ig2
 u2OyE2dh5pFmPSVR0qXlc5BiWaXsUDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708698136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rFl5yzktf5HUlYVWtBAvteQR2gUC7/3MKNZiD55SCT0=;
 b=SLZC3MEpAvYBZarFKqNONoOFJ59w7yOhuQW4HdDSU6NBYqCMpaP82kPCjixvrBzq16RvMe
 8aLGc+qbAHkDU3Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708698136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rFl5yzktf5HUlYVWtBAvteQR2gUC7/3MKNZiD55SCT0=;
 b=MPLEppLB5fLUvuK6TRmhrnBD6thQ4J5FZ2EwTuH2LhwnoToSj5HMxW7iXr0urWep9KjE1A
 FsWTx9R3za8ePAWtvFpIcc/CTzxuv3qZpxABG5oakc18KnHUZHjt7l88Y9vQ8Cfmx75ig2
 u2OyE2dh5pFmPSVR0qXlc5BiWaXsUDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708698136;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rFl5yzktf5HUlYVWtBAvteQR2gUC7/3MKNZiD55SCT0=;
 b=SLZC3MEpAvYBZarFKqNONoOFJ59w7yOhuQW4HdDSU6NBYqCMpaP82kPCjixvrBzq16RvMe
 8aLGc+qbAHkDU3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0026133DC;
 Fri, 23 Feb 2024 14:22:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E4OTJReq2GWLEgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Feb 2024 14:22:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 00/34] migration: File based migration with multifd
 and fixed-ram
In-Reply-To: <ZdgKJgxUqb1DrzRt@x1n>
References: <20240220224138.24759-1-farosas@suse.de> <ZdgKJgxUqb1DrzRt@x1n>
Date: Fri, 23 Feb 2024 11:22:12 -0300
Message-ID: <87a5nr9s6j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.46 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-1.16)[88.81%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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

> On Tue, Feb 20, 2024 at 07:41:04PM -0300, Fabiano Rosas wrote:
>> Latest numbers
>> ==============
>> 
>> => guest: 128 GB RAM - 120 GB dirty - 1 vcpu in tight loop dirtying memory
>> => host: 128 CPU AMD EPYC 7543 - 2 NVMe disks in RAID0 (8586 MiB/s) - xfs
>> => pinned vcpus w/ NUMA shortest distances - average of 3 runs - results
>>    from query-migrate
>> 
>> non-live           | time (ms)   pages/s   mb/s   MB/s
>> -------------------+-----------------------------------
>> file               |    110512    256258   9549   1193
>>   + bg-snapshot    |    245660    119581   4303    537
>
> Is this the one using userfault?  I'm surprised it's much slower when
> enabled; logically for a non-live snapshot it should take similar loops
> like a normal migration as it should have zero faults, then it should be
> similar performance.

I just enabled the background-snapshot capability. Is there extra setup
that must be done to enable this properly? The ufd_version_check from
migration-test returns true on this system.

>> -------------------+-----------------------------------
>> fixed-ram          |    157975    216877   6672    834
>>   + multifd 8 ch.  |     95922    292178  10982   1372
>>      + direct-io   |     23268   1936897  45330   5666
>> -------------------------------------------------------
>> 
>> live               | time (ms)   pages/s   mb/s   MB/s
>> -------------------+-----------------------------------
>> file               |         -         -      -      - (file grew 4x the VM size)
>>   + bg-snapshot    |    357635    141747   2974    371
>> -------------------+-----------------------------------
>> fixed-ram          |         -         -      -      - (no convergence in 5 min)
>>   + multifd 8 ch.  |    230812    497551  14900   1862
>>      + direct-io   |     27475   1788025  46736   5842
>> -------------------------------------------------------
>
> Also surprised on direct-io too.. that is definitely something tremendous.

Indeed. That was the intention with this series all along after all.

