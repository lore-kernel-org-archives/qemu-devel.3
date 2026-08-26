Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04D1C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIKL-0000Jg-SQ; Wed, 26 Aug 2026 14:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzIKJ-0000JP-Ol
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:26:20 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzIKH-00074E-0o
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:26:19 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3964e480f76so1742558a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787768775; x=1788373575; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sfq5WGO/1TQRYfLBInKobA87taWcLCMeqOMCDl4pues=;
 b=Ec0zYayJGQf1nC7qzYFjbS8bbcujDiAnf3IqFj2vgCHfv1/UeE5IT9wnfgWdEpgJvx
 ZiD1xXBmRKqxZrWylveVmmqMpqzY+2O0NjkM6p6yu97qfjTd9mBa2h1YeZWgIuGIyIHq
 wRPWGC4f9Wl/sS2yp+wWBacLJL6eglp8QhYCez7Inwh3ZIW7S3xllaLpuINEQahktrWM
 JKb5OYWGZuk6SMXU2tGYUPhBD8NDTkWn4vnmCcHbMO8cb9Wcp826Jqgd/ZUO5YvUQBNM
 erqxnqALnH9e4RFr+jQfYFQS8/ig9xd6nJbrGsjvROQk5vVytrfFKdBwqiZb3uys/daZ
 85Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787768775; x=1788373575;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sfq5WGO/1TQRYfLBInKobA87taWcLCMeqOMCDl4pues=;
 b=LmIs9F2LiKbq35hKakfDmpqXxm2Cz0ey2gDVTsyS1vJtXbE5HVu9KQxgTY312Or/oC
 4SKib1Dd3p5Jgl2FM8fnihSvrw1ALHCCK84NdbLZh53yBd39o+78dyTw4WMsEolBCLsK
 H3LQg/HR/oUCKTPgt0SPLAEKTyGrAKa2qCQZ1VlfrPYNE3dwutChyby7g2P+TTPZeVOA
 pTepgcRqtnRXZJ4yx+iIOs5yROfpKv6KNlH1xLNbKsc1TcLztyqtrUqVpVVzHryJcYoR
 KzI6quswwq8ZpmmNTqYOCdRvBnb1MosgvqbODRGGqBOvDwhj9mOcVqD2n6eCx0J9mOtk
 ScWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoatYQFGV3eqUCPqSXIGsz4r0OBOurkZ01Vg+ewukRFEvqgDdDmgID70tpqtw3/76XD38Ytk2kKlDwG@nongnu.org
X-Gm-Message-State: AFuF++kJrIj4EwFXWQDQ5netcTxCeUepkRYjjlg0Y1JW01VpdRpeK1D1
 Ql4XDFBb+GGrZXG7pWZ2D0o1SM4xKCKfmNTfNKVHe9bmXel7KVW9Wa5oNflxSHvogl4=
X-Gm-Gg: AR+sD126AKMOlN4sMBP5lfP65B+U/iBwNcwa5MM902bdYkcOqJ2BnXgkXXr+chyO3jH
 A+ezYlvOodasKgg2mv1RP+q9mHrPkECoptfxNT4GsXudskDGiZk3hKs+lpYDpji/VRkA/Yaf/Yk
 7vEGsHDeiqJxpMDa7OASHNipoWVRQvdkRT+sClNGR9nf8pZ+lUBWbpGa9sGY4bi9e9sGaZo3bi5
 llDzsEjL/SWfY8ejyFRNPeZB3PL3Dcifj6W8GY/njF4wO1Dm8xoKlrpCOPEXNIUai5KAl//qiyG
 Um3UfsOfWNVflYrIJtym1x8qgcz+chujsp4sKkuKde/GbHwFhLnW5eCpUtmGi0/OujJfyeD570D
 QdZDFcGz1PygNJaQWDq4mmsp/wC9UvHeKlj7Z55Iu5owH1w77i00m2UbHljIMji+1vzeattadeT
 A+24380bknYI2eB5p+IIx1KcKujMjagEVJLA5G5pfEtea3/9ETPLQHwHMfeVNZRPJfGCddazX/B
 4NNjpdKLbvr3c2SvAOEA3bxZN/Q
X-Received: by 2002:a17:90b:4e88:b0:38e:6f90:eabd with SMTP id
 98e67ed59e1d1-3966d3ed64amr18677446a91.5.1787768775392; 
 Wed, 26 Aug 2026 11:26:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645da08desm8913544a91.17.2026.08.26.11.26.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 11:26:14 -0700 (PDT)
