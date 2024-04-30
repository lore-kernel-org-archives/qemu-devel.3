Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7297AC10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 14:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1o2C-0002Uf-KN; Tue, 30 Apr 2024 10:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1o29-0002TU-5G
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:00:37 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1o23-0002sW-0R
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 10:00:32 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A4B1421EB3;
 Tue, 30 Apr 2024 14:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714485627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYynI1qa8xvrfVkgQHW1Fgx9r9qxCq9BktiNonT9XuU=;
 b=Xw7PIu6yyz5lPmEvdrPI4+f5kzoOSxmIWCLjj9+JX4O7dUvkKLiyNQ2xDHCDr/+wlHIUBm
 RyjKMALQnsVaRPLQvaXAQ5xOdL8kqxFhNiYNhWJS5NjFmJgNKMjOMcq+CZqlDG4jr4wg5y
 vv3rjHnsGzo7HOwFR7FuNud7jDQmAXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714485627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYynI1qa8xvrfVkgQHW1Fgx9r9qxCq9BktiNonT9XuU=;
 b=0759iXqjK2wuS2n2+BMyrMeeDDFH0jvkc//c8+L8by3W1vXXyVEPxAqtqfxZct5cIfBpuj
 OCXzdExgWfH39JDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Xw7PIu6y;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0759iXqj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714485627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYynI1qa8xvrfVkgQHW1Fgx9r9qxCq9BktiNonT9XuU=;
 b=Xw7PIu6yyz5lPmEvdrPI4+f5kzoOSxmIWCLjj9+JX4O7dUvkKLiyNQ2xDHCDr/+wlHIUBm
 RyjKMALQnsVaRPLQvaXAQ5xOdL8kqxFhNiYNhWJS5NjFmJgNKMjOMcq+CZqlDG4jr4wg5y
 vv3rjHnsGzo7HOwFR7FuNud7jDQmAXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714485627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYynI1qa8xvrfVkgQHW1Fgx9r9qxCq9BktiNonT9XuU=;
 b=0759iXqjK2wuS2n2+BMyrMeeDDFH0jvkc//c8+L8by3W1vXXyVEPxAqtqfxZct5cIfBpuj
 OCXzdExgWfH39JDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 239EF133A7;
 Tue, 30 Apr 2024 14:00:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Fk8EN3r5MGYpPwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 30 Apr 2024 14:00:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Song Gao
 <gaosong@loongson.cn>, qemu-devel@nongnu.org, Tianrui Zhao
 <zhaotianrui@loongson.cn>
Cc: pbonzini@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maobibo@loongson.cn, lixianglai@loongso.cn,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] target/loongarch/kvm: Fix VM recovery from disk failures
In-Reply-To: <f9956c18-3530-4fc2-8150-beba7b673f89@linaro.org>
References: <20240430012356.2620763-1-gaosong@loongson.cn>
 <f9956c18-3530-4fc2-8150-beba7b673f89@linaro.org>
Date: Tue, 30 Apr 2024 11:00:24 -0300
Message-ID: <87edanlzlz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A4B1421EB3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, linaro.org:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> (Cc'ing migration maintainers)
>
> On 30/4/24 03:23, Song Gao wrote:
>> vmstate does not save kvm_state_conter,
>> which can cause VM recovery from disk to fail.
>
> Cc: qemu-stable@nongnu.org
> Fixes: d11681c94f ("target/loongarch: Implement kvm_arch_init_vcpu")
>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   target/loongarch/machine.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>=20
>> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
>> index c7029fb9b4..4cd1bf06ff 100644
>> --- a/target/loongarch/machine.c
>> +++ b/target/loongarch/machine.c
>> @@ -191,6 +191,8 @@ const VMStateDescription vmstate_loongarch_cpu =3D {
>>           VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
>>                                0, vmstate_tlb, LoongArchTLB),
>>=20=20=20
>> +        VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
>> +
>>           VMSTATE_END_OF_LIST()
>>       },
>>       .subsections =3D (const VMStateDescription * const []) {
>
> The migration stream is versioned, so you should increase it,
> but this field is only relevant for KVM (it shouldn't be there
> in non-KVM builds). IMHO the correct migration way to fix that
> is (untested):
>
> -- >8 --
> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
> index c7029fb9b4..08032c6d71 100644
> --- a/target/loongarch/machine.c
> +++ b/target/loongarch/machine.c
> @@ -8,8 +8,27 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "migration/cpu.h"
> +#include "sysemu/kvm.h"
>   #include "vec.h"
>
> +#ifdef CONFIG_KVM
> +static bool kvmcpu_needed(void *opaque)
> +{
> +    return kvm_enabled();
> +}
> +
> +static const VMStateDescription vmstate_kvmtimer =3D {
> +    .name =3D "cpu/kvmtimer",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D kvmcpu_needed,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +#endif /* CONFIG_KVM */
> +
>   static const VMStateDescription vmstate_fpu_reg =3D {
>       .name =3D "fpu_reg",
>       .version_id =3D 1,
> @@ -194,6 +213,9 @@ const VMStateDescription vmstate_loongarch_cpu =3D {
>           VMSTATE_END_OF_LIST()
>       },
>       .subsections =3D (const VMStateDescription * const []) {
> +#ifdef CONFIG_KVM
> +        &vmstate_kvmcpu,
> +#endif
>           &vmstate_fpu,
>           &vmstate_lsx,
>           &vmstate_lasx,
> ---

LGTM, I'd just leave only the .needed function under CONFIG_KVM instead
of the whole subsection.


