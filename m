Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21317C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3WGL-0004IN-9n; Mon, 07 Sep 2026 06:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3WGJ-0004I5-Ot
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3WGH-0008Nw-Lj
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788775656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1jFHgTvoAV+cL4LTnL9VtsBBRyqfmULDEuXOEomdM1I=;
 b=fqqhYR5VfQcm3K5zFq2W2WFN0E9eqpXkf0nSW3Ff2TF6xAYAxMKtv10Uc1608718t2ZBzI
 dJcD8usCqy0K/DV6vyc1o7YvvI8n6bzhhSzRcil5HO/boWaVrKeX0DBSbLV7jf8ldCPnnz
 61RBMQqx+IyeiqGYWFvwuGRjSt4GrJs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-6DFGHQhpMqe3zeWax_5eHw-1; Mon, 07 Sep 2026 06:07:34 -0400
X-MC-Unique: 6DFGHQhpMqe3zeWax_5eHw-1
X-Mimecast-MFC-AGG-ID: 6DFGHQhpMqe3zeWax_5eHw_1788775654
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-484362cb000so2284222f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 03:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788775653; x=1789380453; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1jFHgTvoAV+cL4LTnL9VtsBBRyqfmULDEuXOEomdM1I=;
 b=llF6+qabCg9r5XeL2x6Uzdy0xdZhAUKqWF3fhIgkxih1t6msTYXPZAv9ED2YhCTzFC
 ioWvUHbEyk3Q+J31hmv3hiE2ankGmMsSmTavahIOv5XHJTF+n6kgf/p9672c8lVBvYay
 CTyPkIFbfa4ZMa7ZQLyfjjwrormC/eLNHfVpFy9cmnvg/SUPc2kG1XpwCJLkZpoJiVQN
 VUwPtMEHJDTdnrgMQOC+bwm80mqe5c8kMolKkTf/PKYSn+aApyH6lLCi4BP2Jj+e8452
 tSvBQxOWeC7EZrw7hxANuTlslrp0RxIbJNwP4FlgCBAtCu/oKfPLpgg16Rcw5CDD7Qns
 ytNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788775653; x=1789380453;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1jFHgTvoAV+cL4LTnL9VtsBBRyqfmULDEuXOEomdM1I=;
 b=GE/xP6t3QbSIzMWG54bhJBeiLhRuH9ZSz60L5w5ThqVltV+iBiLLdjMzDZIfsqE+gL
 PLAvZamWVdlWm/WnAg6Er36JewIOHbbSsNl54uYUWg+2h2KLKPQ8HKwl3QKFBmMlAEcH
 sgtajKLRzpHamTudMBd3k3PaeCFswF61XzxmCoLQbZyiVEc4cz/yzUrl5tMkMgoKaQR+
 mzp7h8YowLbvSRXs8mdLkhxH2YJRB1bJ82FxjnUPFo3kf2ljJc7a+jxWZxGuliGyicZK
 cYRuX7SbyLP+Of0eLLTCvsFxziiHSFHPhArlvBDJRJWMge+7jXnFhaB9d3LzUS8iNYVK
 3CSw==
X-Gm-Message-State: AFuF++lLyUjrMiqPDPFHr0M09W72gWXfd/1N9iYXD5hxpAX4thqS/ZRt
 OWKfsADOIYB2JdJFOx5t9uGHjl/FowIBufTXhDrcr+jkU2JjJyPEsxaOab8LnrXc/jk9uMuApHs
 2pVQZjmatPCbcqMmY0QMpy+Hl6F95QdFWOTZaYwd0EshTzr5kkTQFyPqU
X-Gm-Gg: AYBFou3Qj3bjQDK0d6/qbW99KzonVyEaMRnXbi1RQWRejRqUCzkDBTdDqRM9P2pTmv6
 IMu3WNfLiT56CssAwNUo3RXLXwI/kJ2C9TjD97yarJKNRpKLje/Z9L9Kphhx9IPKWkU63PdpRwF
 2LqkmtqxXpi+cSt3YKZFeIlHERr1uCIHL9bICjniP/jQ+h/m2KOx5D1JJ4NqeE/0YUjX6DYj4uU
 RB8hnG8NkRDbW+cMPBSLjFnnpURDF3zO8UwwgEgTal2yKy88+de2dUlWRb3DujITjWPKU2aByGy
 V0jkxcfz82ozpRBXnhISvgKuaZqlF6f/zkzCOXQSfy1rf9aiMJI0Pdyf797RuqYbWKmUtZ/taJs
 LovI=
