Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924FED2CDE3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 05:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vROKh-0005ol-Bi; Fri, 05 Dec 2025 00:26:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vROKf-0005l9-MS
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 00:26:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vROKd-0000f6-Fy
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 00:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764912373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B207U5QNFr2n5vxkgJkfphenKg78SH6MLRNo8ddV58k=;
 b=WgKb0NBBTSWhGiuVQs/77AvBsJDnqaO0iu+k76GsXAUk20i9ThfWqcKXw8hAbfcGb+4M0L
 r4aGQHWXgXVMYZkDqrsFY4xbdHRjSQny3X3p/8Od2ToWCDV6C10w2F3v52GJF7F2FhSN4s
 OvD04whUriUkCy0GshA4iF9swJ7FoD4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-9rIfnfn6NP2vrSFvxuzXdw-1; Fri, 05 Dec 2025 00:26:10 -0500
X-MC-Unique: 9rIfnfn6NP2vrSFvxuzXdw-1
X-Mimecast-MFC-AGG-ID: 9rIfnfn6NP2vrSFvxuzXdw_1764912369
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-343e262230eso2127928a91.2
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 21:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764912369; x=1765517169; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B207U5QNFr2n5vxkgJkfphenKg78SH6MLRNo8ddV58k=;
 b=sJhStt6X/njy7ZpS1z+yQpJWZbk1YWkrrISms7zVgknRbfTQU5A2JCoFzbFbtAlvAJ
 vYxHgPvaeFrDgn71+f0IbSaupx7UiBBuhDEWTgrpRk7k7WCiyH6wlQH5qVxkedMZ0zFI
 nD/dW9CTZRsmppFJj175iOg+0zJk//aWAsL8RRM6R1/yFo79AvcLiR34OlM5s1LpB5vx
 4P4jAOjBhDaLV/jeukYZzKrSiN1M25nXnFzCGqMfPyeDS6uzLB/3xQOB9aCvkLzegzOi
 PStahoI2U0T1YjZYpciDipKZ4xd7+PaQJQV0a324lyyenM1yVdG2LSXMzpb1dOyvVUKp
 FL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764912369; x=1765517169;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B207U5QNFr2n5vxkgJkfphenKg78SH6MLRNo8ddV58k=;
 b=Ayj+nGp4yl1YTCmd4fn5vSfyd7RcsCmrKVCWv+XbNJSc8fabkhMQXqObaCza9DIqsJ
 q5AADl6Gx88mkennH3fhEmT7U0qEX8L6ifWlbAqIrPAlD47+I3wkAeJp1I30JWvlIkwe
 67+zLk75OPheJ86MHYiIn5V+ZTasg6noah5YcepgPcLCxGAOBLPApF42/xsA52Auilef
 LrdVCjMR1u9TgaVNk8aF4j/A7pIEFRiJMzhnxBXyRXSTMEZR78R0B7KLwURGD2ZZOh6k
 ha1Uf/UvODvN/I3Y+0FIKTRaxcnMnYhl29P+DVu6QMMz2muD3X95TMeA+hbLobEHIqFq
 6HtQ==
X-Gm-Message-State: AOJu0YzKO1SFP7fm+xEs2vMlqB73eOwIoNPmSkikvAV3Sq7N5Sl/BVj3
 qHH2gTs6j37rJlm9iTDIEiscu0FvLKvzDdbzW0n4WV0YUr9eLjt1/s6HBzmdQotHSzgLBXIOfYw
 aOZUSrrOqZTCqzFFljGnVH6XFlkpkQ+U/VTRGhpEWZxrOx/dVr63d5FcRjjxUIhw9PsueOfVrsW
 iw9I1/iIkwr1XpXkuXdOAo61GkHogEe4Y=
X-Gm-Gg: ASbGncvfBkPgbBqWwzGjmxHg/cRd63FtwIb6z/gGemPD+t0SQgCPhyXP0GNoJ1DxpOg
 RhptcMSMwsaMRLWiDegbFka8AKBnzBkoZ29tHllTi0Gq95emXYPLyAAk+boPay5Kq0a1SQl685K
 opzn8oBFVlZAsATdgz0TW4VUVyFOJbuvW8EMm7ckjf+eYOP6qa0dN+Zl4Sq45chPhzKQ==
X-Received: by 2002:a17:90b:1850:b0:33d:a0fd:257b with SMTP id
 98e67ed59e1d1-34947f37050mr4504814a91.36.1764912369102; 
 Thu, 04 Dec 2025 21:26:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHN1vDQ9T6OhnioVFtzvVkD3E9ShEkg3ioqlDWK7b0sATUvayo6x63bq5nI92R9aSo6e8nS1zMduY0n/GOZi1Q=
