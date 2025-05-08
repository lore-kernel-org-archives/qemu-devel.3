Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AD0C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 11:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCzEz-0001Hn-5Z; Thu, 08 May 2025 07:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCzEx-0001HS-H4
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:16:35 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCzEv-0003V4-M1
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:16:35 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so7346275ad.2
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 04:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746702992; x=1747307792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tLpGJj5JVxvGr22T29T+1zI2AylCHOToJw4QpkIhvy8=;
 b=xLFjNnVTejS85nFhYrDaFJdY5RRAjCuEiUh5+IKU1tidV5XPP3Su6oZWJuORyPRVFw
 LNwUqRiwMHsgRg5O1bvzuLhnxcJBcSr8krkZX621KQg+jB6D41c9DnBCk0ym0YV2LWlP
 EIndmifCQIoJlZ8g/ygK6kxCV1zHqF7ZorN6RLSPzZZS7tHavCOeSIcTOi3Ncn56lVMk
 zyndbWwYBBD5nQ+PsV8PlW5sgqvMzxTenWvWV7buFkQg41zkcTda9LP84ejnGHGcqhGF
 2hYsi7miDKkHGbfPt3kRAaIqJxGXDdV/f9EbMqKhirX0DoiX+2fzYaiJTWpMSqjCKNl6
 EO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746702992; x=1747307792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tLpGJj5JVxvGr22T29T+1zI2AylCHOToJw4QpkIhvy8=;
 b=HfIt66dE1BZ9p9LlHE0pMXXrFNNCnXdRgzCVuOsErrXnsc7nAdc6SdqVZe65lA7WMq
 kf9PVfZttAHyb1e1RoDVOJEljtdIYX6hM5JwC5g8dfQvrgk0yj/fawnR8BFKMqSC2uhA
 YBcXlXJ5ekJk2jJ3Kp6Dl9SOQ02EypPQARG72I1xxZEcUtpnLrzBaxLzeFLFKF2IBOoe
 4o1V6YU1zBsoqrPxdfMZ4GWkXzgwXO00PHVmE6IAFwCAZGNriRph5vXCzuAL3CPcUlZ3
 RzusDTAwOYEq+zg8UCFwKSS5qIyqnHyth2JyXb/7Uzy4shJviOntpYGgJRsbkpDpUKdq
 lSlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5Ji30RibncwoI/XVVwLXYaUisMqDdxY0oDdN9GjW/95L97brtX9sK4SYIwteEJfkoAWxRQUX6iQCe@nongnu.org
X-Gm-Message-State: AOJu0Yx4YVS/xlOANxE3gnZONAFp9n2dvymwND+LGJE+6zemV0ce3Uiv
 xPoNZdxChfHVqJBpX+G3AwpFSoZcgGGAQOpnYLo18zImbF2YbKY8JUH9serY1wE3MNyRDKU+VNe
 XZoY3aw==
X-Gm-Gg: ASbGncuYW5wb9KEdxYFRddWOsNSWGZpJRxa7t4xMiB7Mes6YYOKFMaWhJsOvGbO4v6S
 ytPWnOeeqY4h4NJvUwtyAvSGRJMfZeE2WzX35KBE+2WnfbyZIPrIwjmLUmli9bWapoaAam+2bBm
 o6x39Qp1X7DazQAVx4GJjYjkGE6SQs4E11OzujbAgvewLpkuI7yE8Up234G2msr5PLwGrD6AxFr
 81JCrTai9vxyorQGNp/3QJj2kQhZmqZ8jwZ3S2YwUOnfNs16lAU87rcDeb9c5CJTL/JbyhZmcTo
 3BjUXWdQYp6LuEdSF8ki2zNc237TnV7Rrt6BbpheD2lzldrEUDZKsmhU0aBuORfqhWMQDuItC7p
 fkgGV0G0u
X-Google-Smtp-Source: AGHT+IES0b37rWFWyh/29Ng1D1PlXsbrUZzNXlSYMeiSi+zowKGN84cPJgBxqHYJwUET5Z6qM7ExCQ==
X-Received: by 2002:a17:902:f543:b0:216:2bd7:1c2f with SMTP id
 d9443c01a7336-22e85be8904mr33940135ad.18.1746702992204; 
 Thu, 08 May 2025 04:16:32 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3b7c5b8sm9420950a12.39.2025.05.08.04.16.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 04:16:31 -0700 (PDT)
Message-ID: <4f11ae0b-2775-458c-8dbe-e13cec44e509@linaro.org>
Date: Thu, 8 May 2025 13:16:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] include/hw/boards: cope with dev/rc versions in
 deprecation checks
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 devel@lists.libvirt.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
References: <20250506160024.2380244-1-berrange@redhat.com>
 <20250506160024.2380244-3-berrange@redhat.com>
 <09b0a1cf-afac-4308-89a2-cc22aba5699d@redhat.com>
 <aBxxHob9MK0BYHLw@redhat.com>
 <3b92958c-c99f-4c9c-96b6-c5fbaaec06fc@linaro.org>
 <aByGENuj1O-SJ_xG@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aByGENuj1O-SJ_xG@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x633.google.com
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

On 8/5/25 12:23, Daniel P. Berrangé wrote:
> On Thu, May 08, 2025 at 12:21:20PM +0200, Philippe Mathieu-Daudé wrote:
>> On 8/5/25 10:53, Daniel P. Berrangé wrote:
>>> On Thu, May 08, 2025 at 09:45:50AM +0200, Thomas Huth wrote:
>>>> On 06/05/2025 18.00, Daniel P. Berrangé wrote:
>>>>> When VERSION is set to a development snapshot (micro >= 50), or a release
>>>>> candidate (micro >= 90) we have an off-by-1 in determining deprecation
>>>>> and deletion thresholds for versioned machine types. In such cases we need
>>>>> to use the next major/minor version in threshold checks.
>>>>>
>>>>> This adapts the deprecation macros to do "next version" prediction when
>>>>> seeing a dev/rc version number.
>>>>>
>>>>> This ensures users of release candidates get an accurate view of machines
>>>>> that will be deprecated/deleted in the final release.
>>>>>
>>>>> This requires hardcoding our current release policy of 3 releases per
>>>>> year, with a major bump at the start of each year, and that dev/rc
>>>>> versions have micro >= 50.
>>>>>
>>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>> ---
>>>>>     include/hw/boards.h | 33 ++++++++++++++++++++++++++++++++-
>>>>>     1 file changed, 32 insertions(+), 1 deletion(-)
>>>>
>>>> FYI, this causes a failure in the CI now:
>>>>
>>>>    https://gitlab.com/thuth/qemu/-/jobs/9965651507#L163
>>
>> Ah, just noticed the same error msg:
>>
>>    qemu-system-x86_64: unsupported machine type: "pc-q35-4.1"
>>
>>>>
>>>> Looks like we have to remove the related subtest now?
>>
>> Hmmm shouldn't we merge this series on top of up-to-4.1 machines
>> removal?
> 
> There's no dependency on that series in general, just removal of the
> test case. We need to remove that test case regardless, because our
> machines will automatically remove registration of the machine type,
> regardless of whether the code is deleted.

Great then :)


