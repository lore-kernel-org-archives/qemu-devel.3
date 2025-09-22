Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9762ECAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 10:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0dvt-0000fR-WA; Mon, 22 Sep 2025 06:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0dvr-0000fA-NN
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:38:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0dvo-0004gz-Cl
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:38:06 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46cbdf513d7so10548885e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 03:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758537479; x=1759142279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXYLQXF5lh6VekWK/qOtpACANc5VDw5OfHlBjpQiS0c=;
 b=LmBTCKHgNimZlnqi+ooVeLD86xL+G5XbHQ0uIs7unaNsSpSZUeY7ai22dvukCLRqPz
 tzWavRfkgfQIXyY+13NVJK+HWwmyzkURsTd8COKABTIx/Zsr4Me7XVHmYyQztOdbW2NB
 Q6XXjbbrKla156Zdk0eetfmsnj19YE3x66afXv0jleGzjxItBEcT6A7yJGpGr47ifyov
 fuwD+NHlOIllE0t4cRhImIsxjNwYwKB3ARbw/1YPoNDKGlskDmzDnqc5IJQBlxPyDpop
 7V4pbRV+2ZK4tPVGBScGxCDsTt6wfqEKdDcNg+Ikn61/5DfWICvEboSuH43Nu32/fxVe
 p4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758537479; x=1759142279;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QXYLQXF5lh6VekWK/qOtpACANc5VDw5OfHlBjpQiS0c=;
 b=OJ6yaGNLprKC9y4CscKsPLl4qsNqMJT3YzkzWRp64lD1Lo4SePxCJA0TDTkJtoT78Z
 tmM30QO0FGOpqXCGmfrIRoVzl1VcUB6OnnwyE5NtK4Ufh4CWVh+uWemtBZZit+pnRTBq
 xGg5IQ6JykzOjQc8B28oGRF6sKKlqlkLCTvECPp2ghiVWzhbxSl/MnjjFSF5Ga+Zguej
 WiQB6ooyeDdLt8dwKVBmKRt5dFtXuNkRbRIbXyC7/EBf3gI3C2wri2Thnatf4mM0QIi4
 FjLY33+CxjpV0gfCeVR/jaNdM0RuLlisgs6DJAvkzBqb9ELer/AlotrkROOImcLEULD/
 PPyg==
X-Gm-Message-State: AOJu0Ywzgrob3dTx7nbzFQ9dytgk98KkgzU031MoBhuhEHXivYo+galb
 +Vcdzi4Y5ItZ4aXQblbVmG9Cr3Pm7eyq88dBq9ha+ADltqgIW+hReMJODDFaypvPctI=
X-Gm-Gg: ASbGnctlbNh9RuRHGUYcpbr/htI+EXD9ZLfBRGtEbf4tq83MQ/ATjUYC/OBsOM0uZ9a
 a2cH28hjV891VYpVHpBWQntZt6sKD9b9bsEYXezRGJPlVa4yNOPfsytjbu1Y7xA8Z3Nfvi4Wtal
 vGtQcr1pVMkIY03He5Fz4sDsUB9R1vOMrztiqxozkmrsSDXG8zvukehBTcKlk58gyO90eo/ovhI
 mt2bM0gzWiwO890gnw2zfgIwdfVpu51Igy6rPw9jfzZ2HRlYWVKcenzDS/DU9ffVCvEPFGw0YZW
 z/4uDy3u2anrH52RDghiR/ghwE6rO3PmKcEcwkOCNBEWC0M1w8TjJRQjoYhawq3xOS7EDXp7qX5
 C3Y7/+kzgf9yt+Hnnkgfv+nQ=
X-Google-Smtp-Source: AGHT+IFMexRU56tFrSGw+nmhgQFz4Y2flPA5GFwXAywpIcS3fJItYge9Z+eYYBQ6Jq1Iw1E7T/4f/A==
X-Received: by 2002:a05:600c:4755:b0:45b:81b4:1917 with SMTP id
 5b1f17b1804b1-467e6f37db6mr135765495e9.10.1758537478944; 
 Mon, 22 Sep 2025 03:37:58 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f0d8a2bfsm203412615e9.2.2025.09.22.03.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 03:37:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2AA1B5F7C4;
 Mon, 22 Sep 2025 11:37:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  mst@redhat.com,
 david@redhat.com,  mjt@tls.msk.ru
Subject: Re: [PATCH v2] virtio: Add function name to error messages
In-Reply-To: <20250922093632.381955-1-alessandro@0x65c.net> (Alessandro
 Ratti's message of "Mon, 22 Sep 2025 11:33:15 +0200")
References: <20250915162643.44716-2-alessandro@0x65c.net>
 <20250922093632.381955-1-alessandro@0x65c.net>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 22 Sep 2025 11:37:57 +0100
Message-ID: <87348epybe.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Alessandro Ratti <alessandro@0x65c.net> writes:

>> > For completeness you could also fixup:
>> >
>> >   virtio_error(vdev, "%s: %d reason unknown", __func__, pnd->reason);
>> >
>> > for virtio-ballon. Otherwise:
>> >
>> > Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>=20
>> Thank you for your review.
>> I've missed that. For completeness, I've sent out a v2 that removes the
>> manual __func__ usage in virtio-balloon to avoid duplicate function name=
s,
>> as you suggested.
>
> Resending v2 with additional CCs to virtio maintainers and Michael
> Tokarev (trivial-patches), as no feedback was received after initial
> posting.

You should have added my Reviewed-by to the commit. You'll find tools
like b4 can help you with this:

  https://qemu.readthedocs.io/en/v10.0.3/devel/submitting-a-patch.html#prop=
er-use-of-reviewed-by-tags-can-aid-review

>
> Thank you for your time and consideration.
>
> Best regards,
> Alessandro Ratti

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

