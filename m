Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF829EDF045
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQM9-0004ka-J7; Thu, 12 Feb 2026 01:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqQM5-0004jh-NT
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:39:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqQM3-00080m-M6
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770878349;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ySDl3nW9Li55DERBDgoMljj1NloJNEsBQnU+H+anTHg=;
 b=Bs659RUc5DuMq+q/xYb/IPVPdf34L9E6HwTMkP6XfCz+xdQx1om5LCVOyR8FZ9A+RuutwC
 Z2tod8OzSOj+w+HxsM6B8/dfOf/PC+lv9KPSf0lD6sMW/mCEdCK9WIRDpo9mBpNJFsdEK3
 +vnQ7RClcyUQ3aK1nVokrovn+/rbh4A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-l2pf37_QPU-RMKecEajXQg-1; Thu, 12 Feb 2026 01:39:07 -0500
X-MC-Unique: l2pf37_QPU-RMKecEajXQg-1
X-Mimecast-MFC-AGG-ID: l2pf37_QPU-RMKecEajXQg_1770878346
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4803e8b6007so24822365e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770878346; x=1771483146;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ySDl3nW9Li55DERBDgoMljj1NloJNEsBQnU+H+anTHg=;
 b=W8+qyMJjjHBo6ux511Z3jbNMkCeZIGfMjaTJTU2L1ZjWpGrD00t685KT1LpfIleF2n
 adPJ9E9yZ1OGE36RFq1FgQKnpeg6HYdAWb2E+v0HV2YViH7LWx8G/YvyVM2iwt3PTRU8
 YQjb4oeIjp2hZrhGcFkq9NoeUQILBb+yk4CEAFdqcL5mkqBGe6TImepWCk784imQZ0d5
 /Bgu5H441oRDH/OtooMqrGG6jrB4Yns4tTvDe5Ux90RJTxvXY881k0RpMrt+WPvRVIxc
 /uhhVT2B0AvPiOtIc/bJ8ryw0oBax2XJeetU5T2hHsNlc7xKnnijWXQ9beQh79kK4MMo
 /Siw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6cNySkdRzXo1z4Bc4TvQEIrvaS7Hrs8uZ9HirSLTe02sAD9iAEV+9SdgmHgdoqAXUuWrFO+zs3V0k@nongnu.org
X-Gm-Message-State: AOJu0YxYJRGLT/NcwIIb9te5tc70YvceYiqlCl7S0sHcLSnrzpwutysY
 fcLvaYa5C8n0j9E86csRU9IsizUcsmmVAPzmkElZ68gn/HSE4HWSQdDS95s56H+PYSsj1kjI5Qs
 Aol5bqZfR1ZSuYeoYj3oAHvCam81F9BYU1AWoTJ/3BuAVm//q8gxjuh6E
X-Gm-Gg: AZuq6aJ7rp8SPhp03wl1HLFyaefIFtMTr5tS3KU9i68zzTUxJzGSTO5AMdP6A5zR+Sp
 pt+9HWDwjC6bs5Y57FYZZO75cQweC+LgL8ULJ5DbJcf320LGb7xhWqb8hzX21rL45o5q/8MD1n9
 4FWIfqHmkCHGod721ANjIl0UFl8vT7vghcgPbq0MZsxoM5Y5Tg5irWj1lYWzT+4GT5X7qOzWdE3
 d2XpQWGywX3k+Jar6gl8TSD2BlzmvoA0eoBwQFQe2Ixba/xR62+VxJq46FNKajhAG8WiIaMVWbZ
 afVYAYuzKkRrSav5rGuYiu6LU/zD5BPhRtiFJF3HQ/OMBjRsV45cdcY1As2egDYEkQKDbIPp3Mo
 Yb2wDDHNX+wKoEtNvDz+78LyP5Ebi6KlckodW+CXA9SVHVUkvTMeBYmArUhtXhF2AViO6Tw==
X-Received: by 2002:a05:600c:c174:b0:483:3380:ca11 with SMTP id
 5b1f17b1804b1-4836717eba9mr13080505e9.33.1770878346316; 
 Wed, 11 Feb 2026 22:39:06 -0800 (PST)
X-Received: by 2002:a05:600c:c174:b0:483:3380:ca11 with SMTP id
 5b1f17b1804b1-4836717eba9mr13080255e9.33.1770878345944; 
 Wed, 11 Feb 2026 22:39:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835ba3024asm56922495e9.5.2026.02.11.22.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 22:39:05 -0800 (PST)
Message-ID: <39acf072-3227-442b-acfe-658829071917@redhat.com>
Date: Thu, 12 Feb 2026 07:39:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
To: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
 <20260211083415.133534-4-skolothumtho@nvidia.com>
 <aYzFeMh1szhJlJJk@Asurada-Nvidia>
 <e66e82d6-0953-49f0-9d84-bf2776e8f3ce@redhat.com>
 <aYzJhEFg/zxtrJ8z@Asurada-Nvidia>
 <CH3PR12MB754855AE35A087B900B0C311AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aYzTUDmTzIZZCwnW@Asurada-Nvidia>
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aYzTUDmTzIZZCwnW@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Nicolin,

On 2/11/26 8:06 PM, Nicolin Chen wrote:
> On Wed, Feb 11, 2026 at 10:43:04AM -0800, Shameer Kolothum Thodi wrote:
>>> On Wed, Feb 11, 2026 at 07:14:40PM +0100, Eric Auger wrote:
>>>> On 2/11/26 7:07 PM, Nicolin Chen wrote:
>>>>> On Wed, Feb 11, 2026 at 08:34:13AM +0000, Shameer Kolothum wrote:
>>>>>> +        if (local_err == NULL) {
>>>>> Does eventq need to rely on !local_err from cmdq?
>>>> if local_err is NULL we can safely use it, no? Or maybe I miss your
>>>> point. maybe test !local_err directly?
>>> Point is: if local_err isn't NULL, why can't we allocate vEVENTQ?
>> Technically nothing prevents that I guess.
>>
>> The only thing is we have to call error_report_err() if local_err != NULL
>> and then set local_err == NULL before calling  alloc_veventq().
> Or should we use:
>
> include/qapi/error.h-402-/*
> include/qapi/error.h-403- * Append a printf-style human-readable explanation to an existing error.
> include/qapi/error.h-404- * If the error is later reported to a human user with
> include/qapi/error.h-405- * error_report_err() or warn_report_err(), the hints will be shown,
> include/qapi/error.h-406- * too.  If it's reported via QMP, the hints will be ignored.
> include/qapi/error.h-407- * Intended use is adding helpful hints on the human user interface,
> include/qapi/error.h-408- * e.g. a list of valid values.  It's not for clarifying a confusing
> include/qapi/error.h-409- * error message.
> include/qapi/error.h-410- * @errp may be NULL, but not &error_fatal or &error_abort.
> include/qapi/error.h-411- * Trivially the case if you call it only after error_setg() or
> include/qapi/error.h-412- * error_propagate().
> include/qapi/error.h-413- * May be called multiple times.  The resulting hint should end with a
> include/qapi/error.h-414- * newline.
> include/qapi/error.h-415- */
> include/qapi/error.h:416:void error_append_hint(Error *const *errp, const char *fmt, ...)
> include/qapi/error.h-417-    G_GNUC_PRINTF(2, 3);
>
> ?

Usually error_append_hint() is used to append a user friendly msg that
helps the user to fix the problem.
In qapi/error.h there is an example that relates to "Receive and
accumulate multiple errors (first one wins):" by using error_propagate()

Thanks

Eric
>
> Nicolin
>


