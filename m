Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785B8C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6OZq-0001uC-R0; Tue, 15 Sep 2026 04:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6OZT-0001qH-JR
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 04:31:23 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6OZM-0007NF-Ap
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 04:31:19 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so18760535e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 01:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789461069; x=1790065869; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4BpJB6H6dh8juTzGhRAolvTxWoGaR4nQG/LZO5ZM+eI=;
 b=OIsOJaDERNXSJOJNK389xuIsdUSBPn+dw3N6CyixnuNv6tfguSQB2jc8NXM3/AaKWs
 vXQ/91lQZGhwY0WFEsTBciDwln9Hrg/zoQ7XwcwidkLhtmfhbJ280b4QGIsuS9WacX1+
 +8u4E8/XZkNoR8LxVkPMvfWTjmg1VNXCWap7UF+WMlwF+pr/i5yPKpZrhXk+OG1u52br
 jMdywHzfl8wjAz8WCv5loJc2wdT0jsNHTKwZklWGAYnkvDXK6ZV/DtC0/SEaMSKtB0Lr
 2eGhpO0A9csmS5ZqQBZbiZNDPgrpmgXda4DzMzxo9PVnMQY0Esn8I6h76L/S1LOivoGT
 8DWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789461069; x=1790065869;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4BpJB6H6dh8juTzGhRAolvTxWoGaR4nQG/LZO5ZM+eI=;
 b=xo8+Diph1oOPD4hpzRuimVVa4/vrj6E9mtKfEeMkHP6nQOsE04IV8elyZbIrCJeiyu
 vHlO9jO7VRf5lM+HuV6HahIofuAKCEfpyHZ8EhwKPoKiGUTNtK3tWu1yE71jVfQXG45M
 JmimSZLfh+zM6ZTff73qkIbNsB2Eh4g1xBtdFIKuaXGiZ6+hn8Q09JkHWyOwrvOxAyz1
 zzfdF2V4oLmZHcGOQbY8n5k/pcsze/it1Oa6lVgzhl5fKM5aDWRwInc+ZJzx0/WWmfeM
 b2PuKxgJ3Ku42aj6qIotJEkYN0zkv3PubJhGolp1Zsm6YZqRfHgjGMgVKKHsdVu3vd/4
 PLAA==
X-Gm-Message-State: AFuF++lJi8H7lJyc1OgABTBQrPOpE+9q3NO/SDBkRNw1n8UB2s6eR2wU
 i5/6H6g/2uEiV16tu7xDMO3BYLuE2pF4FO8x1IB6iceh5iK+poTdwoVWhkUmnUVm5G7w1NL6Mcw
 rmKZhqnI=
X-Gm-Gg: AYBFou0SEDUAQZkHkiBKCceHMAcZ3M9dX4jWNEi5j9d7X9bIwPxqTMq/RJGjeenRZqy
 OOHO5tNINaZrcoP8rfsFmyeFfYMJ+SQEJqePX9TebVK7BpruwBngVQdc/QN2YaB2CBe1ffal1Uq
 1Ftmkerb4r+jJ/5ljkjhJRw0j3MyunjBR8dd3te4RVlP7KCOajkCpWGxRIaQpHo4AO1zBAnosOy
 I5BJTa+qaicyFCZ1rwfnnjW6nCoQjctO+VZnVbuci/MuU4iEiT5iLX/l5FdyGN9+i0o6+Kn8Pon
 bzonkU6vh1nGiTlDsSDlIEI+iABFqdzayt08lhW5TrVjX/kQE1xVyR56sTEpVxvakpRVd/bHGcE
 2gaAwYR+5aLMmJqlUiG1fiFPC4T41bJvapnkVjU2FzEWTfkDv5fpMCwUBhNAjFJCsr6dyxty9LK
 J2V2MZaRFhoc6CcrnEQHLiAhzTQXOB8nbqX40PNni/fJ72Fg/3FC/2ZZSElpLsF9I4pirjux4=
X-Received: by 2002:a05:600c:1910:b0:49c:ff8d:b548 with SMTP id
 5b1f17b1804b1-49e7a67f6b8mr130274115e9.11.1789461067460; 
 Tue, 15 Sep 2026 01:31:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7ef8a7b1sm41571605e9.12.2026.09.15.01.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 01:31:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 747835F825;
 Tue, 15 Sep 2026 09:31:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] gitlab: update the @user id mapping file
In-Reply-To: <aqhSIPwd23VKNQ5g@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 14 Sep 2026 20:59:28 +0100")
References: <20260914184534.706637-1-alex.bennee@linaro.org>
 <aqhSIPwd23VKNQ5g@redhat.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Tue, 15 Sep 2026 09:31:05 +0100
Message-ID: <87bj9yc3w6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Sep 14, 2026 at 07:45:34PM +0100, Alex Benn=C3=A9e wrote:
>> I needed to fix a POSIX-ism in the script as well.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .gitlab-map-auto          | 8 +++++---
>>  scripts/gitlab-map-update | 2 +-
>>  2 files changed, 6 insertions(+), 4 deletions(-)
>
>> diff --git a/scripts/gitlab-map-update b/scripts/gitlab-map-update
>> index c134c226aa2..743ad11900d 100755
>> --- a/scripts/gitlab-map-update
>> +++ b/scripts/gitlab-map-update
>> @@ -33,7 +33,7 @@ glab api --paginate /projects/qemu-project%2fqemu/memb=
ers | \
>>      .gitlab-map-auto.tmp
>>  test $? !=3D 0 && fail=3D1
>>=20=20
>> -if test $fail =3D=3D 0
>> +if test $fail -eq 0
>
> Using '=3D' instead of 'eq' is more typical, and what I intended
> to use originally.

I did consider it (and originally used =3D) but I went to -eq as that is
explicitly a numerical rather than a string compare.

>
>>  then
>>    grep '^#' .gitlab-map-auto > .gitlab-map-auto.new
>>    LC_ALL=3DC sort .gitlab-map-auto.tmp | uniq >> .gitlab-map-auto.new
>
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

