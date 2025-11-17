Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72223CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxnq-0006y0-HV; Mon, 17 Nov 2025 06:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vKxnp-0006xh-3d
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:53:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vKxnm-0005Gp-T3
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763380425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MXZiOZNlTcOZBOE8TR/AQwYK1U6qMIN6umQpVD2GZko=;
 b=LKvpjwGpgF0FGBRsJAGIBz+G8nialVN6P4qx1/GqnSet0QPysr74MkwUlACXHDe8xJBJ6J
 EfnVqaJK7u9Q/SZ+T45gfFYWpS/Otcre6S1bZcfr2GzdbELV7ZNJVjdi1I0sl4REgyMoR9
 jGNeswFr4XChu4vyN+TcpOC2FEF2QoY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121--5ovsgPTOo-4hd23QyVzOQ-1; Mon,
 17 Nov 2025 06:53:42 -0500
X-MC-Unique: -5ovsgPTOo-4hd23QyVzOQ-1
X-Mimecast-MFC-AGG-ID: -5ovsgPTOo-4hd23QyVzOQ_1763380420
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3F9D18AB40D; Mon, 17 Nov 2025 11:53:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F082180049F; Mon, 17 Nov 2025 11:53:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5142921E6A27; Mon, 17 Nov 2025 12:53:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Honglei Huang <honghuan@amd.com>
Cc: <alex.bennee@linaro.org>,  <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>,  <mst@redhat.com>,  <cohuck@redhat.com>,
 <pbonzini@redhat.com>,  <qemu-devel@nongnu.org>,  <Ray.Huang@amd.com>
Subject: Re: [v4] virtio-gpu: use consistent error checking style for
 virtio_gpu_create_mapping_iov
In-Reply-To: <20251117105104.258513-1-honghuan@amd.com> (Honglei Huang's
 message of "Mon, 17 Nov 2025 18:51:04 +0800")
References: <20251117105104.258513-1-honghuan@amd.com>
Date: Mon, 17 Nov 2025 12:53:37 +0100
Message-ID: <87zf8kq3i6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Honglei Huang <honghuan@amd.com> writes:

> Fix error handling logic in virgl_cmd_resource_create_blob and improve
> consistency across the codebase.
>
> virtio_gpu_create_mapping_iov() returns 0 on success and negative values
> on error, but the original code was inconsistently checking for error
> conditions using different patterns.
>
> Change all virtio_gpu_create_mapping_iov() error checks to use consistent
> 'ret < 0' or 'ret >= 0' patterns, following the preferred QEMU coding
> convention for functions that return 0 on success and negative on error.
> This makes the return value convention immediately clear to code readers
> without needing to look up the function definition.
>
> Updated locations:
> - hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_create_blob()
> - hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_attach_backing()
> - hw/display/virtio-gpu.c: virtio_gpu_resource_create_blob()
> - hw/display/virtio-gpu.c: virtio_gpu_resource_attach_backing()
> - hw/display/virtio-gpu-rutabaga.c: rutabaga_cmd_attach_backing()
> - hw/display/virtio-gpu-rutabaga.c: rutabaga_cmd_resource_create_blob()
>
> Changes since v3:
> - Extended consistency improvements to virtio-gpu-rutabaga.c
> - Changed CHECK(!ret) to CHECK(ret >= 0) and CHECK(!result) to
>   CHECK(result >= 0) in rutabaga functions for consistency
> - Now covers all virtio-gpu files that use virtio_gpu_create_mapping_iov()
>
> Changes since v2:
> - Use 'if (ret < 0)' instead of 'if (ret != 0)' following maintainer's
>   feedback on preferred QEMU coding style for error checking functions
>   that return 0 on success and negative on error
> - Updated all similar usages across virtio-gpu files for consistency
> - Expanded scope from single function fix to codebase-wide style consistency
>
> Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


