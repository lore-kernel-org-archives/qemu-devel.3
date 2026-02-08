Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CA8EF06E2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 14:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vp5wv-0003SS-1o; Sun, 08 Feb 2026 09:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vp5wt-0003S4-CN
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 09:39:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vp5wr-0004j7-Ik
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 09:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770561580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H+7RTuhH+zIeTVLpBgBdEntS+Sj5EglPPGl0ZzHm6J0=;
 b=B8+fRpm5YjvPdpGbzCFjp94t1rKMuDrtq5XcT8i/QpBdiWpeCp50fmUKM19N5SdHHnvfJl
 U5YxjUoaC2bc1iIQoecC1sy0Cg2dfM/39UcaksY3tHg3GDdl5eBa0zckE8Hzvi4SO0Nxb0
 JHZn3FpT78q4/wIc0n/LmY/ndIphUU0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-JQuJQuXZNs-QrlK7H2N23g-1; Sun, 08 Feb 2026 09:39:39 -0500
X-MC-Unique: JQuJQuXZNs-QrlK7H2N23g-1
X-Mimecast-MFC-AGG-ID: JQuJQuXZNs-QrlK7H2N23g_1770561579
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c52c921886so390223385a.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 06:39:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770561579; cv=none;
 d=google.com; s=arc-20240605;
 b=U+qRCreWWDzGERa65q0BpO/CdWLw8Q/nuZr9l5wezD6Th1bgZo8K57txtk8cthA25M
 qd7KpVt75cpGYVjVVw0tFK4f2n/DHvUyWWmSk6dXkNd6kBuK3xdsSHgcSMQtsGyJSWxt
 QC3W/+x5r5kx7O2wOQOPsGZWLgEbuxzUw4lMCdvJ8DtNzm+y8STDOT2ASjXhKJVfZtek
 9xLArzTec/kKsj80FS/xejCONNFFvote3bmtnbQsqmwlmBA/XV/XxuSgk/duA3lrLMmJ
 kV2fihTCfNCUxoH/BHDfP3SJRVsCIfedL161ZY8c11lEN+puLvct5byfrw4mDXFLH0ks
 eAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=H+7RTuhH+zIeTVLpBgBdEntS+Sj5EglPPGl0ZzHm6J0=;
 fh=oZnGT2C1cF2FP2/rWkitY0ymYxWSqhGwgUfh3mJ3qQM=;
 b=dxz99Hn03V/Kfib7hObw2evBj+al7scm/lXm9BuWDyQMJDUi2hyu2Rs+XLrSuNQjX3
 29UQ6sgcDDXXC5ylV8B57bq/y+G89LV53Hc+9U3qWtTxdGOUA4kQ0UCgVE50w7pC/Zap
 GircXk88CQjsr1bZNnc7eenSKclP3K5IxmmH8U3wun+wsVbVAC36ePLOrzE4gq1dDul7
 dasboYevFVmaqkVEVprxujP5VFO8fpOZXLlJFQKxmSGmZXLvOiQ5D2Az2x8/Wxo8DBxC
 voEGqdqb7Azo7g5l1OeNHhEVyYuVuqrEh+EkpogWlOif9KOAjDBWpr187umVWmKSnO8S
 op1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770561579; x=1771166379; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+7RTuhH+zIeTVLpBgBdEntS+Sj5EglPPGl0ZzHm6J0=;
 b=Y1CxtMrNsGn+90uvoTczcpbxmO9H8hKTerTr7GgUJuzCcfhhjJbH1Wz2JOBzqKJKCs
 MRI4FDHPbMWswcVxC0TlygVx1EnVT/8y+sFPCNhANBfsUHjrdZ6q8nw+T+2cidogMXSK
 PeMIsrZw4qNtWcQMaMjOvNWaVObHA99mst1iypp/ZbZdwG09AZYK85MJ+hPNsrmE3SXb
 kKiqCqIhNvefIZ2GoX2HINy1+lmfHdWs5K18z0oBFF2u+KEkWpmT0SEfPy8KjauHWvu8
 s67cKh/Gzb/Vulr70HjDAUCr2H/L/weNLT+g/y0VynkC+zS1gSc581o4y927HoF0Eavn
 iGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770561579; x=1771166379;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H+7RTuhH+zIeTVLpBgBdEntS+Sj5EglPPGl0ZzHm6J0=;
 b=ImMbN5TyfLpQsW4HFbWUGTt3MeFwoCL7J7QQhjV5e2RrSQl+77w6mcajssTXS4oAr/
 kjNuRhsNZmI7n8IIrietrWZR8cDtlDnEDC96ep6mE0Pa8pTaOXerV1f6vCwLELaxmcHE
 tgJNGP8QBM18zVHNvpm4CpCz6wdtLB/l08FB91MIIOf68rQ9vlyWvXStCvMqYrYzJ1th
 Adlt01szECdpmbnE5qHNpPdEuZaF2UJOjBM4Azb6pwMTkltftIf+GqH2dgorDOURRid5
 G+d/y2Hc1PBzJOiLvPghz/zyjHZwOMpOVQ5JSQCfCRJD9z3ve3cruZOqD2+ABzt6Wnf5
 JXhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJFSIxjJSchklZB+6kdljG5qmRubmZ5nSUquZqCVmkT2T59lFoio146GsMQMINdgOgJdwZel7estYw@nongnu.org
