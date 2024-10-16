Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10EDD1AD4B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 11:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t12aW-0005t6-TI; Wed, 16 Oct 2024 07:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t12aV-0005rK-75
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 07:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1t12aT-0006Ti-7Y
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 07:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729079587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ylGMU0Eg2An+5nHweBWXyGzmcRsvXM62rOTJam6qa58=;
 b=IpnMEnAqXIEzTUN1uImboqgM0QhQswlVH4goURYpNIgv58Gtdg3uYVIhkVdA6YoySsAqDN
 iUdG/CgRw8N2IbNjmOkejqqVS/HR9ykNkVgd0IcBCLMUx6DXw8lfru0LqJA+HgFQ/2cs75
 cJyaCnWkS4tN6sBEieknQVIpCkHE0NE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-fzsDsOFCMx2V8BiedNiWHA-1; Wed, 16 Oct 2024 07:53:04 -0400
X-MC-Unique: fzsDsOFCMx2V8BiedNiWHA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d52ccc50eso2667798f8f.3
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 04:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729079583; x=1729684383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ylGMU0Eg2An+5nHweBWXyGzmcRsvXM62rOTJam6qa58=;
 b=KdcF4YSwEO22XzicJsaozVIoZ/Zna3fOdvOUwUO2FC23mFG5ImiMmGdMsXIQxvSYFl
 oFyYEYLFWQm+IfIyIwJOwYgsJD5hLePwqI5TrVaFb9stMsJkZDacX5H/qMoIun9+OXLh
 FGH46zWXRflsgIiF2MiDRREZsYgMkyoDAOS8xKphzz5WHZLK8OzUWhT1ee7LJZDiSplr
 PS6npl0F7km9Mo3dp5P2o4EExzkfVs9THcuSElTNiTiWKt9R2C0LJSYj4xwPAREOzACU
 bE+kG6Ek4B2Nmz+2HBJEMwPDZGYwSQynGbEGBUwXdmx5YbFPV5wCGAVa7keZqPv3Aaw2
 NONw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2vGrcmYr2C4GiBQDKW4A5+K/ooPHP2qHfyF3DyyDpHrcTXDV34v+XZidyjYeFZMJnhZ7gi6dk0nrK@nongnu.org
X-Gm-Message-State: AOJu0YzZmJ5Iq9nWuz+yvZyJ24oqUZ4dywMtccIoVS7B58B35KdxDYdR
 UERwP6wPUregqw1u57uCJQ9uBEz2sQKF8D8neMFuwei54jEIriZ20cU31dhu+aIYAPGNTn9rrpb
 eRB/XBYA/oC+eKgPJRKQPZNKyhdvp40y7Kj6ubPih00iM/I4JMz6J
X-Received: by 2002:adf:cd03:0:b0:378:fe6e:50ef with SMTP id
 ffacd0b85a97d-37d86bb66d1mr2325640f8f.5.1729079582732; 
 Wed, 16 Oct 2024 04:53:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaSw3zmopIbzACHsU1MMnmrye1bJbm0I/4/vm9++GhCFFSBwFvxeNscIhS2w/vuq0s155vAg==
X-Received: by 2002:adf:cd03:0:b0:378:fe6e:50ef with SMTP id
 ffacd0b85a97d-37d86bb66d1mr2325628f8f.5.1729079582275; 
 Wed, 16 Oct 2024 04:53:02 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc123e5sm4111096f8f.95.2024.10.16.04.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 04:53:01 -0700 (PDT)
Date: Wed, 16 Oct 2024 13:52:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org, vchundur@redhat.com, rjarry@redhat.com
Subject: Re: [PATCH v6 0/3] Add support for the RAPL MSRs series
Message-ID: <20241016135259.49021bca@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240522153453.1230389-1-aharivel@redhat.com>
References: <20240522153453.1230389-1-aharivel@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 22 May 2024 17:34:49 +0200
Anthony Harivel <aharivel@redhat.com> wrote:

