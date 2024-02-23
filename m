Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A184EC54E41
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 14:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdWDr-0003ZD-57; Fri, 23 Feb 2024 09:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1rdVv1-0002GU-PJ
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:48:52 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1rdVv0-0007pZ-1d
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 08:48:51 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3C2E621228;
 Fri, 23 Feb 2024 13:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708696126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4nMuBBmidA/+rwVLIkJYi8NHFXTXlngsc2OgvHtFdY=;
 b=tqcI7BobCLIdLoTFhV5gtrulu2Oo6thGtgRG1KUDAy/+FbtUcVf6tPSMlu9I0zbTWLZGnu
 QzYiLGbBNyorvgLQhquIl5ulazKtnE/HM97k6Ekah93lrt1ZT3CohtG94TawRLl+lkjc1v
 YFCN6A4JiNQcKhIhNd8WWVTpVeI74Qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708696126;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4nMuBBmidA/+rwVLIkJYi8NHFXTXlngsc2OgvHtFdY=;
 b=JeiJLz2NOTAWigJTx6vdczj5Ky2gir31DJc3mEwX3+Jw9ekDVMSUMcrNu4VnVJdi+KebOC
 FXKCssGHVQKZu1DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708696126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4nMuBBmidA/+rwVLIkJYi8NHFXTXlngsc2OgvHtFdY=;
 b=tqcI7BobCLIdLoTFhV5gtrulu2Oo6thGtgRG1KUDAy/+FbtUcVf6tPSMlu9I0zbTWLZGnu
 QzYiLGbBNyorvgLQhquIl5ulazKtnE/HM97k6Ekah93lrt1ZT3CohtG94TawRLl+lkjc1v
 YFCN6A4JiNQcKhIhNd8WWVTpVeI74Qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708696126;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4nMuBBmidA/+rwVLIkJYi8NHFXTXlngsc2OgvHtFdY=;
 b=JeiJLz2NOTAWigJTx6vdczj5Ky2gir31DJc3mEwX3+Jw9ekDVMSUMcrNu4VnVJdi+KebOC
 FXKCssGHVQKZu1DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F08EA132C7;
 Fri, 23 Feb 2024 13:48:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m1vmOD2i2GW9CQAAD6G6ig
 (envelope-from <cfontana@suse.de>); Fri, 23 Feb 2024 13:48:45 +0000
Message-ID: <7e972804-8490-bfe4-6cc3-b926a91244ed@suse.de>
Date: Fri, 23 Feb 2024 14:48:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 00/34] migration: File based migration with multifd and
 fixed-ram
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com
References: <20240220224138.24759-1-farosas@suse.de> <ZdgKJgxUqb1DrzRt@x1n>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <ZdgKJgxUqb1DrzRt@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.35 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-1.05)[87.72%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.997];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=cfontana@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.533,
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

On 2/23/24 03:59, Peter Xu wrote:
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
> 
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
> 

Awesome! Can't wait to have this available for our customers.

Ciao,

Claudio



