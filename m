Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0B0C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 19:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUtU7-0007rw-IV; Tue, 30 Jan 2024 14:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUtU5-0007qx-8u
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:09:25 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUtU2-0001bl-G5
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 14:09:24 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40faf6788d1so727145e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 11:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706641761; x=1707246561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/kkacUVhUnUXmyHODg7+pC9WEDyrMJVGgjtkparKFto=;
 b=WN/wMWuDjL3PEt6XximG6ZYed6kI5loS7/cpK9kVkzWkbR8DLdrXdHJICcM9YPSmAm
 MWFZPFdtlBVIx5BYplQOGfdC568ZyZdKglN4/5jk7al2Lu+d+iPgVa/1wD7TOASZVgNO
 /TzNpZyb1v4ijqDBbKWMj55URr12g3px/EJXDRKha/t8ExbxlqJ6pTH6lYhCOMQpzMfT
 FAMkKqrCE1LZsZEFI8lL+NOOePqYlWeTXLqnZs/yDu7yKJ0TTPZmJlH5tpCWZHFyUgnc
 U3EkTd0h1hUo2B2aq4li+ARYjNUNGyB4leEP7kzl0OHnGFH9WDK8j4lqEeCHoXWQfQf7
 5sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706641761; x=1707246561;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/kkacUVhUnUXmyHODg7+pC9WEDyrMJVGgjtkparKFto=;
 b=xLJOg90OyMxm4RjnTxBdpnj7wF91IDgI4pEliCWs1twb/zoA4m3TVDPTM8BZfmJ70f
 dm8o7VPhAhDibfk58peVq6qZUcdc86uFdz+1w+6affBp7AhOoLTcOy7i+u7uiHBEun0Z
 zUi/wxCJQabkGaxrdi8x0kM36ZarIhGtTOe7eqtc7FTKZtAL5KcKzo7NyPB5bg7+xbe0
 hAnZvFYEkH3Hqja2Xp4TWQfpFD7c/dQglyd2J2nNMPTDpOph6rEJl4dOOd2uBj6WNeCx
 NQZ7zJfeRYYDhrRf1i+kAV2xgXoAT8ANUDVpcWrJCBHUglUSYOypXrHpHko1ioJzbOK8
 BNlA==
X-Gm-Message-State: AOJu0YxR3q+w9yp74yZmdu5xrnPEe34Kh8pAhxfW8YbQyn8DWVTLzyFo
 0/4NNlgdiEh5D2PddVnWY/7N3Xn36tjbHXJOJw/JvfrSevB2dAv4alc9mZrVF08=
X-Google-Smtp-Source: AGHT+IEIhCTmzD6968GruPsMltO+hifU8Wns4LVUPlZ1Xyz/GoZoJ28FV54yljSGy9rBe2nBSi+RzA==
X-Received: by 2002:a5d:6a91:0:b0:33a:edc0:d491 with SMTP id
 s17-20020a5d6a91000000b0033aedc0d491mr2117021wru.20.1706641760909; 
 Tue, 30 Jan 2024 11:09:20 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a05600c0a0700b0040eccfa8a36sm14038535wmp.27.2024.01.30.11.09.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 11:09:20 -0800 (PST)
