Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DFCCA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 05:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwDiz-0004uS-5V; Wed, 10 Sep 2025 01:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uwDix-0004uD-7B
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 01:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uwDir-00025j-R8
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 01:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757483420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MjShFlni77G2XephMLf8gjBgFZsxqzf9kUzFxYltnKI=;
 b=OicJh3/akUF4J8tzD2OKv9MU8tFWR4UwQTYq1gr6hNRNHG3sf3nUaECp+zogIdN5eLfjOV
 MEK/36VgQf4e8tJKBkvs+sWbqyd0SYXTZsTfroFF5q1nVjsTkC2rFC6aYT9P83Cf3kd8kN
 +sExjkEPGjlfppAYMXj4PIKfWaHWsYA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-NabI1dwFMvqTQZDzmlLYIg-1; Wed, 10 Sep 2025 01:50:17 -0400
X-MC-Unique: NabI1dwFMvqTQZDzmlLYIg-1
X-Mimecast-MFC-AGG-ID: NabI1dwFMvqTQZDzmlLYIg_1757483416
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-62716b5b7baso3113996a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 22:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757483416; x=1758088216;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MjShFlni77G2XephMLf8gjBgFZsxqzf9kUzFxYltnKI=;
 b=c9ZEv91n/sV7/E+c53OdVteTcqPwT2tW43gxm3iy1b5fKaycIOv0SQhcX0CHCj9G1s
 ifYjzH9gAHS4gHwDDw0ww7AmzeQ9wi9TIVOeOy03j4PXovEF41QA3hK+RgWtjMd9WOOI
 qPy9/xpenleL/xQ2sImkLOpVD1l59+yOZPoL4hmLnNpdqqfOFKlOcqfwmuM0Sy4h82Wr
 B6oGhLI2Q1XsOnyFaMMRS7q1rEhMRnDsF/oCKxgLOLpMnFeHhyW46buX6AEMb7yzU6TA
 imBNsjJyWQG+oguT8Fvc0Uvj57+Is4R1zGxcu/376BcpK9M6e1PfXuEpb9K1f8mVDkFO
 xtRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2XnJyIOp6jbKqjT0TExRU4rAwxBykeEapYJQ+kBqd3iMICwlokQimsYyT3fYEsvYe00/PMJ1cokig@nongnu.org
X-Gm-Message-State: AOJu0YxkdKOy+bmbAv2LgySpdE59I2REBHUfJBun+Gql2o4DetG0sov0
 EhNfqd2ARS8j1Tbxd+DyTdJyJkz/tNBPnJUWy88pO+2y+ee1AvHtZ0rMdhCVd99mvfUfl9F747I
 kpMcRi1jUM6rHs2czpiVktBX++LxfPCBZDcxgX3R6rBc424l/MeUse6UP
X-Gm-Gg: ASbGnctUStbfiveCyBFjApDHi/PRRZr4/Kdr8Hw8JxeSVkA4QgOeuxg0GPiL2mOBXJF
 jNw7SLKFQ4NQTYT930mrIx2SeS6OEcBsszqLrkWzVRHzxaZJevICrf9J8TJFcx9GgtzQqhyIUBu
 FzirO4SqQP020S6mRFOO0SMOUxHOy/VNmJQZs6jhtq1ABjthqq81djUhsiOIyVFkvLc/sP8IZPD
 oUXnX4cu9BZAYyPr0u/ZF4TAdxKRfRZc/7PgqwW2dAmC6SaOmQQuY3FZufkMqqu+8PqpLGh7mvG
 4JVlviSMJCSKgd/vcUE26fi4mVusANGyoVj9YWdUb77HrQauEMkD2fXytfA917EMP8oDp3Nxdkn
 rtDkVTg==
X-Received: by 2002:a05:6402:3512:b0:627:d77e:c346 with SMTP id
 4fb4d7f45d1cf-627d77ec6a1mr10087033a12.23.1757483416224; 
 Tue, 09 Sep 2025 22:50:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIX5h69Oyc63LNgzKPFxYv/VXEkTfnJJRUXv7wytvFMjMmXT5L9f2uxasmdXlrghVw4OySpw==
X-Received: by 2002:a05:6402:3512:b0:627:d77e:c346 with SMTP id
 4fb4d7f45d1cf-627d77ec6a1mr10087006a12.23.1757483415794; 
 Tue, 09 Sep 2025 22:50:15 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-183.pools.arcor-ip.net.
 [47.64.113.183]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62dcb9f427fsm114875a12.10.2025.09.09.22.50.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 22:50:14 -0700 (PDT)
Message-ID: <23d92164-5f1c-4905-a2c9-12ae2db580f5@redhat.com>
Date: Wed, 10 Sep 2025 07:50:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/16] target/i386: implement TSS trap bit
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250512190524.179419-1-pbonzini@redhat.com>
 <20250512190524.179419-11-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250512190524.179419-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/05/2025 21.05, Paolo Bonzini wrote:
> Now that we can do so after the error code has been pushed, raising
> the #DB exception for task-switch traps is trivial.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/seg_helper.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
> index cb90ccd2adc..071f3fbd83d 100644
> --- a/target/i386/tcg/seg_helper.c
> +++ b/target/i386/tcg/seg_helper.c
> @@ -473,10 +473,6 @@ static void switch_tss_ra(CPUX86State *env, int tss_selector,
>           new_segs[R_GS] = 0;
>           new_trap = 0;
>       }
> -    /* XXX: avoid a compiler warning, see
> -     http://support.amd.com/us/Processor_TechDocs/24593.pdf
> -     chapters 12.2.5 and 13.2.4 on how to implement TSS Trap bit */
> -    (void)new_trap;
>   
>       /* clear busy bit (it is restartable) */
>       if (source == SWITCH_TSS_JMP || source == SWITCH_TSS_IRET) {
> @@ -622,6 +618,11 @@ static void switch_tss_ra(CPUX86State *env, int tss_selector,
>           }
>           SET_ESP(sa.sp, sa.sp_mask);
>       }
> +
> +    if (new_trap) {
> +        env->dr[6] |= DR6_BT;
> +        raise_exception_ra(env, EXCP01_DB, retaddr);
> +    }
>   }

  Hi Paolo,

as already quickly mentioned in IRC, the kvm-unit-tests CI had a regression 
after homebrew updated its QEMU from 10.0 to 10.1, the "eventinj" and the 
"taskwitch" test started failing:

10.0:  https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/jobs/10871048973
10.1:  https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/jobs/11282832498

I've now bisected the problem (painfully in the terminal window of the 
cirrus-ci), and it seems to be this commit here that is causing the issue:

  ad441b8b7913a26b18edbc076c74ca0cdbfa4ee5 is the first bad commit
  commit ad441b8b7913a26b18edbc076c74ca0cdbfa4ee5
  Author: Paolo Bonzini <pbonzini@redhat.com>
  Date:   Wed Aug 14 12:33:02 2024 +0200

      target/i386: implement TSS trap bit

Could you please have a look?

  Thanks,
   Thomas


