Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803AFCEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxTD-0007hT-So; Mon, 17 Nov 2025 06:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKxTC-0007gc-1X
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:32:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKxTA-0000jl-3n
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763379146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z3gH6To22CM90o+a7zPC3aVcpyfVElKltA7aaMDJcDI=;
 b=Yu4OsAJFUPImuMUNWOa3iNzA5defg7c90BWNwnutn5HUJwNzeuSPYnaZ2GnOehBF/TTRyg
 UbxIxArx/+s5DCIJwWYnxUtH/7wdRxUHoc+Zp0sb1xEs6XLXQUETDf44QHf4/INCruGHcs
 /BKy3VmtHd97zkmMrXTHRnKHuM5IkOk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-j-YWHQgxO9qW8XTnaSF6yQ-1; Mon, 17 Nov 2025 06:32:25 -0500
X-MC-Unique: j-YWHQgxO9qW8XTnaSF6yQ-1
X-Mimecast-MFC-AGG-ID: j-YWHQgxO9qW8XTnaSF6yQ_1763379144
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779cb470a7so13428745e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 03:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763379144; x=1763983944; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Z3gH6To22CM90o+a7zPC3aVcpyfVElKltA7aaMDJcDI=;
 b=Juz9vS5NK2M0badreDhhmI9SUvXxAUM8ES1JlbkHjmSvC+S0O+N7UehrYf07E2MgfG
 a/Mq34r0a0Dbn7pwXdrpUP5wOBZKw2cRwZaGYnXXLmVHYKQapXFw5o2HI7nIT2o6Q5yO
 +jFopWvmsy01Wsl1CVHiZO8iAuRAv+R/CHmI88yfz1hCVkdYXEALEWoZ+TBY/PZw4RTX
 6EYoeHQfkdhmkVl5PHLgq3Wb8+creFij1J6oqTnNDJIuZVXnXH/QBW50fJ72vF4vsl81
 4q3bnvfUCRWGegHZ++UCW3HllMtxHQtGLrsHxbIXD5xMmjYAn+0nbyhm5DZE1zX6+9LD
 Q1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763379144; x=1763983944;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3gH6To22CM90o+a7zPC3aVcpyfVElKltA7aaMDJcDI=;
 b=LKP6v4+2G6lux6CqwNSuImxjBupBuOnDQ6pqUpuSxbVFe0HlRnyH9b/M/yzMeIVU5r
 gOold4yExuS5D0fs73rQ7Silzm/JotYUWIk8IJxE4IIZekKK4rdcKpTOwlOE/5xttThr
 osG8DjOpN3BPJkghvbWAeNS2YZ0554RMXXvMnMxu1LHa5xMF7I8i1jubluYIQdTlwwZN
 j4u/hEQuuB6ZJjlxZzwtZ7UMjs1uzrvYbDjQ95I09LPh1RSsWZWFNMA93zoEuR5sRQlt
 tt3V5VCMSCgnoceKJ+L4K3oo2m0NghBkNc+qqfZV0uvPZcBugq0EutJCFSbkWLyB2hne
 a7Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiuOTKTdnOGo2DyNnRQokkOOq0qwMLDcYYM22I/KNQhvAHKmUP1du1E7rJB+q4vU91RQySGCCQEp3P@nongnu.org
X-Gm-Message-State: AOJu0YxKa7hdDni+Xr9rPScm1JVYRXot+cHhTYnM0kcrUt2Vc24sH5Bf
 ZmLzU73lqCUgEJnyVEvvdd999aO6GsM2DHh1pI5lbD8F666+Ox1v7QJfhMY0IX66WXBUlpPpG+S
 z/UKQnu+F8HdnNv7kPSDnuLuHiLhJgfZeCLgEECSpreE7Qm5Du9TZcyxJ
X-Gm-Gg: ASbGncvwBJqYZcIWSvHa5/KN27SycwFZTMa1XLn8Cn8SubRR9fn/LPWz4OP4WwwRfJS
 CRlL2xGLD1wDPTHfyJA5xTqxQ+h1ezYdJzQAZ0/8WlJ2YcaDaW3YPRa3AcERLtJdPCnoWAMpEHy
 PlElQPXveAzEE4cc/BMagv8bHr6x+Bjb+NannjTpNr7HbPg30JQ3XTycjSfmrto3Js91oUk3/W7
 PTJpdjs5qTzbvW03RE5gKO+6Cpe47YkYnidtQEryTeHmp7fKkCVGhXo22cNQ8LO6Y4ap0tYYz9M
 /shEOnScqfOeT0DO30lZfN/u6jg1wRXzOAs1/+xyDDI71wHUrUiBPNLTxIAEUtVGxUYFg1qWp7g
 fEmi7gs9hzknBG96mpG6Up/IXTBFp3aeZVxLdUENEGXRYBMlGfZXIB1TpZNScmzXrtIrWFk/n8W
 wW1n/h
