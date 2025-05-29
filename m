Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9951C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 04:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKVDQ-0006ZQ-3J; Thu, 29 May 2025 00:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKVDO-0006ZC-6s
 for qemu-devel@nongnu.org; Thu, 29 May 2025 00:50:02 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKVDE-00053h-Fh
 for qemu-devel@nongnu.org; Thu, 29 May 2025 00:50:00 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso527707b3a.2
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 21:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748494185; x=1749098985;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zURfk3t/4T9Ns1uELAvTGqS01V0Qg6T+nBhQOzSGot4=;
 b=0wP3zYMdnObY4XTsRe5CwD30U9HwdIdZIdzm0KvA0pytwZdEFvWu3Pkd7Y8euYJpOS
 fQPYVQA39EgXSeNYl7suXC3Pco1g1pMRdn5ibQD1Ff/YeZX9UAtDTg+DSOFSzhZRxmOs
 yr2R5qbOKXVfR6U85r9HgnvWhR6aLCW6RkU58i2cyP9dubywnK5vPdj4+Z3A3wiUEEOE
 Y7ZCwM94Py/ND1e8RGIMDdt9tKFrqGjbwb4/KTHIXCaQD/oV5ABEkqgGsVyhVCQp3yHO
 vvCopyKOZX24Gcbik/8y+1beiKaKqsCrmBc9H9rhFOuFbplsZQd2QlQMeQx0eJkDDfAF
 nUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748494185; x=1749098985;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zURfk3t/4T9Ns1uELAvTGqS01V0Qg6T+nBhQOzSGot4=;
 b=IBIhhvw5mOOZgZJqq6IqUodMAmBXACNO7ZtqUszs/tX4ybJgGF+bexl/rcMLs8L11M
 KYgYwIRrwQRgePNjauzYvrV+pmUBQnirTzL7EpzOTGhQgPTyVeB67IFzvi7evnkWrVBn
 xwT+SFDO6wa4wbA8rnMjhwVJK1eNIAgRYcx7j256y+y1uvmNLQeC+2VjCtkTJ2Q1a7W4
 hQ2WMDglcA0i+9AuwH3nvc0ulHWe6+NiwKrasmH602XG5Fw50lFtWPVqYjsSIc/WTJsY
 ljOoZTV6iavAoTYztNDZ4Q9UmtvrwxW99rLdnZurWp9EM3SO+eTaByxYFdtebP67JjhQ
 5G1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq9b0s4bNJ4s5+WANClUDRCEXiYKEwIHO/RogS2KAUwEHRvmc/czmBzWQ4lntUGw6P8WyCUBpkJ8dI@nongnu.org
X-Gm-Message-State: AOJu0Yw2OkInkQgVcAJ8V1BuHJcKwHX0htMdC0XWy22juj31pq2XI1JN
 VB94eBxR0qy6qV8r2hQhKYdLq1vWs2Ixsw1qTtxzWYbFARirWipiqvsUJ+L21sY9ekI=
X-Gm-Gg: ASbGncvkFem6RXNGdoep6Nq9euH35LWEDKxcgRKVpq9cI+HvMhn4Ki2bWV/Qij/jMZK
 +EZqZp1gRMNAKKcnO+1ZMCDHMImh7clch6hBg51/uca1X2uqC5MjHZzCJwCGuM4aNRejFw8SMks
 VyPsHTmSpNEG0OrktfImZWSKczYYY0diamj1bDtczt2oseLtwHAfGKUMoCIQZypFqL7OPIh5IFH
 14NpawiO2nhUc33SYAc7hWA0cm/Uu5h58agecFFW0jlklKjYSHRptdfIBtIqkrummM9rDPQE71Q
 W9YR1EIxlj+O/j3QnVQ7ux808gwDAPjOc9XXE/KKQj/rxch85Mh5hRFGjf4N9f87VhdcaqWo
X-Google-Smtp-Source: AGHT+IEvKRPXoxgXYxC4Iep5me+SlvL8s6f/ZPdV2cjjMM2SPNbJbCzXSUJ3GMjYvqxBhPn59ofGgg==
X-Received: by 2002:a05:6a20:9185:b0:216:1476:f54 with SMTP id
 adf61e73a8af0-21acbaf17a0mr1282644637.38.1748494185396; 
 Wed, 28 May 2025 21:49:45 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afe967a6sm461343b3a.1.2025.05.28.21.49.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 21:49:45 -0700 (PDT)
Message-ID: <31b15d51-42dd-4bce-ad2a-429fd28c0d17@daynix.com>
Date: Thu, 29 May 2025 13:49:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] hw/display/apple-gfx: Replace QemuSemaphore with
 QemuEvent
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
 <20250526-event-v4-11-5b784cc8e1de@daynix.com>
 <8905dbb0-a6b0-42e3-98e6-095ac2b9e8d7@linaro.org>
 <eb4b90f7-eeff-4491-8b9b-3545aa87ff00@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <eb4b90f7-eeff-4491-8b9b-3545aa87ff00@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/26 18:29, Philippe Mathieu-Daudé wrote:
> On 26/5/25 11:27, Philippe Mathieu-Daudé wrote:
>> On 26/5/25 07:29, Akihiko Odaki wrote:
>>> sem in AppleGFXReadMemoryJob is an one-shot event so it can be converted
>>> into QemuEvent, which is more specialized for such a use case.
> 
> BTW it would be nice to document that in "qemu/thread.h" API.

I will add a documentation with the next version.

