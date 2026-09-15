Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E96C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6O4C-0005nZ-9g; Tue, 15 Sep 2026 03:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6O4A-0005nK-GW
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:58:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x6O48-0000lx-ON
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789459135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ojl9aY+AN0Cltiv3vkp4eAaHl7L94AFxnibv6/wsHHw=;
 b=YLrb1BIZxwsElB6sQ8WBcL6SYK5esxdTmcpBnMGz/F1As1dFL1zKBq+3GL4t6hl20IHuNc
 Ht7M0ketdHxVJAlKz4646FWP1z0Fjodl4c5fxaTbs+VXWCz5FuQgls6xdihGx+svl/mdnK
 m4QrHDw2guXMDXvzeuvQ0d1C0DzQA2U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-dr2YxqffNeiJ8Fk1fYhkmA-1; Tue, 15 Sep 2026 03:58:54 -0400
X-MC-Unique: dr2YxqffNeiJ8Fk1fYhkmA-1
X-Mimecast-MFC-AGG-ID: dr2YxqffNeiJ8Fk1fYhkmA_1789459133
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4870a0f802cso60827f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789459133; x=1790063933; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ojl9aY+AN0Cltiv3vkp4eAaHl7L94AFxnibv6/wsHHw=;
 b=DFXblOHQV5iyvd3Kl7MuWCM9sk1QZebjSSVW1UxNPylWlhkPanTou8/w+hLiTt6964
 vCv1yud0R8yNZIdYql5VXSm/Sn9PzVvEv9OGp7SX2RnwpIukTtUiH0MFZ/UyaBd9ACZC
 UXWsIs+e5OBD85+0AWXU4oDX64zvUpvB/zvs+VfXDBdJQmmVuqupDchuBfXjRGAp7auB
 9CJ1e/j02ytFjFaHRoNkvYHgGH38o5vxRcTRgC2s1N7DBABwPTIU0va/t9vs1ZwtrM0f
 aemU0hj5O4vx+7BCEYrHfjUViMydvzCkgNf91omPTkN/c+7ucT0vCxC+NpS+r9wRV2Du
 6TcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789459133; x=1790063933;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ojl9aY+AN0Cltiv3vkp4eAaHl7L94AFxnibv6/wsHHw=;
 b=hXh3L4wlNkwuuk7msGu0urYb0JgHXSRyBoCrwTITjS5H5ZYPSDmL4e3z5M2c1BeASy
 jw1nk/q9i1gNERCTgfe8YnIGNBLibNr5IxMcHNTQDlXXUH5EmjraBgmxi46wMGWJTa9V
 Pb6+aU7K9/OwEfHcZfLF1oydvYMl0Xa2noe98MU2bKaSF65/+/F/jULuzTgiHpooMJ1l
 TQHbk5C8Cw/E5UdMfQTXfu1jyot+Iy+8IgEo4JuRiJnhKl2w0MvsCZaFMQui7MTySH3l
 otSHRWHgNs8PwMyUDksiPULFdS+jQcnbmdsAVeUG55/RgrDgtYtzRoCU8x8GvoCTzIT5
 Oogw==
X-Forwarded-Encrypted: i=1;
 AKwUvByJCsrZPikHfZSiyHZZugRbFBYbvvgkKq/Olvf/mKwbL3sOzEz9pX9XUOzElU5szbhlF99wXJjXsvE1@nongnu.org
X-Gm-Message-State: AFuF++kqs8fdVRRKFnd5lAGPsmsR5r3ccoUMnEklwVsvu6r166cRHj5P
 f/tDPi9lxc1bKaeS1LDhghRaf+44TJntkRC3/I0TnPk8VDK4Cex9AryTI6BZ2d0Y1+kgpDPEgTL
 OfLom2ORr4oUX0ono+iQAl8BxgzduZP6num6IFfnLmvJXYrqu0dSE3rgL
