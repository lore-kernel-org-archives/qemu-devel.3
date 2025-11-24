Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAEACFD35A
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 21:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNe7Y-00035f-U8; Mon, 24 Nov 2025 16:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vNe7X-000350-DL
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 16:29:15 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vNe7V-0002B4-Or
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 16:29:15 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1764019735; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WNuNwbydehGAKVPWkadgdOGHa5yx96y0SJKtja5dIHeOmuVVC2KTwdu0FYaZgYl/jMyraNObGjSOr2CRnaIKlRacjD+yfWND6aNOJHa60qtWzCK71xa7Ln7BOIsKkNQ4Qezse7l7Jwf/sethRjblCjCdkc3s0RUTGAmzb7HYazc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1764019735;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=hTH1pOkaBQxStiEDOzRG8+oy0n/iY9EvYmXhWfPQpbo=; 
 b=DB8CvF3RJcjFB9DM7nsf9L3XDi8EQaHMo5zCMZyWKhbMG86RPmUAxvUdeeU/wkjy80yktJSIOA8FQopDWcWi70Bv73ZuUoBYax75s2g7CwdVRrp3PQVltTQf8pVZIDtC0CYhUf72kRdHLSyoZCbzHg4A4Bl8re5geyaFmp3qMWs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764019735; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=hTH1pOkaBQxStiEDOzRG8+oy0n/iY9EvYmXhWfPQpbo=;
 b=UZ/MSsB5QtFKbvCaFeldkF4KEdrkv/s2LRndeFd4yq8tIwszeICfn4nZCphSmYnI
 982UfBHRwv0HKmY66M3lJn98s6ak5b3sxlCezKJOTuOK0del0RJ6VpTRc825UWCPtIt
 40UMhCCVxYislk0Tg+o+os3MbVdpcAuPSQWnd+P4=
Received: by mx.zohomail.com with SMTPS id 17640197334407.1296674011802;
 Mon, 24 Nov 2025 13:28:53 -0800 (PST)
Message-ID: <19852f51-0c20-463d-98d7-5219f17ca45c@collabora.com>
Date: Tue, 25 Nov 2025 00:28:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 1/2] virtio-gpu: fix error handling in
 virgl_cmd_resource_create_blob
To: Honglei Huang <honghuan@amd.com>, alex.bennee@linaro.org,
 odaki@rsg.ci.i.u-tokyo.ac.jp, armbru@redhat.com
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com
References: <20251124032423.227712-1-honghuan@amd.com>
 <20251124032423.227712-2-honghuan@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20251124032423.227712-2-honghuan@amd.com>
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

On 11/24/25 06:24, Honglei Huang wrote:
> Fix inverted error check in virgl_cmd_resource_create_blob() that causes
> the function to return error when virtio_gpu_create_mapping_iov() succeeds.
> 
> virtio_gpu_create_mapping_iov() returns 0 on success and negative values
> on error. The check 'if (!ret)' incorrectly treats success (ret=0) as an
> error condition, causing the function to fail when it should succeed.
> 
> Change the condition to 'if (ret != 0)' to properly detect errors.
> 
> Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
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
>              cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>              return;
>          }

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

