Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F2FFCB60B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWvR-0007K7-Fx; Fri, 06 Mar 2026 10:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vyWvP-0007JY-Kd
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:17:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vyWvN-0006Fh-Ru
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772810229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tR9P6wZJVn3Be7DBqKtwoMlRUtYfRrgjFxyxPPHBdIg=;
 b=GTOBI3zT0QB8m9YqkFE9VG+hPcJgDmdl08Ki8XOFE2fzVh6Omc5aIVPo/wHPfQdB2oNN+j
 2x4dbtN3y7ClojlRB6P2TcNLQ2F7297gHRjdQaOSYpyy/JCdj3gpZaZpjy8a/pzqt1WTkt
 fjfgb/BmGACWOi5rrEQcY0pwVcIjbOU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-5a0MiiJfPIyi8GLFZgwfTQ-1; Fri, 06 Mar 2026 10:17:05 -0500
X-MC-Unique: 5a0MiiJfPIyi8GLFZgwfTQ-1
X-Mimecast-MFC-AGG-ID: 5a0MiiJfPIyi8GLFZgwfTQ_1772810225
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-483786a09b1so94664685e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772810224; x=1773415024; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=tR9P6wZJVn3Be7DBqKtwoMlRUtYfRrgjFxyxPPHBdIg=;
 b=DzM6WgOexHweTq93+kL9JC2K9jat+TeNgwTOARelXbwaGQPsxTdDRdQjSzYBOoGWuk
 TCQ8FvuRt0cOQHjrPviXCe3kYD7P/ANfnAFGY10hB7kguUlWfO/ZtwPWpiLGi86NjzPU
 mYRHwMJ2gzeyPN+aHnJGFl37r1fKxoLCyNO22XTBPQLLfCNpqEmQxfRn9I90WfsvxwFa
 OZWpE1aU7VGgCojKffEx2vuj8ioXl/9wEywHA0GnBReW8XpDbUWpa7/WeiKMFeZwoI3D
 XT8bhrkvle9Shsshk1oQH9320XVUk2cM0rGyQ1iKBPlZNeYodyZVMc6LQNhv8/rh3Uy3
 8Qjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772810224; x=1773415024;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tR9P6wZJVn3Be7DBqKtwoMlRUtYfRrgjFxyxPPHBdIg=;
 b=ikwlz5lgiq1tX8g0G+wbKB96cPGWp35+bTRUHgdkJyAfNzAYA2YYTTsTsv+SuyafrJ
 aeFyKvjA8gbNMIhnIk9ZhDgoqJ2fjg49xo2Sy6vJC7v4+EZZNElYcsFJ/d/Kdp7gPUS6
 30dZPFO6cmyfKMOK31ReG3LnUYlN61adesb0qTgldDp63q3aiP3HwBoKzK283pHXm7xZ
 fcunO+F0e1fMcs6mur76VKHgxn2wUidMWJ86tHXObxT/IgnR952ruZYV+GgQKjp+6gRE
 nWzLOinRamC1oC13OQFjd3DxCbnNh0v2V5nUeNf4GDWJUfxf8xc4fcVEvbHqTSMudrqM
 SQiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx/P+KCaVKxrfTMRTb/HMnCptI9UcwPjSRTSqZp1sgDW4JCJrXXviYdS0D71vwoBnF74WZ5l87WKIF@nongnu.org
X-Gm-Message-State: AOJu0YzeoUjn8A6ZRndCvFGLnlgaKRbyL2aDXRIp0zsGkqebvnRx8l6W
 Ob5LKbqvFeFpxrz20kdCD/s4UbCznETeuWSn0Vm2xa/+GiRAVc/r8pH+yG9sFMr7IExlbav8Ubg
 7hf1T0cEhBwjw7T9s0EuUgAy0PolftKk+mjaXVrARR0mau98UJk7v8eqG
X-Gm-Gg: ATEYQzxK+rWFvRDpQlIWKU6oO5qQfQcQiSNIlSXkptxfXYGVCnDKLTOQv7JILBWIDYO
 4RyFVXtLSD+yRW3lm0b6wPWVS45Xkgur91biElXlfgGpLZ4TbtAD1QD8m+VXMfcgJq8oMGHLbEm
 nMuO7vxl4iQ8upPw2ZVLpOU1ikWyhq7MBEKOXTTLseSBBA6op25Qk5Bx8wYct4rkA6NstkpNfnP
 SIoOXLe8h4LhnESHIOKrVrGb3QERhFO3Lo3DnVO3AzXWAzXwve08zXEnNfz+gNGESZ22YX1zaoL
 BCa9PYthLhxdV9OIXr8C0KcQ8UscD+xafkzo8IVK9s4itfKzuz5hqN2S3iKuuAtXiAjbXHwaOeh
 PbF85BWGyCUfa9WMlpLD1bnUX5uuxECCajWW2GkhA2SKgM9ipxcI927CQ0pf2ld+SOyGw
