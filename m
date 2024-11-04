Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1596D132C4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7xDN-0005UU-Je; Mon, 04 Nov 2024 08:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t7xDL-0005TC-Ap
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:33:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t7xDJ-0001aA-4r
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730727226;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bsKR/ZbSwcHqsurNqiuF+M7XrV5jICI7Kt7LjPLlYkQ=;
 b=d6UgYyCBG/mBxH1rpB44hl2g7x5WI4UsMblNyPo+vjEsZkj0urTvMILBTuxLYPbtA9+ktW
 BywHo5iOC7D2604BWytoEZv1BnyrgvmeJobDEmAbPOhBFrd/ws9T/O8/w8mi9bSbmRzWL9
 11RUFZTQr76LxDzOj4UMvGKKmtu9K38=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-j9sn-fGvPNu6B8ykQvvWww-1; Mon, 04 Nov 2024 08:33:44 -0500
X-MC-Unique: j9sn-fGvPNu6B8ykQvvWww-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d43e7acd9so2154281f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 05:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730727224; x=1731332024;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bsKR/ZbSwcHqsurNqiuF+M7XrV5jICI7Kt7LjPLlYkQ=;
 b=CP+3FksMlMRu7sKZH8yhumtrehi/CD+qvSrL3UHoWM8UX+DsCnbTxG4ZJsVcIiBsfH
 E8wIjCreFqI15lPzWaOwbWGScp6Z7cgFfWB58uGF7UwmPkgRforeTjxbuV7c8fsZkzLP
 FeWzMTdo7Sylfdvp61zkS1IgIkFChXBvMGWcDa+QbXU5jpqDRZoX/we/1tUvqhGoaP35
 5x17rfWwgjx98QKXwXswsDK1ZpqYpYGlH62wOCw9Rf3vMNV+pZkhxGfwjeW7S0S9AOVH
 HXytPJoi2sakkeQHTgP7m9619FTqZXBlYkA4gBNJLnHenNo8Yd1VtxAt9yBefF8CckfQ
 e3Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeEImumDWiU6ovTPh9j5fEeHAi/nRJ0tsCTdC1GDc2wwPlpSd/4vvYQ6pDTWbFUSOGAqDFgZdkBcT6@nongnu.org
X-Gm-Message-State: AOJu0YzjQtg6Xj4H3aqEoEKqMic7Bjg3BZSUzJEAgACAgPVBHOWCuazF
 bvVbx7rEmcPaaXTooJUoG/RlHS5BbqcQn+nEfnSNHXqCb1rAhioVdqKFH67+4b0A2mUl/66PiIl
 jScCQInPwyfaDM6nqpdAaemCh0mMku7vwLEdxPyYypy4KuohKJReg
X-Received: by 2002:a5d:4cd0:0:b0:376:37e:2729 with SMTP id
 ffacd0b85a97d-3806115ae83mr21401253f8f.31.1730727223768; 
 Mon, 04 Nov 2024 05:33:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELeWTIVJZeus8w+il4ddk4jSY487U1fuv7GwRz3yTa/j/J83SY2mSwYHUBN8IDwnbvY+HJzw==
X-Received: by 2002:a5d:4cd0:0:b0:376:37e:2729 with SMTP id
 ffacd0b85a97d-3806115ae83mr21401234f8f.31.1730727223376; 
 Mon, 04 Nov 2024 05:33:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d49dfsm13267277f8f.46.2024.11.04.05.33.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 05:33:42 -0800 (PST)
Message-ID: <f950f884-f5f7-4985-8825-ed5f2a10509b@redhat.com>
Date: Mon, 4 Nov 2024 14:33:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 14/21] arm/cpu: Add sysreg generation scripts
Content-Language: en-US
To: Marc Zyngier <maz@kernel.org>
Cc: eric.auger.pro@gmail.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-15-eric.auger@redhat.com>
 <86frok2jwg.wl-maz@kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <86frok2jwg.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Marc,
On 10/25/24 19:05, Marc Zyngier wrote:
> On Fri, 25 Oct 2024 11:17:33 +0100,
> Eric Auger <eric.auger@redhat.com> wrote:
>> Introduce scripts that automate the generation of system register
>> definitions from a given linux source tree arch/arm64/tools/sysreg.
>>
>> Invocation of
>> ./update-aarch64-sysreg-code.sh $PATH_TO_LINUX_SOURCE_TREE
>> in scripts directory do generate 2 qemu files:
>> - target/arm/cpu-sysreg-properties.c
>> - target/arm/cpu-sysregs.h
>>
>> cpu-sysregs.h creates defined for all system registers.
>> However cpu-sysreg-properties.c only cares about feature ID registers.
>>
>> update-aarch64-sysreg-code.sh calls two awk scripts.
>> gen-cpu-sysreg-properties.awk is inherited from kernel
>> arch/arm64/tools/gen-sysreg.awk. All credits to Mark Rutland
>> the original author of this script.
Sorry for the delay. I was out of the office last week.
> You really want to be careful with this. Both the script and the
> source file describing the registers are submitted to regular outburst
> of churn (I'm currently sitting on such a series). You really have to
> be prepared to see things breaking on each import.
OK thank you for the warning. It is now understood we cannot fully rely
on them and checks should be done on each run.
>
> That file has also been known to contain annoying mistakes, as it is
> all written by hand.
>
> Ideally, this would be directly generated from the ARM XML, which is a
> public set of files. However, the license attached to this package
> strictly prohibits its use in QEMU (or anywhere else). One day...
;-)

Eric
>
> Thanks,
>
> 	M.
>


