Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D4A6C47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 15:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUpla-0007cU-9e; Tue, 30 Jan 2024 10:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUplW-0007bl-2J
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 10:11:10 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUplQ-0003Bj-57
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 10:11:08 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33ae5e7d787so2360671f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 07:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706627461; x=1707232261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rl8mVKyXBbIbbg+Hdc08clQcxKA01MtX6k5p7htTQ50=;
 b=ylLfceT48K/KC54z92/cuDwQGHfC4uIrlTm8GwI6aSfAeHj1Vt1jcI9hbM+q3zknNq
 u/ux8ItB/oC1wCgMqUBaat0pe4yGq6O6Rrdl4a8bh5yrCFnPQJGnS6ePpnN6lIAyB/Dn
 0xS9i3USO3e7z85d/Qtu+kBvI5dvEeEYcXXJOkeZn3te141CfDetxUk2iQfaJ1iWZ2vt
 /S4obgN8Ehr/hmUe/HADEzGHQCvBDTSriQCaexUp90cU5limlIDT6QBTAx9zrS+ljuvL
 3numXSm76NB4b5KVqM9CZa1cUWtw424d9ouQommfxgO+PT6jPGneFFhpbReIT6kx+D7j
 yKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706627461; x=1707232261;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rl8mVKyXBbIbbg+Hdc08clQcxKA01MtX6k5p7htTQ50=;
 b=hWVuisPBUTDhuroLQlVXGwBwiERAzMrWb5RU/Mey8dWAKa32kook8V7OfuQgqMImNf
 6OF2wypJnlss7RTWwdGO+4mByPMu2zfXgn72SVsZQSFCMKI6tja4zikd+DGHtG30431r
 LE3674Sb1tTKHyndNkiR5+d+FSbCB8MVmGRqaI/T+RJ7YLAKhhJwENjGhFpgxdpeyKAS
 Ppz6NL8LGETpb+oE5g9wmJDUmnOU3qZpwlIK0GeDLQ3yNPzQWGGPazFv+LKltNs4DHNl
 E5k2/rP7FcotbnJOlGHNl8AoKrGTDogC5hjT0fkMg9EWW0sPbREiyKf9LsItSJwj9Ath
 ifOw==
X-Gm-Message-State: AOJu0YyS+iiZkOmTujluFFPpY+ud9VWZJdnHI69spn9AerR/x5YxW5aR
 UpR3J2nFpGObsH7ea4Ituam6qPU3UoKR+YrzMubjhhFy/poy646A18vrJQQVY8+yVnO8tPfPOwD
 E
X-Google-Smtp-Source: AGHT+IHaFclazMByqrM6p3tmdf8M9vvge8DNA6sj0b89l1dlz29e4jUcnfHVBMJFkJnBOO5jT8tgiw==
X-Received: by 2002:a05:6000:80c:b0:33a:e739:28ac with SMTP id
 bt12-20020a056000080c00b0033ae73928acmr8650139wrb.67.1706627461381; 
 Tue, 30 Jan 2024 07:11:01 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 s14-20020adfdb0e000000b0033afce63fd0sm1463399wri.53.2024.01.30.07.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 07:11:01 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B13FF5F9D3;
 Tue, 30 Jan 2024 15:11:00 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9=20?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2] scripts/checkpatch.pl: check for placeholders in
 cover letter patches
In-Reply-To: <82lcl.1qg7az61g8ip@linaro.org> (Manos Pitsidianakis's message of
 "Tue, 30 Jan 2024 12:26:54 +0200")
References: <20240130101107.214872-1-manos.pitsidianakis@linaro.org>
 <ZbjMNZpX9kYyw5hW@redhat.com> <82lcl.1qg7az61g8ip@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Tue, 30 Jan 2024 15:11:00 +0000
