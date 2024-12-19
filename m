Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ACEE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 19:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOMUl-0005p6-DL; Thu, 19 Dec 2024 14:47:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOMUj-0005oy-KP
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 14:47:37 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOMUh-0004TD-UI
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 14:47:37 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-216401de828so11422735ad.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 11:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734637654; x=1735242454; darn=nongnu.org;
 h=content-transfer-encoding:subject:to:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EV/HxzU+uFv/fSgf8FetipjUF00vDRebzRFtTkrXFms=;
 b=RdNKAQtdi1wsIyUwvOijTk7GxAEalWZAPrAXl3VeIs9TIi4i1aOBmTznIsQ3QK5RgA
 r8TM+XJRfbUPFHzIYzKCKvajaAj9ZSqrNp2HltF7BWY3iStPj1mNP3ICVpX/1wwpRg1j
 AS4WLpMvNyLTrjlkcuV9SebOnl0x+HuWqDYkQHwRDROm3ezhk+BhjNbpDRcd6dcDCEgf
 v4p9lC1OfpqeSZo1Suc1aHsLibLBipIgK4XTtE14R9yxo0zR9ETzWWKq8OS2mNi2UfZq
 RVxNXdOu11iswhmBjUp40FIGaG6kgIHQeJU92GPrZl/jgf7v1h0VoHf1noiNHPoKWrSk
 rMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734637654; x=1735242454;
 h=content-transfer-encoding:subject:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EV/HxzU+uFv/fSgf8FetipjUF00vDRebzRFtTkrXFms=;
 b=fjIhcQx5smgfOPYO0Fil130MMpj/CFVqbBmiQfqpMNqIlbVFaNDiPG7LUrMtCUhvcS
 JD4/6zH8p1yDma2u+/qR1M+n/uOVD7dFB5gJtzDcbKcDOTclXBfwasgz+/Bv7SBGez8f
 HWKqq0Tlp/3IdTCjTNDBn0vGyECUHDj0FXSZRP5tmA+mG4ZqXJsj+XHjRoSZjNB2oDSV
 Hts9s7u6UMCo19YLh7GrwoA1Q3pHdluVUwPTnK3jh+VE88XM2ZCnJGeVL1NzpJIsU5WN
 /NMx5dqKfVCZDkCfXW2LKcZvXJeFGEB/orCgUTdqdXmpo8aPefM1mSeXOyRBqGrCQkYC
 4ScA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVL9W2N1h9F+GoTuavuZrWR2CGTwhH/TLW+kmffDMkCI6NXEflvnXg2V02lnUTOnara0SxlpnDSNsD@nongnu.org
X-Gm-Message-State: AOJu0Yyu6izgd4LKPiPnSCXDQVW5KGiklSLHJFDxO/rXnNegFYluu8+j
 ahyRuTUtmQcwNF/apCTK8c/kWWvHEJhdDpnEFoSEVjpll2EDb+BpXl8IEOMycEE=
X-Gm-Gg: ASbGnct7+VRv+TcStN0hQjtTiukGGmYMMwRW207TTNEOW+2oIOg0JTVFfnk0ZT4O/fj
 HopoWcKu3bAFrJ7XjbBq1FpsfBGrQ87LbYoFOd0y3nPdU0MQ2xRxSirNIKDxkxbtbqiTnd0GPsO
 JO4SxE+G7ubl53dQwRfdRm+JXdHHm5oUlQ+1jUn+WV/e9rAOStRvU099dfNCdsn5mXfIdZWOobo
 SxoctMHKSSGlkKPH/P7CSqHnWfTxRSbgWPN3lljgkzS3WVKzAGiA8/4W179mWXImqnzGA==
X-Google-Smtp-Source: AGHT+IGZXmGC8wCsvXOMjnRWMJQJrnIojxs2290djBQbIgAKnqX3ksRPw/kuHXxkyMb8k5Gw2Y756w==
X-Received: by 2002:a17:902:f546:b0:216:84e9:d334 with SMTP id
 d9443c01a7336-219d96b3b4amr70488655ad.33.1734637653901; 
 Thu, 19 Dec 2024 11:47:33 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dca025d1sm16121135ad.254.2024.12.19.11.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 11:47:33 -0800 (PST)
Message-ID: <5f571195-39b9-45e5-ba03-fd835afb5012@linaro.org>
Date: Thu, 19 Dec 2024 11:47:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Test assets not available anymore for
 tests/functional/test_rx_gdbsim.py
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

Hi all,

assets for tests/functional/test_rx_gdbsim.py are not available anymore.

It seems that the directory "https://acc.dl.osdn.jp/users" vanished from 
the web, and it's not a temporary issue.
If someone still has those assets on their local cache, maybe it's a 
good time to upload them somewhere else, and update the test.

Thanks,
Pierrick

