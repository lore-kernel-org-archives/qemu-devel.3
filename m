Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2291AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 20:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2zeX-0006lQ-3f; Fri, 03 May 2024 16:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2zeV-0006kz-Dp
 for qemu-devel@nongnu.org; Fri, 03 May 2024 16:37:07 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2zeT-00074I-98
 for qemu-devel@nongnu.org; Fri, 03 May 2024 16:37:07 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6EE622076C;
 Fri,  3 May 2024 20:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714768623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xVbxsDQa1IIouj456CRRZQa8J9DRWGbPSy5vWB3h42A=;
 b=kF9A0f8uGRSjbo72jEnyopE0ETC0uEXVrHx0TyqzcCkW/Et8YTEFnmI7ESM1g9iz9irqTk
 dpWDIuXRxMzgOAOO4bmk735J+O7ncl2xMlKzyE31si75NCEVdrBdhoIzjlx6/wd0aV8eGu
 Se5R0Tz7ZTK7/e76jEdbInZkXDqrwDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714768623;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xVbxsDQa1IIouj456CRRZQa8J9DRWGbPSy5vWB3h42A=;
 b=h+jCfdxyIXWFmjrcKguSwRzKFUSMf/KzHF0+UZCkOaotPpA0FApvj64Ntl3F+cvCMHgrCi
 0nLkrvWkYrri2PCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jCs3KljG;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zb2uu+7j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714768622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xVbxsDQa1IIouj456CRRZQa8J9DRWGbPSy5vWB3h42A=;
 b=jCs3KljGc3eP7rO5/XCh+3elqPLMRgRqhJq3CpLA0pLUL/q9wl0faVhu5qFQTJ/UJ8RswT
 5vAsmMdQJMHBckZT9+FHGjUbwEtnk+Q+dZ3sE4RXrqStHDKAmxFWv+ZfgyyR7ddHhhL+ax
 A83jFm2Ms3Fo29Caec9Q3thnQqaPbYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714768622;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xVbxsDQa1IIouj456CRRZQa8J9DRWGbPSy5vWB3h42A=;
 b=zb2uu+7jUIADzCsmlRoZflQXQCqzoYfhDq2KWJjeIh0xQW+jxVN6DCFOSBDFaT/OG2bZJe
 fsQ0tC9F2OQD72CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB47013991;
 Fri,  3 May 2024 20:37:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id D4VwK+1KNWaHBgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 03 May 2024 20:37:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH 3/9] tests/qtest/migration: Fix file migration offset check
In-Reply-To: <ZjUVKEJq7LBU57Rf@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-4-farosas@suse.de> <ZjUVKEJq7LBU57Rf@x1n>
Date: Fri, 03 May 2024 17:36:59 -0300
Message-ID: <874jbeocno.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6EE622076C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 DKIM_TRACE(0.00)[suse.de:+]
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

