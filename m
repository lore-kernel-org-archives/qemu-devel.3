Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F363D340BB
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 16:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkmIf-0004W6-MZ; Tue, 27 Jan 2026 11:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vkmIa-0004UO-07
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 11:52:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vkmIY-0001JN-Ez
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 11:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769532732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rHkHrFUsEzO8KekL6OGYKfzXVNKet8mDOgQIYRfibQI=;
 b=Qi8Gj2kF0T6uGedu62YHViMfwZlqHFQH61zZjAO4fdX23+pClazY1IlG+prKLFNkezWESJ
 02g3+33jbXAXMW+CkimGW9ajVCzougsJXa/x9J5ebG3Y48DYbFFtYBW2VI0lhfb+dLhdf4
 Zd4OMDRVVBblwFYJzDQut2Iwuos52yo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-618jhL3KPU-0oNMJDl7_sw-1; Tue, 27 Jan 2026 11:52:11 -0500
X-MC-Unique: 618jhL3KPU-0oNMJDl7_sw-1
X-Mimecast-MFC-AGG-ID: 618jhL3KPU-0oNMJDl7_sw_1769532730
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47edc79ff28so37082675e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 08:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769532730; x=1770137530; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=rHkHrFUsEzO8KekL6OGYKfzXVNKet8mDOgQIYRfibQI=;
 b=iRyJ74RRcVQj3CuK1buj/fVPbiza0lghsZaoZYs+O8hsSF9Yc/2BpUDlyD4N/M+7El
 wCjiQFqSLYnyaGGLV+4JcqqWZjooesnI1Y6NxuUV6HcBmr8rV2hOUzGKpr6OdzAvQxXV
 wUAKul8EZ5AigKRAivLWwYlUBufXDVUnuwMSi2crX8ean9L5TC8Ol6w4pWcNk2y/kWyc
 OesnO7WPLvh3Cj4j/xiS+blh3gydWYQQoaOZQcYzKNJ8DPUwuizEneLzm0j3ckNN2w7b
 HMEYpvFM4MBwrfbgJzBGtnWXyTU2KS8dXcl1b2i4WKxfQ8CHS1thJJLz36fM9vyfH+kt
 4dDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769532730; x=1770137530;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rHkHrFUsEzO8KekL6OGYKfzXVNKet8mDOgQIYRfibQI=;
 b=wjQidYkSMiV53rh6FzfpoH+M+I0MCPhu8iYWjzGtGWAHRD6UIC+UtT0XZGC6vdDEem
 MBSixjjrb0fzJ9jn3td2uvdIxK1EhWrmE+Em9dIK5a+Bv01brP3SzUAgMgowpKv45eiX
 NLIhDe6bMZqk8xce0IY2gK61SdKiwIuTAemMnQryeSB2O/bp6e9eVWWMdS/fpZO3xJYo
 0/amlgx4hpDRLwhMphS/8jEYbhfcshUAlglCeCrqdNpYHmlaNkcsx7N0RqPTWW2PRilg
 ILoOarX3f7nSC4OO1s/wDV4a8UHDBKMKrsdgcCzmu7PHi+VFaPZZPxI3USFcMBGE4tM1
 EuFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFCDzoZCSowOP3didwzr4gnJzIzXOANRDrecUMx4Dda81m71d0L170yR/S3WzKRHrjUbWgHiRO5tBu@nongnu.org
X-Gm-Message-State: AOJu0YzdOXkTia3KUIkmpCuVk6kcj0K9n3CBJzIdZP3AqW6HcnrjupZh
 EE14wSa9EUFdq8k7T8GW26Sf9gbqrxiwzSYhhM1MxPhghzSpIOvDyW7Ko8vmaFxq30Ula5ZfOqR
 gyZBNPz46qgOfSMNAKwuM9lSzjp3QRQnXhDza3zzIzSAPGXvojfy+SoV9
