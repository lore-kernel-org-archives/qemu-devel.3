Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C07CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 06:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKsuX-0008FO-Fa; Mon, 17 Nov 2025 01:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vKsuU-0008En-3q
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 01:40:22 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vKsuQ-0005px-TN
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 01:40:21 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AH6dw76070834
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 17 Nov 2025 15:39:58 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=rfk2mWrjAEvU7HmOKrIKIQDDO6cf0RyGdgtKEbK9tec=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763361598; v=1;
 b=ug1kfqT6mPKuC6cRBjPo3TM1SQDORWl2HNsKJu4nHsGJQFRf8GsXcQcSmYh1c3jr
 Z6rX40mG2pd6C2rA3wj4ExC8AA7SObZt5kMZW45+TmAqNHej+YiKXqH2a5CMEvsU
 rvxGOcB6e8r5wnVtVZXrQ9QJYigg5LgjHIS85Invm0SiK8UmIBcHaTN9xNtt04Xa
 mbb6Dm+u1diLF/HnQR1BSXSqoq/bKzsVJyfWdDmWLzTyKjlMfszBwLPTBRwIiw2W
 DDC7QYS+1cEY3Z2lpTpuEUWGDUMUmtleBmsbueM6/nt3cnYpeGVMOZu+IibymRhK
 7UYexL8TcDk5L7vKDyqHxw==
Message-ID: <5eca552d-31e6-4918-adf1-da2568af18ef@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 17 Nov 2025 15:39:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu-virgl: fix error handling in
 virgl_cmd_resource_create_blob
To: Honglei Huang <honghuan@amd.com>, alex.bennee@linaro.org,
 dmitry.osipenko@collabora.com
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com
References: <20251117055112.99046-1-honghuan@amd.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251117055112.99046-1-honghuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/11/17 14:51, Honglei Huang wrote:
> The error handling logic was incorrect in virgl_cmd_resource_create_blob.
> virtio_gpu_create_mapping_iov() returns 0 on success and non-zero on
> failure, but the code was checking whether to set the error response.
> 
> The fix changes the condition from 'if (!ret)' to 'if (ret != 0)' to
> properly handle the return value, consistent with other usage patterns
> in the same codebase (see virtio-gpu.c:932 and virtio-gpu.c:354).
> 
> Signed-off-by: Honglei Huang <honghuan@amd.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

This should also have:

Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")

