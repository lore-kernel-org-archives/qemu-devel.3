Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA449C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 13:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reF0a-0002pS-CT; Sun, 25 Feb 2024 08:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1reF0Y-0002p5-Q2
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 08:57:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1reF0W-0000ZA-UQ
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 08:57:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708869450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/JXIUgngW2iuXX2sfMj/Zfqo7xFMB9b7gRFoeC4Eng=;
 b=h/YUiM4CGdrWXj4p38KvXwKAcwhzO9wPYALDwymEAaqKaZAd2fh6JqfDQIvAstWGD1/YXO
 aCS+ZfxVKNhloCjLU7Csx6PcJ9pwmWB1qHNPdS13iazfvIpcNfvmOatawLN+hpmodeTyjA
 2kYBCrEh4VTIamg7FiKkPbNOJ7pImG4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-ufGDc-4EOL-eK7UAkchQQA-1; Sun,
 25 Feb 2024 08:57:26 -0500
X-MC-Unique: ufGDc-4EOL-eK7UAkchQQA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5100738130B1;
 Sun, 25 Feb 2024 13:57:26 +0000 (UTC)
Received: from [10.39.192.57] (unknown [10.39.192.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 216A48CE8;
 Sun, 25 Feb 2024 13:57:23 +0000 (UTC)
Message-ID: <46bd8ed1-eea5-095b-1a55-043754f4f2ef@redhat.com>
Date: Sun, 25 Feb 2024 14:57:22 +0100
MIME-Version: 1.0
Subject: Re: [PATCH V2 1/1] loongarch: Change the UEFI loading mode to
 loongarch
Content-Language: en-US
To: Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org,
 maobibo@loongson.cn, Song Gao <gaosong@loongson.cn>,
 zhaotianrui@loongson.cn, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <cover.1708336919.git.lixianglai@loongson.cn>
 <0bd892aa9b88e0f4cc904cb70efd0251fc1cde29.1708336919.git.lixianglai@loongson.cn>
 <582cb02c-9778-46af-97d3-5b248b30b02e@linaro.org>
 <CABJz62ML+ye=mwX2vfZJG==TOHLyLoFMGZaAvTS36Dcax8jcaA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <CABJz62ML+ye=mwX2vfZJG==TOHLyLoFMGZaAvTS36Dcax8jcaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/22/24 16:49, Andrea Bolognani wrote:
> On Thu, Feb 22, 2024 at 04:10:20PM +0100, Philippe Mathieu-Daudé wrote:
>> On 19/2/24 11:34, Xianglai Li wrote:
>>> The UEFI loading mode in loongarch is very different
>>> from that in other architectures:loongarch's UEFI code
>>> is in rom, while other architectures' UEFI code is in flash.
>>>
>>> loongarch UEFI can be loaded as follows:
>>> -machine virt,pflash=pflash0-format
>>> -bios ./QEMU_EFI.fd
>>>
>>> Other architectures load UEFI using the following methods:
>>> -machine virt,pflash0=pflash0-format,pflash1=pflash1-format
>>>
>>> loongarch's UEFI loading method makes qemu and libvirt incompatible
>>> when using NVRAM, and the cost of loongarch's current loading method
>>> far outweighs the benefits, so we decided to use the same UEFI loading
>>> scheme as other architectures.
>>
>> This is unfortunate, since LoongArch was a fresh new target added,
>> we had the possibility to make this right. Are you saying libvirt
>> didn't accept to add support for the correct HW behavior which is
>> to simply load a ROM instead of a PNOR flash device? Could you
>> point me to the libvirt discussion please? libvirt is very good at
>> supporting a broad range of legacy options, so I'm surprise 'Doing
>> The Right Thing' is too costly.
>>
>> What is really the problem here, is it your use of the the -bios
>> CLI option?
> 
> Hi Philippe,
> 
> the thread is here:
> 
>   https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/7PV3IXWNX3UXQN2BNV5UA5ASVXNVOQIF/
> 
> Unfortunately hyperkitty makes it impossible to link to a subthread
> directly, so you're going to have to scroll around. The relevant part
> of the discussion happens entirely as reply to the cover letter.
> 
> You were actually CC'd to that subthread right after my first reply,
> so you should be able to find the relevant messages locally as well,
> which is probably going to be more convenient.
> 
> In short, the discussion is similar to the one we had a while ago
> about RISC-V, and my argument in favor of this change is largely the
> same: barring exceptional circumstances, the overall (maintenance,
> cognitive) cost of straying from the established norm, now spanning
> three existing architectures, likely outweighs the benefits.
> 

I'm surprised that the UEFI payload (?) on *physical* loongarch machines
is supposed (?) to launch from ROM. That means "no firmware updates",
which is quite unusual nowadays. Recent versions of the UEFI spec have
introduced a bunch of interfaces just for standardizing firmware
updates, meaning both add-on card firmware, and platform/system firmware.

(Unfortunately, I have nothing "constructive" to add; apologies.)

Laszlo


