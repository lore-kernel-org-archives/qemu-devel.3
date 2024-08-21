Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31F7C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 16:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgoeS-0001qR-VF; Wed, 21 Aug 2024 12:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgoeR-0001pf-1J
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 12:57:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgoeO-00016O-Fw
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 12:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724259454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=72nVWtKKC2sfvJi0dQHZuwXl9Lj7ZDv0etuqaJN5224=;
 b=Lgj90RSTEAy8di336b4XrPyelhI8iM/QCj7xKOqXoqUa3mB4kyJIPPd/Cdk2B62DmESp4Z
 tnVz2rqzXZcT5Hdho6TqJFYsLMxzmo6bb3MBGqvkvrVyB9mrMKmFOvekaMkm4vnTezln4S
 fR1CiFX2fXcS96UoO27viNmUZt+Rf3U=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-3wgfYhH6OjC6SSi2wCRLiA-1; Wed, 21 Aug 2024 12:57:33 -0400
X-MC-Unique: 3wgfYhH6OjC6SSi2wCRLiA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a1d4335cceso182713485a.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 09:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724259451; x=1724864251;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72nVWtKKC2sfvJi0dQHZuwXl9Lj7ZDv0etuqaJN5224=;
 b=GQjHoL5z1wsXR8iQjDYAWlXwDeH9GlZ5UQ2DwDe9LII2+91mW4xsu46+mrmIJyyn78
 SiScGPsqL3IkM7+BkYGJIClF75rmTvpRGcxSuj2xfB7kubrIxPfO8JCZqP2DLCa40E3b
 xLF+876zNQtGxVRA7Onqw1Vklt+YFJysSDVXBxR2WHU0hapF1qTOEFGCy0kNwJDdBgmO
 oD1DeI65rFgM+O1nPMKa4t2+zcODAK/VWY3mJTAz0D+GnBhhTs8n/TqbpwBSCVSfjFSn
 C92AlzzK61OPHJC5ykDU6WFwo7A72VA0okqgjFhnOLihIdXaX+0CYthRxA0MA+925vrA
 zJDA==
X-Gm-Message-State: AOJu0YxJhgojk1PtqHXE6p4+iP7hRAE0L3TZMDSPlu8LhQiru/QJj3ld
 AKz0D4u9nJkOff2/5LdS8exHDybOxpvSKrPWt9vcuajXXdK2VyBfKn1fzaJwV+PzQ7kdEvi3bXz
 WRxKqXbENqdsm4glqAO4BuSlzm0vdZts66dF4xRSD4UMkJGu/dIpD
X-Received: by 2002:a05:620a:2802:b0:79f:17f4:7154 with SMTP id
 af79cd13be357-7a67d3e2bd4mr43128385a.3.1724259451440; 
 Wed, 21 Aug 2024 09:57:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaPJP7V3tmnF9VdcWHFtYulr+E6l6Ls8mJnQ6SIrJwjmiv3rgdgdeMOSeovbfJ+METZll24A==
X-Received: by 2002:a05:620a:2802:b0:79f:17f4:7154 with SMTP id
 af79cd13be357-7a67d3e2bd4mr43123885a.3.1724259450961; 
 Wed, 21 Aug 2024 09:57:30 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a4ff02505dsm644662285a.13.2024.08.21.09.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:57:30 -0700 (PDT)
Date: Wed, 21 Aug 2024 12:57:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 06/11] migration: fix mismatched GPAs during cpr
Message-ID: <ZsYcd7EJjtoLZx0V@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-7-git-send-email-steven.sistare@oracle.com>
 <ZpqUGYclrONQEuc7@x1n>
 <571a4f84-693c-43d4-a43a-52a53a1091e1@oracle.com>
 <ZrvFXCRPczXvCu2n@x1n>
 <5f763763-1479-4585-98ce-83fcec03b4db@oracle.com>
 <Zr9li88goR-YKcng@x1n>
 <aa789f70-145f-42a1-a0c1-175190867d85@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aa789f70-145f-42a1-a0c1-175190867d85@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Aug 16, 2024 at 01:10:02PM -0400, Steven Sistare wrote:
