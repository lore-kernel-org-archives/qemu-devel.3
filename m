Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AEAC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9nDS-00089V-BX; Tue, 29 Apr 2025 11:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u9nDP-00089F-PG
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:49:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u9nDN-0001Xb-B1
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745941781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1B8ZBE46zfWiDO+NR1rEYvfwkRkemLDa+po7ylo2GzQ=;
 b=UXriAxo0SKrctUkcUcJt6CsH1VrN3NySYG79FMXasIJdR3MG8BkOvV9FQQyfjjFtMLenUR
 96KeLE+tIln8XHLQqC8EPWiAobU+zRmhxjr/1WG+co4dqYa/X4OcWQrmxfEs54C5FsPgwX
 ZURoonLrAh37aD9fuZKflUGt5u59og0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-jAQxclMJOl233wP4ZR8iow-1; Tue, 29 Apr 2025 11:49:39 -0400
X-MC-Unique: jAQxclMJOl233wP4ZR8iow-1
X-Mimecast-MFC-AGG-ID: jAQxclMJOl233wP4ZR8iow_1745941779
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c5f3b8b1a1so1020564885a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 08:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745941779; x=1746546579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1B8ZBE46zfWiDO+NR1rEYvfwkRkemLDa+po7ylo2GzQ=;
 b=fYobj1M3JWpEr3O+sYDYuwIPPLxiIkpjRjqt4Kr5zNXRpr2Za9OZ2zMqfQeF7vyg6t
 l+CfqAsCNQkdHsp2nuBC4Cv/zYvzcm93m6UdKHGF3D8VTQnPq0r8viXDXigcb2Ebgwl2
 +I1Ed51zfQmo8p2T/d/xiNHhxFMMVtM82MSH2mkvKtBeNo2GPa3t2Xvc4/nt+kC9qsle
 oMrJsW+N+rCE9TQIBchyRoQIHXl5lwQ2V3+uA4SwSV1z5xFcNx18HD1ATH00N+udeZht
 qNuMMp7eqAbKi7QvYpRQuLRPqxjaXk+5rOZXOj/+B0E01+jrJxXlHmnlfGm+CZDAHPv0
 0V9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVOh2OviA7+nE4mA4JKcOWKtCiaN0kQu37sCfYiQlnyi69Ci47pYKINqVo/gJ8JrKcIhEvmOc7TUkC@nongnu.org
X-Gm-Message-State: AOJu0YznC55nSli9S+2PGxBu4A67nFEBxyaWPagbzEzlp7F9udYPrPVH
 evczz+0uV+ScCjMqgHU52MIg1ZasdCcyOS1i12Y6/E/HNhNZ76Ab+O7IOU3uo+0N910GWUJpGkm
 AKSeUd8PG525m0p5Wit/0pmABM8+fKUARTxt2CDOmWFdB7MeNTeZX
X-Gm-Gg: ASbGncvGz0B2vGEsaKMyIk9FC61R/2g7Z1foBFVG6lgV3iiwGf3Yo5yskW5ja9u1rAA
 kyyH1ZVZtGRsKoZSaoBmialqDni0xV6y5ErRVxvO/irX3/BrQZF0pNVVjFxbus1Dttf2Lj5Yhsb
 HrnyCt5s1AD2uXSjYd0RSXMmRwnwljBFAs5VZzz3rkmh0dNAb3fjFDJmpqOacuk9LCKIffAN7S9
 q4J5JPpZfqBvgK65cxoHWAPWnilcmGd3bH8aKWClDU0rSZrK2DOlqvQ6MI+yMe95AdXIGhpwLY9
 Ayc=
X-Received: by 2002:a05:620a:280c:b0:7c9:2537:be48 with SMTP id
 af79cd13be357-7cabdd870d6mr543260185a.24.1745941779105; 
 Tue, 29 Apr 2025 08:49:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhg/UsCL7g6FsMP5Ds0UyePhDu4Tytob/2UBDvH8wbl47fH1zMcl1KrpnG+s1EUW4jReBahg==
