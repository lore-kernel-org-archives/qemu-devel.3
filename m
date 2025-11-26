Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EF4D1039B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 16:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOIau-0000BB-RN; Wed, 26 Nov 2025 11:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vOIas-0000Aj-Up
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 11:42:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vOIaq-0003IN-ON
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 11:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764175331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m7SyIdqdUa9gYwWDMUZBbMOAJgYjhUedYCXY9gacoNU=;
 b=dgtGsWkG4aQoqCYaMzykl1/8IfgdFNEjuEflvAlEN+hlaDWbgs0Hd17h57z3smbfsx8B2w
 ErylV8PXuyKeEIEUPl4ZOHMV3P4GNsvP8Wd6CfECN9m55lyrw9zWdu5Hxgitvqv5gKBuJt
 DFA5+oMd8dFYP85blmoG7P+dZqwkGPs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-dQQFax84Mjuv7xCqnxjY9w-1; Wed, 26 Nov 2025 11:42:10 -0500
X-MC-Unique: dQQFax84Mjuv7xCqnxjY9w-1
X-Mimecast-MFC-AGG-ID: dQQFax84Mjuv7xCqnxjY9w_1764175329
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429c5da68e5so1023485f8f.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 08:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764175329; x=1764780129; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=m7SyIdqdUa9gYwWDMUZBbMOAJgYjhUedYCXY9gacoNU=;
 b=VIrYZLPH+MloFbARuPCXvXQaFSwCu/pMAN9NcKWqZ0/7JwImX4FDRBXVouo/EzwZGn
 2evTaMCJoOxA4LrRu6yPEH2mcxZ7g5dqts+vSq5IE+sUQHsNwjYtZ4El5DRoGrOmrdRT
 2C9GvIzo8zOne1m+Yxd72RkVgbPYzS2Rt9BWLl/23zL9UBbeTvzrwuXkdz0snpNQuMF4
 z4PCVfizNRORF7QCxgsiZHLvRocUSUy+eZkmB8EV3jsBWCDAftN2Aj2PNorralMTuQz5
 mePMFsFdb3br7bq7n2Ym0nFXI2JV/qT65oofVFqCsfMGalloYSmqDNQau6pjsj3AVlun
 fsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764175329; x=1764780129;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m7SyIdqdUa9gYwWDMUZBbMOAJgYjhUedYCXY9gacoNU=;
 b=FWv5Ps6QfUU2k0hJHCgUGE3m0B80QmuP0lQeNB8J7VneVWd5PVurB3I+R7eZ81JV2q
 d0kKStx5f1CJEyeOA6rpVQBeYjehsqw298OmhiAL/FLOBrwv1XAEASJ9dmKjn9CiaPj1
 DLEdWGlTOb5CLeZnjjIgDs/eVNqnBLoy283dt7LUt+Gpp1wnMfUtMCVmq3jcdMVTrSz+
 8inLjmHzf94ZCaIY5T+3q1S6+WbAVWQoitwr1L1MFgpZsRuy6zQB80ke8qszh85vZXdk
 Cg6v4eULSuR35iQ3P/3lO1vzN9tYLL+4mOafMipSJbn2SqwfEWbXX1gqaLmfghmL9xDC
 vuSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzVLi69V8Ba1S5xlbN1j4Dvzoeyp8CIb0QKy804JLq5VxwQrAsYcjqJtI4jt3/emqUCeaqrneUT39Y@nongnu.org
X-Gm-Message-State: AOJu0YzqdarHbVkfBvM8WT9Z9riLZWAVTt6LL+0eDdYRE+BhCvbpgxZr
 56AOMmya5fp/C79BI6pM93Th8+x/yT2yJu5J5POT7CE5Rk/biJkmoxkXNapbluQCcJWozNHZCQI
 FZL5ULlOVXO8y76Y1fUTTtqHKC5+XONkAoC0EqHSUfDJhkjgWjFW0RRxG8VAaDhRS
X-Gm-Gg: ASbGncuIwFMbsK1DZi0tVihnR4bxYSLcG2yAthDoJgE+AFbXuVLtm/xq6DdZk0zGPNw
 fRip+tthelHqbiVGLzoK3+8Wwbdq4BTb0d2sQeX5NbyBJIVdI60cNDBg34z1TQCHanewBKLvgWE
 pxcZdytu03JXY/NPSevbPKFI+tmOniXgfTOiL3ei1pV297cIvNNld4shSAW+K497n1A8hAMwqNn
 WEJK2VB+6urTWYJLCKSNaPJv/MSWjm66/5kEWU5Dw+3EtgPv2ojpdwhNxs+pQpfuykH3eCRtq+v
 0C/9UNH/4QRDQE+6VBeMBBaRoCdn3nuIo/ZBcJnlwmW0lO65apG+7BSoxplLSgqxjCtCgELDBQ7
 hVhgcBGB5wTMcUufRZDr1kxXGWecENtv/BPq5GCzOXe2s0pVuaWgMhLypYQ==
X-Received: by 2002:a05:6000:26c7:b0:411:3c14:3ad9 with SMTP id
 ffacd0b85a97d-42cc137bc77mr23294343f8f.21.1764175328709; 
 Wed, 26 Nov 2025 08:42:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjg5qZgo/NEQ5RtMwcn6hAtfuG2XUuXqArlLrWu7TMGdKF9OeYauHKx52hmpqkQgMmB6L/Jg==
X-Received: by 2002:a05:6000:26c7:b0:411:3c14:3ad9 with SMTP id
 ffacd0b85a97d-42cc137bc77mr23294304f8f.21.1764175328279; 
 Wed, 26 Nov 2025 08:42:08 -0800 (PST)
Received: from rh (p200300f6af35a800883b071bf1f3e4b6.dip0.t-ipconnect.de.
 [2003:f6:af35:a800:883b:71b:f1f3:e4b6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa7affsm42112712f8f.23.2025.11.26.08.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 08:42:07 -0800 (PST)
Date: Wed, 26 Nov 2025 17:42:06 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, cohuck@redhat.com, maz@kernel.org, 
 oliver.upton@linux.dev, gshan@redhat.com, ddutile@redhat.com, 
 peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 06/11] kvm-all: Add the capability to blacklist some
 KVM regs
In-Reply-To: <20251125100859.506228-7-eric.auger@redhat.com>
Message-ID: <fd76a931-0bff-2e83-5032-0c91df036dc6@redhat.com>
References: <20251125100859.506228-1-eric.auger@redhat.com>
 <20251125100859.506228-7-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, 25 Nov 2025, Eric Auger wrote:
> On ARM we want to be able to blacklist registers that are exposed
> by KVM. To mitigate some mitigation failures that occur when a new
                            ^
                            migration
> register is exposed and does not exist on the destination, some
> registers are tagged "hidden" and their state won't be saved. As the
> state is not saved and they are expected not to be used, we want to
> enforce they aren't. So let's check this. The new CPUClass hide_reg()
> callback is optional and will be implemented on ARM in a subsequent
> patch.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

How about "kvm-all: ensure hidden regs are not accessed"?

Reviewed-by: Sebastian Ott <sebott@redhat.com>


