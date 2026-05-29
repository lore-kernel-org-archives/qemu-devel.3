Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4E2CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 17:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT0jr-0000ei-5x; Fri, 29 May 2026 13:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wT0jq-0000eV-GC
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:11:14 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wT0jo-0007V8-CH
 for qemu-devel@nongnu.org; Fri, 29 May 2026 13:11:14 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-835386ff122so14006260b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 10:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780074670; x=1780679470; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m/FonfV9xysczRoV2MiizOpkSgqxtGDJN8eXQSghS6c=;
 b=E17NafjV0aU6MkBm99BieIXfVeMwVQ+KZtbXM6nDuDSjVgejprit6gzimD1QRucEHz
 x96OUYbqj3haf/E4tRQ3SqhJDeqsZAJ02vyMTaE099vzKK2bUmLukUTqockai5SuisE/
 55P9LLvM6vL9iWsQh+uFlsONicH/1NTLv8aZvDCFANXNJAYRJM1lHXRBF2OsBXoicuaC
 vHV1qsyzSI0D2q1wsnARjGTR34FsJRoPeX+IYhX3+eADXOzbD4KFsRdOT78gK4WUJ8mj
 HDSHNXl7axmhYs7IvCldfXcOh36c5VNvPBFZXlj8qr7z+rX0SJ9mtUriOe5yc6QSyz64
 Q+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780074670; x=1780679470;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m/FonfV9xysczRoV2MiizOpkSgqxtGDJN8eXQSghS6c=;
 b=IevZOOwzISMV4EjEj6Vbq4T63sq5hBu4suYm82hx6Yobcqb6L1LioMAioBFzAfeBaB
 CCf500LGqzha5Brrw0i2x5222dIZx69KvHxpH7HKBjNoc3gWiDA/oKayHCNlwPFnj/cR
 TpwCL4LojT3gi4B7y4JLHATrPGLl+XIzKqyvE/Apr9rBkWlUwyLLJBI5uGowAIS5rZCU
 63My39UpYYtO9d0CE/OPfHmHf2vKevvtttMuciRbBbgVP+v+CDCX5sDzwJcSkNc6T2fv
 G8SZ5esyax2Oqr3MjwbzaPVQXUENrME3FI7ueMktUnNlKC6BKxEq6ogPJn7VXSuk7kfd
 3TZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NiVmc5DtnBxX3Bv+yLCTX0ZgFlBmpGhIrWhA0JNAXtrK7T6jUjsVuJjfsCVfhnLOdo04d88peltWl@nongnu.org
X-Gm-Message-State: AOJu0YzmTBRFAWP+uCYlVpU6JLGqMLJ2SYiI0KF7RJpQYaynbzIsIxgO
 FyF1mSPgA7ha6Q2RECnHA/DXGluyW90bLtxNnDx947acKhy4xInGZPlHm+ebF9Mq0EA=
X-Gm-Gg: Acq92OFwQLjlbkzPMQfYXJ8aXWWGRSqCFpYxE6bq+jYh70DBTc2J//wama40kLUluM6
 o8EzbZPnUhH05UVJdulgjMGuv/czrw1KPxdnl9ggC2bdM1HjoDmKIMhSRm5wc28iZ8a9E9A9SwH
 bwagzG0Ciofp1zVYgxCEjdC3ShhmtO3LU4sHxMQdPVcn2YhSmmiJYIzy4A1w9AEEgIhr13i0Srw
 fPDe3eYQu6xZbsz0elXGDmL2eZRvPRdGGJgo7CTe4NtVNulhxZi1fIRyl2D9mI8SrMNFkdQlcLm
 zcPEBFY5ufaTKq0NbiY5a+e398YeiVx3zFyetfuWf0/1BmAkDrKSdfs9/Yi9wpjlcvD64oE3dww
 5gL4yEHDmoE8bYbsvR971dEUJKol1ejueMdbBt7dXcg0WYAcxeCYdPxSBwYZD+qQaCMU1XRnaat
 wPQetALfHAZ3ECsOE3GItRv715y5/J6aqyN86oD8uW0DUGw5gAvUww4SsTCw==
X-Received: by 2002:a05:6a00:3489:b0:827:3d52:5d1a with SMTP id
 d2e1a72fcca58-842251b184cmr486198b3a.0.1780074670165; 
 Fri, 29 May 2026 10:11:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214cc0d1csm2675397b3a.42.2026.05.29.10.11.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 10:11:09 -0700 (PDT)
Message-ID: <c21051c1-19b7-4fa5-b14f-772a50717d8b@linaro.org>
Date: Fri, 29 May 2026 10:11:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/arm/ptw.c: Add Granule Bypass Windows
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260528-jmac-gpc3b-v1-0-d34c46c5069f@linaro.org>
 <20260528-jmac-gpc3b-v1-3-d34c46c5069f@linaro.org>
 <c5e98ece-ecad-42cc-9b83-154453f535a5@linaro.org>
 <ahnCgXdlwjro5Ybj@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <ahnCgXdlwjro5Ybj@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 5/29/26 09:44, Jim MacArthur wrote:
> On size and stride validation: there are reserved values for these fields,
> but the ARM does not say explicitly (that I can see) that they make GPCBW
> /invalid/, so it wasn't clear to me that we should fault on these.

It's right there in the pseudocode for GPCRegistersConsistant.

r~

