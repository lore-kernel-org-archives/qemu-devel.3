Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DB8C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 07:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIMgh-0007il-G6; Fri, 23 May 2025 03:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIMge-0007iI-E7
 for qemu-devel@nongnu.org; Fri, 23 May 2025 03:19:24 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uIMgb-0004gr-E5
 for qemu-devel@nongnu.org; Fri, 23 May 2025 03:19:24 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-af5085f7861so5666077a12.3
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 00:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747984758; x=1748589558;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BE9Cj4wjyVkmC10ajXeVohkOF58CJrSGnrxEZFR6L9E=;
 b=XNPjCWxdO9GvgTLcTgMJd+QUx/wmWTB6pOlk2seOGtPdQtYNPmZXyYX9z32IEG3Tcu
 G3A3jDOZX6uKHL3F6U3E+QDm8eySNRm6xpBJTIhxiV/PGJK1ij5TxT+Yd8hh0zoXX7fc
 MrBVjo2gBVKKLqd7/GJJEORzlibM3Et+nhGoV+03U6i2ajMWn4Ulm8Ok/ipJsh1CgFYr
 yBI5TtCX8qwG8yZ26WR3S24xJta4I+vTzxHWYQ21tb0/nBxeeeHJL0eeV1IFwUMe8Ha6
 Cj+b/kuRSpp71XnWoWQ4r4M+YuQLIOtYD/93UEr59bhXrOc5Q/iVDmC/kj930DiIJgyu
 DLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747984758; x=1748589558;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BE9Cj4wjyVkmC10ajXeVohkOF58CJrSGnrxEZFR6L9E=;
 b=CemolzHfeH6g/hnnyDa8tSXxwIBGthAMvo5C607L9P/qTMVES3alte6vhFYv82dnGp
 ChQK75qmDcH7Z3ZnM4iGd1Oc47En1cXXvcsGJeutSngTqBkJ2FuhxuAAR7647wGNMuFN
 2stwd6cUWq95FxmgU9CxO4PpIUKJBudTdaG1d41oUj/eSDygpnbljjhV7fAlUhiBrPe1
 i0DtKda14oJmtogjr9ZNNZAyvCiDPOK4tnzly5BPPU01d7OjoaOGP7z7D7Ay0eDgpQ0v
 89dU+fDEXxYfLb2zTiYa3az8SRYDUvFqHFLttNazyisw6PJayEznlkwP6w0n7HsuPtTm
 ti6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5WRgAymj5A+vGlOFyJrZN//5U1vhAIcd8vGdatfdDk0WoeD4d8KQN5rDlmDgxYfvZcazlb7Kk+T5U@nongnu.org
X-Gm-Message-State: AOJu0Yz9FkeoKCzgQlQw+CswJd0v22PwD7BS5mpiQ33BHlJEBF4ZySdK
 +V/ErgoYucmz0yQr9CuI58SmuQVNRvuuqxsKhYrRYW6cayyv3kH6rsNo65myCFIVTVIhOyor4Py
 DZT9s
X-Gm-Gg: ASbGncvZyVG5J5rc2IDdL8mLuCGcRhODcySEJTfT1Lu4cVtgVIrkNTABLk/Jkjyfc7O
 TrsqOZTpQtVueCzVkKb38l+7WKnk9TSshaeLwvB1/ksxlAvEXnLC+ebufBOsI3s0TwfzFjBfT2S
 K/5o52uYRZscBPA4p8XP81J81LKdWJo+kzsL/Oiebmein8Iog2ZoyHJTIkTit/zyM1Xr9n32DTQ
 q6HDUd6DDMw9wHTNv2UocFv3Qd/sQoE2yqk7oy5RkG006W49F3O5PMzVXmZ4tQ0RiWcFHol6NbH
 OKkNWRcri0G6msDH3cv1Ui5e2g1YA9MfJr38TBHjVbwUCJYNBdKyEBfrg+DEZw==
