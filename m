Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C45C2D0CD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 02:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHCjX-0002yA-6O; Mon, 19 May 2025 22:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uHCjW-0002xx-3o; Mon, 19 May 2025 22:29:34 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uHCjU-00021r-6x; Mon, 19 May 2025 22:29:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1747708161; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GZV15ZaJm1Wtx2CIG6TJ/rih/BSUZe6PB1fS9gRqHOACU2XGGsuEupWtucpgY0gxvWV/TgVj8TEbDrgwF7eNKYm5P0YzaJVdW1ava2VSeXMGfL6mMuhJHxBzU8jS8louuiJMmP/LjwSNyBOEIQpyzjUki10nl+B5dTNz0ij8zvA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1747708161;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=D/dyr7e6EQagYJPbvp6PG6zc0AJlvB7n8MkQwsnhiAI=; 
 b=gDKM1qw6+uc68ESqpdmqqnzGIkhHCd9iwPvjzOlY0K8ZU97E8RHx2QpnRph4hJUG/0LV+jU1Vxad1wPeRoK5flO5smXorVb7FtI6fys3OndMD2zYoZ6EmM0FftLmWdMqFK2N2N13DkQ+ePbMk16OV9kYuiZomuXbX+Kr/poUTuo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747708161; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=D/dyr7e6EQagYJPbvp6PG6zc0AJlvB7n8MkQwsnhiAI=;
 b=iXZN1tvreCPOihYiV+eIAdTCARNHXRw83GmKiKsAgeWOQEYrgXFk62XiwPAXiamr
 TPBAsxeNZlYpPkitpODrDpigeuLkSLQa3nf1+Hd+I0tCY8zhTcF2yzJZKOVgKxH1RRn
 cuh5yqMxHWQ6/BMdS33UfaaPYrOeo2MO0jKURHwE=
Received: by mx.zohomail.com with SMTPS id 1747708158503882.8965376596562;
 Mon, 19 May 2025 19:29:18 -0700 (PDT)
Message-ID: <f4bcd5ba-bddf-4155-bb7e-3a0ac6ccb631@collabora.com>
Date: Tue, 20 May 2025 05:29:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-gpu: support context init multiple timeline
To: Yiwei Zhang <zzyiwei@gmail.com>
Cc: qemu-devel@nongnu.org, balaton@eik.bme.hu, qemu-stable@nongnu.org
References: <20250518152651.334115-1-zzyiwei@gmail.com>
 <6420d58e-ab55-448b-a860-889d3fed04a2@collabora.com>
 <CAJ+hS_j14ZY97rLgWQ5-F+Yiw8cY-pXABNSBNYCto7dNA9qHdA@mail.gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAJ+hS_j14ZY97rLgWQ5-F+Yiw8cY-pXABNSBNYCto7dNA9qHdA@mail.gmail.com>
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

On 5/20/25 01:20, Yiwei Zhang wrote:
>> Is it possible that virglrenderer will ever write a context fence in
>> virgl_renderer_create_fence()? Do we really need this check?
> I assume you were referring to whether a context fence can be written
> in virgl_write_fence(). Yes, the fenceq contains both the global
> fences and context specific fences. Without the check,
> virgl_write_fence() will signal any context fence with a fence id
> smaller than the latest signaled virgl global fence.

Indeed, I was comparing with the async-cb variant and forgot that async
one uses separate fence list.

-- 
Best regards,
Dmitry

