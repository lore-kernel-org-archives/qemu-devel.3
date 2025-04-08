Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A567EC369A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 16:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2C8V-0001kP-1y; Tue, 08 Apr 2025 12:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u2C8T-0001k8-0V
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 12:49:17 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u2C8Q-0004v7-N8
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 12:49:16 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5ec9d24acfbso12539973a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744130952; x=1744735752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YmxFs/8Z6wIchrJvUZGs5jv1CY2mwpaOOrLZBmJJhFE=;
 b=aXHBcu2F7lcjpaIZCAJfkmjyB3nuAh2wPTb52gY7vcCcaBEvDnDEr/RRCQ/RFLg9ZN
 EEmnrXt1wlDLtutVAGWlLmCrVWqAbcQr8ES8LR//hqkIZ+5n298LhMD0LVLj735Y+liO
 tiOZjiPg0ZKbsBZlOM0MfX9gBBcncd5ixpvYsmqZ9oQz1zrxfh0S7wz5spnlDYsPdDHK
 kKwPfCyvHsMUj6KnGOMCO42C2jmgIA5as6JIwX95uXa0g+Z6QYkKsJQcghvbQRtLdDnJ
 m0jPt9w2ai6fRLy3pia4hgsFP5D/tzeYYzWragC7BYvawXq/EwpHw+p3ppCUxd+Jc+vG
 j8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744130952; x=1744735752;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YmxFs/8Z6wIchrJvUZGs5jv1CY2mwpaOOrLZBmJJhFE=;
 b=uDrUr5JN++HoZHTCpn7jMIWOk7puhGDuj8NZLyNKD65V+qBI5CSqklBieeEo977fCS
 9dDvfBpQIH2G5aOX/bhic2VGUW2cNC+T3ub2ydfbiRo82L0QaMboYLvhEG8PkqCdD8sL
 1Wrczvwg034qTl/RX4vfpxF0eIAmTR712Qg1q7fABx5R1pn4NzY5UHGYbEgPnt9ioyjm
 tlAqa9nEQNe5UL/finnWVKnSOW3WA1Lk7AoS8cg40wQVNOpJnqUFFmQveYOaHDzhbzvK
 AYVveDUb60310RiW+FEYhHqwdcwYh8H1h04e5E/VQZ64uURDDWRN3nx7rvmEH4sIaK7p
 goxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/pO/YcuJa34zQnQjIQCpyP+kPJBAhuwaNPE2vpQy8j1tK3VFrJBsU3wmM2dTsczaao19ddB5nAaJ7@nongnu.org
X-Gm-Message-State: AOJu0YwSomJYS6Y7c2VpkTv38dUrex/oHBdvQzTfN4+X1HOvikkaisb1
 gGJYP9/aGMhlK3fH3Wl7X+N7epa+BrYetgTZsZmzYPVOdRAwqBlVaSiKa1X4CtY=
X-Gm-Gg: ASbGnctOsZCD50owykuuB0WeY5b0Iw7CCqV2cijt9RQAa0slr+cfD+6IfUGXscFvd+7
 0q60Yd4yXZ4+TXeVYeHsFmMM/a5oedeGUaZlIuDtsxRlpMpfKWP3wP6lD4YdrsYFI1ol/I7yr8o
 UmnDskfs/KJmXek6AkzDS9c4hEZbi7jyXnAUKBf5PTTERPpZAX/46fM0csH5X3Is5OrTOBLsL1e
 PTHwPOWoL/iXHzGGZ+HDG+M68QIXbG74vT8aDQhH4z75jYGnMSfmYzGXz4mLPzTezJDbAvAyBJf
 5c9UW9z/sMVzNq/3vZ7ow4ab35IpLW0gjYn3Am09Dj9izFE=
X-Google-Smtp-Source: AGHT+IFO6mvFTdo1/lFUW3hl4mz0w2UuNwCf+PBUN0ILwUPJIIMQ3bSNzkZZOHT2axBCnvpqRjX92Q==
X-Received: by 2002:a17:907:7f8b:b0:ac1:ecb0:ca98 with SMTP id
 a640c23a62f3a-ac81a8790cdmr330144266b.26.1744130952294; 
 Tue, 08 Apr 2025 09:49:12 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7c0184865sm919818266b.124.2025.04.08.09.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 09:49:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D03DB5F8D1;
 Tue,  8 Apr 2025 17:49:10 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Subject: Re: [PATCH] scripts/checkpatch: Fix typo in SPDX-License-Identifier
 keyword
In-Reply-To: <20250408162702.2350565-1-zhao1.liu@intel.com> (Zhao Liu's
 message of "Wed, 9 Apr 2025 00:27:02 +0800")
References: <20250408162702.2350565-1-zhao1.liu@intel.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 08 Apr 2025 17:49:10 +0100
Message-ID: <87bjt6ha49.fsf@draig.linaro.org>
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

Zhao Liu <zhao1.liu@intel.com> writes:

> Fix the typo in the error message to help `grep` the example:
>
> ERROR: New file '***' requires 'SPDX-License-Identifer'
>
> Fixes: fa4d79c64dae ("scripts: mandate that new files have SPDX-License-I=
dentifier")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

