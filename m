Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D849C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 16:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXNGZ-0006QP-RK; Mon, 13 Jan 2025 11:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXNGX-0006Pt-FB
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 11:26:13 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXNGS-0003VV-4q
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 11:26:11 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d9f0a6ad83so648038a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 08:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736785566; x=1737390366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLepUCxL+2iBrTVKhtRYOOcQ7Yqi1Ij2tD+XmIEcCXc=;
 b=BDJ3LFgHYI/mv7IGgZX5z6kpzL9u7mA17KNPPnq7oHPt9VOkKIolVJE7tNZHYdGccb
 hO0BVg5fSD28emAiFpRJVXUqJJTLgv98DrNs+c+/8da4wdQOBg4uRqS+fL8CKWGveJh0
 vvaIE7AyXtpPjVU6OEPR11oZzJWWiRZE53oqO6ROfeuS2dAY836nVli5ZfzhebH6xfPH
 uKPfd04/yUMTVNb14yQCNQuEVkUZm5iB0OWoguPEqhaFd5RyhlmG59MXOMX9RdaEVTTB
 0rLWtusiCp1HigozHElmlQHOnlkWP3zxLiZnFUaH1Ud1xIDNXuTz3tcozFmy2mGQR2O/
 +EuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736785566; x=1737390366;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dLepUCxL+2iBrTVKhtRYOOcQ7Yqi1Ij2tD+XmIEcCXc=;
 b=SlaUu/p2+btTlPcsFtAxQaFAGldrIbJkF4qKNMM0ZUOrriwOynovnxSwrIDwB6oGTX
 AWDb81vgqS6tsyCljCISLu8y7Pm3zNXFHf66UbpzKwYZ5zIHeakl+qxn2ac3vhNmlLcj
 zH587t4xmVXd3jDVp9CSgjNEW80e3Yi5rSk6Vqzm8YNL3L4h9I3F1pe1V8CEQ1Apa9ZT
 R8abQTki4u03SPi99etPLxouoDhIgLqJBU1U1AS5ecyLEATpdMCKqOxPo+KVuHfw4QFK
 jKeHWiI83efvnNbbjgpQJdRRm8rj0T46QBrQd3aEfSrSWNvjznbChd7c7exC6fXJFde6
 vqiA==
X-Gm-Message-State: AOJu0Yz/eD7prnnPlYgyN9x8xvHwCJrQMSdhuwjWa8b9FkUL8k4hLLJA
 vuncRoJ96KYcheXblmdGuH79FfhmnEoX4nz9K3f8Vhj5nLsoE4ixJQrec+JI2yoiY9aWzGuru1a
 zdnY=
X-Gm-Gg: ASbGncu0ME0uITf+78jxVTsSOsnKf6NZ/5jGMXLd39aeaBWHo/BIIt61sE5zYhUUyjI
 /B2KP9T2Vth5c6J/JWNSarser8dbGSm4JJqxe9buSFCC5s5CuGZjwev3MMRNdvY3ldW6WkhwP1M
 bwmgTGy5CPEhBXkm6znqCeipjRptf8OOSFXOArPdBWIaFTuOqIkSeXE/zIhnHxdEuz6WUrSOrnl
 I7UXzjvbY+qprc2v21Gd7zbgkNjBfQyhsn3yfXvXBkueX+fbiIZ7aQ=
X-Google-Smtp-Source: AGHT+IFacEOQ0n7s/Au3f0MeyVp0jq1QAS2iDiaINU8QRhzUqi57DVRDRs26bdW9UuCSEQj/gSg2nA==
X-Received: by 2002:a17:906:ef0e:b0:aa6:9e0f:d985 with SMTP id
 a640c23a62f3a-ab2ab748e6fmr2171896366b.35.1736785565839; 
 Mon, 13 Jan 2025 08:26:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c9563af3sm525595566b.105.2025.01.13.08.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 08:26:04 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4A0975F713;
 Mon, 13 Jan 2025 16:26:03 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  qemu-stable <qemu-stable@nongnu.org>, Stefan
 Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 17/32] system/qtest: properly feedback results of
 clock_[step|set]
In-Reply-To: <15435e6d-a77c-4d3e-ae06-b1cd23fbee61@tls.msk.ru> (Michael
 Tokarev's message of "Mon, 13 Jan 2025 18:22:05 +0300")
References: <20250108121054.1126164-1-alex.bennee@linaro.org>
 <20250108121054.1126164-18-alex.bennee@linaro.org>
 <15435e6d-a77c-4d3e-ae06-b1cd23fbee61@tls.msk.ru>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 13 Jan 2025 16:26:03 +0000
Message-ID: <87frlmllyc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> Ghrm. 46 recipients seems to be quite a bit too aggressive..

I think git-publish just accumulates Cc's from each run for a given
branch. While I can reset the version counter I'm not sure where I can
reset the Cc list from.

> 08.01.2025 15:10, Alex Benn=C3=A9e wrote:
>> Time will not advance if the system is paused or there are no timer
>> events set for the future. In absence of pending timer events
>> advancing time would make no difference the system state. Attempting
>> to do so would be a bug and the test or device under test would need
>> fixing.
>> Tighten up the result reporting to `FAIL` if time was not advanced.
>
> Is this qemu-stable material?

Probably not - I guess that was a Cc from a previous series that stuck?

>
> Thanks,
>
> /mjt

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

