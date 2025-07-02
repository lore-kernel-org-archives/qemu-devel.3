Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DD6C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWxFj-0002u6-9o; Wed, 02 Jul 2025 09:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWxFe-0002nd-Fy
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:11:51 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWxFb-0006LC-3C
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:11:50 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so5026132f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751461904; x=1752066704; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C8lvA+l3wNoCTx9JuHtyHUxTUWUWBsRM4PqjqegebxU=;
 b=lIPzWp2O5Z1frhm2iJRgi+QJsySDOWNCiJW3+zmwt5OzuSSSBeqq2zqGLqXXw8ep4k
 T9dzbfUHqwtH3R/1TEukBt9It21jwW5j2zrKAbsRPxzJoddfwAKpAIOk5KrXBzbqfV1y
 Mx2ZnuL8Jnj8zleyCbXBOxgqDTGrb3nKR81T80RzZcUlLPe2ucQv1rgDw4vs1kjEVuOr
 z6g+rHg9UGwJn7vUomFumr+Mggy79U//XFNjHRRSIYhJvlpYDc65yYZYNOBWIQL3XVN3
 58FjTRyMUdkinYyTG8O9wj9CQ+7aVv+ikYJZv6Vy7o5VnO4y5vzKmjV3ePvhLzRK+dmg
 QF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751461904; x=1752066704;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C8lvA+l3wNoCTx9JuHtyHUxTUWUWBsRM4PqjqegebxU=;
 b=WXDjC6mzIwiuwpFCmGZoKIP1zyOM9JJ8TP0Igw1a38bcBCqidBOOGJRxPbTx/TsP1L
 Z/bXCtJbaZr1mitU381Srx4btjjMhUjN4BEPystF0n/42eck30RYEtCFFCz/gB5BhpIP
 wF8O58NML5ruJRB1h0S5RkLezz7U9H1tMv555r8HI1GqgrbkYQDLCRQgRysVMQ7m9dg9
 52Wr6VYxRC/TDl20cboHBebbk5m9ztEEDZBDUAkX1mhFt0XBNC9RaV2WeDKlV15vY2uZ
 wTOdGHS9r3OV45rCbOwsk/HYvh5IKx65sD2VzK2tqOirvzGg8gn6uS6/k2JMV7zJhun9
 r5Kw==
X-Gm-Message-State: AOJu0YxXU8fylaJHwmvMMKzkbFSTlLIcb1y/rL5eNMuM3+z/R4wQp8K6
 V288UNWDHn8JGBtKmR3Squ1rIljPh0VhVSJR9xhVAwqs1+cUFwVn7o82eJg28KKB/50=
X-Gm-Gg: ASbGnctWvx4V4PgDeDwf8tjVf3GgSWujUB6KsngXBSCbjY/b54u4kv3hGdpAu29AzL7
 1COr7AbIabFqpvoY+/3EevoV9cYklO8qJ0eqP7hrQ7JEdRdebKyPJcEAib9/gwlCx9Jyh7zTE5L
 fVysFv5SK8TEXbm3+vZyo6ScrHYtpYibVw6NFKoWSMwgF5AII/ch2rVs6fd0NqD4HN9je8kVuKJ
 b2nc0IafNTm5RlbrSH/bYPsd7hEzKBEI2v76eaTZ3Ccv1NrhzRv8cMHZaovGl5CIuRPqjhku03n
 hnra3vZuazi3RnZdWMsmwpWFHM2vI5vZt6jl97eRrWcTWJM5Y/8Ylx5oKG+XeCLaqvfmK5RtOZU
 UV4bSJx987DtuNUAj5cWjjfiX+8OIHQ==
X-Google-Smtp-Source: AGHT+IGlrNHl8N4sLogigtp0t4ezf+YtP5kFVC2uWInF/frLmUyVBD41303bLOqpnDRshpB8F1IenQ==
X-Received: by 2002:a05:6000:188f:b0:3a4:d685:3de7 with SMTP id
 ffacd0b85a97d-3b1f61bdb37mr2366627f8f.8.1751461903755; 
 Wed, 02 Jul 2025 06:11:43 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e595c6sm16467247f8f.66.2025.07.02.06.11.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 06:11:43 -0700 (PDT)
Message-ID: <1c95b135-f9c1-4c52-8e26-d3e9110b3035@linaro.org>
Date: Wed, 2 Jul 2025 15:11:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 24/68] accel/system: Add 'info accel' on human monitor
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-25-philmd@linaro.org> <878ql7rxxg.fsf@pond.sub.org>
 <d9ab105e-20ad-4ee2-8655-2b89ed3910b8@linaro.org>
 <87ms9myf9a.fsf@pond.sub.org> <aGUiXjcEvx7ncBRI@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aGUiXjcEvx7ncBRI@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 2/7/25 14:13, Daniel P. Berrangé wrote:
> On Wed, Jul 02, 2025 at 02:00:01PM +0200, Markus Armbruster wrote:
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> On 2/7/25 06:58, Markus Armbruster wrote:

>>>> Standard question for new HMP commands that don't wrap around QMP
>>>> commands: why is the functionality not useful in QMP?
>>>
>>> So far the sole use of this command is to prove the 'split accel'
>>> works by using it in a test:
>>> https://lore.kernel.org/qemu-devel/20250620172751.94231-43-philmd@linaro.org/
>>
>> Different series?  Best to add new interfaces together with their uses.
>>
>>> Is it worth overloading QAPI and its documentation, and overload
>>> the QMP command set (even if prefixing with experimental / hidden 'x-')?
>>>
>>> If so, I don't mind implementing yet another "embedded plain HMP string
>>> to QMP command" in v4, or directly export each debug statistical value
>>> via QAPI.
>>
>> Whatever the reasons for implementing something in HMP only may be, the
>> commit message should state them.
>>
>> "Just for testing" is a valid reason for HMP-only.  It's not obvious
>> from the command documentation or code, though.
> 
> IMHO there is no valid reason for continuing to add HMP-only commands
> which are not backed by QMP.
> 
> A test case can easily run QMP commands, and we accept arbitrary QMP
> commands with the 'x-' prefix and experimental tag, to serve as the
> basis for the HMP command printing human readable text. So if anything
> I'd suggest exposing a QMP command and not bothering with HMP at all.

Fine.