X-Google-Smtp-Source: AGHT+IGQPf2LXS8n5y2PRscFSyVqlmBRLT0jaDORLl68o4E8HaleQjuBvBF0jKG5RYiAmB2ZTyPm5g==
X-Received: by 2002:a17:902:ec89:b0:224:93e:b5d7 with SMTP id
 d9443c01a7336-231de370eb9mr388956705ad.34.1747984758158; 
 Fri, 23 May 2025 00:19:18 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ebb168sm117819985ad.204.2025.05.23.00.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 00:19:17 -0700 (PDT)
Message-ID: <29808015-f8b3-4e18-8d1d-5280bda4ee3d@daynix.com>
Date: Fri, 23 May 2025 16:19:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/16] virtio: introduce support for GSO over UDP
 tunnel
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <cover.1747825544.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/05/21 20:33, Paolo Abeni wrote:
> Some virtualized deployments use UDP tunnel pervasively and are impacted
> negatively by the lack of GSO support for such kind of traffic in the
> virtual NIC driver.
> 
> The virtio_net specification recently introduced support for GSO over
> UDP tunnel, this series updates the virtio implementation to support
> such a feature.
> 
> One of the reasons for the RFC tag is that the kernel-side
> implementation has just been shared upstream and is not merged yet, but
> there are also other relevant reasons, see below.
> 
> Currently, the kernel virtio support limits the feature space to 64 bits,
> while the virtio specification allows for a larger number of features.
> Specifically, the GSO-over-UDP-tunnel-related virtio features use bits
> 65-69; the larger part of this series (patches 2-11) actually deals with
> the extended feature space.
> 
> I tried to minimize the otherwise very large code churn by limiting the
> extended features support to arches with native 128 integer support and
> introducing the extended features space support only in virtio/vhost
> core and in the relevant device driver.

What about adding another 64-bit integer to hold the high bits? It makes 
adding the 128-bit integer type to VMState and properties and 
CONFIG_INT128 checks unnecessary.

> 
> The actual offload implementation is in patches 12-16 and boils down to
> propagating the new offload to the tun devices and the vhost backend.
> 
> Tested with basic stream transfer with all the possible permutations of
> host kernel/qemu/guest kernel with/without GSO over UDP tunnel support
> and vs snapshots creation and restore.
> 
> Notably this does not include (yet) any additional tests. Some guidance
> on such matter would be really appreciated, and any feedback about the
> features extension strategy would be more than welcome!

My proposal to add a feature to tap devices[1] simply omitted tests and 
I wrote simple testing scripts for my personal usage. As you can see, 
there is no testing code that covers tap devices, unfortunately, and I 
think adding one takes significant effort.

[1] https://patchew.org/QEMU/20250313-hash-v4-0-c75c494b495e@daynix.com/

