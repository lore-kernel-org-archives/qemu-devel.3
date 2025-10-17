Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA73CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 06:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9eLo-0003Fv-If; Fri, 17 Oct 2025 02:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9eLm-0003Fm-Ej
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9eLd-0004nP-JG
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760684032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5NYUGkrAYUWUsR8UJGWDE8F6g6vFAY0AaAxE3o/FMAo=;
 b=g8Jx+rcSrYbO2o4vYGgxBmvPt8wH++E47OUujfGVWDX/LHAlXatdw2jbWNRVQGQ5S2FBwj
 /8Hw9ohNkozbpjPh8K78RIGicGJ5M4tBAFbWbRhT+W1WyBgk4vdLjZIPKQB4tkB+YIqwMF
 x3gYZmoLd4GZymhIPKrdIoi1LCR6gXI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-LNQ2ssHTO7WSCjVv5CTaKw-1; Fri, 17 Oct 2025 02:53:50 -0400
X-MC-Unique: LNQ2ssHTO7WSCjVv5CTaKw-1
X-Mimecast-MFC-AGG-ID: LNQ2ssHTO7WSCjVv5CTaKw_1760684029
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4710c04a403so14103575e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 23:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760684029; x=1761288829;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5NYUGkrAYUWUsR8UJGWDE8F6g6vFAY0AaAxE3o/FMAo=;
 b=VmSt5mdiMTdAMQPMwJMHtrlCmTEyH0zjk4rRzLtU3kl+RhQqRat0Jn26AsntPc5HVJ
 0/F22Si5Y1QEYJhKx2/cMkF9xUsNs1HjV9AN4dujjhSxbY8+pBJCyqeCx5EjXKSCcTOn
 tqcerHJ1jx1FKINPLfTDd1ESkz1bIHtdvmOesP7YhuIzIfch7SjkWBajxyIGuXunugKv
 hn+Rfe5iNUQOP7R8s18GP+PAbitRngl/4guLVy+2maQDOjgUD1Llr87ppzBhRSrQntb6
 HAZwB+bIXuwxEDOXinv4PlaykOOjnGIjVxBifaJa+3t36OrwFooSY6rd2G3dMRwho4gR
 FSow==
X-Gm-Message-State: AOJu0YyoXFMgJZWeEOf3m5MYGM0NtNQPsJE7jelKswBBpPCA8OwHeQzl
 OViKco4VCrYe9P3MP2gy3zseTkKwh2355ifnUFrGHrn/gM7wWmNjLGnE8iqErYBbIwaVlNlckQT
 +jniaM0aq4MPBcaGvsfTAKmcOVVNUMSL4G5itDfYKnGHdLmM0YDQfm3zo
X-Gm-Gg: ASbGnctnKNXszwhMB5uict/VbS1PV95WIJ/PB3heh2ZurrMJKUUgOBYgAuic/hQktPC
 +ExRDAYnWzJY7G6t9wdCY81TQMCKZG2MzwtgRGdaShKBx7VYLvL6bOQ5Pg9sCNefjZODa9ER/fB
 i3Hnoa794RAsF+CAtcZBnEWtMtPkO2qhH5ewM8EudeaG2o67ju6oJWlDTEbJvf3i5kOfzhhAhYg
 vUVYFmT801UxXzwjW+kNot97g80vBVfJ0WZ3ZYM7nTiGihfISAV8oHHotE/L5gBw+5plsYs//6e
 NSJxR5+UpMWtyadzvI7yCN+oQ6/heDRfuDTjEqcp5bHFWXNmB2ovD7Eg8BFxpSac30N+qUTLxGh
 LxB1q8q7so+8ypVctk6NzCVIuJ7U6xYMwfkhUXCfM
X-Received: by 2002:a05:600c:45c9:b0:471:115e:87bd with SMTP id
 5b1f17b1804b1-4711791c601mr17706745e9.26.1760684029059; 
 Thu, 16 Oct 2025 23:53:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbQZq6dcSOz7OzIaTXFqk7xGyDFQIDyWvps1axfFMhpg3H0z6T8tp7VQemBsrcFH2Rped7GQ==
X-Received: by 2002:a05:600c:45c9:b0:471:115e:87bd with SMTP id
 5b1f17b1804b1-4711791c601mr17706595e9.26.1760684028586; 
 Thu, 16 Oct 2025 23:53:48 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-135.pools.arcor-ip.net.
 [47.64.114.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711443e81asm68016175e9.10.2025.10.16.23.53.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 23:53:48 -0700 (PDT)
Message-ID: <a47eea0b-5f48-43b0-a340-d720621dc333@redhat.com>
Date: Fri, 17 Oct 2025 08:53:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SLOF repo mirror URL updated to GitLab
To: Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
 Nicholas Piggin <npiggin@gmail.com>
References: <CAJSP0QXLR5QkPwS62aGyKTTajwaXz-6bXzq8FNumW-HfMiQptA@mail.gmail.com>
 <aPFGJXe5gEqEQoIJ@redhat.com>
 <CAJSP0QVSszz0iE9Yv--9nRL6=7F8k_CcpWiFaktM5Z4P=KM9BA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAJSP0QVSszz0iE9Yv--9nRL6=7F8k_CcpWiFaktM5Z4P=KM9BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17/10/2025 00.58, Stefan Hajnoczi wrote:
> On Thu, Oct 16, 2025 at 3:23 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Thu, Oct 16, 2025 at 02:57:20PM -0400, Stefan Hajnoczi wrote:
>>> Hi,
>>> QEMU's SLOF mirror at https://gitlab.com/qemu-project/SLOF has been
>>> updated to pull from https://gitlab.com/slof/slof instead of
>>> https://github.com/aik/SLOF.
>>>
>>> Thomas Huth requested this change on IRC and I see that
>>> https://github.com/aik/SLOF has a notice pointing to
>>> https://gitlab.com/slof/slof as the new official repo.
>>
>> Just changing the mirror location is not sufficient. The most recent
>> commit in aik/SLOF, which was mirrored into qemu-project/SLOF, never
>> existed in slof/slof.
>>
>> We'll need to force push history to qemu-project/SLOF to get rid of
>> the divergence, before the mirroring will succeed.
> 
> Thanks for pointing this out, Daniel. I have force pushed so QEMU's
> SLOF mirror is now syncing with the new upstream repo.

Thanks, Stefan, very appreciated!

  Thomas


