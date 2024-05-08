Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC3FC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 08:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4cNZ-0001g5-Og; Wed, 08 May 2024 04:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4cNV-0001f9-KW
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:10:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4cNS-0001Qc-QO
 for qemu-devel@nongnu.org; Wed, 08 May 2024 04:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715155813;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SCqAYfsobavvaZmjXP87PdP/8lZ0MEZ+fgvf0byLdKs=;
 b=grAfBKxCafW22X/dLpjQAP5A2yBQFeWoFUlTidAMnKck+3O+pba83kQR+piKYfLBg+HpzE
 rY1O3isqUqNtZcuTu2KZ5QlC2zpOjmRLEu37blaXvg16DAdxvl+6viy3nV3PsShZtgbmbo
 oI1jLDFwUteldqu21CqKDsB73tzFEmk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-j9ewiadFPwCVovvnsePF5Q-1; Wed, 08 May 2024 04:10:10 -0400
X-MC-Unique: j9ewiadFPwCVovvnsePF5Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D38608016F6;
 Wed,  8 May 2024 08:10:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65588492CAB;
 Wed,  8 May 2024 08:10:08 +0000 (UTC)
Date: Wed, 8 May 2024 09:10:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/9] tests/qtest/migration: Fix file migration offset check
Message-ID: <ZjszXofTjB-dOOMo@redhat.com>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-4-farosas@suse.de> <ZjUVKEJq7LBU57Rf@x1n>
 <874jbeocno.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874jbeocno.fsf@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 03, 2024 at 05:36:59PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Apr 26, 2024 at 11:20:36AM -0300, Fabiano Rosas wrote:
> >> When doing file migration, QEMU accepts an offset that should be
> >> skipped when writing the migration stream to the file. The purpose of
> >> the offset is to allow the management layer to put its own metadata at
> >> the start of the file.
> >> 
> >> We have tests for this in migration-test, but only testing that the
> >> migration stream starts at the correct offset and not that it actually
> >> leaves the data intact. Unsurprisingly, there's been a bug in that
> >> area that the tests didn't catch.
> >> 
> >> Fix the tests to write some data to the offset region and check that
> >> it's actually there after the migration.
> >> 
> >> Fixes: 3dc35470c8 ("tests/qtest: migration-test: Add tests for file-based migration")
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  tests/qtest/migration-test.c | 70 +++++++++++++++++++++++++++++++++---
> >>  1 file changed, 65 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> >> index 5d6d8cd634..7b177686b4 100644
> >> --- a/tests/qtest/migration-test.c
> >> +++ b/tests/qtest/migration-test.c
> >> @@ -2081,6 +2081,63 @@ static void test_precopy_file(void)
> >>      test_file_common(&args, true);
> >>  }
> >>  
> >> +#ifndef _WIN32
> >> +static void file_dirty_offset_region(void)
> >> +{
> >> +#if defined(__linux__)
> >
> > Hmm, what's the case to cover when !_WIN32 && __linux__?  Can we remove one
> > layer of ifdef?
> >
> > I'm also wondering why it can't work on win32?  I thought win32 has all
> > these stuff we used here, but I may miss something.
> >
> 
> __linux__ is because of mmap, !_WIN32 is because of the passing of
> fds. We might be able to keep !_WIN32 only, I'll check.
> 
> >> +    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
> >> +    size_t size = FILE_TEST_OFFSET;
> >> +    uintptr_t *addr, *p;
> >> +    int fd;
> >> +
> >> +    fd = open(path, O_CREAT | O_RDWR, 0660);
> >> +    g_assert(fd != -1);
> >> +
> >> +    g_assert(!ftruncate(fd, size));
> >> +
> >> +    addr = mmap(NULL, size, PROT_WRITE, MAP_SHARED, fd, 0);
> >> +    g_assert(addr != MAP_FAILED);
> >> +
> >> +    /* ensure the skipped offset contains some data */
> >> +    p = addr;
> >> +    while (p < addr + FILE_TEST_OFFSET / sizeof(uintptr_t)) {
> >> +        *p = (unsigned long) FILE_TEST_FILENAME;
> >
> > This is fine, but not as clear what is assigned..  I think here we assigned
> > is the pointer pointing to the binary's RO section (rather than the chars).
> 
> Haha you're right, I was assigning the FILE_TEST_OFFSET previously and
> just switched to the FILENAME without thinking. I'll fix it up.
> 
> > Maybe using some random numbers would be more straightforward, but no
> > strong opinions.
> >
> >> +        p++;
> >> +    }
> >> +
> >> +    munmap(addr, size);
> >> +    fsync(fd);
> >> +    close(fd);
> >> +#endif
> >> +}


Use of mmap and this loop looks like overkill to me, when we can do
it in a fully portable manner with:

   g_autofree char *data = g_new0(char *, offset);
   memset(data, 0x44, offset);
   g_file_set_contents(path, data, offset, NULL);

and I checked that g_file_set_contents' impl also takes care of fsync.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