X-Received: by 2002:a05:6000:430d:b0:485:8226:c698 with SMTP id
 ffacd0b85a97d-4858226c977mr27504054f8f.23.1788775653538; 
 Mon, 07 Sep 2026 03:07:33 -0700 (PDT)
X-Received: by 2002:a05:6000:430d:b0:485:8226:c698 with SMTP id
 ffacd0b85a97d-4858226c977mr27503991f8f.23.1788775652972; 
 Mon, 07 Sep 2026 03:07:32 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.96.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bfe14sm27797384f8f.35.2026.09.07.03.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 03:07:32 -0700 (PDT)
Date: Mon, 7 Sep 2026 12:07:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v4 00/10] migration/cpr: support vhost-vsock devices
Message-ID: <ap6Mvify0SILdfn8@sgarzare-redhat>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <c656126b-fa5f-48e9-b841-665f1f097b6c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c656126b-fa5f-48e9-b841-665f1f097b6c@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On Mon, Aug 31, 2026 at 02:16:13PM +0300, Andrey Drobyshev wrote:
>On 8/20/26 2:39 PM, Andrey Drobyshev wrote:
>> v4 is mostly fixes suggested by Stefano.
>>
>> v3 -> v4:
>>
>>   * Patch 1 (NEW) ("vhost-vsock: block CPR migration modes"): block the
>>     CPR modes until the support is fully in place.  Make mid-series CPR
>>     attempts fail early and gracefully instead of crashing;
>>   * Patch 2 -> 3 ("vhost-vsock: don't reset connections during CPR"):
>>     write vhost_vsock_post_load() in its final shape, not defer to the
>>     last patch;
>>   * Patch 4 -> 5 ("vhost-vsock: preserve vhost FD during CPR"): reword
>>     commit message;
>>   * Patch 5 -> 6 ("vhost: factor out vhost_dev_init_backend()"):
>>     document vhost_dev_cleanup() on error;
>>   * Patch 7 (NEW) ("vhost: make vhost_dev_cleanup() safe on a partially
>>     initialized device"): split the vq->dev NULL check out of the
>>     ownership handoff patch;
>>   * Patch 9 (NEW) ("vhost: add vhost_dev_is_initialized() helper"): add
>>     an explicit 'initialized' field to struct vhost_dev instead of
>>     relying on hdev->mem;
>>   * Patch 7 -> 10 ("vhost-vsock: hand off device ownership across CPR"):
>>     - make the start guard in vhost_vsock_set_status() check
>>       vhost_dev_is_initialized() and vsock->owner_reset instead of
>>       vhost_dev.mem;
>>     - call vhost_dev_cleanup() if setting the guest cid fails in
>>       post_load;
>>     - lift the CPR blocker (narrow it to the ID-less case);
>>     - reword commit message.
>>
>> v3: https://lore.kernel.org/qemu-devel/20260626164643.2526-1-andrey.drobyshev@virtuozzo.com
>>
>> Andrey Drobyshev (10):
>>   vhost-vsock: block CPR migration modes
>>   vhost: add vhost_reset_owner op
>>   vhost-vsock: don't reset connections during CPR
>>   vhost-vsock: fix FD leak in realize()
>>   vhost-vsock: preserve vhost FD during CPR
>>   vhost: factor out vhost_dev_init_backend()
>>   vhost: make vhost_dev_cleanup() safe on a partially initialized device
>>   vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
>>   vhost: add vhost_dev_is_initialized() helper
>>   vhost-vsock: hand off device ownership across CPR
>>
>>  hw/virtio/vhost-kernel.c          |   6 +
>>  hw/virtio/vhost-vsock.c           | 220 +++++++++++++++++++++++++++---
>>  hw/virtio/vhost.c                 |  57 ++++++--
>>  include/hw/virtio/vhost-backend.h |   1 +
>>  include/hw/virtio/vhost-vsock.h   |   4 +
>>  include/hw/virtio/vhost.h         |  49 +++++++
>>  6 files changed, 307 insertions(+), 30 deletions(-)
>>
>
>Friendly ping
>

Sorry, I was on PTO, I'm going to review this week (hopefully today).

Stefano


