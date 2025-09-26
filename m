Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9137BCAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 16:04:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2Aum-0001lg-TR; Fri, 26 Sep 2025 12:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v2AuL-0001Va-3m
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 12:02:56 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v2AuA-0004ta-CF
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 12:02:50 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b49c1c130c9so1722782a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758902551; x=1759507351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mPQa80q1v1PKlb2HcaBtoxK7+XTWqPZSx0PW2nTA3JE=;
 b=OKKBDQs392eecgF+TpKwcH0Xmw+EMFbyV5CRouMQtmXJqxxWFZCRP73oArcl4Spw8z
 1YpbvruMeNpbDhdZfFFF7dMMMQyPIvT9RPu6OAgU40FFIteBEPBAybzmcgWZwTMTld8T
 PDVM/1lqe0k7nN+COBpwcT1MMHmyVC3ynKQ084HNmXdFHQe0n2NJwyrTY/wyRa1xjNme
 URpC2FuBkIp0Fxcg/Sqy1Vdt+m8QfmOThBHRQk8og7SOj7q3U9T5JALFkQRJzMFvyobs
 9NfQLqoqd0fB81N8o+ccvUy+Gzoiunal42M8MxBl12YYYc79T9hC/D82SjCBcCm3U4Tr
 IX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758902551; x=1759507351;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mPQa80q1v1PKlb2HcaBtoxK7+XTWqPZSx0PW2nTA3JE=;
 b=gIqaRNSxgPOR4jNf+JxViVTpYwfRxg0JsUrrdPSLycXl4eqz3BJo3/IxQ9ri1sR9Yg
 /O2D/MrT0WaKtQH3YBIkPDGQrBuLXeJzW3Y9Pf8G0w6JiKeZCfzG16eh10CzS/oIoqIt
 A/+ETe/2eAMr27kXXSlvRhy6jJpAbR3HSOPLchR8cGk+tBZhL29jzpfKlWjHflTrKdae
 33K2x/19YueJfCHHx0hoboNRyXi1WZ9wjou+ZFygkWczxjzON5dITYD5GCEhKqiw6UIM
 7rc2lVi00i+MLR8gqEcyY6hhXvX0YTwZE1G/sU2f6N/eqh5mL8K1NSVY+U7cGYGqmQlF
 DOGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOvbtlX54MHoGUbo2InbRMS07cp9poI7xCopZCYl0dN/Y658kL1FelFk7WP659vCDWCp/5gO93IK9W@nongnu.org
X-Gm-Message-State: AOJu0YzqOFfPnQ3rW880ODjUfUHGrfMxhfFlqOAk3R2AE7Tn4MZzbawv
 PzybWKn1B3RWRvYU61Vbrq5lmwr7+GJrM9UIjlIUbLWyzY7GV4EBMub5x2bEEqskDlc=
X-Gm-Gg: ASbGncv9OxVMRuh05uuvU08sVgl7Ps7rtd5VkAJOhptsZ9j0OWP5TDnEVWYb5wAHH6y
 si1jsIX7qFA8KfVisUFPB4zdjOu2ccZdVJhlRaPLMG/4DnTBf6sZpbC5nP4cUlm8FMhTLqOVZho
 lS9EDxMFScPG1O3LWXZWldjZX9qkEenlz+porbr0J6q6j1wkE/hScE3pLn87U3T5P5Mf34guV++
 K8pubfrmwZZ1xxd6fRX7b8yFshBbu7DcJlnYmlXzBBmhm5Y5fCQdR+UBFzxSd6eMHg6xbumpP3S
 a4+M3eK3a+VJ+cX/qIshBW5cMve04LLms+LvwL90ikjvqf+Yg4AMN/xMZE+JsbEkungK2WH19yA
 PF2yWc73DJnVH7wuaYHSBIt3xKCV6VBM9jYRpDRxd4NBpiDYQQNC+e/ZmautsnGOj8iWsrUCY8U
 U=
X-Google-Smtp-Source: AGHT+IEpwGVLdpHxlWxZTeONg7SPB83t0s99BHE5ffmCFurYh+hOKZbyV8LGb9oX8tS61biiZiMXTQ==
X-Received: by 2002:a17:902:f611:b0:271:fead:9930 with SMTP id
 d9443c01a7336-27ed4a78d72mr87113175ad.59.1758902551069; 
 Fri, 26 Sep 2025 09:02:31 -0700 (PDT)
