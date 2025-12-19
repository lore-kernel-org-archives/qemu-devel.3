Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554E1D74961
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 08:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWVbl-0006QQ-Qm; Fri, 19 Dec 2025 03:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vWVbi-0006Pu-3p
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 03:13:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vWVbg-0005JJ-6j
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 03:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766131978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4esfwqmnp6Yj7iH0lv6nCVR9ijz7TDmc5LP+PUle+1U=;
 b=S54FdaqbD3129eR+RIdEqYoV8rB1fP51igHn/Abufqr+stzOiEOQErB7FfquGjSB2wmXtP
 YkOTsMA1SuIYEgJRwC/SGcU3shDrXM1ZoOxq0LCEQyCzttvXCPeMfaXIm3UG0QKx6u8ANJ
 NGhYE5RnH3qIYGxsuQMFZ3YuprJ98g4=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-ESTK59XMPty0kuMTVQATHg-1; Fri, 19 Dec 2025 03:12:54 -0500
X-MC-Unique: ESTK59XMPty0kuMTVQATHg-1
X-Mimecast-MFC-AGG-ID: ESTK59XMPty0kuMTVQATHg_1766131974
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-63e324b2fd0so2927638d50.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 00:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766131972; x=1766736772; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4esfwqmnp6Yj7iH0lv6nCVR9ijz7TDmc5LP+PUle+1U=;
 b=mcHU69GpbHi8MNz90WyM/ALCsDL1OG5kdXEjo952/f5RTQ4ahdxz0RxbcO4X6I1XP1
 VQvTsmhKnLQ8I7JTckkzvErfpVBPDpyDFF/2acIDGpb9xEIwxpTUn9U9D8HtsgvWYR1N
 48EB7kxhP4OuWusDrP/INyNlaBXxKOpdwT/fG7P6KRO8wZZxh/6jTqQPJC7r1o3gBJx9
 5NBEjM455/1+qv5dpg5/cllo80sP91A0vkl2oGikXXEsGB7L1FDldqK8aBidTgxhWYz+
 7iD8EfjSZgRAuE4/4ORYMA+yA4hkO/xl19LOBx9Zu6tsHXEO6MGS/aQxhemFCzp/XDxt
 h6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766131972; x=1766736772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4esfwqmnp6Yj7iH0lv6nCVR9ijz7TDmc5LP+PUle+1U=;
 b=SXza89jgkHmDMq5CCpXIVpu99h+0dLOG+mSa6dbOAv0dRyU+mQ1JyYGPZbYgmYSdD3
 C5Ub7zuaEqJXy/tPuTxi8NVrmUwFtsqAl1yjtH8Wy/bWKRL3h5DjTjI4D0irJsw2Soa4
 26FCq4oq5JurL5PlVGJNxTgLbKvz5p33eZABVgIOyoyiqG9n221wPstfjUeVh97aSXUj
 nmmyod7CHmzdYefitQmg6hXFAYwzaFtx0wFCuF5XF8EPtAYop1GcO8VN1WNqp7/nTwkJ
 8BL31/Y2C5QBlO3rR6sBJYlG3OM7v+KdBYRBA3gYyKXIBWclleXlGOs7g5xjiZhl91T7
 1aAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj4qeGcUET4BPE9HfJiyz/njBd3cVQfU+4QiFPvaLDNkh+Fbmc9hfxsqWqodrht9/ni6sZFau+pye3@nongnu.org
X-Gm-Message-State: AOJu0YwbexzZCQllReVl3Lec3/wJ21Yfv9kA3ENevm/6hlriDc5idHFP
 Ia//3LoPz8wSSimIAZNuXnYyaqmG+3pDszbzZnzgqWggPpazw9EG7EPEV89/N8siat/YWr3BrZc
 Nr+RCpivve1rU+QeQ8nWYCxxb4iMSe/b+/8CK7Q2WdY6r9Iu5vYcYv/XXnLqmDPbl+pcikUMcOS
 NTDN1WdDI2xpiLKCXKlRk7sFYxVFImaF+49FD4mJs=
