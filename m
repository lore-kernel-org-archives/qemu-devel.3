Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CE2F46112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fXl-0006I5-6A; Mon, 23 Mar 2026 09:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w4fXf-0006Gp-Vm
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w4fXa-0004Em-CM
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774273316;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFR/uvyPyMIgIXD2fn4+1E5+IwSBm0k0CtQI5ytOBHM=;
 b=Gie/ahJLmVuvXCq/TOop9R9BbqYVHafklttFtUn3RAXEk28Rr/HES/kLBIaj2QvrmmY8nZ
 +qg6hujtCfIavMWnjVRmoHbwMP9ZT6SIwIGGlcynadTCxub8B5c6754ldq82uVm3Nxsrk1
 A1o71T/67khuDcgwRy93mJSw5eZq+L4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-El3kUb4KNFm2U59OrEaHeg-1; Mon,
 23 Mar 2026 09:41:52 -0400
X-MC-Unique: El3kUb4KNFm2U59OrEaHeg-1
X-Mimecast-MFC-AGG-ID: El3kUb4KNFm2U59OrEaHeg_1774273306
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79FA51955DDB; Mon, 23 Mar 2026 13:41:46 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.227])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAD1B300019F; Mon, 23 Mar 2026 13:41:43 +0000 (UTC)
Date: Mon, 23 Mar 2026 13:41:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, mst@redhat.com,
 yuri.benditovich@daynix.com, akihiko.odaki@daynix.com,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] virtio-net: validate RSS indirections_len in post_load
Message-ID: <acFDFHsh8Rjhfncc@redhat.com>
References: <20260323131531.1976-1-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323131531.1976-1-junjie.cao@intel.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 23, 2026 at 09:15:31PM +0800, Junjie Cao wrote:
> virtio_net_handle_rss() enforces that indirections_len is a non-zero
> power of two no larger than VIRTIO_NET_RSS_MAX_TABLE_LEN, but
> virtio_net_rss_post_load() applies none of these checks to values
> restored from the migration stream.
> 
> A crafted migration stream can set indirections_len to 0.  Even if it

The migration stream originating from the source QEMU is trusted.

Is there a problem you can demonstrate with regular QEMU commands
/ versions, not crafting a malicious migration stream.

> also clears redirect, virtio_load() calls set_features_nocheck() after
> the device vmstate (including the RSS subsection and its post_load) has
> already been loaded, re-deriving redirect from the negotiated guest
> features.  When VIRTIO_NET_F_RSS was negotiated, redirect is set back
> to true regardless of the migration stream value.  The receive path
> then computes
> 
>     hash & (indirections_len - 1)   /* wraps to 0xFFFFFFFF via int promotion */
> 
> and uses the result to index into indirections_table, which was not
> allocated by the VMState loader when the element count is zero (see
> vmstate_handle_alloc()), resulting in a NULL pointer dereference that
> crashes QEMU:
> 
>   #0  virtio_net_process_rss    ../hw/net/virtio-net.c:1901
>   #1  virtio_net_receive_rcu    ../hw/net/virtio-net.c:1921
>   #2  virtio_net_do_receive     ../hw/net/virtio-net.c:2061
>   #3  nc_sendv_compat           ../net/net.c:823
>   #4  qemu_deliver_packet_iov   ../net/net.c:870
> 
> The RSS subsection is only loaded when rss_data.enabled is true (via
> virtio_net_rss_needed()), and the command path always produces
> indirections_len in {1, 2, 4, …, 128}, so an unconditional check
> cannot reject a legitimate migration stream.
> 
> Fixes: e41b711485e5 ("virtio-net: add migration support for RSS and hash report")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>  hw/net/virtio-net.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 2a5d642a64..3038836098 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3427,6 +3427,15 @@ static int virtio_net_rss_post_load(void *opaque, int version_id)
>          n->rss_data.supported_hash_types = VIRTIO_NET_RSS_SUPPORTED_HASHES;
>      }
>  
> +    if (n->rss_data.indirections_len == 0 ||
> +        n->rss_data.indirections_len > VIRTIO_NET_RSS_MAX_TABLE_LEN ||
> +        !is_power_of_2(n->rss_data.indirections_len)) {
> +        error_report("virtio-net: saved image has invalid RSS "
> +                     "indirections_len: %u",
> +                     n->rss_data.indirections_len);
> +        return -EINVAL;
> +    }
> +
>      return 0;
>  }
>  
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