> Dear maintainers, 
> 
> First of all, thank you very much for your review of my patch 
> [1].

I've tried to play with this feature and have a few questions about it

 1. trying to start with non accessible or not existent socket
        -accel kvm,rapl=on,rapl-helper-socket=/tmp/socket 
    I get:
      qemu-system-x86_64: -accel kvm,rapl=on,rapl-helper-socket=/tmp/socks: vmsr socket opening failed
      qemu-system-x86_64: -accel kvm,rapl=on,rapl-helper-socket=/tmp/socks: kvm : error RAPL feature requirement not met
    * is it possible to report actual OS error that happened during open/connect,
      instead of unhelpful 'socket opening failed'?

      What I see in vmsr_open_socket() error is ignored
      and btw it's error leak as well

    * 2nd line shouldn't be there if the 1st error already present.

 2.  getting periodic error on console where QEMU has been starter
      # ./qemu-vmsr-helper -k /tmp/sock
     ./qemu-system-x86_64 -snapshot -m 4G -accel kvm,rapl=on,rapl-helper-socket=/tmp/sock rhel90.img  -vnc :0 -cpu host
     and let it run

      it appears rdmsr works (well, it returns some values at least)
      however there are recurring errors in qemu's stderr(or out)
      
      qemu-system-x86_64: Error opening /proc/2496093/task/2496109/stat
      qemu-system-x86_64: Error opening /proc/2496093/task/2496095/stat

      My guess it's some temporary threads, that come and go, but still
      they shouldn't cause errors if it's normal operation.

      Also on daemon side, I a few times got while guest was running:
        qemu-vmsr-helper: Failed to open /proc at /proc/2496026/task/2496044
        qemu-vmsr-helper: Requested TID not in peer PID: 2496026 2496044
      though I can't reproduce it reliably

 3. when starting daemon not as root, it starts 'fine' but later on complains
      qemu-vmsr-helper: Failed to open MSR file at /dev/cpu/0/msr
    perhaps it would be better to fail at start daemon if it doesn't have
    access to necessary files.

 4. in case #3, guest also fails to start with errors:
      qemu-system-x86_64: -accel kvm,rapl=on,rapl-helper-socket=/tmp/sock: can't read any virtual msr
      qemu-system-x86_64: -accel kvm,rapl=on,rapl-helper-socket=/tmp/sock: kvm : error RAPL feature requirement not met
     again line #2 is not useful and probably not needed (maybe make it tracepoint)
     and #1 is unhelpful - it would be better if it directed user to check qemu-vmsr-helper

 5. does AMD have similar MSRs that we could use to make this feature complete?

 6. What happens to power accounting if host constantly migrates
    vcpus between sockets, are values we are getting still correct/meaningful?
    Or do we need to pin vcpus to get 'accurate' values?

 7. do we have to have a dedicated thread for pooling data from daemon?

    Can we fetch data from vcpu thread that have accessed msr
    (with some caching and rate limiting access to the daemon)?