X-Received: by 2002:a05:620a:280c:b0:7c9:2537:be48 with SMTP id
 af79cd13be357-7cabdd870d6mr543257785a.24.1745941778755; 
 Tue, 29 Apr 2025 08:49:38 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c958ea0b9bsm748125585a.91.2025.04.29.08.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 08:49:38 -0700 (PDT)
Date: Tue, 29 Apr 2025 11:49:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 berrange@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v9 0/7] Allow to enable multifd and postcopy migration
 together
Message-ID: <aBD1D3obdWFta-1H@x1.local>
References: <87ecxteym0.fsf@suse.de> <87bjswfeis.fsf@suse.de>
 <CAE8KmOzzn7g1=pd2J325gAf4ffmGALKoHdgL17So4KawxkZdbg@mail.gmail.com>
 <87y0vyepta.fsf@suse.de> <aAlu0hcUCdzmIN4p@x1.local>
 <CAE8KmOz7P+Pz8zwJq+mTEJbZjhCk7iAo9+c5DrZzhbTmz=VtUQ@mail.gmail.com>
 <aBDObgL7hDQMy63F@x1.local>
 <CAE8KmOx9yuZWWHnaA6gkC2VpeimY1=Pw+AU9iDvQ+vVpUp_vKg@mail.gmail.com>
 <aBDYj3k83_W6ihlF@x1.local>
 <CAE8KmOxR1EoyLK6+49bVJK9BW0NfhgEcE2_aVxQQjkBY9y1xwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE8KmOxR1EoyLK6+49bVJK9BW0NfhgEcE2_aVxQQjkBY9y1xwA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Apr 29, 2025 at 08:50:19PM +0530, Prasad Pandit wrote:
> On Tue, 29 Apr 2025 at 19:18, Peter Xu <peterx@redhat.com> wrote:
> > Please don't rush to send. Again, let's verify the issue first before
> > resending anything.
> >
> > If you could reproduce it it would be perfect, then we can already verify
> > it.  Otherwise we may need help from Fabiano.  Let's not send anything if
> > you're not yet sure whether it works..  It can confuse people thinking
> > problem solved, but maybe not yet.
> 
> * No, the migration hang issue is not reproducing on my side. Earlier
> in this thread, Fabiano said you'll be better able to confirm the
> issue. (so its possible fix as well I guess)
> 
> * You don't have access to the set-up that he uses for running tests
> and merging patches? Would it be possible for you to run the same
> tests? (just checking, I don't know how co-maintainers work to
> test/merge patches)

No I don't.

> 
> * If we don't send the patch, how will Fabiano test it? Should we wait
> for Fabiano to come back and then make this same patch in his set-up
> and test/verify it?

I thought you've provided a diff.  That would be good enough for
verifications.  If you really want, you can repost, but please mention
explicitly that you haven't verified the issue, so the patchset needs to be
verified.

Fabiano should come back early May.  If you want, you can try to look into
how to reproduce it by looking at why it triggered in vapic path:

https://lore.kernel.org/all/87plhwgbu6.fsf@suse.de/#t

