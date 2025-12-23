Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A61E6FE24
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 17:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY5tg-0001Ed-6E; Tue, 23 Dec 2025 12:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY5te-0001EF-AE
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 12:10:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY5tc-00027t-IW
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 12:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766509803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DywxrOPpVRV7+CbJ4zZNnAVUrOA+xZf6EH9KfsL2QPg=;
 b=G8QVywUZJ0yaPjM4UEQJwhHErDP/NCUwpY6eX8WKkI5lkub4DQ9/ICE++3EgC5rUHzIPmZ
 cc2AYh+MQHLVOv0PLkLBTRIXIHf7xd+LYaOElo38L65EaZhmYqPgFY71P7+6hIw5GWL4k8
 Fw/Ro+cHT9OIU1Ip4KJORFBSTqeA+uo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-rHh67bCnOUiztErCurXtnQ-1; Tue, 23 Dec 2025 12:10:01 -0500
X-MC-Unique: rHh67bCnOUiztErCurXtnQ-1
X-Mimecast-MFC-AGG-ID: rHh67bCnOUiztErCurXtnQ_1766509801
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b4f267ba01so1588047585a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 09:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766509801; x=1767114601; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DywxrOPpVRV7+CbJ4zZNnAVUrOA+xZf6EH9KfsL2QPg=;
 b=d26nH+F/j9kWqoUvfGYUpr/Zr0BVihgbP6V6ldSKL9PBlrOA669qXoDToaUBmKR9pW
 n4GcYhcbGGpFwpRuRMjl0xCuMYXoMKM0/kqRunhjKUsZRobYxJS79EeidAVRZWB9DJOT
 oRgqPehFxEHwKg/RrOn7s8b+ggOta1btK/5JcHPPKVhyhjgmmqtwDEUfcC/91EWjekz2
 nnYVassAWKXQYMMhKQ+UbXQea3cXDDV3uslaTYpQilnakltxRRX0XEmixxjdTa74OmDZ
 zFXey0VUXZPqDdl0mDlaXVPxR0H44ugu4j8a+Dma1U7lobFyWwPbrkQUICafJbE7k4gc
 Xwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766509801; x=1767114601;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DywxrOPpVRV7+CbJ4zZNnAVUrOA+xZf6EH9KfsL2QPg=;
 b=UIA+TEV4cceErMgPhc2ZCL9EE1drUbqtxf9bSDxdnsut65UYmuE6mPY/+ka1vF2pdg
 YhWBVAcmBKrB1tDhLuFKl0AhO0InPJ9nvHBBwqWQSS7ldSsN4cGaZqvjlSpwemdurOkz
 ZpOvGWLGwV1EQih1CGlIFJiTqsj8uABsxfyz2TvKtYvDZEyVy2ULqJpDR2AXOo6Tmj5B
 suX/S8CrnNlkUXBvGWJCvZGyY+oVaCSf3UtuC6y6ofGHloH/sJdwQyBDCejLpM0Ajcv1
 /L2fRA/QgXKaJuJmj7tp9Yb2hMXAock7eMIrPNMzUsngjJ9e3Bm7OEokabHs+8U12FRl
 uVGg==
X-Gm-Message-State: AOJu0Yx3m1pt2r+4Wel3xfqBnm7Nu1H/lopgeJromCZt6x8kCve+bmXK
 TqFJkBoqN4g2yufRXBoMdV+WdoVnaBq34LsAmSYdxwSCxXcqiRWTr6QMVU4yykknURFWU4mJiNT
 AkIQidwaaEYBtIE3s3z/eFoTD/iFIlCbzQHiim9a+J3V1mAfkRSYHMQ3R
X-Gm-Gg: AY/fxX4BD3egOdHj8DyxUikLkHBmTLP2i7WPhDasXaOKZ12hCaWW+EQTdrp1TGxl3/9
 j+g+/+2X0x1eLZqScAedAeFpoa7uU5h8W2Rol6e2lvsqyk4FftOjMOCtRtUy0vb/uJSFlhoev3f
 GaVvgaNuLihbpb5xcIBazEfopq0Tl8hrlU09ZOKhI5smTSZcWDjEK/Q+OzRF+Zb0a6UxxWgSrPN
 DRVnS5Z7qX6WKhyG72SNbCmDepeXl03XmCkrWDAtGyleAUuhFvDj1aLDwvsX6oIYnASaYkgxurJ
 dHJPASblegfNJ5Q+vj5Gbd5B1NFVY6vP7ZgSzY3IpQJwDn9SUvDb9FrW/FWEK7sV2rtpXuazJPg
 rZ58=
X-Received: by 2002:a05:620a:3725:b0:8ac:70cd:8727 with SMTP id
 af79cd13be357-8bee6820715mr2545068585a.11.1766509801212; 
 Tue, 23 Dec 2025 09:10:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdBa4a5hCrk53bOAvDlphVFKGgvrC0KemjzomCV5lb7aty9coWDXseB3BBIosEaAdlEAiG7Q==
X-Received: by 2002:a05:620a:3725:b0:8ac:70cd:8727 with SMTP id
 af79cd13be357-8bee6820715mr2545062785a.11.1766509800691; 
 Tue, 23 Dec 2025 09:10:00 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c095b79b32sm1104060385a.0.2025.12.23.09.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 09:10:00 -0800 (PST)
