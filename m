Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A36DC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 23:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts9EG-0008SS-2N; Tue, 11 Mar 2025 19:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1ts9EB-0008Rz-7b
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 19:41:41 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1ts9Dz-0008E4-KV
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 19:41:33 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22438c356c8so80572785ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 16:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741736485; x=1742341285; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zo+UlsP77Wmz4I9AyuAeQf1g301eOymnLAp02aCSBz4=;
 b=kqXx/NHJ5AZ+05et7Wtnqqei/9m/+qChai3xQzDpLDKbHKe3Rq4PXYCGUE7h0tLnZQ
 mB9krJBRYv7ZviDgCetlXgsQWSYP5vVD4rniHjRSjZ+8vTxtRBfVvmO+nxzfN/3Dgobf
 inm2iOiMtH1C3y78MHe/LtWid+nPd4Za/6LuUDvDxC3/ZdqXEtDewPMpz7M1rN7nTHCF
 F5tdKB4Q8kw+Mhi0PkvP7JVy2HUlYubffY9sV6p7x+N/ZALPsWir+5ib4f47/G8ZX6e1
 4M+x7dObIV/YjZgxRe4DyPEjbb5GtJg4Dh6YPbIHkaS2RFYbL24LCYu9lVn/sd0knbcB
 FRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741736485; x=1742341285;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zo+UlsP77Wmz4I9AyuAeQf1g301eOymnLAp02aCSBz4=;
 b=oTiiS3n6paBw8D8gUeZ89rHnFZkjNc0R1truJUb9UgpYjINKaKY93tJfXAN0wLO3Uf
 /ycG++T8ySMgj+M4TVNjlc270INuzjJbGv4dNa/pV1q2iAaUW5zQm4Ua7lkuv8LYOF4N
 +yAzBDqEFJsgudTct/tDH1wDgeJHSgRk1O6kLaHM33SN+oDrFBcy8YE2+vnE9doA1aHx
 MVyKibqDX/L2xROJHQw+98/532vjpxSZLFHicyB5vxQR6PdOkDSqhMU1MJ3nBQUoqlsa
 A/ivWSNooUZWgB6WWzbAkuiY+Al2WuF/rf5gIY3tXGGXOZSHQ5AvHgDIGLdc9EUj+e2J
 hsTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfwuhb0a7lUW27/seNam0+4f6rETCw+rmZa2QjRbMy1NNSbUzx0JrhshQu8ZBP7JvJDa2eoQhvI2We@nongnu.org
X-Gm-Message-State: AOJu0Ywwb6U35mPrq7xK9kyXBgkfixVvSzQORZBHuhVBwT9oL2uIntRp
 Gm6rLOrJEoExCbvc0Sqs+SKygqv0j9cU4nflMWcXXsgd7WPLhAgU
X-Gm-Gg: ASbGncvABxjPQW8T9tWkse7y4t9dB/YrRRMeDXnNpES47wthowkAAYKqxWyyaHoOq0K
 Tdyv8sLtHo9s5j27PIBs8tJDkk42sXCiy65C14RjpML3bX9qTpCFr+MVIgIqPgGZK5eXuHrS52a
 TlH8LvVG2YQFCeIAjU81uXxFMGzxzpgYht9fB9opkwprkuj6DiieE1l0YFtxKb2KEcLy536xi6g
 5420eF1BdSQhR4O3yFSKMpbc0FoceeliTQid0uG4vwq8ZzU9MeGiKIxfEvx1o2eyGfwfwzxl83p
 aM1n/wilFDjHcB/tvo/WPLBOmSpBHmNuA9RBQA5z
X-Google-Smtp-Source: AGHT+IFGM+HsmMY+fGeU8y35TBp7Oeb+NHXc/syEHBA/8HLUkqBBaBKKLdFFHn4/+/wNvR9Kg2Q6hA==
X-Received: by 2002:a17:903:192:b0:21f:507b:9ad7 with SMTP id
 d9443c01a7336-22428a89081mr308990395ad.25.1741736485423; 
 Tue, 11 Mar 2025 16:41:25 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410ac0794sm103780465ad.259.2025.03.11.16.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 16:41:25 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Mar 2025 09:41:20 +1000
Message-Id: <D8DU1X7UDEPK.2PZVT8SJAWUFI@gmail.com>
Cc: "Thomas Huth" <thuth@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH] tests/functional: Don't fail any precaching errors
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
X-Mailer: aerc 0.19.0
References: <20250311131327.903329-1-npiggin@gmail.com>
 <Z9A8swNn6zBm57jC@redhat.com>
In-Reply-To: <Z9A8swNn6zBm57jC@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Mar 11, 2025 at 11:37 PM AEST, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Mar 11, 2025 at 11:13:26PM +1000, Nicholas Piggin wrote:
>> The NetBSD archive is currently failing part-way through downloads,
>> which results in no clean HTTP error but a short transfer and checksum
>> error. This is treated as fatal in the precache download, and it halts
>> an entire set of tests even if some others could run.
>>=20
>> I hacked up this patch to get a bunch of CI tests going again for ppc
>> merge testing.
>>=20
>> Don't treat any precaching failures as errors.
>> This causes tests to be skipped when they try to fetch their asset.
>> Some CI results before/after patching:
>>=20
>> functional-system-fedora
>> https://gitlab.com/npiggin/qemu/-/jobs/9370860490 #bad
>> https://gitlab.com/npiggin/qemu/-/jobs/9373246826 #good
>>=20
>> functional-system-debian
>> https://gitlab.com/npiggin/qemu/-/jobs/9370860479 #bda
>> https://gitlab.com/npiggin/qemu/-/jobs/9373246822 #good
>>=20
>> This is making the tests skip. Is there a way to make the error more
>> prominent / obvious in the output? Should they fail instead? I think
>> there should be a more obvious indication of failure due to asset so
>> it does not go unnoticed.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  tests/functional/qemu_test/asset.py | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu=
_test/asset.py
>> index f0730695f09..3134ccb10da 100644
>> --- a/tests/functional/qemu_test/asset.py
>> +++ b/tests/functional/qemu_test/asset.py
>> @@ -174,14 +174,11 @@ def precache_test(test):
>>                  try:
>>                      asset.fetch()
>>                  except HTTPError as e:
>> -                    # Treat 404 as fatal, since it is highly likely to
>> -                    # indicate a broken test rather than a transient
>> -                    # server or networking problem
>> -                    if e.code =3D=3D 404:
>> -                        raise
>> -
>
> Why are you removing this ? The commit above does not make any reference
> to the problem being a missing URL (404 code). We want missing URLs to
> be fatal so that we identify when images we rely on are deleted by their
> host, as that is not a transient problem.

Yeah it was just a quick hack I guess so I didn't put a
complete changelog or get it quite to the point I wanted.

I think *no* precaching errors including 404 should cause
failure because you would still want other tests to proceed
(in some cases).

But the failure should be caught when the test case tries to
fetch the asset, so you can still easily identify the download
failure.

Thanks,
Nick

