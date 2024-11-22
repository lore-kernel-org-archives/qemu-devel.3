Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9782EE69186
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 18:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEYJU-0001zr-0A; Fri, 22 Nov 2024 13:23:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tEYJP-0001zU-OX
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 13:23:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tEYJM-0003al-Q7
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 13:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732299799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PH8gtYqhB9mwTl35PPBm7dRAxK+CYGA0GQDmeaTYwiA=;
 b=Wf6b8uI1pZzRWiDOfxho4J5JkJk+9xt+3HpFOmI3T3mdcTt21RliYe2GIJFPt/LJKZQG9j
 DdckJfAsldrOO75W7DSzxYNvm3FZtaAd06d0W2gcyoU7c+9Whz+gFdUDYa4zWRvw/QRcj5
 Fd/nFhT+zob9MFGQWldQarrhBsGhSD4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-bCUvcHGOMWaAlCqLy0KMyA-1; Fri, 22 Nov 2024 13:23:18 -0500
X-MC-Unique: bCUvcHGOMWaAlCqLy0KMyA-1
X-Mimecast-MFC-AGG-ID: bCUvcHGOMWaAlCqLy0KMyA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3822f550027so1185588f8f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 10:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732299797; x=1732904597;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PH8gtYqhB9mwTl35PPBm7dRAxK+CYGA0GQDmeaTYwiA=;
 b=l2VFHkT9zUwByOuJy1x5L/8GRshiVYs2FCwOJub/9YPhlS2O6aEMoKI1zEeyTKR4w8
 /lv+ppFj/01irA9zmUlQV129jPrKDuIuCl2nNVwtGAlPfaS2qrI9PPpteKFyVBsqjXiU
 7zpG6r3UfDLyYcmMhI/2HXlxVUsnL4nx+Eyb75Dv0VlJnx7SPuSadxP4/Jtzup2QcEXp
 bqtgZu1yBihLcdWj47J03PKKUqW65zFybU+6i9WxsYzB+RObZKOXczYwpnkuMU9JAaND
 KqwKzG7P8zsZ2Y2OpdGdgvaiFakZkwiP+hoNrioLQDkUuB5ZhG0HZUVsh2/w9PNBgayp
 9Q2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhw7hCL2KQXAfhTgTvWUAmU6x3ObCsZa0PlHm0gA17pifsP4ptq+8dipwWZd6H9/Oo4lFs7/t/XYeS@nongnu.org
X-Gm-Message-State: AOJu0YwRKQBUM0yJwYPw8CzXlAB8QueOGTwtHZnpswZEAZpYE8pYzcgO
 KV7n1ChTO6sBqUJ9UZFqhBcyfhMd1Ra3VLNU4An6b3eoL+csWCVCz1QwGE3aRhqX7G7Y8+pp/dc
 Khxx/HkJh336E6TR2baePIuZ1qyQsde440n6D3nrQCC0ZZ4qyiZ0G
X-Gm-Gg: ASbGncunmDwhbf5i2gCv/yzKdY19ZFmFbo+R8RWTrXEQ04KZQfXMc+JbN0Pf8RWv/nH
 WPmgg4KrRkWRkf19QFzlEGFtF8ySZG23qeguyPSdxipk2Yjp7xuKP7EkAbrMOLc11bO/wniwtVI
 ZJk/xXOQKshS2wu8QUkybf5eP5mbFhI0po6+lUHcXGT8eZsx8SgKn2VqKWU31PrmZdaCwd4+FGC
 OqV9kNcpaVQS/MrekSkCXFyaC+k4BnyPzj4J+F5EEmT73FvUwirw94=
X-Received: by 2002:a5d:5f53:0:b0:382:4bc5:e5f0 with SMTP id
 ffacd0b85a97d-38260bcb489mr3314375f8f.39.1732299797060; 
 Fri, 22 Nov 2024 10:23:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ6yDmHzXNPRun3NGOz7YE0zgF52BdkbJpaI20Lhftq10VpEvwyToAonl+P+wHEynU+ig7wA==
X-Received: by 2002:a5d:5f53:0:b0:382:4bc5:e5f0 with SMTP id
 ffacd0b85a97d-38260bcb489mr3314362f8f.39.1732299796693; 
 Fri, 22 Nov 2024 10:23:16 -0800 (PST)
Received: from [192.168.10.28] ([151.49.204.250])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-433cde10eabsm36057845e9.13.2024.11.22.10.23.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 10:23:16 -0800 (PST)
Message-ID: <240aa88b-7ac4-4852-9c40-4fb5d8fbd89a@redhat.com>
Date: Fri, 22 Nov 2024 19:23:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 01/43] Add option to enable/disable helper-to-tcg
To: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 philmd@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-2-anjo@rev.ng>
 <c478cbc8-6684-4a8d-bd88-724d48098c36@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <c478cbc8-6684-4a8d-bd88-724d48098c36@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/22/24 18:30, Richard Henderson wrote:
> On 11/20/24 19:49, Anton Johansson wrote:
>> Adds a meson option for enabling/disabling helper-to-tcg along with a
>> CONFIG_* definition.
>>
>> CONFIG_* will in future commits be used to conditionally include the
>> helper-to-tcg subproject, and to remove unneeded code/memory when
>> helper-to-tcg is not in use.
>>
>> Current meson option is limited to Hexagon, as helper-to-tcg will be
>> included as a subproject from target/hexagon.  This will change in the
>> future if multiple frontends adopt helper-to-tcg.
>>
>> Signed-off-by: Anton Johansson <anjo@rev.ng>
>> ---
>>   meson.build                   | 7 +++++++
>>   meson_options.txt             | 2 ++
>>   scripts/meson-buildoptions.sh | 5 +++++
>>   3 files changed, 14 insertions(+)
> 
> Looks ok.  Could probably stand another set of meson eyes.
> 
> Acked-by: Richard Henderson <richard.henderson@linaro.org>

/me bows

Since the subproject has a pretty hefty (and specific) set of
dependencies, please make this a "feature" option.  This allows
subprojects/helper-to-tcg to disable itself if it cannot find
a dependency or otherwise invokes error(), without breaking the
build.  The --enable-hexagon-helper-to-tcg flag however *will*
force the subproject to be buildable, just like all other
QEMU feature options.

Something like this:


########################
# Target configuration #
########################

# a bit gross to hardcode hexagon, but acceptable given the name of the option
helper_to_tcg = subproject('helper-to-tcg', get_option('hexagon_helper_to_tcg') \
    .disable_auto_if('hexagon-linux-user' not in target_dirs))


and replace helper_to_tcg_enabled throughout with helper_to_tcg.found().

>> +  if helper_to_tcg_enabled
>> +    config_target += {
>> +      'CONFIG_HELPER_TO_TCG': 'y',
>> +    }
>> +  endif

Here I would add instead add CONFIG_HELPER_TO_TCG (maybe renamed to
TARGET_HELPER_TO_TCG) in configs/targets/) and add before the loop:

ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
if not helper_to_tcg.found()
   # do not define it if it is not usable
   ignored += ['TARGET_HELPER_TO_TCG']
endif

Paolo


