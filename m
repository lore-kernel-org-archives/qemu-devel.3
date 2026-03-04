Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85471EB7EB2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 09:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxipG-0003Tu-2A; Wed, 04 Mar 2026 04:47:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vxioL-0003Ji-Vd
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:46:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vxioJ-0000rV-8W
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772617587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EiAMEFW1jWXYrmKJgZqXPA/D+gQfmsyc9aMT5lcSRSs=;
 b=S2JJi/UkBDda9r0C8DrydbOFpSFyIEO67DtVBupfWawc9qu8yVsL7qOoUO1otmWcU19h4K
 NNvX4clC2iqtOZoc3cbgHr4Vap1H6uyuPtMYpCUUCn3ZU/XEjwRd2sRY++YZdGGRZuMIlf
 Mrdvj+5xhYFctJSNig/sUopoIjbUZNA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-H4QnLkoGPV-a9RXMjeYW8A-1; Wed, 04 Mar 2026 04:46:26 -0500
X-MC-Unique: H4QnLkoGPV-a9RXMjeYW8A-1
X-Mimecast-MFC-AGG-ID: H4QnLkoGPV-a9RXMjeYW8A_1772617586
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-79881805767so71225557b3.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 01:46:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772617584; cv=none;
 d=google.com; s=arc-20240605;
 b=laB0trSICg7N+7KDE53F4MprQi5U9Ghkfe26G5H0HCV77nDa+4Cb2n1L0iMkp+RSfx
 vwPdzMKMkWVcjDh+zYDj9LGXfTYmcsjflmHwMcdOPILTD/Ei6FvCzaCEWIK0d86NIy4K
 +e3WdXOa6ykE0IibwAcjVhRkNMwU9YX7iCMSZSjwrsbkTUDJTumUKg/QToC/e6wz6Yyk
 HvJ1tTUvF1bwlBPdkxSDksReDO89sVHb2rjpW1WtWCOiL8AU1DcpfHw/EondTxJ4b5Hz
 vy9vOH+zNEy+QGuAoh+pwr+QdfBFds+5wqhMFA17b3TDwY9Gjo3uLCE94XzVnRv8f7PB
 2kZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EiAMEFW1jWXYrmKJgZqXPA/D+gQfmsyc9aMT5lcSRSs=;
 fh=/+XR4WOjNW1VKJ2gGmSXII/te/TjZO5mQ455a1KsGjQ=;
 b=Sq/AcdqzS1fxyQqZ2CffC35KI4q+Wh2ABXmbqTN1V46r2nEPE/ofyRhcVi4VuUSD5C
 scxj3TNpYIbQgXb8Mq6ubtq2uwSmJSRrT1lcHqYn7d5EXNFIRx+6uwE4Q9C8xrC+QS0t
 nFeuQHim1OM/EqgEdigQ/IvdcNgiSKj3uvHFqNjk9SPVwmdV1Ed6G5JS6C7aC5Tcw+eN
 7Csw+4rF2gjJgJllDKxvPkRG9GmZicSvQccqwtnnYfb6xdJ4eSUnDe/4JaVyNLyOh7Pp
 3ZIeazabtp8Tf8Em3uxv8UJb/Aae5Dx8DkDWL+7uEKSvPJQDkUaweJH4nx32896f/UKa
 1JJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772617584; x=1773222384; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EiAMEFW1jWXYrmKJgZqXPA/D+gQfmsyc9aMT5lcSRSs=;
 b=GUhgUvsqRiJdVYlp1tvxj8kbWvywfO7jKbn+gK6hIRLoKbWJl/PPadvfa6CflWm2D7
 BpJr/m96/8OeerSBP4gllVXTQ1sxDiizSIxboDA/peEUTPRc04Xuebz9Bm5lihCrAyZB
 BGRnNdsKCgysx4+NBAsuhzNeDcf3FWvyN/oquI6QiVztZTtoKS1oGUd4C9xzcMPmwwBV
 WWedChlUHVVu9iU7D+SJV9MtZU2XxRPvsEgFTVuPlQNFijB8txTel8dbUY5n9Rz5CBBc
 sPoC973/ltPaBmc5swu1JGiPBcVH/2pven9goUuuvqRug/FsHKmPiVUmZ9mwLaI0/k3o
 d8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772617584; x=1773222384;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EiAMEFW1jWXYrmKJgZqXPA/D+gQfmsyc9aMT5lcSRSs=;
 b=qDPnvvNyRLZvp/CaeoAUWM/9wiCWzlUXZFWXQW4zwdXUFsc9fw1DMY7PqyjQoPFbrj
 tx34e7W5Uy7nTfzd8DPuKZYpMadN1XvzGowo/almyH8Zm+F9T4tCte4/7tjqspxMAdfK
 IzAvoKw7dCR4C8E1yd6oP5y7KRVz/veWBQ2qHmlQnlspPsQU2/tZuZS5l+NTw9eNR+uz
 ZYaJ9oMIrIKFBEEuEcWjcn89jRTq+DrjSyRUunqhiEVgSlGldh+e91Ln8DFHui97hyT5
 5HShjxGo185YvJR4XWv8nKTypkAkxgbxw53ycg3SewZioCQeA8rzzsGQKko9StxiNnuN
 lRYQ==
