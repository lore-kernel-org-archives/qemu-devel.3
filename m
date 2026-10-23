Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D6E606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=n8lEY5SR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKDhp-0005Fz-AP; Fri, 23 Oct 2026 07:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKDhn-0005FM-CJ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:45:03 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKDhl-0006qy-NK
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:45:03 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8ac525c1f05so7172617b3.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 04:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792755900; cv=none;
 d=google.com; s=arc-20260327;
 b=IK4IaPvlpkKB40v40pl5jGOzgJ4pnmVDYBpqx13Ga2FLm6wo6Mdkd6ayFBtZv6zmFA
 O8ndK5uDvjLEhASSf+sv74s6j3dvCerfxbWrRlNX6Y1BULJGHICuKGynx6nr9jhIgtHd
 z2U4MAm9U9tmynuTcN4fa7SPM3ypB14PQDuH4Qo+CG39VyN+CNmfECFIBQbHg2tf5YAF
 PGi+en8UQ7SKM8a69FX010U3mh6qSKdKGRrjaFlK+8FR6YBbDLjC6xfShfRhyC0phAUO
 cuyJiiL+pyhbxW1CqG+Y63tZdk3G2XxdCqPyPw3Y7SrUDFVnSDHM+xIUypP356INLD4C
 jk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LJ3/gGSXFuZez0qoiMtJBNrT34Y0qC3xMuJpLq2A+6A=;
 fh=Gq8viepnx+yEcYoCSHA6ZHrNSYBCgdeBPcAy7YLlzFY=;
 b=Cj873Am1xa931EaX1cWVN3f9k4aGDLNPJeQ+xq5qo6HxhpKJ9N9kM0KL9rFcZYWcbV
 SCvwD9I1YgtD+sydDjFhEnGnoVC7nFhAm0nJbCIyCpFUJdUDswLPmSRpT906Y0FsWrYJ
 Lxbw+MDZwXBWECJnvq9EFXjjpXfgQ+/xn2wU2e/6XKndriIfzdPfvb346UnkVZs9khyY
 mVce49W2X6ZibPythE8E29zxCEMIO/2r1Y/znwnHXBc/Es4ix5OOvUbYqGOCz9kWVwF6
 nD8gzHR8ElTiznNIVraulLtR5zOL65+wY74rEHE1GTjGxi5xVAzhsqbZTlLW46RRFum9
 tz8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792755900; x=1793360700; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LJ3/gGSXFuZez0qoiMtJBNrT34Y0qC3xMuJpLq2A+6A=;
 b=n8lEY5SRDepQHCpTEVODa9eThVaZwnc4j/kCYFBlKIsHx5Kx3U8C2BHf2ZIC8S8eeN
 3u8id2Y51/b7VPf5hW0qMjyl0JSDdQSCGLZEM7tx5bE4nxIlIjYNVLs+VvXfx/kQEc61
 lsQMjpS7UICdVHq+qrPenLFyVD1JjH8I5v1oHncGtZmv/WN6+4ZS0ZyJyQVq+ih73nAv
 bgAztgATlm7eIIIuyuyqufk6UeQittR1HQiQrn+8FZwa87gWQ1PLE64cHHhYcKwiMHQi
 N2ktDOduwMcXTM3/c+XBd+MrK63RvrnEXk+7/kTFPIgYaYKJfZzzwwjdYRmhC+whg75l
 98bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792755900; x=1793360700;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LJ3/gGSXFuZez0qoiMtJBNrT34Y0qC3xMuJpLq2A+6A=;
 b=IsYUIM518HiTUc/dDodhbIKPLVYWV/83p8EURfZ36/YmOQYJOhz6BQDhIoxFtnW95V
 KfGP+h3OEreLlOh4Bajv68ge02SuPkrlDesZOp53+J7hiAVa3dOFQGU4NJdc1nja0153
 9KGbcoc6wx0riddqLQ0oCxBG455g0biMGU+Q1b289vcrI5XcnkkV0UJbTloyND5PpIA2
 1t0GQ1RvYf42uzKsWL0pKdUlvPc3HRDL9+6E2uEw66KQB5bv+bFCaq1gafpuIyCNYcYK
 9fVP8xMeFpv76Ci3TC0UjP57roWo52cWfPDe2gCR1ARcTAq7Xp6XkySHvy5f736TPnMc
 Rapw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMB5zafEURUhleDyDW71KQDbQABIImE8dtzAU/lGb0ghafVPnMfAEb6CEHrXgLseXm6kZ6xiBJJJi8@nongnu.org