> In this version (v6), I have attempted to address all the problems 
> addressed by Daniel and Paolo during the last review. 
> 
> However, two open questions remains unanswered that would require the 
> attention of a x86 maintainers: 
> 
> 1)Should I move from -kvm to -cpu the rapl feature ? [2]
> 
> 2)Should I already rename to "rapl_vmsr_*" in order to anticipate the 
>   futur TMPI architecture ? [end of 3] 
> 
> Thank you again for your continued guidance. 
> 
> v5 -> v6
> --------
> - Better error consistency in qio_channel_get_peerpid()
> - Memory leak g_strdup_printf/g_build_filename corrected
> - Renaming several struct with "vmsr_*" for better namespace
> - Renamed several struct with "guest_*" for better comprehension
> - Optimization suggerate from Daniel
> - Crash problem solved [4]
> 
> v4 -> v5
> --------
> 
> - correct qio_channel_get_peerpid: return pid = -1 in case of error
> - Vmsr_helper: compile only for x86
> - Vmsr_helper: use qio_channel_read/write_all
> - Vmsr_helper: abandon user/group
> - Vmsr_energy.c: correct all error_report
> - Vmsr thread: compute default socket path only once
> - Vmsr thread: open socket only once
> - Pass relevant QEMU CI
> 
> v3 -> v4
> --------
> 
> - Correct memory leaks with AddressSanitizer  
> - Add sanity check for QEMU and qemu-vmsr-helper for checking if host is 
>   INTEL and if RAPL is activated.
> - Rename poor variables naming for easier comprehension
> - Move code that checks Host before creating the VMSR thread
> - Get rid of libnuma: create function that read sysfs for reading the 
>   Host topology instead
> 
> v2 -> v3
> --------
> 
> - Move all memory allocations from Clib to Glib
> - Compile on *BSD (working on Linux only)
> - No more limitation on the virtual package: each vCPU that belongs to 
>   the same virtual package is giving the same results like expected on 
>   a real CPU.
>   This has been tested topology like:
>      -smp 4,sockets=2
>      -smp 16,sockets=4,cores=2,threads=2
> 
> v1 -> v2
> --------
> 
> - To overcome the CVE-2020-8694 a socket communication is created
>   to a priviliged helper
> - Add the priviliged helper (qemu-vmsr-helper)
> - Add SO_PEERCRED in qio channel socket
> 
> RFC -> v1
> ---------
> 
> - Add vmsr_* in front of all vmsr specific function
> - Change malloc()/calloc()... with all glib equivalent
> - Pre-allocate all dynamic memories when possible
> - Add a Documentation of implementation, limitation and usage
> 
> Best regards,
> Anthony
> 
> [1]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg01570.html
> [2]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg03947.html
> [3]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg02350.html
> [4]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg02481.html
> 
> Anthony Harivel (3):
>   qio: add support for SO_PEERCRED for socket channel
>   tools: build qemu-vmsr-helper
>   Add support for RAPL MSRs in KVM/Qemu
> 
>  accel/kvm/kvm-all.c                      |  27 ++
>  contrib/systemd/qemu-vmsr-helper.service |  15 +
>  contrib/systemd/qemu-vmsr-helper.socket  |   9 +
>  docs/specs/index.rst                     |   1 +
>  docs/specs/rapl-msr.rst                  | 155 +++++++
>  docs/tools/index.rst                     |   1 +
>  docs/tools/qemu-vmsr-helper.rst          |  89 ++++
>  include/io/channel.h                     |  21 +
>  include/sysemu/kvm_int.h                 |  32 ++
>  io/channel-socket.c                      |  28 ++
>  io/channel.c                             |  13 +
>  meson.build                              |   7 +
>  target/i386/cpu.h                        |   8 +
>  target/i386/kvm/kvm.c                    | 431 +++++++++++++++++-
>  target/i386/kvm/meson.build              |   1 +
>  target/i386/kvm/vmsr_energy.c            | 337 ++++++++++++++
>  target/i386/kvm/vmsr_energy.h            |  99 +++++
>  tools/i386/qemu-vmsr-helper.c            | 530 +++++++++++++++++++++++
>  tools/i386/rapl-msr-index.h              |  28 ++
>  19 files changed, 1831 insertions(+), 1 deletion(-)
>  create mode 100644 contrib/systemd/qemu-vmsr-helper.service
>  create mode 100644 contrib/systemd/qemu-vmsr-helper.socket
>  create mode 100644 docs/specs/rapl-msr.rst
>  create mode 100644 docs/tools/qemu-vmsr-helper.rst
>  create mode 100644 target/i386/kvm/vmsr_energy.c
>  create mode 100644 target/i386/kvm/vmsr_energy.h
>  create mode 100644 tools/i386/qemu-vmsr-helper.c
>  create mode 100644 tools/i386/rapl-msr-index.h
> 


