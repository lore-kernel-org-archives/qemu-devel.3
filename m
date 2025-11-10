Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22378CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vITFa-00048P-Vx; Mon, 10 Nov 2025 09:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vITFK-0003l9-5Y
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:51:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vITFH-00007S-Ru
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762786309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rvt+30g98YUK3RqNruQMpVntwkIfzfc8fcDCvUUlJBI=;
 b=hn7KiR8CV5JYrCzqp8p0C+tID4hCgfs70dya8IK13VjxtwxH7Uj7BXvxkgQ96ZbJEBMlne
 dPfF7TkLGNcqpL5/V6D7lwA57Os4vb0jhU8wJ+fkSHNjyoaDJUztMj14Grrj8fuOeUvzsE
 VHgXBBDcLlPFcbyPzmgVR1HQ4NnUSyE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-pj-td_dUPnaVwlzgYMRHPg-1; Mon, 10 Nov 2025 09:51:46 -0500
X-MC-Unique: pj-td_dUPnaVwlzgYMRHPg-1
X-Mimecast-MFC-AGG-ID: pj-td_dUPnaVwlzgYMRHPg_1762786305
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477792eb8e4so11572155e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 06:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762786305; x=1763391105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rvt+30g98YUK3RqNruQMpVntwkIfzfc8fcDCvUUlJBI=;
 b=lvi7wfpJnZDjvIxsVd8t0Nntk3UdHkYc92ZwsLq12cujH8a8uTXeKnSBe/uxYuffN9
 2HDVdi3GHRTJLNncj8HK/eup3CFs4KCD5jBZDxJ24tIY0UZdUVd/f0VSBQOSIjcUhj10
 ODPRCG+5rBHN91nvue0k/vMuX8m6FuJZZ6zMzMORQN0oTf8HQ3lKKjz9XsBtwDvmcdI2
 xGj3INV6AJehgEsoNj1VyUsFHED6S5CObph0IKIVR/vdLZqoc/JiBSnR91k1xw7uebZ5
 lBSInYAOG8rwjsrqnwO+xXOR9x0+bwYO89LO6y3WTNRxK0C6t/bpZ9y3+T+1g5amA9Eq
 P3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762786305; x=1763391105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rvt+30g98YUK3RqNruQMpVntwkIfzfc8fcDCvUUlJBI=;
 b=llyolMB7sBDwtjt+dOljDqMDkQ90p4I/DjL+nfJtbqkXAdVTntmOu/WdtaxcLBCjOF
 4iakmsp7E49s2eMFz8Z6lTT/yH8zEnBn+73t/Mc37NUTzOPUqWNLN8Q1V0fKdKBb204b
 oj+UoGRN39AjPz59sPYT3CiEbAe8q57GTnxow6i8vvifpQWt/hjqfZ/4aoxyNlqAeWPe
 SIHz1Rp+RN/z+BBmy/vaTjrPGyVrEpd3afeKk84rdwBmKp5yhYL3YrRiKdotXXynk6Ni
 WDBQo5gKaK6XDI4ODeCoaRs3HHKZAVBFimOBTghPitkey07shN3V2PoQZOgRfyBk+stm
 liJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZb0xS3Xecx1+95iuNJAEWvOFwwCRuCCoxEGr7wvfeNAIh1F1W7m+pKaaxnXFpDmw9ySAlSwHRfkqz@nongnu.org
X-Gm-Message-State: AOJu0Yxx7t/ma6bq2ZhuWUqGRhFVv4Wq6Jc6vyrZhcrOQA3bHmsty3J1
 rGedd1xejlhIvAn5XS28DJ9WRrLYImm624/TKTajaKbIhfiaJ7SF5RdBN4WvICOGc76JKbs7APY
 8VAjw3pFuZmj/E/opn7sb/H99gDUvzJdjwHr34DPFFuTFjLZ0JLcelWcb
X-Gm-Gg: ASbGncuXf2qYBS5HRgkOSlFXcfsJSz8CHJHSf3nOkcTO8C0OCfbFM+/svt8iN9nu0Ib
 56HTFnFJP98Tw8U22foSIYsvjfvq+z2jgXPwjNALu2PMhHMHO78Ouw8xcVLhEa9bWBCbVMRD6Nm
 7+kvmevCF+xCqlu9JzXUAqp/ACyrwJuzweUY6kyY8N4qzlIIwBpVy8l9QVx1P4SocUs7puuSvdW
 VObfTwZhvQaxCJkJq0V+8tPzfyKiupJFy01YB6ihToTASAeN6zzLMunGB9MRf3CYZH6ijvgNTDV
 HL9vq+gb9VgF8kKGCDH0polnEypAxhCPAAZYFcMhtENCfWGsB3AQrLjqRI2UqqC3lQ==
X-Received: by 2002:a05:600c:358f:b0:46f:b42e:e38f with SMTP id
 5b1f17b1804b1-47772e04085mr94272965e9.19.1762786305141; 
 Mon, 10 Nov 2025 06:51:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7GqgfYJ/EzdUQOsp0/nA/yOyOV2b2aOwop4yVpvkvYTJzL8k7JThQ+PtYjCIOYtcSmZL3aw==
X-Received: by 2002:a05:600c:358f:b0:46f:b42e:e38f with SMTP id
 5b1f17b1804b1-47772e04085mr94272635e9.19.1762786304751; 
 Mon, 10 Nov 2025 06:51:44 -0800 (PST)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4776bcd51dfsm207584995e9.5.2025.11.10.06.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 06:51:44 -0800 (PST)
Date: Mon, 10 Nov 2025 15:51:42 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 shan.gavin@gmail.com
Subject: Re: [PATCH v3 5/8] acpi/ghes: Bail early on error from
 get_ghes_source_offsets()
Message-ID: <20251110155142.6408a7d1@fedora>
In-Reply-To: <20251105114453.2164073-6-gshan@redhat.com>
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-6-gshan@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed,  5 Nov 2025 21:44:50 +1000
Gavin Shan <gshan@redhat.com> wrote:

> For one particular error (Error), we can't call error_setg() for twice.
> Otherwise, the assert(*errp == NULL) will be triggered unexpectedly in
> error_setv(). In ghes_record_cper_errors(), get_ghes_source_offsets()
> can return a error initialized by error_setg(). Without bailing on
> this error, it can call into the second error_setg() due to the
> unexpected value from the read acknowledgement register.
> 
> Bail early in ghes_record_cper_errors() when error is received from
> get_ghes_source_offsets() to avoid the exception.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 527b85c8d8..055e5d719a 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -513,6 +513,9 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>      } else {
>          get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
>                                  &cper_addr, &read_ack_register_addr, errp);
> +        if (*errp) {
> +            return;
> +        }
>      }
>  
>      cpu_physical_memory_read(read_ack_register_addr,


