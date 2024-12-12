Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BFCE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 13:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLj0g-0002D6-LQ; Thu, 12 Dec 2024 08:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tLj0c-0002CB-Vt
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:13:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tLj0a-0001Gp-P6
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 08:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734009214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wxof28cpgCbDnkhoQWNSoVVTvYRkzUUHJ4j75bS+0v0=;
 b=AA7aR5ZuORU3KN7lW5BK/mdL6zn1w10lrJ2CSUhaALHej96xupZc2wUEXzQDm9WMmShTbf
 x35nKugvsvyPlC5Namu1Ay/6c82lB1jzeaho/pgnSpH04TvWvh2q+xez8+E7JCg/jbcA/q
 hdGenwE7sL4RhvNsiTUb+6ZM78ABAhU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-7EnWtZ8MNE6JbMyBGUeTDg-1; Thu, 12 Dec 2024 08:13:32 -0500
X-MC-Unique: 7EnWtZ8MNE6JbMyBGUeTDg-1
X-Mimecast-MFC-AGG-ID: 7EnWtZ8MNE6JbMyBGUeTDg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3862e986d17so282945f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 05:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734009211; x=1734614011;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wxof28cpgCbDnkhoQWNSoVVTvYRkzUUHJ4j75bS+0v0=;
 b=ZFcm+txZ90Na6wfByZfTotoxgTOjqh68BQ1Ijkz2n+NP3VJMBKRn3l4p5F7B0g6sTf
 VZfsuud47uuFsc0ezURANfNtAuxpqXu6jGHT0wjRXTuDjWROgUIye7h4hCn5a9Xq0oew
 3l0U9oPezlZyAHTR+S5MLIbfsbWmDqSxgWt/CSjAa9bmI863iy3b+Jb2/y8LYbH2BqzS
 XGWBXkKTvF74Q31gednD7Y1Y0pNgDq3uUyBYnYaw2EJ4FwukJ+6R7O4BBI/TAvxSpGBI
 22XBAi4Eu6lgonDLI/XRC+EqEuq0wey2DQgVpWgTI0is3HrxyN4F+CNx6/bDzdxSairT
 zeTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaQA28HCGF/ReTUgOnrmTgcFsTuN+cI8CDxOMfiOb45eNyAnXt2qW7d1S5HfPCJsDN3tSRw7PaQD2R@nongnu.org
X-Gm-Message-State: AOJu0YyLy1mpDeasNap5iaYgADoCuQjtsJAprJiriWYjnlCYsIuXKqeG
 VhZB5wriedwLL+gbJBmNFrGFyq+t1cVDl6hy0fiO03HwAB+jjny7E11oWDxsF5B4+nQs8+i5Z4L
 KV1CiLj+5/QSEvS8+M7hST8gDIqCA3j90RFi1GVBr1or22n0UtgwJ
X-Gm-Gg: ASbGnctSEA9ws2KnuoIs30SQNqtkyJo2jxvxbLtNNpNIl+iZTb+rpsryUjYnn7l4qFT
 Lyo9t7+0zbUnk7Sp44m0PFeF1AEgtknAhqmIMBO71JozNMPx/DYgyddtJMvLd9EJ27ccrKBUCGf
 9CzAoKxxm4ymbJeJtktm+O0YSYJkZlyoWwRO2J9lu3U5FX9Ckq4vezV3vDf5R6t3PCngsY6eCsp
 x8xj2P/hCazq3AnIeUIwAXs5FuDbEvjECzMvP9z4ybZZN7ETzYy4hwgm/1XQHrGekGguicSgVIH
 ZdXD8DdJgw+0Nt131iD1B6Ek+E9x
X-Received: by 2002:a05:6000:1842:b0:386:4034:f9a8 with SMTP id
 ffacd0b85a97d-3864cec576fmr5319998f8f.38.1734009210966; 
 Thu, 12 Dec 2024 05:13:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFA9jreMWG/dYyAwe1URrFUYx8Xo0dt4ngkcqqQNsGq7c7BNDX5RAIlfNLMhrZNJ9g/WfPCmw==
X-Received: by 2002:a05:6000:1842:b0:386:4034:f9a8 with SMTP id
 ffacd0b85a97d-3864cec576fmr5319966f8f.38.1734009210560; 
 Thu, 12 Dec 2024 05:13:30 -0800 (PST)
Received: from rh (p200300f6af0bca008282df582fad0b68.dip0.t-ipconnect.de.
 [2003:f6:af0b:ca00:8282:df58:2fad:b68])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782521dfesm3907401f8f.107.2024.12.12.05.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 05:13:30 -0800 (PST)
Date: Thu, 12 Dec 2024 14:13:29 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, shameerali.kolothum.thodi@huawei.com, 
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com, 
 jdenemar@redhat.com, shahuang@redhat.com, mark.rutland@arm.com, 
 philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH RFCv2 00/20] kvm/arm: Introduce a customizable aarch64
 KVM host model
In-Reply-To: <20241206112213.88394-1-cohuck@redhat.com>
Message-ID: <90431f60-e366-50e9-e95e-2ec9c6812056@redhat.com>
References: <20241206112213.88394-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 6 Dec 2024, Cornelia Huck wrote:
> A respin/update on the aarch64 KVM cpu models. Also available at
> gitlab.com/cohuck/qemu arm-cpu-model-rfcv2
>
> Find Eric's original cover letter below, so that I do not need to
> repeat myself on the aspects that have not changed since RFCv1 :)
>
> Changes from RFCv1:
>
> Rebased on more recent QEMU (some adaptions in the register conversions
> of the first few patches.)
>
> Based on feedback, I have removed the "custom" cpu model; instead, I
> have added the new SYSREG_<REG>_<FIELD> properties to the "host" model.
> This works well if you want to tweak anything that does not correspond
> to the existing properties for the host model; however, if you e.g.
> wanted to tweak sve, you have two ways to do so -- we'd probably either
> want to check for conflicts, or just declare precedence. The kvm-specific
> props remain unchanged, as they are orthogonal to this configuration.
>
> The cpu model expansion for the "host" model now dumps the new SYSREG_
> properties in addition to the existing host model properties; this is a
> bit ugly, but I don't see a good way on how to split this up.
>

I gave this a spin today and successfully migrated a VM between 2 similar
machines that only differ in the DIC bit of the cache type register using:

 	-cpu host,SYSREG_CTR_EL0_DIC=0

This allows me to get rid of my horrid qemu hacks to achieve the same.

Thanks,
Sebastian


