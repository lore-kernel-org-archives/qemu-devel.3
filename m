Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F98C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp9ZD-00085L-Gb; Mon, 03 Mar 2025 12:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp9Yt-0007xZ-Un
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:26:41 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tp9Yj-0003yX-QW
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:26:39 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso30892735e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 09:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741022784; x=1741627584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CSreCeawk6aPyHUuUw/+V6K5AWOXRypxXTe/QVGQIMo=;
 b=lo5cJrL+I4pG66+BCdzA4Hu2cFaTC92BdrNxnFNTkfmI0Ejvg/ttpi37cvkb/30kBc
 XmAUucIjeY7mGzuqUK317xBtKlJausKOp299I+Diucl/eo0VjfiYz488MjI3E+FM9tvl
 nnvwXtebnTViqJXXHVeArfEbcHco+NFe+F9OqrYWanbhHg0cBjWzpCP/iVds20xcYx0/
 BOp36cZZ8UjDTVjZSiC5U2kXEpLl9uyFV8nonJ4SedYFRbu01LDptwdKx5fbe2BGk8RM
 8fgapJ/AydWH3jUNxpZkfJz8g26qe5/A48pUIHgH9Zt9AiJtp2vMLBmAwh1JC8tr/DFw
 RWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741022784; x=1741627584;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CSreCeawk6aPyHUuUw/+V6K5AWOXRypxXTe/QVGQIMo=;
 b=BHKvfHeIaQKq0TSAQTZ+plOm/yDuxQxWYTXMqfiBhk8UqMOe54Pe7vZjtKvbCDVN5k
 ovP7VrBRiPqaCVHDJcTKp8nPdPa9QADogU9ciPnu66gkb7poZELokT9b+Z41FPCdk/on
 INeB63oHt4gULhtEd8M2KiNjKeqwH4qkbio5dp2ZeTOnGi7+MbTXjYxVXYRXXH0ZVGbs
 2vzebMJbO4XQ1JmFsa6qmDj25w74Ediu1CfJlNmX/Y1c2UEDaFgHQh1PwDJCiC6Hi6m1
 tW5lBXpiiDAW8rXESNuWCsQnVi6txnsunO45i0H25kqybyXhlYu/x0RFegypqw+XavDF
 ksPw==
X-Gm-Message-State: AOJu0YwvFkkj4ctSPI+TJoYUUWBReIR7GJ3rYZDB3IMlEYqiVlO8Pd0n
 ckEFPNXFAatF/nTXg1+H2T3ri03QzFqsRIcTxxKRgew1GvOoABuetjYI646enbE=
X-Gm-Gg: ASbGnctNz19LDDmNtyvFPH5TmbsjD1fkUefAtqqjlXF5UAiATXAv8j8bmd5y0iTbHeZ
 hjjUkNv5YfGcrrZcWujImhNtdNGsC2Ub1uXsJPgeI6S8AFd/Bvcp6GxZQfhcQfCjsXuh2AxuIp+
 q7uZu4KiZvQ4EEKojHA3AqKXUtszd6L6AAhE64ygPmBn34yO3R/u5gh3vFKKqAMcpqg9Gs0V2b5
 vHLvLo9kh15KYnpUAIV9mtGtfoeHEPXFH+i/wGkloXhEHnq1rhk+V3dQwQTnUC9gqYSWlNyVP+x
 uuIHACTQzJX3VM/M3hVhYLneo96QsJPVrx5WsabS577Dnt8AiXsmFc/m8ivMDN7UJ87rE+WrSjA
 uoG7G/yTE+0Go
X-Google-Smtp-Source: AGHT+IHP+IC4BsKkRzN5QyizxabTw+lUQDxuXqG5BFZ4oWFcyz4gYIOVvQn+5GdnwcpbtLIWoLYf8g==
X-Received: by 2002:a05:600c:3516:b0:43b:c528:d0b8 with SMTP id
 5b1f17b1804b1-43bc528d48bmr31615855e9.5.1741022784143; 
 Mon, 03 Mar 2025 09:26:24 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bc743f649sm24034325e9.27.2025.03.03.09.26.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 09:26:23 -0800 (PST)
Message-ID: <24656a07-1f17-4762-9141-f7c6c6f066d4@linaro.org>
Date: Mon, 3 Mar 2025 18:26:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/11] New vmapple machine type and xhci fixes
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 pbonzini@redhat.com, stefanha@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, eblake@redhat.com,
 armbru@redhat.com, qemu-block@nongnu.org, qemu-arm@nongnu.org
References: <20250112210056.16658-1-phil@philjordan.eu>
 <20250115100747-mutt-send-email-mst@kernel.org>
 <CAAibmn2-vP1ukGwQ8cj6aswjVXMFGi0KzJV3xDPD8SKVH44emg@mail.gmail.com>
 <20250115103953-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250115103953-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/1/25 16:40, Michael S. Tsirkin wrote:
> On Wed, Jan 15, 2025 at 04:33:45PM +0100, Phil Dennis-Jordan wrote:
>>
>>
>> On Wed, 15 Jan 2025 at 16:08, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>>      On Sun, Jan 12, 2025 at 10:00:45PM +0100, Phil Dennis-Jordan wrote:
>>      > This patch set introduces a new ARM and macOS HVF specific machine type
>>      > called "vmapple". There are also some patches for fixing XHCI spec
>>      > compliance issues and adding a workaround to a quirk in the macOS guest's
>>      > XHCI driver.


>>      just to make sure, who is merging this? Me?
>>
>>
>> ICYMI, Phil M-D has already pulled patches 1 & 2, and Stefan has merged them
>> into staging & master.
>>
>> As I understand it, Phil M-D was also in the process of merging the rest of v16
>> of this series before discovering the GICv3 dependency/Kconfig issue:
>>
>> https://lore.kernel.org/qemu-devel/
>> 8554330d-fd9b-4fa5-b37c-161f70b71f7d@linaro.org/
>>
>> I don't really mind either way who merges this, but he might have some more
>> thoughts on the matter - there might be a specific reason he's so far only
>> picked up those two patches. :-)
>>
> 
> Excellent just making sure it's not lost.
> Thanks!

Now queued, thanks!

