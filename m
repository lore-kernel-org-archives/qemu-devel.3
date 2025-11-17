Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132F1CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 07:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKtzv-00080Q-0s; Mon, 17 Nov 2025 02:50:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vKtzo-0007yF-Gt
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:49:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vKtzl-000710-3D
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:49:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763365791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5yHI6GRo3irNJeQRH7r0vzTpsJSXCdPhAiszTYXJjGY=;
 b=V4hZzWqp+/Ud9jwp/JzcsqQ7dbtadv6a6jq3gWvZnFF6HHMu/rS2XluHvyGN6OqNtBU4BA
 AiUn5iLck+AWUQPFsv21/nB5ThIykZ1mc8M/yhpoczCQnrTqtzjRCEZWsQC+v+XPhDQKZR
 Nopj/P+U0WLo1gm6vITgawnv7cRRUsY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-KNIA-9K0Mu6DvzFq7LBuKg-1; Mon,
 17 Nov 2025 02:49:47 -0500
X-MC-Unique: KNIA-9K0Mu6DvzFq7LBuKg-1
X-Mimecast-MFC-AGG-ID: KNIA-9K0Mu6DvzFq7LBuKg_1763365786
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB2161956089; Mon, 17 Nov 2025 07:49:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF59019560A7; Mon, 17 Nov 2025 07:49:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0DEC421E6A27; Mon, 17 Nov 2025 08:49:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Honglei Huang <honghuan@amd.com>
Cc: <alex.bennee@linaro.org>,  <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>,  <mst@redhat.com>,  <cohuck@redhat.com>,
 <pbonzini@redhat.com>,  <qemu-devel@nongnu.org>,  <Ray.Huang@amd.com>
Subject: Re: [PATCH] virtio-gpu-virgl: fix error handling in
 virgl_cmd_resource_create_blob
In-Reply-To: <20251117055112.99046-1-honghuan@amd.com> (Honglei Huang's
 message of "Mon, 17 Nov 2025 13:51:12 +0800")
References: <20251117055112.99046-1-honghuan@amd.com>
Date: Mon, 17 Nov 2025 08:49:42 +0100
Message-ID: <87ms4lrtd5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Honglei Huang <honghuan@amd.com> writes:

> The error handling logic was incorrect in virgl_cmd_resource_create_blob.
> virtio_gpu_create_mapping_iov() returns 0 on success and non-zero on 
> failure, but the code was checking whether to set the error response.
>
> The fix changes the condition from 'if (!ret)' to 'if (ret != 0)' to
> properly handle the return value, consistent with other usage patterns
> in the same codebase (see virtio-gpu.c:932 and virtio-gpu.c:354).
>
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  hw/display/virtio-gpu-virgl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 94ddc01f91..e60e1059df 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -701,7 +701,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
>          ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
>                                              cmd, &res->base.addrs,
>                                              &res->base.iov, &res->base.iov_cnt);
> -        if (!ret) {
> +        if (ret != 0) {

I recommend

           if (ret < 0) {

Why?

When a function returns true on success, false on error, we check for
error with

           if (!fn(...)) {

Same for functions returning a non-null pointer on success, null on
error.

When a function returns non-negative integer on success, negative
integer on error, we use

           if (fn(...) < 0) {

When a function returns zero on success, negative on error, both

           if (fn(...) < 0) {

and

           if (fn(...)) {

work.  I strongly prefer the former.  Why?

If fn() returns an integer, fn(...) < 0 is very likely correct (it's
incorrect only if fn() deviates from "return negative on error", which
is a bad idea).  If it returns a pointer or bool, fn(...) < 0 won't
compile.

If fn() returns an integer, fn(...) or fn(...) != 0 are likely correct
(same argument).  If it doesn't, they are likely backwards.

Because of this, an error check fn(...) == 0 triggers my spider sense
when I read the code: I stop and look up fn(...) to verify the error
check is correct.

Please don't write code that makes me stop and look up things when I
read it :)

>              cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>              return;
>          }