X-Gm-Gg: AY/fxX7/KqFY6NvUQZx6wwEOMn22QAJQpUkDfGpKfOh6ZUJ/03l9DhPQyYvkVBBYGRn
 uY3Owsa3LeS6TegRd1TOyoq13wtacOz5wfwVwL8/SiQdKabdWRbE/jzKndi4lrolUZHkyo0iGyk
 0Tn5SMliQMg2paGfGK2SPY2DIQ8D/RP11SDdS50jPgc/DFp6c7xL/rJQdQGqB8mJWZVCY=
X-Received: by 2002:a53:ed90:0:b0:645:53d0:2d1f with SMTP id
 956f58d0204a3-6466a834cf8mr1327499d50.6.1766131972202; 
 Fri, 19 Dec 2025 00:12:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExQzmkn+NMbFa3KzBmeOdjSfpGCK4eXIglomR92lnijzn9qzGVo6XM/POWNXyN9VXtgnflz8NUw8QWLFP0Tsg=
X-Received: by 2002:a53:ed90:0:b0:645:53d0:2d1f with SMTP id
 956f58d0204a3-6466a834cf8mr1327482d50.6.1766131971535; Fri, 19 Dec 2025
 00:12:51 -0800 (PST)
MIME-Version: 1.0
References: <20251216015416.6418-1-wafer@jaguarmicro.com>
In-Reply-To: <20251216015416.6418-1-wafer@jaguarmicro.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 19 Dec 2025 09:12:14 +0100
X-Gm-Features: AQt7F2o0fAgbU98VI_CTc6RSnqKBof5Sgc-uoK1DZHwquhY4jepc8XTPJM1Ot04
Message-ID: <CAJaqyWfNFrSDb3wk5oMpB6Lc4aTkUnbaQ-sy875+cO9jGk7Vaw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add Split indirect descriptors for SVQ
To: Wafer Xie <wafer@jaguarmicro.com>
Cc: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Dec 16, 2025 at 2:54=E2=80=AFAM Wafer Xie <wafer@jaguarmicro.com> w=
rote:
>
> From: wafer Xie <wafer@jaguarmicro.com>
>
> This patch series adds support for VIRTIO split indirect descriptors.
> The feature is VIRTIO_RING_F_INDIRECT_DESC.
>
> Eugenio hs submitted a patch: vhost: accept indirect descriptors in shado=
w virtqueue
> https://lists.nongnu.org/archive/html/qemu-devel/2025-12/msg00056.html
> Therefore, this patch must be applied first.
>
> The current svq implementation can read the indirect descriptors provided=
 by the driver,
> but it cannot use indirect descriptors when interacting with the backend =
device.
> However, if a backend device implements indirect descriptors and wants to=
 use QEMU
> to validate its indirect descriptor support,
> then QEMU needs to fully support indirect descriptors in this path.
> This series is intended to provide that full support,
> so that such backend devices can be properly tested and validated via QEM=
U.
>
> Multiple buffers are used to store indirect descriptors, and each buffer =
has a size of ring.num * 4.
> Each buffer has two states: FREED and FREEING.
>
> When adding elements to the virtio available ring,
> descriptors can only be allocated from buffers in the FREED state.
> If the current buffer does not have enough FREED descriptors,
> its state is changed to FREEING,
> and descriptors are then allocated from another buffer in the FREED state=
.
>
> When retrieving entries from the virtio used ring,
> descriptors are returned to the buffer indicated
> by the buffer index associated with the element.
> If all descriptors in a buffer have been reclaimed,
> the buffer=E2=80=99s state is changed back to FREED.
>
>
> Performance (pps) was evaluated using testpmd, comparing three scenarios:
> 1) fully indirect descriptors(apply this path series, indirect_desc=3Don)
> guset<--------indirect desc-----SVQ-------indirect desc----->device
>
>
> 2) hybrid mode with indirect plus chained descriptors(only apply VIRTIO_R=
ING_F_INDIRECT_DESC, indirect_desc=3Don)
> guset<--------indirect desc-----SVQ-------chain desc----->device
>
>
> 3) fully chained descriptor mode(don't apply any patch,indirect_desc=3Dof=
f).
> guset<--------chain desc-----SVQ-------chain desc----->device
>
>
> The results show that the fully indirect descriptor mode achieves approxi=
mately 5%~10% higher performance than the indirect + chained descriptor mod=
e,
> and approximately 12%~17% higher performance than the fully chained descr=
iptor mode.
>
>

