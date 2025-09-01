Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA28DCA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4ey-0001yq-QX; Mon, 01 Sep 2025 09:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4ex-0001tn-He
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4ev-0002Gt-2M
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756733598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YBk2BeE8GpTsP3FQQicRdhMQ9033UMCS2anERI8LpEg=;
 b=N58hJWLcbHNz2nw0xThWfry0Hp91tcgeD+yievw47EYHXwDACv2xmLQp5t81K+8As0EwD2
 dr9sgH3AKNw8EM/U/8OVYoBAW1EeEc+go0v/rN/JrxJRfc8kr4o068Lyv9ujBESX/HFnB3
 2RojVncuZPjBam3Yjg9+xf2qrUWlf2A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-jXkftrD1Mwau8xo99DOTfw-1; Mon, 01 Sep 2025 09:33:17 -0400
X-MC-Unique: jXkftrD1Mwau8xo99DOTfw-1
X-Mimecast-MFC-AGG-ID: jXkftrD1Mwau8xo99DOTfw_1756733597
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-70de6f22487so82087266d6.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756733597; x=1757338397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YBk2BeE8GpTsP3FQQicRdhMQ9033UMCS2anERI8LpEg=;
 b=jHOIEwQdpdrpkuzhMz2QxzhYZIVF2siO8uPf/3vCV4nkAqrt7NURTL21U461Cjsk08
 dDjC/GmU7RSdEkZrPRVDHXYvHXhYXYHsn9sm8ykpLi+tFl5cPHouuP3bInDHT8djV+Jw
 zznmkkdHWQOYD+ncWpLZY+U4YDYryddpQEyJD5Q0Q87zH43vaGwVtfBbNJQrlKZKKGTz
 D0zHyie4OV2odTfIOrZqg5a1tJUUYs69mUA4yHkEzJsSfWSOyCTeH2thWbf28lKR9Sz8
 rG0VYS2ELTXduiaBAYqDlafNGTIdqdb+gQx410UdNyxuhEIu5vui7T4VJoM01R1jw1Ed
 5A3g==
X-Gm-Message-State: AOJu0YwyBT3FJDv3uRIPyAp3FZfeh7RTeMaqCXb+zA6dOpgJKZcPVY9e
 uQegwx43fBArBatBMDtKC3V4sNgghpOsw7+Y6s8+1eXcwTelkl1F04XFpyEre2RI6TJj/WmRmNB
 IzmqwV8UjLIT045q3ngjwyCx6moRMr8MNLNzZt4JKppT5iJm3Hp2emnNw
X-Gm-Gg: ASbGnctf2Mj7qcIm0bNMXP98w8wysVTgZUKPQcQC01Y4piYWrd5wPSj59sRQcd3GdVy
 OpNmz14DdrYKB4677aPuxwLckLLG+eeTlEERr6JbR/hpA/DovSBPpfU3iXn1l3xTUbQ2PqJXW3j
 Dx5Cge+j5i+ysV5LQOTYsm/AbLT4JOI2y60uaw5SX1dVlWecLHk58zFh39ij71bmo8C8a33a0l7
 KrsTLKGia3qBk1T7riNMyQmn/ET2MWW6z4J7l9q+vYWHm+qPqLxy4091t1HzNTIHkN4+O7SQEB4
 FkVy4OZYxPN2K0PqOm/0GN5GnV6WSA==
X-Received: by 2002:a05:620a:4045:b0:7e9:f81f:ce77 with SMTP id
 af79cd13be357-7ff2d1a13c3mr744977185a.77.1756733596981; 
 Mon, 01 Sep 2025 06:33:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLz4jiUYrYwnai7l956s+ssDw7jXQwS/9eGKPSBEcr3LgFuVIAh929f+IZ9bGcjXD1QqHqjw==
X-Received: by 2002:a05:620a:4045:b0:7e9:f81f:ce77 with SMTP id
 af79cd13be357-7ff2d1a13c3mr744972085a.77.1756733596387; 
 Mon, 01 Sep 2025 06:33:16 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70fb2837f9esm39704426d6.48.2025.09.01.06.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 06:33:15 -0700 (PDT)
Date: Mon, 1 Sep 2025 15:33:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH 18/18] tcg/user: do not set exit_request gratuitously
Message-ID: <20250901153312.5f5a793e@fedora>
In-Reply-To: <20250829153115.1590048-14-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-14-pbonzini@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Fri, 29 Aug 2025 17:31:15 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Whenever user-mode emulation needs to go all the way out of the cpu
> exec loop, it uses cpu_exit(), which already sets cpu->exit_request.
> 
> Therefore, there is no need for tcg_kick_vcpu_thread() to set
> cpu->exit_request again outside system emulation.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  accel/tcg/cpu-exec.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index ad94f96b252..7c20d9db122 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -751,6 +751,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>  
>  void tcg_kick_vcpu_thread(CPUState *cpu)
>  {
> +#ifndef CONFIG_USER_ONLY
>      /*
>       * Ensure cpu_exec will see the reason why the exit request was set.
>       * FIXME: this is not always needed.  Other accelerators instead
> @@ -758,6 +759,7 @@ void tcg_kick_vcpu_thread(CPUState *cpu)
>       * CPU thread; see kvm_arch_pre_run() for example.
>       */
>      qatomic_store_release(&cpu->exit_request, true);
> +#endif
>  
>      /* Ensure cpu_exec will see the exit request after TCG has exited.  */
>      qatomic_store_release(&cpu->neg.icount_decr.u16.high, -1);