X-Gm-Gg: AZuq6aKfQvihAS7H4w8oaSp8p49aarzToFRN+qA18rZ/wuCfi/B2RwpPFT1TR2qaSNL
 4X3ckuPmN6kCOgLwRENktILgjavksmlTrVuiFwP19CqG5l5QCum496B7Web2O0/uT2B0pSZLXet
 0TrgChraISHwNTHt0GN/PTLU62Sw/94DWTEbg/ByFYMdU2ITe7h1tkJ1XGYYpy0fE5vWaPZUN8v
 Lv+v+2Q3wUi6P5SZXzs/eFh5k2Vxdp20cqOt+fg3hSV8NTI680z2cAhIgQls17xFWq6BON+J8Fk
 YUW3wf69Z/9Y0qZreBBSwDfe34SPj2+1PuSMB4ksOAnx/fPcefz2+qq+77FwZiW/eCuVEUuzAwk
 Tehepf/VHwy8pL8DiIPMq5XkswTvZLTQj76JDL40rPORqfIesIgzoMvslkbM=
X-Received: by 2002:a05:600c:3e08:b0:47a:810f:1d06 with SMTP id
 5b1f17b1804b1-48069bfac67mr32498155e9.4.1769532730031; 
 Tue, 27 Jan 2026 08:52:10 -0800 (PST)
X-Received: by 2002:a05:600c:3e08:b0:47a:810f:1d06 with SMTP id
 5b1f17b1804b1-48069bfac67mr32497825e9.4.1769532729551; 
 Tue, 27 Jan 2026 08:52:09 -0800 (PST)
Received: from rh (p200300f6af31d00062ddfb9151537832.dip0.t-ipconnect.de.
 [2003:f6:af31:d000:62dd:fb91:5153:7832])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce564f9sm3852565e9.14.2026.01.27.08.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:52:09 -0800 (PST)
Date: Tue, 27 Jan 2026 17:52:07 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, Cornelia Huck <cohuck@redhat.com>, 
 maz@kernel.org, oliver.upton@linux.dev, gshan@redhat.com, 
 ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org, 
 pbonzini@redhat.com
Subject: Re: [PATCH v6 00/11] Mitigation of "failed to load
 cpu:cpreg_vmstate_array_len" migration failures
In-Reply-To: <20260126165445.3033335-1-eric.auger@redhat.com>
Message-ID: <02feaa00-2188-8265-4a65-63fe40270093@redhat.com>
References: <20260126165445.3033335-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 26 Jan 2026, Eric Auger wrote:

> When migrating ARM guests accross same machines with different host
> kernels we are likely to encounter failures such as:
>
> "failed to load cpu:cpreg_vmstate_array_len"
>
> This is due to the fact KVM exposes a different number of registers
> to qemu on source and destination. When trying to migrate a bigger
> register set to a smaller one, qemu cannot save the CPU state.
>
> For example, recently we faced such kind of situations with:
> - unconditionnal exposure of KVM_REG_ARM_VENDOR_HYP_BMAP_2 FW pseudo
>  register from v6.16 onwards. Causes backward migration failure.
> - removal of unconditionnal exposure of TCR2_EL1, PIRE0_EL1, PIR_EL1
>  from v6.13 onwards. Causes forward migration failure.
>
> This situation is really problematic for distributions which want to
> guarantee forward and backward migration of a given machine type
> between different releases.
>
> While the series mainly targets KVM acceleration, this problem
> also exists with TCG. For instance some registers may be exposed
> while they shouldn't. Then it is tricky to fix that situation
> without breaking forward migration. An example was provided by
> Peter: 4f2b82f60 ("target/arm: Reinstate bogus AArch32 DBGDTRTX
> register for migration compat).
>
> This series introduces 2 CPU array properties that list
> - the CPU registers to hide from the exposes sysregs (aims
>  at removing registers from the destination)
> - The CPU registers that may not exist but which can be found
>  in the incoming migration stream (aims at ignoring extra
>  registers in the incoming state)
>
> An example is given to illustrate how those props
> could be used to apply compats for machine types supposed to "see" the
> same register set accross various host kernels.
>
> Mitigation of DBGDTRTX issue would be achieved by setting
> x-mig-safe-missing-regs=0x40200000200e0298 which matches
> AArch32 DBGDTRTX register index.
>
> The first patch improves the tracing so that we can quickly detect
> which registers do not match between the incoming stream and the
> exposed sysregs
>

I gave these a spin - works as advertised, no issues found.
Tested-by: Sebastian Ott <sebott@redhat.com>


