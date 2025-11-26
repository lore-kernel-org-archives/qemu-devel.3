Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51045D10381
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 12:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOEKP-0005tj-33; Wed, 26 Nov 2025 07:08:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vOEKF-0005st-IT
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:08:47 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vOEKD-0001ac-7l
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:08:47 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1764158909; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=blqD83/Kg1JbjWVJ8y78zbRNWrd2fLDL1RoQeNfSTkby7bq1oXqzm5fO0tZ0a5xOmb33JXcpvM8J8rPaBuWdwT4rPvSNnfdSexQ+4h+Ow9g3y5hqBJptJDFF/tkBf7E9qT1Io3yJFzzCYsuZZuSSpjMlEaUxc2aBsGXnZZparbs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1764158909;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=mdFF1S46chWaQKQrMyZ6rTugJFjhgDLB6eVZ2vbhfn8=; 
 b=CEuHs8opd7RoVdxx2Aom+lP/tssF1h11uQLqZrXjFuAJrsBlk3DNmy7vw3iTXQ5ZdjOzuOEGBxa0PnQPawMED2p4eJ1BqCyZKB80ZgrfCHw/WTYIRO6kaieudlUO4rt/HcbAQST4DmAx8hfIObUIaKDLG9u0dqYtuL/Oc1XIFH8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764158909; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=mdFF1S46chWaQKQrMyZ6rTugJFjhgDLB6eVZ2vbhfn8=;
 b=MEe+BmZbL9D5Cqe0iHIahiGyG6ULa2bf5dNdtrHgM7uSwuuRlk78Ms+jD0VbtDnx
 H71pH2+uuMd61czzJlAVJeaSdkEqpd028vah01upbKbXVcRMc4zOXOmWGKOd3zaB6Yc
 OFGxVxsExwF39oFGe05w7Wgsb4BBFujQBMP5ib3A=
Received: by mx.zohomail.com with SMTPS id 1764158906465455.6297610652814;
 Wed, 26 Nov 2025 04:08:26 -0800 (PST)
Message-ID: <624b3a45-24f5-4802-801b-748e20442366@collabora.com>
Date: Wed, 26 Nov 2025 15:08:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 2/2] virtio-gpu: use consistent error checking for
 virtio_gpu_create_mapping_iov
To: Honglei Huang <honghuan@amd.com>, alex.bennee@linaro.org,
 odaki@rsg.ci.i.u-tokyo.ac.jp, armbru@redhat.com
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com
References: <20251126020208.2449414-1-honghuan@amd.com>
 <20251126020208.2449414-3-honghuan@amd.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20251126020208.2449414-3-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.184.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender3-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/26/25 05:02, Honglei Huang wrote:
> Unify error checking style for virtio_gpu_create_mapping_iov() across the
> codebase to improve consistency and readability.
> 
> virtio_gpu_create_mapping_iov() returns 0 on success and negative values
> on error. The original code used inconsistent patterns for checking errors:
> - Some used 'if (ret != 0)' in virtio-gpu-virgl.c and virtio-gpu.c
> - Some used 'CHECK(!ret, cmd)' in virtio-gpu-rutabaga.c
> 
> For if-statement checks, change to 'if (ret < 0)' which is the preferred
> QEMU coding convention for functions that return 0 on success and negative
> on error. This makes the return value convention immediately clear to code
> readers.
> 
> For CHECK macro usage in virtio-gpu-rutabaga.c, keep the original
> 'CHECK(!ret, cmd)' pattern as it is more concise and consistent with other
> error checks in the same file.
> 
> Updated locations:
> - hw/display/virtio-gpu-virgl.c: virgl_resource_attach_backing()
> - hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_create_blob()
> - hw/display/virtio-gpu.c: virtio_gpu_resource_create_blob()
> - hw/display/virtio-gpu.c: virtio_gpu_resource_attach_backing()
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/display/virtio-gpu-virgl.c | 4 ++--
>  hw/display/virtio-gpu.c       | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index e60e1059df..6ebd9293e5 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -557,7 +557,7 @@ static void virgl_resource_attach_backing(VirtIOGPU *g,
>  
>      ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
>                                          cmd, NULL, &res_iovs, &res_niov);
> -    if (ret != 0) {
> +    if (ret < 0) {
>          cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>          return;
>      }
> @@ -701,7 +701,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
>          ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
>                                              cmd, &res->base.addrs,
>                                              &res->base.iov, &res->base.iov_cnt);
> -        if (ret != 0) {
> +        if (ret < 0) {
>              cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>              return;
>          }
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 0a1a625b0e..1038c6a49f 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -352,7 +352,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
>      ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
>                                          cmd, &res->addrs, &res->iov,
>                                          &res->iov_cnt);
> -    if (ret != 0) {
> +    if (ret < 0) {
>          cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>          g_free(res);
>          return;
> @@ -931,7 +931,7 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
>  
>      ret = virtio_gpu_create_mapping_iov(g, ab.nr_entries, sizeof(ab), cmd,
>                                          &res->addrs, &res->iov, &res->iov_cnt);
> -    if (ret != 0) {
> +    if (ret < 0) {
>          cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>          return;
>      }

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

