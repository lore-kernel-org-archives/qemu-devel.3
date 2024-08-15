Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25648C52D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 22:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sej4E-0007mk-Gp; Thu, 15 Aug 2024 18:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sej4C-0007mE-CF
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 18:35:36 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sej4A-0003BA-S7
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 18:35:36 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70d2b921c48so1120456b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723761333; x=1724366133; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HdzScUTKGYJB5ILTcrQHqL3EBoSqU7A+8ZmJGHSjWoI=;
 b=XlxDyFZWAwRi905A2kSJ9o8aV8YHKur0W5TBzmaAp3udrGdP7CmYO0JOM6d5E8uEy9
 sy0Uz5qd4TxlsTIjp9INtRAAD4VpIBIpQ+8FCINFmqSzWz6dCLEF5AgujUgqDvez44hI
 fubCSFWQYfzI+VdDLqtefERX54iIjnye7e3tWvGufzYLk10vADXRnZytc97udeUOrYgx
 isiJVg2lixwpH8ApL5LFRtkndI86ETaWD3CauEUpfNwvEJIpFlohKEpe73mlkAyczVeD
 MAAmpdc+gNIyZrw14rOK46+vU9vFDWemgmPhC/hoJOi5AUHsBXjmP3gb49J7YFQrsH6H
 ZAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723761333; x=1724366133;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HdzScUTKGYJB5ILTcrQHqL3EBoSqU7A+8ZmJGHSjWoI=;
 b=rsKQcjh8puPMEoFXz2RGZR6E8iCh1crOiU1aX35Puks64mkQ3DtJD7P92W0O9Bxt3g
 M1cfRLptX3kbuJdx92y4ybYmr7/Ydj10UVF3hdFF2zYmcOhVmKuEh0zoW1pfJ9Fi0i6R
 oz22bxyaFXvhVkp0M5ERieU5iuFLXmdGl+YsPP+XkE44ksvQ7BEgzDz9EYtYjVjr6zUY
 k8V1+mAozueJneQBWeK3AuRCsjv3qw7N0+Ie+o086FMveev5+80ri0h4ysMW37Ja9TQz
 vM+ZlWORBHVdVsEKfrBS04usaPtUiu0KyJtkz8NYB6mH0Jdx7FSy31QsY4k8/SjdQKQ/
 hhRw==
X-Gm-Message-State: AOJu0Yy/j2Plzfs1LnNRqIfQJIgWeYP7dECxrKA9ePt9OpQJDcVlonZP
 Pj9RR+1Gu1noD1ci9dCfinWSmVMg2Rxx7CDGpq63yM5jucwEtZ6MbMUFFDAZDxE0tDgD+ETt3dw
 vzLc=
X-Google-Smtp-Source: AGHT+IEBUG50cmpCwLe7/3wsIsZ+9lI1VZSqxLrSYtooJEBvLd+vyoTGc1s/nrwNMiyHYIuO9O1XKg==
X-Received: by 2002:a05:6a00:6f6a:b0:706:742a:1c3b with SMTP id
 d2e1a72fcca58-713c4dff651mr1257966b3a.8.1723761332672; 
 Thu, 15 Aug 2024 15:35:32 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.109])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127ae08027sm1485917b3a.66.2024.08.15.15.35.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 15:35:32 -0700 (PDT)
Message-ID: <41a1f75a-a747-4108-a180-15c0c1f35c0f@linaro.org>
Date: Fri, 16 Aug 2024 08:35:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] Avocado tests: allow for parallel execution of
 tests
To: qemu-devel@nongnu.org
References: <20240806173119.582857-1-crosa@redhat.com>
 <20240806173119.582857-10-crosa@redhat.com>
 <1f645137-c621-4fa3-ace0-415087267a7b@redhat.com>
 <CA+bd_6LTqGbx2+GOyYHyJ4d5gpg4v8Ddx5apjghiB0vjt8Abhg@mail.gmail.com>
 <6ecd8981-f5d5-42d0-9769-82fbde55df23@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6ecd8981-f5d5-42d0-9769-82fbde55df23@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 8/16/24 02:02, Thomas Huth wrote:
> that patch that I linked did not set the default number of parallel tests to $(nproc), it 
> just used the value of the "-j" option of make. So if you just run "make check-avocado" 
> there, you only get single threaded execution as before. You explicitely have to run "make 
> -jX check-avocado" to get X parallel threads. IMHO using "-j" is more intuitive than using 
> yet another environment variable.

Seconded.


r~

