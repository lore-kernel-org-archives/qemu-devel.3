Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86594C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVI9-0006qm-4f; Fri, 08 Mar 2024 03:09:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riVI7-0006qN-GV
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:09:19 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riVI5-00052w-UE
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:09:19 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5139745e6afso146347e87.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709885356; x=1710490156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X/tDJI4u53aPpsmCZld2hNeyBzUWShDPzyvAKyLfhvI=;
 b=qvjpe331JTKrD6I4tpbaFHU9Po5RuAHmG85ra+QOM9vlR7lgM5gh3bfGitStSA+MOa
 7Deqx2Vma3c/zr9kLetUDdE9cn7k2kOZt4D7U3cZS3+1vnEajC9RiN4xKE9/74Eyzx0n
 NndZIjlcuP2zv64ZYWwb0s/I7c5txb+IFW8i04g3sYByvqMMGruNGlhuSkF7FvKwogEf
 3b6pm7VlwhAXJNxWqSnl6Ae8D5AMIQ8EamSgdjCnWLOWW01sofY/rcENlcsgAvrrSHid
 chJBqytgb14IrotNLbSuTsz8pAG1/WrE/MbYSk781OQoSsC9eiGYQHg408XsM4rZ+gJJ
 iQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709885356; x=1710490156;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X/tDJI4u53aPpsmCZld2hNeyBzUWShDPzyvAKyLfhvI=;
 b=d5ImRNNbq8YxwDTJAW9OMa7nyzlBjAwRt5u2Bt6Gpz5SSEBE9EZY4ZH2KlJmgbmPu3
 pa7Z3QGyxy0aDK1EiacTo/8fx678ZCDw2j6jHR8vxpgj2mlQPSL1XxmiWH4iaVhCT8l9
 Akn4AbH3++BwBQUQqGTFO9kTBEbucjpH89TBZ458f3wo1D5QDxhAUrISocze0Sj9KZ30
 oDRMTwEUKPLG1HrR0/j0avQIDnuLiEG4NkrOH6mExsfelt/t07DgiRXqC3WbcdgU+Bnd
 NQXkLP0DNvFz6sFtaNwpqBdmcTFE0PT2AkrLlhaibY1uV1KR1QTLAm2CD4VF21dab+gh
 zWAA==
X-Gm-Message-State: AOJu0YyslevTRP35oN7SN1xSwykVfC+besZINMBNNLYENfSoeB7bQP2f
 WCa3x2GsDBRQzQiwHafOxmTsn67z41mdGcg/SEbQv0ZoF3WqeU+bBj5pwah/qoU=
X-Google-Smtp-Source: AGHT+IG7Hukxsk6zF+t5G+rnld2IIZyIYkobSIz7DEHyy4eYiXo0MR8EmBB1Wv+d48RvpN+uWl9T4A==
X-Received: by 2002:a19:910a:0:b0:513:25b9:6cf7 with SMTP id
 t10-20020a19910a000000b0051325b96cf7mr2876780lfd.20.1709885356020; 
 Fri, 08 Mar 2024 00:09:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bo16-20020a056000069000b0033e422d0963sm11943332wrb.41.2024.03.08.00.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 00:09:15 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 41BC95F892;
 Fri,  8 Mar 2024 08:09:15 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,  Jagannathan Raman
 <jag.raman@oracle.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Alexandre
 Iooss <erdnaxe@crans.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Juan Quintela
 <quintela@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  peter.maydell@linaro.org,  David
 Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/5] scripts/kernel-doc: teach kdoc about QLIST_ macros
In-Reply-To: <ZerA34BH9NNf_K1Y@x1n> (Peter Xu's message of "Fri, 8 Mar 2024
 15:40:15 +0800")
References: <20240307181105.4081793-1-alex.bennee@linaro.org>
 <20240307181105.4081793-2-alex.bennee@linaro.org>
 <ZerA34BH9NNf_K1Y@x1n>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Fri, 08 Mar 2024 08:09:15 +0000
Message-ID: <87msr9taac.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x135.google.com
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Mar 07, 2024 at 06:11:01PM +0000, Alex Benn=C3=A9e wrote:
>> The kernel-doc script does some pre-processing on structure
>> definitions before parsing for names. Teach it about QLIST and replace
>> with simplified structures representing the base type.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  scripts/kernel-doc | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
>> index 240923d509a..26c47562e79 100755
>> --- a/scripts/kernel-doc
>> +++ b/scripts/kernel-doc
>> @@ -1226,7 +1226,14 @@ sub dump_struct($$) {
>>  	# replace DECLARE_KFIFO_PTR
>>  	$members =3D~ s/DECLARE_KFIFO_PTR\s*\(([^,)]+),\s*([^,)]+)\)/$2 \*$1/g=
os;
>>=20=20
>> -	my $declaration =3D $members;
>> +        # QEMU Specific Macros
>> +
>> +        # replace QLIST_ENTRY with base type and variable name
>> +        $members =3D~ s/QLIST_ENTRY\(([^)]+)\)\s+([^;]+)/$1 \*$2/gos;
>> +        # replace QLIST_HEAD, optionally capturing an anonymous struct =
marker, and capture type and variable name
>> +        $members =3D~ s/QLIST_HEAD\(\s*,\s*([^)]+)\)\s+([^;]+)/struct {=
 $1 *lh_first; } $2/gos;
>> +
>> +        my $declaration =3D $members;
>
> May need a "tabify" here..

Ugg that file is a mess. Any idea what we should use for perl, tabs or
spaces? I can update editorconfig.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

