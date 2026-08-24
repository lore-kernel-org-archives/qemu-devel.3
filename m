Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F9CC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUYr-0004cl-1R; Mon, 24 Aug 2026 09:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wyUYp-0004bK-UH
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wyUYm-0005X0-OQ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787577476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oshjea8Wc8qToF3gikaj+JuwnqmJ5EWZ/BT0sqjnFlA=;
 b=CYUZMmvxhwZcbHqziYpV4eX0WkRVIwaetiBhuSFmPS/g5hhJrecX8cKdMrWLP55AzWqjNG
 eywvTCX7jr/H/z0cy0mWlsI8yGaP7Kmu8HvnqGxH4+i0Bw0r+OOGzU60Hp1+NESjt4S2XA
 po0kpbNho7jTJDdDMLFSR51ti2JT4uk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252--FBYnQVTNLGhUuxJ09LlWw-1; Mon, 24 Aug 2026 09:17:54 -0400
X-MC-Unique: -FBYnQVTNLGhUuxJ09LlWw-1
X-Mimecast-MFC-AGG-ID: -FBYnQVTNLGhUuxJ09LlWw_1787577473
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c20262b5e10so421518066b.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787577473; x=1788182273; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Oshjea8Wc8qToF3gikaj+JuwnqmJ5EWZ/BT0sqjnFlA=;
 b=fArNbYJd65qmiNV2q9YZKiZZ38WZJZwDS5JEEBr11f3aEtZbtudleo5fV3azTor9YZ
 FAsA+ak4LdSJvPSE4LFMvkYNh8JGSc2B6hnbQd0lP6YvIX867hnz+7M2RSBHST4jd6d1
 +fLGujV7/JLflqacSy+elFFsWBQpbOxbRUG2y09ljPby3yZ5pjqMUqli6kaIWLZE6Zgz
 hzqNTeICPGSjQLFdmKG5/qUfeKva/N0hcNwV+jYRWk0Zx9FtVC2ecMn+XLbc2cbuBv9m
 dypdnHSfb2v2uKK0cVr5i+kjOWoFGo/H5NkHmKEYbO8R6fXJOoMGCmQcgaCPjYEFxYMu
 3EFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787577473; x=1788182273;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Oshjea8Wc8qToF3gikaj+JuwnqmJ5EWZ/BT0sqjnFlA=;
 b=eacpIFMV4D5khqFTO6tq94to7uYBcYb+qo8w9kiZ2qog8nkvHdVEXNgCkfSXgYs6t1
 /VU2F4rEHOJY3FHg1eyYNMcE9PZC1S4WN+B7srBto+YEiEa/UY05Dd6lTNTXKzNwmlbp
 fxzlupNeouP+5aHTLM+aFDPcoh79qx67nQvIKifxhTDq+Q0nBSTOeN1GM38Dm5MC/Ool
 v9QDKcS7mHeXLj/0UohAyILkyvqjZCh4t1kFE/A4fU11Sbi1G2zlA90YPrbD9x5MAd9J
 vYxjmZ5N2IL2NWQYAkpGaa46YghVFn+5+zhlAZb/LHP1jChdhXLBOQ5hwhrhPVXBSxLK
 ZXBw==
X-Gm-Message-State: AFuF++m/hKdaeW12sleVccFU5Ivm6y8hxa3x1hGH10vw6ThYLCQAK0oc
 aQTHqFFlmxC4aXj+wQwR7U4bOrnh4T9HnismAsRKtj4uZEsxDNJqxU5bJQ/9VOeIad3BN1XTczb
 xC1hm83PyP0AMLzxKjowX5aCc6iZy5dJRSdD8ACfv1h/cxTIGZybAY1ED
X-Gm-Gg: AR+sD10pPq18CMSdknNEhII74yNkz2WORs1QhkYJc+RcMBXU8UTQvp5UOKKLzayd7mA
 QkpxCNvqZutuTcVPFkp2YiybztzB3WvXTars8LR4/Q/XRW/aDK/z6mnxFL2mrE359lv+G3suZLG
 +BL28cv1MiP1uSlaVpfzvdL+7y0lZTPPLag3ltM0Hwk8aamiotgMxl1UIVUxmRaLVQVnT+79io0
 +J7m+zba+JlmpuktmQrmpV4b4xpNlQlcfWbXIL5tGwvY7KhsYnBw+4rDfBbvj2AMoyP5VOouD/t
 yj7nW25eJ4iWzxMWr+XRzj/SGW0lzFZLnCEsn855Jr9KRuvOLq/tMznOsdqCWGXV6tfI2yi/0Rg
 /7GKHdw28B41gnbQk3J0vQY9ls6PiEmI42dl+IP0+oE9CHIm9dCLnUKeuX2g=
X-Received: by 2002:a17:907:e14b:10b0:c19:80cf:4c75 with SMTP id
 a640c23a62f3a-c246a6ab42dmr2506110466b.20.1787577473339; 
 Mon, 24 Aug 2026 06:17:53 -0700 (PDT)
X-Received: by 2002:a17:907:e14b:10b0:c19:80cf:4c75 with SMTP id
 a640c23a62f3a-c246a6ab42dmr2506102566b.20.1787577472896; 
 Mon, 24 Aug 2026 06:17:52 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606bd05sm1204110166b.2.2026.08.24.06.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:17:52 -0700 (PDT)
