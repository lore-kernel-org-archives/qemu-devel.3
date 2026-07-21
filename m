Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3166C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 09:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6Ul-0001NT-2e; Tue, 21 Jul 2026 05:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wm6Uj-0001NC-F0
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 05:10:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1wm6Ug-00008Z-7J
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 05:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784625028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=slsU2Ayz2bb8lrdP9X/oYxa3SWjpysmpRrrI6Ee/Hrg=;
 b=YsEdYY8tev/J9OV8jmVV3s+kLbBhYdBFM9hc7BP2sGpfjP4mB2qMVvxIeR4Fe9iOOR08ON
 sfdLJE8UZwQxNPUfrJtOu9QuJFMOLM+dWZWZp09lpDf9Pah2rmsbYgAFGbiYuQFdg0rR57
 PB8EbBTarF+E1T92fZPLDx6z+3PVGaU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245--gZwTACAPyCjnsypFWtuqQ-1; Tue, 21 Jul 2026 05:10:23 -0400
X-MC-Unique: -gZwTACAPyCjnsypFWtuqQ-1
X-Mimecast-MFC-AGG-ID: -gZwTACAPyCjnsypFWtuqQ_1784625023
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-81e6bb29581so116361477b3.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 02:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784625023; cv=none;
 d=google.com; s=arc-20260327;
 b=HmtzR3OYQIHD4D+q0cJR6MHrIg9CcoFZPhE2GVwpyrVQRYO59YPcEIBvkiQWubLN20
 A7h59PKBKL6jGww7hXMAIOrJNtURmPvy7GValA9os5xiLe+uXHLgEQ92x2P4YVAkbu/n
 CdAfiGFG0/anRz/8OS5ozwwJ8mL6jGt8T6Ms8SHaCUOAmn2pz0CNTQ1AR4k5YJ/IcjCR
 CDsspd4dqBH3ykhStNiOEvJx3sMBR/GvWTOobbEs2z4jSZIDg1xuPQ1hNx6z1SosXdfk
 p1ICjTWKRu1r4HOwtBEtELCaTpYfuXeU+NYEf84A7qEj9TNwyl01zLxV5E/Srbd8Eght
 2iMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=slsU2Ayz2bb8lrdP9X/oYxa3SWjpysmpRrrI6Ee/Hrg=;
 fh=Dinz4M5vMQdTyJr85P6TvuqEoIhmyzA00gALOwJTkYY=;
 b=fqwc+OphVzf1XthnzK+/OkdhVO5rHuySakpmv+sR/qQTjDaOjPac/z0rEd0mrzwK3P
 oXlmAlvlxwNvmz6IF1g5WEkSRgLFJzXs56FGtZdymj6f6Fz57gduqjSojO9scG8c/Jex
 +JhhhqNvk/LdLrVlRNUo2plphmSw5KXD3DrvQVtOEwe3fO4+PtzppmKjukuEh9/E0rji
 CXVErqRBmd0S8zNYSJTCOoqz0SsqtdSTkAN0I8b9CBHP448N0zN/pxwOCa6GHcZm00Cf
 Ggy+F25v9YhXeDHuzWqCYJNUdYcZGGLzsBE7qgGLZ67FRQM3eZQ/mOkbHUY8vzCtf5tC
 LUdw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784625023; x=1785229823; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=slsU2Ayz2bb8lrdP9X/oYxa3SWjpysmpRrrI6Ee/Hrg=;
 b=Q7Mj8miLMVdEkK9IsnX8gM+I39tUybXyHf7VwcNBhIFUCJf2qyrchIHJVBsCKoUcrS
 FFauP2Se171os9KfJX3Jv5mECis9wxqrWub96ITWPLMPlwYxj1XpZAuSWDxrZJ6pRKmz
 zZa4ctyccH3v2ZkDbd7Cn/HS5711F1rOFrQ6zLve5vpoPAFAkJPGKOlLyyISxP1FKexN
 zF7ThnTM8UDK1BM08O4c1gdr2Jv4xrAdKCQmdr9knViIFVOQXQg6U6E+cApgnDL/VQKR
 Q5z70wZs2lxRGbJNXM2KMJffyfb+ndbH0Ykfp2HTURtdiiFNjdU3JHCfz8V+3WBh9YMN
 INJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784625023; x=1785229823;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=slsU2Ayz2bb8lrdP9X/oYxa3SWjpysmpRrrI6Ee/Hrg=;
 b=fIe4WsvOEB0WAjjSUa1CDAxbLkRe1GgiXUHeYR7mjPSZnDp3tHaNBbzsBDsH3IkSVB
 L1Cz0zqJwWeNvNfOIOnELhQKHKYuSKB4NoS8S6c0TyHBTENAmZcZZM9ZqLQI60rHQR4Y
 hixknFS92/dWtQWxuOqaHphwdamGzf5qHfAF4lm23ilY5RCmfJVj4HYONpujvd2iRWeU
 aWukGqvFGub7JBJBprxznzDc0sbBiq19LM4md0cZ9dbTo2wXM5qM1Nu3mohWrtBU3P40
 Qr5xducRCUAHGq5MOkO/13ZAmiZ2fmUDNrL8yrDlf8xROlNZTv3LQWmf6WV2sL6tXjnE
 8rvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcbDggbHV7q9zXLxZ/XtZt2qBM8wAdpWBQCQ2+oRksowUu9iQad3Pj5VrgLgU3qo3W8bu6snBqu18i@nongnu.org
