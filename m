Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC837C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 20:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6D2a-0004T7-Qz; Mon, 14 Sep 2026 16:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6D2Y-0004SS-EI
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 16:12:34 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6D2O-0005QN-Aj
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 16:12:34 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98fso1865107a91.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 13:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789416742; x=1790021542; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9ARoslV4j4nOCIsbp52vZPQJckL83oVoxpHpt8EKEdU=;
 b=znnssHrJfRtcrRaFkThmvqj8CEo05IVR/CXMDk18isUgZUcLh0objC1x2Xr295UNlE
 mdZGGEhW7Gwul1DzW9QVG/5rVL/uu5h5w03rjUAp1neEvzsEjjIIk2WtV7kPPl3app+z
 gS0SyOytGAachWi0SwKaDU/UorwCm2IofyIlGqiPTQreoCu//bsPk4zrpxT0sDW9eyv4
 3zw7dB1QLEEap67Q5RUPAswk8VIuu0UHdURm8MPLlZRNukLJwHq8DWHGxrpZ4k4axuW3
 gs4HhGq46N9p1UDMtuaUMxny6+n1pBpfXa4l2Ar82xm0y4AEjiZ6+4otxGa2JG4O0AlU
 0mIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789416742; x=1790021542;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9ARoslV4j4nOCIsbp52vZPQJckL83oVoxpHpt8EKEdU=;
 b=Og+lYXBHlU7PMVA7ivXBpNXhA8lcZ/3s9woDqizhMznZ29b+sMoH4tGpa3ZkjY2Nln
 cJ0K1NYIfpgWyHswshprKHLJRc3GQj+GliH01EGpEEeEGYkM9i8eJxmksL9BjA8vtOcb
 KYhFl6wYXWwUKc6OpbwyTz9j0Jm42qXvfz706bvZG/cyVEC/qnunBDp8OIvz/QzmPhYb
 HhHMvgngYCrjh9F5GYf+EXgmH/oPy13d2o/naaLa24+WOFVAQF4JL78kf3onTJNydN1A
 ZF7GNsebJgukMsbilMZgLKzmabcQmIEFecEa3IR8Q3dzNLyzG37BYRWyBPwDmAbq19sK
 U8+A==
X-Gm-Message-State: AFuF++n04u9IfKVePumplnpKI8Ddi9vMIfai8HyaXjjWuUrKNrtAhpCt
 kOd7ghsjrPBef7tcggFrGfMG5dp//WeQkh5W9ecGoMqKibDNbLjMppgeR5eHk+CkybY=
X-Gm-Gg: AYBFou3IkOk0WYYw0chDJxpAWOIqA1q07iHAQNu8RQFiEny3+D5eRcjUNRcEGoTgXh4
 7mqSF0MjRwXynAB5LvtGsdAORTeQlbidRUuBN0dfWKu3QZpIpj8sQtTbtg6OWvxjIBhkMCNvzOf
 r/H+GnC2/kFUOtkEvo9RkUaGSOFsl0LoP37gKZxPSJzohIxTpmD2D/1PQuxKuGXwyMWkOwUQ/fz
 mTMNen2686G+ahY2G/XxXS4AwuADpMOI8mpBY6Jg3gG3HGmorgA+PVX4sKjRF3dGtj56G0MgBul
 T0nOMEwXfkIGsFo/gRR2xl0F2hFIJTKNFg6h/gX7pgaxL4vwusVfzGbvmNgYfHprHdmCpjDWGY6
 k+tSV5FkAacV/dVE/lXm9VZl2+52dvSjJLQw4/7eVes33NOVIxk6bzpmVT11NsdeUmoi2vDCGO+
 pSOCWx4vRwysN2/VJI6TjjeZMJPAYg+b1siSZjLV2RzRglGgSSQVGNxt2SRwqKMWYGuirpPzHO4
 LLxvyomIR2PmYDb8Jv7woK0M7A9ZRqk44MrpuOue1qJN4lQ9kE7HL2vK5mKow==
X-Received: by 2002:a17:90a:6d97:b0:39d:ec43:df74 with SMTP id
 98e67ed59e1d1-39dec43dfbbmr5521453a91.12.1789416741896; 
 Mon, 14 Sep 2026 13:12:21 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:7164:7976:4c53:31bc?
 ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b97994sm49700053c88.12.2026.09.14.13.12.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 13:12:21 -0700 (PDT)
Message-ID: <0ff70c1c-cf73-46ec-9ae6-e2130bd1eb91@linaro.org>
Date: Mon, 14 Sep 2026 10:12:17 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/14] qom: report & filter on security status in
 qom-list-types
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-13-berrange@redhat.com>
 <7a47ed5e-fc50-4f13-8fac-455c6015d38e@linaro.org>
 <aqhTQ4pad4OOWCcV@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <aqhTQ4pad4OOWCcV@redhat.com>
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

On 9/14/26 10:04, Daniel P. Berrangé wrote:
> On Mon, Sep 14, 2026 at 09:30:56AM -1000, Richard Henderson wrote:
>> On 9/10/26 00:36, Daniel P. Berrangé wrote:
>>> @@ -161,9 +163,15 @@ static void qom_list_types_tramp(ObjectClass *klass, void *opaque)
>>>        ObjectTypeInfo *info;
>>>        ObjectClass *parent = object_class_get_parent(klass);
>>> +    if (data->has_secure &&
>>> +        data->secure != object_class_is_secure(klass)) {
>>> +        return;
>>> +    }
>>> +
>>>        info = g_malloc0(sizeof(*info));
>>>        info->name = g_strdup(object_class_get_name(klass));
>>>        info->has_abstract = info->abstract = object_class_is_abstract(klass);
>>> +    info->has_secure = info->secure = object_class_is_secure(klass);
>>
>> Why are you assigning to has_secure here?  I thought that was just for the
>> filter test above.
> 
> 'data->has_secure/secure' is for the input parameter allowing the
> QMP client to say whether the returned device list should be
> filtered based on security status, or include everything (the
> default).
> 
> 'info->has_secure/secure' is for the return value reporting to the
> client whether each device was secure/insecure.
Still not getting it.  I understand info->secure as an output.
I do not understand info->has_secure as an output.

Unless info->has_secure = true as an output indicates info->secure is 
valid?  But in that case, why make them identical.


r~

