Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243AFE77199
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 18:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUs74-00008x-NY; Mon, 06 Jan 2025 13:46:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tUs71-00008a-46
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 13:46:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tUs6y-00048M-Mk
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 13:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736189159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZ2lCFp8uj/zo+i+Wcl9N7U3y9hnCImXCEbiAb3QQiw=;
 b=Uv8BKdrozmAQymKyqG2Vk/LOU9eGFFce9lMnksUFQRl55KxaESp3ZchVenFzo1lSLGww+l
 XSVWyvuM2Au9rZqn0m4+cdcSWtckEDesxF6vzwN9ihS9zqPMEIDIipc9Z5mgeAKvXGvNeO
 e0A/kk2rEh7w7djDssfXN1Ij6C7mz+4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-C5wdl2PoP_qrXIkp8ZyoaA-1; Mon, 06 Jan 2025 13:45:57 -0500
X-MC-Unique: C5wdl2PoP_qrXIkp8ZyoaA-1
X-Mimecast-MFC-AGG-ID: C5wdl2PoP_qrXIkp8ZyoaA
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b7477f005eso2159696085a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 10:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736189156; x=1736793956;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bZ2lCFp8uj/zo+i+Wcl9N7U3y9hnCImXCEbiAb3QQiw=;
 b=lL4FPLJ4f/crjzTmdeG9sRyCcsW/qZGa2019JSTVsCycOOhbxeW2ProsiDHAErWI77
 yrjr/QyMzF85zPEzfpkP40qf1gUcpnH9ak3on4M4UZkt+NlZljuXdhxUBDwQg5CqN/Y8
 UEuu+TnzUvHZni2G6pvtuG1Nt1UXmS513nhJh2z7UrhE+2eUcdNjTRUQEg9MirYcTJOc
 rORgNNaLrLkizlKwym3PbHENR2dmp6xQDacoCajIyrVAMmrWFXVr5idqe5YD9Z34ZoS2
 tc42Q3TduIsgl8ADWug4RcMo5iR26eT3hTvWF6HgUBw1aPDRCPcf0n6JrHJA1g645MHX
 EXKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWRJhWU1lJGnpI5lErWyHnEYk65uJK0ugr4MiAkYXC56jCQBTcjqcqa7KFrjF4qLyFK/awRbjIalqw@nongnu.org
X-Gm-Message-State: AOJu0Yxs81awekSOqhto/BjfhnEhwFT1dfWAhnE90OIQ7w8AWWPpiFo2
 BDw03htUvO2sr0VxyZtNU1PcVA8g1Cr6JQBm1hCYpJzpxd7+7ujqfVsvYzrnn6m3D066qSORqdv
 Y8kgTzcRoJEdfGWhkdhGIx0poIhTDYBE6J1UcA00NOFbZnjst/7Za
X-Gm-Gg: ASbGnctbBUYqSRDofm1jb6mX2OgnVl8dRkjsxzK1ds6/MUuTredMxej4kNb4KnQIvMV
 8UWC0MITaQZqt4cVX32dUxqDtg5yDsPAmKb1meRLs1kTD0NwdbaEMAjfk86l7kKKSVWnT/rYHVB
 kK9fN4Jbqgm05+4yzMFFRm6KiKMuQKiBk+u/I2kAhDzKysb7yU2v93GYxSap4WLHbdrSfS2l+bD
 YWSQWou/sOOtZUJtzo9RbAtKrYRSAVuYl5/OtB5xPXXnQXrYnJ5FajEIOeMarXuU73/i7daRufl
 iZEPrfvQQxNvewnkHA==
X-Received: by 2002:a05:620a:4105:b0:7b6:d23a:be39 with SMTP id
 af79cd13be357-7b9ba836bc5mr8957172785a.44.1736189156367; 
 Mon, 06 Jan 2025 10:45:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAOfc7VUdcOh5RMxZLuzneicnKdeKOylv+wqtSVk48YZ8/9ziNL8yZolaeBuCS9dYyfq33LA==