Received: from [192.168.0.102] (189-47-45-49.dsl.telesp.net.br. [189.47.45.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed688223dsm57862285ad.86.2025.09.26.09.02.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 09:02:30 -0700 (PDT)
Message-ID: <d0f10230-11f8-480b-9b54-d7c146fbe732@linaro.org>
Date: Fri, 26 Sep 2025 13:02:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] tests/functional: Re-activate the check-venv target
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-2-gustavo.romero@linaro.org>
 <5aefdfa3-4b8b-4512-a6a4-1a1684352d0f@redhat.com>
 <aNZQwnBW76LPUgeE@redhat.com>
 <1015000c-3f92-429f-84d2-bf496b5776d7@redhat.com>
 <aNZTx0Sxfo8QJMj_@redhat.com>
 <80c73d95-e8c0-4cb7-bf11-1c1e2f749c00@linaro.org>
 <aNa1iV7XZ-BSeX88@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <aNa1iV7XZ-BSeX88@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Daniel,

On 9/26/25 12:47, Daniel P. Berrangé wrote:
> On Fri, Sep 26, 2025 at 12:44:58PM -0300, Gustavo Romero wrote:
>> Hi Daniel,
>>
>> On 9/26/25 05:50, Daniel P. Berrangé wrote:
>>> On Fri, Sep 26, 2025 at 10:42:22AM +0200, Thomas Huth wrote:
>>>> On 26/09/2025 10.37, Daniel P. Berrangé wrote:
>>>>> On Fri, Sep 26, 2025 at 10:34:01AM +0200, Thomas Huth wrote:
>>>>>> On 26/09/2025 07.15, Gustavo Romero wrote:
>>>>>>> Add check-venv target as a dependency for the functional tests. This
>>>>>>> causes Python modules listed in pythondeps.toml, under the testdeps
>>>>>>> group, to be installed when 'make check-functional' is executed to
>>>>>>> prepare and run the functional tests.
>>>>>>>
>>>>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>>>>> Suggested-by: Thomas Huth <thuth@redhat.com>
>>>>>>> ---
>>>>>>>      tests/Makefile.include | 2 +-
>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>>>>>> index 3538c0c740..d012a9b25d 100644
>>>>>>> --- a/tests/Makefile.include
>>>>>>> +++ b/tests/Makefile.include
>>>>>>> @@ -109,7 +109,7 @@ $(FUNCTIONAL_TARGETS):
>>>>>>>      	@$(MAKE) SPEED=thorough $(subst -functional,-func,$@)
>>>>>>>      .PHONY: check-functional
>>>>>>> -check-functional:
>>>>>>> +check-functional: check-venv
>>>>>>
>>>>>> I just noticed that there's still a problem: If you run "make
>>>>>> check-functional-aarch64" immediately after configuring + compiling QEMU in
>>>>>> a fresh folder for the first time, the functional tests fail with:
>>>>>>
>>>>>> ModuleNotFoundError: No module named 'pygdbmi'
>>>>>>
>>>>>> We either need to add dependencies to the check-functional-<arch> targets,
>>>>>> too, or we have to make sure that tests still get properly skipped in the
>>>>>> case that pygdbmi has not been installed into the venv yet.
>>>>>
>>>>> We already have a decorator for skipping tests when modules are missing,
>>>>> so we should add usage of that.
>>>>
>>>> Ack ... and the "from .gdb import GDB" in qemu_test/__init__.py likely also
>>>> has to go away, to avoid that each and every test tries to pull in the gdb
>>>> code.
>>>
>>> Or alternatively the gdb module can move the gdbmi import so that it is
>>> only referenced in method scope, so it becomes relevant only when
>>> executed.
>>
>> I can´t follow what you meant here. Do mind expanding on it a bit?
> 
> The code currently does:
> 
>    from pygdbmi.gdbcontroller import GdbController
> 
>    class GDB:
>        def __init__(self, gdb_path, echo=True, suffix='# ', prompt="$ "):
>            gdb_cmd = [gdb_path, "-q", "--interpreter=mi2"]
>            self.gdbmi = GdbController(gdb_cmd)
>            self.echo = echo
> 
> but it could instead do
> 
>    class GDB:
>        def __init__(self, gdb_path, echo=True, suffix='# ', prompt="$ "):
>            gdb_cmd = [gdb_path, "-q", "--interpreter=mi2"]
>            from pygdbmi.gdbcontroller import GdbController
>            self.gdbmi = GdbController(gdb_cmd)
>            self.echo = echo
> 
> 
> so pygdbmi is only required if the GDB classs is instantiated
> by a test, not when 'gdb.py' is imported

ah, got it. Thanks for clarification ;)


Cheers,
Gustavo

