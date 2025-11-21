Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A531DCF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd6Z-0004Pu-8l; Fri, 21 Nov 2025 21:12:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vMckc-0001D8-NX
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:49:25 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vMcib-000556-6z
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:49:19 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763748063; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SGdq7p4vxF1vCuwhfTM2lLRQShqNfpiE7rZYRgJs015bZPHIe6KE8YVF0T11lguQR488AT/4HDuDwJBnkpkMcbAQUVXUkF5p3sGTRz4shm0jI+Zo5hXjxU4OLhq+5oP6Xy6i85N2eNaDmicFsLGeIYyGFmSX4gZdn94jIzI8rAI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763748063;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wPeIlaJHuo4cYtPbPURSef3BMIAudGoPvkeIJ7+n8i4=; 
 b=iPTH/wN+e99xtA/JDDshqikOv5SA+SsMTHip1BN2Ui9o/xUTRfEqH03vXuzh8/4WQda6N818OHfWTn/gYkILY9HY6BZ3w9MBqErDjLej8n/ZRCt4sqdm09ijgVPkHjXNtnN9rDQUoZ9bA2t9WORDrgLjy5EfEdTPDzohYWoABE4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763748063; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=wPeIlaJHuo4cYtPbPURSef3BMIAudGoPvkeIJ7+n8i4=;
 b=c+V89hzxy9TAzZOHlhFrkfj+XQyr7GPSO67qEmDhuD6ZpB3bMUmc0f8vryEj1dJ2
 mnW4hqIRYUhhjO+YmzOd3gAE4UREehHT7X0ggcDMc5rb0v11EnbFxePoSQV9g1sKl42
 4itNzJVS6BYhgYtYjn+zIcL91Tf7FRjugUXWd3fo=
Received: by mx.zohomail.com with SMTPS id 1763748059907203.62618332581224;
 Fri, 21 Nov 2025 10:00:59 -0800 (PST)
Message-ID: <b828a7e0-5422-415b-b4da-2442b0c924a1@collabora.com>
Date: Fri, 21 Nov 2025 21:00:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] virtio-gpu: use consistent error checking style for
 virtio_gpu_create_mapping_iov
To: Honglei Huang <honghuan@amd.com>, alex.bennee@linaro.org,
 odaki@rsg.ci.i.u-tokyo.ac.jp, armbru@redhat.com
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com
References: <20251121075802.1637598-1-honghuan@amd.com>
 <0ef0b85a-d45b-4efc-ac1e-b562b1d34786@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <0ef0b85a-d45b-4efc-ac1e-b562b1d34786@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
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

