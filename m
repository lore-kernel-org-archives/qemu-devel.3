Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F24FC3ABD8
	for <qemu-devel@archiver.kernel.org>; Sun, 18 May 2025 16:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGgpR-0000DW-KT; Sun, 18 May 2025 12:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uGgpP-0000Bm-HE; Sun, 18 May 2025 12:25:31 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uGgpN-0005IN-Mu; Sun, 18 May 2025 12:25:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1747585518; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LDGQjXaoc/3GxY9ZwP9hA76JGT77DIz3g9vGN7lZNUM6muxQQj3XgsaxxNcBkbxM+Wk4cPMXWKzkJpL7lOXkDWhempDZcU+DGoQ3lXMwWanhBiQos0klW8698NfEIIRYXEsBxKYdZQmLQHU6sAjQgJ+GYDvGU+aoqk44+YR6Bv0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1747585518;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=XxKCoX8BBegFBqChEZSZ2SwHsIwre29Xkq1ROGOJGNA=; 
 b=P16gw0WBnNOvtrhsvy2l2oDO/gCY7t1UlipCs93qM5tik5VoI6VvAjpVK7IpuqBM5DvPU3M67kirh/5pyqr3L8iDttBu7SkIRgAlxOntrxJRcb4YBPMSJatW1GIT++w8Fgs8rchq0/2jwVUdYKKHbdq/THxj8F/UNShTjTUSn8Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747585518; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=XxKCoX8BBegFBqChEZSZ2SwHsIwre29Xkq1ROGOJGNA=;
 b=iODYUDoecGaZy2Q+kuiCseueY/pPSSdQMlQ7WeEU8nkD/W2VNZ6pHXji6lYGrSrT
 OdLPKkhvpXyWtKyaWCxgNxRdDiK/ThzzYhEsDCIS7xzNrwwiFh4i743Axgx3KL+/fGl
 TMeY7PZuw/iDpdSnZSPgjVDkdew/SIMd4VpUWnoE=
Received: by mx.zohomail.com with SMTPS id 1747585515339960.8038940598573;
 Sun, 18 May 2025 09:25:15 -0700 (PDT)
Message-ID: <54e8f419-47e6-4786-8b4b-cc4c6bef10e7@collabora.com>
Date: Sun, 18 May 2025 19:25:12 +0300
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
> Venus and later native contexts have their own fence context along with
> multiple timelines within. Fences wtih VIRTIO_GPU_FLAG_INFO_RING_IDX in
> the flags must be dispatched to be created on the target context. Fence
> signaling also has to be handled on the specific timeline within that
> target context.
> 
> Before this change, venus fencing is completely broken if the host
> driver doesn't support implicit fencing with external memory objects.
> Frames can go backwards along with random artifacts on screen if the
> host driver doesn't attach an implicit fence to the render target. The
> symptom could be hidden by certain guest wsi backend that waits on a
> venus native VkFence object for the actual payload with limited present
> modes or under special configs. e.g. x11 mailbox or xwayland.
> 
> After this change, everything related to venus fencing starts making
> sense. Confirmed this via guest and host side perfetto tracing.

Thanks for the patch, looks good. Haven't realized that ring idx support
should've been a part of the context_init addition. Interestingly, it
never showed a problem during venus testing in the past.

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

There could be multiple sources of a problem RE frames going backwards.
I'm always testing venus in conjunction with async-cb patch that adds
per-context fencing support and it doesn't help the X11 WSI issue
discussed on [1]. Hence the Mesa WSI fixes still needed.

[1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/34283

-- 
Best regards,
Dmitry

