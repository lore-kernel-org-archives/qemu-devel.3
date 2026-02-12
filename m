Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828E1EDF04C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 07:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqRTY-0004g7-4G; Thu, 12 Feb 2026 02:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vqRTU-0004fs-Ax
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 02:50:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vqRTS-00060M-8t
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 02:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770882652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qOvRFjuhnTRc3QDh3S9/EmKKtwVyoWkoQTnGpYdJhTQ=;
 b=ZEt9akWMfUNF6eNcjDImRbY+HPlMdVrSQ6Itsdqzb/FrqKD7a4Z0FNhK24SpIycc7KgPdl
 TDqQREdazZKJGaY1kjZ81NkFd5FmemI7Szl6VD9cxeQWquhZbhNtuCVlHyqrUkjYs7JU7c
 TpYLWrwGyOnSecBq66kcOf6bpO61050=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-dECsd7EtPCu4lzWy20YG5g-1; Thu, 12 Feb 2026 02:50:50 -0500
X-MC-Unique: dECsd7EtPCu4lzWy20YG5g-1
X-Mimecast-MFC-AGG-ID: dECsd7EtPCu4lzWy20YG5g_1770882649
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47edf8ba319so28636645e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 23:50:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770882649; cv=none;
 d=google.com; s=arc-20240605;
 b=Djsiq0nxDQ0iyCrtAY4Mv1m4uoSEuVneEhRy5AP5yafN7Iwsz+cn+uu35hqboXuzne
 Ya6njJP+HBgvTqPCcm9IIfAVD1njpkznkVoa/yMxFus+fHhsHJ/nEH/QLKW8xMqTC4eS
 Rfc6OHyiBTNfWUA26UiKsxgBf3XKqa2BzN4uyv8CBTAwGw8WoeR8uGjf5cqcS3c8Vy2t
 9qHeP2cVnsmaVZPyE6IcHOHqyCMeLCcuxbGQYeuTB4AYRMyd+L3DkCvR8/zFSpvYMtUv
 S5/PE5Qi2K/0QT4fx4tjoA2lj55cCdSDp9PeWyn6l4a0a1xq/ALuoOUo6qO/vL1xI+7C
 ilxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qOvRFjuhnTRc3QDh3S9/EmKKtwVyoWkoQTnGpYdJhTQ=;
 fh=5oOKzZrAz0d9aAIgyytgTtF15OSg2tigWcg5lE1W6xc=;
 b=EgsaoOHoRGwb6v5YvtNRMbDvWzNbqjFsPSUlHRyo6kVb6y0SrryP15W9uqONKjOBTY
 r92BDNBnj9QU/eBeHPmjZSiY7GwrZ7IYX8z8dYTNp5+/HehhqBPC89r0H6L0qKiazEol
 v8Sp03014Hmg6gecNhdwyXLKtCKPWfB9s2SN2weCC2uxP3prJAuTKJ50HfPRDAtoeze3
 rv1tgpNRWcsRxn5rUHf2SK7g4s7zdKaRnycf15K1pDvZrX9DxHN0qf0zTWDj9hLUA2MR
 4XjcgVm/g7uee3FSo5P6HzmqfxzUo47fRYSXU1b/imkG1CdZJh67tnSnKaHhfxQlYR8R
 +hGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770882649; x=1771487449; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qOvRFjuhnTRc3QDh3S9/EmKKtwVyoWkoQTnGpYdJhTQ=;
 b=GZ1W8ltIP5xgDU8zHCBam5s00ObBIFz3PTemg0xzmL8AhoVWy+G+CDdBiukSm1yBPV
 /iqJnd3OztFGgk2IPbKSHtNOTSty0qNRcyg7rP3Qj8aF2MWW/I6DM4IM6uTBNnUPrh9k
 Z7EoLT3ddVP6ZFOpzf+Q9zKbt6PblCRhhtoBy8gWeXE4YexlZS4tc4x2k3ZPgY+cWw4g
 UwVsU6wuFEFvsg56u+caKkPVbwjXnrkS0Fd+t6O44g55b4sxiP92ktRYx7RI/Ubc3guf
 /AqMmuIDbetCFxf2Xn/gsSmFalVmZV69c+sUBSQML4kMkqAdTNZxpcDuTguNzgImaraD
 RQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770882649; x=1771487449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOvRFjuhnTRc3QDh3S9/EmKKtwVyoWkoQTnGpYdJhTQ=;
 b=wXhQfojH0x4II5sPfJ0i9lnMLEu7Dp43kXeJetThRsTaKxIMkZDkFUhHmrfEIoqM9V
 cAalFdbIJ9rF7J9pDgD+IBAiLF4CIAVXH15Q2WUB7hZ+ySMtyzmwvGAFV19v0plXNhlW
 zXsWY7FC+LdV/noaRX1cM07TcQX5WQq/1M2YdVqwJB5rd70ycCTEqiSVWescRehffHHS
 ETSFWgdFNLNzjVUxL20l6gX0UGD+ctXKzqH27VHlLvrJwhW2V0bAuj0CRbDPXiQbtx0E
 ZORkBa3LzvPIQWezXjD5hKe0wXQOrOhmuCULm7QPiDWuHGh2msYWRwtUa1bplEOosOzj
 Bi8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzc7f6kXM1ypbR+ptEmwMFQ3BPT0MgAqUbCzKQH68Soi9wIYGjWdhhiaHaeKT4xj3Nyw9wETcAEMK3@nongnu.org
