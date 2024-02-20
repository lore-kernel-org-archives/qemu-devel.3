Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF99C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcP6j-00010M-KM; Tue, 20 Feb 2024 07:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcP6h-0000zr-60
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:20:19 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcP6Z-0004sn-H4
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:20:15 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4126fda8ef8so2978615e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708431609; x=1709036409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=en4M2z59ORJxnfwO0sqQooTGqZaI9mV3tBiE1WfXXyo=;
 b=BPTiifJQeWiqcmD7iWw51J1KZwv0encMuRmaN36SPHyiGt3wLL15hfa2mkGyBwYes6
 HmRB/H04igDv7YWaaQM0NoFsIfg+S8oFAgwZcGlulbSjHENwAuEBbfsf5W1s9b3D/i+v
 WjcNSC6biACGLfoAgFjhLaJijT4krqvlC5Jfbx6HKPy9GWcc/uD0rsrteKxdgThvY2x1
 Ab/3H2GPwQke8gFigr22UG42d/cOfb1vbpuYcZqADN0cKUPqHNXcmVbbjVuekm27T4yq
 YpsenUd7GReBRKtatSDrIz9atWbtwOXyaueVDCc//NoCqzx72oEeNabhX+yL2HhfuSQ/
 /4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431609; x=1709036409;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=en4M2z59ORJxnfwO0sqQooTGqZaI9mV3tBiE1WfXXyo=;
 b=VRgrFQwiHNnw82hy/FR+zCNjpxjPnzSpfVKwWjEJVBWnf1is9rSDqAToD32uqXp/T2
 4IHId+ZC10gR7exodt9aX3ltR8ROIFbjAxzJzdvEgwmFKxjMZxySn5nX5QbdumAK+tdo
 7x2LG9Y/qRiRmEh138fUfBc4hD8YoyIekyrbJNlRlFCrOYP0YEK5RkUy12EN/Q1RW11K
 rodcQ1p05Q+MWwHzTl+V7sjcyKyNN/apHUpe0t8cl2t6bQRoaE1j9rXDRR6MMszGMbKs
 58Qk9ZSZaShnwn1PuwHrNq6OaSjhCOiakOE7DyyzG7RH+Fd4tOdayad2kWhY/RBbFlec
 9/uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDYW17ZDv5VMLc6gz90CBXtg34D+XXaosWcLDbb1wtGtG/8NLgKy+J/dewcVLffxH/VX+Rak2rKSVVQ8aw3QpXXMcco6g=
X-Gm-Message-State: AOJu0Yyd/BhLS+g4jD2+kOHQog6ZcmyaMnlxBp0la9Y+K+xeFtmHIUeC
 2LXoBmBdAKOvoHsUz8WfCuEmXicu5+iez6lqG6hP27yrbpuB64yU0cqudqiChbI=
X-Google-Smtp-Source: AGHT+IHwzxjgKJ00sjIlYJBm3oz94NkdqV85y6tx2+TlFKI3jsI0GvUfjSUst1wFZUM7HhYhRKbOOQ==
X-Received: by 2002:a5d:4389:0:b0:33d:3b83:6ca3 with SMTP id
 i9-20020a5d4389000000b0033d3b836ca3mr4647585wrq.64.1708431609143; 
 Tue, 20 Feb 2024 04:20:09 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 a7-20020adfeec7000000b0033b483d1abcsm13193952wrp.53.2024.02.20.04.20.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:20:08 -0800 (PST)
Message-ID: <3d446080-6be2-4a05-bc52-a2b131e84a4a@linaro.org>
Date: Tue, 20 Feb 2024 13:20:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/21] qapi/ui: correct typos
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Eric Blake <eblake@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
 <2b12236539211bfa887364cf7b621586addbb42e.1708419115.git.manos.pitsidianakis@linaro.org>
 <87a5nvcw0p.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87a5nvcw0p.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 20/2/24 10:41, Markus Armbruster wrote:
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
> 
>> Correct typos automatically found with the `typos` tool
>> <https://crates.io/crates/typos>
>>
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> ---
>>   qapi/ui.json | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/qapi/ui.json b/qapi/ui.json
>> index b6d7e142b7..1448eaca73 100644
>> --- a/qapi/ui.json
>> +++ b/qapi/ui.json
>> @@ -63,7 +63,7 @@
>>   ##
>>   # @SetPasswordOptionsVnc:
>>   #
>> -# Options for set_password specific to the VNC procotol.
>> +# Options for set_password specific to the VNC protocol.
>>   #
>>   # @display: The id of the display where the password should be
>>   #     changed.  Defaults to the first.
>> @@ -125,7 +125,7 @@
>>   ##
>>   # @ExpirePasswordOptionsVnc:
>>   #
>> -# Options for expire_password specific to the VNC procotol.
>> +# Options for expire_password specific to the VNC protocol.

Too bad, I remember reading few times the procotol, it was
funny.

>>   #
>>   # @display: The id of the display where the expiration should be
>>   #     changed.  Defaults to the first.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> 


