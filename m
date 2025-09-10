Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404AECA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 12:11:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwJeV-0003p6-G8; Wed, 10 Sep 2025 08:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uwJeL-0003nA-UJ
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 08:10:10 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uwJdO-0003Pw-Il
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 08:09:32 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3dae49b117bso5948534f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 05:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757506145; x=1758110945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=utmF69cm2EcCRmsDAxSenqLWg6GQOQ80HTLaORXx34U=;
 b=wNx69+3C6exdBrlfRad9rCWsDBKMut8vn7knovg84VMLiJ5jJX3n4u4BTT6NaW9op/
 yKx5HWTkQxRsI1jBmT/1r8AeGlmw/KAxLARJqcedTXpO4gujySX9KyoF3VNKo3ogUnEl
 XdLHQEKLY/ug1TgP8NYSTiXu5HU8Vd1o936Fj93Wj3v7+PQ81e3aHLVUPCVEk9YNYdg9
 pfKBvUofCGRoRTkR2q3cDqlnPRtP6pAXMZnqTcBV3ZQtucP5y/QEtvkzPfQD/eE1Mj4h
 9mHKyQFCletI6snI4c5czvUjazFdvEyhqJSSjbYyOgpi7O1QkLN7sH6Wy0oaK8ZKAYwS
 8+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757506145; x=1758110945;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=utmF69cm2EcCRmsDAxSenqLWg6GQOQ80HTLaORXx34U=;
 b=FV+CrCgT3joOgYJT19VuciXMFcMqtLWvl/CqBnEsK5ZDWujfkZrym68Bsl5jxSMba7
 f0LG0h57/Nz2VCK0HvOG3qAm3+b7RMJa+IJIyyXwPgTZeyd/7Id1XBvhliHfFo65cB0K
 HFu5rqxbOo9qd/h55S3qtaYE9z0GX9SWxxWYUcBORSUUdE9ClakHpimx8/7cLziGMtWi
 +/UdgFZEXFRk03GmrpOJCmHyYJfEtyrr1fGXmL97UGFm7omn5oPxC0cgzLJRWji8HhJi
 d6DixwKNXFlEK7sH/zketMgc5oSKN3AcNH0WIyo5pJP+98ayftRER7joHrUnKqt3SpyE
 LLQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXigj5QDOl+m3/NS4Id8vomHV2StpHKImhAVB+JOt6sx88G77QmQJEVo3afI+fnzcsamCcuFLIcjpwh@nongnu.org
X-Gm-Message-State: AOJu0YxYvK2g4mexFsl5ml4qPQ0CXxLlTTMVjQ/6XQ6lCDITpOizZuOy
 km40KulLQZsyMXScSSH953jp0HRrec+nbSN3xL4jxU5OBOIyELg7FomFbKDvpGJQDlaTv4QfoVt
 BFVLNAUU=
X-Gm-Gg: ASbGncsIJz+fnbeRGCvt1TSq1MebIz1QStp4swPkdxNgJdiFyj5ar+a3v44iFJ8/YP3
 phJeNTYLsh4ZrafVLHGSC0Gh2asxhJ5hYQDSN44e7egrKu1Bh+Wv5zeY88vR6/eix2+VW8QgR0v
 73SKaKgE7VQXivoynfIhDlh9J/xgHH9HgOIHWhWKGeMTW0Xx5IbGpsOLkNwTdzezzI2pWy/jAKa
 soXVMI+sWnpycJouhUa3NF1hmvTWi0bqm7zA58Z9eR/bPQTpptrVkrQ7NLXDwrEhjPw7Q+NM4i/
 jgQxfONTvdNjreN0sOkZFM+569pJyufTmo2YAf30fAZTcnfiegGGfiBvTM6RnGZndvvDNx0pzOk
 ZBs6EA7XPEpEK714GdgViLCE=
X-Google-Smtp-Source: AGHT+IH0CbEtEB9brPQ9X0ztEERu7A34w/N1m6R/MYRlFXhIHuMAg6EHpR51Cp3SNgtDP8c07EkWkg==
X-Received: by 2002:a05:6000:22c2:b0:3d1:c2cf:da07 with SMTP id
 ffacd0b85a97d-3e641e3aba5mr11901264f8f.4.1757506145180; 
 Wed, 10 Sep 2025 05:09:05 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e75223898csm7031588f8f.39.2025.09.10.05.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 05:09:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 758355F82D;
 Wed, 10 Sep 2025 13:09:03 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Julian Ganz" <neither@nut.email>
