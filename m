Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B59C982DF
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 02:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x87QD-0005TV-NF; Sat, 19 Sep 2026 22:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x87Q6-0005So-JF
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 22:36:47 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x87Q5-0004sT-2T
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 22:36:46 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-398a1676000so1622070a91.2
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 19:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789871803; x=1790476603; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S4GfSX1+0XCG1xzUEHOD4fsHny0gcvWF1PEeYb7X7VY=;
 b=A0dqpD0WzWJfiLQLUANu4MIIR47P+obXI4Rt4BKlHL/yH9jXj6GD63cK/Jdw7wuZhr
 Ik14nlZXSOnU+CCEcvm2UPTDzhLv+O4V26g/kP8dRI5ZrMlhdhyx6V71Xp++VzrB8H5f
 fxOn0zAd9W7V2n8CLzLR+qiklnE95gEHp1O6SGji+NYOiddKbR+DABtKzj1Myb2F2MBF
 ieqxaoxmO8YOj/xFQ5RsECUd0mfJ9hR0kPNQPm276A7Gdqv3Kb72sH9AJLzVKD9/mqP8
 4IFfPigFCE7njkqTxtUUD4jnnN8MCJ26s20Cq3DUp55zweD1TfRs1EKrXpXwfo0PQTQX
 xTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789871803; x=1790476603;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S4GfSX1+0XCG1xzUEHOD4fsHny0gcvWF1PEeYb7X7VY=;
 b=vuD44snMcBiaNgq0KFtsWI5zubjMCHCbtA4TDlcp4NPbTYTiwMJYskrW0TVt8VY5Nq
 B3iXCAnUbuHEUOPDHijI+NWaDAXa07g6ukqtMRVJTm1sSa9E0tRqCI4njT5SEFhtU7Kk
 +1caMEzxtxvc/fFV1cqMQFTNBvp1B/kZ5hwcvht+AK7xq691QplRaEsaETv4HonlFtJ5
 UHW749/sZ9IiYTzeyRcQCp6pRBuFngYWxIIujgFPEDxtGnDR5kfgJZM909NX0eEwnWOB
 76O9hKKlSYJd0KFz8wiRyAgbIYqtMV0099f2yBtqP7+kbRnmGfSzxqTHvJj7qyZ/w34V
 6k1w==
X-Gm-Message-State: AFuF++kIJWNTPqAuj66FC9R/GuWrg9Op7pswPdMPr/FLpdaEwT/i2ZAO
 Gfp0zaHGxcRjlVtkRqyykgjJ4NZ36CtSDxbeW3OOW4TRAl/hiZnMblSlQDeWnp44KWbpCTQEutM
 t1FhUuGM=
X-Gm-Gg: AYBFou3ixyFJ4y9BqOT8Z34KN2HtUdxkkIqU6omCWrVA4g6RdZoMRqe8vMqKpZY2jSv
 67pL64vRwgyBg5mWcW4Xcufl7Y7gFs8G3clwpnCritzI1OdHqJDTl0bCLOmzS2xQ9bEBroepcA0
 54OuDeCuKqnxA43iGIF+T9AyvWDzYtLXlo5jt//rPIcYFvKgSVE+UvXxvnIgWlgrLubbeF963TW
 YbNqovkmAf5bS2582OB6CuPfM8hJJ6XhZwOEwYbftbvagtbziZgO6cplx7YYpjI+Sn286lF0IQ/
 dN3QgGCxFOJIo3LRkRITVriKQcG5FgP8HLl/IiL8OsxRGeklemA5SjqZJPT5L+isN1/2Gp8WLpg
 KvSGRjWYjrVITKXrP4yfft9hn5HYGnvfgHme7BEiseGVu/YwNqLbEG6MeSG86+B+wDFlaR/zHdF
 ZCTiNh5K1rklAMaQKmU5AwZ33bJoTfd3vLhtQK4i9K1036iZvRzfSDQlmVRPs70TMpIGvH8F8HZ
 tJm2Z2waMuqm+N6YupVAAVTpzh8/NWKIreb094twAZdomKQnewL/r+bwOfqvA==
X-Received: by 2002:a17:90b:17c1:b0:398:e86b:ce14 with SMTP id
 98e67ed59e1d1-39e54e3f526mr11385728a91.20.1789871803295; 
 Sat, 19 Sep 2026 19:36:43 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:8758:b6a7:94be:427a?
 ([2603:800c:7900:ed00:8758:b6a7:94be:427a])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144df9ad683sm1243931c88.6.2026.09.19.19.36.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2026 19:36:42 -0700 (PDT)
Message-ID: <cf3951a3-0471-489f-abc9-94727321f4ce@linaro.org>
Date: Sat, 19 Sep 2026 16:36:40 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] accel: Change AccelOpsClass.update_guest_debug to
 void
To: Matt Turner <mattst88@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20260917082618.1076988-1-richard.henderson@linaro.org>
 <20260917082618.1076988-2-richard.henderson@linaro.org>
 <CAEdQ38Er2whRT=rGW6gFrcCnnTUOMu5ubvpNd5HKD_q6hFjK6A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAEdQ38Er2whRT=rGW6gFrcCnnTUOMu5ubvpNd5HKD_q6hFjK6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/19/26 10:46, Matt Turner wrote:
> On Thu, Sep 17, 2026 at 4:26 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> The return value is never used, so drop it.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/accel/accel-cpu-ops.h | 2 +-
>>   include/system/hvf_int.h      | 2 +-
>>   accel/hvf/hvf-accel-ops.c     | 3 +--
>>   accel/kvm/kvm-accel-ops.c     | 4 ++--
>>   4 files changed, 5 insertions(+), 6 deletions(-)
> 
> Two other places need updating:
> 
>    accel/hvf/hvf-accel-ops.c:266, in hvf_insert_gdbstub_breakpoint()
>    accel/hvf/hvf-accel-ops.c:306, in hvf_remove_gdbstub_breakpoint()
> 
> With that fixed,
No, those are separate callbacks.


r~

