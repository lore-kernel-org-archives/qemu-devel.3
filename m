Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE77D65C68
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 10:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBWf5-0006QM-8s; Thu, 14 Nov 2024 05:01:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tBWf3-0006OF-2Q
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 05:01:13 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tBWf1-0005NL-2p
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 05:01:12 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1731578464; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FmJQPdOO9RYATCzEl3hNLxopQT51B3zLmw9EAZWPj4mDRFseTSxJCZZFQ22gmAoPTpYcT9gAk8AVpKdwS6hq+PEW3JkkurywlxOwhUoMPDHIFkTXaO/8Z2w8UqBUMGqsGMucwrgZKTA5VqdhyQXIMFDAxWFwSai4HpVj0faIMIw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1731578464;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=EjEJzf8CsYwPKLKIG5oKhdvfLVY/zQxXGsTbWfcWLZ8=; 
 b=kYxXMNCnY/GeFczhqCW3FGfaUhxYzgS4Yt2+jaH91EMSnK6PKTqbvLMTBRlR2Nz1Dr/y9Oy9s07wt4YyLyz95NCTcw+Ip+sjsqbb/s3oWn5qRO64cyazA+xi2InlQqP8qYGA6f1DSMJRl+y0ed6w66E3yalPp1HIaFKnRb51W0M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731578464; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=EjEJzf8CsYwPKLKIG5oKhdvfLVY/zQxXGsTbWfcWLZ8=;
 b=kwrmpUhBaJO8cnxnLEX6zrk0H+wxkUHB26h4oQgeUxy6lE+hHWXsSOTmIYURahtU
 n1iPROPPwXoxlhSPQ5uo74TO6eTNvHGp/OIaWl9F0maupNsSuZeJhkVF3/WHhoRaS75
 O3ZHxPZmaj3XIgu1TUS8oAai1GpUMfs1m0Gsz9nY=
Received: by mx.zohomail.com with SMTPS id 1731578462590295.3042169689453;
 Thu, 14 Nov 2024 02:01:02 -0800 (PST)
Message-ID: <47eed205-7cc9-4cb9-82c0-06eaa81b56d2@collabora.com>
Date: Thu, 14 Nov 2024 13:00:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/display: factor out the scanout blob to fb
 conversion
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
References: <20241111230040.68470-1-alex.bennee@linaro.org>
 <20241111230040.68470-2-alex.bennee@linaro.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20241111230040.68470-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/12/24 02:00, Alex Bennée wrote:
> There are two identical sequences of a code doing the same thing that
> raise warnings with Coverity. Before fixing those issues lets factor
> out the common code into a helper function we can share.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> ---
> v2
>   - fix compile of virtio-gpu-virgl
>   - tweak comment for blob_size
> ---
>  include/hw/virtio/virtio-gpu.h | 15 +++++++++
>  hw/display/virtio-gpu-virgl.c  | 22 +------------
>  hw/display/virtio-gpu.c        | 60 +++++++++++++++++++++-------------
>  3 files changed, 53 insertions(+), 44 deletions(-)

...
> +    return true;
> +}
> +
> +
> +
>  static void virtio_gpu_set_scanout_blob(VirtIOGPU *g,

Super-nit: the extra newlines are still there. You may edit them when
applying, otherwise we can live with them for now too :)

Thanks for addressing rest of the v1 comments!

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

