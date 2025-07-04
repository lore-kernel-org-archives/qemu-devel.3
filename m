Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639D6C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXbmD-0002kP-M2; Fri, 04 Jul 2025 04:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXbmB-0002jp-3Q
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:28:07 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXbm7-0006nS-RY
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:28:06 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso7460155e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 01:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751617680; x=1752222480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U0A4usibI7eGbC53g5/4tZrjHX/EOioQsgduZ6qqcEw=;
 b=LTMZOUqjwyfHMFBAWR8Wj5XXa6mAMIi2oqjW4/8sCsO5DReKxvb4FZuFlp2H/deXy2
 Ipxhju7raHVEQgIlVUZvIbLvLNcdEoXxarhlyszQbZjl2pq6gL0iI3WwRRnKFFw88OyH
 dUwsnSrwU+7o/MeSSVsAidK8SWKszAzk9xklo1v0G0RBowaaHZP4wYj5iRD9Y3RElqXt
 /Y92VPG2UOsw5RK8P+uZ0OcvVZioZimgExf6Ys0AImAf4JdniGLlPMbITpDWoH3zc+fM
 oLjRZ/WGLFOwArKBN//qaJpUPAgrh+h5YtsvL55ff7Tq5DI7vRyOFwk3zFE0353G00lD
 oFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751617680; x=1752222480;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U0A4usibI7eGbC53g5/4tZrjHX/EOioQsgduZ6qqcEw=;
 b=RLprvZJ8nU4XO4UcZ9o90dx3gi7t2+KATiWFRuU9nZc2q9D5URRra3sJvpOCHRYYAo
 bvfGJbYIDBtxczGGcNMx8gJ8tHl8cqfoVJb2+/aP05zbH3fjcYnIyPZM7G90UDfTLDIf
 pnLqZpnvoCj6Q0/V/PU0+639x85QBoGcJjWACO1Nv5SgjdLXArvtSi4wEsQGMGiIDN9f
 elzEDjrBgwtkUjoYI2fQnEoeX+J6ceTAj/EfL6LD2jFtlNXi3EzH7BvEXjuV/I+eNSWc
 LLFserQu1mkNq2q2nrkf5qYmS4D4MXklbY3r7c0vshEQBheky2RwKMd3db2K4k5myfGU
 L2Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4WWZbbnbrg3jBk74Z3BceN3LO7QVBgH3dzGBasx4P24zNGUSEPDVpU+i9opnaJOgS4ZSgEyYd5NSK@nongnu.org
X-Gm-Message-State: AOJu0YzFKTV8tSu/sI/BdQ+ybyCYgcrF4Cm72XtoG2/vL4IbMYBFmoDC
 J9Il8/iZPN8vkI8CYQcuYgDYNflToHpgQ3cScRYSty6dtGoCHDG9aB5sLZYRZ4u3oCY=
X-Gm-Gg: ASbGncukx7KUXgM7LwaVYQhY9uktnvZSn5aEE0/1xG2Ro8lQp0kPSPH7/nx84+rcs4Z
 /2q/TyBfGrGAPqowX0zJ4ZD9UOY1kMCFPgbBVchWW8bInc7XTnUmkfhGf+RkMzytRCnS4nLYUoZ
 /Py6TASLgzQj4+Zo2w7fqEZOH8bLX1A4cuHC0pyd9pfAW+LwlRVHKRoEXSNukbjU0uPaAZ+CmCe
 GC+P1brMShX1H5EYhQvhTe09IwGovkVxDVJDFQ3lwcCAjLv6lrUdI9sAiMsAMt9J5OlRID1XLcF
 6F1HPq5OrFva9aH1JNvs+n9NcijS8TdzRW24IN7CBUb92UAo80jh06UbCbSOztO/bp3IFIaAeZk
 DNYxAGbI0havKCngXQI2D//0oRc+/MA==
X-Google-Smtp-Source: AGHT+IEJWeuXd5bkocPT1GC2uTHAsrEBbH8Qs+f1xwK7OySX9hPisz7u73RvYfTp/652iJy3CmXBxQ==
X-Received: by 2002:a05:600c:1c94:b0:43c:ec97:75db with SMTP id
 5b1f17b1804b1-454b4e79819mr10558905e9.11.1751617680441; 
 Fri, 04 Jul 2025 01:28:00 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b1634147sm20034405e9.18.2025.07.04.01.27.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 01:27:59 -0700 (PDT)
Message-ID: <0bc1e609-88ea-4994-9815-020ae6389475@linaro.org>
Date: Fri, 4 Jul 2025 10:27:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 28/39] accel: Expose and register
 generic_handle_interrupt()
To: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-29-philmd@linaro.org>
 <e8d0edca-f79c-4d6c-b1a3-69ad506bf470@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e8d0edca-f79c-4d6c-b1a3-69ad506bf470@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 4/7/25 08:38, Xiaoyao Li wrote:
> On 7/4/2025 1:32 AM, Philippe Mathieu-Daudé wrote:
>> In order to dispatch over AccelOpsClass::handle_interrupt(),
>> we need it always defined, 
> 
> It seems I can only understand it until I see the code to really require 
> it to be mandatory.

See 
https://lore.kernel.org/qemu-devel/acd1d192-f016-48d3-90e1-39d70eac46f5@linaro.org/

> 
> But anyway, the change itself is correct.
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Thanks!