> 
> Paolo Abeni (16):
>    linux-headers: Update to Linux v6.15-rc net-next
>    migration: introduce support for 128 bit int state.
>    virtio: introduce extended features type
>    virtio: serialize extended features state
>    qmp: update virtio features map to support extended features
>    virtio: add support for negotiating extended features.
>    virtio-pci: implement support for extended features.
>    vhost: add support for negotiating extended features.
>    vhost-backend: implement extended features support.
>    vhost-net: implement extended features support.
>    qdev-properties: add property for extended virtio features
>    virtio-net: implement extended features support.
>    net: implement tunnel probing
>    net: bundle all offloads in a single struct
>    net: implement tnl feature offloading
>    net: make vhost-net aware of GSO over UDP tunnel hdr layout
> 
>   hw/core/qdev-properties.c                     |  46 +++++
>   hw/net/e1000e_core.c                          |   5 +-
>   hw/net/igb_core.c                             |   5 +-
>   hw/net/vhost_net-stub.c                       |   7 +-
>   hw/net/vhost_net.c                            |  35 ++--
>   hw/net/virtio-net.c                           | 195 +++++++++++++-----
>   hw/net/vmxnet3.c                              |  13 +-
>   hw/virtio/vhost-backend.c                     |  59 +++++-
>   hw/virtio/vhost.c                             |  58 ++++--
>   hw/virtio/virtio-bus.c                        |  15 +-
>   hw/virtio/virtio-hmp-cmds.c                   |   3 +-
>   hw/virtio/virtio-pci.c                        |  19 +-
>   hw/virtio/virtio-qmp.c                        |  28 ++-
>   hw/virtio/virtio-qmp.h                        |   3 +-
>   hw/virtio/virtio.c                            | 103 ++++++++-
>   include/hw/qdev-properties.h                  |  13 ++
>   include/hw/virtio/vhost-backend.h             |  10 +
>   include/hw/virtio/vhost.h                     |  13 +-
>   include/hw/virtio/virtio-features.h           |  90 ++++++++
>   include/hw/virtio/virtio-net.h                |   2 +-
>   include/hw/virtio/virtio-pci.h                |   2 +-
>   include/hw/virtio/virtio.h                    |  17 +-
>   include/migration/qemu-file-types.h           |  15 ++
>   include/migration/vmstate.h                   |  11 +
>   include/net/net.h                             |  20 +-
>   include/net/vhost_net.h                       |   8 +-
>   include/standard-headers/asm-x86/setup_data.h |   4 +-
>   include/standard-headers/drm/drm_fourcc.h     |  41 ++++
>   include/standard-headers/linux/const.h        |   2 +-
>   include/standard-headers/linux/ethtool.h      | 156 ++++++++------
>   include/standard-headers/linux/fuse.h         |  12 +-
>   include/standard-headers/linux/pci_regs.h     |  13 +-
>   include/standard-headers/linux/virtio_net.h   |  46 +++++
>   include/standard-headers/linux/virtio_pci.h   |   1 +
>   include/standard-headers/linux/virtio_snd.h   |   2 +-
>   linux-headers/asm-arm64/kvm.h                 |  11 +
>   linux-headers/asm-arm64/unistd_64.h           |   1 +
>   linux-headers/asm-generic/mman-common.h       |   1 +
>   linux-headers/asm-generic/unistd.h            |   4 +-
>   linux-headers/asm-loongarch/unistd_64.h       |   1 +
>   linux-headers/asm-mips/unistd_n32.h           |   1 +
>   linux-headers/asm-mips/unistd_n64.h           |   1 +
>   linux-headers/asm-mips/unistd_o32.h           |   1 +
>   linux-headers/asm-powerpc/unistd_32.h         |   1 +
>   linux-headers/asm-powerpc/unistd_64.h         |   1 +
>   linux-headers/asm-riscv/kvm.h                 |   2 +
>   linux-headers/asm-riscv/unistd_32.h           |   1 +
>   linux-headers/asm-riscv/unistd_64.h           |   1 +
>   linux-headers/asm-s390/unistd_32.h            |   1 +
>   linux-headers/asm-s390/unistd_64.h            |   1 +
>   linux-headers/asm-x86/kvm.h                   |   3 +
>   linux-headers/asm-x86/unistd_32.h             |   1 +
>   linux-headers/asm-x86/unistd_64.h             |   1 +
>   linux-headers/asm-x86/unistd_x32.h            |   1 +
>   linux-headers/linux/bits.h                    |   8 +-
>   linux-headers/linux/const.h                   |   2 +-
>   linux-headers/linux/iommufd.h                 | 129 +++++++++++-
>   linux-headers/linux/kvm.h                     |   1 +
>   linux-headers/linux/psp-sev.h                 |  21 +-
>   linux-headers/linux/stddef.h                  |   2 +
>   linux-headers/linux/vfio.h                    |  30 ++-
>   linux-headers/linux/vhost.h                   |  12 +-
>   migration/qemu-file.c                         |  16 ++
>   migration/vmstate-types.c                     |  25 +++
>   net/net.c                                     |  21 +-
>   net/netmap.c                                  |   3 +-
>   net/tap-bsd.c                                 |   8 +-
>   net/tap-linux.c                               |  46 ++++-
>   net/tap-solaris.c                             |   9 +-
>   net/tap-stub.c                                |   8 +-
>   net/tap.c                                     |  19 +-
>   net/tap_int.h                                 |   5 +-
>   qapi/virtio.json                              |   8 +-
>   73 files changed, 1209 insertions(+), 271 deletions(-)
>   create mode 100644 include/hw/virtio/virtio-features.h
> 


