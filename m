Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C60D0EE0B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 22:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO1Xu-0004ct-Ke; Tue, 25 Nov 2025 17:30:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vO1Xs-0004Zv-Ks
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 17:30:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vO1Xp-000498-Lb
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 17:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764109796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V/UAoV+jMOM+PCf6ZH4kzVrKJeHi9vbgSHJE4fio42Q=;
 b=LfQv6K4gZL3k0VsxzjxbrT4GuafyH1ziAHqZA7kfxZtL/dGr9do2Cga+96goxslKxnW03D
 V52Gh6gCQ3L/C5udpEc37Am6VOEcOPQaXGqSqJQO+rGochHA96QD9gaqkwLdZJBTFDy7o/
 B2WAMiI2HqTEDuO1c2M+D5TCBBmWznU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-0oHv4FgyOuSY30_9PoMXNQ-1; Tue, 25 Nov 2025 17:29:54 -0500
X-MC-Unique: 0oHv4FgyOuSY30_9PoMXNQ-1
X-Mimecast-MFC-AGG-ID: 0oHv4FgyOuSY30_9PoMXNQ_1764109794
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-880441e0f93so7503026d6.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 14:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764109794; x=1764714594; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V/UAoV+jMOM+PCf6ZH4kzVrKJeHi9vbgSHJE4fio42Q=;
 b=rYtfyt1ibxyLadGmF7bWSw5hrpEUo/7OYkMghU4INpyDJ3BUsJlD31U/r1IwrVgZhj
 gCZ2VkH5yPz2YXzRIV1HMgAiIlia+C1jRis6abmsF2rf23D9wV7zy3m2KYq5Q85B/7mM
 DtFLW5JGabZFmu7pJ3wAau+QIlopbNr9ZgaN0T/GzQFC+wfy+5WZZAP0kw1xpgaJrse/
 8JclljXk0ETsf9jBvf24/py5JwxO/Zv0uDGLKuWdwFbH7u1RwB5vtgs/N8stP/MI5C28
 rlsIVG8BrSTTSG3AJdAHhoZ8+bdaDWmIMO1DK2uRA4YcaaVmOFK3YT4Eoc0CrQpwidQ7
 3nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764109794; x=1764714594;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V/UAoV+jMOM+PCf6ZH4kzVrKJeHi9vbgSHJE4fio42Q=;
 b=VT61ZRPyv59e1b6KZsY69h9LfS+p/sP62B92lciKQDYmhfb85g94dfk2eLKPpBVDij
 iTshQ+pQn/ze8Ow0PvYmXjYhFMhazkQqyk6EgFtFqRgqUpawwAJxo9rePw8601Z8OtbO
 2qeSyQaozOF3VWAKEVHk09ImV2By0n+oAawws3DIvrQAFX6Iqhtteu264U3f92zh0sg9
 o7IidAC8IZOFZsP85goEaROld63MhLe33VId12bNkW8CzumROi7ilyU6f/6/A8XHBwCk
 qtZThrdPbdMatztKpEqWCmIDVM3j9z0f+AsqsnxebweTx8Wpuqi+WsGgyi0mQQDGttTy
 k2bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIBnlI7JCd8+x8mGlNdcU+4ALl3GRhSWbx4G/ARP/IXy42JiTjjhuzs955uA1JdrluRY7fl5V3e4+/@nongnu.org
X-Gm-Message-State: AOJu0Yz3K7p2hPZSjj0c7LJY2GOK2oHej3X2G4AvltKiVfDB/79agQWY
 gR4mAy/uh88hBHHECFgPrVwu65YbsZohearCsWe1TOIf04CGSvk/9Xoo6aJYUMcinfU4CEq/gU1
 wTBUS2q4jeLzQ6lTeJCIf3A3bwOQ8KAwoMfrGAzhqLcOZ2gJB5Pm8olo4
X-Gm-Gg: ASbGncun0d3LJ7Se1RHNQRBGWlX298pZd7+zi4AqrFtDHHxUbJK9+Fyg3jJ2pT5qEgt
 zUrga/fjSE4Gx3m1fhASij508GseV76xzVp85Ync8EujuiOG+idK75XYHBsPcJeufrwxlTAfmbR
 QSL8MqC7acsyVh2THdsJ5kCc5UhoZai4v904Nz6B2tVKTPu4CymclQDx0i0oXH/7L76TykdWPlp
 ev6h2K6z6bkv5KOlnqLFtYsbdfBZH5dGNKAvA2KfgP6JXFXeS7caQTE0UQpcYWpMKDBmxqoWjMt
 aUvCtkPqkuL7qZepC/3o8r/LkqngQlfk3eylM4goNgeiOD1fRz5u/rKZPBAFipYIjBIad6VVm2b
 Ly8k=
