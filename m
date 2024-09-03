Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75374CD343D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUkE-0004Fv-8y; Tue, 03 Sep 2024 10:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slUkC-00044u-VF
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:42:56 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slUkB-0004lE-AZ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:42:56 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3770320574aso143320f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725374573; x=1725979373; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dBSo0p669m5XVMaDHmCdxfOvuVSl2FEAZOqKaTfV0cA=;
 b=l/ngaf7z/JHNcjNPi3Jt1YooM276JaMcHjOii4ZbFp4CNq8tFJA+HAh5YC28zjGbpc
 boZHtJylkjPZf7SO4VIkbUX084Ihe0wye6GY/sVD9ipFJ0Evi9S1MHqpM8OgM9yD+chZ
 x55UxgLylBU11gLlPjOoIWGYNRxkWy0awHhCNsZNA7lL4lX5BzieguhfRpDR8GFKRNGi
 5MfwKn7cIz5L4YbaBffBvGHw4RHyEw5aA1wf9XQpi48QTdUUGgCU+QvvT/MIjU2OhLJG
 5ZvH+iKLsIjV1QCg0Q+qX/c15vWAEBl6XuyO5R/+kqyLBqK+jpWi1voFdkc8a7FA3ZUI
 vNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725374573; x=1725979373;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dBSo0p669m5XVMaDHmCdxfOvuVSl2FEAZOqKaTfV0cA=;
 b=iSbm/H3F3XDwcwd4jDhSyb4/XbJ9ALXL6O79e3Fd3KSsbg95bftL/cusjlyd027MqH
 BItjzhUBi1hdhmQwPUQ61AcddXy7zTdFznzLUw1KFIDovip0moVCKv4JkO/gikp9JrND
 y+oa/nN6+dCJp/02PpnQahgQTOcxE/yj9Y0n+buPKakWYBUAhe7Lo2C1NZouKFcmR2dw
 MgvQGO04GAAFwpKQSRhPvydNjAWSG5H60tIK4KKxQBV699YNw8IzeHOFSUKC5BiXjXdC
 +HfsnqrYZe2nG+wbXgZr2/3y90vKQsT1bDlPkwZu/Oqmf01nzrOYpknwYpavgwrtm4cS
 jTTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2rUsYqogBEPwtgcJwYyAiro20YVCnzOM5OIKvnMvw1IQZXa9OdEb1vUHT+bcc/UuQ68YtnFk1VVgx@nongnu.org
X-Gm-Message-State: AOJu0Yz/wEcnLCofB/8roZu3w5RE+xVLHCDlsd2XbZ8+6roODO6mhO9K
 Aw7xJzdZYtqsBNdX3WuP4w+/vJC8Ta2iSw76No+uRp79dfz55EOkXUuk8v3E5wg=
X-Google-Smtp-Source: AGHT+IFZb40mFIJZQZH7ksoPykkM5neFaq7YIA4tOJrRiV+HgTtnqyCEPqw/xdu9LK3m+G+7RWvcYw==
X-Received: by 2002:a5d:4cc6:0:b0:371:8c06:82ee with SMTP id
 ffacd0b85a97d-374cd0d4572mr4521562f8f.49.1725374573390; 
 Tue, 03 Sep 2024 07:42:53 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-376548acb59sm1895226f8f.58.2024.09.03.07.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 07:42:52 -0700 (PDT)
Message-ID: <a0688913-432e-4230-9d72-21af402442e8@linaro.org>
Date: Tue, 3 Sep 2024 16:42:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] target/alpha, hppa: Remove unused parent_reset
 fields
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nico Boehr <nrb@linux.ibm.com>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
References: <20240830145812.1967042-1-peter.maydell@linaro.org>
 <20240830145812.1967042-6-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240830145812.1967042-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 30/8/24 16:58, Peter Maydell wrote:
> The Alpha and HPPA CPU class structs include a 'parent_reset'
> field which is never used; delete them.
> 
> (These targets don't seem to implement reset at all; if they did they
> should do it using the three-phase reset mechanism, which uses a
> 'ResettablePhases parent_phases' field instead of the old
> 'DeviceReset parent_reset' field.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/alpha/cpu.h | 2 --
>   target/hppa/cpu.h  | 2 --
>   2 files changed, 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


