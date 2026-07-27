Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7B2C531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 06:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woEbb-0004oG-3p; Mon, 27 Jul 2026 02:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woEbZ-0004n8-7S
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 02:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woEbX-0006un-IK
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 02:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785132861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MnAIMqZorQZZLw9Hg9T577/7zW2ncI93rgQQ5xqAneU=;
 b=gbSXNx7u8Gf9VEQIWLHRT4B1zxsSITde5+Q+TyMmilK/fkr20VBYy6cbKy/P2KoQJf6hP3
 D/u2dynxNbUVKqbitOEwOgi4c1KdF47rwIDSIT0WQhae6ZqvRI9HJoYJ3stEwl8X9gu+Nf
 K19HPa61It19IEIXO9U7BzgFH376Oz4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-A0m2PiXrN3W1BfXuoj_n_g-1; Mon, 27 Jul 2026 02:14:19 -0400
X-MC-Unique: A0m2PiXrN3W1BfXuoj_n_g-1
X-Mimecast-MFC-AGG-ID: A0m2PiXrN3W1BfXuoj_n_g_1785132858
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4954dcd6131so25436345e9.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 23:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785132858; x=1785737658; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MnAIMqZorQZZLw9Hg9T577/7zW2ncI93rgQQ5xqAneU=;
 b=nWR6K/szZnZh6A5VnRHiR/+dtCh3+s4Axj2EVBpV9PQBofLCruek66fRgBuCJLBKQB
 W0WrcmLoEE3mxN/9nDljFjy+t4twwPF+8KkVcMJoXBL/MPrqmmLq1/na3QseVL9GWuWE
 8IGx83w1oUrZLWaHHE/vMDT8qOKFjzIARVMpSGFLp4fPXYwlIuv12OXKVOPeRzf0a4u8
 ZZbQpl3LAo+5wg4bAW+pHnEmOl1zv0o/L3tupgLia6W5ZpyPPWjhnFRs8SfBPCugkqLq
 ioU2mZDaYvr/ka7rtcV0PraEY5EsN5c7+UoGv5GjVaUF4m3bC8BtK1Hx7KL5Eh3q6Y+T
 eTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785132858; x=1785737658;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MnAIMqZorQZZLw9Hg9T577/7zW2ncI93rgQQ5xqAneU=;
 b=qncYiQ+fvgWvIzL56eh3W2IJtc9FLrJwhmti2/Hu9pSyK+80h4Fs3PaaDZfbzpwKn2
 zR5DNCAWNdUoTweTbTx5J//JB0E7oNGm7AdhmU0kdHbMg7ZDDhGwAuQLHWExmvpD9WSH
 O5959H7frMdOUJkLY/KXRgm16Sk0bgFIXZ6SrWV2sOROhDytIlemJt9K0hBxeUFNTfrv
 wFgpjAVn0IIPdZtCbJbNIMFZX8wdfHV5PojtPN4SooTr0GEw2CMPZOUJ+N2aOsYliddQ
 X0eKZzLzMLNYEc2gX5QUMHSeAy8R212nyfvFDOxk+oOwQBkcW42jcMYlRULQ6SlolfOS
 gRvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIpppfypQf8yrgI3zJV3IL64l8s7Nce8oJt04njDLi+wJgGGPENgDroq3qiWbjOPIuXlxdWgkoSSl3@nongnu.org
X-Gm-Message-State: AOJu0YxDxdmOTdhU99yTiKPw+aHyD9LOvgdImswX+8+cyFo4/T7NEBZ/
 +0+VSBLEam4lShNeAh4/ZCs0uxkAHA4rj+0GS+MoZmhdw+lSXJ2SDmWm5OuvwH3g10Q1dVf8Zmy
 pK8vMZpVcAsXuWsQcJoyyRjtv8KI0btBaSpfXUjvfAT1pktNAQuxjmbwEYX03vico
