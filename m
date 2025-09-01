Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728E8CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4TG-0007Xt-5E; Mon, 01 Sep 2025 09:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4TD-0007XL-QY
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:21:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4TB-0000IT-Ua
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756732871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1n1xFw6wiuhiXcN8MAT+mXcY/SJ/ImdRvxC7C94tRTg=;
 b=G62pE9TGZGsnlk+7ASrVdiEWnUw7Pq7pQ6xW9BxIOcHuyV95+FouMZPJbbsIC1gwJWQIJO
 b2dgbRDBVuaklqG6p+0Bi0bQlEI291aoLKTVe5Iq2AV7fqkxW6I2V4egqqqEwlf7qoLVvt
 e2/9oSX3+Ss1gsCF+GT/sM/XhfzwgsY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-Eym7ehU0MD6wVuIUuKevjw-1; Mon, 01 Sep 2025 09:21:09 -0400
X-MC-Unique: Eym7ehU0MD6wVuIUuKevjw-1
X-Mimecast-MFC-AGG-ID: Eym7ehU0MD6wVuIUuKevjw_1756732869
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b33e8943e3so3673491cf.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756732868; x=1757337668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1n1xFw6wiuhiXcN8MAT+mXcY/SJ/ImdRvxC7C94tRTg=;
 b=gSgvQQSZ4hOvN+BVlSdnxoK3WQuKTqXBsMtikxqMhxq/CxPNVXXqVDJJ3UxKgK3hUJ
 rQn04KtxW8dBywhSVC+co2JZ0EYc2QIEbd5Bt+QLlRlcvEOIFGYURY8vKnkyihcaGBPs
 /71wqtrvMvGNQoJTChfUTg2UlWUhmnQFSPoG7u+9OLwB4TscMr0IGtCQ/ThqZitCwxBi
 kV3XyfU5ZAIFVzdVucmtiZalB3/5nnTCGGjhl5lRFHRQ+g6x/0tGGKUYnEW+7+PcGm3x
 HyVZQmPZe2dTE0HRSJTzKjYevPxcwpbUBzDWxlFhAGXaWF99b1LRCivWCkYAoC2VI3sc
 ckGQ==
X-Gm-Message-State: AOJu0Yxgb6UQOuWmhllHD0TcXicWt1hZti/qMeNlHOi4XpKm789cjyAI
 9YVT00Pw4zgA1D5o2nR1jPTjH+9mK+8KVRshWicku1lOxHdUrU3RvXMcowyqD3jyIs97ubIYWYF
 5762oRDeg8gkZ7UrI01QXidpXPKV7wFQO8EA6C0DN7WOME+7obbrEF3Rb
X-Gm-Gg: ASbGncuKu+N3ZulWrSG68Iace417WrEmLGGIcGRnK+AzjfC5ZclOzTVe04edy7ZofiD
 MTZRWclsxkNB5kwJvEwy10qzMYJZdoceUWfYfcTVx9QXRQyAfXMhhZZm2VsysoxUD7eed09deta
 Ui0rq2SK5ZStubTNw2QrwnpgywFWK6U54x9WromAmHXE3V4qalgF/TtmrXGH1fHb/fNDXBOB3kd
 EI7OFtqYMzzo2CDzNN7wj8XE64Tov9fOPELr0My7heFqUxL8BkRnwwaKpkCOKeNj+xAn28bRUht
 vdbYhXSFQmZxnLv25FrP80Mf4kQA7w==
X-Received: by 2002:a05:622a:1b0b:b0:4ae:cc29:829e with SMTP id
 d75a77b69052e-4b31dd22bddmr84863781cf.59.1756732868626; 
 Mon, 01 Sep 2025 06:21:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCLe6F96kwsGN2ERR2udc37g0M+KGzyab9eEbn+LGAykyRscL+Hxmj6EFXCTZWq5y9qEkuog==
X-Received: by 2002:a05:622a:1b0b:b0:4ae:cc29:829e with SMTP id
 d75a77b69052e-4b31dd22bddmr84863421cf.59.1756732868221; 
 Mon, 01 Sep 2025 06:21:08 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b31991d3a4sm45660811cf.45.2025.09.01.06.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 06:21:07 -0700 (PDT)
Date: Mon, 1 Sep 2025 15:21:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH 12/18] accel/tcg: inline cpu_exit()
Message-ID: <20250901152103.385d2778@fedora>
In-Reply-To: <20250829153115.1590048-8-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-8-pbonzini@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 29 Aug 2025 17:31:09 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Right now, cpu_exit() is not usable from all accelerators because it
> includes a TCG-specific thread kick.  In fact, cpu_exit() doubles as
> the TCG thread-kick via tcg_kick_vcpu_thread().
> 
> In preparation for changing that, inline cpu_exit() into
> tcg_kick_vcpu_thread().  The direction of the calls can then be
> reversed, with an accelerator-independent cpu_exit() calling into
> qemu_vcpu_kick() rather than the opposite.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  accel/tcg/cpu-exec.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 9241bcadb5f..3ae545e888f 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -751,7 +751,16 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>  
>  void tcg_kick_vcpu_thread(CPUState *cpu)
>  {
> -    cpu_exit(cpu);
> +    /*
> +     * Ensure cpu_exec will see the reason why the exit request was set.
> +     * FIXME: this is not always needed.  Other accelerators instead
> +     * read interrupt_request and set exit_request on demand from the
> +     * CPU thread; see kvm_arch_pre_run() for example.
> +     */
> +    qatomic_store_release(&cpu->exit_request, true);
> +
> +    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
> +    qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);
>  }
>  
>  static inline bool icount_exit_request(CPUState *cpu)
> @@ -780,7 +789,8 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>      /* Clear the interrupt flag now since we're processing
>       * cpu->interrupt_request and cpu->exit_request.
>       * Ensure zeroing happens before reading cpu->exit_request or
> -     * cpu->interrupt_request (see also smp_wmb in cpu_exit())
> +     * cpu->interrupt_request (see also store-release in
> +     * tcg_kick_vcpu_thread())
>       */
>      qatomic_set_mb(&cpu->neg.icount_decr.u16.high, 0);
>  


