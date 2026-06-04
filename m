Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778CDCD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 05:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV0lA-00064k-Jc; Thu, 04 Jun 2026 01:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>)
 id 1wV0l1-00063m-TM; Thu, 04 Jun 2026 01:36:45 -0400
Received: from msg-3.mailo.com ([213.182.54.8] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>)
 id 1wV0ky-00027J-Ip; Thu, 04 Jun 2026 01:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780550531; bh=yj72RW+PZSNnlRLCgVzePC22nbh2OZ+lxbXcXo1CbWM=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=R0vngN6VgivgdgZWc9sicYQbntx0Uah+q6s5C4q3gRQuy7z09wfi20yrsoNi3P68t
 oDz5afNKwD+wB4kJrtQ41JYIBjvga6vsJN3lPsMbxa48BYdZ8G/v4wqqhJIsvttg3X
 Q8WY6Nc6TuXn4ePiubAm9YIt34PavYkP+ZtQaOjE=
Received: by be1-2.in.mailobj.net [192.168.91.12] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Thu,  4 Jun 2026 07:21:37 +0200 (CEST)
X-EA-Auth: j46QNwIeAbDMCrpFUGdgVVD4zU9iTEbs4G+QSfuUnZPhzKs7Nmyti4H8mLg8STmfKoeclNXqONaSLYBelvly3cTkMFZH9NrS
Message-ID: <6fe5e4ce-eb3b-4d5f-9b98-146e3cbd32d3@mailo.com>
Date: Thu, 4 Jun 2026 07:21:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/12] hw/riscv/aia: Configure stride for the M-mode
 IMSIC
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260603065859.592063-1-joel@jms.id.au>
 <20260603065859.592063-6-joel@jms.id.au>
 <876dbf23-c7ec-46f4-9232-816a3d0bf16c@mailo.com>
 <CACPK8XeJX2s3-mvpsrCeOLsMyZXYN7fxiMCiitKTtN84Ntxvvw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <CACPK8XeJX2s3-mvpsrCeOLsMyZXYN7fxiMCiitKTtN84Ntxvvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.8; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 4/6/26 05:03, Joel Stanley wrote:
> On Wed, 3 Jun 2026 at 17:41, Philippe Mathieu-Daudé <philmd@mailo.com> wrote:
>>> --- a/hw/riscv/aia.h
>>> +++ b/hw/riscv/aia.h
>>> @@ -14,6 +14,7 @@
>>>    uint32_t imsic_num_bits(uint32_t count);
>>>
>>>    DeviceState *riscv_create_aia(bool msimode, int aia_guests,
>>> +                             hwaddr m_imsic_stride,
>>
>> hw/riscv/virt-acpi-build.c:74:    uint64_t imsic_socket_addr, imsic_addr;
>> hw/riscv/virt.c:532:    uint32_t imsic_max_hart_per_socket, imsic_addr,
>> imsic_size;
>> target/riscv/kvm/kvm-cpu.c:1829:    uint64_t socket, base_hart,
>> hart_count, socket_imsic_base, imsic_addr;
>>
>> Why choose hwaddr for a stride (region size)?
> 
> Brain fart.
> 
>> Using uint64_t:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
> 
> uint32_t would be more than sufficient too, do you agree?

Yes I was thinking the same, 32-bit is sufficient. But maybe
we should update the other cases for consistency (as a separate
patch)?


