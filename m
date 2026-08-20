Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC57C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx1HK-0006SG-MP; Thu, 20 Aug 2026 07:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wx1HJ-0006Re-1h
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wx1HH-0004sO-Ki
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787226586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A4vay6hXX3iVyfYX6w1TLG8aJVsF5JcuByAXnGPdkGM=;
 b=grNs4l7mjSUmCkT5S1kiEGQXjvORlmrYiAh4jmExPlQBQ0qJ01n9msPo631aM2ASNja8Yw
 ZeCVUNUhgmssZujqEABt9VZ+bbAamZzYyZTljEV4TIuhsn+kiHVikpFdBGSkvmY7PHoZPq
 glbeXfQeLGXbywOTHgg51/evdnCRIkw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-tIc7fU1lP0CeVIM_P1tuJw-1; Thu,
 20 Aug 2026 07:49:38 -0400
X-MC-Unique: tIc7fU1lP0CeVIM_P1tuJw-1
X-Mimecast-MFC-AGG-ID: tIc7fU1lP0CeVIM_P1tuJw_1787226576
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CF68180034C; Thu, 20 Aug 2026 11:49:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99F0F180034C; Thu, 20 Aug 2026 11:49:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3314A21E6920; Thu, 20 Aug 2026 13:49:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com,  qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev,  peter.maydell@linaro.org,
 shaju.abraham@nutanix.com,  khushit.shah@nutanix.com,
 yangjinqian1@huawei.com,  cohuck@redhat.com,
 richard.henderson@linaro.org,  sebott@redhat.com,
 skolothumtho@nvidia.com,  philmd@oss.qualcomm.com,  maz@kernel.org,
 oliver.upton@linux.dev,  pbonzini@redhat.com,  berrange@redhat.com,
 abologna@redhat.com,  jdenemar@redhat.com
Subject: Re: [RFC PATCH v7 12/18] target/arm/kvm: Introduce
 kvm_arm_expose_idreg_properties
In-Reply-To: <20260726153221.24773-13-eric.auger@redhat.com> (Eric Auger's
 message of "Sun, 26 Jul 2026 17:29:50 +0200")
References: <20260726153221.24773-1-eric.auger@redhat.com>
 <20260726153221.24773-13-eric.auger@redhat.com>
Date: Thu, 20 Aug 2026 13:49:32 +0200
Message-ID: <87a4qh3tbn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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

Eric Auger <eric.auger@redhat.com> writes:

> This helper decode the ID reg writable mask, matches it against
> ID reg fields defined in target/arm/cpu-idregs.h.inc and
> for each writable named field, generates a uint64 property.
>
> REVIDR_EL1 and AIDR_EL1 are writable but they do not expose any
> field. They will be handled separately.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

[...]

> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 4f9b0a559d..1a78893f87 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c

[...]

> +static void set_sysreg_prop(Object *obj, Visitor *v,
> +                            const char *name, void *opaque,
> +                            Error **errp)
> +{
> +    ARM64SysRegField *field = (ARM64SysRegField *)opaque;
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    uint64_t *idregs = cpu->isar.idregs;
> +    uint64_t old, value, mask;
> +    int lower = field->shift;
> +    int length = field->length;
> +    int index = field->index;
> +
> +    if (!visit_type_uint64(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    if (length < 64 && value > ((1 << length) - 1)) {
> +        error_setg(errp,
> +                   "idreg %s set value (0x%lx) exceeds length of field (%d)!",
> +                   name, value, length);
> +        return;
> +    }
> +
> +    if (field->arch_vals) {
> +        /* this field has some enum values */
> +        for (int i = 0; i < field->arch_vals_count; i++) {
> +            if (value == field->arch_vals[i].value) {
> +                goto valid;
> +            }
> +        }
> +        error_setg(errp,
> +                   "idreg %s set value (0x%lx) does not match any "
> +                   "arch valid enum value!", name, value);

Scratch the !

From error_setg()'s contract:

 * The resulting message should be a single phrase, with no newline or
 * trailing punctuation.

> +        return;
> +    }
> +
> +valid:
> +
> +    mask = MAKE_64BIT_MASK(lower, length);
> +    value = value << lower;
> +    old = idregs[index];
> +    idregs[index] = old & ~mask;
> +    idregs[index] |= value;
> +    trace_set_sysreg_prop(name, old, mask, value, idregs[index]);
> +}

[...]