On 11/21/25 11:14, Honglei Huang wrote:
> 
> 
> On 2025/11/21 15:58, Honglei Huang wrote:
>> Fix error handling logic in virgl_cmd_resource_create_blob and improve
>> consistency across the codebase.
>>
>> virtio_gpu_create_mapping_iov() returns 0 on success and negative values
>> on error, but the original code was inconsistently checking for error
>> conditions using different patterns.
>>
>> Change all virtio_gpu_create_mapping_iov() error checks to use consistent
>> 'ret < 0' or 'ret >= 0' patterns, following the preferred QEMU coding
>> convention for functions that return 0 on success and negative on error.
>> This makes the return value convention immediately clear to code readers
>> without needing to look up the function definition.
>>
>> Updated locations:
>> - hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_create_blob()
>> - hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_attach_backing()
>> - hw/display/virtio-gpu.c: virtio_gpu_resource_create_blob()
>> - hw/display/virtio-gpu.c: virtio_gpu_resource_attach_backing()
>> - hw/display/virtio-gpu-rutabaga.c: rutabaga_cmd_attach_backing()
>> - hw/display/virtio-gpu-rutabaga.c: rutabaga_cmd_resource_create_blob()
>>
>> Changes since v3:
>> - Extended consistency improvements to virtio-gpu-rutabaga.c
>> - Changed CHECK(!ret) to CHECK(ret >= 0) and CHECK(!result) to
>>    CHECK(result >= 0) in rutabaga functions for consistency
>> - Now covers all virtio-gpu files that use
>> virtio_gpu_create_mapping_iov()
>>
>> Changes since v2:
>> - Use 'if (ret < 0)' instead of 'if (ret != 0)' following maintainer's
>>    feedback on preferred QEMU coding style for error checking functions
>>    that return 0 on success and negative on error
>> - Updated all similar usages across virtio-gpu files for consistency
>> - Expanded scope from single function fix to codebase-wide style
>> consistency
>>
>> Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   hw/display/virtio-gpu-rutabaga.c | 4 ++--
>>   hw/display/virtio-gpu-virgl.c    | 4 ++--
>>   hw/display/virtio-gpu.c          | 4 ++--
>>   3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-
>> rutabaga.c
>> index ed5ae52acb..ea2928b706 100644
>> --- a/hw/display/virtio-gpu-rutabaga.c
>> +++ b/hw/display/virtio-gpu-rutabaga.c
>> @@ -466,7 +466,7 @@ rutabaga_cmd_attach_backing(VirtIOGPU *g, struct
>> virtio_gpu_ctrl_command *cmd)
>>         ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries,
>> sizeof(att_rb),
>>                                           cmd, NULL, &res->iov, &res-
>> >iov_cnt);
>> -    CHECK(!ret, cmd);
>> +    CHECK(ret >= 0, cmd);
>>         vecs.iovecs = res->iov;
>>       vecs.num_iovecs = res->iov_cnt;
>> @@ -616,7 +616,7 @@ rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
>>           result = virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
>>                                                  sizeof(cblob), cmd,
>> &res->addrs,
>>                                                  &res->iov, &res-
>> >iov_cnt);
>> -        CHECK(!result, cmd);
>> +        CHECK(result >= 0, cmd);
>>       }
>>         rc_blob.blob_id = cblob.blob_id;
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-
>> virgl.c
>> index 94ddc01f91..6ebd9293e5 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -557,7 +557,7 @@ static void
>> virgl_resource_attach_backing(VirtIOGPU *g,
>>         ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries,
>> sizeof(att_rb),
>>                                           cmd, NULL, &res_iovs,
>> &res_niov);
>> -    if (ret != 0) {
>> +    if (ret < 0) {
>>           cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>           return;
>>       }
>> @@ -701,7 +701,7 @@ static void
>> virgl_cmd_resource_create_blob(VirtIOGPU *g,
>>           ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
>> sizeof(cblob),
>>                                               cmd, &res->base.addrs,
>>                                               &res->base.iov, &res-
>> >base.iov_cnt);
>> -        if (!ret) {
>> +        if (ret < 0) {
>>               cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>               return;
>>           }
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index 0a1a625b0e..1038c6a49f 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -352,7 +352,7 @@ static void
>> virtio_gpu_resource_create_blob(VirtIOGPU *g,
>>       ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
>> sizeof(cblob),
>>                                           cmd, &res->addrs, &res->iov,
>>                                           &res->iov_cnt);
>> -    if (ret != 0) {
>> +    if (ret < 0) {
>>           cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>           g_free(res);
>>           return;
>> @@ -931,7 +931,7 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
>>         ret = virtio_gpu_create_mapping_iov(g, ab.nr_entries,
>> sizeof(ab), cmd,
>>                                           &res->addrs, &res->iov,
>> &res->iov_cnt);
>> -    if (ret != 0) {
>> +    if (ret < 0) {
>>           cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>           return;
>>       }
> 
> This v4 patch started as a bug fix for error handling in
> `virgl_cmd_resource_create_blob()` but evolved through community
> feedback to include comprehensive code style consistency improvements,
> unifying error checking patterns (`ret < 0`) across all virtio-gpu files.
> 
>  This version appears to have gained community consensus and may be
> ready for acceptance.
> 
> Correct me if I am wrong.

I was previously very puzzled by what bug is fixed and didn't notice it,
seeing only the err < 0 changes. Now I see which code is fixed after you
pointed it out explicitly.

The common practice is:

1. Bug fix patches should contain only fixes
2. All code improvements should be done in separate patches
3. Bugfix patches should be first in the series, improvements follow
them on top of the fixes

So here should be two patches:

1. The virgl_cmd_resource_create_blob() fix
2. virtio_gpu_create_mapping_iov() err handling improvement

-- 
Best regards,
Dmitry

