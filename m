Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA49E64006
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECnc-00043z-Km; Thu, 21 Nov 2024 14:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tECnQ-0003Qb-PM
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:24:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tECnN-0003NL-FH
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:24:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732217092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oHhzRY1DDx5AtEjcDs/FlVKKpG2XZi+o+W+4cGdMJKU=;
 b=GUMEJ95293t+Gz2YVuKYBZaFLjAJF+EicnEblEjrL0bjwC+XdNeMN2U//YB4+25VDWsDGt
 ucWXdnIVcSG1IiVyRluxUqdrxOskvCXzdT9czwr31Ge0BBw0rkMYgoviXbf1oBrIS4zQLu
 1wJgGW+tFg2F3kDLguU6EQmTM84WmfY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-m3Gvnu7kOMCtWRyzrNFQHQ-1; Thu, 21 Nov 2024 14:24:51 -0500
X-MC-Unique: m3Gvnu7kOMCtWRyzrNFQHQ-1
X-Mimecast-MFC-AGG-ID: m3Gvnu7kOMCtWRyzrNFQHQ
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5cfca544b47so1046641a12.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:24:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732217090; x=1732821890;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oHhzRY1DDx5AtEjcDs/FlVKKpG2XZi+o+W+4cGdMJKU=;
 b=plVZw5ennfkg3AcGKpLvC5s75EjjKZYLNE200oyZZLm4oDiFiONQgoyKmfmn3I9NmK
 SvcCr1xKpDNPI4wDiswI4ovHV9ZOa5mDPUxID3Hsc41CtACWhuzgDmgyTuiCsEAMmP10
 7LREEOiqDbcVPLqNd5p5JXwgs5Y6LfF4dFNanErso5dR/AOOkBmoDMf1Gus5AcN8IRwK
 RTW1iJdRfhFE4UN8W8lQ3lPYLKrh8ABmshsZMK7MtvZxM9FpZ4anOTIouN3DeihPqvnd
 um4VpxK0KdI8XI9H5UxZOQWCEj81Rg8k5wBF3IkLxIvO7/hkhQopuPydtfF2jiutY7BI
 RAbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUnKIf74rov2D4jzwraiLRWLHjHA8Mmm5iUSPihgLNpzqsCxB6sluhzsRdYcrCRFmBvqK/bhjPXh7h@nongnu.org
X-Gm-Message-State: AOJu0YyS9DtG+Gh07QLoJiF39zaRhVDAeW8En9jRqgS3B1bSLTAbjqwy
 p4eJhJK+ZVTe41OJ64rSMFC9PH89hVgSQkB516NF0gNvA0FQhFtY+uzbuhEPK5Uw955IjxyIVkM
 /HmlYZvNkk1oCFBJwfxpMcQMvH4dgqLP6qo0iu82fJPvjFoFchf2A
X-Gm-Gg: ASbGncsExi3Xxx8GCJkr2kd6VyjgEF6YcN+uklz6GnHDThg9AqeSTtu9Br3E3vzWory
 MWF/cOrzrOkDpQFucQnHEW5bZ+l+M9kPHun0TTbtQghcsmb7s7/Jr3UyVxOwj4neewVn7D80+S0
 /xWkdeIxCYNA1RPwmwA3Semg0stNTXG/xUd/yVJB1afa52+h7Zm9HkS8+X1Wt9sCcYbR//3rtSu
 +3950Y7BIzI0/h+G4C8PWTnGaeW4F7wb84EKqt/fA6HaHUOuY56SPpdo/93x+xkg3qk0+mEcHsX
 CUE=
X-Received: by 2002:a05:6402:5ca:b0:5ce:bb32:ccac with SMTP id
 4fb4d7f45d1cf-5cff4cb5887mr5496180a12.26.1732217090103; 
 Thu, 21 Nov 2024 11:24:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESte4FUUfXXG7nMs7+ESJc+k/ADg8VAPZqc4NMHb94P0GLerMCGtDZ14/y2TBClpJqDe6J0Q==
X-Received: by 2002:a05:6402:5ca:b0:5ce:bb32:ccac with SMTP id
 4fb4d7f45d1cf-5cff4cb5887mr5496156a12.26.1732217089768; 
 Thu, 21 Nov 2024 11:24:49 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-70.web.vodafone.de. [109.42.51.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d01d401f64sm96925a12.70.2024.11.21.11.24.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 11:24:48 -0800 (PST)
Message-ID: <bfb12b04-ca4b-4135-ba09-250daffb9ea9@redhat.com>
Date: Thu, 21 Nov 2024 20:24:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/39] tests/functional: require non-NULL success_message
 for console wait
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-s390x@nongnu.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Markus Armbruster <armbru@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
 <20241121165806.476008-15-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241121165806.476008-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 21/11/2024 17.57, Alex Bennée wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> When waiting for expected output, the 'success_message' is a mandatory
> parameter, with 'failure_message' defaulting to None.
> 
> The code has logic which indicates it was trying to cope with
> 'success_message' being None and 'failure_message' being non-None but
> it does not appear able to actually do anything useful. The check for
> 'success_message is None' will break out of the loop before any check
> for 'failure_message' has been performed.
> 
> IOW, for practcal purposes 'success_message' must be non-None unless
> 'send_string' is set. Assert this expectation and simplify the loop
> logic.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-Id: <20241121154218.1423005-15-berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/qemu_test/cmd.py | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
> index 98722a9cf6..f6c4e4dda1 100644
> --- a/tests/functional/qemu_test/cmd.py
> +++ b/tests/functional/qemu_test/cmd.py
> @@ -81,6 +81,8 @@ def is_readable_executable_file(path):
>   def _console_interaction(test, success_message, failure_message,
>                            send_string, keep_sending=False, vm=None):
>       assert not keep_sending or send_string
> +    assert success_message or send_string
> +
>       if vm is None:
>           vm = test.vm
>       console = vm.console_file
> @@ -95,7 +97,7 @@ def _console_interaction(test, success_message, failure_message,
>                   send_string = None # send only once
>   
>           # Only consume console output if waiting for something
> -        if success_message is None and failure_message is None:
> +        if success_message is None:
>               if send_string is None:
>                   break
>               continue
> @@ -107,7 +109,7 @@ def _console_interaction(test, success_message, failure_message,
>           if not msg:
>               continue
>           console_logger.debug(msg)
> -        if success_message is None or success_message in msg:
> +        if success_message in msg:
>               break
>           if failure_message and failure_message in msg:
>               console.close()
> @@ -138,6 +140,7 @@ def interrupt_interactive_console_until_pattern(test, success_message,
>       :param interrupt_string: a string to send to the console before trying
>                                to read a new line
>       """
> +    assert success_message
>       _console_interaction(test, success_message, failure_message,
>                            interrupt_string, True)
>   
> @@ -152,6 +155,7 @@ def wait_for_console_pattern(test, success_message, failure_message=None,
>       :param success_message: if this message appears, test succeeds
>       :param failure_message: if this message appears, test fails
>       """
> +    assert success_message
>       _console_interaction(test, success_message, failure_message, None, vm=vm)

This assert is theoretically not needed since we call _console_interaction 
with send_string=None, so if success_message is None, the new assert in 
_console_interaction would trigger instead.

But it also does not hurt to have it here, so fine for me if we keep it.

Reviewed-by: Thomas Huth <thuth@redhat.com>


