Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9234DC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 10:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJst6-0000ey-7j; Wed, 19 Jun 2024 06:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJst4-0000el-M5
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:49:58 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJst3-0002Tc-5V
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:49:58 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a6f0e153eddso829807766b.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718794195; x=1719398995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fFVQUYkG4laYm54TlOEcC+w8V5GFvqf/W23gvKPtIlY=;
 b=X4X3pu5WLP9dxUVqpu8FeCM4IM7+Z0oo3ZFJ8bbrr/K0DBtGpnjIinHzMcn8j6lhKu
 sk0saturOBORUeV9WtiLSlSvqF+CgIB1oELCkR0p/Q8sdaW37qo0X4tKTfqmwwTsTo0c
 eyvlO+jwTpi0puelOxKrNoG86K1aq4My+5TqkXUs69KHwPwAqVzSULHG+zEIsfuxp7XP
 jRMMrByYco4mI+uRs44AAyBtjMWrTogorFSZz8jjLfOZ5XBwei/ZlzT7flXLJhYmYTz6
 gIEulm84N4niaCYPX4DrmDP52SXX5ug96pDZx37VH2/g4OsAPBHqP8vrpwHwQbQQd2lf
 PufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718794195; x=1719398995;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fFVQUYkG4laYm54TlOEcC+w8V5GFvqf/W23gvKPtIlY=;
 b=o5wTBjNWLc/eQJo3qH4828R49e3U7PANCa/kHt3rJaAdJtXNqGxHNE11U4QmJ/RUCM
 muSc7TZa1MW8dMZuHwr5WlKmqkCGTl8010pPLyor/voCr7KpEPy0JU5YsUirTruB3J1S
 TuNIgylDpanHiHdBrwwKfwXwpb3UWCNV1BW7hngJQosYAqqb+q3wp2j5xCCPzGhNJddT
 OnQgC3RX5VqzZ/sw5EWxfr2+sJbEm4NAzQeK0GA5G1zBGO/7OEP+MLSpS1gLKxR8P+2R
 n5GBUqX64CZZUG73Hb3NBj7M7ccMQ6bJ1rhqwxFDEZEk58wBpTXWkQyW6ktnmKQC3wla
 kekQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/dYjgKc7UWaXfXQNuo8q0LV7UUadamRdkf9Tu7d6rFj0FV3zfp92FQjZdbNdglSx6ARb4OWAvhWaBNrgcwVul8upvRCw=
X-Gm-Message-State: AOJu0YwtBvV236gAyZYh78zMbxH1gznGhlAZ45h6PmLPhU3kHeHIwsu1
 kcZuLruLmowbDQ1NGNUrsFR88e/1YXlPtNRalOaq/tIVd8JwVev6UVqdOYBfFgg=
X-Google-Smtp-Source: AGHT+IEWjUs64ms9GV3+LTW4vsAdiZWLTevcTMfE5fvQijf/mjO7LwgASIkoZqLu+OEto5uRDGUiGg==
X-Received: by 2002:a17:907:8688:b0:a6f:4d38:f40c with SMTP id
 a640c23a62f3a-a6fab77a60amr139198866b.62.1718794194471; 
 Wed, 19 Jun 2024 03:49:54 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.133.105])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ecdd8fsm650837166b.107.2024.06.19.03.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 03:49:54 -0700 (PDT)
Message-ID: <e865d8e3-e768-4b1f-86d3-aeabe8f1d511@linaro.org>
Date: Wed, 19 Jun 2024 12:49:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] exec: Make the MemOp enum cast explicit
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Roman Kiryanov <rkir@google.com>, qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com
References: <20240618224528.878425-1-rkir@google.com>
 <4e725d93-01fe-42ae-9873-d7324c30e50f@linaro.org>
Content-Language: en-US
In-Reply-To: <4e725d93-01fe-42ae-9873-d7324c30e50f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 19/6/24 12:40, Philippe Mathieu-Daudé wrote:
> On 19/6/24 00:45, Roman Kiryanov wrote:
>> to use the QEMU headers with a C++ compiler.
>>
>> Google-Bug-Id: 331190993

I searched for this on 
https://developers.google.com/issue-tracker/concepts/searches but no 
hit, is this public information?

>> Change-Id: I785f2e65d192287f1f964d2840131b653755648c
>> Signed-off-by: Roman Kiryanov <rkir@google.com>
>> ---
>>   include/exec/memop.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> and queued, thanks!


