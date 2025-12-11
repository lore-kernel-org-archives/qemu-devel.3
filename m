Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB71D3E79C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 07:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTbT0-0002sA-RC; Thu, 11 Dec 2025 02:52:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbn@yandex-team.com>)
 id 1vTbSz-0002ry-VN; Thu, 11 Dec 2025 02:52:01 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbn@yandex-team.com>)
 id 1vTbSw-0004U1-QJ; Thu, 11 Dec 2025 02:52:01 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id D24EC80860;
 Thu, 11 Dec 2025 10:51:52 +0300 (MSK)
Received: from [10.211.131.6] (10.211.131.6-vpn.dhcp.yndx.net [10.211.131.6])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id mpJC8n0FQSw0-ksG43CUs; 
 Thu, 11 Dec 2025 10:51:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1765439512;
 bh=VHPAYO3a+8XtBYBXb5UcXt9ywu1hsUEP/fQA3cSSUm4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=n+nGTkuzYbvZD8Eg+g/Wl/dRCUae96AsL9+9gpGvE0zZx+F2YDnHJSCG3gwRdWD8X
 pHBaGRRW9etxnqyr4KTmZ2YSKHlRFEIre8xKpUHEyMCGv5HkNBK8X3UeYASgCvA4Ld
 dVhjCJf31lyTq4UhE1B11mEzrr2WQxg7+Jdznljc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
Message-ID: <3f126358-377f-4b4a-9fe5-dd361ba662ee@yandex-team.com>
Date: Thu, 11 Dec 2025 16:51:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] q35: Fix migration of SMRAM state
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20251203180851.6390-1-arbn@yandex-team.com>
 <20251210144055.3351d435@imammedo>
Content-Language: en-US
From: Andrey Ryabinin <arbn@yandex-team.com>
In-Reply-To: <20251210144055.3351d435@imammedo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=arbn@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 12/10/25 10:40 PM, Igor Mammedov wrote:
> On Wed,  3 Dec 2025 19:08:51 +0100
> Andrey Ryabinin <arbn@yandex-team.com> wrote:
> 
>> mch_update_smbase_smram() essentially uses wmask[MCH_HOST_BRIDGE_F_SMBASE]
>> to track SMBASE area state. Since 'wmask' state is not migrated is not
>> migrated, the destination QEMU always sees
>>  wmask[MCH_HOST_BRIDGE_F_SMBASE] == 0xff
>>
>> As a result, when mch_update() calls mch_update_smbase_smram() on the
>> destination, it resets ->config[MCH_HOST_BRIDGE_F_SMBASE] and disables
>> the smbase-window memory region—even if it was enabled on the source.
> 
> [...]
> 
>> +static void mch_smbase_smram_post_load(MCHPCIState *mch)
>> +{
>> +    PCIDevice *pd = PCI_DEVICE(mch);
>> +    uint8_t *reg = pd->config + MCH_HOST_BRIDGE_F_SMBASE;
>> +
>> +    if (!mch->has_smram_at_smbase) {
>> +        return;
>> +    }
>> +
>> +    if (*reg == MCH_HOST_BRIDGE_F_SMBASE_IN_RAM) {
>> +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =
>> +            MCH_HOST_BRIDGE_F_SMBASE_LCK;
>> +    } else if (*reg == MCH_HOST_BRIDGE_F_SMBASE_LCK) {
>> +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0;
>> +    }
>> +}
> You are correctly pointing to the issue about non-migratable wmask controlling
> config[], it should be other way around.
> 
> given reset already sets
>   wmask[MCH_HOST_BRIDGE_F_SMBASE] && config[MCH_HOST_BRIDGE_F_SMBASE]
> to default values, we don't need to do the same in mch_update_smbase_smram()
> so we can just drop it.
> 
> Also I wouldn't introduce a dedicated mch_smbase_smram_post_load() though,
> since mch_post_load() already calls mch_update_smbase_smram() indirectly,
> I'd rather fix the later.
> 
> Would following work for you:
> 
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index a708758d36..7a85a349bd 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -431,31 +431,25 @@ static void mch_update_smbase_smram(MCHPCIState *mch)
>          return;
>      }
>  
> -    if (*reg == MCH_HOST_BRIDGE_F_SMBASE_QUERY) {
> -        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] =
> -            MCH_HOST_BRIDGE_F_SMBASE_LCK;
> -        *reg = MCH_HOST_BRIDGE_F_SMBASE_IN_RAM;
> -        return;
> -    }
> -
>      /*
> -     * default/reset state, discard written value
> -     * which will disable SMRAM balackhole at SMBASE
> +     * reg value can come either from register write/reset/migration
> +     * source, update wmask to be in sync with it regardless of source
>       */
> -    if (pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] == 0xff) {
> -        *reg = 0x00;
> +    switch (*reg) {
> +    case MCH_HOST_BRIDGE_F_SMBASE_QUERY:
> +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] = MCH_HOST_BRIDGE_F_SMBASE_LCK;
> +        *reg = MCH_HOST_BRIDGE_F_SMBASE_IN_RAM;
> +        return;
> +    case MCH_HOST_BRIDGE_F_SMBASE_LCK:
> +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0;
> +        break;
> +    case MCH_HOST_BRIDGE_F_SMBASE_IN_RAM:
> +        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] = MCH_HOST_BRIDGE_F_SMBASE_LCK;
> +        break;
>      }
>  
>      memory_region_transaction_begin();
> -    if (*reg & MCH_HOST_BRIDGE_F_SMBASE_LCK) {
> -        /* disable all writes */
> -        pd->wmask[MCH_HOST_BRIDGE_F_SMBASE] &=
> -            ~MCH_HOST_BRIDGE_F_SMBASE_LCK;
> -        *reg = MCH_HOST_BRIDGE_F_SMBASE_LCK;
> -        lck = true;
> -    } else {
> -        lck = false;
> -    }
> +    lck = *reg & MCH_HOST_BRIDGE_F_SMBASE_LCK;


This change makes strict adherence to the negotiation protocol unnecessary. As a result:
 - Writes performed before MCH_HOST_BRIDGE_F_SMBASE_QUERY are no longer ignored.
 - The guest can set MCH_HOST_BRIDGE_F_SMBASE_LCK immediately.
 - The guest can now set MCH_HOST_BRIDGE_F_SMBASE_IN_RAM, which was previously impossible.

Perhaps this is acceptable — it may simply expose misbehaving guest behavior, I’m not sure,
I'm no expert here. But it does raise the question of why these restrictions existed
in the first place.

Also, if we are lifting these restrictions, tests/qtest/q35-test.c will need to be updated.

>      memory_region_set_enabled(&mch->smbase_blackhole, lck);
>      memory_region_set_enabled(&mch->smbase_window, lck);
>      memory_region_transaction_commit();
> 
>>  static int mch_post_load(void *opaque, int version_id)
>>  {
>>      MCHPCIState *mch = opaque;
>> +
>> +    mch_smbase_smram_post_load(mch);
>>      mch_update(mch);
>>      return 0;
>>  }
> 


