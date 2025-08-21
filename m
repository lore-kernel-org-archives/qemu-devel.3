Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8E4CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 14:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up6Hi-00076T-Bj; Thu, 21 Aug 2025 10:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1up6Hg-0006yK-TR
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1up6Ha-0006iJ-DN
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755786528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L51OVTmldxiGjbiUijwbCvWYsBNxnQW1+XHi6WZr0Jg=;
 b=a2kngV1SjbSC2Hg7wibL63RU/5KNftTh/68VR3TfFDaLXG4tuT1osUrUUci0f7Ywa4kliQ
 w0rPjFsRCiqNqanvznlBsCb7i5VRRAlp+pEQuAeAFu6bSOsffBQws9rIrDlW27SmTBoVmJ
 jzH15lmn8WWt2NRuwA9jdhzU6aR3C2o=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-7gbC1WBgOUaMTkQfsG3aAQ-1; Thu, 21 Aug 2025 10:28:47 -0400
X-MC-Unique: 7gbC1WBgOUaMTkQfsG3aAQ-1
X-Mimecast-MFC-AGG-ID: 7gbC1WBgOUaMTkQfsG3aAQ_1755786526
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7e8704d540cso117321585a.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 07:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755786526; x=1756391326;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L51OVTmldxiGjbiUijwbCvWYsBNxnQW1+XHi6WZr0Jg=;
 b=s4pJN/b2hnERU2rhJSuj0Myx5yhiMIcE2OaV8pD6hAD7EaPP4uK9/v1tFIsR4IGnId
 XQWcDDkTdB1do2B9ve26EtTmRL4JEyNzGbqmgVR+/o8xTNiZN9+xDQKb0oIXb+FmUK6e
 0hQzXGoZPY4jnguWjIVaFFNeXUgWCxwgmTkp4J/rcM7Qaq1f2f58YDkYyklcpe6bbPdF
 G1oNULqhajGjVhNdnUWyimqZajtJ1uQ5XLjhqW3bd4V4kadoC0IUAWkWoFNVUDiHkJ0g
 BZZs+IZgICGWrLnHB4ZtBDR17G2OCm1JAjuus1MV9YMFV54EUsMM9wcV7NQpfFd4AgQC
 MFdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWia3bvJHJF35hReKZSt0t9oQjE7X2CtFhm/6B/CpPDq6J97mUVMOh+DUi53aw+uQE/eyXlbEf6emwm@nongnu.org
X-Gm-Message-State: AOJu0YwaqTDeHF0FS4Uk0cEWBXSGADj9XlskppvKfLvIJU8z3kg8ehyy
 dfpLGbgiVclgrH3Aun/cSC2nnRrNOY61TpedkG3fphHVzJDjg0Fb9boq9XmuW6JPt/TxjmW/7mc
 PBQkitm4qrUKT4KkEPmn237yyd20BL+xR0+QnW2iKakc3EmFuvSNXZPzW
X-Gm-Gg: ASbGncv+GqMBo0fApw5QGGEtGyWa3Z4fYJMylxYeaifAlyy0qt1qPBUrrLQPTUwIPRs
 lKkES/ytbGaQxgaZxeZZ8L+ey8fbDpmEYZkzfq38+8y+2Mpa5UioqQPsOe1dDCcKFXC1npBU8CU
 GK5GduYxqDMFF8iWb5mv65L+2qczx5QewmQBWvp42QckcYwIMOl0LWgyqG52oNVkLF6VkRQlqjm
 uLlkCH+lkNHEP1nufqCeUIcyH7vLquAK40IMA6UCkPK+34ATFhviPxSv7e58piPqJgIcgwsc/CW
 SCP+jrXXJCM+rxjBERYjU8AWIsQHxs5n
X-Received: by 2002:a05:620a:1993:b0:7e6:252b:9b28 with SMTP id
 af79cd13be357-7ea08d95f58mr290865685a.33.1755786526275; 
 Thu, 21 Aug 2025 07:28:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtMy/eN4WzQkAz1QUx7ubbBNJw5OIAPb8d2zId/Kp76677sUgWM2FCgagD1bq3FV7wjCWDhQ==