> On 8/16/2024 10:43 AM, Peter Xu wrote:
> > On Thu, Aug 15, 2024 at 04:54:58PM -0400, Steven Sistare wrote:
> > > On 8/13/2024 4:43 PM, Peter Xu wrote:
> > > > On Wed, Aug 07, 2024 at 05:04:26PM -0400, Steven Sistare wrote:
> > > > > On 7/19/2024 12:28 PM, Peter Xu wrote:
> > > > > > On Sun, Jun 30, 2024 at 12:40:29PM -0700, Steve Sistare wrote:
> > > > > > > For new cpr modes, ramblock_is_ignored will always be true, because the
> > > > > > > memory is preserved in place rather than copied.  However, for an ignored
> > > > > > > block, parse_ramblock currently requires that the received address of the
> > > > > > > block must match the address of the statically initialized region on the
> > > > > > > target.  This fails for a PCI rom block, because the memory region address
> > > > > > > is set when the guest writes to a BAR on the source, which does not occur
> > > > > > > on the target, causing a "Mismatched GPAs" error during cpr migration.
> > > > > > 
> > > > > > Is this a common fix with/without cpr mode?
> > > > > > 
> > > > > > It looks to me mr->addr (for these ROMs) should only be set in PCI config
> > > > > > region updates as you mentioned.  But then I didn't figure out when they're
> > > > > > updated on dest in live migration: the ramblock info was sent at the
> > > > > > beginning of migration, so it doesn't even have PCI config space migrated;
> > > > > > I thought the real mr->addr should be in there.
> > > > > > 
> > > > > > I also failed to understand yet on why the mr->addr check needs to be done
> > > > > > by ignore-shared only.  Some explanation would be greatly helpful around
> > > > > > this area..
> > > > > 
> > > > > The error_report does not bite for normal migration because migrate_ram_is_ignored()
> > > > > is false for the problematic blocks, so the block->mr->addr check is not
> > > > > performed.  However, mr->addr is never fixed up in this case, which is a
> > > > > quiet potential bug, and this patch fixes that with the "has_addr" check.
> > > > > 
> > > > > For cpr-exec, migrate_ram_is_ignored() is true for all blocks,
> > > > > because we do not copy the contents over the migration stream, we preserve the
> > > > > memory in place.  So we fall into the block->mr->addr sanity check and fail
> > > > > with the original code.
> > > > 
> > > > OK I get your point now.  However this doesn't look right, instead I start
> > > > to question why we need to send mr->addr at all..
> > > > 
> > > > As I said previously, AFAIU mr->addr should only be updated when there's
> > > > some PCI config space updates so that it moves the MR around in the address
> > > > space based on how guest drivers / BIOS (?) set things up.  Now after these
> > > > days not looking, and just started to look at this again, I think the only
> > > > sane place to do this update is during a post_load().
> > > > 
> > > > And if we start to check some of the memory_region_set_address() users,
> > > > that's exactly what happened..
> > > > 
> > > >     - ich9_pm_iospace_update(), update addr for ICH9LPCPMRegs.io, where
> > > >       ich9_pm_post_load() also invokes it.
> > > > 
> > > >     - pm_io_space_update(), updates PIIX4PMState.io, where
> > > >       vmstate_acpi_post_load() also invokes it.
> > > > 
> > > > I stopped here just looking at the initial two users, it looks all sane to
> > > > me that it only got updated there, because the update requires pci config
> > > > space being migrated first.
> > > > 
> > > > IOW, I don't think having mismatched mr->addr is wrong at this stage.
> > > > Instead, I don't see why we should send mr->addr at all in this case during
> > > > as early as SETUP, and I don't see anything justifies the mr->addr needs to
> > > > be verified in parse_ramblock() since ignore-shared introduced by Yury in
> > > > commit fbd162e629aaf8 in 2019.
> > > > 
> > > > We can't drop mr->addr now when it's on-wire, but I think we should drop
> > > > the error report and addr check, instead of this patch.
> > > 
> > > As it turns out, my test case triggers this bug because it sets x-ignore-shared,
> > > but x-ignore-shared is not needed for cpr-exec, because migrate_ram_is_ignored
> > > is true for all blocks when mode==cpr-exec.  So, the best fix for the GPAs bug
> > > for me is to stop setting x-ignore-shared.  I will drop this patch.
> > > 
> > > I agree that post_load is the right place to restore mr->addr, and I don't
> > > understand why commit fbd162e629aaf8 added the error report, but I am going
> > > to leave it as is.
> > 
> > Ah, I didn't notice that cpr special cased migrate_ram_is_ignored()..
> > 
> > Shall we stick with the old check, but always require cpr to rely on
> > ignore-shared?
> > 
> > Then we replace this patch with removing the error_report, probably
> > together with not caring about whatever is received at all.. would that be
> > cleaner?
> 
> migrate_ram_is_ignored() is called in many places and must return true for
> cpr-exec/cpr-transfer, independently of migrate_ignore_shared.  That logic
> must remain as is.

Is this because cpr can fail some ramblock in qemu_ram_is_named_file()?

It's not obvious in this case, maybe some re-strcture would be nice.  Would
something like this look nicer and easier to understand?

===8<===
diff --git a/migration/ram.c b/migration/ram.c
index 1e1e05e859..ace635b167 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -214,14 +214,29 @@ static bool postcopy_preempt_active(void)
     return migrate_postcopy_preempt() && migration_in_postcopy();
 }
 
-bool migrate_ram_is_ignored(RAMBlock *block)
+/* Whether the destination QEMU can share the access on this ramblock? */
+bool migrate_ram_is_shared(RAMBlock *block)
 {
     MigMode mode = migrate_mode();
+
+    /* Private ram is never share-able */
+    if (!qemu_ram_is_shared(block)) {
+        return false;
+    }
+
+    /* Named file ram is always assumed to be share-able */
+    if (qemu_ram_is_named_file(block)) {
+        return true;
+    }
+
+    /* It's a private fd, only cpr mode can share it (by sharing fd) */
+    return (mode == MIG_MODE_CPR_EXEC) || (mode == MIG_MODE_CPR_TRANSFER);
+}
+
+bool migrate_ram_is_ignored(RAMBlock *block)
+{
     return !qemu_ram_is_migratable(block) ||
-           mode == MIG_MODE_CPR_EXEC ||
-           mode == MIG_MODE_CPR_TRANSFER ||
-           (migrate_ignore_shared() && qemu_ram_is_shared(block)
-                                    && qemu_ram_is_named_file(block));
+           (migrate_ignore_shared() && migrate_ram_is_shared(block));
 }
===8<===

Please feel free to squash this to your patch in whatever way if it looks
reasonable to you.

> 
> The cleanest change is no change, just dropping this patch.  I was just confused
> when I set x-ignore-shared for the test.
> 
> However, if an unsuspecting user sets x-ignore-shared, it will trigger this error,
> so perhaps I should delete the error_report.

Yes, feel free to send that as a separate patch if you want, since we
digged it this far it'll be nice we fix it even if it's not relevant now.

Thanks,

-- 
Peter Xu


