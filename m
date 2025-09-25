Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6093CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1k6y-0003Ew-00; Thu, 25 Sep 2025 07:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1k6v-0003Cf-IH
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:26:05 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1k6p-0007AE-D3
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:26:03 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so661466f8f.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 04:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758799554; x=1759404354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cio7y/tjdjQV/IVTKXjZgPxup3F7esjhpzwWIloJ1hw=;
 b=cnsY67qv5rot1elxgzoYVE91FnUe/hW0N6aVTrOLlC8pRAhcRQ2PP8WKr74Us6ZSmL
 Z5wTPp8pLkUZkPD6OGjdZGSVCMwNmvVDNonm+3HJRHTfeIgHMDbFap1wOsjT7sxZpDPt
 AOcXV8NdKj3svj/DBq+zY3YXCpOeyfb6YLl6eXCPV1OPyfW9XxUnIoNcD4n6ICvyo1uq
 t3XR9YEVKo5gIG0Sk4PQG+QPW61OaVeV5PHdZ2ak83HH4E5RKmnT89xqesue2dqmjZPp
 D5eecPV6C50CheXw4LxcX0Yav9AJUSx+OVhpfn06awqxsuHf12kRfRE2EDwgwJsQvAMz
 vIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758799554; x=1759404354;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cio7y/tjdjQV/IVTKXjZgPxup3F7esjhpzwWIloJ1hw=;
 b=JiLAjpZ+ZmdnRZUDOkL3Eheo70/8Alc96LsHVp7OoMNGPwlVFFlOEqIVZwQt3OCjT7
 5D1Sz3U5Tbp1jtCSjFlYsylyNvoTTu1DNDbI8LwnIZWRSx9nZOJKsPPxnCeteQE7opsx
 OfV0jWphbwsI4MugkHA+rnWUFG8IxNwEyFkLLmAGq9RXhqHs15CB7PhGvc05orn7ZCNo
 hdRYDFzRnVT73TtGBXkzTE+1k1Wuwjeqzm5bQqlmTDcbH+TjEz4ioMdwyyBbZtAE/izU
 3/gP9wHPy4Qc3n3OmyzRaLohMhSmouxlr+mSKG2dxBlsFJDTGIF6F4D/+dH/+l6zMbAt
 9qpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIU8CHYb/dhujEXzRbC+z5ASvEfycTAi2prfg9cpP+fH9Ou93uSLYi/8OTRH9VIENcPCrqHSKPr/De@nongnu.org
X-Gm-Message-State: AOJu0Yw35LAH/v4sABakZ8K401yL+cKN6BjFDmP1L0nDioq0adXdaZRS
 95N/Vhd6CadGugahtsrzZh5B+BWeeH2KwFrzMaJn/NBtYFAm0HhRU2MJnGYlkcBb9A0=
X-Gm-Gg: ASbGncvCH//o3GpDXf+iJHiqUiE8824CKgFk+vqLPpis8n2mZPG9fSHE5nLWjVsX+DY
 LYZuZsLKreQD96Q0e5tFTKJcuvWHT10JrQWC747FwZVfjNwrnTElZXRwiE3pXAIX+qPXwGnaSlg
 O4EL0GEHDe0xicDXyhs5AsqOXWQMDK0K3bc8zHQo53rlVxNd4sqTmMpQ/eqVVM7vAKNnq0mFJO9
 OwHrYWhMuqqA7rbq0nBaY3UxULSGqfraRKenM+AibtUqg9JhNjxE6OmXPST56mKS3XeWo87P4m4
 Qa3q9cpJRr08uwtS7gdLWG/eVWRx4GBrjW4Vg/TH7VYRYPor0j9/PC8lqew35s3w7exTx1nov0k
 v6BkesWG/wk169NKQ0FRZw48ekIboZVYOzrGxGMHKY69HtCayeRws4f7DQhsTZGBgGg==
X-Google-Smtp-Source: AGHT+IG2/s+Y2c4jg+19GVv2+smzeXbAQYzuaIJ0BeU36PXGhEjChv1lOcYd1QK3qPqaOFQKhchFyg==
X-Received: by 2002:a05:6000:220e:b0:3ee:14db:701a with SMTP id
 ffacd0b85a97d-40e468e7291mr3116620f8f.16.1758799554434; 
 Thu, 25 Sep 2025 04:25:54 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb871c811sm2637652f8f.15.2025.09.25.04.25.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 04:25:53 -0700 (PDT)
Message-ID: <7053c954-9c86-4b4b-9df3-db20b25d6d7c@linaro.org>
Date: Thu, 25 Sep 2025 13:25:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/23] util: add brackets around guest name in message
 context
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
 <20250925094441.1651372-24-berrange@redhat.com>
 <5b72b061-8516-4ea4-80c6-43b3f5eafc8c@linaro.org>
In-Reply-To: <5b72b061-8516-4ea4-80c6-43b3f5eafc8c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/9/25 12:01, Philippe Mathieu-Daudé wrote:
> On 25/9/25 11:44, Daniel P. Berrangé wrote:
>> The message context can optionally include the guest name if the
>> argument '-msg guest-name=on' is given. The formatting, however,
>> does not look good if the guest name contains whitespace. Change
>> the output to include square brackets to demarcate the name.
>>
>> Before:
>>
>>    # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 
>> 'trace:qcrypto*' -msg guest-name=on -name "fish food"
>>    fish food qemu-system-x86_64: (1146846:main): 
>> qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55657e94e690 
>> dir=fish
>>    fish food qemu-system-x86_64: (1146846:main): 
>> qcrypto_tls_creds_get_path TLS creds path creds=0x55657e94e690 
>> filename=ca-cert.pem path=<none>
>>    fish food qemu-system-x86_64: (1146846:main): Unable to access 
>> credentials fish/ca-cert.pem: No such file or directory
>>
>> After:
>>
>>    # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 
>> 'trace:qcrypto*' -msg guest-name=on -name "fish food"
>>    [fish food] qemu-system-x86_64: (1144713:main): 
>> qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x5604ada2c950 
>> dir=fish
>>    [fish food] qemu-system-x86_64: (1144713:main): 
>> qcrypto_tls_creds_get_path TLS creds path creds=0x5604ada2c950 
>> filename=ca-cert.pem path=<none>
>>    [fish food] qemu-system-x86_64: (1144713:main): Unable to access 
>> credentials fish/ca-cert.pem: No such file or directory
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   util/message.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/util/message.c b/util/message.c
>> index 814ca0316e..7d94b9d970 100644
>> --- a/util/message.c
>> +++ b/util/message.c
>> @@ -28,7 +28,7 @@ void qmessage_context_print(FILE *fp)
>>       if ((message_format & QMESSAGE_FORMAT_WORKLOAD_NAME) &&
>>           message_workloadname) {
>> -        fprintf(fp, "%s ", message_workloadname);
>> +        fprintf(fp, "[%s] ", message_workloadname);

No formatting -> fputs?

> 
> Squash with patch #20 "util: add support for formatting a workload
> name in messages"? Anyhow,
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


