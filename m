Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AF3CC6B24
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH0yB-0005SO-2g; Wed, 14 Oct 2026 11:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xH0y7-0005QE-Mv
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 11:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xH0y5-0008EN-H8
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 11:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791991954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mq81I6/6MELfTlSiNgJCcbSKdRE4LM8gKHiIeTsVVWs=;
 b=EmYFF1k/u5TYs+hm0HcDGh3T0hNdP6nBMFePwqGE96ay0pTA0zG86VnsHqgype/DVhIirj
 2v3Iw+O8XwdqCKElN9mBlAcMjAQ4OHouQeuT3Ewe1LyOALbPx5Z+o9PjhiSV5/Ll4eGWpT
 CD0kzunLcueN6fGdeImeuHvdmZE/0RI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-_5UhVUurMsSRdT0rD1AW6w-1; Wed, 14 Oct 2026 15:32:33 +0000
X-MC-Unique: _5UhVUurMsSRdT0rD1AW6w-1
X-Mimecast-MFC-AGG-ID: _5UhVUurMsSRdT0rD1AW6w_1791991952
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a01d1fb07bso12867845e9.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 08:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791991952; x=1792596752; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Mq81I6/6MELfTlSiNgJCcbSKdRE4LM8gKHiIeTsVVWs=;
 b=WDfqrMtz2aZTWmqfjY4rdt6UPufK2ibRRxxKe3Fj9MnE/oz5xGb9yIpEKcEXUmBbHG
 rgsLL3fOxb6D75NTdLdb3BtHZzmnlP/Tfd45gBktp81BUcSjIG+KcBW8vHaki1VaLr5s
 LSGQoNCXrJ1zuAkRS+exAwM1vJrHZe9Fi/hOAz8vDOoLzLrPpmRqEGT89ZL+JagaKIs1
 bhrHGeFm7gFs4HQ2aIQmYi2B6HxUSs4NprOBecN3GT7g+dOnxNcT2DnwvYgxHheKPr1J
 DYvVxuEwrVhOKnMMAgktFFa2DX1FFKeRqFCN+qrlgV3woutFZ1dokBz9VNc0EDfBu3M0
 aH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791991952; x=1792596752;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Mq81I6/6MELfTlSiNgJCcbSKdRE4LM8gKHiIeTsVVWs=;
 b=U3uS+/h5mHBtSfh/LYEJ6vstGO6Kth0VHFh2VxzScEPhh5NSG1qwg3JEr/cwhpctXA
 3y+H+//eYM6PEbGsPzOmf1feTpq+otvy0pO3YC/+Douk6NZq7+1T8TD2emjDGoIm+veG
 bXUpPyCKDv2u6UdySG+cFHPqnlXbAiC1aF5GN4DIsOkZ+6uAosYtktCfpsyxWY7rooGC
 UOqjcSAedJslVgq5hNQ9+uYpgKzu2lNV+x9gsErH9VWufF3ogB1zRtKfylMJMs3oco1j
 r9LSB/F/tsK2fozqCfyDpTc4CaFV3bFkKbesWuR9UFv5DTdT/HWTe8HPJk6O6npSdBgN
 z2Uw==
X-Gm-Message-State: AFq9FYIrCE/XrZiwCFk1xVTkbpkTBMz06DcCA97uhcL6RpA3bVd6Q6Vb
 mZvNIWx+xjwp/9NMAW0u4Nbi/CLGaYyD0IBSU1ZJihOYZP+UumKsreeTSAE2/86yUsCJx/Mfg5h
 16mpjhL6vy3oOTx6/nUHWWAQJ/Pmmoh0W9sHgMlIUj+Wk8ZvZCddnxATMYls/ykGxb8e29Le9ek
 MDJhPLtwN7ssz5T4+MRFhYHQGGeuSEnGQqyywbJHUq