Message-ID: <71bf3e5e-9fb6-4797-b773-0e1485cfb27c@linaro.org>
Date: Tue, 30 Jan 2024 20:09:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scripts/checkpatch.pl: check for placeholders in cover
 letter patches
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20240130101107.214872-1-manos.pitsidianakis@linaro.org>
 <ZbjMNZpX9kYyw5hW@redhat.com> <82lcl.1qg7az61g8ip@linaro.org>
 <875xzaonzv.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <875xzaonzv.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 30/1/24 16:11, Alex Bennée wrote:
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
> 
>> On Tue, 30 Jan 2024 12:15, "Daniel P. Berrangé" <berrange@redhat.com> wrote:
>>> On Tue, Jan 30, 2024 at 12:11:07PM +0200, Manos Pitsidianakis wrote:
>>>> Check if a file argument is a cover letter patch produced by
>>>> git-format-patch --cover-letter; It is initialized with subject suffix "
>>>> *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If they
>>>> exist, warn the user.
>>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>> ---
>>>> Range-diff against v1:
>>>> 1:  64b7ec2287 ! 1:  9bf816eb4c scripts/checkpatch.pl: check for placeholders in cover letter patches
>>>>      @@ scripts/checkpatch.pl: sub process {
>>>>       +# --cover-letter; It is initialized with subject suffix
>>>>       +# " *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***"
>>>>       +		if ($in_header_lines &&
>>>>      -+		    $rawline =~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
>>>>      -+        WARN("Patch appears to be a cover letter with uninitialized subject" .
>>>>      -+             " '*** SUBJECT HERE ***'\n$hereline\n");
>>>>      ++				$rawline =~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
>>>>      ++			WARN("Patch appears to be a cover letter with " .
>>>>      ++						"uninitialized subject '*** SUBJECT HERE ***'\n$hereline\n");
>>>>       +		}
>>>>       +
>>>>       +		if ($rawline =~ /^[*]{3} BLURB HERE [*]{3}\s*$/) {
>>>>      -+        WARN("Patch appears to be a cover letter with leftover placeholder " .
>>>>      -+             "text '*** BLURB HERE ***'\n$hereline\n");
>>>>      ++			WARN("Patch appears to be a cover letter with " .
>>>>      ++						"leftover placeholder text '*** BLURB HERE ***'\n$hereline\n");
>>>>       +		}
>>>>       +
>>>>        		if ($in_commit_log && $non_utf8_charset && $realfile =~ /^$/ &&
>>>>   scripts/checkpatch.pl | 14 ++++++++++++++
>>>>   1 file changed, 14 insertions(+)
>>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>>> index 7026895074..9a8d49f1d8 100755
>>>> --- a/scripts/checkpatch.pl
>>>> +++ b/scripts/checkpatch.pl
>>>> @@ -1650,6 +1650,20 @@ sub process {
>>>>   			$non_utf8_charset = 1;
>>>>   		}
>>>>   +# Check if this is a cover letter patch produced by
>>>> git-format-patch
>>>> +# --cover-letter; It is initialized with subject suffix
>>>> +# " *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***"
>>>> +		if ($in_header_lines &&
>>>> +				$rawline =~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
>>>
>>> This continuation line is now hugely over-indented - it should
>>> be aligned just after the '('
>>
>> It is not, it just uses tabs. Like line 2693 in current master:
>>
>> https://gitlab.com/qemu-project/qemu/-/blob/11be70677c70fdccd452a3233653949b79e97908/scripts/checkpatch.pl#L2693
>>
>> I will quote the **QEMU Coding Style** again on whitespace:
>>
>>> Whitespace
>>> Of course, the most important aspect in any coding style is
>>> whitespace. Crusty old coders who have trouble spotting the glasses
>>> on their noses can tell the difference between a tab and eight
>>> spaces from a distance of approximately fifteen parsecs. Many a
>>> flamewar has been fought and lost on this issue.
>>
>>> QEMU indents are four spaces. Tabs are never used, except in
>>> Makefiles where they have been irreversibly coded into the syntax.
>>> Spaces of course are superior to tabs because:
>>>      You have just one way to specify whitespace, not two. Ambiguity
>>> breeds mistakes.
>>>      The confusion surrounding ‘use tabs to indent, spaces to
>>> justify’ is gone.
>>>      Tab indents push your code to the right, making your screen
>>> seriously unbalanced.
>>>      Tabs will be rendered incorrectly on editors who are
>>> misconfigured not to use tab stops of eight positions.
>>>      Tabs are rendered badly in patches, causing off-by-one errors in
>>> almost every line.
>>>     It is the QEMU coding style.
>>
>> I think it's better if we leave this discussion here, and accept v1
>> which is consistent with the coding style, or this one which is
>> consistent with the inconsistency of the tabs and spaces mix of the
>> checkpatch.pl source code as a compromise, if it is deemed important.
> 
> I suspect the problem is that checkpatch.pl is an import from the Linux
> source tree which has since had syncs with its upstream as well as a
> slew of QEMU specific patches. If we don't care about tracking upstream
> anymore we could bite the bullet and fix indentation going forward.

We diverged quite some time ago and don't track it anymore AFAICT.
Regardless, git tools are clever enough to deal with space changes
and a tab/space commit can be added to .git-blame-ignore-revs.

> Of course arguably we should replace it with a python script and reduce
> our dependence on perl. I'm sure someone had a go at that once but it
> might have only been a partial undertaking.
> 


