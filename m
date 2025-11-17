Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA05CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 12:04:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxxZ-0002Wk-FV; Mon, 17 Nov 2025 07:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKxxY-0002WY-5Y
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 07:03:52 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vKxxV-0007tC-ON
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 07:03:51 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763381010; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UsuFY2ke2/zV1jouNwv/1CHuV8+cLQRk5ZhO2oMi+4RlSGIBfPg7FLowLdgUqywzwBHFep0NZIUGgKOi21ahcroWCuEFY/jVrgN2qLBKk7h/YOeHnx91AI4Y2yjSiZGtynotDc4y3u6thQLiRZbUm1OFPAtzvzjK4pbhg/WjKR0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763381010;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=8LjHtv97a8jNHSpL/vp6K0dhN4Cnv659mYnL0EZXz8o=; 
 b=lUa9i2QzREkb1bOQBVj91ZWHSgXIQjK6GobC3yiSaAtKZRH74pT7NaWJCKFtLvPRuS5oSFPO92vAQqey44sJrPsK/i7NuqhHoF5j/QCzuPvSc2V7KtuzfXudBhYTA1JhiguB4OYJXNIAbYSdjTWu6oXMMMBPhx/a/XhXZ3wp5xE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763381010; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=8LjHtv97a8jNHSpL/vp6K0dhN4Cnv659mYnL0EZXz8o=;
 b=UD/eRt9EosBllhu9lhNxfcKAs/sVubGwcy5IzX5ZmD2Cf4BbVwThj+HhCYjdc1zt
 +kmFP4jNBseYbV2fDleWFiIBPurld3ov4xTMW7PrNL9Eha+MrooAIdk4YlxxVEv38rU
 fufbXBN8Os1WdSPFNCEy1Tajp6v8EUlCmRihwZwk=
Received: by mx.zohomail.com with SMTPS id 1763381008192345.7475549443021;
 Mon, 17 Nov 2025 04:03:28 -0800 (PST)
Message-ID: <9f547fbe-ea57-4784-9e37-f79b52b551a9@collabora.com>
Date: Mon, 17 Nov 2025 15:03:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] virtio-gpu: use consistent error checking style for
 virtio_gpu_create_mapping_iov
To: Honglei Huang <honghuan@amd.com>, alex.bennee@linaro.org,
 odaki@rsg.ci.i.u-tokyo.ac.jp, armbru@redhat.com
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com
References: <20251117105104.258513-1-honghuan@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20251117105104.258513-1-honghuan@amd.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/17/25 13:51, Honglei Huang wrote:
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
> index ed5ae52acb..ea2928b706 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -466,7 +466,7 @@ rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>  
>      ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
>                                          cmd, NULL, &res->iov, &res->iov_cnt);
> -    CHECK(!ret, cmd);
> +    CHECK(ret >= 0, cmd);

virtio_gpu_create_mapping_iov() doesn't return positive values, don't
see how this change improves anything. You now saying that ret > 0 is
okay, while it shall never happen.

-- 
Best regards,
Dmitry