X-Gm-Message-State: AFq9FYJxso5cjPVT/CjP7CgI1GDacWjG9DwXiqu69LymjPY1sMzm/EnL
 ZVSNG2peV7ymHED4rP5AS472nHO/bFqSCsZgswxjl/JB3tBT/1jAUl6oCj4S9xPA7CYXkBw7fES
 SJGhT35kqE7uTt7XXQa2cv1K6FSuq4GDqYkgy+4JXig==
X-Gm-Gg: AYBFou0Qr0ztY2FkBa1MrB6zL33DRC1oab83nYUnEG/GEmw4+M0PB9Pdnbi0cVwBGXR
 xchiCnm8Kl24w1ZjjH0WCNZOvLITjAN7Go1Xh/I4UbuXlOvm/efZGrclcX70socWawhYJff0WBj
 93dOfjwyuOzjjnDaaJsiY/M2NHRjV0nhaVPAl7UtZhT3SdPuz7eb3M27f1CoaMWx7xrgMn4hfnF
 MR9YpC1eri7ZDy8ZmCRW6//oGqSBB+24GyFPUv9TPHIyiSxMV3qEFSwO2+4zXPmC8KXV41n3XHy
 2rMFZIRxVCuzbmhtSSou7inElom42Kb6p3jgPxaz6N2doEWO0RCmJaELpWHr+i8l2CQlxj2Sv8C
 hm0afb/pBEZrSSEQiRSUMZp4H/6kkr0X7t/h6UeUpqC9x+vKUDElGVxxE46edfQZhEJ6RoPvXPp
 Ubbp9sO9jqNmXJBO+8OxiM
X-Received: by 2002:a05:690c:7108:b0:847:d0cd:11eb with SMTP id
 00721157ae682-8b157ba2d78mr17589257b3.9.1792755900069; Fri, 23 Oct 2026
 04:45:00 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261010133725.642498-1-eric.auger@redhat.com>
In-Reply-To: <20261010133725.642498-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 12:44:48 +0100
X-Gm-Features: AclHuK-SOddt72tpNNxsXJ62VuaXNgbTq3dc6W6MUQby4pa5991PP5qOVGNvpWA
Message-ID: <CAFEAcA9XE0TLxp+DNzFSbkxbj7f0M78N+tf1a01cJ5rNkM7NBA@mail.gmail.com>
Subject: Re: [PATCH v10 00/26] kvm/arm: Introduce a customizable aarch64 KVM
 host model
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org, 
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com, 
 maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com, 
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com, 
 jdenemar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 10 Oct 2026 at 14:37, Eric Auger <eric.auger@redhat.com> wrote:
>
> This series enhances the current host KVM model with capability to
> set writable ID reg fields.
>
> Since v6.7 kernel, KVM/arm allows the userspace to overwrite the values
> of a subset of ID regs. The list of writable fields continues to grow.
> The feature ID range is defined as the AArch64 System register space
> with op0==3, op1=={0, 1, 3}, CRn==0, CRm=={0-7}, op2=={0-7}.
>
> The end goal is to get more flexibility when migrating guests
> between different host hardware. This series is a prerequisite for
> aarch64 named vcpu models.

To help me with review prioritization -- are you hoping this will
land for 11.2, or are you expecting it to be 12.0 material? (Given
the softfreeze date is rapidly approaching, it feels to me like
12.0 is where it's going to be.)

thanks
-- PMM

