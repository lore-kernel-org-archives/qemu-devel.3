Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F9610775F9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vJq-00024P-JP; Wed, 18 Mar 2026 14:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2vJo-00023h-QG
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:08:33 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2vJn-0003Uu-5g
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:08:32 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so909355ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 11:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773857309; x=1774462109; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WOhPiIQ73nztfzTsvKlilpHJ8UiayJHN/PdnFZXibio=;
 b=wBrMAd/nvf8l2Rpp9wtkGuMdcmhiz4Kr1HXaoVdmJ93KNW+HVXnqUC7K3YYbqg68w6
 cuoBNowOoV2p1YNwj2OklumKQWByP1WXlF6bQoFFNyEzzA+V/SUdXSFQmo8HUKXV6bb9
 6GsovWuPZU/ZUgEUZq5LPabCVubhN/qbUbt0Rw6CYGZ3TyEDMvPO3b17SqNSOSkDzvPy
 DZiFplqwUlQHCozQBUm051iGcAB/DODXu5bMvMasyb1TYHqKMOqeZCEXQLp0L61/YaKn
 GwyPDKjTnF5wqk0SJRyIUt8aVmOlA36cWqJjDgdQ0rngMYr7aVF2nfycOttSjukk1IK6
 LrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773857309; x=1774462109;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WOhPiIQ73nztfzTsvKlilpHJ8UiayJHN/PdnFZXibio=;
 b=ljfhx2VdZHjcAEcHxPv+wSHPVirqUZsPyNDrOLJoz1gGkAFxOVkTK1pWYL6seYpfwT
 64dnob0c5yIF1GNy3zWPXfKoDhOx/dzm63Q5tVCBFaCBjeLuojTQ477LJUDcDw/sIvQm
 ppIfv8vPiM/lggV5q5OaOp84QULUAMJZ4QYe9q/ijevG7ep/xpv6qN1XPPBhNUS26p5X
 FfG0ak8dAj3NRCeXykoAKXw6ZxIhCrgi76qYhIoM2JF3oQnR0UtQsffDMsbjJwtqzqrD
 cnouO+usTi+OEKCWDoS9TwOALBby4SdME0n8Tc0YwytBEJrDk0JRLtjDY1aB3fAOCdoJ
 dNpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuGa6mKRLCbPzwfoBhbWGYQLmuRRi1CrXdQ7rtAlH9d6TWzyxJU72sOCeZ7w2t6Z5Kuu02RcMtUmXe@nongnu.org
X-Gm-Message-State: AOJu0Yw4JEpKX3CTJWKCg3qLm4TCBvASvknKa/MhPN4h4PNMewF279CU
 sSAM89LT33c9o9WodYudXnG/KWE4lt7RpXTeelCNO0bzB5J6xTD1WyehsadqM1Gldl8=
X-Gm-Gg: ATEYQzwtKffdfXyLJmbxAiEjBY4S8colLEBfgN3k82TbrNNDDYhCTs2sSkiuAamohKe
 Z/dHN926mveHEa3fzlFbA/TQUynAH9A4prAjZ2yj4ZbuHF6ySxbUq8jX74OXu8vLr1U2+NXE6t9
 C/PaO9EVnXA3T9FkTfTzF9/VVYQ8TNsk1VxnKoUBce2BU1HAmzAm8bJn2vupXQ78KFpzWNFjMG3
 quxDJIcSaIGBizH++3k7rVyi+Sv4k+5JIwd6wPRT9YY3vOnGvYe2troic29TZbVL0wDUqK+BoUK
 I5SAEtuMue+KZLGtz932MriTMpF+c/3P8VuReldnby9xLuUAkPqSFsqztTcgvvhRoINCRj1ktyf
 dh1wesFYkLKugP0+qHPqlaf7YW9Fr7fgGPmvmjegRzeDqWA8VcpXkvBh+pS1x2ofPg5GEUol0Ty
 MMngKPXY0JEO1paTeKZiIkJFZVCPu2fw163EzbcOG6r6c2nC26MEr64XKfQYbS7lEdhnJM
