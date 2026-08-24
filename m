Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13372C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 17:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyYMr-0006VJ-Iw; Mon, 24 Aug 2026 13:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wyYMo-0006V0-Ib
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 13:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wyYMm-0000ph-Lp
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 13:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787592105;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GbUK19ldvIBWtcuD0oTMHA2hFkXjZn0gQlWJ+k3b3+E=;
 b=dk1eKWACHdEppSowQwPw8lHTNu77IpXOi5UXo3aXDoLgsnGsMkD1OcMj7jc9Xu1b0N8+8l
 7pVR/LfPLfpbL/HFIF4lYRQPm18wA0oA6FXr1d3q/lSmgEuTdQ9c/EZ2JEo9qxw0uh3E33
 V+mB4K7Jvk7Yl9WThIkcean1n9EIFLw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-FvHhUkoCO_KW-2Itg0qFgg-1; Mon, 24 Aug 2026 13:21:43 -0400
X-MC-Unique: FvHhUkoCO_KW-2Itg0qFgg-1
X-Mimecast-MFC-AGG-ID: FvHhUkoCO_KW-2Itg0qFgg_1787592102
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c160b9c0676so280469266b.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 10:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787592102; x=1788196902;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GbUK19ldvIBWtcuD0oTMHA2hFkXjZn0gQlWJ+k3b3+E=;
 b=lbEUZTOhBSQmsAN+Xmgn/aqTWuU3xZTWYqSOe1O3P/0BBpKHETVoURPFqdfPZaQJ+R
 lcCVLPcxet9G3L3sBFHdrpgtA3a4MXsfZWbi1RzJ1Tzu1jeeHWaLJmX5M4eevY8S9xi1
 DigTjXFI+SOJ8LaOjZ4GNlG+S3Ab/bdirbJ9n7rDk2sxNb8UGd/mesBHILsNTNKj+31F
 fnGrXj7jph8dUA/6XnGg+YyVt9ltvUduFNGN7u0pY3gPvjUYYIF6Eguxia9HfMbBdPLt
 SB+Kw1FtDtLf2YBZqeG57uSIn4V5FaOiYEzjFRsf5RCMaNa5GaeQvIFDMzTGDDzl8pGf
 AAmA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpySif+j1qQTn46o8gTeS9R2hFjEntjv8THyee2lgN2RGaPR0HE/8ccZrehyE65RdE0oqaZ0NLFiimw@nongnu.org
X-Gm-Message-State: AFuF++lT2oEJmuigsbN+INsyw1/mS9hT09pS97A0lV3qzskC92QpnGmh
 zxEX1ulH7GGG/iV5fBoF4A5kXjwlEhXIHmQCh8s8qUMVMxpNIIVDtH8ZomB7tDazU4+5irfGWB4
 ag/K+DYC9s9B+yA7E1OZByvROT6BkVTQKnAnUSFHrOk+AO0PfnMKSg6Mf
X-Gm-Gg: AR+sD12J1kWlTBHii0fACgndhot86KKmifxKpw/xMq1RkZh/TzjW18uZZpVeOMRow13
 c5Im1qwjJB0FZpU68mEf221mvCRvwxenJskb1LGdXYHeGx/7CDO0NyADbogJfak3hhPZqYypfNM
 252nysFv2CWXI2Rh5NoPaWl+l3PsCO/MyH0Gh3yFfG7rNWGU8Cobd+w7gbFSvKXJnRxMUxulmG/
 oYTQuDca0XttbViPdibni1Y3k3ZP1Dq+ZPqKx3TMvcp+ASDcOvbp6Z7+HVVNX0kyo5n0MVI+bde
 2Yq/x+gfEU44vl23mdqC5KbVnxo+jtD31G9xrf7h52vTPJvYnoUZhxJ0i7WhKQ2r6fNP2vemhCh
 3hm/jtXLyXYXeWdnzf+HFcKuK9xANyqj5FmEeY1AjsF/2iHgh
