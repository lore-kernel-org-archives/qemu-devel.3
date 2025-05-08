Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FB5C3ABC6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 21:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD8xj-0005l6-Gi; Thu, 08 May 2025 17:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uD8xg-0005ku-Vj
 for qemu-devel@nongnu.org; Thu, 08 May 2025 17:39:25 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uD8xd-0006tH-UA
 for qemu-devel@nongnu.org; Thu, 08 May 2025 17:39:23 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-af52a624283so1427172a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 14:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746740360; x=1747345160; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RIVzRxBQ0ha8wenOm7zlIZDDBm5UcvXpy6kwjw4B2j0=;
 b=f9cfD+TDEn7dRbKk+n6yhuxYfsAIAJqs+9mGpSYHPebeLuMajSVhFQbrN5DYBzixNj
 UPzoZaKyQj+h7HTcMlNWkux2D1pz4HOt2DEWK9pXfBGHBxOkDB3ZmbIUGPke7LZ/nP2w
 CL2m/YLgkLyPCxOzGl88gY32QPyct8mvmypczw4BreDS64uBi8l7hQLUjVojXaRuBUND
 pDA8YV5LiQekDLT1Hkqg7v+kDO6XE1qpveGJsTuIfS2mw4sYoy/wZuOIQAzKyyS6E5ih
 0RBOX4wZcwPUYPDEpV771+1DwN/wVyAg9d1x7BR+PoMz3/n1KqnD9hOXADB2iSwtO63m
 w4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746740360; x=1747345160;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RIVzRxBQ0ha8wenOm7zlIZDDBm5UcvXpy6kwjw4B2j0=;
 b=gpnGMYI1Z4KHACTCTsx1edyFmJKTvUaxSL4TE+wp4VYV+kCi40iVXXGdCvFfekwTW7
 G01+ONLH0I/aPY+rveQTd1sEEfFiAZGyODri1MSp0ODt9xHFlT4jv8ltLDiqMR7KhzvJ
 1ksWz2Wmu4kA68utUK4lIEHgsEKRUh67WwT58vY2mFsEHxyiwlZs9H/6tM1YyJhhQJnl
 GgustJks7FSkd34TCBrdMowmVmUll3XDFmX3eHvSiGmw0mmUDgcxU3r/AIx6/O+QKF9j
 jQ7vNENADmQnaiNe+Bv6Idcy8HQsTA2I7998LFzgxOnHTR1Sb5Qnd4LTyB2Z0ACUPEi0
 cVXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqJWjVnZh93ZS98BaOWKutkRJ18fP/TnKD6zE0TFgBeqiejLfrN69yw4CbsY6iS2Uo90bNhHGV4+0E@nongnu.org
X-Gm-Message-State: AOJu0YwDUUSTJX87k63F2itBEJD8etwPL2Ldbpa0f7AUUsY5BFkVY7CZ
 DbSp1QN+Nz3pqFBofd6A31Lb3ZwFS1al3hJ8KAAxwdt0GJo9yTD7J1M98iyzc0w=
X-Gm-Gg: ASbGnct8vCH/9Rj7qey6L98dlnttZNTqvKpxjrGw4vUvJYWyA4LFyuZeBNc6g/4FeD3
 rAv7ygH8TX4uHAAdvBsneU4TTcx8QHnt4ihLQ3oQJadOBAzoBOXgWamUlMO7Ahnuu3KOeM/RlE6
 XrQ1TEQz0WP6S8YmttNpBI0DlDdyAyM0sKcvN1vmI0CN2Qi0QIsLVX4c9JKjpYvWNxKiunaZff+
 WkpewbPLMz1ldlhz+bzEhUXTY69E8PBsgYtDgLNzmBaOvDTH32rfuQqjHGBq9j7mSDOsZoUgrQN
 iuQDZ3AsasOg08KgUdL826kO+9j9NqzZcw2rzEYUO6x1GybfheTwZBb57ERO
X-Google-Smtp-Source: AGHT+IG/270pCzQSFoEjNB8YVTry7RGATg5hCBKH108zES6TVj0IwEOYOB7Y+NOYRhCyTuhtiqrSog==
X-Received: by 2002:a17:902:f64e:b0:21f:5063:d3ca with SMTP id
 d9443c01a7336-22e84783767mr82097805ad.16.1746740359836; 
 Thu, 08 May 2025 14:39:19 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82c329dsm4170055ad.258.2025.05.08.14.39.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 14:39:19 -0700 (PDT)
Message-ID: <ce0be4e4-6e77-4a4a-9e1a-90e8f99e0d02@linaro.org>
Date: Thu, 8 May 2025 14:39:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/24] target/m68k: fpu improvements
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20250507211300.9735-1-richard.henderson@linaro.org>
 <14e74771-f887-4e7d-8fcd-78244a3f0d08@gmx.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <14e74771-f887-4e7d-8fcd-78244a3f0d08@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 5/7/25 14:28, Helge Deller wrote:
> On 5/7/25 23:12, Richard Henderson wrote:
>> v3: https://lore.kernel.org/qemu-devel/20240909172823.649837-1- 
>> richard.henderson@linaro.org/
>> v4: https://lore.kernel.org/qemu-devel/20250224171444.440135-1- 
>> richard.henderson@linaro.org/
>>
>> Changes for v5:
>>    - Rebase from February.  :-/
>>    - Use ldl_be_p in m68k_fpu_gdb_set_reg (phil).
>>
>> Patches needing review:
>>    03-target-m68k-Keep-FPSR-up-to-date.patch
>>    05-target-m68k-Update-FPSR-for-FMOVECR.patch
>>    09-target-m68k-Use-OS_UNSIZED-in-LEA-PEA-JMP.patch
>>    10-target-m68k-Move-pre-dec-post-inc-to-gen_lea_mode.patch
>>    11-target-m68k-Split-gen_ea_mode-for-load-store.patch
>>    21-target-m68k-Implement-packed-decimal-real-loads-a.patch
> 
> Hi Richard,
> I noticed that the FPU emulation on hppa has some issues too.
> Any suggestion, how one can test the runtime FP emulation (inside the VM)?

RISU is probably best.


r~