> On Fri, Apr 26, 2024 at 11:20:36AM -0300, Fabiano Rosas wrote:
>> When doing file migration, QEMU accepts an offset that should be
>> skipped when writing the migration stream to the file. The purpose of
>> the offset is to allow the management layer to put its own metadata at
>> the start of the file.
>> 
>> We have tests for this in migration-test, but only testing that the
>> migration stream starts at the correct offset and not that it actually
>> leaves the data intact. Unsurprisingly, there's been a bug in that
>> area that the tests didn't catch.
>> 
>> Fix the tests to write some data to the offset region and check that
>> it's actually there after the migration.
>> 
>> Fixes: 3dc35470c8 ("tests/qtest: migration-test: Add tests for file-based migration")
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration-test.c | 70 +++++++++++++++++++++++++++++++++---
>>  1 file changed, 65 insertions(+), 5 deletions(-)
>> 
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 5d6d8cd634..7b177686b4 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -2081,6 +2081,63 @@ static void test_precopy_file(void)
>>      test_file_common(&args, true);
>>  }
>>  
>> +#ifndef _WIN32
>> +static void file_dirty_offset_region(void)
>> +{
>> +#if defined(__linux__)
>
> Hmm, what's the case to cover when !_WIN32 && __linux__?  Can we remove one
> layer of ifdef?
>
> I'm also wondering why it can't work on win32?  I thought win32 has all
> these stuff we used here, but I may miss something.
>

__linux__ is because of mmap, !_WIN32 is because of the passing of
fds. We might be able to keep !_WIN32 only, I'll check.

>> +    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
>> +    size_t size = FILE_TEST_OFFSET;
>> +    uintptr_t *addr, *p;
>> +    int fd;
>> +
>> +    fd = open(path, O_CREAT | O_RDWR, 0660);
>> +    g_assert(fd != -1);
>> +
>> +    g_assert(!ftruncate(fd, size));
>> +
>> +    addr = mmap(NULL, size, PROT_WRITE, MAP_SHARED, fd, 0);
>> +    g_assert(addr != MAP_FAILED);
>> +
>> +    /* ensure the skipped offset contains some data */
>> +    p = addr;
>> +    while (p < addr + FILE_TEST_OFFSET / sizeof(uintptr_t)) {
>> +        *p = (unsigned long) FILE_TEST_FILENAME;
>
> This is fine, but not as clear what is assigned..  I think here we assigned
> is the pointer pointing to the binary's RO section (rather than the chars).

Haha you're right, I was assigning the FILE_TEST_OFFSET previously and
just switched to the FILENAME without thinking. I'll fix it up.

> Maybe using some random numbers would be more straightforward, but no
> strong opinions.
>
>> +        p++;
>> +    }
>> +
>> +    munmap(addr, size);
>> +    fsync(fd);
>> +    close(fd);
>> +#endif
>> +}
>> +
>> +static void *file_offset_start_hook(QTestState *from, QTestState *to)
>> +{
>> +    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
>> +    int src_flags = O_WRONLY;
>> +    int dst_flags = O_RDONLY;
>> +    int fds[2];
>> +
>> +    file_dirty_offset_region();
>> +
>> +    fds[0] = open(file, src_flags, 0660);
>> +    assert(fds[0] != -1);
>> +
>> +    fds[1] = open(file, dst_flags, 0660);
>> +    assert(fds[1] != -1);
>> +
>> +    qtest_qmp_fds_assert_success(from, &fds[0], 1, "{'execute': 'add-fd', "
>> +                                 "'arguments': {'fdset-id': 1}}");
>> +
>> +    qtest_qmp_fds_assert_success(to, &fds[1], 1, "{'execute': 'add-fd', "
>> +                                 "'arguments': {'fdset-id': 1}}");
>> +
>> +    close(fds[0]);
>> +    close(fds[1]);
>> +
>> +    return NULL;
>> +}
>> +
>>  static void file_offset_finish_hook(QTestState *from, QTestState *to,
>>                                      void *opaque)
>>  {
>> @@ -2096,12 +2153,12 @@ static void file_offset_finish_hook(QTestState *from, QTestState *to,
>>      g_assert(addr != MAP_FAILED);
>>  
>>      /*
>> -     * Ensure the skipped offset contains zeros and the migration
>> -     * stream starts at the right place.
>> +     * Ensure the skipped offset region's data has not been touched
>> +     * and the migration stream starts at the right place.
>>       */
>>      p = addr;
>>      while (p < addr + FILE_TEST_OFFSET / sizeof(uintptr_t)) {
>> -        g_assert(*p == 0);
>> +        g_assert_cmpstr((char *) *p, ==, FILE_TEST_FILENAME);
>>          p++;
>>      }
>>      g_assert_cmpint(cpu_to_be64(*p) >> 32, ==, QEMU_VM_FILE_MAGIC);
>> @@ -2113,17 +2170,18 @@ static void file_offset_finish_hook(QTestState *from, QTestState *to,
>>  
>>  static void test_precopy_file_offset(void)
>>  {
>> -    g_autofree char *uri = g_strdup_printf("file:%s/%s,offset=%d", tmpfs,
>> -                                           FILE_TEST_FILENAME,
>> +    g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
>>                                             FILE_TEST_OFFSET);
>
> Do we want to keep both tests to cover both normal file and fdsets?
>

I think the fdset + offset is the most complex in terms of requirements,
so I don't think we need to test the other one.

I'm actually already a bit concerned about the amount of tests we
have. I was even thinking of starting playing with some code coverage
tools and prune some of the tests if possible.

>>      MigrateCommon args = {
>>          .connect_uri = uri,
>>          .listen_uri = "defer",
>> +        .start_hook = file_offset_start_hook,
>>          .finish_hook = file_offset_finish_hook,
>>      };
>>  
>>      test_file_common(&args, false);
>>  }
>> +#endif
>>  
>>  static void test_precopy_file_offset_bad(void)
>>  {
>> @@ -3636,8 +3694,10 @@ int main(int argc, char **argv)
>>  
>>      migration_test_add("/migration/precopy/file",
>>                         test_precopy_file);
>> +#ifndef _WIN32
>>      migration_test_add("/migration/precopy/file/offset",
>>                         test_precopy_file_offset);
>> +#endif
>>      migration_test_add("/migration/precopy/file/offset/bad",
>>                         test_precopy_file_offset_bad);
>>  
>> -- 
>> 2.35.3
>> 

