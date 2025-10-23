Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D64CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 19:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC0aj-0003Qm-7g; Thu, 23 Oct 2025 15:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vC0ag-0003QR-J7
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 15:03:14 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vC0ae-0003l1-SL
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 15:03:14 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-63b710f276fso1222584d50.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761246190; x=1761850990; darn=nongnu.org;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7YCKHDxmPeg4gGk6swvhL2XTQkAAmXAuBzLL3OGdR/g=;
 b=ZT0RXO8nzrYWdFctbiC/N8yCIfaQnHze/ZEL+cXinda6xf+LCQYPpQoDZh9HA4myuu
 eFyzaEoNc4/MpwSh2yQD/1Yrjhd8CpCy/v3bcYJvEcwCNbgBhXCPqxuuG2JaykTDy9e4
 iMae761qu5UN5a9ur+kK1xqguNovnOZWYOt4p7q8PBAphnPcZCJxvXr04KagKDa08+dk
 AmQWb571qfCu5zGCM78tbONx4LMxZD9OBXJSSuPGkcDV0JIcYmnvug0uNmxpt5m2HMtl
 AgfNaZrIlEGkJco1ogaCJTj6tnK/ou3V7gisH2SX3T0vqSz+PxTOTK4wc0G8RQcuIszE
 sedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761246190; x=1761850990;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7YCKHDxmPeg4gGk6swvhL2XTQkAAmXAuBzLL3OGdR/g=;
 b=TXonS4ciEt9UpLcDTX0yKCmjHgVig4I0E5OGK1c+s4nm+tvCy4NL+5fZ6RRStRUHWL
 Y9RpJ5DznFr2J4tiIowsq2dUu9J30Ov6vvRrIoT7Whdn0GEJkq57u9nTSo24xQP9Luz8
 LoMuR+1aX05WGlEW1T3ViwD0mR3Mmr1v+zftljS77IYT4m3ZumWJCHtGen0tjHtIFJqu
 sb7tnfQQlilbJq51eixF7t13z3XldqEapUsidikYtbO5O5Db62E6d6ik8pvY8+M2w/5O
 3aVYKAoB45wDMYh6D+UkUJPKbQldJHDQFkkdHMjt3apqzETlI0Si1wM4jh5M3So8DGHC
 3Fbg==
X-Gm-Message-State: AOJu0Yznmd3Qrjn1/s4sEUSsEOFs0AQRUrtXLsyKYiwHcH2l8u3M7ILS
 zveTIZtEnTc6q2T/cGdjTjAXmbKlEQp8+gzYt4v4QaiYkriu94s1m7PtJnYnqhvXQTk=
X-Gm-Gg: ASbGnctPoNjJCnZ4g0IgYzWstVr/r8GQijTf0B3X5fN2U6/YOx3Q/ARC+zub0Pi57fe
 pVMqAkQlE8c6T3Fv5khdJ19vkLRZPxb5vMb8U+cwUlz6P/eEUmGwvt/Rn6MB2YO498d1alelA66
 GCVLAZiPPRrR3t/ARwbimR0wTzubnwts7Z0139jI4vBEczgNB78I3kpfpygWQhcdz7Cli9mu6sl
 DJT/Tp1tcLOxrTJYSMYRckw77Exxcu1LP33hcFEvD78SCnNN3mdvCSB2/qsxRhrDmveGRUiVHiM
 l3FOW1rLRe5u3qT45SnEp1SWqyy+HHCsIkPayeGWNETHQfMqyGvkZEVMAc/xOKnUbNyI2cz5JB8
 uqebiHY9jYDJjYKxAJ8EYA+XRMtthmGGLe1PFvdVx4oBo1Ef1grtZ6Q9GLDqYAMWK1y4LibBmEQ
 TRayTsM5k4z58k6BWeDdvflXq/l1Z60kyHAIU1auiQf34etV4aAl5iMcDBC5Cw
X-Google-Smtp-Source: AGHT+IGA5qUDT1B5iQW3dHOcMIPs8xEH8nZVofwyYgqGU/KsOVakyv9bcyRggVdwpcW0P0DGHPT6FQ==
X-Received: by 2002:a53:d005:0:b0:63f:2db0:9960 with SMTP id
 956f58d0204a3-63f2db09be6mr4891713d50.34.1761246190153; 
 Thu, 23 Oct 2025 12:03:10 -0700 (PDT)
Received: from ?IPV6:2607:fb90:8ae0:85c9:1b89:4cd2:87fd:d3df?
 ([2607:fb90:8ae0:85c9:1b89:4cd2:87fd:d3df])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-63f378da831sm877500d50.5.2025.10.23.12.03.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 12:03:09 -0700 (PDT)
Message-ID: <d98deec4-c95a-434c-9ef4-d7a0fd41a42b@linaro.org>
Date: Thu, 23 Oct 2025 14:03:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: AWS CI Oddities
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb132.google.com
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

https://gitlab.com/qemu-project/qemu/-/jobs/11827686852#L1010

ERROR: Job failed (system failure): pod 
"gitlab-runner/runner-o82plkzob-project-11167699-concurrent-9-ther90lx" is disrupted: 
reason "EvictionByEvictionAPI", message "Eviction API: evicting"


So.. if I'm guessing correctly, the job is doing fine, 28 minutes in to a 1 hour timeout, 
when it gets kicked off the machine?

This has happened a few times the the last week or two.  Is there any way to fix this?


r~

