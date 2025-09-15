Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DDFCAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy6IK-0003de-OY; Mon, 15 Sep 2025 06:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy6IB-0003aa-8F
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:18:39 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy6Hv-0007gl-5d
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:18:36 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3e4aeaa57b9so3390699f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 03:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757931497; x=1758536297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3j6kpaAA/zdlWJrqLVWFFIySs9ZJWfWWyxqZnZNzRhU=;
 b=YcVrQ4gKv3IqIFmWL0O+Rsd2maK9nwBaMDLd+C3fPGd/dkEZY+wwcZ9AbH6S/nAAnm
 XQxeVkAX1pLev+EHcbwSc4WhV5EdXhsgtT6SrgExwLc3iOAdCsKyFUPZ3zyltYzeLEAj
 iKFIPZQakg0vbgqMRWLYDeNrbwYEM1IyWwDXaU+djCchK8pcBEYhCvMRnzCVgQ3j7NTK
 rPR0K5W8LC5TmC+w20FgWDv0JvH7V5V06t0Fsd2FoRSip0pguGDG8Zpaus69uNiX4UAx
 fO0m6c5aU342lXLMZ1qy/8xZqnFdvEGE7fBosYjzkQwNMWhABAkyDafyBrSj4Mts/jYG
 FZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757931497; x=1758536297;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3j6kpaAA/zdlWJrqLVWFFIySs9ZJWfWWyxqZnZNzRhU=;
 b=TSLe/8q6DiRSIx1Wbbp7j6P4MWbm9acI/G20T0o6AZkppRxhQUwBGUv7w8m3iZGgsb
 Ie8UTpe4KqbSaPLmttKzYN/Pn53KbFW/tkdhOcChvFgh7Jd3P7B+wrPY3wGDg8pwBCr1
 Q0iVTJP4PYKXps0Q4b0DM9j+yp7699wfPfYXl8guZzpKLoVwhWo/2s1t7Ku4iCWEZN7Q
 UqY6yr6yQBJOFXma+Gq3dgCZFA3fWUGfqi7xccQM1Sx7jbIymafaZ/yBlKEQkKlsoWSS
 rDyXBU0+9zEEOPkchQOVgFWwenIahJEWDMjX3njsS2DTW6/fz3aztZZBrjK+MI8NY2XZ
 48Og==
X-Gm-Message-State: AOJu0YyYU5+ONjH2Io4kN8HsHRhiBRO8CNtPey1tw1H8VkwGQ37aNrZy
 XfCThJhH1xtvTaAJCsjKdUoidJykNljVR7XwgtXSCT8oKautOGq/opH0v99vT5UX6JdP7syFYvs
 CeCsT1zc=
X-Gm-Gg: ASbGncupcJ4eWZoGGy3EDjFpplJ2RGS4A4JZPWwHW0XVZju5ImoY/tHmbrHOSmQ61u5
 dYyIxxw2RrbIZNWRCHCs3zUCOECbXMRHw4S+8F+8JDu36M/JyK7XBGOv+Vv35wiw08Jl6PDAu0D
 fW64S6QKnwMIj8eJEmhYWhnwXXNSdw654+ghSBdowZT6NAVG+jz3SoLiS3BD9hvxmIhFPc9tz8w
 Nmscky4VllOu0nkcwHzHPvX7rJnVuPBKi/4Qw1vcMIqDpBsRPQ2Bk9L/6fN5Mlt5vahoMo6Kiey
 hLZbdCK7H0ULRJED8GTs93g7sufkzBSxzpRTRhM8h9JaFIi6xDbxkrsq2RC6XOdyEsXIwUsM4c0
 SIbTHIrihYMmio0+W1GHwTKDxzwB8LNuGIg==
X-Google-Smtp-Source: AGHT+IGAmZR2LnSLJup6SXh3H/OaQcCINmFBUrqn2y1GVw6vgVAT9BrtBytaQIokleP6CnndkfVTqw==
X-Received: by 2002:a5d:5d01:0:b0:3d7:38a7:35d0 with SMTP id
 ffacd0b85a97d-3e765a263c3mr9731994f8f.62.1757931497484; 
 Mon, 15 Sep 2025 03:18:17 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e8b7b6ff8fsm9051158f8f.61.2025.09.15.03.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 03:18:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 217435F867;
 Mon, 15 Sep 2025 11:18:16 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 5/6] tests/functional: close GDB socket in reverse
 debugging test
In-Reply-To: <20250912182200.643909-6-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 12 Sep 2025 19:21:59
 +0100")
References: <20250912182200.643909-1-berrange@redhat.com>
 <20250912182200.643909-6-berrange@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 15 Sep 2025 11:18:16 +0100
Message-ID: <87348orpcn.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The GDB socket FD is leaked currently resulting in a warning from
> python about the unclosed resource.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

