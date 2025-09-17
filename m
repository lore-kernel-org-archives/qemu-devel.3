Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CECCAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 16:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyvGk-00022s-0e; Wed, 17 Sep 2025 12:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uyvGC-0001lW-8U
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:44:08 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uyvGA-0006pu-9b
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:44:00 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ea7af25f8aso1512135f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 09:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758127436; x=1758732236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/Z24iy612p2TxL1dfOWvwtylIWEih8ax7WqaQLW/o0=;
 b=jeGJJlnT8U6yFunuw90TLgu4CiXCbFE42dP9xv3oJ7iYOx7Mco2+BFoLvdFnLcqJ2+
 8G/AyaKggGsrKs9fvU76qT5EBiB3T5WICR8EEeVS39L8CZJLmgf+fKkMTzQniBAAI1Q4
 eVxk6b/XzmQkyOidmkM+QJSeEKq1gJ007HxNK8sQ5gcaIzv/+Ni0T3pSWBvHtPBR/7E6
 XlGlciuXyPzvO3NjAnywWl8hRepqAT0bzoNkGn039wyousLd5M7g4drSrdxaLpqq6jne
 zDTfNDUPTCH46bE1FJ4iLVlWulbovnaDCdrfypCseGAwct++qksR0Cuktj4qTSZQ/gUe
 7iGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758127436; x=1758732236;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y/Z24iy612p2TxL1dfOWvwtylIWEih8ax7WqaQLW/o0=;
 b=qc+frDGO+oEvtphKcKmSk3Nv6rDVXmaTgKs7h0oUtJtPVO0zT9aFrhbgHk/7jMGPgk
 U3qVY4cQtkPeyqGCfLKlNlnr2PwLzEyOo4tglmz0zmS5ab5DkbLT5xOzv1fo85h80MJR
 M1jg6CBkeph2Btg/PdQjOx2FKfNPar+RT/1qpoq+nrxxiMKlWzmXvgUpvg2yIdV34oES
 I3ScGPE0erVeXvlMV6Qyece/v+n3+YNiNagiK6imcqCnO/6TB+Y5HqLcAtm+M66bzfzo
 3D+2ihbucfUbcnr/5ytgkf12GUhI6QIwoMXsn/ISDbX7gbSI7SxkI1VcZLKTXdFwFknI
 UUsg==
X-Gm-Message-State: AOJu0YyPxMJIYcP08f82/Zu71+2A7sAvZDsfp2SjvJ0i5mrwEvQdsHEI
 dM4poLfx60/AQJWF9i69YlIZFvi09UJNM33niA3kd16FjmMh2i5GUnaNb9CKNtDbcgM=
X-Gm-Gg: ASbGnctMfUUh1Id5xkE2uC5lxnStVVLpCJgaHs/1ugj8oyd7HHHu3H9vRs5ooYSCxSo
 IomXWmXxHfnwufTpdt60LZXgfS6kyPIypLKonniGAQUPjhAdel8sy6kz7XQLJ6gznxA5xWnDE3J
 O6D+aPlK/xfWpQR1cF4PKt2tGVjn34ttkvxNkOgj9j7Oi+rCGZOOGJevYiNRnzSfTtiTrtWm4dh
 RInELd8iiug1+S2964EBdmos76nf5glXpJshEtdwGfLFKZwgEZRXAa2uk3uCiQVvMio+1xKyJxL
 YGXH6c/n5i6ZuBzNsQhmj7vLZd47pg9ptzx2Nw3OhK2ubKFBSdp61S/yqLG9AUYRMUD9BayE05I
 66YhFAJUL0HEwHQku22b13yE=
X-Google-Smtp-Source: AGHT+IEXuKUb66uXA4fYRvQwSz8fcHeBuS0Sgkz4JkCGcPCUDoDRfpJkEPDqqN6AquL+mPJ35RIwbA==
X-Received: by 2002:a5d:584e:0:b0:3ce:db36:607f with SMTP id
 ffacd0b85a97d-3ecdfa0b79emr2155591f8f.37.1758127436364; 
 Wed, 17 Sep 2025 09:43:56 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f0d8a2bfsm3368355e9.2.2025.09.17.09.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 09:43:55 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A09625F80D;
 Wed, 17 Sep 2025 17:43:54 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com
Subject: Re: [PATCH] checkpatch: Ignore removed lines in license check
In-Reply-To: <20250916165928.10048-1-nabihestefan@google.com> (Nabih Estefan's
 message of "Tue, 16 Sep 2025 16:59:28 +0000")
References: <20250916165928.10048-1-nabihestefan@google.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 17 Sep 2025 17:43:54 +0100
Message-ID: <87seglm3lh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Nabih Estefan <nabihestefan@google.com> writes:

> When running the license check, if we are updating a license it is
> possible for the checkpatch script to test against old license lines
> instead of newer ones, since the removal lines appear before the
> addition lines in a .patch file.
>
> Fix this by skipping over lines that start with "-" in the checkpatch
> script.
>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