X-Gm-Gg: AYBFou1YbXHeoNVJVyehxHlZYBfsSJ4B7IBMcpElFeneEZCd0BkHHMwWrOmcL+PKIAt
 ST5srVe/1ZginY1KI7/ZlRybIYwAS/65psWx+Jo7oiwu8+9gg6+xXay4GC2VmsevYPrYuhrUVAA
 bd3NVaHDHxkY2oWKZVV4NaPEIjztxrw9rfdnr0Upo9heeA6gaeUwWqG9TAxaI+7TxP6RKhl10B2
 qX7AEVS6ktllOb0VwCgfCztwVeEKr7a9V31SMSW9YNyHYs+Iz/7w20KhGXXVz6i432WL2Ip5iSL
 ZLjdfTQnH1RY1ZNVox0O0pd9x0mp8aX1Itztw/e8dQm2BBjJjxL6sFhMyHtWWlI3RMEhXJrkYMj
 mQAPPpum7Vn5LJt2fMktscX2LsGFpfCFh3jfFl8vD1g==
X-Received: by 2002:a05:6000:2902:b0:486:f856:1975 with SMTP id
 ffacd0b85a97d-48702ab79cdmr6549297f8f.22.1789459132758; 
 Tue, 15 Sep 2026 00:58:52 -0700 (PDT)