Date: Mon, 24 Aug 2026 09:17:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, jmarcin@redhat.com, david@kernel.org,
 pbonzini@redhat.com, chenyi.qiang@intel.com, farosas@suse.de,
 aik@amd.com, xiaoyao.li@intel.com,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v4 00/12] KVM/hostmem: Support init-shared guest-memfd as
 VM backends
Message-ID: <aoxEfKoYWtdOSwH_@x1.local>
References: <20260812201938.198915-1-michael.roth@amd.com>
 <aoheMqE-RnH8sQ82@x1.local>
 <3fwr25hmoz7yicoh3o3x3ldeweapn2tbn4dnji67hgrnz7l5bh@rs7gqotxraef>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3fwr25hmoz7yicoh3o3x3ldeweapn2tbn4dnji67hgrnz7l5bh@rs7gqotxraef>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Aug 23, 2026 at 10:52:13AM -0500, Michael Roth wrote:
> On Fri, Aug 21, 2026 at 10:18:26AM -0400, Peter Xu wrote:
> > On Wed, Aug 12, 2026 at 03:16:38PM -0500, Michael Roth wrote:
> > > v1: https://lore.kernel.org/r/20251023185913.2923322-1-peterx@redhat.com
> > > v2: https://lore.kernel.org/r/20251119172913.577392-1-peterx@redhat.com
> > > v3: https://lore.kernel.org/r/20251215205203.1185099-1-peterx@redhat.com/
> > > v4:
> > > - Picked up v3 series from Peter Xu and rebased on 11.1.0
> > > - Collected pending Reviewed-by's
> > > - Per-patch changes:
> > >   [01/12] Fix blank space (Xiaoyao)
> > >           Fix commit message typos
> > >   [02/12] Drop duplicated error-handling for capability checks
> > >   [05/12] Fix up commit message, disambigurate "in-place" terminology (Xiaoyao)
> > >   [07/12] Fix up commit message, disambigurate "in-place" terminology (Xiaoyao)
> > >   [08/12] Disallow 'seal' and 'hugetlb' options based on guest-memfd=on
> > >           Fix minor typo in comment
> > >   [11/12] Fix up typo in g_test_skip() reason
> > >           Pending: Move kvm_guest_memfd_init_shared_supported() to
> > >             migration-util.c (Fabiano)
> > > 
> > > This patchset is also available at:
> > > 
> > >   https://github.com/amdese/qemu/commits/gmem-shared-mem-v4
> > > 
> > > and is based on top of v11.1.0
> > 
> > Should I just pick this up?  I'll touch up the commit log that Phil
> > requested.  Objections welcomed before next week.
> 
> Hi Peter,

Hi, Michael,

> 
> No objection here, although I'll be posting new version of the in-place
> conversion support later this week (~Wed-ish) and was planning to an
> updated version of this series roughly the same time so which ever way
> is best for you.
> 
> If you do post one though there's also the missing 'return false' and
> dropping the seal=off enforcement that Daniel noticed before we started
> talking about introspection fun.

I didn't mean to repost this series, I meant to pick it up for a pull.
Sorry if it was confusing..

I want to make sure balls are rolling.  From our side, we weren't rush on
this one to land, as we'll need to wait for 1G to settle anyway, but if we
have others (like your in-place series upcoming) pending, I think we should
just land it sooner.

You're right, we need to fix things, I noticed it right after I sent the
email and then I found CI / unit test failing.. but I haven't got a chance
to say..  If you repost please check migration-test with --full, otherwise
the gmemfd test will be skipped.

I have two fixups queued locally, I'll attach it here, please use it
whatever way you like, I'll wait for your repost.  NOTE: I touched up the
hugetlb failure message when I fixed it up myself, but since you'll repost
you can decide; please just treat it as a comment then, I just think the
new err message is less strong because we will support it.

Thanks,

===8<===


From 0a0dd0f808d4f668ac099945ab35a981e1a07bfb Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 21 Aug 2026 12:16:15 -0400
Subject: [PATCH 1/2] fixup! hostmem: Support fully shared guest memfd to back
 a VM

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 backends/hostmem-memfd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index fbe65b00be..6576331441 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -57,14 +57,16 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
     }
 
     if (m->guest_memfd) {
+        /*
+         * NOTE: guest-memfd ignores seal=on/off because it always
+         * implicitly seals the FD by definition.
+         */
         if (!backend->share) {
             error_setg(errp, "guest-memfd=on must be used with share=on");
             return false;
-        } else if (m->seal) {
-            error_setg(errp, "guest-memfd=on must be used with seal=off");
-            return false;
         } else if (m->hugetlb) {
-            error_setg(errp, "guest-memfd=on must be used with hugetlb=off");
+            error_setg(errp, "guest-memfd=on doesn't support hugetlb=on yet");
+            return false;
         }
 
         fd = kvm_create_guest_memfd(backend->size,
-- 
2.54.0



From 66ac7b3f2268430106bfe8034ef8460215e9db91 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 21 Aug 2026 13:00:09 -0400
Subject: [PATCH 2/2] fixup! tests/migration-test: Add a precopy test for
 guest-memfd

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/precopy-tests.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 8146f37d61..d57ffcac23 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -184,7 +184,6 @@ static void test_precopy_tcp_plain(char *name, MigrateCommon *args)
 
 static void test_precopy_tcp_plain_gmemfd(char *name, MigrateCommon *args)
 {
-    args->uri = "tcp:127.0.0.1:0";
     args->start.mem_type = MEM_TYPE_GUEST_MEMFD;
 
     test_precopy_common(args);
-- 
2.54.0


-- 
Peter Xu