X-Gm-Message-State: AOJu0YwpTMltzoBLZkIYLM23TTwZV4cXwfiUhE//2dipnDtPdMZpt3HK
 yb4M885u7vKiJWc51307Pw8yIcmLmMs1izBYBACMjCtwG6ACQ0w5mG0KfgTOxNBxP59MQBRZkuc
 85nBz2tq2jvMaoq6GNULxQeDI2eo0nAzOX80YZpr2Xs41OKugf8hBFPmLfNsIt4mN1u/0PSNE25
 Ubr8xLUoswZ0iYz4KnrOmvQsDNJENzphY=
X-Gm-Gg: AR+sD10jvMEql9OlIAPKoFTKWUH/1g++UWl0jaEByqMB9VtJaRqUkDZG61VadtKB+B8
 45x4+5iiIz7H604zoF8OGOzlOvFm7Y6hQTerYRQcdR1Ng+9tPx9t9wNn1dNquKOSq1jIxnZyeT9
 jh/y724QCVR8tTIs7amDwHj/7rcbguPXQxvf/hm2bBkrc3jQxaXva+WvZeKneCDB3XCePr7SYOh
 zM9YiiiQndpFKLUBas2ytSmz7Q3CLKyWcGIqFxxi8FPmEF5+zqNMopDV9I=
X-Received: by 2002:a05:690c:dd0:b0:80d:5ddd:1989 with SMTP id
 00721157ae682-81ef256b495mr59430037b3.10.1784625022867; 
 Tue, 21 Jul 2026 02:10:22 -0700 (PDT)
X-Received: by 2002:a05:690c:dd0:b0:80d:5ddd:1989 with SMTP id
 00721157ae682-81ef256b495mr59429897b3.10.1784625022303; Tue, 21 Jul 2026
 02:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260720141040.181946-1-r4o5m6e8o@163.com>
In-Reply-To: <20260720141040.181946-1-r4o5m6e8o@163.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 21 Jul 2026 11:09:44 +0200
X-Gm-Features: AUfX_mypA7oTxSucKfqGCkqmjhFuRqPhh_bDH2dF50m_ZTQcNCE2RIvdENtQTlY
Message-ID: <CAJaqyWe_nhVOvfA03So_edVO_+1UeHCC6RGnHRQB9dq7CWS4LQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] virtio: SQ/CQ doorbell polling for vhost-scsi
To: "rom.wang" <r4o5m6e8o@163.com>
Cc: mst@redhat.com, jasowangio@gmail.com, stefanha@redhat.com, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, 
 Yufeng Wang <wangyufeng@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=eperezma@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Jul 20, 2026 at 4:19=E2=80=AFPM rom.wang <r4o5m6e8o@163.com> wrote:
