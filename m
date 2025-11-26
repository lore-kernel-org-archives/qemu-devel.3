Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8842D10371
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 02:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO51H-0006Ii-IK; Tue, 25 Nov 2025 21:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vO51C-0006HV-0M
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 21:12:30 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vO516-0005V2-CC
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 21:12:27 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AQ2C1JJ004489
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 26 Nov 2025 11:12:01 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=CEfsxt6LqnK/ZxMgxsMvzMHMVwSCCWvlBrf5bKVJOfw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1764123121; v=1;
 b=Y9ApE8BfjRhrB95PP+oQF3IEyMHtyr6KyfkoLdwk9w+4e3mLKasxxKW3j6MGPZYL
 oqgh/tl42aUKbhyjg+r+u3Obo+XCMmnoSRc2IkCBis6wvrv3+u8+PLt8LXIAtTuF
 Nk/r0dMCUTP7HE8cfnYXFHPmpkNL4HC2sqqaqctFXpa2jEOWZiPaBDfqQ/q43G/H
 fWR3MN4x2spCSsie1cVpC69B9Rmo/FC6d8o4IUfn+jYqPpJOLrm1qxYs9HrTRj2y
 1zZOisBg1hp7fXvJr0cTrBzFSLG5Un96L84D5+0LRmTzWviOfBmRbFCpr5d8d+O6
 gJnYyJYtzIZ7lCFWnbp2yQ==
Message-ID: <0427fefb-347d-45c7-b83a-09c992c0cce9@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 26 Nov 2025 11:12:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 2/2] virtio-gpu: use consistent error checking for
 virtio_gpu_create_mapping_iov
To: Honglei Huang <honghuan@amd.com>, alex.bennee@linaro.org,
 dmitry.osipenko@collabora.com, armbru@redhat.com
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com
References: <20251126020208.2449414-1-honghuan@amd.com>
 <20251126020208.2449414-3-honghuan@amd.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251126020208.2449414-3-honghuan@amd.com>
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

On 2025/11/26 11:02, Honglei Huang wrote:
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

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

