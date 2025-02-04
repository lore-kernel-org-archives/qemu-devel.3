Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB30C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfMyF-0004jr-77; Tue, 04 Feb 2025 12:44:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfMy8-0004iz-PF
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:44:18 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfMy7-0000TT-6I
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:44:16 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21f08b44937so11311195ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 09:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738691041; x=1739295841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9tjjdmH2FtrX67phFJjpaJnbqrZuEhLiL4H3Y5yILf4=;
 b=cZc/w8PdfMN8hm0rkT1oUphwZ+yQ3mamY0rKQ1bHLIa9g/vkm1316A6QZMh3R3vxRp
 XQxvf5ju0p8nlDfjMcpz/7uFkMrZbUKuFcoKWuhY9/O3gRTnNhIaASm+wtpivAV7Gn+3
 9tcEkayKI42lluoKqkL6nJmx09rP6JJB12OVrpSc6eW68YqWP46vVnh+/R9aaUhTK3B6
 x+Y1+7W1Bz2Sj6nq/ZmzezMqqMhWCC8Qj6UljEWWXdL92nER+W2vWdvW5/zCa/e/ZFwn
 YXzlqwo5pMsS7mrERQIc+Aa8ubVR7gWO24lQuTVEGu6+d7X/n1m5bAscsVTnC5Hzp/fr
 eFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738691041; x=1739295841;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9tjjdmH2FtrX67phFJjpaJnbqrZuEhLiL4H3Y5yILf4=;
 b=IDESmOGWnGUIkiOayhL2mYdUVX+Q96JXnf6gr+O+HPTPsFVEU3XouARWTsC7OzIZ7G
 LeSwjJozcOGXnnlbSeyzznJ4aBz2v9t89+Wf6SVSG0AT9+bD1h2+73bBYce4qTFgc/JM
 UPjCMuwXcSoKpfr2S9Ti5VgRjmxfra7os/4bZoG729ZM/ZcHZEMarrVEsfFDQvhMjrkt
 Z/Qa5StN0JPtd34lU8QbvnqefxOU5g+KdiqMBYvZiEsx2Ve0vKt+EiINkIm3Zk1H4rRE
 M14rfaXgAnMMGcBcVOdJPCe9DW1jSydI928FjbLu4L43kkfFd5dWTC9iNv5B8GFBiwAE
 dXpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwKFd3O6Oy8wmjJYm2gMW+5HcnPIJusrKBdSyU3jy/nhKr5kWBdqT4dKa+I4Al2TjNr4ZKJrQJQCVx@nongnu.org
X-Gm-Message-State: AOJu0YzY5UBSvFAqX++/csBts2XkmCN88J5AjKCMWMIqcbtqqndIMT90
 6mYpAf6L58tDzB+7u7vmJsqvqode6lXJR7C59UQRebOxQIL710Cq4L092jZK9sY=
X-Gm-Gg: ASbGncuvNVcW9BLhFmvyPhYPl+nKIVl/T10PiW7F2ZEnLL3B/e9xeckHVNy2H/y4go2
 IJEFX96w5NY1BJ+ipFcG6UKkm361OZUF3HPp9UUuMrxxsQbZswFwOZ/OVIwRMdll/FODgQC2U/x
 FgrHFIzXgubzIgUa/TlyXSqSsq96mq9RtEK7SShW+gQRqGOK3Nj+VXF9Cysx4GKm6PRgekNlC4g
 /DrjevW4VGTi4wB507F8OIIn5QDnALHKTliykA05KXQrcBKhsRvCv76D17C5NcdQW4u1TbHh1NV
 NL9c7+Lq0EyEiL7rH+eLAVqzai4KzDV72Eqcb8tsf9dXbIhK+PPHNbE=
X-Google-Smtp-Source: AGHT+IHFhUKffgbyflev5b055IIKO1UPGRQc9l8sioY+iaAqPvTUcT4w+olBp/SxjTPSKWDgpAz8xw==
X-Received: by 2002:a17:903:46c7:b0:21f:2a2:3c80 with SMTP id
 d9443c01a7336-21f02a2416emr48266405ad.8.1738691041560; 
 Tue, 04 Feb 2025 09:44:01 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f0dcab345sm8752405ad.72.2025.02.04.09.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 09:44:01 -0800 (PST)
Message-ID: <068a42f4-0a11-488b-b41b-017c68906f71@linaro.org>
Date: Tue, 4 Feb 2025 09:43:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: Fix register selection for the fdtox and
 fqtox instructions
To: Git <git@miszr.win>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20250203140130.78240-1-git@miszr.win>
 <653F9E2D-61AE-4954-A161-D1347D1336C5@miszr.win>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <653F9E2D-61AE-4954-A161-D1347D1336C5@miszr.win>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 2/4/25 04:43, Git wrote:
> Thank you Richard for noticing the issue.
> 
> I have been able to create tests that show the malfunction of the FsTOx instruction as 
> well. I am however not yet able to prove(through tests) the malfunction of the FxTO{s,d,q} 
> instructions.

Destination register 32 should be sufficient there.

r~