X-Received: by 2002:a05:620a:1993:b0:7e6:252b:9b28 with SMTP id
 af79cd13be357-7ea08d95f58mr290859685a.33.1755786525512; 
 Thu, 21 Aug 2025 07:28:45 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e87e0204f3sm1152556585a.9.2025.08.21.07.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 07:28:44 -0700 (PDT)
Date: Thu, 21 Aug 2025 10:28:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 devel@daynix.com
Subject: Re: [PATCH v8 2/2] memory: Do not create circular reference with
 subregion
Message-ID: <aKctCjv8newNIX71@x1.local>
References: <20250110-san-v8-0-57a5a1be1bcf@daynix.com>
 <20250110-san-v8-2-57a5a1be1bcf@daynix.com>
 <CAFEAcA-aTYebu-5s4AeBfE3oLQfxTwCpeosoj0TU8E_XPu_ZDg@mail.gmail.com>
 <CAFEAcA-ygHuA5BH+oftCGDKZOh8CHbiUKE4v=-iXvCaKzG4kHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-ygHuA5BH+oftCGDKZOh8CHbiUKE4v=-iXvCaKzG4kHQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 21, 2025 at 01:45:20PM +0100, Peter Maydell wrote:
> (updated cc list with Akihiko's new email address)
> 
> On Thu, 21 Aug 2025 at 13:40, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Fri, 10 Jan 2025 at 09:20, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> > >
> > > memory_region_update_container_subregions() used to call
> > > memory_region_ref(), which creates a reference to the owner of the
> > > subregion, on behalf of the owner of the container. This results in a
> > > circular reference if the subregion and container have the same owner.
> > >
> > > memory_region_ref() creates a reference to the owner instead of the
> > > memory region to match the lifetime of the owner and memory region. We
> > > do not need such a hack if the subregion and container have the same
> > > owner because the owner will be alive as long as the container is.
> > > Therefore, create a reference to the subregion itself instead ot its
> > > owner in such a case; the reference to the subregion is still necessary
> > > to ensure that the subregion gets finalized after the container.
> > >
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > Reviewed-by: Peter Xu <peterx@redhat.com>
> >
> > Hi; I came back to this patchset because it was never applied,
> > and so we still have various leaks of MemoryRegion objects
> > in devices which use the "device owns a container MemoryRegion C
> > and puts another MemoryRegion X which it owns into that container"
> > pattern.
> >
> > Unfortunately, with this patch applied, I see a segfault when running
> > the device-introspect-test for Arm:
> >
> > $ (cd build/x86 && QTEST_QEMU_BINARY=./qemu-system-arm
> > ./tests/qtest/device-introspect-test -p
> > /arm/device/introspect/concrete/defaults/none)
> > [...]
> > # Testing device 'imx7.analog'
> > Broken pipe
> > ../../tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from
> > signal 11 (Segmentation fault) (core dumped)
> >
> > Here's a backtrace collected with gdb:
> >
> > $ (cd build/x86 && QTEST_QEMU_BINARY="xterm -e gdb --tty $(tty) --args
> > ./qemu-system-arm" ./tests/qtest/device-introspect-test -p
> > /arm/device/introspect/concrete/defaults/none)
> > [hit 'r' in the gdb prompt in the new window]
> >
> > Thread 1 "qemu-system-arm" received signal SIGSEGV, Segmentation fault.
> > memory_region_unref_subregion (subregion=0x555557d58370) at
> > ../../system/memory.c:1862
> > 1862        if (subregion->container->owner == subregion->owner) {
> > (gdb) bt
> > #0  memory_region_unref_subregion (subregion=0x555557d58370) at
> > ../../system/memory.c:1862
> > #1  0x0000555555d5f97b in memory_region_del_subregion
> > (mr=0x555557d58150, subregion=0x555557d58370)
> >     at ../../system/memory.c:2705
> > #2  0x0000555555d5cc1c in memory_region_finalize (obj=0x555557d58150)
> > at ../../system/memory.c:1811
> > #3  0x0000555556197595 in object_deinit (obj=0x555557d58150,
> > type=0x5555579d2ea0) at ../../qom/object.c:715
> > #4  0x0000555556197613 in object_finalize (data=0x555557d58150) at
> > ../../qom/object.c:729
> > #5  0x00005555561988f9 in object_unref (objptr=0x555557d58150) at
> > ../../qom/object.c:1232
> > #6  0x000055555619a3d6 in object_finalize_child_property
> >     (obj=0x555557d57e20, name=0x555557c59810 "imx7.analog[0]",
> > opaque=0x555557d58150) at ../../qom/object.c:1818
> > #7  0x0000555556197344 in object_property_del_all (obj=0x555557d57e20)
> > at ../../qom/object.c:667
> > #8  0x0000555556197600 in object_finalize (data=0x555557d57e20) at
> > ../../qom/object.c:728
> > #9  0x00005555561988f9 in object_unref (objptr=0x555557d57e20) at
> > ../../qom/object.c:1232
> > #10 0x00005555562f4600 in qmp_device_list_properties
> > (typename=0x555557d3ee70 "imx7.analog", errp=0x7fffffffdc00)
> >     at ../../qom/qom-qmp-cmds.c:237
> > #11 0x00005555563981ba in qmp_marshal_device_list_properties
> > (args=0x7fffe00031f0, ret=0x7fffef6afda8, errp=0x7fffef6afda0)
> >     at qapi/qapi-commands-qdev.c:65
> > #12 0x00005555563bcb53 in do_qmp_dispatch_bh (opaque=0x7fffef6afe40)
> > at ../../qapi/qmp-dispatch.c:128
> > #13 0x00005555563ed87f in aio_bh_call (bh=0x555557d3f540) at
> > ../../util/async.c:172
> > #14 0x00005555563ed9cb in aio_bh_poll (ctx=0x555557a00770) at
> > ../../util/async.c:219
> > #15 0x00005555563cd517 in aio_dispatch (ctx=0x555557a00770) at
> > ../../util/aio-posix.c:436
> > #16 0x00005555563edebe in aio_ctx_dispatch (source=0x555557a00770,
> > callback=0x0, user_data=0x0) at ../../util/async.c:361
> > #17 0x00007ffff6e965c5 in ??? () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > #18 0x00007ffff6e96710 in g_main_context_dispatch () at
> > /lib/x86_64-linux-gnu/libglib-2.0.so.0
> > #19 0x00005555563ef89e in glib_pollfds_poll () at ../../util/main-loop.c:287
> > #20 0x00005555563ef930 in os_host_main_loop_wait (timeout=0) at
> > ../../util/main-loop.c:310
> > #21 0x00005555563efa6b in main_loop_wait (nonblocking=0) at
> > ../../util/main-loop.c:589
> > #22 0x0000555555d7d181 in qemu_main_loop () at ../../system/runstate.c:905
> > #23 0x00005555562f94c7 in qemu_default_main (opaque=0x0) at
> > ../../system/main.c:50
> > #24 0x00005555562f9585 in main (argc=18, argv=0x7fffffffe078) at
> > ../../system/main.c:93
> >
> >
> > In memory_region_unref_subregion(), subregion->container is NULL.
> >
> > This is because in memory_region_del_subregion() we do:
> >
> >     subregion->container = NULL;
> >
> > and then after that we call
> >     memory_region_unref_subregion(subregion);
> > which dereferences subregion->container.
> >
> > Won't this always SEGV ?
> >
> > thanks
> > -- PMM
> 

Peter, could you try the v3 version patch 8/9 instead?

https://lore.kernel.org/all/20240708-san-v3-8-b03f671c40c6@daynix.com/

I still prefer that one, and I hope that one doesn't have this issue.

If no one objects, IMHO we could merge v3's patch 8/9, and v8's patch 1 (I
can touch up some commit messages and details, e.g. v3's 8/9 commit
message is a bit too simple to me).

Thanks,

-- 
Peter Xu


