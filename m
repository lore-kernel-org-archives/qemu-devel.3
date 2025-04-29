Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D079BC3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 18:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9pGD-0002Nl-Fj; Tue, 29 Apr 2025 14:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9pG0-0002Dh-Ir
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 14:00:36 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9pFy-0002Qy-1I
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 14:00:36 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5f6214f189bso12350476a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745949632; x=1746554432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W565OXPJFxpwR7G4QiUxU/Nozj7duuNh7IqlPlkMCu0=;
 b=sm6XhJM8J3D4QJ5JiSFbbgUVUtTjTHdwJsivnurFRFu1iJrz6AIqX8oDJBiSGiTUNt
 B5cyz2h8RXjifu6Y+Z3zqi4tq//rVnPJKe2d9XHnKycSbrPI8UApHo2VJjKs6/1+uSdu
 bmCz3MGjceFuOCV3Yl+viWpTn1E0OERCMAuN/OZAf1+AvoMAbqNRiepAejzfdhessrTX
 M4bLcbHEPGsV7oGkAb2kln3+y7wdbWsRprcJyneygAAUdSpxc3Lms+QGgHDAfyxZ0/Jp
 wskAp+oJqzf/xgGd4xMwzHnMZkUHmb4Uei/OT/BVE9yCDslOZgj3tUbInG8D7W6IuKpX
 97og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745949632; x=1746554432;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W565OXPJFxpwR7G4QiUxU/Nozj7duuNh7IqlPlkMCu0=;
 b=R7OjnSz4s8KkAUY2KFVxLInB9BUG7fhpvWArj8+mqXRJrOJwmLBhl23nCbCGq9BZFH
 SlHbZMRQMGXg0z2a9nTUYWGnFOh+fAOsoMBqPJWhDgN5YTKtjQAd5bV6ene4n1JG5Imt
 rAgRpAV47EaQwaqDUgz/BTtPhXCM5JQd+YNJeuC90I8vIUvuLRXYcZWggimzQRSz5S6p
 WJ4lDR5qdzFzq0sNsH1WeKPlJ58jWCyRtDynDkSOcAKr1l/UQMXVqym6jTZBW4LmLcdt
 4oxfnL+5P7dKCq2Yy1TRlkWYf3m6wuoVrgHf3cBQBHY50n11UDsn2xolhQ32ZKh7x0bB
 W/lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/K+bqrW+/SAZqqx5XHi6EoJwZso1hwxd8RtW8UhiwoQez+8RF/NeUqPEwnaqzo+X8Hf6BgFazCzoW@nongnu.org
X-Gm-Message-State: AOJu0YwZaxlQ/uCfinqUJ/n25DLDUFn8U2UdP7aXL8kE0LzywXMrMfEe
 w960JYTy8BjaIKMNP7xwBkCiiaAn18cByICcXoKTuvsWoiAZCzxB/UUHrsyQ/vw=
X-Gm-Gg: ASbGncsTNivvToeBE8Gby4SrqhWXc9rB+FpuAgEpn3qqChxvFjJGhEP7I6kW5fzyuJ9
 gJj23jfO0O30weredNWsOZsKTrjvKES48H8NAYaYeqi9S1zoVWMo843CyFkMJvlI4+dqo5kAbNv
 vpBIdsUAGpC7uGWgcvkZV+rjT0kUU9kP5E14bB+LRewZ5PeGshOIeuXHKCKzBKz4nCgg/CvFDjs
 dvicOvb28eQ5VGrFw2ToAObR6eVydHR/ZsLiDhy8W9ZdIKaRBbdN7MURRQduj5AtDPT0VRgCfPv
 LiYlkWk3Ham3yg8/a9pcCj1Q5/P0mS+3z1EGrVjPc90=
X-Google-Smtp-Source: AGHT+IHaPN0TiqOtkvWYkGMgEpdTKqJM/6qp/HIyxgjWKy06jefBqgtbGFhHzK3Jc9P8UuiGY00wgA==
X-Received: by 2002:a05:6402:2116:b0:5f5:f890:3db2 with SMTP id
 4fb4d7f45d1cf-5f83aa3b190mr3768739a12.0.1745949631971; 
 Tue, 29 Apr 2025 11:00:31 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f7011fc469sm7715801a12.7.2025.04.29.11.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 11:00:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C75B75FAEE;
 Tue, 29 Apr 2025 19:00:30 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>,  qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org,  Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH] target/ppc: Inline most of dcbz helper
In-Reply-To: <a121583f-2ec0-4f81-b5b3-1259906afb8e@linaro.org> (Richard
 Henderson's message of "Tue, 29 Apr 2025 10:30:29 -0700")
References: <20240701005939.5A0AF4E6000@zero.eik.bme.hu>
 <d3c6c417-20d9-a215-2a5c-86fa084b00fa@eik.bme.hu>
 <173c9111-e065-0dd5-c276-6bbc0351f9cc@eik.bme.hu>
 <2b969dcd-4a82-9086-803d-c52ea274fefb@eik.bme.hu>
 <e4fc537a-a15e-77dd-1167-32b12ee7a22d@eik.bme.hu>
 <87bjsf3s40.fsf@draig.linaro.org>
 <a121583f-2ec0-4f81-b5b3-1259906afb8e@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 29 Apr 2025 19:00:30 +0100
Message-ID: <87tt663l1d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 4/29/25 08:27, Alex Benn=C3=A9e wrote:
>>>                 - 45.16% rr_cpu_thread_fn
>> Hmm you seem to be running in icount mode here for some reason.
>
> For some reason ppc32 does not enable mttcg.
> I'm not sure what's missing to enable it properly.

I seem to recall it may have been reverted due to instability but I
can't find the commit.

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

