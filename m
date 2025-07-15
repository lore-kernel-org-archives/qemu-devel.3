Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2AAC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublj9-0001LM-Q2; Tue, 15 Jul 2025 15:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublJw-00085K-Tm
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:28:11 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublJv-0007ZA-Bq
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:28:08 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45617887276so21810345e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752607685; x=1753212485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ajYqPtt9PaHY9wdE83dbPwpCPQ4HuB83O+8wOEh0amk=;
 b=FaWcp4WYNEQYwSr092Zfl7UVCXewp/4oe10uymGSZayzX5WqRYvC42TrqZj0yQla6j
 qt8D5llGvC0u2rqdYMJtETfDRzHhWqQ0ZhyI1oY4DsSegd7zr3CKmwBLDITNCY0vKk6Z
 14sheQK1OCK/Jy/LpNACBMER1gPK26FN/W6zlWe6yIViC2XaEx0ULsXQoMhR4hWx6GXm
 e0uaVNEnSXm0ILUPAiIFC+MrntWdp1YT8eQeLSStnj+MBWSnzU35GAtbw86tmAqC4XEa
 VeT45rcY1+dKPY/ngoIteyuSLW2L9CygXlrW152siz3WIM0fdU/8+qA/VmVXDWu7iPBx
 A/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752607685; x=1753212485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ajYqPtt9PaHY9wdE83dbPwpCPQ4HuB83O+8wOEh0amk=;
 b=mttlxbgtqgwCa51WookuofkkM8NoA10TWeGExJQynbVqauwfyIZ5sax1mtdahvnEBl
 sF7aYShhOPmNBkzxYiMq3AciZ/dcqXWnSi9EjVFe820RRYfc8zsl2wFog64gzNLWTR+L
 88CECi1I6N2QAQYkw8H1+lf0izpK5Xki5sYG61LQxmuWlAxB11N0xx8jWBgYkwX2VScs
 pkjwAAgNpKA6wLTEHaDYDxr09aVNm5LAAMZdiGdyk1u80x5U5vjh4kYFqikWLMGYHpHj
 u6nhxdsiqDLpq68JYbG+R11kfyZDO2Jelh1SVrabRC/b+Yd37bLbbqr1+Zpxr4Wz2XQN
 U/xg==
X-Gm-Message-State: AOJu0YzFzd3c4aa8Y0j5IcnzzRoT04gTm4gRPlq1YPMSXBkDz/V1nV9/
 zrbgt+sUNr0S4hMr0aQn4WD8cWbiresbhStLLyrVoSpazrIMv4Az8cZXLAeMQdWivpMmPke197l
 lgPSI
X-Gm-Gg: ASbGncvk7nd5tZcv3dVaS0QI+BWjPUZ6AzbjZY6maw+KDc4sjxJxFS6Bl+TdRGdsW1J
 knWLW1cZ/JL+CqNavbZBUPohcu96xNV7JU3U/kX8uctieIWf0swjjyyMZwe05+YwER1FmbYIK0S
 CrhiitGqm43PjaATAIyNrBFiBTjpoW9kpKWTfrwikkPCwbGiNcr66wfOgxme73SeDHq3yKAzIE6
 0Y6iqKDa0wE6QraT3u6TlEklFCMwo24fVxf+mWA4y7zd34Qz7Czdza1Wql+ByJCOysyQde4+NXZ
 Pb8S4MjI2q6ur9NGtYCOHMENO0EQF+MiaGazB8M6NJaLZH4jkTyrYweFOBiNX+mHGQxTalK903x
 4uY8gXcWFD/3aFX9xHZzlctMk4apQLoGcOsK6dXYLdSlj/7TBwX68nS6leez+xPtrGg83gwA=
X-Google-Smtp-Source: AGHT+IHrMAyFTT5F/gFtDyBzfTeteyF1GWBJnrQBjSDZVYkGCGMNCccJ1TKFrMegfApYUPySq2sllQ==
X-Received: by 2002:a05:600c:3e06:b0:456:161c:3d77 with SMTP id
 5b1f17b1804b1-4562e38abc0mr332555e9.16.1752607685513; 
 Tue, 15 Jul 2025 12:28:05 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd47543asm168405695e9.15.2025.07.15.12.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 12:28:04 -0700 (PDT)
Message-ID: <f915bd56-bc20-48e1-b8c2-a0abb75ae145@linaro.org>
Date: Tue, 15 Jul 2025 21:28:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v6 0/8] accel/system: Add 'info accel' on human
 monitor
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Markus Armbruster <armbru@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>
References: <20250715140048.84942-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715140048.84942-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 15/7/25 16:00, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (8):
>    Revert "accel/tcg: Unregister the RCU before exiting RR thread"
>    accel/tcg: Extract statistic related code to tcg-stats.c
>    accel/system: Introduce @x-accel-stats QMP command
>    accel/system: Add 'info accel' on human monitor
>    accel/tcg: Propagate AccelState to dump_accel_info()
>    accel/tcg: Implement AccelClass::get_stats() handler
>    accel/hvf: Implement AccelClass::get_vcpu_stats()

1-7 queued, thanks.