X-Gm-Message-State: AOJu0YzLFc2n7bfEP2sTL6OBWVkGgpwrnJa5HkazFm9uCh9WbJ48biBC
 DG6hKxEb2xlV0eN8zyltPeNBqXYzadUfwjuTo8FdfbAv9KALaL/peqZARQpTb4uSu+QtGtusD4m
 Pj+XGE6JrYiOyznPIsrktSgIjb9DXnPas6OG6gVqhZAPG84YBvcUf1WMIHFDmGlQMgZUZgZ5Wzb
 AzTa1GHg0zLzvXd0log8sBTkoSJRv2LEmBQPtgJCsatknV
X-Gm-Gg: ATEYQzxkrBsqZ/SR7HTA8VFc8ma3BRV0Uaefpour1YAg0G1cux2JRIXuLIZZe6HRD5n
 vv06HjSMVs//vNyM3JbvDHccFYIkHfs2CvMSLjvhqaMvDpmmlZaDm3I0CRc7yyagkrJA7yi09Lm
 fv2Bz56Fwe71Z2tMCBczQ3co3C6+GoJbGTws/552DSQA1pKmOEySWfjLO/Rh1ZpZ0TCqpr+JEfV
 Q==
X-Received: by 2002:a05:690c:6983:b0:798:8577:dbba with SMTP id
 00721157ae682-798c6c2d28bmr12099977b3.29.1772617584084; 
 Wed, 04 Mar 2026 01:46:24 -0800 (PST)
X-Received: by 2002:a05:690c:6983:b0:798:8577:dbba with SMTP id
 00721157ae682-798c6c2d28bmr12099827b3.29.1772617583674; Wed, 04 Mar 2026
 01:46:23 -0800 (PST)
MIME-Version: 1.0
References: <20260219130334.787858-1-aesteve@redhat.com>
 <20260219130334.787858-4-aesteve@redhat.com>
In-Reply-To: <20260219130334.787858-4-aesteve@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 4 Mar 2026 10:46:12 +0100
X-Gm-Features: AaiRm52bjdJQDw3VC4emRsprH9GS_v5LuFemhjHt59b1Kj4_6zGaoc6CXQcMhz4
Message-ID: <CADSE00KJdqPp=mnC0zxPsZucWD+6-0zdiFM3XbZmSsTU1oMang@mail.gmail.com>
Subject: Re: [PATCH v13 3/7] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, mst@redhat.com, 
 dbassey@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 stefanha@redhat.com, 
 manos.pitsidianakis@linaro.org, Stefano Garzarella <sgarzare@redhat.com>,
 jasowang@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, slp@redhat.com, hi@alyssa.is,
 stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 19, 2026 at 2:04=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> Add SHMEM_MAP/_UNMAP request to the vhost-user