X-Received: by 2002:a17:90b:1850:b0:33d:a0fd:257b with SMTP id
 98e67ed59e1d1-34947f37050mr4504798a91.36.1764912368580; Thu, 04 Dec 2025
 21:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20251017055112.837032-1-hzuo@redhat.com>
In-Reply-To: <20251017055112.837032-1-hzuo@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 5 Dec 2025 13:25:54 +0800
X-Gm-Features: AWmQ_bnW7nhDDFHdIvBcIr6V-XApjBwWOuL5JJrrABgsEf6M3nNhRtcZIFVDFWg
Message-ID: <CACGkMEuUunL71TAsijpNLyHnw53DXBMSrQ-x7HQj=fx-CzbYQw@mail.gmail.com>
Subject: Re: [PATCH v5] net/tap-linux.c: avoid abort when setting invalid fd
To: "Houqi (Nick) Zuo" <hzuo@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Cindy Lu <lulu@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Oct 17, 2025 at 1:51=E2=80=AFPM Houqi (Nick) Zuo <hzuo@redhat.com> =
wrote:
>
> When QEMU creates a tap device automatically and the tap device is
> manually removed from the host while the guest is running, the tap
> device file descriptor becomes invalid. Later, when the guest executes
> shutdown, the tap_fd_set_vnet_hdr_len() function may be called and
> abort QEMU with a core dump when attempting to use the invalid fd.
>
> This patch removes many abort() calls in this file. If the fd is found
> to be in a bad state (e.g., EBADFD or ENODEV), the related function
> will print an error message.
>
> Additionally, the return type of the tap_fd_set_vnet_hdr_len function
> is changed to int. When an error occurs during the ioctl() call,
> the return value from ioctl() is now passed back to the caller,
> allowing the caller to handle the error appropriately.

It would be better if you can split the patch as it seems to fix
different problems.

>
> The expected behavior for this negative test case is that QEMU should
> report an error but continue running rather than aborting.
>
> Testing:
> - Start QEMU with automatically created tap device
> - Manually remove the tap device on the host
> - Execute shutdown in the guest
> - Verify QEMU reports an error but does not abort
>
> (gdb) bt full

Since we are hitting abort(), the bt is not very useful here.