X-Received: by 2002:a17:902:e812:b0:2ad:dfb8:8ed3 with SMTP id
 d9443c01a7336-2b06e32392dmr44710915ad.8.1773857309223; 
 Wed, 18 Mar 2026 11:08:29 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0704ccc67sm28600905ad.15.2026.03.18.11.08.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 11:08:28 -0700 (PDT)
Message-ID: <0380187a-b1fd-4488-aa31-8a1f1ab66b1f@linaro.org>
Date: Wed, 18 Mar 2026 11:08:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] backends/iommufd.c: report error when /dev/iommu is
 not available
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 Eric Auger <eric.auger@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>
References: <20260317225751.1325098-1-pierrick.bouvier@linaro.org>
 <20260317225751.1325098-2-pierrick.bouvier@linaro.org>
 <IA3PR11MB913683DE47A156F52C77AE7C924EA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <068a3098-4e4d-490c-9cef-ac39a7e9c29f@redhat.com>
 <IA3PR11MB91364D3734AA30AB6C474E1D924EA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <af3fdb2e-7c0b-46ab-807c-4c0527f6734c@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <af3fdb2e-7c0b-46ab-807c-4c0527f6734c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/18/26 5:18 AM, Cédric Le Goater wrote:
> On 3/18/26 09:37, Duan, Zhenzhong wrote:
>>
>>
>>> -----Original Message-----
>>> From: Cédric Le Goater <clg@redhat.com>
>>> Subject: Re: [PATCH 1/2] backends/iommufd.c: report error when /dev/iommu is
>>> not available
>>>
>>> On 3/18/26 08:36, Duan, Zhenzhong wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>> Subject: [PATCH 1/2] backends/iommufd.c: report error when /dev/iommu is
>>> not
>>>>> available
>>>>>
>>>>> In case current kernel does not support /dev/iommu, qemu will probably
>>>>> fail first because /sys/bus/pci/devices/*/vfio-dev/ is not present,
>>>>> since QEMU opens it before /dev/iommu.
>>>>>
>>>>> Instead, report an error directly when initializing iommufd object, to
>>>>> inform user that kernel does not support it, with a hint about missing
>>>>> CONFIG_IOMMUFD.
>>>>>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>> ---
>>>>> backends/iommufd.c | 5 +++++
>>>>> 1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>>> index acfab907c03..c4eb3de1307 100644
>>>>> --- a/backends/iommufd.c
>>>>> +++ b/backends/iommufd.c
>>>>> @@ -32,6 +32,11 @@ static void iommufd_backend_init(Object *obj)
>>>>> {
>>>>>        IOMMUFDBackend *be = IOMMUFD_BACKEND(obj);
>>>>>
>>>>> +    if (!g_file_test("/dev/iommu", G_FILE_TEST_EXISTS)) {
>>>>> +        error_setg(&error_fatal, "/dev/iommu does not exist"
>>>>> +                                 " (is your kernel config missing CONFIG_IOMMUFD?)");
>>>>
>>>> If hot add an iommufd object with object_add QMP, may this kill QEMU
>>> instance?
>>>
>>> yes.
>>>

Good point, I didn't think about it.

>>>
>>> Unfortunately, backends are Objects. So we don't have a realize
>>> handler and a 'Error **' parameter :/
>>
>> Maybe do it in iommufd_backend_complete()?
> Yep. Perfect.
> 
> Pierrick,
> 
> Can you please move the test under the complete handler ?
> May be add a  #define for "/dev/iommu" while at it.
> 

Yes, it works as expected.
I was not sure when the "complete" phase would be called, but it's still 
triggered before trying to open vfio-dev/vfio*/dev, so all good for me!

> Thanks,
> 
> C.
> 
> 
> 

Regards,
Pierrick

