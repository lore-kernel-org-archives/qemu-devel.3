Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E611C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 14:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFw9C-0002TS-3t; Fri, 16 May 2025 10:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFw9A-0002TF-Ur
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:34:49 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFw98-0000TW-VS
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:34:48 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22e09f57ed4so35873665ad.0
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 07:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747406085; x=1748010885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TEnEGcFi6VPQs60U9lEm0a9bREKnRuuGtjuuvtkqe7E=;
 b=VjdAdl1CeH4r7TY95RQTwQU0Y4hP14Bs6bRaMsOdnZcalgZaGKV36WOoScn23R5s0P
 z3F7aQvBOkhE2s+4jraDWtW5C+Fpurpt28WGRq/4S/XWfVdIyrmKYIo4Y/WLO/sr3D2F
 CGoFclvtVhoocQ2SFFwlJRZHRTH+uTgdrd04kwpqZvU6RfxIuHUHr1BWRZ7CsHHhtDJh
 hNNtJ7NvGQ4+aUfwS9ZtKNch7bLp57tnWECk14EwlhZLkYXORlWBYSDqxkJ3AB9WTA0h
 m+YKECbPoFqxv1ImA5jfGJ5hZGJM6Rub7/hTamVf+08Z9z8luC/ZlDVxTOHy6yYXNXad
 +ZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747406085; x=1748010885;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TEnEGcFi6VPQs60U9lEm0a9bREKnRuuGtjuuvtkqe7E=;
 b=JXSqF4thiJuePIUnKZyPa/Pgte29CmaohNvBjxpx5LenegHhUrlhm2PvB2H8Y4E7xF
 nea7OISIWqmFRvi4ukvlKAIA+HagBDGFIdFQb0yGyQx5kA/mQzKjvfQkeNHbs7QFU2Yr
 1dYGhTgXeZ4GhlH+N6wluwou9msvXo6bL+H3aQcAjPWvmhF3+ARVGCTo4GosDysy2fkC
 IBc/jHTWP1eDtfyIGJuHcPsPLorcZRQiai0bTMGlx1OzHNTDCJ8uXiMp84sdxq3X2PhT
 zRTeF7Bz7vHs/0v8ubMxl/kF+qQooY5YbZOuV/PQxFq9rQAwDhnk9ybTt2VWtFEEVH4Q
 xKLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWddsAAH1+wOHu3khD8gykwSYok7VbteqFsDOb659cbmKkb7HjDmCecPAcfZUhMtcfC1WdQf6IYUrY2@nongnu.org
X-Gm-Message-State: AOJu0Yym5z/4vPgBeZN+lKCY8yTKXXTkKldis1yq0OwuJO7GmmpYgAbU
 bHIx3OkZNJ8useGlFLpcXrFpiLYUep/m5mbXS35se8CCSo9a07DKX13RKGf1eaVXBOo=
X-Gm-Gg: ASbGncviGP7Zaijlqmxs76sE5TVQ6Siz/E+jDjN/ncuO23pNoma/5QKl5obU6dPR1ML
 kc6fsZum89z7xPpZJ9gD/Az0wVAioepwvD8yEMxMy2XxTnxHt7w/QT0o23mvo0OV13lPN/9oCx4
 APzsWYYcb9IBNLg+YfqckmQM+R7oqqHrB/28cZ2cwgZKBfZAjJV8eNuuVHoj9C3ay5VN/A2TcuF
 BBOQA6hevewhcXqsmM9ceZtJKKYAyzltF7DICzwds9jXJWbHt79l89MVHM6swcS1+VJoeaAJMSn
 CwOG0ktOAfXZV7AJf9fm+idXLaS3OgVdR4pOeD5swjlrssdQpI27OT9pudZielQC
X-Google-Smtp-Source: AGHT+IG7aWRCeI66acbu/I0HNU7HUWA+PW3yfNIN+4y6fno/TCBNw+kZYhiVOSwkWgNl4UAai1NMgA==
X-Received: by 2002:a17:902:bb86:b0:231:b7e1:c96f with SMTP id
 d9443c01a7336-231b7e1e718mr57195745ad.18.1747406085303; 
 Fri, 16 May 2025 07:34:45 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4eba4b1sm14978365ad.168.2025.05.16.07.34.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 07:34:44 -0700 (PDT)
Message-ID: <287ce150-750f-4b04-99fc-a3cb3ca5c3de@linaro.org>
Date: Fri, 16 May 2025 07:34:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] meson: build target libraries with common dependencies
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com, thuth@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
 <20250516052708.930928-2-pierrick.bouvier@linaro.org>
 <8e6cdcb9-24f8-4762-831b-ce57f6e81b20@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <8e6cdcb9-24f8-4762-831b-ce57f6e81b20@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/16/25 4:42 AM, Philippe Mathieu-Daudé wrote:
> On 16/5/25 07:27, Pierrick Bouvier wrote:
>> As mentioned in 20250513115637.184940-1-thuth@redhat.com, dependencies
> 
> Use LORE link instead?
> https://lore.kernel.org/qemu-devel/20250513115637.184940-1-thuth@redhat.com/
>

Yes, thanks.

>> were missing when compiling per target libraries, thus breaking
>> compilation on certain host systems.
>>
>> We now explicitely add common dependencies to those libraries, so it
> 
> "explicitly"?
>

I'll fix it, thanks.

>> solves the problem.
>>
> 
> Should we use the following tag?
> 
> Fixes: 6f4e8a92bbd ("hw/arm: make most of the compilation units common")
>

Yes, it makes sense. I'll add it!

