Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0C9FED9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2WAO-0002r1-Lj; Tue, 17 Mar 2026 11:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2WAH-0002pB-TV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 11:17:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2WAG-0004cM-B7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 11:17:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so64234205e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773760618; x=1774365418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JBoGQmmcPTredet1L+ZSGS/difgQ7HgCBwQPZ2M+OWU=;
 b=GUO2pEGIHDETjfhYlT5AZeosdnNDCHIKkzeUeZKlZxBP6TqPHItbKbYPUOIAcJwB83
 n3Rcnu+vkrlRWMkhNqBJAkIS6/7+hOEYg4qiLg+S77FMta7syC79wFQ3otPgC9vgW1o7
 t2iKFenxfmtp1Dtocslg3HfSJFdcT5s33kXB+wFsFYu9aQ/GWPwz3S2koOt2aagl/50B
 lQEAg+nPX8xFkC27gDV3O1KHZR6xxaCh7nyM++l57B7Y5YZVMynXlqqIB+M7iGprEjfT
 xy1/Kb0kgn8sHzytZQEl26eRA2+vb9SdLoUtFC0mMXOdIyMHLlomTHi3s0/lM8/lssIY
 Kj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773760618; x=1774365418;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JBoGQmmcPTredet1L+ZSGS/difgQ7HgCBwQPZ2M+OWU=;
 b=R+N59P+gLXwGKWqsA+VlJdTm+m03kCZSIrQPjoUtPSSVO9tlztrKsNSGX+r+Lu2GT6
 ZGR9dD+ZrNW+1Zn6K4c+H6KYlS5hlBUXyQ/RcYm/63lsB2cZg0WzuK3Mu72BWCo6gp9c
 vMD1PErGqu8gGur5fbnA4wAvldiXi4tqFQSzerO30HBmn+xDvDcxARwmoAZs1bDlRHRc
 Ix6W46YNxaPwB2xBZGOfR6AE8gh6qGFVBPDoSl94XdRyrHQ3rjQbrGNd5TVAGLof/6gr
 BBihRj/FAvco7diysU/8W5q3o7sKl7rz2HclYKyaOvpiU3vxEk/Fe64iw3Yeev5WOs++
 wq5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkbtmsYT/rzVISRqxz32881iUp5SnACp+1+XmXhJnsgt/uObKU0iVPXwX9I5pmJjyWrVj7zZk9vdQR@nongnu.org
X-Gm-Message-State: AOJu0Yy7ZYUPstiso9afYH+TW976+c3O/BMu+ixhg+JpdSqT723nsk2A
 J4/nrPV1LhFHa2Bq0VPBg98cfzFFzlqYojgt1/HtDsqK6r8s16/MgczZjQ+bhV1f7sk=
X-Gm-Gg: ATEYQzwOMZyXrAEmTR174S5JhwfwedRUDILxhLcwWr+yO001qMZmNFiF2ZAcncjTE5J
 AFlwh2E6ZzEb41CSuGf9YLWnC7YU5cABRU3vT9DCbcpHsrolS+hfBaXk2IR0RIZi3/qH/PFoWus
 4flqZRflVgDkWe6KDtIArcMNnnZUZD+wY2Cj81Xc2dSbpvxUQYySslfcAnQgVHi3KpESZ1K6OXc
 EElwKqwXwbRSe7vXGQD34GWt+MytV3Rvzb53DrEPeaKzybD/SWKFFbpHqbB7dFViy/GSdzT4gGn
 e150ks3jZVttBdJQuFYK2rABgVHWwjG/ntlEg+XhszYSnq7MO38jtAjHtv2pB1ujQLJgObKtM2W
 YQ9I2dOq576XTS8kEMwkLSYhfKHYuZs7pbyM0YhYvtoGlHFpug0ndcqP+7XjTt4T+BLOffTE3WQ
 1QonxK6iQFt2KO/TypFDE/9GaBBmNbL9lcIrsZIxntS0uUjY27U9kN20Cyw2gkw+e3EQ==
X-Received: by 2002:a05:600c:8489:b0:482:eec4:76d with SMTP id
 5b1f17b1804b1-485566f7a2amr309022265e9.17.1773760617604; 
 Tue, 17 Mar 2026 08:16:57 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea9d7e1sm72225025e9.7.2026.03.17.08.16.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 08:16:56 -0700 (PDT)
Message-ID: <398bcb91-9d7a-4b7e-a392-bcc0aa51fa7d@linaro.org>
Date: Tue, 17 Mar 2026 16:16:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] hw/tpm: Remove CRBState::ppi_enabled field
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260317120241.16320-1-philmd@linaro.org>
 <20260317120241.16320-4-philmd@linaro.org>
 <abdffb51-a16e-42e6-81b2-ef07b42afaa7@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <abdffb51-a16e-42e6-81b2-ef07b42afaa7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 17/3/26 14:19, Stefan Berger wrote:
> 
> 
> On 3/17/26 8:02 AM, Philippe Mathieu-Daudé wrote:
>> The CRBState::ppi_enabled boolean was only set in the
>> hw_compat_3_1[] array, via the 'ppi=false' property.
>> We removed all machines using that array, and the array
>> itself in commit a861ffef237 ("hw/core/machine: Remove
>> the hw_compat_3_1[] array"). We can safely remove the
>> now unused property. Since CRB devices always use PPI,
> 
> s/use/uses

I used plural form. To you rather singular?

   "Since the CRB device always use PPI, ..."

> 
>> simplify removing the CRBState::ppi_enabled field.
>> Set the generic TPMIfClass::ppi_enabled so ACPI subsystem
>> can keep checking its availability.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/tpm/tpm_crb.c | 13 ++++---------
>>   1 file changed, 4 insertions(+), 9 deletions(-)