X-Received: by 2002:a05:600c:1396:b0:471:152a:e566 with SMTP id
 5b1f17b1804b1-4778fe583e3mr82839905e9.13.1763379143973; 
 Mon, 17 Nov 2025 03:32:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKYZseVlXopxRDx2+0a8fzCWW5JmlMwAdrMyh6cuf5xu4OTtdfqx+zdw9tTUFLT2v4V5SjpA==
X-Received: by 2002:a05:600c:1396:b0:471:152a:e566 with SMTP id
 5b1f17b1804b1-4778fe583e3mr82839555e9.13.1763379143449; 
 Mon, 17 Nov 2025 03:32:23 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-42b53e85627sm27120752f8f.16.2025.11.17.03.32.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 03:32:22 -0800 (PST)
Message-ID: <851ab1f1-c05b-48e9-a08d-2076fa9ab67c@redhat.com>
Date: Mon, 17 Nov 2025 12:32:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: svm: fix sign extension of exit code
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20251115002644.103889-1-pbonzini@redhat.com>
 <3e215a17-11ed-4172-9598-42a2e1bd9e9e@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <3e215a17-11ed-4172-9598-42a2e1bd9e9e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On 11/17/25 10:42, Richard Henderson wrote:
> On 11/15/25 01:26, Paolo Bonzini wrote:
>> -void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t 
>> exit_info_1,
>> +void cpu_vmexit(CPUX86State *env, uint64_t exit_code, uint64_t 
>> exit_info_1,
>>                   uintptr_t retaddr)
>>   {
>>       CPUState *cs = env_cpu(env);
>> @@ -732,7 +732,7 @@ void cpu_vmexit(CPUX86State *env, uint32_t 
>> exit_code, uint64_t exit_info_1,
>>       qemu_log_mask(CPU_LOG_TB_IN_ASM, "vmexit(%08x, %016" PRIx64 ", 
>> %016"
>>                     PRIx64 ", " TARGET_FMT_lx ")!\n",
>> -                  exit_code, exit_info_1,
>> +                  (uint32_t)exit_code, exit_info_1,
> 
> Why cast instead of printing all 64 bits?

Because in practice exit_code is either a very small negative value 
(-1...-4) or a positive value.  For QEMU in addition the positive value 
will also be small (less than 16 bits); values between 0x8000_0000 and 
0xffff_ffff could happen in principle but are for use by software and by 
the processor[1].  So the high 32 bits are basically unused, and the 
cast removes eight zeroes or f's from the log.

Paolo

[1] see for example arch/x86/include/uapi/asm/svm.h in Linux:

#define SVM_VMGEXIT_MMIO_READ                   0x80000001
#define SVM_VMGEXIT_MMIO_WRITE                  0x80000002
#define SVM_VMGEXIT_NMI_COMPLETE                0x80000003
#define SVM_VMGEXIT_AP_HLT_LOOP                 0x80000004
#define SVM_VMGEXIT_AP_JUMP_TABLE               0x80000005
#define SVM_VMGEXIT_PSC                         0x80000010
#define SVM_VMGEXIT_GUEST_REQUEST               0x80000011
#define SVM_VMGEXIT_EXT_GUEST_REQUEST           0x80000012
#define SVM_VMGEXIT_AP_CREATION                 0x80000013
#define SVM_VMGEXIT_SNP_RUN_VMPL                0x80000018
#define SVM_VMGEXIT_SAVIC                       0x8000001a
#define SVM_VMGEXIT_HV_FEATURES                 0x8000fffd
#define SVM_VMGEXIT_TERM_REQUEST                0x8000fffe
#define SVM_VMGEXIT_UNSUPPORTED_EVENT           0x8000ffff
#define SVM_EXIT_SW                             0xf0000000

SVM_VMGEXIT_* values are actually stored by the guest in its own memory, 
not by the processor; whereas SVM_EXIT_SW is only used in nested 
virtualization scenarios and will not be passed to cpu_vmexit.