Date: Tue, 23 Dec 2025 12:09:59 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 11/12] tests/migration-test: Support guest-memfd init
 shared mem type
Message-ID: <aUrM55V7xNdlxKXd@x1.local>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-12-peterx@redhat.com>
 <87qzsu1pdj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87qzsu1pdj.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Dec 16, 2025 at 11:18:48AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Support the guest-memfd type when the fd has init share enabled.  It means
> > the gmemfd can be used similarly to memfd.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tests/qtest/migration/framework.h |  4 +++
> >  tests/qtest/migration/framework.c | 60 +++++++++++++++++++++++++++++++
> >  2 files changed, 64 insertions(+)
> >
> > diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> > index ed85ed502d..b4c5edcad3 100644
> > --- a/tests/qtest/migration/framework.h
> > +++ b/tests/qtest/migration/framework.h
> > @@ -34,6 +34,10 @@ typedef enum {
> >       * but only anonymously allocated.
> >       */
> >      MEM_TYPE_MEMFD,
> > +    /*
> > +     * Use guest-memfd, shared mappings.
> > +     */
> > +    MEM_TYPE_GUEST_MEMFD,
> >      MEM_TYPE_NUM,
> >  } MemType;
> >  
> > diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> > index e35839c95f..9aa353bac6 100644
> > --- a/tests/qtest/migration/framework.c
> > +++ b/tests/qtest/migration/framework.c
> > @@ -26,6 +26,10 @@
> >  #include "qemu/range.h"
> >  #include "qemu/sockets.h"
> >  
> > +#ifdef CONFIG_LINUX
> > +#include <linux/kvm.h>
> > +#include <sys/ioctl.h>
> > +#endif
> >  
> >  #define QEMU_VM_FILE_MAGIC 0x5145564d
> >  #define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
> > @@ -283,6 +287,9 @@ static char *migrate_mem_type_get_opts(MemType type, const char *memory_size)
> >      case MEM_TYPE_MEMFD:
> >          backend = g_strdup("-object memory-backend-memfd");
> >          break;
> > +    case MEM_TYPE_GUEST_MEMFD:
> > +        backend = g_strdup("-object memory-backend-memfd,guest-memfd=on");
> > +        break;
> >      default:
> >          g_assert_not_reached();
> >          break;
> > @@ -425,8 +432,55 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
> >      return 0;
> >  }
> >  
> > +static bool kvm_guest_memfd_init_shared_supported(const char **reason)
> 
> Should be in migration-util.c, like kvm_dirty_ring_supported() and
> ufd_version_check().

Ah.. sure.

> 
> > +{
> > +    assert(*reason == NULL);
> > +
> > +#ifdef CONFIG_LINUX
> > +    int ret, fd = -1;
> > +
> > +    if (!migration_get_env()->has_kvm) {
> > +        *reason = "KVM is not enabled in the current QEMU build";
> > +        goto out;
> > +    }
> > +
> > +    fd = open("/dev/kvm", O_RDWR);
> > +    if (fd < 0) {
> > +        *reason = "KVM module isn't available or missing permission";
> > +        goto out;
> > +    }
> > +
> > +    ret = ioctl(fd, KVM_CHECK_EXTENSION, KVM_CAP_GUEST_MEMFD);
> > +    if (!ret) {
> > +        *reason = "KVM module doesn't suport guest-memfd";
> > +        goto out;
> > +    }
> > +
> > +    ret = ioctl(fd, KVM_CHECK_EXTENSION, KVM_CAP_GUEST_MEMFD_FLAGS);
> > +    if (ret < 0) {
> 
> Should this be <= ? I see there's a window between the addition of
> KVM_CAP_GUEST_MEMFD and KVM_CAP_GUEST_MEMFD_FLAGS in the kernel.

That was checked right below [1], so ret==0 will fail with a better error
message:

> 
> > +        *reason = "KVM doesn't support KVM_CAP_GUEST_MEMFD_FLAGS";
> > +        goto out;
> > +    }
> > +
> > +    if (!(ret & GUEST_MEMFD_FLAG_INIT_SHARED)) {

[1]

> > +        *reason = "KVM doesn't support GUEST_MEMFD_FLAG_INIT_SHARED";
> > +        goto out;
> > +    }
> > +out:
> > +    if (fd >= 0) {
> > +        close(fd);
> > +    }
> > +#else
> > +    *reason = "KVM not supported on non-Linux OS";
> > +#endif
> > +
> > +    return !*reason;
> > +}
> > +
> >  static bool migrate_mem_type_prepare(MemType type)
> >  {
> > +    const char *reason = NULL;
> > +
> >      switch (type) {
> >      case MEM_TYPE_SHMEM:
> >          if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
> > @@ -434,6 +488,12 @@ static bool migrate_mem_type_prepare(MemType type)
> >              return false;
> >          }
> >          break;
> > +    case MEM_TYPE_GUEST_MEMFD:
> > +        if (!kvm_guest_memfd_init_shared_supported(&reason)) {
> > +            g_test_skip(reason);
> > +            return false;
> > +        }
> > +        break;
> >      default:
> >          break;
> >      }
> 

-- 
Peter Xu


