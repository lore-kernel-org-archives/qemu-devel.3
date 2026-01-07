Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C26CDC198
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 09:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdQ3y-0000lk-M5; Wed, 07 Jan 2026 04:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vdQ3x-0000jj-Jh
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 04:42:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vdQ3w-0004mf-6M
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 04:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767778962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jQDx2T+HeKKnkQIuqHHC20iDo5Rh3611LRambLEaoOw=;
 b=WxIT3z1zmrF2C5MTXC+68vCRQVsJ+LV81fAEcppY65HyRADnhPMGqzD5Cfiscf/p/ZV0kv
 FcecPp3sdqpZInjqWotz1LG/BVefZdNGVmZRkez2PDiMJOrxtz2aabUWRLsJmrT4hG6C9k
 Foakv8dFHsFjZhHIZN7yCspEhBZBgyQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-o5EdkVpPPEOaXlvRhvmxJQ-1; Wed,
 07 Jan 2026 04:42:39 -0500
X-MC-Unique: o5EdkVpPPEOaXlvRhvmxJQ-1
X-Mimecast-MFC-AGG-ID: o5EdkVpPPEOaXlvRhvmxJQ_1767778957
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70BDB19560AD; Wed,  7 Jan 2026 09:42:37 +0000 (UTC)
Received: from localhost (dhcp-192-224.str.redhat.com [10.33.192.224])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 421EA1800285; Wed,  7 Jan 2026 09:42:36 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Honglei Huang <honghuan@amd.com>, alex.bennee@linaro.org,
 dmitry.osipenko@collabora.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 Ray.Huang@amd.com
Cc: mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 honghuan@amd.com
Subject: Re: [PATCH RFC v4 1/3] virtio-gpu: Add support for
 VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag
In-Reply-To: <20260107075030.3453924-2-honghuan@amd.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260107075030.3453924-1-honghuan@amd.com>
 <20260107075030.3453924-2-honghuan@amd.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Wed, 07 Jan 2026 10:42:33 +0100
Message-ID: <87tswxahdi.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jan 07 2026, Honglei Huang <honghuan@amd.com> wrote:

> Add support for the USE_USERPTR blob flag in virtio-gpu to enable
> user pointer mapping for blob resources. This allows guest applications
> to use user-allocated memory for GPU resources more efficiently.
>
> Changes include:
> - Add VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag definition
> - Enhance blob resource creation to handle userptr flag properly
> - Remove arbitrary nr_entries limit (16384) in mapping creation
> - Add conditional handling for userptr vs regular blob mapping
> - Support guest_blob_mapped parameter for virgl renderer
> - Fix value check issue in virtio-gpu
>
> This enables more flexible memory management between guest and host
> for GPU virtualization scenarios.
>
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  hw/display/virtio-gpu.c                     | 7 -------
>  include/standard-headers/linux/virtio_gpu.h | 1 +
>  2 files changed, 1 insertion(+), 7 deletions(-)

Please split out any updates to the imported Linux headers into a
separate patch to be replaced by a headers sync (I thought checkpatch
would warn about that?)


