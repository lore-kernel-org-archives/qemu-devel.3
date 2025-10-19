Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C3CCCD195
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 19:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAZC1-0008Od-4Z; Sun, 19 Oct 2025 15:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAZBz-0008OC-62
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 15:35:47 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAZBw-0008Dt-Tv
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 15:35:46 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-28a5b8b12a1so37477905ad.0
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 12:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760902543; x=1761507343; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dmOw9cauqcw3YVgp5LNR9SmR6Bk6D2IZFOitNWrybrs=;
 b=Kge7WBHP9gjE2ZmcIs1g6I1rexigh0pVPL+omI15/e95d3JKtKCrnIfksyp3EM6ikB
 wim3H3IRPNJ/UKctb6wGa2uhbmsXLvX21pAxH2z7t549FyFm4kGPwgIxk9/+EHFz3e+8
 6HsH7nVN7W0RzsKTvviMFf9va9DlcfeFuIh8L4TeonZm+2QLlVwmije+VxRkUxLG/4pX
 uP9zKc3bi62//6N+a/YVViDsV+A2KXC2xx1wDU2ZsZVnWnIMrxRoIZZnts4jz9JtCFDb
 6bXSVnmQtcHhf/EM2AQsisOZG1qJ2iJxsGyGqvKJkyLcWiNzCFPu+wcki1mNrQSMNbeE
 tj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760902543; x=1761507343;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dmOw9cauqcw3YVgp5LNR9SmR6Bk6D2IZFOitNWrybrs=;
 b=GVK5jzE7PBW7RnvE41IK/uvo+phD8mauFascffIRczuAvpYiu9+ImUFlBnJz5t3unv
 VYnf0IBM1XV3CtZ+uR3vbbI10nO8hSDbEvtaEu2lBpthrewXMz/WEsQtFlOhZctcJWLr
 KSX7RHCuE09umx2fKY39OyIEEN/RPlMUXgbdJ3MQEjD9VpCaBIpjVF8tccuIxLJKWFk2
 8uK1UIMx0X4zR+myAjWmvCGn/FjNC0CEg4Rr82anzqiqViKBAwML/JVGNibO1YUcZq7B
 eSOgnJU8j26HEPZPZHiTuRMhFzxN0A7OkPtljFHxYmZe+scatc00dGXEcqsNfWbzaC8G
 U/Ow==
X-Gm-Message-State: AOJu0Yxt9pPcSyfypEjVroXadifukVrk97ghCz8HM0Q29ebmSZTTiWyk
 syZ1XvoyNK7DPYJwcRulqyHrIRcBFm2BlKQxPM3aR6BLmilJVdy4JIUZBQyndsNGxCg4AizdKL4
 7YLSMbzM=
X-Gm-Gg: ASbGncu8tjnZUUDcZTTaN++rG7GK4FaTyiZgifAb3TnjqSMw1fqZMX9rlJ4wszrrDb4
 bMv7+CX7zqUaqr6+1PO/gu3hBj4HX7obt0rDvuNQg6JP/a6+YQgjBvQxLHF1aTiLlLGrCUUuykI
 98WY1Lr7YZQFifuirsyphiNA2ieIhgMo2V+AlPTTXRFyVfVlwAr2hMoVq7r6sxzWn0BdfhROsM4
 hYiJMThqAukerOvkqHf44kWteUmWBzAqRm5EiKBWV1XrA7F2wM5ITqjXowdBKqd3DRNfcY01huz
 S55SVV477ULkFK+5+RLu4NSLlqydRENwzMlDqEvosqurSnLfBRuOx7KGEFvKoZkGVOTmC1anO2B
 fW3aExLMtDfSFe28pHJFMlH//2AgZ4n6uo/Eh27xjt/Ni4xNSH37/K46SE4jVBKMGx6zhH5kNUv
 eA/I1BmuMSxqDjNDSQJhKTkcie
X-Google-Smtp-Source: AGHT+IGsgK/d8qC2v36h5BeMGNaB74WbuQ5ZtEfO3YBBoKEbyRDWhncwnzcSCQ0iCrE/2WrFyszcfA==
X-Received: by 2002:a17:903:94d:b0:266:9c1a:6def with SMTP id
 d9443c01a7336-290c9bea18dmr130755405ad.0.1760902543167; 
 Sun, 19 Oct 2025 12:35:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-292471fdcccsm59574345ad.78.2025.10.19.12.35.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Oct 2025 12:35:42 -0700 (PDT)
Message-ID: <80df479e-8d00-4711-9315-080a5d185303@linaro.org>
Date: Sun, 19 Oct 2025 12:35:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .gitlab-ci.d/buildtest.yml: Install 'file' for the
 Coverity job
To: qemu-devel@nongnu.org
References: <20251017133156.926094-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017133156.926094-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 10/17/25 06:31, Peter Maydell wrote:
> The coverity-scan upload job has started failing as of 30th
> September:
> 
> [ERROR] Cannot find '/usr/bin/file' command, and no 'file' command is found in the PATH
>          Coverity Capture uses this tool to identify the file type of executables.
>          Please ensure '/usr/bin/file' is available, or add the 'file' utility to your PATH.
> 
> This seems to have broken when we moved our containers from Fedora 40
> to 41 -- probably F40 indirectly pulled in 'file' via some other
> dependency, but in F41 it does not.
> 
> Explicitly install 'file' for the coverity job, in the same way we
> already do for curl and wget.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I don't know any way to test this except by applying it and letting the
> coverity job run when it hits upstream git... Possibly we might find that
> it complains about some other missing dependency and we need to iterate
> on this.
> ---
>   .gitlab-ci.d/buildtest.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Applied to master.


r~

