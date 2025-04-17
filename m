Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB9DC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 08:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5KB9-0004Ho-HJ; Thu, 17 Apr 2025 04:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u5KAx-0004Gw-Qj
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 04:00:50 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u5KAv-0007Yv-Mu
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 04:00:47 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39ee623fe64so424566f8f.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 01:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744876842; x=1745481642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PbO9RPjualoYCm0gLCXj1guSu2ZhGAMd21Xk3hfmXaA=;
 b=U//2XYzQrNJkNZcKjFF00VO5slZk6UX/v4BYkCFzwbdf0pQyFPtk0HXSOsMsSFXCi1
 xPz064TtukxOK0eZpCJ7rPRT/RBta3F8IuQI13BtAcr95ysiJvzGxnYCrMFz2fOytlBp
 Dis7+KEE9l6CfNy0qhfyr7OAYKQMxcDwVDyHBR0iqheL6IUPbcmi52i1iM60qjDpi8Rx
 WVCNyevpDu6poZHfghuawyaGKmCfm5Zfa1BqPfrViY7O5TOX6Y8t6RmEbxKA1NvU9MOu
 RpFKOncvVPuksrT6vRcCoAXFYvJfsrfqdD7d0ggVXXem1tAAO77K26VUJiMqW8UdQQ+G
 N1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744876842; x=1745481642;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PbO9RPjualoYCm0gLCXj1guSu2ZhGAMd21Xk3hfmXaA=;
 b=F1iSrZmtfwUVVygwNUicv1yZvoYU14P82KdZso44QvdAMfS4wAwhInXEnZFvepQiUh
 D5M/XSXVQW8xbD6PXZuK/OYm1whyb1iD8GaC1sCemQo4EDkGlrnLukGbdZVZIVmilVfS
 cHTzM7PWGZCfuImjPAxGwGYABOSNGFf484GczuXuREhyDbY5jyBY5txTAekVeDBCiNmn
 0A/pCb1lrbuJMvlsH/DBxcoI2h0lzBNd7X7IVRGtLHL9kX8Lbbhv0B9150qtQJPi1hos
 yqBOGOXzRCKBlbw3P8icAQQiuTkdzoz3N7p+iDDggiPR0vmocOt6RQ6pn7lLBTK0trVJ
 ZJrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVohUsXmh+RJ3mFuPmUfF16fVdbA+1UnHIucOyjPTJfBivz/Z+h17SJIR3QxiB8+Rh37J7dIeLoEXOg@nongnu.org
X-Gm-Message-State: AOJu0YyRCrNL2jmxZmsc+58tqsDIu480Sl1s8rj8rluqycy8x2fLm0tz
 AX0bqg2zemYdIMnsnLO1c24u2k56FEvRd30cjz3IF94iCEbfuQvgdjvHUQjb13Y=
X-Gm-Gg: ASbGncs4GnN1UYq63OJFa7STkxonX0kJ13wfJ7fi8+3oUwd4dJIeyvl7s9UcbxA6hwv
 ksbLiw/pLudAV2GLtPPiBx09fU3SlZ4J8UZmPvnFHq1Ata/tqWGV6LNlBDXZo4IBDveSh6sgCra
 9Tv6nPY+XK+9w1tBO9Ur1F7ZcetTKPWJf88HxfitnQLYRKoYkySJ/INSHIQfU1VfeBH3dFQqu/B
 6zVrFaCWABlHCFgIBstwRO3jcAEKdSMz+NgIK1ZXbQSh9/xTxmycVj0FUAoNtwh488zBYxYEizy
 JH867IGEnjQOlNwe2f2XvOkVAlkuPvhnYDSQ0Bsyqi8=
X-Google-Smtp-Source: AGHT+IGFlihEBVT4ClppGZBY2WpMuuPKHBaYjZj4Hy3uariDX8j6rVdwBa18P1glssi+7C49ecTxLw==
X-Received: by 2002:a5d:59ae:0:b0:39e:dbee:f644 with SMTP id
 ffacd0b85a97d-39ee5b8954amr4206925f8f.46.1744876842300; 
 Thu, 17 Apr 2025 01:00:42 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf445742sm19501440f8f.95.2025.04.17.01.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 01:00:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ADBB05F889;
 Thu, 17 Apr 2025 09:00:40 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH v2 0/3] virtio-gpu: fix blob unmapping sequence
In-Reply-To: <20250416145701-mutt-send-email-mst@kernel.org> (Michael S.
 Tsirkin's message of "Wed, 16 Apr 2025 14:57:32 -0400")
References: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org>
 <87v7r5clft.fsf@draig.linaro.org>
 <20250416145701-mutt-send-email-mst@kernel.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 17 Apr 2025 09:00:40 +0100
Message-ID: <87jz7jcj4n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Tue, Apr 15, 2025 at 07:46:14PM +0100, Alex Benn=C3=A9e wrote:
>> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>>=20
>> > A hang was observed when running a small kernel that exercised VIRTIO=
=20
>> > GPU under TCG. This is an edge-case and won't happen under typical=20
>> > conditions.
>>=20
>> Should I (or MST?) pull these into a tree for 10.0 or should they be
>> grabbed for when the tree opens with a Cc qemu-stable?
>
>
> Let's just agree who takes them, then it's up to that maintainer.
> You wanna merge them?

I'm happy to take them, I'll cc stable when the tree opens up again.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