X-Gm-Message-State: AOJu0YyJeB0gP/ZFctgXdlly46dQZjKI6YJwiggmeDjgvG7waT4MCQZt
 qQSDh5elDotJXe6NSsiHj36aUkzji128OdBFvdI+wf25V0C0Vg8t8lXND65muNvw78/K6fCEob/
 hzSLFWj3hqyTVlWqG8whTWsG39nj25lqViJM9XQSz4Drf0rZnXkQCe9hEiwn6iOuk5k3Dl+cua8
 TXm+e6CqMmzSN/0kfXXF7KAOS5+MWGk2g=
X-Gm-Gg: AZuq6aJDvirhoap1pUjbeBNC9fDLGvrl1wpPS86WaDxGeM2UPurgYAXlN5Mi+Okbl5w
 ZrHkmmTkhT5rqooYi8tZfGBJJyBU/px7QddVCNZE8kgYbX6UmlRcMEjw7wyn4rF0xkt4Ro6pIQU
 sJwSiXF3jM5Azxeb85yswA+WCOLoMajTJIv8lk2Kyif1r93LSj8LDR+cPXrQh65bHbmr70Km2VU
 MLUToB2ROp4z63Q4viIlVlY9mMdUe2jxzw2uF94YLymRZdlIYRaRhy5M6cHnYOIjmQ=
X-Received: by 2002:a05:600c:3585:b0:480:19ed:7efa with SMTP id
 5b1f17b1804b1-48367178a3dmr18824655e9.36.1770882649408; 
 Wed, 11 Feb 2026 23:50:49 -0800 (PST)
X-Received: by 2002:a05:600c:3585:b0:480:19ed:7efa with SMTP id
 5b1f17b1804b1-48367178a3dmr18824355e9.36.1770882648998; Wed, 11 Feb 2026
 23:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20260212062522.99565-1-anisinha@redhat.com>
 <20260212062522.99565-18-anisinha@redhat.com>
In-Reply-To: <20260212062522.99565-18-anisinha@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 12 Feb 2026 13:20:32 +0530
X-Gm-Features: AZwV_QjBRWdpW4G_f3yYhxUO7DE4LNWCUoX6PV-rLcFVJtj7YapP-US9hxJwr1U
Message-ID: <CAE8KmOwa1M_F9Qfs-XXRhaJZx7jiwQDfwDk7U2shJi8SLa+y9Q@mail.gmail.com>
Subject: Re: [PATCH v4 17/31] i386/sev: add migration blockers only once
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, kraxel@redhat.com, kvm@vger.kernel.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, 12 Feb 2026 at 11:58, Ani Sinha <anisinha@redhat.com> wrote:
> sev_launch_finish() and sev_snp_launch_finish() could be called multiple times
> when the confidential guest is being reset/rebooted. The migration
> blockers should not be added multiple times, once per invocation. This change
> makes sure that the migration blockers are added only one time by adding the
> migration blockers to the vm state change handler when the vm transitions to
> the running state. Subsequent reboots do not change the state of the vm.
>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  target/i386/sev.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 66e38ca32e..260d8ef88b 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -1421,11 +1421,6 @@ sev_launch_finish(SevCommonState *sev_common)
>      }
>
>      sev_set_guest_state(sev_common, SEV_STATE_RUNNING);
> -
> -    /* add migration blocker */
> -    error_setg(&sev_mig_blocker,
> -               "SEV: Migration is not implemented");
> -    migrate_add_blocker(&sev_mig_blocker, &error_fatal);
>  }
>
>  static int snp_launch_update_data(uint64_t gpa, void *hva, size_t len,
> @@ -1608,7 +1603,6 @@ static void
>  sev_snp_launch_finish(SevCommonState *sev_common)
>  {
>      int ret, error;
> -    Error *local_err = NULL;
>      OvmfSevMetadata *metadata;
>      SevLaunchUpdateData *data;
>      SevSnpGuestState *sev_snp = SEV_SNP_GUEST(sev_common);
> @@ -1655,15 +1649,6 @@ sev_snp_launch_finish(SevCommonState *sev_common)
>
>      kvm_mark_guest_state_protected();
>      sev_set_guest_state(sev_common, SEV_STATE_RUNNING);
> -
> -    /* add migration blocker */
> -    error_setg(&sev_mig_blocker,
> -               "SEV-SNP: Migration is not implemented");
> -    ret = migrate_add_blocker(&sev_mig_blocker, &local_err);
> -    if (local_err) {
> -        error_report_err(local_err);
> -        exit(1);
> -    }
>  }
>
>
> @@ -1676,6 +1661,11 @@ sev_vm_state_change(void *opaque, bool running, RunState state)
>      if (running) {
>          if (!sev_check_state(sev_common, SEV_STATE_RUNNING)) {
>              klass->launch_finish(sev_common);
> +
> +            /* add migration blocker */
> +            error_setg(&sev_mig_blocker,
> +                       "SEV: Migration is not implemented");
> +            migrate_add_blocker(&sev_mig_blocker, &error_fatal);
>          }
>      }
>  }
> --

* 'sev_mig_blocker' is a global static variable, so it's the same
blocker (address) added each time, maybe add_blocker() should do a
check to avoid duplicates.

* Otherwise it looks okay.
Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


