Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6F3E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 14:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tU5aa-00020z-OE; Sat, 04 Jan 2025 09:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tU5aX-0001wn-5i
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 09:57:17 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tU5aV-0002X0-IB
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 09:57:16 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43626213fffso81896445e9.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 06:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736002633; x=1736607433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5nfImi3ha52/sGabesTZrYrqm4vSNeelgn92bkHRHg=;
 b=ZIQD7RWwO5lvCKTbTEvIpxO+iDnhiIsZKItapRgMr8irztKm/ZC4DxzDMOUR2SNkBv
 5B39uV00XA3btkDDEwQ287QnoiTUkOIOcLQhf0Q8TAKRB9IkIALkNd0r7bQ2f7CxRRFR
 AjMJA/WU1aGaAiNXz1iF1jKYPjxlorI1f+mTiYwJyhoOfIO0sr1p/jVnyOQO6xmVnlJx
 y3DxKRZJhef/wTBMJHJQaKORj75ACuz6LMWmSOurefqKKYBM+FLvjebNBZkIGJY1Fskg
 W1FHvujEK8yBAaMyaJYmaZHocFce2FsmAgjIsgyuuAaF5FXPdqH/jciYjEhkcIx3WbjZ
 D8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736002633; x=1736607433;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y5nfImi3ha52/sGabesTZrYrqm4vSNeelgn92bkHRHg=;
 b=saL0yOTGGiaryqeaBN2KpIdhX/+Oea6M3tKYmq75Zg5Zvkxz5ikzq55/xYboUxvM3s
 rrGeZEzFFG4sz13RhBKThenORiLp3CnzkX3S3TmKmeHfGNI3JyeF0Ibm/DTd4m+hsVJK
 kfvGrP/wLPLzUiMAOKpvBIJeDoeGIITEbmDJeRqrLpIJDpTIbA6871rxuVFWSC5rgYMr
 jVsL4A9WDsl5CDaMw2kdc30/x/qDIlkPO0qP5NCXXZNHNnWZnL3EiYx5vU9/c9X3pvnT
 AhetZ4qD8FjXUflTjUbqH2d3o5nWypu+dO3bwS1mp4rZhRz037FiFc3JvhOFKrXaARi+
 wVUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFfZiBFW2RhRU8OUOnEpU0xcMY23jc50PNMtBCQQ1vrf51pV+HQEVtTBAWZB70DkNftxrQPRQJR5RT@nongnu.org
X-Gm-Message-State: AOJu0YyK6w5pRCNjrFatCcfQUl7PQ9qaM+LrC18jC9cI9zcYSEQyoDss
 WNEvE5JqVgSH2uyZeOg0QJOZMrCikorETki0BulV+24ct6nKXJp6DPaDpKRlLFycu5DfbZL83Bm
 /O/Q=
X-Gm-Gg: ASbGnct1bTsJiwK0IQr2qNmI6msBssvkqJsEFzklRc0A0+T+join0Tf64Srkumr9s8K
 xUIl6jD8Nc/DynRFckYcIG/on3CklG9gHMNwsCKqSHaFB3Y6VD6FqSgg2nVFJPieIX8V7Hc1nTk
 lMtXuT1xvcefZKZxE8wrqa9/BIg9qRtNmPxuS/cq1GD79xQXiQ3S+fmWQQm0AWvRGJYrnGJABBK
 GJzKkqwlGQvfh3myo28Fs2dcs9kX6KAqgqA23g2wC4y0z4NxjzJ1wo=
X-Google-Smtp-Source: AGHT+IEsBwK2my4Ind034a7eRYkWyt3rGMXacFBdStzjhV2tkxkdkA/Zu+vSQfF1BPhCmzPXASu25g==
X-Received: by 2002:a05:6000:4a0d:b0:382:4b69:9ca4 with SMTP id
 ffacd0b85a97d-38a22a65bdfmr42824612f8f.26.1736002633550; 
 Sat, 04 Jan 2025 06:57:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c833149sm42892444f8f.39.2025.01.04.06.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jan 2025 06:57:12 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DAEC55F77B;
 Sat,  4 Jan 2025 14:57:10 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: wainersm@redhat.com
Cc: philmd@linaro.org,  thuth@redhat.com,  peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: Remove myself from reviewers
In-Reply-To: <20250103194450.360789-1-wainersm@redhat.com>
 (wainersm@redhat.com's message of "Fri, 3 Jan 2025 16:44:49 -0300")
References: <20250103194450.360789-1-wainersm@redhat.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Sat, 04 Jan 2025 14:57:10 +0000
Message-ID: <8734hyvd89.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

wainersm@redhat.com writes:

> From: Wainer dos Santos Moschetta <wainersm@redhat.com>
>
> The time I spent contributing to QEMU was great, but I've not been active
> for a long time now. So removing myself from the reviewers list of
> "Integration Testing with the Avocado framework" and
> "Build and test automation" subsystems.
>
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

Queued to testing/next, thank you for your service.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