X-Received: by 2002:a05:600c:c088:b0:483:79a6:e7e1 with SMTP id
 5b1f17b1804b1-48526919935mr36895315e9.7.1772810224557; 
 Fri, 06 Mar 2026 07:17:04 -0800 (PST)
X-Received: by 2002:a05:600c:c088:b0:483:79a6:e7e1 with SMTP id
 5b1f17b1804b1-48526919935mr36894675e9.7.1772810224049; 
 Fri, 06 Mar 2026 07:17:04 -0800 (PST)
Received: from rh (p200300f6af4a490003d6f56739ca055c.dip0.t-ipconnect.de.
 [2003:f6:af4a:4900:3d6:f567:39ca:55c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fb4257csm194675115e9.15.2026.03.06.07.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:17:03 -0800 (PST)
Date: Fri, 6 Mar 2026 16:17:02 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, cohuck@redhat.com, peterx@redhat.com, 
 philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v8 2/6] target/arm/machine: Take account cpreg mig
 tolerances in case of mismatch
In-Reply-To: <e60def83-cfeb-4c65-a4c8-44b20f8f17ca@redhat.com>
Message-ID: <10e0b91a-4c1e-e12d-98fe-2c92ffa9a223@redhat.com>
References: <20260304102249.1963784-1-eric.auger@redhat.com>
 <20260304102249.1963784-3-eric.auger@redhat.com>
 <5ddefbe2-3514-fda2-a933-e2df46b4db89@redhat.com>
 <e60def83-cfeb-4c65-a4c8-44b20f8f17ca@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="-1463806286-824434614-1772810223=:21642"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806286-824434614-1772810223=:21642
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 6 Mar 2026, Eric Auger wrote:
> On 3/6/26 11:51 AM, Sebastian Ott wrote:
>> On Wed, 4 Mar 2026, Eric Auger wrote:
>>> If there is a mismatch between the cpreg indexes found on both ends,
>>> check whether a tolerance was registered for the given kvmidx. If any,
>>> silence warning/errors.
>>>
>>> Create dedicated helper functions that print the name of the culprit reg
>>> and analyze whether a tolerance is set. According set the level of
>>> traces
>>> and analyze whether the migration must eventually fail.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> ---
>>> target/arm/machine.c    | 30 ++++++++++++++++++++----------
>>> target/arm/trace-events |  2 ++
>>> 2 files changed, 22 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/target/arm/machine.c b/target/arm/machine.c
>>> index 476dad00ee7..13b8a0b2220 100644
>>> --- a/target/arm/machine.c
>>> +++ b/target/arm/machine.c
>>> @@ -1065,24 +1065,34 @@ static void
>>> handle_cpreg_missing_in_incoming_stream(ARMCPU *cpu, uint64_t kvmidx
>>> {
>>>     g_autofree gchar *name = print_register_name(kvmidx);
>>>
>>> -    warn_report("%s: %s "
>>> -                "expected by the destination but not in the incoming
>>> stream: "
>>> -                 "skip it", __func__, name);
>>> +    if (!arm_cpu_cpreg_has_mig_tolerance(cpu, kvmidx,
>>> +                                         0, 0,
>>> ToleranceNotOnBothEnds)) {
>>
>> I don't get this. You apply a different tolerance type than the one
>> (potentially) registered. This check will only fail when there was no
>> tolerance registered for this kvmidx. But this can be changed by someone
>> registering a different type. 
>
> OK so we know the cpreg is missing in the input stream. If there is a
> tolerance of type ToleranceNotOnBothEnds for this kvmidx, that's fine,
> we just trace and do not report any warning. Otherwise we warn_report
> the issue but do not fail.
> Does it clarify?

Yes, it does.

It just feels a bit odd that we identify specific issues when comparing
destination vs incomming stream and then test if that specific issue is
tolerated. With the infrastructure from patch 1 I would have expected
that arm_cpu_cpreg_has_mig_tolerance() can already handle the specific
issues - something like:

if (dest[i] == incomming[i]) {
 	//all good
} else if (arm_cpu_cpreg_has_mig_tolerance()) {
 	//all good
} else
 	fail();


..but I guess I'm just missing smth.

Sebastian
---1463806286-824434614-1772810223=:21642--


