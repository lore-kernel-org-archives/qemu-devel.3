Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94494C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNlP-0004Nh-Px; Tue, 20 May 2025 10:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHNlN-0004N0-32
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHNlL-000156-9S
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747750569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B2fknosUvxEu5nCsABZwfZ87yEvLkA1IH6IJQIC+SJ8=;
 b=UsAq7l2yBz2L0kEI0PNbDwyYE3Pjgr0BmLugRJa8HKspN+0MP4aZ78PcF9hVUPSD8klChn
 Higb4LEZu7Y7mQNdl5Mt398Ttic2rGpvoHPTWBpQ3c1KDttILzQOJb2iNTghRrocFcwAv0
 r3krC9hM2laDl2IOReOgchNtOiiWMrg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-O-wK7PKhMgqkYPzrohy2zA-1; Tue, 20 May 2025 10:16:07 -0400
X-MC-Unique: O-wK7PKhMgqkYPzrohy2zA-1
X-Mimecast-MFC-AGG-ID: O-wK7PKhMgqkYPzrohy2zA_1747750566
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a371fb826cso1051484f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 07:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747750566; x=1748355366;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B2fknosUvxEu5nCsABZwfZ87yEvLkA1IH6IJQIC+SJ8=;
 b=SmDedV0YCh0olnEYnH3Z5Juz7Yy0RSqH1PqyDeG8XH4tjsVk7Oe1CM+DeBzpkFCpw+
 9BA4zggFbdPoHVXJGUsVreyvftGtWhCHA7je+blU0bfspvf1D3OHBv+1U0ewek+gvRzY
 yExuybmd/xkrsUz8SC0XQ29v+wbe5FAp7yy3tNynB1aJi8yrosx5IaXWD7ms7q+ev+ll
 mscDuL3T3jP9e3zkbaGDGUXdJbaDqClL2SkgIqz6FnCkFK7Kg88tcphjyisWtlh9Rtn7
 504Iy5Op6SZvwLduAe6gz/habjCr77S1N2TpJiBfC/6oPcNuIU2sOQ5DWs0MRxKES1hC
 4GDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhOAwp9inqke/v6xDL/7vTvXwfSRz6617ylnijrA8XC9cJGsLrB8TFQOdUmHDXhPDoKyUdz1JuL/gt@nongnu.org
X-Gm-Message-State: AOJu0YzG7xxlUk3odVmLLHd53EcGeFfgvspuaH9mz1Yd6JgbF5RUVSgk
 jKiA7tyUU5MA55i+1oGyaYzBhQ63NQRVAzyPeoCz3/Nea7BWp28ngnBprgaMXsLH/YyqqDrBo4l
 5WpVn1528tFpMcDVb+3jSbAeDyHxq8Rk/CCUBZC1Ukq2ubXFJxoy+2XQO
X-Gm-Gg: ASbGnctHn36NmpwHu5RS+zI1A0QLocpN+S2cjdqFpCioL4oa6lwfsPtUB0CAKAttwhF
 k+RPtbiuV7JA2NOgf7KZBQockTfHqUYCz3YvEYLcMxbZN6oNkNXML51rLaCwNLxAMdYREja0nAH
 xi7HrX/9rlVDjaGj4DKBM1JDlJvBlyjmw3HC5mQ7tF58HDPkNYPwteGZfiwCVoTFeVYlwkqjr0q
 RNoe9G+Tnug6QJDtKANYLYjwAu+onTjOiynd58aF+5aE5dghVnUHEKBAv9q7NxO5jAZFdo9RhP0
 rrsmF6avA5eEyg==
X-Received: by 2002:a05:6000:40de:b0:3a3:749b:71e6 with SMTP id
 ffacd0b85a97d-3a3749b7450mr5369408f8f.20.1747750566180; 
 Tue, 20 May 2025 07:16:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW0lvIk9VVm0F98iBZM+YB8gQfdnwRZIYEq07Kywm8rkuM7JqHKlGeWYtp0YILOaUxr8TF/A==
X-Received: by 2002:a05:6000:40de:b0:3a3:749b:71e6 with SMTP id
 ffacd0b85a97d-3a3749b7450mr5369327f8f.20.1747750565269; 
 Tue, 20 May 2025 07:16:05 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8d005sm16966068f8f.90.2025.05.20.07.16.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 07:16:04 -0700 (PDT)
Message-ID: <7eb8274e-fe21-4948-ab5d-54ad71d552c8@redhat.com>
Date: Tue, 20 May 2025 16:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/25] accel: Add Meson and config support for MSHV
 accelerator
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-2-magnuskulke@linux.microsoft.com>
 <aCxsgBJZYeeXJVec@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aCxsgBJZYeeXJVec@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/20/25 13:50, Daniel P. Berrangé wrote:
>> +if get_option('mshv').allowed() and host_os == 'linux'
>> +  if get_option('mshv').enabled() and host_machine.cpu() != 'x86_64'
>> +    error('mshv accelerator requires x64_64 host')
>> +  endif
>> +  accelerators += 'CONFIG_MSHV'
> 
> This enables MSHV for non-x86 when the option is left on 'auto'.

This is similar to what other accelerators do.  The idea is that 
--enable-kvm will give an error on Windows, but not (say) on 
SPARC/Linux.  It was done this way to simplify packaging and let distros 
use --enable-kvm unconditionally; and now --enable-mshv should probably 
behave the same way.

The "requires x86_64 host" was copied from whpx, but is really 
unnecessary there because above you have

elif cpu == 'x86_64'
   accelerator_targets += {
     'CONFIG_HVF': ['x86_64-softmmu'],
     'CONFIG_NVMM': ['i386-softmmu', 'x86_64-softmmu'],
     'CONFIG_WHPX': ['i386-softmmu', 'x86_64-softmmu'],
   }
endif

So the patch is mostly okay, however I'd replace:

>> +if cpu == 'x86_64'
>> +  mshv_targets = ['x86_64-softmmu']
>> +else
>> +  mshv_targets = []
>> +endif
>> +accelerator_targets += { 'CONFIG_MSHV': mshv_targets }
>> +

with the simpler

  elif cpu == 'x86_64'
     accelerator_targets += {
       'CONFIG_HVF': ['x86_64-softmmu'],
       'CONFIG_NVMM': ['i386-softmmu', 'x86_64-softmmu'],
       'CONFIG_WHPX': ['i386-softmmu', 'x86_64-softmmu'],
+     'CONFIG_MSHV': ['x86_64-softmmu'],
     }
  endif

Thanks,

Paolo


