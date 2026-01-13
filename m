Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF5BD29DE4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 07:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfYtk-00088n-0D; Tue, 13 Jan 2026 02:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfYtR-0007x4-GO
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:32:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfYtQ-000753-1i
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768289563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=R3Ed+U/fiFRB/U3BqH1BZm6DUUK7kuwxjLUTVr12wzs=;
 b=gLS4MCPdxE/rmSTvcZsw+6oCEPT12N0+Y3boIt85rETGxqWnp6Ooy6Dkwys5Ozke4evxMm
 xIJXU0EeTjrIuMw5UoWq7F3u/aOPb3TSbcmQKkr2Bn2kyg8gEkjOM/jZn1kzDfLD0YRmaT
 Q5JOLBvVwkDZi+vTsHgtbb7FodhUvME=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-nrORIC_uOq-zpg32noEuZw-1; Tue, 13 Jan 2026 02:32:40 -0500
X-MC-Unique: nrORIC_uOq-zpg32noEuZw-1
X-Mimecast-MFC-AGG-ID: nrORIC_uOq-zpg32noEuZw_1768289559
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-432a9ef3d86so3770892f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 23:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768289558; x=1768894358; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=R3Ed+U/fiFRB/U3BqH1BZm6DUUK7kuwxjLUTVr12wzs=;
 b=cru9Gu2D7ymkreuGcL6CkOC2y9+USW2NSzvLWJ1Ag2V2Pida9rCyjzeiAB3XEmW3Vt
 RQLqHg65JYaEd6T0HueE3abMdqr3qZYxFPFvbnIBO305VsgE65UckSo0jWkRRdDbh9TS
 gXMLaIFW9m2ccOR3SJDC/igbImPv8T5vSnX4nzJrPRLLt0nMQ5gSpBrkJclxWd/2dcZ8
 TuWnYwz56XphuTau2QEtulkKdri1vsHQu+/YOhQlsBNMTXu54MySPj1XynohWmQgrVhU
 rnnyHl5aH8qlTkHIkNb1EL2CE/w7lgvMiEgRDfV77BuI2PBJTuU3rkXjQg/E3S0Je3t+
 a3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768289558; x=1768894358;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3Ed+U/fiFRB/U3BqH1BZm6DUUK7kuwxjLUTVr12wzs=;
 b=wEf7E809UsIZ6Onc01jjThTSfq7bBZnxedCX2dJnH2vxhYxGdkiqRSqt4Q6+8wvZin
 1JKiwKL2/z7AgfKPIq4FvTWGWdw2OU3gMkEXB0+JgdG+gPsLAX80q5d30jdGRxq8+1oY
 HKLQ9gAqXBDDvQrVaVYmMaYO8lpynlCeGl9JqG0qn01j1BhYyxIE38QLFU3EPK0yVDQE
 bxImA5zum4JL7D0gDvdkUD41cd/HJvPr7MAtqSpoKls8mQUSjCjNYMwxvyk1uPhZEVFd
 23suTg/7kqxo/n9sx5IPGEdi4/eo/mMyErZMvPz0kO/KudCmlcF6Pt8ORUnp6PFc6RKX
 h7Ug==
X-Gm-Message-State: AOJu0Yzca8ljaUhaVESVeWAszK1/HquOZzWVqZ8n7ECa3TXd1KSQ7PDZ
 aEpOnFPLrvV/FjVjGqtJTHa+E75BmG3+3Uk6vmlgUqYkUO7Kdnslmz3ZPWdEuNTmrd6ZCq+jzWA
 HP7S0ZltXf8zXlVs3wMr9joaJQkMVCwx3RBOAkGz2yVEgJj/K+0OnSC8Mgx85CTW9tx00AM5f7l
 //Lsx+SAV2G/IYHBLSv1u/wQLqCW8VTdwEbA==
X-Gm-Gg: AY/fxX5sZg8GcDz9KR9DGVMFmK7I4hRWoO0gYQAF5i8CFVJnlTDirIUqEpfWy8bpSp9
 ZDxvfllUewolFUEbT2ZN3R5TlYZmZtEb7/p2JmFSAXG3f0ncJvtygHgCRYKnHQECWM7UEItobtW
 7MXYvAhwGsX41YP3OLHIs0gPo+Aye0NS+Ijpg1Hm6KbwSgvR8GquDbBNphKYEvdGndI7MiNMIHy
 IwRq1nWDIJsqcF9EWgSjNnymSz98lkPUWIxZ8wYS+Chs7my3OtPeXUDfpO4UgFxw2O9qWL72NKo
 7p0jWkE/T4Vbd7kDCmxxmcbESxMeqhUNa5yVn+cK0BqdL3xt5ETOS6Of/G/jp3/BE9tHBxbd+SP
 +7fl0XGGqkNn2vKrGZFsOkklyfCkkdqnQf3dbt3/K0n99kCJa
X-Received: by 2002:a05:600c:1392:b0:46e:4586:57e4 with SMTP id
 5b1f17b1804b1-47d84b32ef1mr242493015e9.24.1768289558123; 
 Mon, 12 Jan 2026 23:32:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBFblkaFqk3ZGIktPEbSFL9d+KBTH6aM6Z7lMcohn1HbwPDMoF7SW7DoQUyvfnmYyj8BYBwg==
X-Received: by 2002:a05:600c:1392:b0:46e:4586:57e4 with SMTP id
 5b1f17b1804b1-47d84b32ef1mr242492715e9.24.1768289557568; 
 Mon, 12 Jan 2026 23:32:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653c61sm398591445e9.10.2026.01.12.23.32.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 23:32:37 -0800 (PST)
Message-ID: <85b04a6f-9fda-45b5-ba69-ca5cc7b6abc1@redhat.com>
Date: Tue, 13 Jan 2026 08:32:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/rcutorture: Fix build error
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260112163350.1251114-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260112163350.1251114-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/12/26 17:33, Cédric Le Goater wrote:
> Newer gcc compiler (version 16.0.0 20260103 (Red Hat 16.0.0-0) (GCC))
> detects an unused variable error:
> 
>    ../tests/unit/rcutorture.c: In function ‘rcu_read_stress_test’:
>    ../tests/unit/rcutorture.c:251:18: error: variable ‘garbage’ set but not used [-Werror=unused-but-set-variable=]
>      251 |     volatile int garbage = 0;
>          |                  ^~~~~~~
> 
> Since the 'garbage' variable is used to generate memory reads from the
> CPU while holding the RCU lock, it can not be removed. Tag it as
> ((unused)) instead to silence the compiler warnings/errors.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   tests/unit/rcutorture.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/unit/rcutorture.c b/tests/unit/rcutorture.c
> index 7662081683f5d781da74402113b73884780b1243..2f19d479a3f210cbca19205a0656eda1f4c2e5a7 100644
> --- a/tests/unit/rcutorture.c
> +++ b/tests/unit/rcutorture.c
> @@ -248,7 +248,7 @@ static void *rcu_read_stress_test(void *arg)
>       int pc;
>       long long n_reads_local = 0;
>       long long rcu_stress_local[RCU_STRESS_PIPE_LEN + 1] = { 0 };
> -    volatile int garbage = 0;
> +    volatile int garbage __attribute__ ((unused)) = 0;
>   
>       rcu_register_thread();
>   

Applied to vfio-next.

Thanks,

C.


