Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E553C2D0CD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 02:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHCje-0002zL-94; Mon, 19 May 2025 22:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uHCjc-0002yu-QI; Mon, 19 May 2025 22:29:40 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uHCjb-00023D-0N; Mon, 19 May 2025 22:29:40 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1747708171; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jq8Tnr5pnfBqwVc3rdpe+5Fi96Ce2OrtIE09m3VZfeAmRhfBSeXi4Qlww52U8uGO/GW3u4aLjJa8rfoC4nOoczPZ6IIpuu4SppIwMM4WWcrF/R/dv5XkcODgFNXpBSLpKx38K1scL0wnQAVWBDpEp/yJeBw8P1xwN3wArhKerJM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1747708171;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=juU9oq6hnMv6+JU6EwraBuIgGy09BAztpzitJbcOd5Q=; 
 b=IZg3bdsE7PvhVZuyNCvpHh7LaHUeADMqFHfeTRRmOVBK01xclUg60e0AoaMTkYg7qd2AHKCueFnjST9aFb4+TsEWLPDtycQN2NMKWbsedBueBx6/WvB7W32ILvnKD8oJdQjZnrLazKv17H+Y9/vR7rgHLxwB6XKr4Ugz+pRZJHs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747708171; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=juU9oq6hnMv6+JU6EwraBuIgGy09BAztpzitJbcOd5Q=;
 b=LjR/JbFiK592L3ZWIeq21yPfnovMIXRKwt2dV1oTPnyOON+l3JdQ/5QRmLn61Kep
 5Zs1sK9TnVp1iPxu5aqbIJvtF7OKHfUKX9+mogU5s3CadlWtxa45uzq9FxChp1JPZyi
 Ef9cDUXf+7ERotY+HNCJU7TEdo4D2m56kRaGZ5GY=
Received: by mx.zohomail.com with SMTPS id 1747708169883793.5444802396709;
 Mon, 19 May 2025 19:29:29 -0700 (PDT)
Message-ID: <328b1fed-f23d-4ec1-ab06-c3096a76da19@collabora.com>
Date: Tue, 20 May 2025 05:29:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-gpu: support context init multiple timeline
To: Yiwei Zhang <zzyiwei@gmail.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, qemu-stable@nongnu.org
References: <20250518152651.334115-1-zzyiwei@gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250518152651.334115-1-zzyiwei@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/18/25 18:26, Yiwei Zhang wrote:
> +#if VIRGL_VERSION_MAJOR >= 1
> +static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
> +                                      uint32_t ring_idx, uint64_t fence_id) {
> +    VirtIOGPU *g = opaque;
> +    struct virtio_gpu_ctrl_command *cmd, *tmp;
> +
> +    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
> +        if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX &&

What if guest kernel version is very old and doesn't support ring_idx?
Wouldn't this write_context_fence() cb be used by vrend for signalling
fences without ring_idx info?

-- 
Best regards,
Dmitry

