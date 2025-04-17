Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C40C369CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 08:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5KJ1-0008Tx-UW; Thu, 17 Apr 2025 04:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u5KIy-0008TU-Mx
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 04:09:05 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u5KIw-0000PB-Ql
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 04:09:04 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso3365455e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 01:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744877340; x=1745482140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Iks2MsTBd1wT8C6Or8MgRacpbfIa/nlF6jjNkiyvwE=;
 b=ylCcbDsI7cZCcnWCGrcJHHH3GeD35LwY2UYCCfGckqMvTgghkkP93fhTlvwy/+iNm+
 N2Dmm9aca5JPxt2awO2/WcVodb+kGT+1gXX9KLyFGPBJwjJwZbEFPC7FcK6VdboZe6bJ
 oOOeZY31RIR3B9A+VSK1oQ1358RUv/rg0l+3CyDaE2KOCTZz2GDj3xQyzi6Y4ayluRzM
 C6Yjq/J2rYN9d8gM6DczxyRmOrwJ5I707yj2KkVg2WpTLNTs31mFyvodQER2h3rJbl7y
 kvPBJiiGGKCOC8RTp5GHdN/g+EgNFnSZU0RwFgrcj1zhbjyxm38EpQOa5+Brd4r1hipr
 9xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744877340; x=1745482140;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/Iks2MsTBd1wT8C6Or8MgRacpbfIa/nlF6jjNkiyvwE=;
 b=ns1IQupThHNoNvUOYwud0AR/N8pbPgB5RrtFwQdm8ElN2s4W+U0hTN5D30CQDdEsTW
 zBN87obttixTfPMxWkPgaTTgmYK6wDvW0n78zTIKoQGf6M8ZNNws3zYbzrIZWrVaGwun
 +3SjjSKRA71ftkzgefYQfeGu6Ybns4nn4JDgDXm9phByCSZGpGzcfbGrKmB4lyMjJYZR
 5tp75AT8+5aD05taZ1knRBuZmUdu7GlDpj3xldFFc5b3NlDRj1ryEZaj/rWuXdeBj5Z2
 4DbuCnEUfl24wnnpFqttm5IFkqicev0eua7z2zMwVL3vI3+wkLe/XUQ3Ito7HXRKXqsa
 ozkQ==
X-Gm-Message-State: AOJu0Yz/xhlimO+tRrqNOWH4NtXoYg3dy5XjZN8zVHafWklLY+mEgOef
 xR3KTzu7l/RD1kGr6vUUjPWMHUcKLfYgdaloGECC62DotvfVopbrF+SgEimMot0=
X-Gm-Gg: ASbGncsp5ZpVtksn3jflauyD4aBFy0UpvwC7jXFaT57uJ/PegsSR7sJh8Eenn14c1ki
 j7SbTKBXoY1rpv95ZRjpkz5XJ3hRdsiiRZsnlSgkoHw05FRxhYSDh5FNRsS2AQptRz0vFQc0b+3
 j0SL19A6nh0EeWosXjgZR6hvWQ9aEsCIvHeAAdtMA0UQx3sShz7/QNd5wl+SHnLlaw5q83saLNh
 Fuu+VRNFVhRbPzzGHnCbzBfJ4fqeMTi0u2IQwAHPOk4Km/qHay5LyFfLl9EKxi0hrsORtG5HzVN
 87htye2486bxqcx/he/NBy8oR5XJ03J9z/S643OawQs=
X-Google-Smtp-Source: AGHT+IGcTQW0nn4nSK4VShTZR2HV44YLjkljNpVmHwQsjkb7NhVV7YeXpwdHEwOIMOIZ7r/S+nRVhg==
X-Received: by 2002:a05:600c:811b:b0:43d:ed:ad07 with SMTP id
 5b1f17b1804b1-4405d6cc339mr41875355e9.29.1744877340429; 
 Thu, 17 Apr 2025 01:09:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae963fccsm19145095f8f.3.2025.04.17.01.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 01:08:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1D6DE5F889;
 Thu, 17 Apr 2025 09:08:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 0/3] virtio-gpu: fix blob unmapping sequence
In-Reply-To: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org> (Manos
 Pitsidianakis's message of "Thu, 10 Apr 2025 15:26:35 +0300")
References: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 17 Apr 2025 09:08:59 +0100
Message-ID: <87ecxrciqs.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> A hang was observed when running a small kernel that exercised VIRTIO=20
> GPU under TCG. This is an edge-case and won't happen under typical=20
> conditions.

Queued to virtio-gpu/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