Cc: "BALATON Zoltan" <balaton@eik.bme.hu>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v6 00/25] tcg-plugins: add hooks for discontinuities
In-Reply-To: <71a535f9154ddc269c0a948053e39053550bd8c0@nut.email> (Julian
 Ganz's message of "Wed, 10 Sep 2025 11:41:15 +0000")
References: <cover.1757018626.git.neither@nut.email>
 <a1c2d356-e664-2632-002f-d0b9bea06e1e@eik.bme.hu>
 <cf6e7db43e9e9e59b6c9edb1c172b01ae62fb23f@nut.email>
 <df0a8c4b-ae9b-1582-1570-6cb588149a7a@eik.bme.hu>
 <3c8d0c3733edc984937ac33a417488f92dccb148@nut.email>
 <819c9f3b-13f4-2ef2-e651-5cfec52f2e12@eik.bme.hu>
 <a2eaee5105fb4b3302e2f65bb8bbea987a85454e@nut.email>
 <a18a99ca-8415-71bf-3022-c9a98e46c2b5@eik.bme.hu>
 <71a535f9154ddc269c0a948053e39053550bd8c0@nut.email>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 10 Sep 2025 13:09:03 +0100
Message-ID: <87ldmm5x28.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

"Julian Ganz" <neither@nut.email> writes:

> September 10, 2025 at 12:06 PM, "BALATON Zoltan" wrote:
>> On Tue, 9 Sep 2025, Julian Ganz wrote:
>> > I ran streamPPCpowerpcO3 on qemu with these patches:
>> >=20
>> >  -------------------------------------------------------------
>> >  Function Best Rate MB/s Avg time Min time Max time
>> >  Copy: 2867.6 0.056828 0.055795 0.061792
>> >  Scale: 1057.5 0.153282 0.151305 0.158115
>> >  Add: 1308.8 0.187095 0.183380 0.193672
>> >  Triad: 1111.6 0.220863 0.215902 0.230440
>> >  -------------------------------------------------------------
>> >=20
>> >  After doing a clean build, with the fans still audible:
>> >=20
>> >  -------------------------------------------------------------
>> >  Function Best Rate MB/s Avg time Min time Max time
>> >  Copy: 2932.9 0.055131 0.054554 0.055667
>> >  Scale: 1067.9 0.151520 0.149832 0.155000
>> >  Add: 1324.9 0.184807 0.181150 0.191386
>> >  Triad: 1122.0 0.220080 0.213896 0.229302
>> >  -------------------------------------------------------------
>> >=20
>> What was different between the above two runs? I guess maybe one is with=
 plugins disabled but it's not clear from the description.
>
> The difference is nothing but a a clean rebuild of qemu. As you see
> there are fluctuations already. Plugins are enabled for both cases.
>
>> > On qemu (6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8) without these
>> >  patches, but plugins enabled:
>> >=20
>> >  -------------------------------------------------------------
>> >  Function Best Rate MB/s Avg time Min time Max time
>> >  Copy: 2972.1 0.054407 0.053834 0.054675
>> >  Scale: 1068.6 0.151503 0.149726 0.154594
>> >  Add: 1327.6 0.185160 0.180784 0.193181
>> >  Triad: 1127.2 0.219249 0.212915 0.229230
>> >  -------------------------------------------------------------
>> >=20
>> >  And on qemu (6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8) without these
>> >  patches, with plugins disabled:
>> >=20
>> >  -------------------------------------------------------------
>> >  Function Best Rate MB/s Avg time Min time Max time
>> >  Copy: 2983.4 0.055141 0.053630 0.060013
>> >  Scale: 1058.3 0.152353 0.151186 0.155072
>> >  Add: 1323.9 0.184707 0.181279 0.188868
>> >  Triad: 1128.2 0.218674 0.212734 0.230314
>> >  -------------------------------------------------------------
>> >=20
>> >  I fail to see any significant indication that these patches, or
>> >  plugins in general, would result in a degredation of performance.
>> >=20
>> With worst case Copy test it seems to be about 3.5% (and about 1.7%
>> with plugins disabled?) and should be less than that normally so it
>> does not add much more overhead to plugins than there is already so
>> this should be acceptable. It may still be interesting to see if the
>> overhead with plugins disabled can be avoided with a similar way as
>> logging does it.
>
> The thing is: that's probably just usual fluctuations. As you have seen
> with the first two measurements the values fluctuate quite a bit between
> runs of the test on the very same qemu (assuming that a clean build did
> not incur any _other_ relevant change). For example, the best rate for
> scale shown with plugins enabled is one percent faster than with plugins
> disabled. Is this significant? Probably not. Or at least it doesn't make
> much sense.

I wouldn't spend too much time chasing this down. As you say this
fluctuation is well within the noise range.

I can recommend hyperfine as a runner:

  https://github.com/sharkdp/hyperfine

as it does some work on how many times you need to run a test before the
results are statistically relevant.

> I may do some more tests this week, with runtimes longer than a few
> seconds if I can find the motivation to set up everything I'd need to
> compile your benchmark. In the mean-time, you are welcome to make your
> own measurements if you want to. The patches are also availible at [1]
> if you don't want to apply them to your local tree yourself.

Balton,

I don't think worries about performance impact are justified and Julian
has certainly done enough due diligence here. If you can come up with a
repeatable test that shows a measurable impact then please do so.

>
> Regards,
> Julian
>
> [1]: https://github.com/patchew-project/qemu/tree/patchew/cover.175701862=
6.git.neither@nut.email

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

