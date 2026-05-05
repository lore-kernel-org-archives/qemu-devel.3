Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383C6FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 19:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKLAx-0000wm-AA; Tue, 05 May 2026 15:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKLAt-0000wE-DJ
 for qemu-devel@nongnu.org; Tue, 05 May 2026 15:11:19 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKLAq-0005sH-RR
 for qemu-devel@nongnu.org; Tue, 05 May 2026 15:11:18 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F37975BCF9;
 Tue,  5 May 2026 19:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778008273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fgM+W49P1ntEyf1ZvxJd1pDpcn5MHLwIOANPkdQjjlw=;
 b=mOVCVCFBOvyzCs+v53kFXJMhBs4r6CPBL8an5NGH3ObNW+kr1pxRRKFiMHLua1hiVydBts
 DEBZqV2VzL49sxoyB7DcigyIFpvgNbReBkMJixaroI3Kx7DH+DQ3lzF/mgpEoxPRaTvawE
 HTTy2EWFRgQS4fRG3QOpdV4bywJWKZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778008273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fgM+W49P1ntEyf1ZvxJd1pDpcn5MHLwIOANPkdQjjlw=;
 b=usnk47Exb8HNcfxohuluzUnIWIniU+cLJXDrtXoEDcNNSqGG68GCJh4+BtAhXA1pvdmYQG
 w6mVi6MkgKRUWQAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ssm++RlX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=k6X6rKbm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778008272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fgM+W49P1ntEyf1ZvxJd1pDpcn5MHLwIOANPkdQjjlw=;
 b=ssm++RlX5HAq9K15lPHibNeu5rRe+PmaZsD4Dm7d/5azTq1SQncsMUXeyAc+1nfpL432nh
 /JPRVLiwpfFDUtByii1piy8urgU15ttbORPKCa7csHAwV4Plbr6iYU0MdgyHFn8rJEVSvf
 ZAXpG81bBQMvjZywU7sltQh+LZ79j7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778008272;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fgM+W49P1ntEyf1ZvxJd1pDpcn5MHLwIOANPkdQjjlw=;
 b=k6X6rKbmzDuH8mwbvWpuAWMrD05OVR2VV63ltneLOqwT25fnHLE2/sSt1xV6NPelN2txQx
 sXLr1CjxRiiWQqDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 927C5593A3;
 Tue,  5 May 2026 19:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I3PgGM9A+mncJQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 May 2026 19:11:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Jared Rossi
 <jrossi@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Eric Farman
 <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH v1] tests/qtest/migration: Fix A-B file build
In-Reply-To: <afoeaRAxWSMO_gK5@x1.local>
References: <20260429231025.30818-1-farosas@suse.de>
 <afoeaRAxWSMO_gK5@x1.local>
Date: Tue, 05 May 2026 16:11:09 -0300
Message-ID: <87se85y8mq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 MID_RHS_MATCH_FROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F37975BCF9
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Apr 29, 2026 at 08:10:25PM -0300, Fabiano Rosas wrote:
>> diff --git a/tests/qtest/migration/bootfile.h b/tests/qtest/migration/bootfile.h
>> index 96e784b163..0ce5b34433 100644
>> --- a/tests/qtest/migration/bootfile.h
>> +++ b/tests/qtest/migration/bootfile.h
>> @@ -8,6 +8,15 @@
>>  #ifndef BOOTFILE_H
>>  #define BOOTFILE_H
>>  
>> +/*
>> + * This file is included from qtest, but also from the assembly code
>> + * that generates the header file containing the guest workload. Don't
>> + * expose the function declarations and non-standard types to it.
>> + */
>> +#ifdef __ASSEMBLER__
>> +#define MIGRATION_GUEST_CODE
>> +#endif
>
> Just to mention: this triggers a checkpatch warning (I only notice this
> when running checkpatch locally; CI is fine with warnings), which seems to
> be false positive.
>
> But still, I wonder whether we need this at all. IIUC we can also put those
> into a separate smaller header and include that here, then use that one for
> arch a-b-bios builds.
>
> Even if it will work, we can leave it for later.
>

I have a bunch of patches adding code into bootfile.c and consequently
bootfile.h for the stress.c and hugepages work I told you about. We can
discuss the header structure when I send them, if you don't mind.

>> +
>>  /* Common */
>>  #define TEST_MEM_PAGE_SIZE 4096
>>  
>> @@ -33,8 +42,10 @@
>>   */
>>  #define ARM_TEST_MAX_KERNEL_SIZE (512 * 1024)
>>  
>> +#ifndef MIGRATION_GUEST_CODE
>>  void bootfile_delete(void);
>>  char *bootfile_create(const char *arch, const char *dir, bool suspend_me);
>>  char *bootfile_get(void);
>> +#endif

