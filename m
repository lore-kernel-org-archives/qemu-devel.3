Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761F0C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8QMg-00017W-0v; Fri, 25 Apr 2025 17:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8QMc-000169-U3
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:13:38 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8QMa-0003TY-7W
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:13:37 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so2487381b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745615614; x=1746220414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5VoGeh0lmnA/W7+tFXiCyRxtx/621O9bzsfAoIYRM4U=;
 b=ErKK66VGEFVl+slpgwwJbDxxvWTlcdPYAWvZ1XMQ3EetFfNB9D0XKEnOhXHzQly1le
 bPXzyRUkDkRdXeIe0TlM/ONgL7MY5V10pUNuQQ99/bGeIlZPkfZbjMQDK5unzdQ9UbnP
 e4+PDPa0tlt3p3WGavZNsJPcd9pHuRO3rXEkfZjG7UO9qZiVw8E7Ork2xLQdi9zVBtIc
 rAU/QjgLtaTSaJ/vZs/HomEYXMFv7G+SYPvh/UAyifr4AMsKw9IP1GZtA9W4e4LYbeKu
 3+Knqy+He9qo00LIkbJ6e9Tye4cw3B/PLaq10bkPKxkD5OCpr3zYgF2sBVoWRMxFYuR3
 MFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745615614; x=1746220414;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5VoGeh0lmnA/W7+tFXiCyRxtx/621O9bzsfAoIYRM4U=;
 b=mU36J1pJBdttT4ABNdRT0/FipCNrBl6VgDIbRTGrQtlwHTuNFkiDq/vFpXknZNk6Ot
 Nald60ZlGBjPVFId6hb1THUG5axQyz2Trf8k1ZT68GBJJDMfMixFd/PdBIVBEO/Ras8T
 sbNEhUbZuUO2EkCMYJznRrmMGnYrwfE8GqZtCqvMaOV4L7ZrorjGY4l7jVmu921oscwI
 HOeXwd6r38NiTbG9HltkdbsKodPTdzJx0+BQKT1evZC/73MyL9xkbhJyffZ7D1OI0zEY
 GHp0X8AW8yiEMOTB4n9FoNeD17/nSw86RYuUs06sSRjmz1TyjJ20cPlb67YzR8eqR3l2
 BXTA==
X-Gm-Message-State: AOJu0YwvTVWPbOg/8EZBdq0N30zbcgBHm0ZvvvnjtSw5+KgQjacvauxt
 FGK2eqx2upoYAEahQNusgf1ycCwS42V5Sle2HrEDFUKnkgQ7zkjrgsCBZKmhB0Q=
X-Gm-Gg: ASbGncs3M9HKLPPCI9Tr6yqtmEI7ogoBF5e6d896jMWFpznC0qvtUxq/1HLsifbBPZc
 O59yA8F4W6Z70i3k7dzDz6x62tgoLh/mv1rKbvEtt5EZFM/9DnyIV4y8HlAZ7ZZFZfPx5j+yXTu
 GTmcwj1GqrK380RbKh8mWqBT54iUvjBgA7Qs2DQv/o5gjc0NShQOH/9KiReehK+3hgTzSjNe1Fv
 MAcq69508rjswybxi3hUcZX1hNIimJ2nV2d9Pi9ZIodMJnAyFXbfiZx9jC0nvFYk8s4qhjMPX2E
 Qxm5g0DBkYEdspGb31DLr7C+ysnU8PaWTegbj1B5VxzIBfdQGZinag==
X-Google-Smtp-Source: AGHT+IHz0za1l9QucXA4ElZtJDzLlmmdklzqEJGsm8RaNQQiuD2NM8QOu05i5Y3XymJNgcbE5qXddw==
X-Received: by 2002:a05:6a00:1744:b0:736:55ec:ea8b with SMTP id
 d2e1a72fcca58-73fd8e54a8amr5381960b3a.24.1745615614508; 
 Fri, 25 Apr 2025 14:13:34 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259134e0sm3647682b3a.20.2025.04.25.14.13.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 14:13:34 -0700 (PDT)
Message-ID: <169a4bbc-5bcb-4cc0-b501-4cde8501647f@linaro.org>
Date: Fri, 25 Apr 2025 14:13:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, stefanha@redhat.com, 
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, philmd@linaro.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, devel@lists.libvirt.org
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <87a584b69n.fsf@pond.sub.org>
 <5b21965d-2428-454c-9dd7-266987495abd@linaro.org>
In-Reply-To: <5b21965d-2428-454c-9dd7-266987495abd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 4/25/25 14:07, Pierrick Bouvier wrote:
>> QAPI/QMP introspection has all commands and events, and all types
>> reachable from them.  query-qmp-schema returns an array, where each
>> array element describes one command, event, or type.  When a command,
>> event, or type is conditional in the schema, the element is wrapped in
>> the #if generated for the condition.
>>
> 
> After reading and answering to your valuable email, I definitely think
> the introspection schema we expose should be adapted, independently of
> how we build QAPI code (i.e. using #ifdef TARGET or not).
> 
> Is it something technically hard to achieve?
>

 From existing json format, we could imagine to change semantic of "if" 
field to mean "expose in the schema, and register associated commands", 
instead "introduce ifdefs around this".

QAPI generator would not have to know about what is inside the ifs, 
simply calling expression passed as value, and condition command 
registering and schema exposition with that.

