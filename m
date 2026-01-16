Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8F1D3CCAB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 09:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggMm-00005J-Tr; Fri, 16 Jan 2026 04:43:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vggMk-000050-VV
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 04:43:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vggMj-0007Em-B9
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 04:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768556616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5xoBBzs0LlR5BhzyykHsABubkw45JF5JQeRiqWpBuP0=;
 b=GjV5Rc1e4LM5szw+1d1MuNcnNJ8F3N9MmGcT+Vc2Z8r2xJo18AVQbW19ngn9V6HNY5ckbk
 ftvHTww0wC2RZ9RpDxSf3HXxpTKVd22AYSQIUrhE0LXheDRPgavv4hEvKgr2BturzRws6c
 9bsluPutGYlg1zGHR4mCsbEmhWhhuGU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-Gr6iS56hMEGENitEgMWyLQ-1; Fri, 16 Jan 2026 04:43:34 -0500
X-MC-Unique: Gr6iS56hMEGENitEgMWyLQ-1
X-Mimecast-MFC-AGG-ID: Gr6iS56hMEGENitEgMWyLQ_1768556614
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47ee33324e8so10831965e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 01:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768556613; x=1769161413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5xoBBzs0LlR5BhzyykHsABubkw45JF5JQeRiqWpBuP0=;
 b=Xo8Q93ujjhGMqVvdgaUiONz+Rtrf/5VtEoB4Eg8fevW1hZlkU7DU3RZGuQFXntv5g8
 Qz6hIz+eTy6DFRiMKFYOZoyLE/dHddfEhICLHsxdyiFoFuc4Oe4AUGOSxFzH1TlV2urV
 m8szUPUkerJiYSl/fuoO+MepVWnxDSoeuutS37X8uL2M5xHq8KlN/7iUTk8YCbY6TQ5S
 UCoc5i5WI7fAjYcyqqmasHA6zoAzjn6gR9AnW0KK6vPJ+z5EtNp2iKmRvT4kgAELwLmW
 esHDfKQaomfi4BwntjOFM1cqnezETJkWlEH2NlXStD4rKoG5y2vPU5qiRAj631j+kSSJ
 SfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768556613; x=1769161413;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xoBBzs0LlR5BhzyykHsABubkw45JF5JQeRiqWpBuP0=;
 b=PkgsXO15nc9tqZx0i56XZLgd7mjbM4SoUgmxXGpZFLJLZ6FG9gSrNAElkAqGVshc+o
 8D3Lvn0M9mvQ9dpbZMQV/g6ARnyQN7XnIvbmDMRs53mWVhXgqwxrEScvkv2SI8QLainW
 EmSmsIXtEeLmPEY3rFOTKyHwYfZj+XOvM43j7YJBOMa5vBxfq9SUK7BQsffVBN3ATQ3s
 xfUpTbzOWkVq28mNoocj3WJZ3z4Lb6AXxTOC6gXD4banUWyC+po2SWn60PS+Ca55Viqa
 26TJe8d73kfOPk2ZEvx8UzfPMGuuLAWIg9oZfDv2zGwIKE/oYIC/Ehmi6OocM6eWpOnY
 h4OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMpUq2lBB7jQcvcg6cmt7W7l4P27xwXYkYrB3kQ/OBpEeSIpCQavsRZcKRst8KTeYUvk0LHOoJOZAQ@nongnu.org
X-Gm-Message-State: AOJu0YyFwpW9Vx+bK27CWcTLkE0WOnzjxHoKwhFzzSoU+FIFsYETRVWJ
 umASxl31v3FhqOicMLaeRco6KijnPgW0A/QqCjsE6cTaHoEgJ9azkuSCsM4ev64N3rMyu2GdsvI
 yjchh29Zg4XXo0JWdLRhgUDmSl9LWnWGYGRFBBmseaLhDOTvtZ34nuSui
