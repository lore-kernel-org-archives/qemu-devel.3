Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00678C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 17:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkoIH-0007U5-Ju; Wed, 19 Feb 2025 12:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tkoIB-0007TY-Pc
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 12:55:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tkoIA-0001Ih-02
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 12:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739987725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ja272GOSac81WNMuQ/dxI36+9cjnhmMdrmPs6R3fh9w=;
 b=G3yjZWZipGerUQA1kwjASY3PjtZuIkNWD7mz8neLT+CkDnNRYd9OK6xwJ1EbhWG5oqw7d2
 iHm/RgAs3wTxXUAo4sODErilH0NjITsgnX5qd44TVMnfqdn6fhGQvnIvLT9yWz4a2Xpu6Y
 cLgnjpA+C6BZ51bpkaKsP3umqvLMl3I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-qHj4FEW0PUOV2ayZxa-D6A-1; Wed, 19 Feb 2025 12:55:22 -0500
X-MC-Unique: qHj4FEW0PUOV2ayZxa-D6A-1
X-Mimecast-MFC-AGG-ID: qHj4FEW0PUOV2ayZxa-D6A_1739987721
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4399c32efb4so4570105e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 09:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739987721; x=1740592521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ja272GOSac81WNMuQ/dxI36+9cjnhmMdrmPs6R3fh9w=;
 b=t1dNX6vFmGejHoaCmvwgzOQnaCCUpWih1pjlwel73GdPNBHVAljI2P+MhWT2esFa/E
 lsi8oDSJoYir3tgxcsrP7g4Dt5MHcQp0lRFxWiQNdKMct9A0Q7RRehi6cgVxdZH+GK6I
 GSbh+Jt5vTvdB0TCvniQJd5T5POUZqXj+0pi1/ObYUK7qxLO8qj2ZNfM/ltOc3Dfj7mi
 m6JwFOJmW04awyHxUBB1tYvLVgTukbYdhScTQRH4pgG4F5umG2rpgXvVybLm+bS8bdJ1
 Z5U4YJtFl0MsxUjEYpeMC3M2HvUaiw5n5b1NsBDl4LsCr3m0CaI0saJiT52cquex/P9Y
 Beeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZfA1n7g3ijVj6aQHeePZ/BHaLRm6dr2/Eo64vTJkPYlUFtYW38J2GKbL3ybJpgQOm00dU0ePG6li5@nongnu.org
X-Gm-Message-State: AOJu0YxiH0zWQKtm+CK2j8br4vEl6h3vILaJooat8G3+1N6gSn0nrlp6
 oetZQuZsnl5o3LQfcd+wZAKsWeTiJiuFQtGT0CNrnNgyW/Hqh9XaeKYujpvH3L+MNIyaNlA8JwQ
 Poi85dwMGcMFcO9lJk2S+PRx7g7Nz5F9QZO5XwMuvP2lxCBSxlENT
X-Gm-Gg: ASbGncsjYgwlPsFwafzIraOLCEOSD8wB0R6JHn+Ope5SkK+2rj/fzle3nv33tkp4LEz
 JsLFyIzCL1CGn8Rl981M7u4tO+W2CCvb3AwREVNCrDzWGVndrYG3hWlyIVK796AbumfPl9uQDN9
 0WVhdo8XeMp/Q1QKpPkNGjL3LBlnvjOMNUJs/09ZEaFWBp5QGdH3JBdFMru8n/6mQy7CnLdVVMh
 LkbuFTCxB0yaavatyKkop/6NK+7Ukl6S3pTneHUGkC8B9C3BCLEvn1f6Pz+wTMbSu+EvAAMRsvJ
 PKkutVBoMYt6Uo534Eh2jWm6wYojJpUd2dRlO8C2dw+xPX54mRkC
X-Received: by 2002:a05:600c:1c9d:b0:439:968b:6669 with SMTP id
 5b1f17b1804b1-439a2faf7d8mr1777185e9.1.1739987720822; 
 Wed, 19 Feb 2025 09:55:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4gUGDkqJYO809rE4EgPcbnx2pLboOtSx2NX5AORYgafRgmx9zKDfWGzSBF4CcimQNsT9RMg==