X-Received: by 2002:a17:907:940f:b0:c21:74ad:8b7a with SMTP id
 a640c23a62f3a-c24e5a5243amr4844366b.9.1787592101829; 
 Mon, 24 Aug 2026 10:21:41 -0700 (PDT)
X-Received: by 2002:a17:907:940f:b0:c21:74ad:8b7a with SMTP id
 a640c23a62f3a-c24e5a5243amr4840866b.9.1787592101419; 
 Mon, 24 Aug 2026 10:21:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249629563dsm1407710366b.17.2026.08.24.10.21.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 10:21:40 -0700 (PDT)
Message-ID: <e2fbfb8a-b3e5-4e27-b938-d92d3ccfe83f@redhat.com>
Date: Mon, 24 Aug 2026 19:21:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Eric Auger <eric.auger@redhat.com>
Subject: Re: [RFC PATCH v7 12/18] target/arm/kvm: Introduce
 kvm_arm_expose_idreg_properties
To: Markus Armbruster <armbru@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, peter.maydell@linaro.org, shaju.abraham@nutanix.com,
 khushit.shah@nutanix.com, yangjinqian1@huawei.com, cohuck@redhat.com,
 richard.henderson@linaro.org, sebott@redhat.com, skolothumtho@nvidia.com,
 philmd@oss.qualcomm.com, maz@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
References: <20260726153221.24773-1-eric.auger@redhat.com>
 <20260726153221.24773-13-eric.auger@redhat.com> <87a4qh3tbn.fsf@pond.sub.org>
Content-Language: en-US
In-Reply-To: <87a4qh3tbn.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Markus,
On 8/20/26 1:49 PM, Markus Armbruster wrote:
> Eric Auger <eric.auger@redhat.com> writes:
>
>> This helper decode the ID reg writable mask, matches it against
>> ID reg fields defined in target/arm/cpu-idregs.h.inc and
>> for each writable named field, generates a uint64 property.
>>
>> REVIDR_EL1 and AIDR_EL1 are writable but they do not expose any
>> field. They will be handled separately.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> [...]
>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 4f9b0a559d..1a78893f87 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
> [...]
>
>> +static void set_sysreg_prop(Object *obj, Visitor *v,
>> +                            const char *name, void *opaque,
>> +                            Error **errp)
>> +{
>> +    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
>> +    ARMCPU *cpu = ARM_CPU(obj);
>> +    uint64_t *idregs = cpu->isar.idregs;
>> +    uint64_t old, value, mask;
>> +    int lower = field->shift;
>> +    int length = field->length;
>> +    int index = field->index;
>> +
>> +    if (!visit_type_uint64(v, name, &value, errp)) {
>> +        return;
>> +    }
>> +
>> +    if (length < 64 && value > ((1 << length) - 1)) {
>> +        error_setg(errp,
>> +                   "idreg %s set value (0x%lx) exceeds length of field (%d)!",
>> +                   name, value, length);
>> +        return;
>> +    }
>> +
>> +    if (field->arch_vals) {
>> +        /* this field has some enum values */
>> +        for (int i = 0; i < field->arch_vals_count; i++) {
>> +            if (value == field->arch_vals[i].value) {
>> +                goto valid;
>> +            }
>> +        }
>> +        error_setg(errp,
>> +                   "idreg %s set value (0x%lx) does not match any "
>> +                   "arch valid enum value!", name, value);
> Scratch the !
>
> From error_setg()'s contract:
>
>  * The resulting message should be a single phrase, with no newline or
>  * trailing punctuation.

done. Thank you for the reminder!

Eric
>
>> +        return;
>> +    }
>> +
>> +valid:
>> +
>> +    mask = MAKE_64BIT_MASK(lower, length);
>> +    value = value << lower;
>> +    old = idregs[index];
>> +    idregs[index] = old & ~mask;
>> +    idregs[index] |= value;
>> +    trace_set_sysreg_prop(name, old, mask, value, idregs[index]);
>> +}
> [...]
>


