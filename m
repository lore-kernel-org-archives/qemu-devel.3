Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBDDC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6sZX-0001zj-Ep; Wed, 16 Sep 2026 12:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x6sZQ-0001tv-Vj
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:33:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x6sZO-0006RY-Qf
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789576392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DeAOrkWI0/qZYRU8Z1NR871zhU56VzEiJlm7V2+JW68=;
 b=S12TqZS7duUB0+2TBdfTUK4T7xODvNOp9vI+yqlsu0lG14OrboB4A+bLnG+HV8+4Idcdq1
 +lP+MG57kmyWG+wmw8n2yUuC5Qp+xaNsS7smeAkLn67Eo/GcqyrqrL+D1/8hc2fEAOprea
 w/yyxulDV58b0jSt2Jc6hs09FYVW/CY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-cHX3QMzoMcuYj_UXm2UeBw-1; Wed, 16 Sep 2026 12:33:09 -0400
X-MC-Unique: cHX3QMzoMcuYj_UXm2UeBw-1
X-Mimecast-MFC-AGG-ID: cHX3QMzoMcuYj_UXm2UeBw_1789576388
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4870a0fe60fso966026f8f.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789576388; x=1790181188; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DeAOrkWI0/qZYRU8Z1NR871zhU56VzEiJlm7V2+JW68=;
 b=LLBi5DuIS1gQ8XfSbe88N4DLWqbX8Szhk7L8yLs9d78UXrzdKQ6AovS2rK5Nqh+k9S
 MynsdCS6sG4k2zHLEzUiRFM62gHiQh527ixDBVqXidY+EhSb3wc8IV235d4CcU+9UVa6
 Q/YPSiI81c5sXMhJiKe77Ye9zlCLJq0X+jKewiNdkxZ8/LMRbnn/CeJ4iC7JZMCnQ8rE
 qnmii7vzTGC+GIFqTIJcm5VdpowjoLbl40Gx8EOi2onpUGJE6JcDsAqbKsux0cyOrZb2
 NMNHIuiYBZkCCP0RfYA/L6BtfiFNlHZHmW0PBYAn9+ybJWJewstTAv9OpNDgJqimY4ba
 WnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789576388; x=1790181188;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DeAOrkWI0/qZYRU8Z1NR871zhU56VzEiJlm7V2+JW68=;
 b=G0s9UsvgoSbruFab7Wl0EFk8VlLMgJwmilIexalQ0kjoRpL1FdS2CNiHSUnxfCBfrh
 Qhc2IgcLMJQALdRHNKYSstJ2U64ZR0LDlw5rKxThXYo84IMKHzU/Zx9MBs1rJtZmiSJf
 rWuejkn22lLVZumGXR+HQtT970+dwHLZvFJ2xetweD2yPunk32nqpp/Nu47L5un3D2my
 l7aH7bNv7VyUa1BA0B0CCl+0Z2CsJhqJMktTaw8iEjCjKvwr0bmz3R8bsxR/kVRAryrk
 CncTkFZGjK2sK9EdZoClOAv1AxhyGAMFd0Jnlxyd4tFW+0yIksVCRkxo7SXDrXwXssBA
 A3Cw==
X-Gm-Message-State: AFuF++luxlG3aNjtm8s4sX0Xz42tQq5QIdizTquM30tPYS+2yIsh7J/9
 OYNOhKe+kIZChLmGhZYHQbs+2gQKKsk38Sbk6aqTCxYDQKH4lfyne0OTwGbkoXyLV3ioaGC2uq0
 nBvY1Iv+LkN3d4JGzWr+LbqUYPSHyQWKzQgsXvAvCg//DGIW5zDZeCvVz
