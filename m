Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9F6C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 10:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYjkB-0006QM-3y; Fri, 17 Jan 2025 05:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYjk2-0006Nt-1o
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:38:19 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYjjz-0006Ez-4A
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 05:38:17 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aafc9d75f8bso328127766b.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 02:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737110292; x=1737715092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vRFyWxzilTzqm609RjKfzFEx0OMx7BNr5J1PdPzYF+g=;
 b=QH4rATXW1raKb7/zvgWz/PUhr/BeqllktIOo9FiApsE2RxS50/IumgnhP4PrCxKrOe
 KB4cgvGQ7/9r78Suk+GrOZ7xK2frAifVJ1pbfkvnCeuQ2foBEEUXA6YoxLsRZMU9M8e8
 udEXXeQDsIh9Jg2LfsiE0rNSfe4+KQlzmLHau4Pm1/iPusInLayGhPHs46Q2/Pt5MAOy
 QkxO9Ws6+bGldKAbxZLGqHKh35O+u4hU15/X8wuylEOKoIRetZRK22ZHwdJOTV3hITxE
 5G8dadgA7/hYGTI58F/mycWL6dbQJbeAzqRLFGEG/MNlv9dYfvIN2VeQRS8LsCigjTmU
 2pLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737110292; x=1737715092;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vRFyWxzilTzqm609RjKfzFEx0OMx7BNr5J1PdPzYF+g=;
 b=A4q9ojF9XgLoPad9ts4lFcvREq2zDngxHzKHDicL0kqD1ki25I1Rpi5n/kOTrGOcYO
 n3nUzWQisLtSR08PO6gj/SPfUArf5MtYXWAUqInnf1mo5C7L2fBC56RwrXoRKG2Rrjpx
 RkdpDT9vMHuQfI0zR9ImBDIdjGu+0NQtzaWaYu3ApiPE+36CXvL+QXSv+qUTqiz1+pwl
 X92A+yJydkemiLsssDrZjYHGxC9KrEc9XHUQ7PED6D5flug3qPQ7VzW9jkuyp56fgBNI
 blNh8UEdZ57jaajIQ/TxUopzrVhKYDrXI2xV0V/9cgsMc4NgdHFvPBX1rBz0VfM36Vgh
 8Ewg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH4/k5t6oNbTsjPtqbV5WeQNBfmn63Mj535ue+XVxqsT3fkv6uZTMRZL7gysf1cbjl9diZjB5vYnmG@nongnu.org
X-Gm-Message-State: AOJu0Yx7t63oXnhSUaJyaCb8ooUVewS4neqhOTu8cC43OmpOpDKq10VM
 gWabKkjmENUmw+4pnKVEv5DLcWnJa9bOkujRHy1oDrrYZ6rb+oxSZ1rLiaruYRPunnufzt+G+oP
 8Fag=
X-Gm-Gg: ASbGncu4FIDSyGt3eLIA9yduWvBfkzUyhCIYMGOkljptZ0/ecn5wmbRvDRw7VTuDc4b
 l+AittIpHfslnFOF/h7nWK19q/nC6z0Y21aYjGZye5ocbqMDS2MTHIWKA/DPzycy0NWcCLEOAHF
 By4ESpixsOkhUQElNyXEhN+Z+anWwqyF3u6oDwyHvuSxfnX45+ZE+e6zgEucy3Ucct7hg7WQ7B4
 FLNG/4gpwzk3Ug93+DxT9gOKDt683vbMeAtSVp10xLLACKts4nvVJQ=
X-Google-Smtp-Source: AGHT+IGQF3SRExeWmZHjj4auvOZtfO/UR9lI0meRdRr6SQU8DY1a/fRDnLBxIDR9Vlo1fYf7NqTRRQ==
X-Received: by 2002:a17:907:969f:b0:ab3:76fb:7523 with SMTP id
 a640c23a62f3a-ab38b4a8ed8mr231543266b.53.1737110292226; 
 Fri, 17 Jan 2025 02:38:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce2105sm149491666b.67.2025.01.17.02.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 02:38:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C4E716083E;
 Fri, 17 Jan 2025 10:38:10 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] tcg: Document tb_lookup() and tcg_tb_lookup()
In-Reply-To: <20250116213214.5695-1-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Thu, 16 Jan 2025 22:31:32 +0100")
References: <20250116213214.5695-1-iii@linux.ibm.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 17 Jan 2025 10:38:10 +0000
Message-ID: <87frlhhgj1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> These similarly named functions serve different purposes; add
> docstrings to highlight them.
>
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