X-Gm-Message-State: AOJu0YzALXUhcqb2z5uQ2//TlQVG4uJH7LB2WwoQC5usyLDI90mJRJI6
 UdOkubc5RnJNZRqmpkr/uAcfCLEdsaqZAl/GuVHQcdmAOtORvrNRKEePuJAmcCN3Re1KEygu3I9
 nY0NrMWJ2qIO1eDTpQgiLBG0PIv7GiUnaS5T+/RVM7VqOfRGeK1ZF0NJ15rQkVrloZxE4D/ZkKn
 0zx46Qyum6Si66IDFR7QlJvAPD1n4Jvok=
X-Gm-Gg: AZuq6aLr2D2oTXQ45O5dWfeWE515422+9oho92r/sE9ZgPRwcbMsx4n3ZIbl1mqV/9P
 PzixCvPRaqYj0GezvFLsu6GKbMjZVQbLDqvPSx7Rwcr24ocxoyHH8yi1DMaAp8GAaLjlS2jhOTa
 7WYqIdS58uV/azSQ54pJWvQ6sBFPbsSZgDBr5td602B/17JnjfggI6uQMzAnBcjlq/WTeGwDhs/
 IMruBwhBNKlW517zQ1qDp2Njn8yMarVnTJ2E71Z
X-Received: by 2002:a05:620a:400b:b0:8c5:3143:84ef with SMTP id
 af79cd13be357-8caf096454amr1083519285a.47.1770561578705; 
 Sun, 08 Feb 2026 06:39:38 -0800 (PST)
X-Received: by 2002:a05:620a:400b:b0:8c5:3143:84ef with SMTP id
 af79cd13be357-8caf096454amr1083517485a.47.1770561578308; Sun, 08 Feb 2026
 06:39:38 -0800 (PST)
MIME-Version: 1.0
References: <20260127051612.219475-1-anisinha@redhat.com>
 <20260127051612.219475-23-anisinha@redhat.com>
In-Reply-To: <20260127051612.219475-23-anisinha@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Sun, 8 Feb 2026 20:09:27 +0530
X-Gm-Features: AZwV_Qh20-NJ48l4ubG-pvhRvk6Xe_GV82qhYiNlrJF4zVd9BnJud73VihFFAdI
Message-ID: <CAK3XEhOet2pFNT2PLOHuBZFNAbXtYq3Hghr0XNvd4FKyPPX7bw@mail.gmail.com>
Subject: Re: [PATCH v3 22/33] hw/vfio: generate new file fd for pseudo device
 and rebind existing descriptors
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 27, 2026 at 10:47=E2=80=AFAM Ani Sinha <anisinha@redhat.com> wr=
ote:
>
> Normally the vfio pseudo device file descriptor lives for the life of the=
 VM.
> However, when the kvm VM file descriptor changes, a new file descriptor
> for the pseudo device needs to be generated against the new kvm VM descri=
ptor.
> Other existing vfio descriptors needs to be reattached to the new pseudo =
device
> descriptor. This change performs the above steps.

I have not been able to test this change. Can someone suggest a way to
add a functional test and/or test this manually?
Otherwise I am going to add a comment in the next spin up that this
change is not tested.

