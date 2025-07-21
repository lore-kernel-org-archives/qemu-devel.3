Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5F3C87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 07:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udlDs-0003jS-KP; Mon, 21 Jul 2025 03:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1udlDY-0003aC-45
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1udlDV-0003Cn-Co
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753083942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FG91StghRVwNM87YYP+aW0OnWnnkB8DTnL4ru7CKQkQ=;
 b=dlnCaHBW4+Gv4MDGNfncetcGzhRZod0JoK45Ce91xyGF2TGRK0tA7wbeT0mMfrCsKjj1o+
 OAnyAg/8lZm80jzinVsgnXXaph5sFsPdAmlaTgfs68V1gNtX5YxcJq0fwpzOJlbWZ/FNoA
 l82vVPf3WPkHEHyN5nxmHuKb3cZtHcM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-LQgw7LeENvi4od_nKWx82A-1; Mon, 21 Jul 2025 03:45:41 -0400
X-MC-Unique: LQgw7LeENvi4od_nKWx82A-1
X-Mimecast-MFC-AGG-ID: LQgw7LeENvi4od_nKWx82A_1753083940
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-747ddba7c90so3418599b3a.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 00:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753083940; x=1753688740;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FG91StghRVwNM87YYP+aW0OnWnnkB8DTnL4ru7CKQkQ=;
 b=o+g7LY7lVY2lqOm9kXuI4Q6D1eNknYS+iipnZJPbkw9BzWaYA2cNhyCjTWlAgrVtQ/
 WSg0RPkHmh7zh0ZCgzvJL0Es5jantIwZ3GQmHe+MpD7cDO1e8tU0XF2bCrCpc9aWffI1
 qoixCx6zHnEI8ViELc+BjQzVQSmC2tc3VNwtRnNfIti9xb34xM5Wk8LVKwF435J/jeZd
 oUsiRrIkgumXEkbwf/WIQQiAkDLtG0XQF66cQFdrhD/vAEfXbW+RLdpgE4LgA6/OYNJg
 PxJf8gT4q3OwhzDRSsXvwziJFjisjE8uImXM7Iy3gI6/b7YTfwuoLPcO9mFQtxT9P6rc
 AQNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7Pn7DYIXPW7t2pnhyDijLFWl1+3qd6VBHmSKPsGGV2iC2VIGarsmsfrfk3lNmH0KcAFN6kQ0FHswn@nongnu.org
X-Gm-Message-State: AOJu0Yx9F3YLvThCYQRNcPMWWMACKz96pEk3tcp6wKWh3t5TnajQIZSZ
 Zw+1y3W5do0B1JvPWwLKQP1l85xUTDfjcJwWoxeyEPoSG5wJ+UBBST7AyBcNDZ7HtscG8gOvvlU
 EH8u5Zxx5cRAsiTbODyU9ftHkHTyxHxHe4PT5uCpN2PN0jODYqaNdPfW9
X-Gm-Gg: ASbGncvY9ZboDt8bsZOh7yAFur1m8GMkzBo2tmaAtgdJAtuKMJEylp9cAX/WxQODsZj
 q0fOuiDBP1NDAu/obAPul/ferP3upMbAK5FA9htA1E6o7FCM3c95Lw5Jvdv27cYXYdjTX5zrMea
 RMSM9JUmQzzi+i6yaj+N5XNUnfDQEySVIRfp+E+6bKRRjiFfIIhfs1FehY/0DWTszgMCuqP5vj8
 +bnEWZwW3gpcH1oJs1CXYOZ3O05C89hu6Sd850Q6UFTV93ZYo6Fn5Ita41fwZ+/S4ekLEj4i8ri
 pix6YWN9yck7+ZY7JxgmNlxJwzuZsB79CeVFfNBYXMH/u1jmEu4WHk7+ZhFiRMyBDtmT0bWszn3
 oAvNqCJeMRRjfDvM=
X-Received: by 2002:a05:6a20:431c:b0:235:5f88:32fc with SMTP id
 adf61e73a8af0-2381114d21dmr29715948637.18.1753083940523; 
 Mon, 21 Jul 2025 00:45:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7pIAtVjP4VsGxQU1fsu6H+uKnM1E1B48tVBNgCto5EtdObx2b3g6OHLxn3JEkmbC7VJFkXA==
X-Received: by 2002:a05:6a20:431c:b0:235:5f88:32fc with SMTP id
 adf61e73a8af0-2381114d21dmr29715925637.18.1753083940087; 
 Mon, 21 Jul 2025 00:45:40 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it.
 [79.45.205.118]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759c84e25besm5158765b3a.2.2025.07.21.00.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 00:45:39 -0700 (PDT)
Date: Mon, 21 Jul 2025 09:45:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH RFC v3 08/13] qmp: update virtio features map to support
 extended features
Message-ID: <7vcioc2tjiikvn5vne2ggdktok4d2ygr5ztllrf5mjepvwslim@cg2fetibx4ry>
References: <cover.1752828082.git.pabeni@redhat.com>
 <8a42515171c651101aa487519fbbc53dbe4c4c29.1752828082.git.pabeni@redhat.com>
 <e17fdd28-b8a7-42cf-a4c0-bc04ffeb3eea@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e17fdd28-b8a7-42cf-a4c0-bc04ffeb3eea@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 21, 2025 at 04:23:14PM +0900, Akihiko Odaki wrote:
>On 2025/07/18 17:52, Paolo Abeni wrote:
>>Extend the VirtioDeviceFeatures struct with an additional u64
>>to track unknown features in the 64-127 bit range and decode
>>the full virtio features spaces for vhost and virtio devices.
>>
>>Also add entries for the soon-to-be-supported virtio net GSO over
>>UDP features.
>>
>>Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>---
>>v2 -> v3:
>>   - unknown-dev-features-dword2 -> unknown-dev-features2
>>   - _array -> _ex
>>   - fixed typos in entries description
>>
>>v1 -> v2:
>>   - uint128_t -> uint64_t[]
>>---
>>  hw/virtio/virtio-hmp-cmds.c |  3 +-
>>  hw/virtio/virtio-qmp.c      | 89 ++++++++++++++++++++++++++-----------
>>  hw/virtio/virtio-qmp.h      |  3 +-
>>  qapi/virtio.json            |  8 +++-
>>  4 files changed, 73 insertions(+), 30 deletions(-)
>>

[...]

>>diff --git a/qapi/virtio.json b/qapi/virtio.json
>>index 9d652fe4a8..f2e2dd6e97 100644
>>--- a/qapi/virtio.json
>>+++ b/qapi/virtio.json
>>@@ -490,14 +490,18 @@
>>  #     unique features)
>>  #
>>  # @unknown-dev-features: Virtio device features bitmap that have not
>>-#     been decoded
>>+#     been decoded (bits 0-63)
>>+#
>>+# @unknown-dev-features2: Virtio device features bitmap that have not
>>+#     been decoded (bits 64-127)
>
>This documentation should contain "(since 10.1)" as described in:
>docs/devel/qapi-code-gen.rst

Good catch!

BTW 10.1 is already in soft-freeze, so I guess this will land in the 
next cycle, so I'd suggest to use 10.2

Thanks,
Stefano