X-Received: by 2002:a05:6214:3f87:b0:70f:b03d:2e85 with SMTP id
 6a1803df08f44-8847c4d3026mr242278646d6.24.1764109794029; 
 Tue, 25 Nov 2025 14:29:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGk5hE6jWVN3KYxGb46SwiU30tJeV8CkLpmgHlsh/12dIY0BRbGfdWVFqteENWqiLWNUxIk7A==
X-Received: by 2002:a05:6214:3f87:b0:70f:b03d:2e85 with SMTP id
 6a1803df08f44-8847c4d3026mr242278276d6.24.1764109793514; 
 Tue, 25 Nov 2025 14:29:53 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8846e574918sm130976136d6.46.2025.11.25.14.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 14:29:53 -0800 (PST)
Date: Tue, 25 Nov 2025 17:29:52 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Pawel Zmarzly <pzmarzly0@gmail.com>, qemu-devel@nongnu.org,
 michel@michel-slm.name
Subject: Re: [PATCH] migration: fix parsing snapshots with x-ignore-shared flag
Message-ID: <aSYt4MUUESAcThrr@x1.local>
References: <20251125174649.257457-1-pzmarzly0@gmail.com>
 <aSYE_rdMhH36KBxf@x1.local> <87tsyheqpv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tsyheqpv.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 25, 2025 at 06:40:12PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Nov 25, 2025 at 05:46:49PM +0000, Pawel Zmarzly wrote:
> >> Snapshots made with mapped-ram and x-ignore-shared flags are
> >> not parsed properly.
> >> 
> >> Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
> >> ---
> >>  migration/ram.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >> 
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index 29f016cb25..85fdc810ab 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -4277,6 +4277,11 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
> >>          id[len] = 0;
> >>          length = qemu_get_be64(f);
> >>  
> >> +        if (migrate_ignore_shared()) {
> >> +            /* Read and discard the x-ignore-shared memory region address */
> >> +            qemu_get_be64(f);
> >> +        }
> >> +
> >>          block = qemu_ram_block_by_name(id);
> >>          if (block) {
> >>              ret = parse_ramblock(f, block, length);
> >> -- 
> >> 2.52.0
> >> 
> >
> > Thanks for the patch, though the u64 was parsed in parse_ramblock()
> > instead.  Would you consider refactoring that function instead?
> 
> There's actually not much going on in terms of "parsing" in
> parse_ramblock(). I think we could move the migrate_ignore_shared() from
> the end of the function to before the mapped-ram check().

Yes, that's also what I meant if it wasn't clear.. it was parsed into a
hwaddr, and it was used to verify the addresses match.

If that check is needed for ignore-shared blocks, then these checks should
also apply when mapped-ram is enabled on top of whatever ramblock got
ignored during migration.

Since the discussion started, I am actually not sure if we do this all
right for two things..

(1) When mapped-ram is enabled, do we actually need to setup those
    ramblocks in mapped_ram_setup_ramblock()?

    That is, when a ramblock returns migrate_ram_is_ignored()==true, IIUC
    we don't need to allocate bitmap or page chunks for it?

    We likely don't need to change this easily, because this will change
    file format.. I'm also not sure if this is a major issue, logically
    when ignore-shared is used we normally shouldn't need mapped-ram.. vice
    versa.  So I may need to better understand the use case first on
    enabling the two..

(2) Is the check proper on validating mr->addr didn't change?

    This is a question on the check itself when ignore-shared enabled,
    with/without mapped-ram enabled.  That is, I question whether this
    check is useful or valid at all:
    
    if (migrate_ignore_shared()) {
        hwaddr addr = qemu_get_be64(f);
        if (migrate_ram_is_ignored(block) &&
            block->mr->addr != addr) {
            error_report("Mismatched GPAs for block %s "
                         "%" PRId64 "!= %" PRId64, block->idstr,
                         (uint64_t)addr, (uint64_t)block->mr->addr);
            return -EINVAL;
        }
    }

    In the error, it said "GPA", but mr->addr isn't GPA.. it's the offset
    of the MR within the MR's parent container MR..  So if the parent is
    the root MR / system_memory, then it is the GPA, however I don't see it
    guaranteed..

    My gut feeling is we almost always rely on proper QEMU cmdlines anyway
    to make migration work.  I wonder if we should just remove this check
    (in case it might break when mr's parent isn't the root MR).

This is irrelevant of this specific fix, so it doesn't need to block a
repost..

-- 
Peter Xu