X-Gm-Gg: AYBFou0b8nPLJ8eE+aGd2v/3Y7TaT6hKtOCj7y8YiAHi+tpQWCxBuOm+wB5Dv2qeCdP
 mmyyOTbjShu9c59vvK/g73UeXeIIQAJ1lz1dP5LO+2uVBtMkSh4c/XDcQA3QAlZQgYCu6cSNp6N
 SKcJQ881uWifJ1IAA8JmTp63PIH1c2thDTXVe0Riy6w8/DLFIOZJG82afWfv5EcAYwf/4G+dnwE
 3I9o1UXHbGhUnCt39MPSLnwI5TR0lv7R9vzyy86Q+fiX76ry/Wbzju8cL0EhV6OTO1IUjCAuaqO
 65PPVX3NNfd5C6XjWVAAw8I5w74s2W+tmOqSBCmeNeCdr/z/JUqpf8ZBVAlu15+hsmQJoOVdcp8
 kxsCcw6aEpfKxlrtHsmUevRISQjihCD93cJ8VOFRXlI69jg==
X-Received: by 2002:a05:6000:22c5:b0:487:981:4e05 with SMTP id
 ffacd0b85a97d-4870d269cc8mr5045453f8f.32.1789576387654; 
 Wed, 16 Sep 2026 09:33:07 -0700 (PDT)
X-Received: by 2002:a05:6000:22c5:b0:487:981:4e05 with SMTP id
 ffacd0b85a97d-4870d269cc8mr5045387f8f.32.1789576387128; 
 Wed, 16 Sep 2026 09:33:07 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf462cesm8238498f8f.37.2026.09.16.09.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 09:33:06 -0700 (PDT)
Date: Wed, 16 Sep 2026 18:33:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, mark.kanda@oracle.com, 
 farosas@suse.de, den@openvz.org, clg@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, mst@redhat.com, dongli.zhang@oracle.com,
 peterx@redhat.com
Subject: Re: [PATCH v6 14/14] vhost-vsock: hand off device ownership across CPR
Message-ID: <aqrDcFrLWGBF_-pg@sgarzare-redhat>
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
 <20260915-up-vsock-vhost-v5-v6-14-4d31b2dc6afd@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260915-up-vsock-vhost-v5-v6-14-4d31b2dc6afd@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 15, 2026 at 11:59:50PM +0300, Andrey Drobyshev wrote:
>The previous patches reuse the source vhost FD on the destination,
>however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
>in realize().  For cpr-transfer the destination realizes while the source
>still owns the shared FD, so its SET_OWNER would fail - ownership has to be
>handed over explicitly.
>
>Do this through the device's CPR vmstate hooks.  Namely, release device
>ownership in pre_save, reclaim in post_load, re-acquire on restart:
>
>  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
>    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
>    cpr-exec).
>
>  - .realize(), for an incoming CPR, only sets up the virtio device and
>    queries the backend features by calling vhost_dev_init_backend().
>    It doesn't take device ownership and doesn't touch the VQs which
>    still-running source might use.  The full init is deferred to
>    .post_load().
>
>  - .post_load() reclaims it on the destination: the full vhost_dev_init()
>    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
>    the device is started at vm_start.
>
>  - .set_status() refuses to start a device whose init hasn't completed
>    yet (incoming CPR before post_load).
>
>  - .set_status() re-acquires ownership before starting the device if
>    pre_save released it and this QEMU is about to run the guest again:
>    the migration failed, or it completed and the management resumed the
>    source (e.g. cpr-transfer target died).
>
>With the handoff in place, lift the CPR blocker.
>
>Note: this requires kernel side support of VHOST_RESET_OWNER operation
>for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().
>
>Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost-vsock.c         | 162 +++++++++++++++++++++++++++++++++-------
> include/hw/virtio/vhost-vsock.h |   2 +-
> 2 files changed, 134 insertions(+), 30 deletions(-)

This LGTM and also fixes the issues in patch 9 IIUC, so IMHO it's better 
to squash them. What is the advantage of having patch 9 changes in 
another patch?

Thanks,
Stefano


