Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83194C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 10:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvEb6-0003ny-3M; Fri, 12 Apr 2024 06:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvEb4-0003nn-Io
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvEb2-0002oA-OG
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712919446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iX6PY019KK5Q4iyxtJjKm24XtntqPypJawDHsWcVsTo=;
 b=F9EO1V6mX055ciMR5IiY7SHg9L0FlTIZvpjJCT7B3lGv4n9JtM/2EGXiiHxwC9aCVTIbr4
 26y85ElbsSVig9SGD8sFuu/k2jV73RooIqrWG/5k9Q2RNQn45epnugmj9zmYmBdQacViSC
 OWMGIjo+IkmXoY/Qz2CIIdursuATbOk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-IzknvvHAMpCEm2MQWua1Aw-1; Fri, 12 Apr 2024 06:57:25 -0400
X-MC-Unique: IzknvvHAMpCEm2MQWua1Aw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-343d7cd8f46so455258f8f.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 03:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712919444; x=1713524244;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iX6PY019KK5Q4iyxtJjKm24XtntqPypJawDHsWcVsTo=;
 b=nwJcEhb/p0r+do5ltZygz9tMqWwPOjEm4p3053dWdWSukBXNrRvtlWC94f8ProsW0p
 tVaFtGJ2vko0SpqNiClnMEqy/iwteb+paFqwFasMkz7sNviq574p2k0m+J534c4vYdas
 l+yXVCBFrmVhXUtYj1fl4OykjmMDCXnKoLJCBoqXyLl5pSIZf6bjnr6VcKSpDoSBdhl/
 wVaqoY0oItEw7UADhikjqW6WLB03aOvmByMxbCICIC0sqzDP+1W4G6UtwugtyAoeYO0J
 Ay57XU0DMz6pjfO+7Yh7V3X64XwWrNdIBvrk8RkG8TGVdXXil4mYQc/jGwQjrR96k9Tx
 UWUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtK3YBoSAX1xvpkcAsnaYG++zGJEmTQOCx04xdBIatLRLkA/FjMShGmbFCBXPQc7EZ/Xk8a3cccuJxrzIuq6tyZ4Eesz0=
X-Gm-Message-State: AOJu0YyE4qCzHxm3mln6Qe+vz6Q5v7O5BWb9DjuJTEZiJtPU8sICJt7i
 /ySUfz5Zpz0ZXir/ufhYFILf91m2LdT6HlXtFq3jUT9m5EfPf+W8fWIM/RcYFp10EAkLc7+sv5W
 zSjqitxmgpT1H9FIlC90BTMEpAipXiqSExKmOtgL86rnE0rAkRUBVtAKK2LJUQ7Bwtxzz+ZdMn4
 uTbuLHNjFgybb+lsJlBQxRNfqOYqE=
X-Received: by 2002:adf:ed88:0:b0:347:62e:b606 with SMTP id
 c8-20020adfed88000000b00347062eb606mr877486wro.11.1712919444069; 
 Fri, 12 Apr 2024 03:57:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrnkEkCcAZSxnJqVr9asaxW7HrvBNZ34sj+9nz8DKOjyObejnyDZ8+McMT4KeqepJH5r3dfgQLXgKBWBWpq14=
X-Received: by 2002:adf:ed88:0:b0:347:62e:b606 with SMTP id
 c8-20020adfed88000000b00347062eb606mr877479wro.11.1712919443757; Fri, 12 Apr
 2024 03:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240411121434.253353-1-aharivel@redhat.com>
In-Reply-To: <20240411121434.253353-1-aharivel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Apr 2024 12:57:11 +0200
Message-ID: <CABgObfamLi+Nz1sTC7PaDFg6jXT=4521SO11gbTysBo08jyp3g@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add support for the RAPL MSRs series
To: Anthony Harivel <aharivel@redhat.com>
Cc: mtosatti@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org, 
 vchundur@redhat.com, rjarry@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 11, 2024 at 2:14=E2=80=AFPM Anthony Harivel <aharivel@redhat.co=
m> wrote:
>
> Dear maintainers,
>
> First of all, thank you very much for your review of my patch
> [1].
>
> In this version (v5), I have attempted to address all the problems
> addressed by Daniel during the last review. I've been more careful with
> all the remarks made.
>
> However, one question remains unanswered pointing the issue with the
> location of "/var/local/run/qemu-vmsr-helper.sock", created by
> compute_default_paths(). QEMU is not allowed to reach the socket here.

If I understand correctly the question, that is expected. This is a
privileged functionality and therefore it requires manual intervention
to change the owner of the socket and allow QEMU to access it.

Paolo

> Thank you again for your continued guidance.
>
> v4 -> v5
> --------
>
> - correct qio_channel_get_peerpid: return pid =3D -1 in case of error
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
>      -smp 4,sockets=3D2
>      -smp 16,sockets=3D4,cores=3D2,threads=3D2
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
> [1]: https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg04417.html
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
>  include/sysemu/kvm.h                     |   2 +
>  include/sysemu/kvm_int.h                 |  32 ++
>  io/channel-socket.c                      |  28 ++
>  io/channel.c                             |  13 +
>  meson.build                              |   7 +
>  target/i386/cpu.h                        |   8 +
>  target/i386/kvm/kvm-cpu.c                |   9 +
>  target/i386/kvm/kvm.c                    | 428 ++++++++++++++++++
>  target/i386/kvm/meson.build              |   1 +
>  target/i386/kvm/vmsr_energy.c            | 335 ++++++++++++++
>  target/i386/kvm/vmsr_energy.h            |  99 +++++
>  tools/i386/qemu-vmsr-helper.c            | 529 +++++++++++++++++++++++
>  tools/i386/rapl-msr-index.h              |  28 ++
>  21 files changed, 1837 insertions(+)
>  create mode 100644 contrib/systemd/qemu-vmsr-helper.service
>  create mode 100644 contrib/systemd/qemu-vmsr-helper.socket
>  create mode 100644 docs/specs/rapl-msr.rst
>  create mode 100644 docs/tools/qemu-vmsr-helper.rst
>  create mode 100644 target/i386/kvm/vmsr_energy.c
>  create mode 100644 target/i386/kvm/vmsr_energy.h
>  create mode 100644 tools/i386/qemu-vmsr-helper.c
>  create mode 100644 tools/i386/rapl-msr-index.h
>
> --
> 2.44.0
>