>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/vfio/helpers.c | 86 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 83 insertions(+), 3 deletions(-)
>
> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> index f68f8165d0..d467875b4b 100644
> --- a/hw/vfio/helpers.c
> +++ b/hw/vfio/helpers.c
> @@ -110,12 +110,71 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type=
1_info *info,
>  #ifdef CONFIG_KVM
>  /*
>   * We have a single VFIO pseudo device per KVM VM.  Once created it live=
s
> - * for the life of the VM.  Closing the file descriptor only drops our
> - * reference to it and the device's reference to kvm.  Therefore once
> - * initialized, this file descriptor is only released on QEMU exit and
> + * for the life of the VM except when the vm file descriptor changes for
> + * confidential virtual machines. In that case, the old file descriptor =
is
> + * closed and a new file descriptor is recreated.  Closing the file desc=
riptor
> + * only drops our reference to it and the device's reference to kvm.
> + * Therefore once initialized, this file descriptor is normally only rel=
eased
> + * on QEMU exit (except for confidential VMs as stated above) and
>   * we'll re-use it should another vfio device be attached before then.
>   */
>  int vfio_kvm_device_fd =3D -1;
> +
> +typedef struct KVMVfioFileFd {
> +    int fd;
> +    QLIST_ENTRY(KVMVfioFileFd) node;
> +} KVMVfioFileFd;
> +
> +static QLIST_HEAD(, KVMVfioFileFd) kvm_vfio_file_fds =3D
> +    QLIST_HEAD_INITIALIZER(kvm_vfio_file_fds);
> +
> +static int kvm_vfio_filefd_rebind(NotifierWithReturn *notifier, void *da=
ta,
> +                                  Error **errp);
> +static struct NotifierWithReturn kvm_vfio_vmfd_change_notifier =3D {
> +    .notify =3D kvm_vfio_filefd_rebind,
> +};
> +
> +static int kvm_vfio_filefd_rebind(NotifierWithReturn *notifier, void *da=
ta,
> +                                  Error **errp)
> +{
> +    KVMVfioFileFd *file_fd;
> +    int ret =3D 0;
> +    struct kvm_device_attr attr =3D {
> +        .group =3D KVM_DEV_VFIO_FILE,
> +        .attr =3D KVM_DEV_VFIO_FILE_ADD,
> +    };
> +    struct kvm_create_device cd =3D {
> +        .type =3D KVM_DEV_TYPE_VFIO,
> +    };
> +
> +    /* we are not interested in pre vmfd change notification */
> +    if (((VmfdChangeNotifier *)data)->pre) {
> +        return 0;
> +    }
> +
> +    if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
> +        error_setg_errno(errp, errno, "Failed to create KVM VFIO device"=
);
> +        return -errno;
> +    }
> +
> +    if (vfio_kvm_device_fd) {
> +        close(vfio_kvm_device_fd);
> +    }
> +
> +    vfio_kvm_device_fd =3D cd.fd;
> +
> +    QLIST_FOREACH(file_fd, &kvm_vfio_file_fds, node) {
> +        attr.addr =3D (uint64_t)(unsigned long)&file_fd->fd;
> +        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> +            error_setg_errno(errp, errno,
> +                             "Failed to add fd %d to KVM VFIO device",
> +                             file_fd->fd);
> +            ret =3D -errno;
> +        }
> +    }
> +    return ret;
> +}
> +
>  #endif
>
>  void vfio_kvm_device_close(void)
> @@ -137,6 +196,7 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
>          .attr =3D KVM_DEV_VFIO_FILE_ADD,
>          .addr =3D (uint64_t)(unsigned long)&fd,
>      };
> +    KVMVfioFileFd *file_fd;
>
>      if (!kvm_enabled()) {
>          return 0;
> @@ -153,6 +213,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
>          }
>
>          vfio_kvm_device_fd =3D cd.fd;
> +        /*
> +         * If the vm file descriptor changes, add a notifier so that we =
can
> +         * re-create the vfio_kvm_device_fd.
> +         */
> +        kvm_vmfd_add_change_notifier(&kvm_vfio_vmfd_change_notifier);
>      }
>
>      if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> @@ -160,6 +225,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
>                           fd);
>          return -errno;
>      }
> +
> +    file_fd =3D g_malloc0(sizeof(*file_fd));
> +    file_fd->fd =3D fd;
> +    QLIST_INSERT_HEAD(&kvm_vfio_file_fds, file_fd, node);
> +
>  #endif
>      return 0;
>  }
> @@ -172,6 +242,7 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
>          .attr =3D KVM_DEV_VFIO_FILE_DEL,
>          .addr =3D (uint64_t)(unsigned long)&fd,
>      };
> +    KVMVfioFileFd *file_fd;
>
>      if (vfio_kvm_device_fd < 0) {
>          error_setg(errp, "KVM VFIO device isn't created yet");
> @@ -183,6 +254,15 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
>                           "Failed to remove fd %d from KVM VFIO device", =
fd);
>          return -errno;
>      }
> +
> +    QLIST_FOREACH(file_fd, &kvm_vfio_file_fds, node) {
> +        if (file_fd->fd =3D=3D fd) {
> +            QLIST_REMOVE(file_fd, node);
> +            g_free(file_fd);
> +            break;
> +        }
> +    }
> +
>  #endif
>      return 0;
>  }
> --
> 2.42.0
>


