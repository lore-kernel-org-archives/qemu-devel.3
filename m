Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF38C7115B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYJG-00031g-28; Tue, 17 Jun 2025 11:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRYID-0001Fx-VH
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:32:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRXgN-0004VA-UT
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 10:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750171981;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/vvdbIrIYuE0AqpfkcU+eN1rb+0uJtRv0SRE3RdgRVE=;
 b=TNoMJAKRfe1BxMDJvlL/8W2jGJQwiQv4JCFkthJU0ZK5zc8JZyhk+ArOM6eVOXUvTVwqSL
 wqsMq0N+YyDowCSQLh9eyw//kczZkYyQdrdU4fFIWkchtzVaoVSB7uV89eIv6KYtecGaJG
 P7+GtdPmCxJtBFfZTK42fq8Djdsd/wk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-x0u6e5-PN8CI4lMCQbRKVw-1; Tue, 17 Jun 2025 10:52:59 -0400
X-MC-Unique: x0u6e5-PN8CI4lMCQbRKVw-1
X-Mimecast-MFC-AGG-ID: x0u6e5-PN8CI4lMCQbRKVw_1750171978
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450d290d542so35388645e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 07:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750171978; x=1750776778;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/vvdbIrIYuE0AqpfkcU+eN1rb+0uJtRv0SRE3RdgRVE=;
 b=YuABcFNSu0FMjMySyj97WRKBp4Uq+2RZJHdQ5IujlyYzKDWKS06Ofw0DQUe256QBEA
 fXL6XvnmYsAK8jZiAlQX18njvAnFc4fH/E9xkjxWE7HhO7Dv2tArgTVSdhyxuyG/jpdJ
 AM2v9c0zU+VhJ4qx8w/CWJuSMxAI6+BS8lwI8LArZO4TEu662hzePv1E89KxtZqreNMU
 VMBvHYsm3u2dFLAxTswpqmbGGL3eWrZkOQgY4nID+WX0rzPdIeL3uGw0qRbn2ylwxqu1
 M7bpJ4wAtDxsrKXRwoeYJmr3koOM+Gzx9QPC+gQCMxKIq3dz0YPub9SFGLCI5pUPL6kb
 AxYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTvuJJOo+bODGKlzUxKiZD8wdjqkjmGSO73wJ1TYVcJA3T3ivVc2qoblQjUyQ/9BXULLexxKwWRE08@nongnu.org
X-Gm-Message-State: AOJu0Yxgvxos6aUVVLuD7hQpHyP6c/xctEHxphQMdzJuQeF7wJ+3YRMl
 eT1wRgoJBMgrp5mc42ZAI93EJfDt9ItpjSOHCYEF31GfkzRdBVyedAg3NZmT4Pw44UEyhjgawwF
 Zc5CPOUNrEw8c+XEd6ExoxgR/5tVffvb2+j89tCs+XmCJgZLMil86fWV/
X-Gm-Gg: ASbGncspwuj2FZ18HTa/kbQY7SqMciJVqcpeNd+cY+URYAL5NFXcl67SW64kXHuRJww
 L2Ou3ra//Gn8pWSCHHEy9SYmTaCtWi+S0lkUEpkzDuBy+OOFxcwyq1tP2I5QgWFJML0Btm/h3do
 UnW0DR94TrZMVHFglIW3wY1VKzWpitopaRkj2kkNF8x/HJV51j1myiFZHLBtW+wPkb0XZN0nlto
 razrF7yAVUnT4etPBNCXWgRUIisHKgomdwJrfjZkBI6E8mZmwaDQM1E0fY9wTGJqUvrBiurpHiQ
 4UK80ca4303RwIBiohT8VrHmAJB9ecjMYFVy4Ih2RuhT+bdsjO32f48+mYl2s5G5F746bw==
X-Received: by 2002:a5d:5849:0:b0:3a4:dfc2:2a3e with SMTP id
 ffacd0b85a97d-3a5723aeb2cmr11568588f8f.39.1750171978386; 
 Tue, 17 Jun 2025 07:52:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9HTWdom8PFQPfWWFaLklEvLBfbARk0LOFa905xM7xhItbTYPloiIJQ7yrjufhWUNXVbry4w==
X-Received: by 2002:a5d:5849:0:b0:3a4:dfc2:2a3e with SMTP id
 ffacd0b85a97d-3a5723aeb2cmr11568559f8f.39.1750171977970; 
 Tue, 17 Jun 2025 07:52:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e224956sm180681045e9.4.2025.06.17.07.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 07:52:57 -0700 (PDT)
Message-ID: <6debc836-c55d-406f-a74d-8ea5070b7fba@redhat.com>
Date: Tue, 17 Jun 2025 16:52:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] hw/arm/virt: Allow virt extensions with KVM
Content-Language: en-US
To: Alyssa Ross <hi@alyssa.is>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, miguel.luis@oracle.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, maz@kernel.org,
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com
References: <20250527062534.1186004-1-eric.auger@redhat.com>
 <20250527062534.1186004-6-eric.auger@redhat.com> <875xgutpuh.fsf@alyssa.is>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <875xgutpuh.fsf@alyssa.is>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Alyssa,
On 6/17/25 4:17 PM, Alyssa Ross wrote:
> Eric Auger <eric.auger@redhat.com> writes:
>
>> From: Haibo Xu <haibo.xu@linaro.org>
>>
>> Up to now virt support on guest has been only supported with TCG.
>> Now it becomes feasible to use it with KVM acceleration.
>>
>> Also check only in-kernel GICv3 is used along with KVM EL2.
>>
>> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Hi!  From what I can tell, this will produce an error on hosts that
> don't support nested virtualization when QEMU is invoked with -accel
> kvm:tcg -machine virtualization=on, but I don't think that's the ideal
Thanks for reporting this issue. This is not an expected behavior. I
will respin hopefully this week so I will have give it a try.

What kind of error msg do you get?

Thanks

Eric
> behaviour.  It would make more sense for it to fall back to the first
> permitted accel option that does support running the machine as
> configured, so if hardware nested virtualization is not supported, it
> should fall back to TCG.
>
> I maintain an OS development environment that includes scripts for
> running images in QEMU, where running KVM on those images is a
> requirement.  Currently, those scripts simply force TCG on aarch64.
> With this change, to take advantage of KVM NV support, I'd have to try
> to identify in the script whether NV would be supported.  QEMU would be
> in a much better position to determine this and fall back to TCG if it's
> unsupported, like how the -accel option with multiple values usually
> works.


