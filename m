Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A83AD49C66
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 07:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vljHO-0001PO-Nl; Fri, 30 Jan 2026 02:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vljHL-0001Ol-Em
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 02:50:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vljHI-0005n4-2M
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 02:50:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769759450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6B/LvtZl4yXmcFPnrFTb/mt2fBFqu3NhphB+9Chub0k=;
 b=eBl1uy2iMXywWMZ9L70z7NpQ4lu08AIegtaJxf9XxTSWWzv4XI/jW5rJG8/dcFMgzQSnTS
 mZ89ErBuMdcsSqa9z7Hi25bHjmYzj+nhNobokAP/7ArUFF9cnRwBMSgpGOTVSqmh3QCBQR
 qvFKBxukMyC8SufGHK0RLtsWj4se51Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-rOpI3NiQPAGPwR_o5e1z9g-1; Fri, 30 Jan 2026 02:50:48 -0500
X-MC-Unique: rOpI3NiQPAGPwR_o5e1z9g-1
X-Mimecast-MFC-AGG-ID: rOpI3NiQPAGPwR_o5e1z9g_1769759447
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4359849d324so1106658f8f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 23:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769759447; x=1770364247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6B/LvtZl4yXmcFPnrFTb/mt2fBFqu3NhphB+9Chub0k=;
 b=GAjsKRgeLcRaK5R8WwHqMZeITCYtQNp69+9MZY78+1ZHXWtEnSjE7v+XZofIb12wf9
 LqkXZFuUoudWkMg13EkPyVRAhcWaZ0HFb5YSp7irBFsOcaWnnJd/I2WFtQHU02oWP3ch
 apPeik3hi0ns7zXbfrItQ+uqzXzUpeb++w++UKIZxmJGsQYg/nbYHbfU1wTZHX9Z/Iu2
 C5FZXtgbJOH+veYOgo6FJ32Xlz1UV2zNZGuLpWtOcgSCtjMriYbJEWU4Y0rbTKvg/dXo
 yJU+nlHJfENf7TsZKJ1NtRAiNslRuMvNZMmaxqtw5T1j4V0wHG8Hx8hQQCGJyyuuMX4Q
 k8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769759447; x=1770364247;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6B/LvtZl4yXmcFPnrFTb/mt2fBFqu3NhphB+9Chub0k=;
 b=Jrm023DKcjldK1NSv6aESRfWtj1x9pyT3Ql6olDs6SwDJ+o5WDr2DDggCCiuOC9hIT
 DmcocYjBxRLNPP+8VFpVRsYKAWryjybcd/D7FL1fC42m9RuTSda6vSp2TLh5vsUUkmxi
 RfF9ZAU2gdau6XxppOxB5DrRRvGfAooLFFPs17bGrN47PLjLZtH3O4goWy+6+G71SS3Q
 W3Wmcj6ZAL2hCoxB3Gv5eudeK0oMLqPyWK8wbC6TwH/+QWF4PveX3z+Kj6IkWz6qGOBO
 mlLZGXjeL3NRwbLv7mWnV0phxDHdK8RKB3gcN1VXiHv+zCMlRC1/IzOnD8rzOwgHipKV
 s6jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3L9Mbn8KEblDu28JHbhiip5tk6QMXqIrXyM4UH3xHxNWpYLsc5eaTMb2zxKv44k85/g5JryAJCx25@nongnu.org
X-Gm-Message-State: AOJu0YyU++gKa5URUueaQnvYaugSmtepq4/7xoI3WIykrXPE6ctbQ/hi
 yB5A2ATNEx8bU40a+CJI8RtbPmNZNqYw/nVTQXPshwhwjyA6HDH5EnRReuxvw0DEmbmQflGz5gP
 yiKnRMzd7fhizrIAmWVtIpJSI6iOaUs9tzrbGMCf+9PTCU9DXINnaoCQl
X-Gm-Gg: AZuq6aKPlq+s+7nkeaOIkWfqCSuNS40I8RrubzVW5cUJxElrBmynwRPUKJDXlIbRTZL
 tFtBBSlHeNfzCxHolwZ5eLFif50jaT3JZs+IBMZV3jXuZp9LiJ17PM78PiZ853exTe0PEqRz5g6
 CJoJjKTOWTectkxtKRvmq9a9nawwVpo/KjHodE4PZnNvYzb59V5QyNkIgNQ5QXJuFSOQyGT2Zfv
 8yG96dqEJ2mh9EH27CTErvaiwt7vtDdqSaAGgkobjk/7VMMxgGp8U8CK1s9dEo9cfBLAHsR0QXL
 qfQns44mAKSY/8poIQei3tFozT9qjhYbXLybUJ8/YM6AC/D77NTYPfJCiJtCZxJoF7nqYzSHc0+
 UE79q5bc=
X-Received: by 2002:a5d:64c7:0:b0:431:62:d946 with SMTP id
 ffacd0b85a97d-435f3a7bafdmr2718648f8f.23.1769759446769; 
 Thu, 29 Jan 2026 23:50:46 -0800 (PST)
X-Received: by 2002:a5d:64c7:0:b0:431:62:d946 with SMTP id
 ffacd0b85a97d-435f3a7bafdmr2718619f8f.23.1769759446316; 
 Thu, 29 Jan 2026 23:50:46 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e4824sm21180491f8f.1.2026.01.29.23.50.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 23:50:45 -0800 (PST)
Message-ID: <25cc36b0-9f9b-4837-b881-f26607b4a1d8@redhat.com>
Date: Fri, 30 Jan 2026 08:50:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bite-Sized Task] Volunteer to Fix Issue #3193
To: Choon Keong Teo <ckeong.teo17@gmail.com>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
References: <CAOkKuiMh4A-7Jo2Zg98Js7cOpXCd7N_B1RUGUr7-=x-tU+=UYg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAOkKuiMh4A-7Jo2Zg98Js7cOpXCd7N_B1RUGUr7-=x-tU+=UYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30/01/2026 06.52, Choon Keong Teo wrote:
> My name is Choon Keong (please feel free to call me CK), and I am
> currently a university student. I have been following the Bite-Sized
> Tasks page and would like to volunteer to work on Issue #3193.
> 
> I have reviewed the mailing list archives and didn’t find any recent
> patches addressing this issue. I found that the property in question
> was converted to a machine property in a previous refactor, but it was
> not assigned a description string in hw/i386/pc.c, as noted by Peter
> in the comments.
> 
> I am currently preparing a patch to add the missing description using
> object_class_property_set_description. If possible, I would appreciate
> being assigned this issue on GitLab.
> 
> Thank you for your time and guidance. I look forward to contributing!

  Hi!

Thank you for your interest in contributing to QEMU! There was already 
another person asking in the ticket, so I dropped a message there to clarify 
whether they are still interested. So let's wait for some days to see their 
response.

Otherwise, we also have some other easy bite-sized tasks in the bug tracker, 
for example:

  https://gitlab.com/qemu-project/qemu/-/issues/228

For that one you likely just have to extend the help text in 
tests/Makefile.include ... would that be an option for you, too?

  Thomas