Message-ID: <875xzaonzv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> On Tue, 30 Jan 2024 12:15, "Daniel P. Berrang=C3=A9" <berrange@redhat.com=
> wrote:
>>On Tue, Jan 30, 2024 at 12:11:07PM +0200, Manos Pitsidianakis wrote:
>>> Check if a file argument is a cover letter patch produced by
>>> git-format-patch --cover-letter; It is initialized with subject suffix "
>>> *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If they
>>> exist, warn the user.
>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>> ---
>>> Range-diff against v1:
>>> 1:  64b7ec2287 ! 1:  9bf816eb4c scripts/checkpatch.pl: check for placeh=
olders in cover letter patches
>>>     @@ scripts/checkpatch.pl: sub process {
>>>      +# --cover-letter; It is initialized with subject suffix
>>>      +# " *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***"
>>>      +		if ($in_header_lines &&
>>>     -+		    $rawline =3D~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
>>>     -+        WARN("Patch appears to be a cover letter with uninitializ=
ed subject" .
>>>     -+             " '*** SUBJECT HERE ***'\n$hereline\n");
>>>     ++				$rawline =3D~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
>>>     ++			WARN("Patch appears to be a cover letter with " .
>>>     ++						"uninitialized subject '*** SUBJECT HERE ***'\n$hereline\n"=
);
>>>      +		}
>>>      +
>>>      +		if ($rawline =3D~ /^[*]{3} BLURB HERE [*]{3}\s*$/) {
>>>     -+        WARN("Patch appears to be a cover letter with leftover pl=
aceholder " .
>>>     -+             "text '*** BLURB HERE ***'\n$hereline\n");
>>>     ++			WARN("Patch appears to be a cover letter with " .
>>>     ++						"leftover placeholder text '*** BLURB HERE ***'\n$hereline\=
n");
>>>      +		}
>>>      +
>>>       		if ($in_commit_log && $non_utf8_charset && $realfile =3D~ /^$/ =
&&
>>>  scripts/checkpatch.pl | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>> index 7026895074..9a8d49f1d8 100755
>>> --- a/scripts/checkpatch.pl
>>> +++ b/scripts/checkpatch.pl
>>> @@ -1650,6 +1650,20 @@ sub process {
>>>  			$non_utf8_charset =3D 1;
>>>  		}
>>>  +# Check if this is a cover letter patch produced by
>>> git-format-patch
>>> +# --cover-letter; It is initialized with subject suffix
>>> +# " *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***"
>>> +		if ($in_header_lines &&
>>> +				$rawline =3D~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\s*$/) {
>>
>>This continuation line is now hugely over-indented - it should
>>be aligned just after the '('
>
> It is not, it just uses tabs. Like line 2693 in current master:
>
> https://gitlab.com/qemu-project/qemu/-/blob/11be70677c70fdccd452a32336539=
49b79e97908/scripts/checkpatch.pl#L2693
>
> I will quote the **QEMU Coding Style** again on whitespace:
>
>> Whitespace=EF=83=81
>> Of course, the most important aspect in any coding style is
>> whitespace. Crusty old coders who have trouble spotting the glasses
>> on their noses can tell the difference between a tab and eight
>> spaces from a distance of approximately fifteen parsecs. Many a
>> flamewar has been fought and lost on this issue.
>
>> QEMU indents are four spaces. Tabs are never used, except in
>> Makefiles where they have been irreversibly coded into the syntax.
>> Spaces of course are superior to tabs because:
>>     You have just one way to specify whitespace, not two. Ambiguity
>> breeds mistakes.
>>     The confusion surrounding =E2=80=98use tabs to indent, spaces to
>> justify=E2=80=99 is gone.
>>     Tab indents push your code to the right, making your screen
>> seriously unbalanced.
>>     Tabs will be rendered incorrectly on editors who are
>> misconfigured not to use tab stops of eight positions.
>>     Tabs are rendered badly in patches, causing off-by-one errors in
>> almost every line.
>>    It is the QEMU coding style.
>
> I think it's better if we leave this discussion here, and accept v1
> which is consistent with the coding style, or this one which is
> consistent with the inconsistency of the tabs and spaces mix of the
> checkpatch.pl source code as a compromise, if it is deemed important.

I suspect the problem is that checkpatch.pl is an import from the Linux
source tree which has since had syncs with its upstream as well as a
slew of QEMU specific patches. If we don't care about tracking upstream
anymore we could bite the bullet and fix indentation going forward.

Of course arguably we should replace it with a python script and reduce
our dependence on perl. I'm sure someone had a go at that once but it
might have only been a partial undertaking.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