>
> From: Yufeng Wang <wangyufeng@kylinos.cn>
>
> This RFC proposes a new virtio transport feature, VIRTIO_F_SQCQ_POLL,
> that eliminates VM exits on both submission and completion paths for
> vhost-scsi by using shared-memory doorbells and kernel polling
> threads, following the io_uring SQPOLL model.
>
> This is an early RFC to gather design feedback. The implementation is
> functional and has been tested on arm64 and x86_64. We are not
> requesting merge at this time.
>
>
> Problem
> -------
>
> vhost-scsi uses MMIO writes (Guest -> Host) and MSI-X interrupts
> (Host -> Guest) for notification. Each notification involves a VM exit,
> which becomes a bottleneck at high IOPS:
>
>   - 4K random read, QD32, 8 jobs: 341K IOPS baseline
>   - With ~340K VM exits/second, the exit overhead dominates
>
> Existing mitigations (vhost-net's tx polling, blk-mq iopoll) only
> address one direction or require the submitting task to poll. Neither
> eliminates VM exits on both paths simultaneously.
>
>
> Solution
> --------
>
> Introduce two cache-line-aligned doorbell structures, SQ (Submission
> Queue) and CQ (Completion Queue), placed alongside the standard split
> virtqueue:
>
>   - Guest writes sq->idx instead of MMIO kick; Host poll thread
>     detects the change and processes submissions.
>   - Host writes cq->idx instead of MSI-X interrupt; Guest poll
>     thread detects the change and invokes completion callbacks.
>
> A NEED_WAKEUP protocol (mirroring io_uring's SQ_NEED_WAKEUP) allows
> either side to sleep when idle, with the other side responsible for
> waking it via eventfd.
>
> Feature negotiation via VIRTIO_F_SQCQ_POLL (bit 42) ensures zero
> overhead when not negotiated =E2=80=94 the driver falls back to tradition=
al
> MMIO kick + MSI-X interrupt.
>
>
> Performance
> -----------
>
> Benchmark: fio, 4K random I/O
>
> Test configuration:
>
>   arm64:
>     CPU:   Kunpeng 920 (2.6GHz), 8 vCPUs
>     Disk:  NVMe INTEL SSDPED1K375GA (375GB)
>
>   x86_64:
>     CPU:   Intel Xeon E5-2680 v4 @ 2.40GHz, 8 vCPUs
>     Disk:  NVMe SAMSUNG MZ1LB960HAJQ-000MV (960GB)
>
>   Backend: vhost-scsi with TCM loopback to NVMe device
>   QEMU:    vhost-scsi-pci with VIRTIO_F_SQCQ_POLL negotiated
>
> arm64 results:
>
>   Test              Baseline     SQ/CQ Poll   Change
>   -----------       ----------   ----------   -------
>   randread QD1      22,427       28,289       +26%
>   randread QD32 NJ1 89,910       75,665       -16%
>   randread QD32 NJ4 186,763      379,549      +103%
>   randread QD32 NJ8 199,967      550,633      +175%
>   randwrite QD1     21,912       27,261       +24%
>   randwrite QD32 NJ1 85,349      81,389       -5%
>   randwrite QD32 NJ4 190,443     355,811      +87%
>   randwrite QD32 NJ8 196,552     566,640      +188%
>
> x86_64 results:
>
>   Test              Baseline     SQ/CQ Poll   Change
>   -----------       ----------   ----------   -------
>   randread QD1      8,263        9,552        +16%
>   randread QD32 NJ1 127,412      162,805      +28%
>   randread QD32 NJ4 303,208      375,056      +24%
>   randread QD32 NJ8 341,625      371,193      +9%
>   randwrite QD1     20,773       30,332       +46%
>   randwrite QD32 NJ1 133,316      159,207      +19%
>   randwrite QD32 NJ4 233,373      229,224      -2%
>   randwrite QD32 NJ8 231,442      231,676      +0%
>
> Multi-queue workloads (NJ4/NJ8) see significant improvement on arm64
> (87-188%) and moderate improvement on x86_64 (9-24%). Single-VQ
> high-queue-depth workloads show a minor regression on arm64 due to
> polling overhead vs. VM-exit savings trade-off, while x86_64 shows
> improvement across most configurations (16-46% for QD1, 19-28%
> for QD32-NJ1) due to lower per-VM-exit cost on x86.
>
>
> Why Not vDPA?
> -------------
>
> vhost-vDPA already provides doorbell mmap and polling. A reasonable
> reviewer would ask: why not extend vhost-vDPA instead?
>
> Three reasons:
>
> 1. No vdpa-scsi device exists. The vDPA framework
>    (drivers/vdpa/) currently has hardware devices for net (mlx5,
>    ifcvf, etc.) and software devices for net and blk (vdpa_sim).
>    There is no virtio-scsi vDPA device, hardware or software.
>    Building one means re-implementing vhost-scsi's TCM integration
>    (SCSI CDB processing, ALUA, persistent reservations) under the
>    vDPA device abstraction =E2=80=94 3-5x the work of extending vhost-scs=
i.
>

I don't have a lot of experience in vhost-scsi, but maybe using
generic vdpa device and ~passthrough all those calls to something
similar to vhost-scsi helps? Live migration is still a challenge that
way but you already mention that in Known Limitations, so maybe going
to generic saves a significant amount of work.

https://patchew.org/QEMU/20221215134944.2809-1-longpeng2@huawei.com/

Also, I'm failing to see the advantage of the Send / Completion queues
over a more agressive usage of event_idx, VIRTQ_USED_F_NO_NOTIFY /
VIRTQ_AVAIL_F_NO_INTERRUPT or VIRTIO_F_NOTIFICATION_DATA combined. Can
we explore what does these lacks compared with the send and completion
queues?

> 2. vhost-scsi is a deployed interface. libvirt, QEMU, and
>    OpenStack have vhost-scsi configuration APIs and operational
>    tooling. Switching to vhost-vdpa requires a new backend, user
>    migration, and toolchain updates. SQ/CQ poll as a vhost-scsi
>    feature is fully backward-compatible =E2=80=94 no existing deployments
>    break.
>
> 3. The protocol is transport-agnostic. The SQ/CQ doorbell design
>    (struct vring_sq, struct vring_cq, NEED_WAKEUP handshake) is
>    orthogonal to vhost vs. vDPA. The same UAPI can be consumed by
>    vhost-scsi today and a future vdpa-scsi device. Implementing in
>    vhost-scsi first does not block future vDPA integration.
>
> We acknowledge that vDPA is the long-term direction for virtio
> backends. If this SQ/CQ poll protocol is accepted, it can be ported
> to the vDPA framework; a vdpa-scsi device is independent work.
>
>
> Patch Structure
> ---------------
>
>   Patch 1: UAPI definitions (virtio_config.h, virtio_ring.h,
>            virtio_pci.h) =E2=80=94 shared interface for all components
>   Patch 2: vhost kernel support (vhost.c, vhost.h, scsi.c,
>            vhost.h UAPI, vhost_types.h UAPI) =E2=80=94 Host poll thread
>   Patch 3: virtio guest driver (virtio_ring.c, virtio_sqcq_poll.c,
>            virtio_pci_modern.c, virtio.c, virtio_scsi.c) =E2=80=94 Guest
>            poll thread and submission path
>   Patch 4: QEMU support (virtio-pci.c, vhost.c) =E2=80=94 PCI config
>            forwarding and vhost ioctl bridge
>
> Patches 1-3 apply to the Linux kernel tree. Patch 4 applies to
> the QEMU tree separately.
>
>
> Spec Status
> -----------
>
> A virtio-spec format document has been prepared and will be submitted
> to the OASIS virtio TC as a proposal. This RFC stage seeks design
> feedback before initiating the formal spec process.
>
>
> Known Limitations (Future Work)
> -------------------------------
>
>   - CPU hotplug: no notifier registered; poll thread may be
>     migrated when its CPU goes offline. Planned: kthread_park +
>     dynamic rebind.
>   - Live migration: no explicit stop/flush coordination during
>     migration. Planned: VHOST_BACKEND_F_SUSPEND/RESUME integration.
>   - SMAP overhead: Host uses get_user/put_user for doorbell access.
>     Future optimization: GUP + kmap to map pages into kernel space.
>   - Backpressure: no "slow down" signal from device to driver.
>     Future: CQ throttle flag or avail_event reuse.
>   - Packed ring: not supported; explicitly rejected at feature
>     negotiation. Future: add packed ring doorbell support.
>
>
> RFC Goals
> ---------
>
>   1. Validate the overall design direction (doorbell + polling
>      model, NEED_WAKEUP protocol)
>   2. Get feedback on the feature bit allocation (42) and UAPI
>      structure design
>   3. Understand whether vDPA concern is a blocker or can be
>      addressed with the transport-agnostic argument
>   4. Collect guidance on prioritizing future work items
>      (hotplug, migration, spec process)
>
> We welcome all feedback, especially on:
>   - Whether the NEED_WAKEUP protocol design is sound
>   - Whether the per-device Guest poll thread model (vs per-VQ)
>     is acceptable
>   - Whether feature bit 42 is appropriate or if a different
>     allocation is needed
>   - Any concerns about the SMAP overhead in the Host poll path
>
>
> How to Test
> -----------
>
> Patch usage:
>   Guest Kernel: apply patch 1 (UAPI) + patch 3 (guest driver)
>   Host Kernel:  apply patch 1 (UAPI) + patch 2 (vhost support)
>   QEMU:        apply patch 4 (vhost-scsi bridge)
>
> 1. Set up vhost-scsi target on the host (see:
>    https://wiki.libvirt.org/Vhost-scsi_target.html#Host_Setup)
>    using targetcli to create a TCM loopback device, e.g.:
>    targetcli /backstores/loopback create dev=3D/dev/sda
>    targetcli /vhost create naa.5001405376e34400
>    targetcli /vhost/naa.5001405376e34400/lun create \
>      /backstores/loopback/dev,/dev/sda
>
> 2. Boot VM with vhost-scsi using patched QEMU:
>    qemu-system-aarch64 ... \
>      -device vhost-scsi-pci,wwpn=3Dnaa.5001405376e34400
>
> 3. Verify SQ/CQ poll mode is active on the host:
>    dmesg | grep "vhost-sqcq"
>    # Expected: "vhost-sqcq: vq[N] poll thread bound to cpuN"
>    # and 10s stats: "vhost-sqcq: vq[N] cq=3D... ema_lat=3D... interval=3D=
..."
>
> 4. Verify feature negotiated in guest:
>    dmesg | grep "VIRTIO_F_SQCQ_POLL"
>    # Expected: "VIRTIO_F_SQCQ_POLL negotiated, starting poll thread"
>    # and 10s stats: "io_stats: cq=3D... avg_lat=3D... interval=3D..."
>
> 5. Run fio benchmark (compare with unpatched QEMU/kernel baseline):
>    fio --name=3Drandread --rw=3Drandread --bs=3D4k --iodepth=3D32 \
>        --numjobs=3D4 --runtime=3D60 --time_based --direct=3D1 \
>        --filename=3D/dev/sda
>
> Test scripts (run-sqcq-compare.sh, compare-sqcq-results.sh) are
> available and will be sent as a follow-up to this RFC.
>
>
> Thank you for your time.
>
> ---
> Yufeng Wang (4):
>   common: add UAPI for SQ/CQ doorbell polling
>   vhost: host kernel support for SQ/CQ polling
>   virtio: guest driver support for SQ/CQ polling
>   qemu: add SQ/CQ polling mode support for vhost-scsi
>
> Patch 1 (UAPI, 3 files): +41 -1
> Patch 2 (vhost, 5 files): +794 -20
> Patch 3 (virtio guest, 10 files): +840 -3
> Patch 4 (QEMU, 14 files): +179 -3
>
> Total: 32 files changed, 1854 insertions(+), 27 deletions(-)
>
> --
> 2.34.1
>