X-Received: by 2002:a05:620a:4105:b0:7b6:d23a:be39 with SMTP id
 af79cd13be357-7b9ba836bc5mr8957169385a.44.1736189155931; 
 Mon, 06 Jan 2025 10:45:55 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2df471sm1531794285a.42.2025.01.06.10.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 10:45:55 -0800 (PST)
Date: Mon, 6 Jan 2025 13:45:52 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 00/17] Migration patches for 2024-12-17
Message-ID: <Z3wk4GRH6E4kfNma@x1n>
References: <20241217174855.24971-1-farosas@suse.de>
 <20241219123213.GA692742@fedora> <87zfkrtsgt.fsf@suse.de>
 <Z2WbSZkEGSnA-BX9@x1n>
 <e5199fbb-e16e-4df0-a93d-5c0eecdc1ec7@redhat.com>
 <874j2f92cn.fsf@suse.de>
 <CAJSP0QVxQf4neUewBha9f=n+6-f2eTD_o5f7v+1R2Wm2y07paA@mail.gmail.com>
 <87sepz7guf.fsf@suse.de> <87pll37cin.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pll37cin.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 03, 2025 at 07:34:08PM -0300, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > Stefan Hajnoczi <stefanha@gmail.com> writes:
> >
> >> On Fri, 3 Jan 2025 at 13:32, Fabiano Rosas <farosas@suse.de> wrote:
> >>>
> >>> Thomas Huth <thuth@redhat.com> writes:
> >>>
> >>> > On 20/12/2024 17.28, Peter Xu wrote:
> >>> >> On Thu, Dec 19, 2024 at 03:53:22PM -0300, Fabiano Rosas wrote:
> >>> >>> Stefan Hajnoczi <stefanha@redhat.com> writes:
> >>> >>>
> >>> >>>> Hi Fabiano,
> >>> >>>> Please take a look at this CI failure:
> >>> >>>>
> >>> >>>>>>> MALLOC_PERTURB_=61 QTEST_QEMU_BINARY=./qemu-system-s390x UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QTEST_QEMU_IMG=./qemu-img MESON_TEST_ITERATION=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 PYTHON=/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/pyvenv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon G_TEST_DBUS_DAEMON=/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/tests/dbus-vmstate-daemon.sh /home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/tests/qtest/migration-test --tap -k
> >>> >>>> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> >>> >>>> stderr:
> >>> >>>> Traceback (most recent call last):
> >>> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 688, in <module>
> >>> >>>>      dump.read(dump_memory = args.memory)
> >>> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 625, in read
> >>> >>>>      section.read()
> >>> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 461, in read
> >>> >>>>      field['data'] = reader(field, self.file)
> >>> >>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 434, in __init__
> >>> >>>>      for field in self.desc['struct']['fields']:
> >>> >>>> KeyError: 'fields'
> >>> >>>
> >>> >>> This is the command line that runs only this specific test:
> >>> >>>
> >>> >>> PYTHON=/usr/bin/python3.11 QTEST_QEMU_BINARY=./qemu-system-s390x
> >>> >>> ./tests/qtest/migration-test -p /s390x/migration/analyze-script
> >>> >>>
> >>> >>> I cannot reproduce in migration-next nor in the detached HEAD that the
> >>> >>> pipeline ran in (had to download the tarball from gitlab).
> >>> >>>
> >>> >>> The only s390 patch in this PR is one that I can test just fine with
> >>> >>> TCG, so there shouldn't be any difference from KVM (i.e. there should be
> >>> >>> no state being migrated with KVM that is not already migrated with TCG).
> >>> >>>
> >>> >>>> warning: fd: migration to a file is deprecated. Use file: instead.
> >>> >>>> warning: fd: migration to a file is deprecated. Use file: instead.
> >>> >>>
> >>> >>> This is harmless.
> >>> >>>
> >>> >>>> **
> >>> >>>> ERROR:../tests/qtest/migration-test.c:36:main: assertion failed (ret == 0): (1 == 0)
> >>> >>>> (test program exited with status code -6)
> >>> >>>
> >>> >>> This is the assert at the end of the tests, irrelevant.
> >>> >>>
> >>> >>>>
> >>> >>>> https://gitlab.com/qemu-project/qemu/-/jobs/8681858344#L8190
> >>> >>>>
> >>> >>>> If you find this pull request caused the failure, please send a new
> >>> >>>> revision. Otherwise please let me know so we can continue to
> >>> >>>> investigate.
> >>> >>>
> >>> >>> I don't have an s390x host at hand so the only thing I can to is to drop
> >>> >>> that patch and hope that resolves the problem. @Peter, @Thomas, any
> >>> >>> other ideas? Can you verify this on your end?
> >>> >>
> >>> >> Cannot reproduce either here, x86_64 host only.  The report was from s390
> >>> >> host, though.  I'm not familiar with the s390 patch, I wonder if any of you
> >>> >> could use plain brain power to figure more things out.
> >>> >>
> >>> >> We could wait for 1-2 more days to see whether Thomas can figure it out,
> >>> >> hopefully easily reproduceable on s390.. or we can also leave that for
> >>> >> later.  And if the current issue on such fix is s390-host-only, might be
> >>> >> easier to be picked up by s390 tree, perhaps?
> >>> >
> >>> > I tested migration-20241217-pull-request on a s390x (RHEL) host, but I
> >>> > cannot reproduce the issue there - make check-qtest works without any
> >>> > problems. Is it maybe related to that specific Ubuntu installation?
> >>> >
> >>>
> >>> Since we cannot reproduce outside of the staging CI, could we run that
> >>> job again with a diagnostic patch? Here's the rebased PR with the patch:
> >>>
> >>> https://gitlab.com/farosas/qemu/-/commits/migration-next
> >>>
> >>> (fork CI run: https://gitlab.com/farosas/qemu/-/pipelines/1610691202)
> >>>
> >>> Or should I just send a v2 of this PR with the debug patch?
> >>
> >> Here is the staging CI pipeline for your migration-next tree:
> >> https://gitlab.com/qemu-project/qemu/-/pipelines/1610836485
> >
> > Great, thanks! Let's find out what is going on...
> >
> 
> It seems the issue is here:
> 
> {"name": "css", "array_len": 256, "type": "struct", "struct": {}, "size": 1}
>                                                               ^
> And in QEMU:
> 
> static const VMStateDescription vmstate_css = {
>     .name = "s390_css",
>     ...
> ->      VMSTATE_ARRAY_OF_POINTER_TO_STRUCT(css, ChannelSubSys, MAX_CSSID + 1,
>                 0, vmstate_css_img, CssImage),
> 
> Is it legal to have an empty array? I would assume so. Are we maybe
> missing a .needed?

I guess we can always decide to dump things even if it's empty.

When I was looking at this, I saw a trick we played in vmstate dump, see
07d4e69147 ("migration/vmstate: fix array of ptr with nullptrs").  I am
guessing we hit a nullptr (or a bunch of..) here so the JSON part is
ignored.

> 
> Comparing with another similar vmstate spapr_llan/rx_pools in ppc
> (-device spapr-vlan), what I see is:
> 
> {"name": "rx_pool", "array_len": 5, "type": "struct", "struct":
> {"vmsd_name": "spapr_llan/rx_buffer_pool", ... }, "size": 32776}
> 
> So for CSS I'd expect:
> 
> -{"name": "css", "array_len": 256, "type": "struct", "struct": {}, "size": 1}
> +{"name": "css", "array_len": 256, "type": "struct", "struct": {"vmsd_name": "s390_css_img", ...}, "size": 1}
> 
> What is weird is that in my TCG run it also shows the empty struct and
> the script doesn't seem to care. For some reason, in the CI job it
> parses further into the JSON.
> 
> If anyone spots something, let me know. I'll get back to this on Monday
> with a fresh mind.

So I thought about a solution; it's not easy to do it clean in a small
change.  So here it is, not so small but not huge either.  This is the
cleanest I can come up with.. attached at the end.

If it works, we're 100% lucky.  I hope VMSDFieldGeneric in the script will
already work for the nullptrs.  If not, hopefully this provides some
insight so you can move further..

===8<===
From e5339d55f71df2d96d99dbd7eb845f06da0e68aa Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Mon, 6 Jan 2025 13:18:25 -0500
Subject: [PATCH] migration: Dump correct JSON format for nullptr replacement

QEMU plays a trick with null pointers inside an array of pointers in a VMSD
field.  See 07d4e69147 ("migration/vmstate: fix array of ptr with
nullptrs") for more details on why.  The idea makes sense in general, but
it may overlooked the JSON writer where it could write nothing in a
"struct" in the JSON hints section.

We hit some analyze-migration.py issues on s390 recently, showing that some
of the struct field contains nothing, like:

{"name": "css", "array_len": 256, "type": "struct", "struct": {}, "size": 1}

As described in details by Fabiano:

https://lore.kernel.org/r/87pll37cin.fsf@suse.de

It could be that we hit some null pointers there, and JSON was gone when
they're null pointers.

To fix it, instead of hacking around only at VMStateInfo level, do that
from VMStateField level, so that JSON writer can also be involved.  In this
case, JSON writer will replace the pointer array (which used to be a
"struct") to be the real representation of the nullptr field.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 118 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 91 insertions(+), 27 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index fa002b24e8..e9321b7846 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -51,6 +51,36 @@ vmstate_field_exists(const VMStateDescription *vmsd, const VMStateField *field,
     return result;
 }
 
+/*
+ * Create a fake nullptr field when there's a NULL pointer detected in the
+ * array of a VMS_ARRAY_OF_POINTER VMSD field.  It's needed because we
+ * can't dereference the NULL pointer.
+ */
+static const VMStateField *
+vmsd_create_fake_nullptr_field(const VMStateField *field)
+{
+    VMStateField *fake = g_new0(VMStateField, 1);
+
+    /* It can only happen on an array of pointers! */
+    assert(field->flags & VMS_ARRAY_OF_POINTER);
+
+    /* Some of fake's properties should match the original's */
+    fake->name = field->name;
+    fake->version_id = field->version_id;
+
+    /* Do not need "field_exists" check as it always exists (which is null) */
+    fake->field_exists = NULL;
+
+    /* See vmstate_info_nullptr - use 1 byte to represent nullptr */
+    fake->size = 1;
+    fake->info = &vmstate_info_nullptr;
+    fake->flags = VMS_SINGLE;
+
+    /* All the rest fields shouldn't matter.. */
+
+    return (const VMStateField *)fake;
+}
+
 static int vmstate_n_elems(void *opaque, const VMStateField *field)
 {
     int n_elems = 1;
@@ -143,23 +173,39 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
             }
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
+                const VMStateField *inner_field;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     curr_elem = *(void **)curr_elem;
                 }
+
                 if (!curr_elem && size) {
-                    /* if null pointer check placeholder and do not follow */
-                    assert(field->flags & VMS_ARRAY_OF_POINTER);
-                    ret = vmstate_info_nullptr.get(f, curr_elem, size, NULL);
-                } else if (field->flags & VMS_STRUCT) {
-                    ret = vmstate_load_state(f, field->vmsd, curr_elem,
-                                             field->vmsd->version_id);
-                } else if (field->flags & VMS_VSTRUCT) {
-                    ret = vmstate_load_state(f, field->vmsd, curr_elem,
-                                             field->struct_version_id);
+                    /*
+                     * If null pointer found (which should only happen in
+                     * an array of pointers), use null placeholder and do
+                     * not follow.
+                     */
+                    inner_field = vmsd_create_fake_nullptr_field(field);
+                } else {
+                    inner_field = field;
+                }
+
+                if (inner_field->flags & VMS_STRUCT) {
+                    ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
+                                             inner_field->vmsd->version_id);
+                } else if (inner_field->flags & VMS_VSTRUCT) {
+                    ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
+                                             inner_field->struct_version_id);
                 } else {
-                    ret = field->info->get(f, curr_elem, size, field);
+                    ret = inner_field->info->get(f, curr_elem, size,
+                                                 inner_field);
                 }
