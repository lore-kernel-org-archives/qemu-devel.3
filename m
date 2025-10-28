Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3051DCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 14:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDkpW-0002VM-Qa; Tue, 28 Oct 2025 10:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vDkpU-0002V8-Rs
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:37:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vDkpR-0003rs-1M
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 10:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761662254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2csqhmQgj0TzgRZV/BMFX/0Njgqa30ez/IKywPQ8x/0=;
 b=QRup+GjYU/kJSGpGKuGUwRIJzoVgeBRzAh6qnN1QlfLeq8S23DPSecNTUAuJed2AEZaDpd
 0s+sE2CH4g7HUe1Yr1GdsObgFKzLR45yO3L+EdBLPDLitwZI1gEXBeVv0mt7akMLwJ+vVB
 LlMzUBrJR6IyHCv4x9+qrWEnMgCQVtA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-_7GjSKlTONuf43O-9uI-qg-1; Tue, 28 Oct 2025 10:37:32 -0400
X-MC-Unique: _7GjSKlTONuf43O-9uI-qg-1
X-Mimecast-MFC-AGG-ID: _7GjSKlTONuf43O-9uI-qg_1761662251
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8a1ba620dc9so814887485a.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 07:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761662251; x=1762267051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2csqhmQgj0TzgRZV/BMFX/0Njgqa30ez/IKywPQ8x/0=;
 b=LMQL8eRDOUWNcltjVwQIpBGrbtN8fPddyRbCSn3+ggthydcT06kXjWfLWJdDQllGFG
 Anoukd5bnkB17gtO1tWk+lkQiURbtEfUcdbtYDA7yh+nJiHyyzX3a92Jn4lpx9omLlLD
 s4fb5QOLYZbHcYssrcN3xtg9ycEFX0Cg54G94iLI3qKsI21KPGzLaickhMr0E5brMJd3
 kkBevsR5YzmM5JWEyPoP4OhktBVElUzPd2HV/P0okG0gdkB+l6OYAHO65kA1hkeIVoKA
 y/CJrhWWWiXl8kAuK4onRZLfGgQJHsVDnIrcbkQSozl/FX9Q/m2jGMS1Z/gEDW1FsGaw
 luqA==
X-Gm-Message-State: AOJu0YzoOcGbTlv7qvpPr1y980p56nfPRz/5OI3r0CqqF/RvKs/Vj/So
 qSOV0NDzEWhZFhOokvBE1rUnc8G4vKVxcks40eLgpAgSp3DNKd5R+Th62q1YieX14GVjZwLnxTa
 J5oL0qswDuOI1pNX8y2aPvtO0GAvyHMOyEEEyqI//TQHzsnS8R7CVc8pa
X-Gm-Gg: ASbGncsrL+av1nPFo8MiKRxbAjSGjYDOM9DmqyTcERLPppd2CduI1wWglMduhPZC+k3
 +NGwj8PGOUPKwG7G7UYRi5YF27Tj48TVZ3vSbJHKUcWAWjg3SM95dirzn8noNEfvGoSML0VidQM
 1GIvk+pmhABXUlPq2UBYClfGkWqQsuFKRVnkmoYMeQDyQUZTeR57fPY2fLUZncVVoRPvt5C31KY
 PxDGXQgRHhCFGT9puk4T7qfwkIqDYHgn27ZDzjff44iqeG1NddUkJHGFaC14itSfTnX0hDy0CpG
 5IDhhpsdqWhWwKns4WcKobRykNWgcBvH3yf5hZj/otKgPSDf7YOPwb63g63+1f7YIh0=
X-Received: by 2002:a05:620a:708e:b0:8a2:da3:97cf with SMTP id
 af79cd13be357-8a7283cc700mr442323285a.43.1761662250167; 
 Tue, 28 Oct 2025 07:37:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYpSEXeUbvCNWsFp121RBpA5vzpYpCrAUYUEY7KtNG1Dkue72uoLRZQE8f6+UpBvKOKbdkdg==
X-Received: by 2002:a05:620a:708e:b0:8a2:da3:97cf with SMTP id
 af79cd13be357-8a7283cc700mr442315185a.43.1761662249438; 
 Tue, 28 Oct 2025 07:37:29 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8a8025fc8cesm119532685a.23.2025.10.28.07.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 07:37:28 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:37:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, armbru@redhat.com,
 berrange@redhat.com
Subject: Re: [PATCH v2] migration: Don't free the reason after calling
 migrate_add_blocker
Message-ID: <aQDVJ91Q2AZ3m68z@x1.local>
References: <20251024205532.19883-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251024205532.19883-1-guobin@linux.alibaba.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sat, Oct 25, 2025 at 04:55:32AM +0800, Bin Guo wrote:
> Function migrate_add_blocker will free the reason and set it to NULL
> if failure is returned.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>

queued, thanks.

> ---
>  hw/intc/arm_gicv3_kvm.c | 1 -
>  target/i386/sev.c       | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 66b0dddfd4..6f311e37ef 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -841,7 +841,6 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>          error_setg(&kvm_nv_migration_blocker,
>                     "Live migration disabled because KVM nested virt is enabled");
>          if (migrate_add_blocker(&kvm_nv_migration_blocker, errp)) {
> -            error_free(kvm_nv_migration_blocker);
>              return;
>          }
>  
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 1057b8ab2c..fd2dada013 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -1661,7 +1661,6 @@ sev_snp_launch_finish(SevCommonState *sev_common)
>      ret = migrate_add_blocker(&sev_mig_blocker, &local_err);
>      if (local_err) {
>          error_report_err(local_err);
> -        error_free(sev_mig_blocker);
>          exit(1);
>      }
>  }
> -- 
> 

-- 
Peter Xu


