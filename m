Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA38AC87FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 09:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugKMM-0000l4-E4; Mon, 28 Jul 2025 05:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugKLs-0000Qi-Ed
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:41:11 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugKLn-00058j-GV
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 05:41:00 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b782cca9a0so971361f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753695653; x=1754300453; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GTmVF8EzinVjukruiFg50rLNKD93OsLskbp//837ESg=;
 b=PCQhPgtQhmDgYfCyR5HNniWRXKNwf0mx4IQXD/tYd/rbRt687moBYcSbZ8poEsCk5P
 3zw/zsm2uCeWhL7V5NxZoY7DbcDizEpKpqC6nEUkk0wkhkiX/QEU9Y8h2Stb/L3SW+R3
 qDM6V3Fnd/cR7M3TZqo6RS014PuvvRr9AUPej+su4r0mGNY4aAVsNuf+9eDg8NzImRbP
 HzSVPu1+9ilNR81mLDO4qIHW7hwb9T5hGYLQPd0uxLBOtyoFAi2dZL6uG/uCVj/M14Zi
 MxNNgWlinT1HMO6ki66pqYSvyd2oEu6xYOgkqwL+7FzxDMs+Z9OuVdNdj8WFIDMyM7ek
 5Mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753695653; x=1754300453;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GTmVF8EzinVjukruiFg50rLNKD93OsLskbp//837ESg=;
 b=HgpiVuekjlLPaoX99z7s23q1co3Xlv5yiA7YlO7Xq0sL42b21Mq6wEU6ta86HCFUUK
 qj1P+QGxgh9kwVtqu0bzejNdXFBezYtMxMcZsvMRuxNUbjXgGZpkvM2jbeS8KWeRsVJv
 DvglAYBiSEL6a0s6AiZ7KgPv14RaFy9v57NJPju0JvYflj8gUdrqK2S1v63VQsgFInAp
 TJTDZf34vD11bC95VN5Lhu3Wo3LIiG4bIlcyvLep2EvYNs6p/CyaBiM5D1hp2C6j4BLg
 nwImD+gA7FQ+BdO3aQcxJDLoEeL3Rh3bjcPW5vy4UgVmwluDeyei1jDhy/+pFF2WCNTC
 O/zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ7Tz+1sl8r/bpLKT1T6JuhQ0wYy/Ufh4B8X9EwJhgVLBB7VA8CaQtLQ0q0tMxiSUqe+zLE4tYrWjs@nongnu.org
X-Gm-Message-State: AOJu0YxmAAPMcduR8jwoawsyvOVjvE9xs3rVuc28O1Yp4Y+hDQJIrs8H
 3hO5HSFgpVxhUSveAA3f7TUl3v/rKOwLyp2hnQzgUT48sITU26TcwIVpdSksUB4x27M=
X-Gm-Gg: ASbGncuOPFHQz3uOcQ038ktWx10axo1Z3iLjPkYJzZ9Tj4E3HYSIiQG9d4zPjAND1Qc
 ed32YcuFVLxpkNOyG5b3TuuTygsZHJJu6glSOEbMGz21aYcELFqMy/iRCVhTY0R+yxCiLTewF2z
 cKh0c4VS8yI6abL5+4dwlI8i+3t2hMquxjA12LK4BKfw0eHX44odHiJSQ1RMF7m+b5V2KNP6QHC
 cRnQP3qv/p4tiH/FXlDlBAK240unw6a25l8zyXSs5UTncScaclzUmMkPOlrBkjpcH8Fdyu+Vlsz
 Bey8l6mk7QTlL0B30n6q+lp9uoL/0LcFVOSeuRhciy54f5zpga9svL2T9hf/ICEX3Ifw7dM7wT+
 wQPw4QmB5+DMESCz6RvtFvZnxZ5uhPWCiwOxiuVTAiur9zWjUwYM2MonXzQsi9QmNxA==
X-Google-Smtp-Source: AGHT+IECZuniptSAva8Gw0G8kLXySsZ7F2baCC5KX59cRDNH+MyJUuXMhEtlbB9WthsvxVzkDPg8eQ==
X-Received: by 2002:a05:6000:25c8:b0:3b7:75d9:5ee5 with SMTP id
 ffacd0b85a97d-3b776645f69mr6857977f8f.29.1753695653399; 
 Mon, 28 Jul 2025 02:40:53 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b78889682bsm2839587f8f.77.2025.07.28.02.40.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 02:40:52 -0700 (PDT)
Message-ID: <ccd22cc7-4bfc-4bb4-9e8f-39b31a3e6014@linaro.org>
Date: Mon, 28 Jul 2025 11:40:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NVMe VMStateDescription
To: chefkiss@icloud.com, qemu-devel@nongnu.org
References: <56AD2339-3C68-4466-86EE-CAF931987CB3@icloud.com>
Content-Language: en-US
Cc: Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <56AD2339-3C68-4466-86EE-CAF931987CB3@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 9/7/25 20:26, chefkiss@icloud.com wrote:
> Hello,
> 
> I am working with an SoC that only supports NVMe, and would like to be able to savevm/loadvm, and maybe also record/replay.
> The NVMe has a VMStateDescription with just unmigratable = 1 ever since it was first added in 2013.
> Is there a technical or other limitation/reason for why this is the case?
> 
> Regards,
> Visual.
> 
> Cc: Klaus Jensen <its@irrelevant.dk>

You forgot to Cc Klaus ;) Done now.

