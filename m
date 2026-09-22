Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243CDC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 18:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x95X3-0007X2-LN; Tue, 22 Sep 2026 14:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x95Ws-0007Ss-6I
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:47:49 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x95Wp-0006xB-Ht
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 14:47:45 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396cccbba91so151747a91.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790102862; x=1790707662; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=78JNZklME0O/1rA8EQgIG2udVfDdlIk7cp3F/kt0sSs=;
 b=aNjJz81pOi+C6dNGvsZy5fO9a6d2T8jYVoWDgSSeeJ6MsfDO8pOcJbcUCQIxj3duRY
 /o0aqaxl4hjRTXF2izHH5lhoS1XU7+mWqTp3ENFNo3SnTpEsbmwqL8ubob346mzYHnKT
 QndyWI1eiSNLkmLa1RAHgWJyxpR4TgGMdfWrrHtRvAPgSWtMtDpbBGi6tCMWtF4VqiJE
 qgN9bZugfVf9/hhI6C/nsqR5ZG+8E0KWx1wLrd4f0gJukZedxpLERULMUHcacc6/OskH
 bzSdTWathhY5vvu2/NcxR+nq6MvI3bqmOmoQgDV4ge2t4dZLstIcuIyhAkdKe3V493CB
 SPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790102862; x=1790707662;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=78JNZklME0O/1rA8EQgIG2udVfDdlIk7cp3F/kt0sSs=;
 b=sVpVRR9tzPe4iDXk3/S+g+RZZ93Qmic+EQAJrIaPpj2NzQygIf0U8zrhqcmUonZ5Y1
 b7bDFqcOwQSRifXKokGoJsHnlWjNkUpujZTXG0mgGg5P4S6z75bFAruzgi601xkvY0v1
 WDV0Fkd7Dnpb+Ek1SbxkZROVc77ML3qsvOSX+aCEcwM9HSu5aoy75OT/okuHqeh5ZiZO
 VskAnLZ5qTWAm5xNCDE1zy+ilUs+BJLGg8HZwTqKny/anpA3Inq5IEM53WT9UsBCju+O
 xviJQMFmcrTTBNBHFHQNOYuHIzZMZrd0b7HrPEW7lIZtn3WCN3Ep0Eid28BXDlZF2+zu
 ma3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjRSNF4CDB+APc4Gd2KgWIx//Gqfl106UsuERpDhnQWu9jzwpZhmBt9GUA4f+zuBpxhieK8Ny0/tYV@nongnu.org
X-Gm-Message-State: AFuF++n0bIzDwkmSrvRNAW+4weL1Z1sK+fYcrQIkLHAe9ksV5Vh3eSox
 frrkEdpX1j57QA5zE4nX+B+scWE9AQOauH/ph/HAo0odSmzpeQELPoeMpDpg2SRfYZ7ZysYAJ78
 OJ499
X-Gm-Gg: AYBFou2f2yWpJFGY4t5YdQXL8xMRY3WZVsdlvIp1TuHLnR6O4YjjuwHu0qPmjZ93XpK
 51a6eYEmIB0FhW90KrEKm4DTN+Ks10mitiip9NIzk5EQneNDf2zWdG4g5rdf6svj7NAOmuSaapp
 UuKFwf5hxkfri1t0RDvBozUFviVXfsws96DhuPEbkPqSwLKgt2E6+FNrDdW5BTSoIJioLUeOUZG
 UMJeez6A4QWb2iC3VmGYPYT+JnWz32OOrvcb/wjqydIbTnfleqEBuiBQHTWL7+BaDBqDz4LTll7
 fysAhaNEg4U7GdUBbkKcjkMxaaQ156jD4J+aSgQvzhYA3BQjl/mnC+tj6Em1BnO+BFCLd9R/+da
 hKXDKqkp00QM455IBuceCrYh5YgQ49Q8SmWCedrFpg3LPvhQDkbrkRIoPWJApKehFWhObaeiGHe
 0HfP0C/1wyGFedwXU9OKuNdc5NT4kr9kY/HhG6U81U+qFjFKXZsFpGEHq9qA7Aq2tEolH4UCUgg
 xHvs/5aBY7gu1uol8eS92DeUt5epz+MICp8xe4Z
X-Received: by 2002:a17:90b:50ce:b0:39d:ecb6:8d40 with SMTP id
 98e67ed59e1d1-3a07e4e41e3mr272243a91.4.1790102861933; 
 Tue, 22 Sep 2026 11:47:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a07dc2923fsm694264a91.11.2026.09.22.11.47.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 11:47:41 -0700 (PDT)
Message-ID: <a067cab4-0e09-47e4-bdd0-b3b09d78cde7@linaro.org>
Date: Tue, 22 Sep 2026 11:47:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/17] target/arm: Read halt state atomically in
 arm_cpu_has_work()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
References: <20260922164936.15189-1-philmd@oss.qualcomm.com>
 <20260922164936.15189-10-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260922164936.15189-10-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/22/26 09:49, Philippe Mathieu-Daudé wrote:
> arm_cpu_has_work() runs without the BQL held. Use atomic reads for
> halt_reason and event_register to safely inspect state updated by other
> CPU contexts.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/arm/cpu.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

