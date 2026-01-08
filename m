Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF367D148AF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 06:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdjvn-0001ZM-8t; Thu, 08 Jan 2026 01:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdjvg-0001VP-Rr
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 01:55:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdjvc-0004pr-BJ
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 01:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767855325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5MMxSTqhdZNpibZZd8weNdtSX9owJ5Hpp1Mup10rJK0=;
 b=KwgiEy6bEs05DHa5zhZLL+iKYsWmgkudjTzKafYP1EdLDA5p7d+VBbf1MlbUIYYwC7tjkM
 oymn6cayNohHuYPKTnwCwyEfngyWRy8lHcJVbVz7zzYX92htSnLsGqbdc8kXZArxk73kt8
 DRxNhdITC0FrS9uS/zVKQ5WLAsEM2yU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-fJ0NxtVsM9uEDpg3IFUsDA-1; Thu,
 08 Jan 2026 01:55:19 -0500
X-MC-Unique: fJ0NxtVsM9uEDpg3IFUsDA-1
X-Mimecast-MFC-AGG-ID: fJ0NxtVsM9uEDpg3IFUsDA_1767855319
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9CF11955F34; Thu,  8 Jan 2026 06:55:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 759BE1800240; Thu,  8 Jan 2026 06:55:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1590A21E6937; Thu, 08 Jan 2026 07:55:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PULL 14/17] error: Use error_setg_errno() to improve error
 messages
In-Reply-To: <4e1b7b58-9598-4914-9a21-de71c465d5ca@linaro.org> (Richard
 Henderson's message of "Thu, 8 Jan 2026 15:15:57 +1100")
References: <20260107124341.1093312-1-armbru@redhat.com>
 <20260107124341.1093312-15-armbru@redhat.com>
 <4e1b7b58-9598-4914-9a21-de71c465d5ca@linaro.org>
Date: Thu, 08 Jan 2026 07:55:16 +0100
Message-ID: <87cy3kegq3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 1/7/26 23:43, Markus Armbruster wrote:
>> @@ -2032,7 +2032,8 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>>           reg.addr = (uint64_t)&val;
>>           ret = ioctl(kvmcpu.cpufd, KVM_GET_ONE_REG, &reg);
>>           if (ret != 0) {
>> -            error_setg(errp, "Unable to read cbom_blocksize, error %d", errno);
>> +            error_setg(errp, errno,
>> +                       "Unable to read cbom_blocksize");
>>               return;
>>           }
>>   
>
> Missed changing the function.

[...]

Sorry about that.  v2 coming.


