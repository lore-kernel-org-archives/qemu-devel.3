Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D958CD8C88
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 00:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wW1BC-0003h5-Hu; Sat, 06 Jun 2026 20:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lhestz@163.com>) id 1wW1BA-0003gx-Cd
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 20:15:52 -0400
Received: from m16.mail.163.com ([220.197.31.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lhestz@163.com>) id 1wW1B7-0001av-HH
 for qemu-devel@nongnu.org; Sat, 06 Jun 2026 20:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=Gy8thGB9jxv0DJWtpjIJUimv547bDA1+txl2GPxG7w4=;
 b=WgzlFEfe8vwYdGaLD8hLubeWX3astvVlnA8sT2ipygqI4BHpY+H+okTftGBmdH
 yjMY+1WMjF7DQh49Ix04GPLWnNliT2OU8MK//UUNWWr/bRvAIzuy5OROCcGJif9y
 SUPEI2S3NgoqIh4O5iv47TEWTkKCEI+h/FHakHr3F/zdQ=
Received: from [IPV6:2409:8a00:18c7:4890:9a3c:298b:940a:e997] (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PigvCgDX_xQXuCRqG4qpAw--.55368S2;
 Sun, 07 Jun 2026 08:15:21 +0800 (CST)
Message-ID: <392e03eb-63e4-4db0-89d2-b7ddc32b91e8@163.com>
Date: Sun, 7 Jun 2026 08:15:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] hw/virtio-crypto: add akcipher keylen validation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, zhenwei.pi@linux.dev
References: <20260606074756.43804-1-lhestz@163.com>
 <20260606043251-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: helei <lhestz@163.com>
In-Reply-To: <20260606043251-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PigvCgDX_xQXuCRqG4qpAw--.55368S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr4xKFWkCrykur47KryrCrg_yoWkWFc_Wr
 4ku39xGw4vyFn2va9F9345WrW7u3y8tFyDJF15Za1xJryrXFsxZF1xXrnavF1DAayUXF4j
 gr4Fyr1rtwnxujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRJ5r3UUUUU==
X-Originating-IP: [2409:8a00:18c7:4890:9a3c:298b:940a:e997]
X-CM-SenderInfo: pokh23r26rljoofrz/xtbC8xnXA2okuBns1AAA3p
Received-SPF: pass client-ip=220.197.31.2; envelope-from=lhestz@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 6/6/26 16:37, Michael S. Tsirkin wrote:
> On Sat, Jun 06, 2026 at 03:47:55PM +0800, helei wrote:
>> The virtio-crypto spec does not dictate a maximum length limit for
>> asymmetric cipher (akcipher) keys. We added a hard limit which mirrors
>> the linux kernels's internal limit for akcipher keys (see
>> keyctl framework and the add_key syscall).
> We have max_size - doesn't that apply?
> backends/cryptodev-builtin.c actually sets it:
> backends/cryptodev-builtin.c:#define CRYPTODEV_BUITLIN_MAX_REQUEST_SIZE  (1024 * 1024)
> backends/cryptodev-builtin.c:    backend->conf.max_size = CRYPTODEV_BUITLIN_MAX_REQUEST_SIZE;

Thanks for your review!  I have verified via testing that all processing 
requests in the dataq are strictly

bounded by max_size, but session creation requests in the ctrlq are not.

>
>> Maybe we should update the virtio-spec and add a max_akcipher_key_len
>> field for virtio crypto devices.
> maybe
>
>> helei (1):
>>    hw/virtio-crypto: enforce max akcipher key length
>>
>>   hw/virtio/virtio-crypto.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> -- 
>> 2.43.0