X-Gm-Gg: AYBFou3N1tB+ns+HyKSVPmOX/lWBfsTVsPz+ej+m4s3BvONd+vNhpHskrr/2a7x7wzX
 Z/KJJVDznG/7ZsNLOE4veNHUPSDinJHWUQnfeRYQ6FywSL7OwzfzTCzLT1jWBoA+PY6b0Jj5yN4
 PgmYg3UgoKIBIRJNvdXjftaBUdUV85LwtWOj6JaCVngBn+4xZmDyQEQUITQj8J1/vWcaNjdvY0g
 afFsQFTfeC1clZrZ3nDfovfh4YjLdupK/96yCd4RH0E65QulXyPlsKQ8tSt6DTSTD9KfGCwXYII
 d5QEHlJTcGxLb/G9hiPJbQzewQ133othNg1p0PZN+oewcgoaX2Ux6dpPPvng2lkxGNUfV/uYYXM
 R8JTDVAItIWEiXw5rkjO784il3q6PKyLUdcs=
X-Received: by 2002:a05:600c:6289:b0:4a1:a475:d885 with SMTP id
 5b1f17b1804b1-4a1a475d8acmr154443495e9.34.1791991951986; 
 Wed, 14 Oct 2026 08:32:31 -0700 (PDT)
X-Received: by 2002:a05:600c:6289:b0:4a1:a475:d885 with SMTP id
 5b1f17b1804b1-4a1a475d8acmr154442825e9.34.1791991951551; 
 Wed, 14 Oct 2026 08:32:31 -0700 (PDT)
Received: from leonardi-redhat ([176.206.38.69])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd66c5e6sm1215655e9.2.2026.10.14.08.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 08:32:30 -0700 (PDT)
Date: Wed, 14 Oct 2026 17:32:26 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/5] igvm/sev: apply the IGVM guest policy before launch
Message-ID: <as-gUPOHujXsPiWV@leonardi-redhat>
References: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Mon, Sep 07, 2026 at 05:56:56PM +0200, Luigi Leonardi wrote:
>The guest policy from an IGVM file never actually made it to the platform
>before launch. The callback that was supposed to forward it ran after
>LAUNCH_START, so it did nothing and the guest was launched with the
>default policy instead of the one requested by the file.
>
>The policy is part of the attestation report, so this quietly breaks
>attestation: the resulting measurement does not match what the IGVM file
>was built for.
>
>Patches 1 to 4 are cleanups needed to get there: dropping an overloaded
>callback, moving the SNP ID block handling, giving the policy properties
>proper accessors, and adding a way to read back the platform's current
>guest policy. Patch 5 is the actual fix.
>
>One thing worth calling out: if a policy is also passed on the command
>line and it differs from the IGVM one, the command-line value takes
>precedence and we print a warning instead of silently picking one over
>the other.
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>Changes in v2:
>- Rework the callback split. Now we don't have an unimplemented callback [Stefano, Gerd]
>- Reject a command-line/IGVM policy that doesn't fit in the 32-bit
>  SEV/SEV-ES policy field instead of truncating it [Stefano]
>- On a mismatch between the command-line and IGVM policy, print a warning and
>  keep the command-line value instead of returning an error. [Daniel,
>  Gerd, Stefano]
>- Picked up RoB
>- Rebased to latest upstream
>- Link to v1: https://lore.kernel.org/qemu-devel/20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com
>
>---
>Luigi Leonardi (5):
>      sev: split set_guest_policy into set_guest_policy and set_id_block
>      igvm: move set_id_block call into the SNP ID block directive handler
>      i386/sev: convert the guest policy properties to custom accessors
>      i386/sev: add a get_guest_policy callback
>      igvm/sev: forward the IGVM guest policy to the platform before launch
>
> backends/confidential-guest-support.c       |  24 +++-
> backends/igvm.c                             |  91 ++++++------
> include/system/confidential-guest-support.h |  36 +++--
> include/system/igvm-internal.h              |   3 -
> target/i386/sev.c                           | 215 ++++++++++++++++++----------
> 5 files changed, 230 insertions(+), 139 deletions(-)
>---
>base-commit: cacd3462963a0a4f5bab4263ce79c2aa4b32692d
>change-id: 20260831-fix_igvm_policy-0b92de52dd6a
>
>Best regards,
>-- 
>Luigi Leonardi <leonardi@redhat.com>
>

gentle ping :)

Thanks,
Luigi


