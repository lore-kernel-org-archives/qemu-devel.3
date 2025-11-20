Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C402CF8844
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 11:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM2tV-0007hn-EE; Thu, 20 Nov 2025 06:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vM2tO-0007gb-KN
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 06:32:03 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vM2tM-0006lK-H2
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 06:32:02 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b736cd741c1so144965266b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 03:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763638319; x=1764243119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vc54jvQKojDxP5il6fQMB0aj2cEvLCOXTbMQU17iikE=;
 b=kU3/qbuE9FzAu59HhQOK9TZ0JCg/KC0/iQ/93C+0PQRUUNEsaL4DWFA31etTxscT3i
 A/DDKtZXQ7gECKLT8UqrJLMY/k5U+9yZ+ohR33qUGGBbXndNoZmaH7lGal3H6Zxfo9gu
 ceDFUgRAl9s5Yx72ZlHiRKAxcusLTxZqNakPh7V/Cg5NWT44TDKW2aBrZYhWUuW09TTr
 8L8bwp/4lLplgxXsPeRkAuVwVySE4chqc8dsBUR1BesL3lQ63pjWd43+4nJCiMPlgG7q
 VOYYbt9o5fDNih/JnKujx7YHSVly0GEoPOPE+hGKNvLIppDTM8Dg6ILikw3CQCmZ6A29
 m2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763638319; x=1764243119;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vc54jvQKojDxP5il6fQMB0aj2cEvLCOXTbMQU17iikE=;
 b=nVLzOsnvuYfhT/4XE1krJbfshXjd0M6nUHVRqiWmRNneDmuQOfrqRBzVAI4zfjFOGF
 PcLWOwR+aKoE3nwkF4fHFDPX1Qg4Jnou+M5nDreaKGVJgzV4/HYl1vuG9KvxZUe3gYG7
 bYqQg/9t7sm+xYrcMiG/5KasfW2qFUrM0uC7ib7DvLb5ep1+XSwxirBnpPmoEoXNIef+
 tN5nRar9rd0cKy+CW9gRI3YWyWCZkABn1iG6d88zDkHWnh5yrG9+pLhT6dv22Q+AaFU0
 KNrD9fdqIVl/iXdORrFaoyKO9/UgMPyBPZGhHNS7WkQFcu0lqRMTPdAjqBEH/LKU0yMT
 g6CA==
X-Gm-Message-State: AOJu0YzbKESYyWHAxvRQbA4V0fV2lbhRwRvbbgkCNFgSKVWSFCXXTgb6
 Fsqnlm+5WDyemcH5HjeWR1TjCdYwl+L08ARygGEngkfafWoOZr3YD4FgaZ6VSssP7ds=
X-Gm-Gg: ASbGncsBTRfKKcwMdkgL0in7AqIT8/BKMWpD2SxB3D58tb94GOfp3Qw43zjG7c6LLth
 BJwVQc1reO2Bet+9NZBSreL4NNY/R98B89Lhi1CbSsyX6bno4Cs5/mPr2GKUGlN9qPnxe23gXnM
 fIaAdquk7smaX3i0eAjiY0T3IgmNJAhkTfjl3yRzViuvcEoptOOqtfZul8kyBMFB6bv/scIX5qh
 wDsCi/jk4p9wdcIsg4xZr9gUrpiWhTDAZErRXP5v5N45CHDZ9i3Em08QaBy5NQC/UaC6Eo4bngN
 jV+4noX82Ef+abavGNUbh/7gjJtDuYnZy5POORZFM8cXa61lFH1RmcEYQKw/9solDjIgjITF49N
 BdDyTfArQId9+D4qILxAy1FnT6fONtLMttMUiD+oOVlHWeMjvC5NzcO60CjdtQWFhq3Lsvv9eT8
 OY+H418z+kskw=
X-Google-Smtp-Source: AGHT+IHjAzSeQWtcwyyv8JSmJBOJzowQCwVUd0IxuhoFtUBUuaoBabLVXxUiSg+BdMBySj1QeU90Sw==
X-Received: by 2002:a17:906:7949:b0:b73:870f:fa2b with SMTP id
 a640c23a62f3a-b76587e1449mr197914666b.27.1763638318583; 
 Thu, 20 Nov 2025 03:31:58 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7655050c53sm185764166b.68.2025.11.20.03.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 03:31:57 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 314A05F802;
 Thu, 20 Nov 2025 11:31:57 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4/9] contrib/gitdm: add Nicholas to the IBM group map
In-Reply-To: <7601933c-5518-4ecd-98dc-5f01764772d8@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 20 Nov 2025 12:04:53
 +0100")
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
 <20251119113953.1432303-5-alex.bennee@linaro.org>
 <7601933c-5518-4ecd-98dc-5f01764772d8@linaro.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Thu, 20 Nov 2025 11:31:57 +0000
Message-ID: <87pl9dhrde.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 19/11/25 12:39, Alex Benn=C3=A9e wrote:
>> Let me know if this should be under "individual contributor".
>
> See '2025' section of https://ozlabs.org/about.html ...

His last contribution was before the move. However if he continues to
use the same address for individual contributions I don't think gitdm
can discriminant based on dates.

Anyway I await Nicholas to advise what he would like to do ;-)

>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   contrib/gitdm/group-map-ibm | 1 +
>>   1 file changed, 1 insertion(+)
>> diff --git a/contrib/gitdm/group-map-ibm
>> b/contrib/gitdm/group-map-ibm
>> index 24d8dc1b865..2d76bbe163a 100644
>> --- a/contrib/gitdm/group-map-ibm
>> +++ b/contrib/gitdm/group-map-ibm
>> @@ -13,3 +13,4 @@ joel@jms.id.au
>>   sjitindarsingh@gmail.com
>>   tommusta@gmail.com
>>   idan.horowitz@gmail.com
>> +npiggin@gmail.com

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

