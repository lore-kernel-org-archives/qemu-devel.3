Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61282C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsng-0002lD-RS; Sat, 24 May 2025 13:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsnY-0001qw-I2
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:36:40 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsnW-0000od-Ox
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:36:40 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so6496035e9.1
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 10:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748108197; x=1748712997; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bDq2Qvy5DE+fPUK7WvtuLanbVmRCXKmNI1ktP0fMnwg=;
 b=xZcyQqVqD7WOba21AHq6fQWBiQbbz0NexOEIE37OsAEjoZhGsRz6AyYo9egPHsPMj2
 APY4Lk46VqZiudruSv1QfBm4oXeCNJsKzINvhNdHpilJCmllNdBi1cgSknC1pBMdScic
 BWsdjlmtwnh9UBgCqdMlXMokgSJLEltjPOTPMKJ9ws9xJJFVySp6nAISNJamps/0LvI3
 0VzBAIN4TfcadP+2M6ol7mhVditD24GRGoZg7uZ1I2/T3MumNiGNzD9JNwJgX66uTzPa
 /5KAlNk9ujyhosf+Aj58Wj2kc5/E/6ksLBQMjrxcdBk+MOY8PGvtaBzZ6bz91M+4o+CG
 sbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748108197; x=1748712997;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bDq2Qvy5DE+fPUK7WvtuLanbVmRCXKmNI1ktP0fMnwg=;
 b=ns2Z/6+iEMHiRm/K+DR9Z/YFI6o93lWt8YFj2IdnkJcuxcbNBBzp+cDfYBbAz+nhq0
 vJyS90uaOqxNC1oZIDDCizjJJ7BLRZ5Drrmu3enMYjcOtwATxXo6RTuwlDKVfbi0KgHT
 x2hdlhIp5o+M4jWFuFMJpnQPEzOo3f3uMkHfL3V5T57nFMLz+k+tqBX3LjtlGgn574Pb
 YmkhYG5J/Wxpzt9+9sTztnORiK9zkg7J1xaNV+F4jWcED8lLrO5T2E5HAdnamPZGoGr0
 gYKWdYILTzzxyqpkFpJgr8F0FjzvHVCt2ta+v87XUvQyDEUygGllpmyi0jOcqTt8Kzb3
 BVhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGnf6S+zhsQuJfImk4YqiXCDdOkiEGYQi+j5u1KojA3XvLijIwEIWIL4fCg0Oc750prirRrWEnpMdw@nongnu.org
X-Gm-Message-State: AOJu0YyWS3QgYgx5cKtHmK2yxb+n47X5BS18DEBM8TmYAfytoNsjaLNm
 YKOK2ck2VkMkScKpdIgVjt9Wk4SWb+9paFUgO1H75pNNjEZH7uaX8D+O5tQkuP7BFAs=
X-Gm-Gg: ASbGncu1eVVqnG1ELqsqHnHTTMJhbxv0hZPqwuEXvccfQk+iOPT0YBmpcS8J3GJcIZ6
 NNNFGHuW22AL1+z3XYgqKPPs26aAzvvGF9Zlk/wZ4CrlA3Q71qJFMi/NVB0QxuXpivJ/I2GReS7
 w9ssBVm1Czyl6Qhx0e9VfyBf69jOeGDGLcQnuX6KuLoOr4AE2iB7lTNHL/tKKa1DBOiUM3iNUlG
 8PfqLaHWYMukZtP0DzRjnlS/lR4aX08wF5PcotiZPnej0EkneUsQx7q1GMk74cblTTEhsHg+r5k
 kozWqeBOtRyI3klofPCHAqZxywmCqe3RNyFzflMAo5PPntZbrM0uVhqBSf84HaB77BNQXz4romT
 0
X-Google-Smtp-Source: AGHT+IFNJSccRM2AkUzZEGhdPAJurn9rF2QLqnZY4BeSif095Iips8Hu8TkKr7BDq33eSLxqCVbWlA==
X-Received: by 2002:a05:600c:4189:b0:448:d54a:ca23 with SMTP id
 5b1f17b1804b1-44b51f4c527mr49952165e9.8.1748108196814; 
 Sat, 24 May 2025 10:36:36 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f38142f1sm182847285e9.31.2025.05.24.10.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 10:36:36 -0700 (PDT)
Message-ID: <cc571ae8-a71d-4a2e-9851-01c6cc71f2f7@linaro.org>
Date: Sat, 24 May 2025 18:36:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/25] target/s390x: call plugin trap callbacks
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <cover.1747666625.git.neither@nut.email>
 <71507814db65ebc5bbf8e5944728a106f51e3808.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <71507814db65ebc5bbf8e5944728a106f51e3808.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

On 5/19/25 16:19, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for IBM System/390 targets. We treat "program
> interrupts" and service calls as exceptions. We treat external and io
> "exceptions" as well as resets as interrupts.
> 
> Acked-by: David Hildenbrand<david@redhat.com>
> Signed-off-by: Julian Ganz<neither@nut.email>
> ---
>   target/s390x/tcg/excp_helper.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