X-Received: by 2002:a05:600c:1c9d:b0:439:968b:6669 with SMTP id
 5b1f17b1804b1-439a2faf7d8mr1776915e9.1.1739987720417; 
 Wed, 19 Feb 2025 09:55:20 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7fe6sm18117958f8f.86.2025.02.19.09.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 09:55:19 -0800 (PST)
Date: Wed, 19 Feb 2025 18:55:18 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 4/4] target/arm: Retry pushing CPER error if necessary
Message-ID: <20250219185518.767a48d9@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250214041635.608012-5-gshan@redhat.com>
References: <20250214041635.608012-1-gshan@redhat.com>
 <20250214041635.608012-5-gshan@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, 14 Feb 2025 14:16:35 +1000
Gavin Shan <gshan@redhat.com> wrote:

> The error -1 is returned if the previously reported CPER error
> hasn't been claimed. The virtual machine is terminated due to
> abort(). It's conflicting to the ideal behaviour that the affected
> vCPU retries pushing the CPER error in this case since the vCPU
> can't proceed its execution.
> 
> Move the chunk of code to push CPER error to a separate helper
> report_memory_errors() and retry the request when the return
> value from acpi_ghes_memory_errors() is greater than zero.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  target/arm/kvm.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 5c0bf99aec..9f063f6053 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2362,6 +2362,30 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>      return ret;
>  }
>  
> +static void report_memory_error(CPUState *c, hwaddr paddr)
> +{
> +    int ret;
> +
> +    while (true) {
> +        /* Retry if the previously report error hasn't been claimed */
> +        ret = acpi_ghes_memory_errors(ACPI_HEST_SRC_ID_SEA, paddr, true);
> +        if (ret <= 0) {
> +            break;
> +        }
> +
> +        bql_unlock();
> +        g_usleep(1000);
even with bql released it's not safe to loop in here.
consider,
  a guest with 2 vcpus
    * vcpu 1 gets SIGBUS due to error
    * vcpu 2 trips over the same error and gets into this loop
    * on guest side vcpu 1 continues to run to handle SEA but
      might need to acquire a lock that vcpu 2 holds

GHESv2 error source we support, can report several errors,
currently QEMU supports only 1 'error status block' which
can hold several error records (CPER) (though storage size is limited)

1:
We can potentially add support for more GHESv2 error sources
with their own Read ACK registers (let's say =max_cpus)
(that is under assumption that no other error will be
triggered while guest VCPUs handle their own SEA (upto clearing Read ACK))

2:
Another way could be for QEMU to allocate more error status _blocks_
for the only one error source it has now and try to find
empty status block to inject new error(s).
 * it can be saturated with high rate of errors (so what do we do in case it happens?)
 * subject to race between clearing/setting Read ACK
    (maybe it can dealt with that on side by keeping internal read_ack counter)

3:
And alternatively, queue incoming errors until read ack is cleared
and then inject pending errors in one go.
(problem with that is that at the moment QEMU doesn't monitor
read ack register memory so it won't notice guest clearing that)


Given spec has provision for multiple error status blocks/error data entries
it seems that #2 is an expected way to deal with the problem.

PS:
I'd prefer Mauro's series being merged 1st (once it's resplit),
for it refactors a bunch of original code and hopefully makes
code easier to follow/extend.

> +        bql_lock();
> +    }
> +
> +    if (ret == 0) {
> +        kvm_inject_arm_sea(c);
> +    } else {
> +        error_report("Error %d to report memory error", ret);
> +        abort();
> +    }
> +}
> +
>  void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>  {
>      ram_addr_t ram_addr;
> @@ -2387,12 +2411,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>               */
>              if (code == BUS_MCEERR_AR) {
>                  kvm_cpu_synchronize_state(c);
> -                if (!acpi_ghes_memory_errors(ACPI_HEST_SRC_ID_SEA, paddr, false)) {
> -                    kvm_inject_arm_sea(c);
> -                } else {
> -                    error_report("failed to record the error");
> -                    abort();
> -                }
> +                report_memory_error(c, paddr);
>              }
>              return;
>          }