Sounds very good! The series is aimed but I have a few comments on it,
let me know what you think!

>
> The raw testpmd output is provided below.
>
> testpmd configuration:
> 1) set txonly; set txpkts 2048,1024;set burst 8
>
>   fully indirect descriptors:
>   ######################## NIC statistics for port 0  ###################=
#####
>   RX-packets: 256        RX-missed: 0          RX-bytes:  491520
>   RX-errors: 0
>   RX-nombuf:  0
>   TX-packets: 74700761   TX-errors: 0          TX-bytes:  307543211008
>
>   Throughput (since last show)
>   Rx-pps:            0          Rx-bps:            0
>   Tx-pps:       745609          Tx-bps:  18324096544
>   #######################################################################=
#####
>
>
>   hybrid mode with indirect plus chained descriptors
>   ######################## NIC statistics for port 0  ###################=
#####
>   RX-packets: 256        RX-missed: 0          RX-bytes:  491520
>   RX-errors: 0
>   RX-nombuf:  0
>   TX-packets: 44153053   TX-errors: 0          TX-bytes:  202580423680
>
>   Throughput (since last show)
>   Rx-pps:            0          Rx-bps:            0
>   Tx-pps:       674954          Tx-bps:  16587671544
>   #######################################################################=
#####
>
>
>
>   fully chained descriptor mode:
>   ######################## NIC statistics for port 0  ###################=
#####
>   RX-packets: 256        RX-missed: 0          RX-bytes:  491520
>   RX-errors: 0
>   RX-nombuf:  0
>   TX-packets: 48458913   TX-errors: 0          TX-bytes:  212695989248
>
>   Throughput (since last show)
>   Rx-pps:            0          Rx-bps:            0
>   Tx-pps:       665493          Tx-bps:  16355164120
>   #######################################################################=
#####
>
>
> 2) set txonly; set txpkts 2048,2048,1024;set burst 8
>
>    fully indirect descriptors:
>   ######################## NIC statistics for port 0  ###################=
#####
>   RX-packets: 0          RX-missed: 0          RX-bytes:  0
>   RX-errors: 0
>   RX-nombuf:  0
>   TX-packets: 18193774   TX-errors: 0          TX-bytes:  93152122880
>
>   Throughput (since last show)
>   Rx-pps:            0          Rx-bps:            0
>   Tx-pps:       683537          Tx-bps:  27997687072
>   #######################################################################=
#####
>
>
>
>    hybrid mode with indirect plus chained descriptors
>   ######################## NIC statistics for port 0  ###################=
#####
>   RX-packets: 0          RX-missed: 0          RX-bytes:  0
>   RX-errors: 0
>   RX-nombuf:  0
>   TX-packets: 18948021   TX-errors: 0          TX-bytes:  97013867520
>
>   Throughput (since last show)
>   Rx-pps:            0          Rx-bps:            0
>   Tx-pps:       646147          Tx-bps:  26466218232
>   #######################################################################=
#####
>
>
>
>    fully chained descriptor mode:
>   ######################## NIC statistics for port 0  ###################=
#####
>   RX-packets: 0          RX-missed: 0          RX-bytes:  0
>   RX-errors: 0
>   RX-nombuf:  0
>   TX-packets: 15944245   TX-errors: 0          TX-bytes:  81634534400
>
>   Throughput (since last show)
>   Rx-pps:            0          Rx-bps:            0
>   Tx-pps:       583981          Tx-bps:  23919889848
>   #######################################################################=
#####
>
> -----
> Changes in v3:
>  -Fix code formatting issues
>
> Changes in v2:
>  -Use a static allocated buffer for the indirect descriptors
>
>
> wafer Xie (4):
>   vhost: add data structure of virtio indirect descriptors in SVQ
>   vdpa: implement a statically allocated buffer for SVQ
>   vhost: SVQ get the indirect descriptors from used ring
>   vhost: SVQ add the indirect descriptors to available ring
>
>  hw/virtio/vhost-shadow-virtqueue.c | 325 ++++++++++++++++++++++++++---
>  hw/virtio/vhost-shadow-virtqueue.h |  46 ++++
>  hw/virtio/vhost-vdpa.c             | 163 ++++++++++++++-
>  3 files changed, 507 insertions(+), 27 deletions(-)
>
> --
> 2.48.1
>