Thread 1 (Thread 0x7fbc4849df80 (LWP 7487) "qemu-system-x86"):
#0  __memcpy_evex_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:274
#1  0x0000560b135103aa in flatview_read_continue_step (attrs=..., buf=0x560b168a5930 "U\252\022\006\016\a1\300\271", len=9216, mr_addr=831488, l=0x7fbc465ff980, mr=0x560b166c5070) at ../system/physmem.c:3056
#2  0x0000560b1351042e in flatview_read_continue (fv=0x560b16c606a0, addr=831488, attrs=..., ptr=0x560b168a5930, len=9216, mr_addr=831488, l=9216, mr=0x560b166c5070) at ../system/physmem.c:3073
#3  0x0000560b13510533 in flatview_read (fv=0x560b16c606a0, addr=831488, attrs=..., buf=0x560b168a5930, len=9216) at ../system/physmem.c:3103
#4  0x0000560b135105be in address_space_read_full (as=0x560b14970fc0 <address_space_memory>, addr=831488, attrs=..., buf=0x560b168a5930, len=9216) at ../system/physmem.c:3116
#5  0x0000560b135106e7 in address_space_rw (as=0x560b14970fc0 <address_space_memory>, addr=831488, attrs=..., buf=0x560b168a5930, len=9216, is_write=false) at ../system/physmem.c:3144
#6  0x0000560b13510848 in cpu_physical_memory_rw (addr=831488, buf=0x560b168a5930, len=9216, is_write=false) at ../system/physmem.c:3170
#7  0x0000560b1338f5a5 in cpu_physical_memory_read (addr=831488, buf=0x560b168a5930, len=9216) at qemu/include/exec/cpu-common.h:148
#8  0x0000560b1339063c in patch_hypercalls (s=0x560b168840c0) at ../hw/i386/vapic.c:547
#9  0x0000560b1339096d in vapic_prepare (s=0x560b168840c0) at ../hw/i386/vapic.c:629
#10 0x0000560b13390e8b in vapic_post_load (opaque=0x560b168840c0, version_id=1) at ../hw/i386/vapic.c:789
#11 0x0000560b135b4924 in vmstate_load_state (f=0x560b16c53400, vmsd=0x560b147c6cc0 <vmstate_vapic>, opaque=0x560b168840c0, version_id=1) at ../migration/vmstate.c:234
#12 0x0000560b132a15b8 in vmstate_load (f=0x560b16c53400, se=0x560b16893390) at ../migration/savevm.c:972
#13 0x0000560b132a4f28 in qemu_loadvm_section_start_full (f=0x560b16c53400, type=4 '\004') at ../migration/savevm.c:2746
#14 0x0000560b132a5ae8 in qemu_loadvm_state_main (f=0x560b16c53400, mis=0x560b16877f20) at ../migration/savevm.c:3058
#15 0x0000560b132a45d0 in loadvm_handle_cmd_packaged (mis=0x560b16877f20) at ../migration/savevm.c:2451
#16 0x0000560b132a4b36 in loadvm_process_command (f=0x560b168c3b60) at ../migration/savevm.c:2614
#17 0x0000560b132a5b96 in qemu_loadvm_state_main (f=0x560b168c3b60, mis=0x560b16877f20) at ../migration/savevm.c:3073
#18 0x0000560b132a5db7 in qemu_loadvm_state (f=0x560b168c3b60) at ../migration/savevm.c:3150
#19 0x0000560b13286271 in process_incoming_migration_co (opaque=0x0) at ../migration/migration.c:892
#20 0x0000560b137cb6d4 in coroutine_trampoline (i0=377836416, i1=22027) at ../util/coroutine-ucontext.c:175
#21 0x00007fbc4786a79e in ??? () at ../sysdeps/unix/sysv/linux/x86_64/__start_context.S:103

So _if_ the theory is correct, vapic's patch_hypercalls() might be reading
a zero page (with GPA 831488, over len=9216, which IIUC covers three
pages).  Maybe you can check when it'll be one zero page and when it will
be not, then maybe you can figure out how you make it always a zero page
hence reliably trigger a hang in post_load.

You could also try to write a program in guest, zeroing most pages first,
trigger migrate (hence send zero pages during multifd precopy), start
postcopy, then you should be able to observe vcpu hang at least before
postcopy completes.  However I don't think it'll hang forever, since if
migration all completes, UFFDIO_UNREGISTER will remove the userfaultfd
trackings and then kick all hang threads out, causing the fault to be
resolved right at the completion of postcopy.  So it won't really hang
forever like what Fabiano reported here.  Meanwhile we'll always want to
verify the original reproducer.. even if you could hang it temporarily in a
vcpu thread.

Thanks,

-- 
Peter Xu