X-Gm-Gg: AR+sD13nLwW/LNzpIgJ0nOhRdGg4O/Ba57n2BTpwm2+vTriYTHxQCDSBDOTLfEIQEEe
 lF6aEMhOyXQY0vZC2w2xm+iIdfQHa3X1sch6QMVixDXb+msH9Fe1Bt3g9nzMkQz4Rz/sLL2e5+w
 nAO3rUyf3qFAMoayFdsQaToJJyWtxH7L33osn5zkeXjCUMH3yRrT4YSnEDLztG2PGkvr6/oW//E
 wIRoqJAG8j8gk8dRMU8D+IkvpyUoJ353oDsiZ0uRGsisx/2M9YmMBKDQbDaCeUVk5QShiKwU5lS
 sUDUIBTaTmoH9z/lc1m7VoisTNp/D/tdmNvd506QItJljrU/RaS0F70ZVJmsYeg/QfN94oV2GU/
 TP3sb/5ta1wZdIc1I4wdbgnkYOF3kOEgeuEKWJNA=
X-Received: by 2002:a05:600c:3b27:b0:495:3c6d:f294 with SMTP id
 5b1f17b1804b1-496b5717d1bmr90008965e9.23.1785132858015; 
 Sun, 26 Jul 2026 23:14:18 -0700 (PDT)
X-Received: by 2002:a05:600c:3b27:b0:495:3c6d:f294 with SMTP id
 5b1f17b1804b1-496b5717d1bmr90008635e9.23.1785132857544; 
 Sun, 26 Jul 2026 23:14:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4858e86sm201784515e9.1.2026.07.26.23.14.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jul 2026 23:14:16 -0700 (PDT)
Message-ID: <6e54009f-2e84-4a22-9316-b0db8f9a1d1f@redhat.com>
Date: Mon, 27 Jul 2026 08:14:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/checkpatch: validate Fixes: tag format and commit
 ancestry
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>
References: <20260723065320.1314072-1-clg@redhat.com>
 <7e4a2ca1-c930-408f-a39d-d926bd8ba788@tls.msk.ru>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <7e4a2ca1-c930-408f-a39d-d926bd8ba788@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/26/26 12:16, Michael Tokarev wrote:
> On 7/23/26 09:53, Cédric Le Goater wrote:
>> Adapt the kernel's checkpatch Fixes: tag validation for QEMU.
>>
>> Add a git_commit_info() helper to resolve commit hashes and validate
>> the Fixes: tag in commit messages. The canonical form is:
>>
>>    Fixes: <12+ chars of sha1> ("<title line>")
>>
>> The check validates capitalization, spacing, hash length, lowercase
>> hex, and quoted title. When the format is wrong and the commit can
>> be resolved, suggest the corrected Fixes: line.
>>
>> When running inside a git repository, also verify that the referenced
>> commit is an ancestor of master.
>>
>> Lines matching "Fixes: CVE-*" are skipped. The check can be disabled
>> with --no-fixes-tag.
> 
> Thank you for introducing this!
> 
> A comment below.
> 
>> +sub git_commit_info {
>> +    my ($commit, $id, $desc) = @_;
>> +
>> +    return ($id, $desc) if ((which("git") eq "") || !(-e "$gitroot"));
>> +
>> +    my $output = `git log --no-color --format='%H %s' -1 $commit 2>&1`;
>> +    $output =~ s/^\s*//gm;
>> +    my @lines = split("\n", $output);
>> +
>> +    return ($id, $desc) if ($#lines < 0);
>> +
>> +    if ($lines[0] =~ /^fatal: ambiguous argument '$commit': unknown revision or path not in the working tree\./ ||
>> +        $lines[0] =~ /^fatal: bad object $commit/) {
> 
> This is the first place in this script which depends on the C/EN
> locale being in effect.  With different locales, git will produce
> different messages here.

Linux uses:

   my $git_command ='export LANGUAGE=en_US.UTF-8; git';

Something this patch could do too.

> Instead of relying on the exact wording, I think it's okay to check
> for the exit status of git command, and only assume we found the
> reference if git command finished successfully.
> 
> An alternative would be to export LC_ALL=C, but I think relying on
> the git exit code is more reliable.

I'd rather minimize the differences from the Linux version.

I will add a $git_command in v2 and use it in the git_commit_info() helper.

Thanks,

C.