> #0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsi=
gno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
>         tid =3D <optimized out>
>         ret =3D 0
>         pd =3D <optimized out>
>         old_mask =3D {__val =3D {10}}
>         ret =3D <optimized out>
> #1  0x00007f1710b6bff3 in __pthread_kill_internal (threadid=3D<optimized =
out>, signo=3D6) at pthread_kill.c:78
> #2  0x00007f1710b15f56 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
posix/raise.c:26
>         ret =3D <optimized out>
> #3  0x00007f1710afd8fa in __GI_abort () at abort.c:79
>         save_stage =3D 1
>         act =3D {__sigaction_handler =3D {sa_handler =3D 0x20, sa_sigacti=
on =3D 0x20}, sa_mask =3D {__val =3D {16929458408262392576, 184467440737095=
50848, 139737042419943, 139737042419943, 0, 94049703655600, 139737042419943=
, 139737042670528, 18446744073709550328, 77, 139705603579344, 1844674407370=
9551615, 139737041472378, 139705595179568, 16929458408262392576, 9404967979=
4864}}, sa_flags =3D 281695456, sa_restorer =3D 0xa}
> #4  0x000055899a71de58 in tap_fd_set_vnet_hdr_len (fd=3D<optimized out>, =
len=3D10) at ../net/tap-linux.c:204
> #5  tap_set_vnet_hdr_len (nc=3D<optimized out>, len=3D10) at ../net/tap.c=
:269
>         s =3D <optimized out>
> #6  0x000055899a8be67f in qemu_set_vnet_hdr_len (nc=3D0x2956, len=3D10588=
) at ../net/net.c:573
> #7  virtio_net_set_mrg_rx_bufs (n=3D0x5589a72cfa10, mergeable_rx_bufs=3D<=
optimized out>, version_1=3D<error reading variable: Incompatible types on =
DWARF stack>, hash_report=3D<optimized out>) at ../hw/net/virtio-net.c:664
>         i =3D 0
>         nc =3D 0x5589a730ab28
> #8  virtio_net_set_features (vdev=3D0x5589a72cfa10, features=3D0) at ../h=
w/net/virtio-net.c:897
>         n =3D 0x5589a72cfa10
>         err =3D 0x0
>         i =3D 0
> #9  0x000055899a8e4eaa in virtio_set_features_nocheck (vdev=3D0x5589a72cf=
a10, val=3D0) at ../hw/virtio/virtio.c:3079
>         k =3D <optimized out>
>         bad =3D <optimized out>
> #10 virtio_reset (opaque=3D0x5589a72cfa10) at ../hw/virtio/virtio.c:3184
>         vdev =3D 0x5589a72cfa10
>         k =3D 0x5589a5c162b0
>         i =3D 0
> #11 0x000055899a630d2b in virtio_bus_reset (bus=3D0x5589a72cf990) at ../h=
w/virtio/virtio-bus.c:109
>         vdev =3D <optimized out>
> #12 virtio_pci_reset (qdev=3D0x5589a72c7470) at ../hw/virtio/virtio-pci.c=
:2311
>         proxy =3D 0x5589a72c7470
>         i =3D 0
>         bus =3D 0x5589a72cf990
> #13 0x000055899a686ded in memory_region_write_accessor (mr=3D<optimized o=
ut>, addr=3D<optimized out>, value=3D<optimized out>, size=3D<optimized out=
>, shift=3D<optimized out>, mask=3D<optimized out>, attrs=3D...) at ../syst=
em/memory.c:490
>         tmp =3D <optimized out>
> #14 0x000055899a686cbc in access_with_adjusted_size (addr=3D20, value=3D0=
x7f0fbedfde00, size=3D1, access_size_min=3D<optimized out>, access_size_max=
=3D<optimized out>, access_fn=3D0x55899a686d30 <memory_region_write_accesso=
r>, mr=3D0x5589a72c8040, attrs=3D...) at ../system/memory.c:566
>         print_once_ =3D false
>         access_mask =3D 255
>         access_size =3D 1
>         i =3D 0
>         r =3D 0
>         reentrancy_guard_applied =3D <optimized out>
> #15 0x000055899a686ac5 in memory_region_dispatch_write (mr=3D<optimized o=
ut>, addr=3D20, data=3D<optimized out>, op=3D<optimized out>, attrs=3D...) =
at ../system/memory.c:1545
>         size =3D <optimized out>
> #16 0x000055899a69f7da in flatview_write_continue_step (attrs=3D..., buf=
=3D0x7f1711da6028 <error: Cannot access memory at address 0x7f1711da6028>, =
len=3D<optimized out>, mr_addr=3D20, l=3D0x7f0fbedfde28, mr=3D0x5589a72c804=
0) at ../system/physmem.c:2972
>         val =3D 6
>         result =3D 0
>         release_lock =3D <optimized out>
> #17 0x000055899a697c15 in flatview_write_continue (fv=3D0x7f0f6c124d90, a=
ddr=3D61675730370580, attrs=3D..., ptr=3D0x7f1711da6028, len=3D1, mr_addr=
=3D6, l=3D1, mr=3D0x0) at ../system/physmem.c:3002
>         result =3D 0
>         buf =3D 0x7f1711da6028 <error: Cannot access memory at address 0x=
7f1711da6028>
> #18 flatview_write (fv=3D0x7f0f6c124d90, addr=3D61675730370580, attrs=3D.=
.., buf=3D0x7f1711da6028, len=3D1) at ../system/physmem.c:3033
> --Type <RET> for more, q to quit, c to continue without paging--
>         l =3D <optimized out>
>         mr_addr =3D 6
>         mr =3D 0x0
> #19 0x000055899a697a91 in address_space_write (as=3D0x55899bceeba0 <addre=
ss_space_memory>, addr=3D61675730370580, attrs=3D..., buf=3D0x7f1711da6028,=
 len=3D1) at ../system/physmem.c:3153
>         _rcu_read_auto =3D 0x1
>         result =3D 0
>         fv =3D 0x2956
> #20 0x000055899a91159b in address_space_rw (addr=3D10588, attrs=3D..., bu=
f=3D0x7f1711da6028, len=3D0, as=3D<optimized out>, is_write=3D<optimized ou=
t>) at ../system/physmem.c:3163
> #21 kvm_cpu_exec (cpu=3D0x5589a5d68b40) at ../accel/kvm/kvm-all.c:3255
>         attrs =3D {secure =3D 0, space =3D 0, user =3D 0, memory =3D 0, d=
ebug =3D 0, requester_id =3D 0, pid =3D 0, address_type =3D 0, unspecified =
=3D false, _reserved1 =3D 0 '\000', _reserved2 =3D 0}
>         run =3D 0x7f1711da6000
>         ret =3D <optimized out>
>         run_ret =3D <optimized out>
> #22 0x000055899a9189ca in kvm_vcpu_thread_fn (arg=3D0x5589a5d68b40) at ..=
/accel/kvm/kvm-accel-ops.c:51
>         r =3D <optimized out>
>         cpu =3D <optimized out>
> #23 0x000055899aba817a in qemu_thread_start (args=3D0x5589a5d72580) at ..=
/util/qemu-thread-posix.c:393
>         __clframe =3D {__cancel_routine =3D <optimized out>, __cancel_arg=
 =3D 0x0, __do_it =3D 1, __cancel_type =3D <optimized out>}