Message-ID: <81990f5c-c6ef-499e-b30c-c370792b6dc0@linaro.org>
Date: Wed, 26 Aug 2026 11:26:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/30] Migration patches for 2026-08-26
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20260826142905.2315503-1-farosas@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260826142905.2315503-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/26/26 07:28, Fabiano Rosas wrote:
> The following changes since commit fe11f459f640cd08f35c21f9d403517951bfd671:
>
>    Merge tag 'fixes-pr-v1' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2026-08-25 06:48:55 -0700)
>
> are available in the Git repository at:
>
>    https://gitlab.com/farosas/qemu.git tags/migration-20260826-pull-request
>
> for you to fetch changes up to baa4631ec2731c1b03e9704c4b398d85e4e90f1f:
>
>    migration/postcopy: fix page_requested leak for vhost-user shared pages (2026-08-26 10:07:27 -0300)
>
> ----------------------------------------------------------------
> Migration pull request
>
> - New feature: Fast Snapshot Load
> - Cleanups and hardening of RDMA code
> - Cleanups and hardening of vmstate code
> - Fix for vhost-user postcopy hang
> - Fix for CVE-2026-6426

This breaks s390x:

https://gitlab.com/qemu-project/qemu/-/jobs/16126649576

Summary of Failures:
   98/1142 qtest+qtest-aarch64+slow - qemu:qtest-aarch64/migration-test  
                ERROR 3.39s   killed by signal 6 SIGABRT
   99/1142 qtest+qtest-i386+slow - qemu:qtest-i386/migration-test       
                ERROR            4.13s   killed by signal 6 SIGABRT
  100/1142 qtest+qtest-loongarch64+slow - 
qemu:qtest-loongarch64/migration-test         ERROR 4.19s   killed by 
signal 6 SIGABRT
  101/1142 qtest+qtest-ppc64+slow - qemu:qtest-ppc64/migration-test      
                ERROR   4.17s   killed by signal 6 SIGABRT
  102/1142 qtest+qtest-s390x+slow - qemu:qtest-s390x/migration-test      
                ERROR   4.13s   killed by signal 6 SIGABRT
  104/1142 qtest+qtest-x86_64+slow - qemu:qtest-x86_64/migration-test    
                ERROR   4.14s   killed by signal 6 SIGABRT
  155/1142 qtest+qtest-i386+slow - qemu:qtest-i386/ahci-test             
         ERROR           23.79s   killed by signal 6 SIGABRT
  156/1142 qtest+qtest-x86_64+slow - qemu:qtest-x86_64/ahci-test         
             ERROR           23.99s   killed by signal 6 SIGABRT
  172/1142 qtest+qtest-aarch64+slow - qemu:qtest-aarch64/qos-test       
                TIMEOUT        120.06s   killed by signal 15 SIGTERM
  183/1142 qtest+qtest-i386+slow - qemu:qtest-i386/qos-test             
          TIMEOUT        120.06s   killed by signal 15 SIGTERM
  189/1142 qtest+qtest-loongarch64+slow - 
qemu:qtest-loongarch64/qos-test               TIMEOUT 120.05s   killed 
by signal 15 SIGTERM
  194/1142 qtest+qtest-riscv32+slow - qemu:qtest-riscv32/qos-test       
                ERROR           70.71s   killed by signal 6 SIGABRT
  197/1142 qtest+qtest-riscv64+slow - qemu:qtest-riscv64/qos-test       
                ERROR           72.57s   killed by signal 6 SIGABRT
  201/1142 qtest+qtest-ppc64+slow - qemu:qtest-ppc64/qos-test           
            TIMEOUT        120.17s   killed by signal 15 SIGTERM
  221/1142 func-quick+func-aarch64 - qemu:func-aarch64-migration         
             FAIL             2.18s   exit status 1
  233/1142 func-quick+func-arm - qemu:func-arm-migration                 
     FAIL             1.82s   exit status 1
  237/1142 func-quick+func-alpha - qemu:func-alpha-migration             
         FAIL            58.51s   exit status 1
  274/1142 qtest+qtest-x86_64+slow - qemu:qtest-x86_64/qos-test         
              TIMEOUT        120.48s   killed by signal 15 SIGTERM
  260/1142 func-quick+func-i386 - qemu:func-i386-migration               
       FAIL            46.18s   exit status 1
  317/1142 func-quick+func-ppc - qemu:func-ppc-migration                 
     FAIL             4.57s   exit status 1
  331/1142 func-quick+func-ppc64 - qemu:func-ppc64-migration             
         FAIL            46.56s   exit status 1
  337/1142 func-quick+func-riscv32 - qemu:func-riscv32-migration         
             FAIL            46.32s   exit status 1
  341/1142 func-quick+func-riscv64 - qemu:func-riscv64-migration         
             FAIL            39.93s   exit status 1
  384/1142 func-quick+func-sparc - qemu:func-sparc-migration             
         FAIL            41.98s   exit status 1
  391/1142 func-quick+func-sparc64 - qemu:func-sparc64-migration         
             FAIL            44.46s   exit status 1
  401/1142 func-quick+func-x86_64 - qemu:func-x86_64-migration           
           FAIL            50.76s   exit status 1

r~


