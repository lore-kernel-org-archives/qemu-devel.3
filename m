Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F7EC28B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 06:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsG0m-0001eZ-3W; Wed, 12 Mar 2025 02:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsG0b-0001di-VP
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 02:56:07 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tsG0Z-0001SO-RW
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 02:56:05 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224171d6826so27776195ad.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 23:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741762561; x=1742367361; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAZpz1vEN6Y89r9ToEq3E9b/zErY8uDj1nHE+SeSmpU=;
 b=Hdl7pZHgH855oKLO3vczwUQdryKHgiNf3FbgYGgrTKkq/B0rqggZ1kngr8FII9j+XY
 aBlX32QRTt5Q8AHoyy41tfBzYtoXH2f+8+B/rHXgUDSn+oI0mOwQKnvByxXFxEenrqsZ
 Hghanlkjp8GZe/2ROALIU9y00mfTGEz3kWSItIb8VV/Y5qvxMKYRCML5A+OLwakLXuSC
 nW70KuY4vihz5kpDn4ii2j5NF6KyalvHZ7SDaLbDnj9R+hRAlG9BO/kJ60WuJtaJBjx2
 p/GzciT/5w2QPgrvFLhOQDTirrGYNglN4uagIVI73GUt9H3pNCIePF3Ltj3QwhJtsfEc
 DU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741762561; x=1742367361;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oAZpz1vEN6Y89r9ToEq3E9b/zErY8uDj1nHE+SeSmpU=;
 b=I+S+u94XxkvVUrMLYreKZiqyNeWFnYd9Et8l0dZcIncE+udcSgukR4ieiuKhK2vE3M
 Gg1Iigx6Pds6FO+VwNAfyWFOzu79u4E+spXfIPnk+VPefedTKLk3a88GAShRAYCk9p7r
 kLnXuqwZWTAJnbcn1zun2B/kjgy+Aag1jWXfv+Rj9eZm0YMs0ETtiW3QlyChHXE9gatw
 UVIR4kebG9gYTrbvZEhWQvp4ck49jUTMbdAb8TenpaYNGbcY99h56oKMd5FrKIXgxSwz
 mUFoxCIBBeaVnVT60X9A39kslDGfLd7hF6I4hAGoVAy0JvtfvZlTqKO7KOfVYgU9pjrn
 rbxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Qdsp8UdfvD822hbfRur+anfmcGt2tFnN0x+pUmozGccD0uNdUxzu8y7m2OxmWVbohHJYGtVpDgm6@nongnu.org
X-Gm-Message-State: AOJu0YyIJP2lPAeW4oeHWaOSiCPiGkWi2hW/Sb/sATFtrS1UAlXqlmuK
 Ffmwam9IgEXmucb/81dokQBzCPgkkoPxLquGHmuYj3wLztctGkVP
X-Gm-Gg: ASbGncuI+TEkU7ZEa3y4qSfRS6s9uQnPkQIxiaFj+JHziIC5e5hRQkCa1ajwKnsopca
 A6zPx7DqZGyyJL//nCfIcgwdK2asPy7KKFu0PZmeHXyC3kqqnQyQ4HURgr/beqk99Zryde3qhqI
 RKvLWIx+cgqsQ4py+0bt4ZZl6LKFc7X1GYLl3CtxK1uDC+y5cs69I8fLWX5kaaNlMuV8f8Whic/
 HLMZ/8DBXYpC9SfNPFRvSVDPbW/TvDa+bmw2RanmdxDhxXb9FQqU/rD3YCh3FmMByR3idjV4GW6
 5a/49BLBAAuTOfcmfaq16lYeD67CTKTdKBdTmPuFCZC7k8COq9Y=
X-Google-Smtp-Source: AGHT+IGcTGa8BDZjGZt6lybwxdgz5TjELzjuPwWhz10bU4JXEn8gc0GSvPNmSNoCIOXN6CCURO8xCQ==
X-Received: by 2002:aa7:8583:0:b0:736:ab48:ea35 with SMTP id
 d2e1a72fcca58-736ab48ec80mr20250498b3a.1.1741762561269; 
 Tue, 11 Mar 2025 23:56:01 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bac9023bsm8680438b3a.99.2025.03.11.23.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 23:56:00 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Mar 2025 16:55:56 +1000
Message-Id: <D8E3AO9HFZHM.29ZMK97VP5Z3Q@gmail.com>
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH] tests/functional: Don't fail any precaching errors
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Thomas Huth" <thuth@redhat.com>,
 =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
X-Mailer: aerc 0.19.0
References: <20250311131327.903329-1-npiggin@gmail.com>
 <Z9A8swNn6zBm57jC@redhat.com> <D8DU1X7UDEPK.2PZVT8SJAWUFI@gmail.com>
 <45d36146-3d2c-421e-b58c-0b1ef50ee81a@redhat.com>
In-Reply-To: <45d36146-3d2c-421e-b58c-0b1ef50ee81a@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

On Wed Mar 12, 2025 at 4:36 PM AEST, Thomas Huth wrote:
> On 12/03/2025 00.41, Nicholas Piggin wrote:
> ...
>> I think *no* precaching errors including 404 should cause
>> failure because you would still want other tests to proceed
>> (in some cases).
>>=20
>> But the failure should be caught when the test case tries to
>> fetch the asset, so you can still easily identify the download
>> failure.
>
> Sorry, I did not get that... if we ignore the 404 during the precaching=
=20
> step, how should the failure be caught when the test runs? The downloads =
are=20
> disabled that case, so the test cannot know whether the asset is not=20
> available due to a 404 or any other reason...?

Right, it would need something to get that error to the test case.
I had not thought too much about it if there is disagreement about
it being a good solution then no point.

But some possibilities:
- downloads could be enabled even for pre-cache case
- the pre-cache step could build an in-memory dictionary of the
  assets
- some additional file name or attribute could be added to the
  pre-cache to convey status

I didn't follow the asset caching rework too closely so I could be
well off the mark, but I would look into 1 first since it might be
simplest. If that does not work maybe an in-memory metadata of
assets might not be too hard and could help with flexibility in
future.

Thanks,
Nick

