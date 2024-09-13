Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EC2FA3755
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 13:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp6mC-0000Hw-SW; Fri, 13 Sep 2024 09:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sp6mB-000092-D3
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sp6m9-0007Zf-JY
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726235752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZDwk7YDrQ2e1pyc+t/UgpfNBP5kXg6q49n0Bbo0X28s=;
 b=H+0ynSHZweBACMKIfR0Ikte1TntAuxXodAWNCCQE3aOOhx6TD1CiRvvN6jxhYn64iu0vzi
 99CNA0rIo+czt0/qCd5l1ZByHpIQDRS0WGnHhxilmzW0qPGVZCD+xbxU7DRIdpXzcwv1Lh
 etEvZYnEs/PnJKdQvhqls46IjKT3t18=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-IrvCc6vFOSiVh4_QajQQ3A-1; Fri, 13 Sep 2024 09:55:50 -0400
X-MC-Unique: IrvCc6vFOSiVh4_QajQQ3A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb115566eso9150775e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 06:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726235750; x=1726840550;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDwk7YDrQ2e1pyc+t/UgpfNBP5kXg6q49n0Bbo0X28s=;
 b=fuo6sQPIZyqZIsLN9sqnb/OdKA4tP6zTCjyWJxOxO30tZ+6ZrHxZLfzMbuflVEhB47
 aCMiF/aHwMCg+B2KAJ/sN+OFSIUPU1xSiRSZ6ocEGqemGfbC1RQnqp76I+gkcWLVFsQ2
 2xwGdzvSE5p+Wy6J6dLidOtAYAX9/hStOof2uyE9LnTh4O31TOxN7YQdHNUP+zMuRUCq
 7CgUJDD3JRWVUH8fsFyVkTtp7/Ko7uXBgN27H01YldxUAZ4dE/fBcSRyDUCvTpoK5C0S
 8C8avbawzcy++dDh3ACunkJN3zli/IzxxOORgpjy1k+yipaS7BdB9Aobqh7u7OIoOD/y
 Uc3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc/A3rwuj+jqJW2EJAlge1teXLqYyc2eu2PtUAc4NrzhR/nWXAi6YJO9yP8li8mLeFxZvNg7I/QjIa@nongnu.org
X-Gm-Message-State: AOJu0YxItiz6kyjuFjPfjC1lRFdsn5gx5jCE1xTRuVFihyi8s6zzRDre
 s3ZT3uYru4qp8y4FViGKzkBjTLaGeh0TSxwlKQqKChZupTkNgjb+7EoMlB0nyeYYxvG+WWeOFYN
 GcrELkCayDVOzFa/fHNrRK3I0PUy0b5H6Xeyur2vC0SMg/PxPLdLN
X-Received: by 2002:a05:600c:4590:b0:42c:bb58:a077 with SMTP id
 5b1f17b1804b1-42d907221a9mr29653175e9.14.1726235749675; 
 Fri, 13 Sep 2024 06:55:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAH2Co7RkFs7RnvMrqkOsnZXOvjUN1H+ZfVJcAnorvT63IjMRBH4gHvIIOgxXbqI2n50jTVg==
X-Received: by 2002:a05:600c:4590:b0:42c:bb58:a077 with SMTP id
 5b1f17b1804b1-42d907221a9mr29652895e9.14.1726235749150; 
 Fri, 13 Sep 2024 06:55:49 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-42-177-39.web.vodafone.de.
 [109.42.177.39]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b05d5dbsm27473145e9.13.2024.09.13.06.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 06:55:48 -0700 (PDT)
Message-ID: <62d9e2d8-cfe9-4147-bd97-13866d61e271@redhat.com>
Date: Fri, 13 Sep 2024 15:55:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] .gitlab-ci.d/crossbuilds.yml: Force 'make check'
 single-threaded for cross-i686-tci
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240912151003.2045031-1-peter.maydell@linaro.org>
 <CAFEAcA-ZuE4B1frfnkpS6yxu_YiTastZ9S_b=4_8zGigRtDeNg@mail.gmail.com>
 <CAFEAcA9sUcspOwWU-huyza4Rp=vw=5wArXBSnV-KDVYm5=8u_g@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA9sUcspOwWU-huyza4Rp=vw=5wArXBSnV-KDVYm5=8u_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13/09/2024 15.31, Peter Maydell wrote:
> On Fri, 13 Sept 2024 at 13:24, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Thu, 12 Sept 2024 at 16:10, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>
>>> The cross-i686-tci CI job is persistently flaky with various tests
>>> hitting timeouts.  One theory for why this is happening is that we're
>>> running too many tests in parallel and so sometimes a test gets
>>> starved of CPU and isn't able to complete within the timeout.
>>>
>>> (The environment this CI job runs in seems to cause us to default
>>> to a parallelism of 9 in the main CI.)
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> If this works we might be able to wind this up to -j2 or -j3,
>>> and/or consider whether other CI jobs need something similar.
>>
>> I gave this a try, but unfortunately the result seems to be
>> that the whole job times out:
>> https://gitlab.com/qemu-project/qemu/-/jobs/7818441897
> 
> ...but then this simple retry passed with a runtime of 47 mins:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/7819225200
> 
> I'm tempted to commit this as-is, and see whether it helps.

FWIW, I just had a try with your patch, too, and it took 53 minutes:

  https://gitlab.com/thuth/qemu/-/jobs/7818945368

Older jobs without your patch seem to take ~ 25 to ~ 30 minutes instead, so 
the runtime got definitely much worse by the -j1.

Considering that we're close to the 60 minutes timeout, you might need to 
bump the timeout of the job to 70 or 75 minutes now, to be on the safe side? 
Or maybe really try -j2 first?

  Thomas