> spec documentation.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 61 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 17a68a62eb..ae4ad6f441 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -350,6 +350,27 @@ Device state transfer parameters
>    In the future, additional phases might be added e.g. to allow
>    iterative migration while the device is running.
>
> +MMAP request
> +^^^^^^^^^^^^
> +
> ++-------+---------+-----------+------------+-----+-------+
> +| shmid | padding | fd_offset | shm_offset | len | flags |
> ++-------+---------+-----------+------------+-----+-------+
> +
> +:shmid: a 8-bit shared memory region identifier
> +
> +:fd_offset: a 64-bit offset of this area from the start
> +            of the supplied file descriptor
> +
> +:shm_offset: a 64-bit offset from the start of the
> +             pointed shared memory region
> +
> +:len: a 64-bit size of the memory to map
> +
> +:flags: a 64-bit value:
> +  - 0: Pages are mapped read-only
> +  - 1: Pages are mapped read-write
> +
>  C structure
>  -----------
>
> @@ -375,6 +396,7 @@ In QEMU the vhost-user message is implemented with th=
e following struct:
>            VhostUserInflight inflight;
>            VhostUserShared object;
>            VhostUserTransferDeviceState transfer_state;
> +          VhostUserMMap mmap;
>        };
>    } QEMU_PACKED VhostUserMsg;
>
> @@ -1064,6 +1086,7 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>    #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
>    #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
> +  #define VHOST_USER_PROTOCOL_F_SHMEM                20

Commit cda83adc62b6108afc8a82d0f54d9a9a861e7aa8 got upstream first and
took feature number 20, so this should be 21 now.

@Michael Tsirkin Is it worth sending a new version or will you handle
the change?

>
>  Front-end message types
>  -----------------------
> @@ -1872,6 +1895,44 @@ is sent by the front-end.
>    when the operation is successful, or non-zero otherwise. Note that if =
the
>    operation fails, no fd is sent to the backend.
>
> +``VHOST_USER_BACKEND_SHMEM_MAP``
> +  :id: 9
> +  :equivalent ioctl: N/A
> +  :request payload: fd and ``struct VhostUserMMap``
> +  :reply payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> +  successfully negotiated, this message can be submitted by the backends=
 to
> +  advertise a new mapping to be made in a given VIRTIO Shared Memory Reg=
ion.
> +  Upon receiving the message, the front-end will mmap the given fd into =
the
> +  VIRTIO Shared Memory Region with the requested ``shmid``.
> +  If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and
> +  back-end set the ``VHOST_USER_NEED_REPLY`` flag, the front-end
> +  must respond with zero when operation is successfully completed,
> +  or non-zero otherwise.
> +
> +  Mapping over an already existing map is not allowed and requests shall=
 fail.
> +  Therefore, the memory range in the request must correspond with a vali=
d,
> +  free region of the VIRTIO Shared Memory Region. Also, note that mappin=
gs
> +  consume resources and that the request can fail when there are no reso=
urces
> +  available. Lastly, mappings are automatically unmapped by the front-en=
d
> +  across device reset operation.
> +
> +``VHOST_USER_BACKEND_SHMEM_UNMAP``
> +  :id: 10
> +  :equivalent ioctl: N/A
> +  :request payload: ``struct VhostUserMMap``
> +  :reply payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SHMEM`` protocol feature has been
> +  successfully negotiated, this message can be submitted by the backends=
 so
> +  that the front-end un-mmaps a given range (``shm_offset``, ``len``) in=
 the
> +  VIRTIO Shared Memory Region with the requested ``shmid``. Note that th=
e
> +  given range shall correspond to the entirety of a valid mapped region.
> +  If ``VHOST_USER_PROTOCOL_F_REPLY_ACK`` is negotiated, and the back-end
> +  sets the ``VHOST_USER_NEED_REPLY`` flag, the front-end must respond wi=
th
> +  zero when operation is successfully completed, or non-zero otherwise.
> +
>  .. _reply_ack:
>
>  VHOST_USER_PROTOCOL_F_REPLY_ACK
> --
> 2.52.0
>
>