X-Received: by 2002:a05:6000:2902:b0:486:f856:1975 with SMTP id
 ffacd0b85a97d-48702ab79cdmr6549269f8f.22.1789459132317; 
 Tue, 15 Sep 2026 00:58:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:e939:7a09:c368:e5d5?
 ([2a01:e0a:1292:d530:e939:7a09:c368:e5d5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb359f38sm30074748f8f.30.2026.09.15.00.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 00:58:51 -0700 (PDT)
Message-ID: <8b44c432-7737-4a3b-9abc-a8b30318749f@redhat.com>
Date: Tue, 15 Sep 2026 09:58:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/9] igb: Add VF post-load fixups for live migration
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 Peter Xu <peterx@redhat.com>
References: <20260902192054.3329753-1-clg@redhat.com>
 <20260902192054.3329753-5-clg@redhat.com>
 <ac517c84-40a3-422c-b022-41b3c8456855@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <ac517c84-40a3-422c-b022-41b3c8456855@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/8/26 10:10, Akihiko Odaki wrote:
> On 2026/09/03 4:20, Cédric Le Goater wrote:
>> After restoring per-VF register state, propagate the VF's PVT shadow
>> values back into the PF's aggregate EIMS/EIAC/EIAM registers and
>> re-apply the VTIVAR interrupt vector routing to the shared IVAR0.
>>
>> AI-used-for: analysis, code (prototype)
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/net/igb_core.h      |  3 ++
>>   hw/net/igb_core.c      | 66 ++++++++++++++++++++++++++++++++++++++++++
>>   hw/net/igb_migration.c |  7 +++++
>>   3 files changed, 76 insertions(+)
>>
>> diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
>> index 60724e2824ab..22e10e4e6d0b 100644
>> --- a/hw/net/igb_core.h
>> +++ b/hw/net/igb_core.h
>> @@ -145,4 +145,7 @@ igb_start_recv(IGBCore *core);
>>   IGBCore *igb_pf_get_core(void *pf);
>> +void igb_core_vf_propagate_irqs(IGBCore *core, uint16_t vfn);
>> +void igb_core_vf_propagate_ivar(IGBCore *core, uint16_t vfn);
>> +
>>   #endif
>> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
>> index 2a4883907353..01745fe756d0 100644
>> --- a/hw/net/igb_core.c
>> +++ b/hw/net/igb_core.c
>> @@ -4552,3 +4552,69 @@ igb_core_post_load(IGBCore *core)
>>       return 0;
>>   }
>> +
>> +/*
>> + * Propagate VF interrupt state to PF aggregates after loading VF
>> + * registers. The load path writes directly to mac[] bypassing the
>> + * register handlers that OR VF bits into EIMS/EIAC/EIAM. Also clear
>> + * stale VF bits in EICR that may have been set by packets arriving
>> + * between PF vmstate restore and VF state load.
>> + */
>> +void igb_core_vf_propagate_irqs(IGBCore *core, uint16_t vfn)
>> +{
>> +    uint32_t shift = 22 - vfn * IGBVF_MSIX_VEC_NUM;
>> +    uint32_t vf_mask = 0x7 << shift;
>> +    uint32_t pvt_idx;
>> +
>> +    core->mac[EIMS] &= ~vf_mask;
> 
> Restore the effective interrupt mask rather than the last EIMS write.
> 
> This clears the destination VF mask and copies PVTEIMS, but that shadow records only the last write: igb_set_vteims() assigns it before applying set-bit semantics to aggregate EIMS. For example, source writes EIMS=1, then EIMS=2, leave effective mask 3 and shadow 2; migration restores 2, suppressing vector 0 until explicitly enabled again. Conversely, EIMC updates aggregate EIMS without updating PVTEIMS, so migration reenables explicitly masked vectors. Patch 7 repeats this fixup on unquiesce without repairing the bookkeeping.

ok. I guess we can save and restore the VF's effective mask bits directly
and drop the fixup then. Same for EIAC/EIAM. It should simplify the flow.
How's that ?

Thanks

C.


> 
> Regards,
> Akihiko Odaki
> 
>> +    pvt_idx = PVTEIMS0 + vfn * 0x40;
>> +    core->mac[EIMS] |= (core->mac[pvt_idx] & 0x7) << shift;
>> +
>> +    core->mac[EIAC] &= ~vf_mask;
>> +    pvt_idx = PVTEIAC0 + vfn * 0x40;
>> +    core->mac[EIAC] |= (core->mac[pvt_idx] & 0x7) << shift;
>> +
>> +    core->mac[EIAM] &= ~vf_mask;
>> +    pvt_idx = PVTEIAM0 + vfn * 0x40;
>> +    core->mac[EIAM] |= (core->mac[pvt_idx] & 0x7) << shift;
>> +
>> +    core->mac[EICR] &= ~vf_mask;
>> +}
>> +
>> +/*
>> + * Re-apply VTIVAR -> IVAR0 interrupt routing. The L1 PF driver
>> + * may have overwritten the shared IVAR0 entries with its own
>> + * queue routing after L0 vmstate restore.
>> + */
>> +void igb_core_vf_propagate_ivar(IGBCore *core, uint16_t vfn)
>> +{
>> +    uint32_t vtivar = core->mac[VTIVAR + vfn];
>> +    int n;
>> +    uint8_t ent;
>> +    uint32_t mask;
>> +
>> +    n = igb_ivar_entry_rx(vfn);
>> +    mask = 0xffU << (8 * (n % 4));
>> +    if (vtivar & E1000_IVAR_VALID) {
>> +        ent = E1000_IVAR_VALID |
>> +              (24 - vfn * IGBVF_MSIX_VEC_NUM - (2 - (vtivar & 0x7)));
>> +        core->mac[IVAR0 + n / 4] =
>> +            (core->mac[IVAR0 + n / 4] & ~mask) |
>> +            ((uint32_t)ent << (8 * (n % 4)));
>> +    } else {
>> +        core->mac[IVAR0 + n / 4] &= ~mask;
>> +    }
>> +
>> +    n = igb_ivar_entry_tx(vfn);
>> +    mask = 0xffU << (8 * (n % 4));
>> +    ent = vtivar >> 8;
>> +    if (ent & E1000_IVAR_VALID) {
>> +        ent = E1000_IVAR_VALID |
>> +              (24 - vfn * IGBVF_MSIX_VEC_NUM - (2 - (ent & 0x7)));
>> +        core->mac[IVAR0 + n / 4] =
>> +            (core->mac[IVAR0 + n / 4] & ~mask) |
>> +            ((uint32_t)ent << (8 * (n % 4)));
>> +    } else {
>> +        core->mac[IVAR0 + n / 4] &= ~mask;
>> +    }
>> +}
>> diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
>> index c34035974620..af7257ccc4fd 100644
>> --- a/hw/net/igb_migration.c
>> +++ b/hw/net/igb_migration.c
>> @@ -384,12 +384,19 @@ static int igb_core_vf_load_state(IgbVfState *s, const void *buf, size_t size)
>>   static int igbvf_mig_load(IgbVfState *s, const void *buf, size_t size)
>>   {
>>       int ret;
>> +    IGBCore *core = igbvf_get_core(s);
>>       ret = igb_core_vf_load_state(s, buf, size);
>>       if (ret < 0) {
>>           return ret;
>>       }
>> +    /*
>> +     * Post-load: sync VF interrupt and routing state to PF aggregates
>> +     */
>> +    igb_core_vf_propagate_irqs(core, s->vfn);
>> +    igb_core_vf_propagate_ivar(core, s->vfn);
>> +
>>       return 0;
>>   }
> 


