Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CACCD98F8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 13:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waD18-0000EZ-DA; Thu, 18 Jun 2026 09:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waD17-0000EQ-5p
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:42:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waD15-00055Z-Lx
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:42:48 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so8698965e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 06:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781790165; x=1782394965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipaoK+80NZA2as0+RiMXUPk9Hbo+8sKF0qujMT+JfMo=;
 b=iTQV0Rbf7Wp7LbdCFWCRjfQVv041oLjRQD0TdIleTgckFEmIsGSyK0DHxyQtJAs80y
 1qBPFrO+i/AzvzsfTpNE8Z4FdwgJtxTjVCrJ7ZRij0kCX+muBZXCHH5gzrI0SP4bDWBS
 WA3I2FHpChvfJDTlqehxGhzVD/QYI5DvMbP15zOCpJP8l9D0PfzxR08ob58SThIn1jFj
 HrxWEq+n9mUBY2ZwLEiVnc1Kmro0AxF+3YCUSXtCcm5UVvS9MVtG5u6Ov7XJaHWrM4Lp
 AG6Qi71qOxFcoh/lzGiCETxGuI5lte2EcyM9hdey+Ih4DxOrGr5U9WMnaMLldzLJmW8/
 u6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781790165; x=1782394965;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ipaoK+80NZA2as0+RiMXUPk9Hbo+8sKF0qujMT+JfMo=;
 b=J6jGuZD52wqUTdcD5h7CUDnl/R87mpXxTXbGiH4+o1ud54e1TOwM0G8N0ENqcGb3my
 3CTCP5KGmD3mpmVwnXywPqiGJ5H5ma4nOlhvyoVoLNMvozs4Fp6opg7bllyZ0F3BnpKd
 aJvYqlI0//Z2rJlmJWdyVpOZ8NLF8tzK2bar2mb+/ZsFVvtB9v+IL0f5zolfot2rF5w+
 Z1/1NKS4QHAzZrsLTnVLEHDuNQGoSd7Nm4RhVYyCO9hPwy9f6IRttQNuNp9nMoqmciYP
 jYUIZuwmy0HiFvdJ/2SMja8q8dVdGwjMwSgEGjrK7eEYg/BKdKwRQfObk9aQtxbN2Q1H
 ID0g==
X-Gm-Message-State: AOJu0YxGh9ha6s81ljPbFrnefVuhMRt2ePtt7xV32cZ/yEnH9iUv/Mws
 q2HpNiKLU8Q9cg/lJVvFcVH0tZsrJm7DPgvEohZJ6Qa6sf8Fpcdv1CK4hEEOLDricvQCsreWEGP
 Rgh2O
X-Gm-Gg: AfdE7cn1Kd7H36lYoFBUwWxMnZaOZcX7oRs/2lDMfGwpc9XWXv56ApLz01CtGt4E3Gx
 iY3gNnaG8exfNzAU20fS7KlQbqw17Z4l6iDngct/mz2HmIjgipwfRRmCvkrsHHukk5vX9ixZ3fB
 IfydznbpLgQfed+7yIJPxS6HHN0afvrHlm1/d/E3u4xA6cdJ0gsL7X6u8qA+xKRq+4g4/paBVHP
 TSF0/3gtNnbKy6fyWLEVOzYmAezHhDCV+Yt6+ta24DpaM6qG7qSLx4jgtRZxlMU5u9mLTiUfTex
 azvAwlosJ3j/r2t8p97SlfKbcSuyMkYK5K49XIpduJzDml27k0cAlGsXkIr+4tL8P9WTDI5rW71
 DR5qgzkdfNLzF0CWKavTiMCSEeZaudUlvyM77L7WeDq4m1EHwirrLAMdHjV17dUcOLkiGPtNvRE
 zMnoQ0nLSPfCKKc/MCxucbt0k=
X-Received: by 2002:a05:600d:8496:20b0:490:e913:656a with SMTP id
 5b1f17b1804b1-492333d8ae7mr110605325e9.27.1781790165004; 
 Thu, 18 Jun 2026 06:42:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4ff67sm258497935e9.6.2026.06.18.06.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 06:42:44 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8DA6B5F905;
 Thu, 18 Jun 2026 14:42:43 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Thomas Huth
 <thuth@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Mauro Matteo
 Cascella <mcascell@redhat.com>
Subject: Re: [qemu-web PATCH v2 3/3] contribute: switch security process to
 gitlab confidential issues
In-Reply-To: <20260618132058.1044341-4-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 18 Jun 2026 14:20:58
 +0100")
References: <20260618132058.1044341-1-berrange@redhat.com>
 <20260618132058.1044341-4-berrange@redhat.com>
User-Agent: mu4e 1.14.2-pre1; emacs 30.1
Date: Thu, 18 Jun 2026 14:42:43 +0100
Message-ID: <87qzm4ezho.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

> It is no longer viable to handle the incredible volumes of
> AI assisted security disclosures via email, nor are extended
> embargos practical or useful.
>
> Remove all information about the current security process and
> instruct reporters to use 'confidential' issues. In contrast
> to the old highly restrictive "need to know" approach, the
> new approach makes all security issues visible to all QEMU
> maintainers immediately.
>
> The focus is on making issues public as soon as possible with
> a viable patch. Co-ordinated disclosure will no longer be
> attempted and nor will requests to embargoes be accepted.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