+
+                /* If we used a fake temp field.. free it now */
+                if (inner_field != field) {
+                    g_clear_pointer((gpointer *)&inner_field, g_free);
+                }
+
                 if (ret >= 0) {
                     ret = qemu_file_get_error(f);
                 }
@@ -387,29 +433,50 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
             }
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
+                const VMStateField *inner_field;
 
-                vmsd_desc_field_start(vmsd, vmdesc_loop, field, i, n_elems);
                 old_offset = qemu_file_transferred(f);
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     assert(curr_elem);
                     curr_elem = *(void **)curr_elem;
                 }
+
                 if (!curr_elem && size) {
-                    /* if null pointer write placeholder and do not follow */
-                    assert(field->flags & VMS_ARRAY_OF_POINTER);
-                    ret = vmstate_info_nullptr.put(f, curr_elem, size, NULL,
-                                                   NULL);
-                } else if (field->flags & VMS_STRUCT) {
-                    ret = vmstate_save_state(f, field->vmsd, curr_elem,
-                                             vmdesc_loop);
-                } else if (field->flags & VMS_VSTRUCT) {
-                    ret = vmstate_save_state_v(f, field->vmsd, curr_elem,
-                                               vmdesc_loop,
-                                               field->struct_version_id, errp);
+                    /*
+                     * If null pointer found (which should only happen in
+                     * an array of pointers), use null placeholder and do
+                     * not follow.
+                     */
+                    inner_field = vmsd_create_fake_nullptr_field(field);
+                } else {
+                    inner_field = field;
+                }
+
+                vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
+                                      i, n_elems);
+
+                if (inner_field->flags & VMS_STRUCT) {
+                    ret = vmstate_save_state(f, inner_field->vmsd,
+                                             curr_elem, vmdesc_loop);
+                } else if (inner_field->flags & VMS_VSTRUCT) {
+                    ret = vmstate_save_state_v(f, inner_field->vmsd,
+                                               curr_elem, vmdesc_loop,
+                                               inner_field->struct_version_id,
+                                               errp);
                 } else {
-                    ret = field->info->put(f, curr_elem, size, field,
-                                     vmdesc_loop);
+                    ret = inner_field->info->put(f, curr_elem, size,
+                                                 inner_field, vmdesc_loop);
                 }
+
+                written_bytes = qemu_file_transferred(f) - old_offset;
+                vmsd_desc_field_end(vmsd, vmdesc_loop, inner_field,
+                                    written_bytes, i);
+
+                /* If we used a fake temp field.. free it now */
+                if (inner_field != field) {
+                    g_clear_pointer((gpointer *)&inner_field, g_free);
+                }
+
                 if (ret) {
                     error_setg(errp, "Save of field %s/%s failed",
                                 vmsd->name, field->name);
@@ -419,9 +486,6 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                     return ret;
                 }
 
-                written_bytes = qemu_file_transferred(f) - old_offset;
-                vmsd_desc_field_end(vmsd, vmdesc_loop, field, written_bytes, i);
-
                 /* Compressed arrays only care about the first element */
                 if (vmdesc_loop && vmsd_can_compress(field)) {
                     vmdesc_loop = NULL;
-- 
2.47.0

===8<===

-- 
Peter Xu