X-Gm-Gg: AY/fxX4yy6UUJMynMY7uoge6IkSQ20D7LmecDVlOWQRTz3iu5yPAFePWeow+956Gxg2
 VxgxQGWWVnpBDsqhutcSGmhpD6GNQnElBGe2i2RHXcybT58e8Z8EXDU7HQB4c/6p/e51M7Ksyg+
 7feVVrPcyFzpMHzfAO66qv9llWHyQ8wMRRmYIfXkEUH3Z+y2F6gIycVmQWENQQqWUZDQB0GNUhS
 YlqPoRkv60TuKaMKMB5egwYZl7Uld2ZcfuDUsCVQEBQpqbh1eO5YDbp4Vue8yqfqYiJx2Z/EEuP
 PrJZycQG7xrdwqt5uUfiBPBB/rDmzBbJ6LOTIeOnV7Ezw0AdUkO59wbmsM1OVkL7ucmhYGSkiIj
 o+ARnv8ierSLLzkF1HWkWemb023bNhXPdnvEhk4m9BSjMnNXr
X-Received: by 2002:a05:600c:3114:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-4801e348326mr28992905e9.29.1768556613553; 
 Fri, 16 Jan 2026 01:43:33 -0800 (PST)
X-Received: by 2002:a05:600c:3114:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-4801e348326mr28992625e9.29.1768556613075; 
 Fri, 16 Jan 2026 01:43:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8795f1sm34007175e9.6.2026.01.16.01.43.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 01:43:32 -0800 (PST)
Message-ID: <fec645ea-d998-459a-b3dd-b141ac49a6e1@redhat.com>
Date: Fri, 16 Jan 2026 10:43:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL SUBSYSTEM vbootrom, v2, 0/2] Update vbootrom image to
 commit 1c8e9510b22c
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "komlodi@google.com" <komlodi@google.com>
References: <20260116082431.3689035-1-jamin_lin@aspeedtech.com>
 <226f29f4-0017-4436-b14d-232b3ccf8d45@kaod.org>
 <TYPPR06MB8206FC043C61247FEC3BDB1DFC8DA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <TYPPR06MB8206FC043C61247FEC3BDB1DFC8DA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/16/26 10:35, Jamin Lin wrote:
> Hi Cédric,
> 
>> Subject: Re: [PULL SUBSYSTEM vbootrom, v2, 0/2] Update vbootrom image to
>> commit 1c8e9510b22c
>>
>> Jamin,
>>
>> On 1/16/26 09:24, Jamin Lin wrote:
>>> The following changes since commit
>> c1c58cee16380f81f88fbde6b12f247b376839e2:
>>>
>>>     Merge tag 'pull-target-arm-20260115' of
>> https://gitlab.com/pm215/qemu into staging (2026-01-16 09:33:20 +1100)
>>>
>>> are available in the Git repository at:
>>>
>>>     https://github.com/jamin-aspeed/qemu.git
>> tags/pull-vbootrom-20260116-v2
>>>
>>> for you to fetch changes up to
>> 29558d1b7d7dc825fb8e7c074464c1c36a27be7b:
>>>
>>>     pc-bios: Update vbootrom image to commit 1c8e9510b22c (2026-01-16
>> 16:00:05 +0800)
>>>
>>> ----------------------------------------------------------------
>>> vbootrom update pull request v2
>>>
>>> ----------------------------------------------------------------
>>>
>>> Jamin Lin (2):
>>>     MAINTAINERS: Update ASPEED entry
>>>     pc-bios: Update vbootrom image to commit 1c8e9510b22c
>>>
>>>    MAINTAINERS                 |   2 ++
>>>    pc-bios/ast27x0_bootrom.bin | Bin 16408 -> 28564 bytes
>>>    pc-bios/npcm7xx_bootrom.bin | Bin 672 -> 736 bytes
>>>    pc-bios/npcm8xx_bootrom.bin | Bin 672 -> 672 bytes
>>>    roms/vbootrom               |   2 +-
>>>    5 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>
>> Could you publish your gpg key
>> C6E09400542315E869EE3547518E8DAB8AF13B94 ?
>>
>> and resend a v3 with just the rom update ?
>>
> I resend v3 here, https://patchwork.kernel.org/project/qemu-devel/patch/20260116093249.443307-1-jamin_lin@aspeedtech.com/
> 
> Do you mean pasted my public key here?

I mean to export it on a public server. For instance,
   
   https://keyserver.ubuntu.com/

Some more info below.

Thanks,

C.

https://lists.nongnu.org/archive/html/qemu-devel/2022-08/msg02386.html
https://wiki.qemu.org/KeySigningParty