>         qemu_thread_args =3D 0x5589a5d72580
>         start_routine =3D 0x55899a918850 <kvm_vcpu_thread_fn>
>         arg =3D 0x5589a5d68b40
>         r =3D 0x0
> #24 0x00007f1710b6a128 in start_thread (arg=3D<optimized out>) at pthread=
_create.c:448
>         ret =3D <optimized out>
>         pd =3D <optimized out>
>         out =3D <optimized out>
>         unwind_buf =3D {cancel_jmp_buf =3D {{jmp_buf =3D {32, 88945440577=
43421332, -1288, 0, 140726164742416, 140726164742679, -8831356496486092908,=
 -8844535456800460908}, mask_was_saved =3D 0}}, priv =3D {pad =3D {0x0, 0x0=
, 0x0, 0x0}, data =3D {prev =3D 0x0, cleanup =3D 0x0, canceltype =3D 0}}}
>         not_first_call =3D <optimized out>
> #25 0x00007f1710bda924 in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:100
>
> Fixes: 0caed25cd171c611781589b5402161d27d57229c ("virtio: Call set_featur=
es during reset")

Please refer to docs/devel/submitting-a-patch.rst for a better fix tag
(40 is fine but usually we use 12 or more) and consider cc stable.

>

No need for the extra newline.

> Signed-off-by: Houqi (Nick) Zuo <hzuo@redhat.com>
> ---
>  net/tap-linux.c | 25 ++++++++++++++++---------
>  net/tap_int.h   |  2 +-
>  2 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/net/tap-linux.c b/net/tap-linux.c
> index 2a90b58467..d6b7533cfd 100644
> --- a/net/tap-linux.c
> +++ b/net/tap-linux.c
> @@ -212,20 +212,25 @@ bool tap_probe_has_tunnel(int fd)
>      return true;
>  }
>
> -void tap_fd_set_vnet_hdr_len(int fd, int len)
> +int tap_fd_set_vnet_hdr_len(int fd, int len)

I guess the build will be broken on other platforms like BSD.

>  {
> -    if (ioctl(fd, TUNSETVNETHDRSZ, &len) =3D=3D -1) {
> -        fprintf(stderr, "TUNSETVNETHDRSZ ioctl() failed: %s. Exiting.\n"=
,
> -                strerror(errno));
> -        abort();
> +    int ret;
> +
> +    ret =3D ioctl(fd, TUNSETVNETHDRSZ, &len);
> +    if (ret !=3D 0) {
> +        error_report("TUNSETVNETHDRSZ ioctl() failed: %s.", strerror(err=
no));
>      }
> +
> +    return ret;

I wonder who cares about the return value of this function?

>  }
>
>  int tap_fd_set_vnet_le(int fd, int is_le)
>  {
>      int arg =3D is_le ? 1 : 0;
> +    int ret;
>
> -    if (!ioctl(fd, TUNSETVNETLE, &arg)) {
> +    ret =3D ioctl(fd, TUNSETVNETLE, &arg);
> +    if (!ret) {
>          return 0;
>      }
>
> @@ -235,14 +240,16 @@ int tap_fd_set_vnet_le(int fd, int is_le)
>      }
>
>      error_report("TUNSETVNETLE ioctl() failed: %s.", strerror(errno));
> -    abort();
> +    return ret;
>  }
>
>  int tap_fd_set_vnet_be(int fd, int is_be)
>  {
>      int arg =3D is_be ? 1 : 0;
> +    int ret;
>
> -    if (!ioctl(fd, TUNSETVNETBE, &arg)) {
> +    ret =3D ioctl(fd, TUNSETVNETBE, &arg);
> +    if (!ret) {
>          return 0;
>      }
>
> @@ -252,7 +259,7 @@ int tap_fd_set_vnet_be(int fd, int is_be)
>      }
>
>      error_report("TUNSETVNETBE ioctl() failed: %s.", strerror(errno));
> -    abort();
> +    return ret;
>  }
>
>  void tap_fd_set_offload(int fd, const NetOffloads *ol)
> diff --git a/net/tap_int.h b/net/tap_int.h
> index b76a05044b..eed41fedc7 100644
> --- a/net/tap_int.h
> +++ b/net/tap_int.h
> @@ -40,7 +40,7 @@ int tap_probe_has_ufo(int fd);
>  int tap_probe_has_uso(int fd);
>  bool tap_probe_has_tunnel(int fd);
>  void tap_fd_set_offload(int fd, const NetOffloads *ol);
> -void tap_fd_set_vnet_hdr_len(int fd, int len);
> +int tap_fd_set_vnet_hdr_len(int fd, int len);
>  int tap_fd_set_vnet_le(int fd, int vnet_is_le);
>  int tap_fd_set_vnet_be(int fd, int vnet_is_be);
>  int tap_fd_enable(int fd);
> --
> 2.47.3
>

Thanks


