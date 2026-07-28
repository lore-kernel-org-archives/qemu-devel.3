Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EB5C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 06:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wobko-0002mq-2g; Tue, 28 Jul 2026 02:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wobkk-0002mX-LZ; Tue, 28 Jul 2026 02:57:26 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wobki-0003Qe-Rz; Tue, 28 Jul 2026 02:57:26 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66S6vIHE026492
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 28 Jul 2026 15:57:18 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=E2mQ5dPFlg7wSF/V0QU1NDcap666JAYAx1+P7fkpHdY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785221838; v=1;
 b=epwGjFel9CeUhkg3ARqWd7x0oRgx8TN6lh/XFxub+w82oUcq4nCCS9QzqLQwIZwt
 NBygvynQ+dyOHaQIF7cg2xyNagVNxqXDrOl/SYCiBaQbCj733zPg58JJEBQa/meF
 WFNiToLRgGxTCJQx4jfXUHuSmDoCgUrwIjTa/0dSNVu4B/wEBV8XT6e090fbWd44
 NUREarBWy9kohPy0oJdSUXJgX9EP1ufn3Hmo94ZFmv2OjGJDCviRR2t2IG/iWu5k
 KjVp6gqRbl4NeHdvnUL1O5ugokgHDsz13H1ZZpuYOPJrXJagwclG2gwXlbdOP7AP
 AkWhQvKtOGuLueFQSbXzAQ==
Message-ID: <0d8606b1-c6d6-4d06-bf83-050152ea0034@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 28 Jul 2026 15:57:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: Initialize blob mapping for
 ATTACH_BACKING
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260725-backing-v1-1-5b584bf7df5a@rsg.ci.i.u-tokyo.ac.jp>
 <95cca0b3-6e94-4b31-9531-e1057804122c@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <95cca0b3-6e94-4b31-9531-e1057804122c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/07/28 6:36, Michael Tokarev wrote:
> On 7/25/26 10:11, Akihiko Odaki wrote:
>> It is necessary for blob cursor and scanout.
>>
>> Fixes: e0933d91b1cd ("virtio-gpu: Add virtio_gpu_resource_create_blob")
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   hw/display/virtio-gpu.c | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
> Again, is this a qemu-stable material?  From the description
> it's difficult to say what's going on here, it feels like this
> change should be back-ported to the stable branches.

This is another[1] NULL pointer derefence fix; it is a trivial fix that 
can be cleanly backported.

[1] 
https://lore.kernel.org/qemu-devel/81a781bb-a4e2-4cfc-a9d1-0316cfb2f17a@rsg.ci.i.u-tokyo.ac.jp/

Regards,
Akihiko Odaki

> 
> Thanks,
> 
> /mjt
> 
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index 718ba3039290..e886298ec42f 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -984,6 +984,10 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
>>           cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>>           return;
>>       }
>> +
>> +    if (!res->image) {
>> +        virtio_gpu_init_udmabuf(res);
>> +    }
>>   }
>>   static void
>>
>> ---
>> base-commit: 006a22cb26998998385b104db1ff9466ef2f3153
>> change-id: 20260725-backing-db0e69515455
>>
>> Best regards,
>> -- 
>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>
>>
> 


