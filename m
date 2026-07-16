Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964E0C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkH3v-0002ng-CJ; Thu, 16 Jul 2026 04:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkH3s-0002nW-Td
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 04:03:17 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkH3q-0004bw-3x
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 04:03:16 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66G8335o038813
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 16 Jul 2026 17:03:04 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=BdrFBTZJTiEPLqER1aW1H22b5P0UznRdpyKQxU0IEzE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784188984; v=1;
 b=e26oljIwCjXOnYvjjXgYMnQMT2b86QkH/96TVcqlRMkvmKazikHXehkDQ+XW/ImS
 UXj8AXRhqbB7KC9GNMgQOklNRdcw/qz4rnoB+FbJbaL4bNFga10+B1eMnkzhaM8R
 JT9IyEnttgbsW8E0oWEBv59E5E469QL9IQ5NUChnuz/fT459PCOZkI/HgtbAOk6/
 nRFbXgugE+20owB0Xj9OZqBz5H0PJO3p8VrZF0zjROVKb9NLYTBgz/o/dR09Ewk2
 BF0Lu24UYaU9C0ixQYkoCjR5ThfoiWCl+lh+WVTEOJLgeRISEkpl3fb1WtIAh68i
 yzO6yi/9+mz1UwLSP/u2Mw==
Message-ID: <c625e54a-b7f5-41d8-8f2c-93bd31f662e4@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 16 Jul 2026 17:03:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: validate stride against width on
 scanout
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260715201055.2465320-1-marcandre.lureau@redhat.com>
 <25541fac-4e55-477c-8599-7e503bff31c6@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
In-Reply-To: <25541fac-4e55-477c-8599-7e503bff31c6@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/07/16 16:37, Akihiko Odaki wrote:
> On 2026/07/16 5:10, marcandre.lureau@redhat.com wrote:
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Validate that the framebuffer stride is at least width * bytes_per_pixel
>> in both virtio_gpu_scanout_blob_to_fb() and virtio_gpu_do_set_scanout().
>>
>> A guest can set a very small stride while using a large width. The total
>> size check (offset + stride * height <= blob_size) passes because
>> stride * height is small, but pixman reads width * bytes_per_pixel per
>> row, causing heap OOB reads. The leaked data is rendered to the host
>> display.
>>
>> The check is added in virtio_gpu_do_set_scanout() to cover all paths:
>> blob scanout, non-blob scanout and migration post_load. The additional
>> early check in virtio_gpu_scanout_blob_to_fb() rejects invalid blob
>> configurations early.
>>
>> Fixes: CVE-2026-63109
>> Fixes: 144bd171c837 ("virtio-gpu: Support blob scanout using dmabuf fd")

I cannot resolve commit 144bd171c837. Apparently the bug was introduced 
by commit 7b5574225429 ("hw/display: check frame buffer can hold blob").

>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3989
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


