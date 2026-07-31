Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C387C55173
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 19:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpshX-0006Mh-Fv; Fri, 31 Jul 2026 15:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpshN-0006Lv-4s
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 15:15:15 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpshJ-00053A-Ix
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 15:15:12 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso1692377b3a.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785525308; x=1786130108; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0gWbCs6CuL7ZtaHSGkfAIEnPy6cYF/O62DB/aSXUuOM=;
 b=CFRkUam7YcSXOd/+Uww1m45CIDaDnq0mqjMQ1JBr08sJ1five7UU7MMe3Vl4JccYu7
 8ZHGFg8THIVNhMeOlNFu+/dugFYs8XEwEzAnG/LjzQlWpMsxWGZ4CJ06H4rIpxKQ7TPE
 wWdANMq8yuJmbECjtwoXWoaSAXyIadgxv/u2ihzPpA1DFeSI9co8aC9fC7Ck9COGL0uG
 qKQ91WJJvJ1g75HNF4WxBqy6/X4nT2wIBy3+JNtUEmrexr9Q3yh0bOFYISbeJ1ymEnNv
 aHUq8aCFJUs7+W9ElvEc7Y2UAsv7KnuCOizSawl0XHiry4ZzGbQQ1Eq01dOWRAsAtDuo
 lp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785525308; x=1786130108;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0gWbCs6CuL7ZtaHSGkfAIEnPy6cYF/O62DB/aSXUuOM=;
 b=ikPM44ody8yJzDU2tq5oin6GeB8hMBUhsOCrVxyTZgw23mlVOqcQTMSwiRKyW8E83s
 M5sJTsj9sb7RY9tTLe35NzSoxguAPX5KIbMtUp05aUac30Hw3OIrMwcUtqsX0KBh+bnQ
 c6oazk9Q+hUczFOL5hwdK0CdJ5LVX5cOsrj/rYOw7QLW3mpSxXM30XDX+zy9ot+fCfeT
 NerhvYSw3/d9j49J2c95WUJwDihoOixI9Jg2F7e+K/A4N0Ls03TdUS31ExAdIXXILZ1E
 p94vOkqNKslWrhjdr+HBp311SqzjflhjAknldGnrdDRKRAmmfZqWn8etvk0Tnrt5BB95
 2IUg==
X-Gm-Message-State: AOJu0YyNmajTyZ7drIQlZzkMpVrWoJKT69/futTx7sdQFLEcvnaMmFHD
 ovfdi/MXCNUJprc4unSWkp8h9Ucns8tRYw/0CnlXR0UaxLnmf13HWYDVo3NXA9BpRHY=
X-Gm-Gg: AR+sD10S7LdCfghUeblDKDelf5IxY6qnu0WV6gLqKF4NBsgRXLgt00vjE5rjvK+1EKk
 g176PoxrgwA5xazZR8MEkQVAin69J8jTjf1yePCZv9uafjQuEHmRqhBm+NHcSuuWZ7ZYOkWSzFq
 zr0K3qQSe2rS0BbpXOoAetC7DBGyJCgNnDpc2I4GX7kd7o38FrDyHWcpibywL8jRUl9X3TdYru1
 DS/jxNd+elUqinbK04syIknyuk/l1BdU7pRDjtC78FilxjZvmmhYlr4D6RCwUY13Km0/8MCFa2n
 ZUk6o5e1tR+Sn7rPXw5ly+X28JjgVuNnirJS6VXCVv2Q5T3gPdDoS+5PeDdVpefh+/3lPDnDAvX
 AYHB/0RQ2ON9qxktMRKox2BfdFd24hOt9Ob35WOPVIZugZ/bmLbzOnTYCI5FQ9z2RMkJ2cD26Q5
 O/ywxfLKSPgiViIP/gMimjM81UhD9o4SZEzoWnAqPIpDqXt7nEpbjaSiDTA7hDwz+U94XIHTj/E
 4kB1fnDvch9GqD8MnlVpw090HPi
X-Received: by 2002:a05:6a00:3012:b0:84a:29a7:f650 with SMTP id
 d2e1a72fcca58-84ee4636b18mr804148b3a.0.1785525307719; 
 Fri, 31 Jul 2026 12:15:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe39ea968fsm983834a12.26.2026.07.31.12.15.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 12:15:06 -0700 (PDT)
Message-ID: <2efdfc06-b522-40f9-9aca-88d1a258ea14@linaro.org>
Date: Fri, 31 Jul 2026 12:15:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target/arm: Add FGWTE3_EL3
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260724030616.76180-1-richard.henderson@linaro.org>
 <20260724030616.76180-2-richard.henderson@linaro.org>
 <CAFEAcA-BkEG59qM8sRtEtD-Y0-LC5sWfuWhMFTLnEcGDcvvDmQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-BkEG59qM8sRtEtD-Y0-LC5sWfuWhMFTLnEcGDcvvDmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 7/31/26 09:30, Peter Maydell wrote:
>> @@ -553,7 +553,7 @@ typedef struct CPUArchState {
>>            * FEAT_FGT2 will add more elements to these arrays.
>>            */
>>           uint64_t fgt_read[2]; /* HFGRTR, HDFGRTR */
>> -        uint64_t fgt_write[2]; /* HFGWTR, HDFGWTR */
>> +        uint64_t fgt_write[3]; /* HFGWTR, HDFGWTR, FGWTE3 */
>>           uint64_t fgt_exec[1]; /* HFGITR */
> 
> GICv5 also has some new fgt registers, incidentally; implementation
> of them in my w-i-p gicv5 branch:
> https://gitlab.com/pm215/qemu/-/commit/31900667e440a136c60b984c9e7c9e9a95d708df
> 
> I don't think there's any particular clash here, though. The
> one thing I do wonder about is that FGWTE3 has only a
> write trap version, whereas the gicv5 regs have both read
> and write trap versions. We rely on being able to use the same
> index for fgt_read[] and fgt_write[].

We do?  Where?

E.g. HFGRTR and HFGWTR have separate names, and could therefore can have separate indexes 
in cpregs.h.

That said, there's also nothing in migration for a given name to keep a given index across 
releases, so we can always sort FGWTE3 to the end so that the other names keep nice clean 
columns.


r~

