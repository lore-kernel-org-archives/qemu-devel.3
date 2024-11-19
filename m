Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3391D6C287
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 19:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDTrv-0001MY-SC; Tue, 19 Nov 2024 14:26:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDTrs-0001M4-I5
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:26:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDTrr-0001aS-4c
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 14:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732044388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6B80xgQeiKFS7aQNcaaxrT0MPRhkdDK+5P2ZyEALXqg=;
 b=ZUZlJAw+hzzX5F3VOoDrhhvlkYZI9CeT3pZVrOyoIn2SA+5PadH01kXXqoZfu0zORhrNiI
 MZxpU3YbC2zt0BbEZ+wxJTlsdFXIzwsvmIareQiS39eUA7wFExdXw8GnEdMiFgQFSx1qTr
 sJVwn+chbjj6EwxZbJ1o1YR2+HPTsDM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-P2EpoZOdPkeitGAD5eRlhQ-1; Tue, 19 Nov 2024 14:26:24 -0500
X-MC-Unique: P2EpoZOdPkeitGAD5eRlhQ-1
X-Mimecast-MFC-AGG-ID: P2EpoZOdPkeitGAD5eRlhQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315cefda02so34461765e9.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 11:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732044383; x=1732649183;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6B80xgQeiKFS7aQNcaaxrT0MPRhkdDK+5P2ZyEALXqg=;
 b=jOafg2LJZJ0U4fCKIHmmj+SnuoQCqWjXoWTq8J1z2tpuaOYKdRvXJXRU/tvol7jn9G
 JNzYstSlqNc+gRNB+N5kZykY5ODwZst8bYTCqcmAXYK1NWj1Kshzt70Wybva01c4TOhd
 DfV32afnTS+ur/tBYlQZdrNpJqvB8wq76jfrHijxNiprihqwmUHxMoN5EV9jLDSvpxqW
 5agBRNgEbHDSF7U6cSi4vTMs4WVkkEd9gJiZnpv1aR+o6zAnLDz4u6jEJ6mjLxukJEZE
 ynKP+J0e4VInYO7ZrcJ3HK1Baa1EzbVSKQ/wQNc16IFOhG3tDr/u7qXUe80Rb44QyUEX
 Vbqw==
X-Gm-Message-State: AOJu0Yz2/j0aH2tSMzwkUCvmb3dOZtw/JBQBUQnuy+bLQyKrHlgjanKu
 DFq7CqLD0I0pDLSlEMYDEG3P0yE6MEWsG8FOUM83Y+Ij+VzwRfjupz+BvqfmlULQKZ+XWzfqLm1
 ngw6Uzw6wwpnnM9VUQT50W1iCSnIPtlYajGMZGcC7fkS/MZ4njVO1
X-Received: by 2002:a05:600c:5125:b0:430:582f:3a9d with SMTP id
 5b1f17b1804b1-4334f01f731mr1002325e9.26.1732044383480; 
 Tue, 19 Nov 2024 11:26:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVHiz4aYc/vA1sZ/4ka7HFyhMAnWl5G6EgRvps0mUg7VzDMi/VjvvnEH9hVqpdkH5M2/XBHA==
X-Received: by 2002:a05:600c:5125:b0:430:582f:3a9d with SMTP id
 5b1f17b1804b1-4334f01f731mr1002185e9.26.1732044383212; 
 Tue, 19 Nov 2024 11:26:23 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432da2444e7sm213373555e9.4.2024.11.19.11.26.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 11:26:22 -0800 (PST)
Message-ID: <85b96b88-36f0-455a-a658-bed430baa0a1@redhat.com>
Date: Tue, 19 Nov 2024 20:26:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] tests/functional: rewrite console handling to be
 bytewise
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20241119150519.1123365-1-berrange@redhat.com>
 <20241119150519.1123365-14-berrange@redhat.com>
 <beb4abeb-299a-4d4a-a253-3e65a41edcc9@redhat.com>
 <ZzzezVVCYEJV4uVg@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZzzezVVCYEJV4uVg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/19/24 19:54, Daniel P. Berrangé wrote:
>>> +        if success is None or success in msg:
>>
>> As an optimization, you could use msg.endswith(success) and
>> msg.endswith(failure), which would avoid the most blatant cases of O(n^2)
>> behavior.
>>
>> More important, I think "if success is None" should not be here, because it
>> will exit after one char.  Instead...
>>
>>> +            done = True
>>> +            break
>>> +        if failure and failure in msg:
>>> +            done = True
>>> +            vm.console_socket.close()
>>> +            test.fail(
>>> +                f"'{failure}' found in console, expected '{success}'")
>>> +
>>> +        if c == b'\n':
>>
>> Here you can put
>>
>>                 done = success is None
> 
> Hmmm, this can only be a problem if "success" is None, and
> "failure" is not None, and although the old code would
> technically work in that case, I think it is actually an
> unknown/invalid usage scenario.
> 
> If BOTH "success" and "failure" are None, this method won't
> be called at all. It is valid for "failure" to be none, but
> I don't think it makes semantic sense for "success" to also
> be None, while have "failure" be non-None.

"Read a line and check that it doesn't contain a substring" seemed like 
a plausible thing to test for, but you're right it doesn't make much 
sense in this context.  It would make more sense if _console_readline 
returned the full line, at which point it would be a completely 
different function and probably not underscore-prefixed.

So yeah, this is okay:

>   assert send_string is not None or success_message is not None

whether done in the caller or in _console_readline itself, as you prefer.

Paolo


