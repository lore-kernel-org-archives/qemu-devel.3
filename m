Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF1BCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 08:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62po-0005zp-HH; Tue, 07 Oct 2025 04:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v62pk-0005zd-HY
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:14:08 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v62pi-0001g4-Ea
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:14:08 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so52414825e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 01:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759824842; x=1760429642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wthlHNr5sDQ8ywdx/OoOiKMZOG8vHgh1sKJa1gK1krI=;
 b=BsK9gV8QNYQOWio3Yr0GIOZaELPSxegakBcbV1Z/1HQNrt6eOanTnEKE7GYdkx8GSz
 beq1qisBdpoRqmJhFlkbK3Xy6RkZ1qSWoewVLTyDLCMdsgkMTvfQcHdTpQOl4zg3nhG4
 CXzkDZKGFRACGqiIrGKYlSYB9zqYQSYNc+46IAGBfgJrZ4Gif6qqCbMJbeKGc2Kzn+pf
 QhPmAL6OVoq2FxgZ2zh/SN5tY58XswEgqozNiFFFx6qPA3ecFh4Kn+akDtzHhurzQzg2
 9Q+75VQL+RKRJLmZT3SKanpexAGYc5aQTUuOUgsZkm9F6yASektKDMdGLEMv5GYucgs4
 bZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759824842; x=1760429642;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wthlHNr5sDQ8ywdx/OoOiKMZOG8vHgh1sKJa1gK1krI=;
 b=nc9GhBfuFp1UcF59NIm/dKnW3vsYGMaFgKmBzsu6zA3avXSAh2j8W45PPza2y0KCTw
 t4bIR7+t6uiPDRmxryi32+WB1UwTtMHIchT7g3JVIsZOwalniI045BXhKF+e2IAi25fO
 /MCiBNw5qaut/MeFgh1CUcesDVxnT7jTUkdzsckxtXSQiI1FXxVNC40jrGp7lA78QLzd
 S8lRudWLOLpwUct7Us73UUHO/mV3izb7jtC5+TgYwgT8BUw+gqz0mtrzIuoSWdluFzsz
 EyDthiuFCYQMVdlAtXbGFJdYw0SSltBSAjNPBxjpn9jhE5hzPj9vkGzFNiUvP9di5Hyo
 gl8w==
X-Gm-Message-State: AOJu0YxbleUmmsT3c9S3Xk/mkBhlwHzhImAwDn/kYe/GFprF8O/TopfQ
 DUiX3Ll19dlo4MdB0xGWq25CQRj1XfvdgpmSkpMrLE24DmIkBzrCKuxqrS8wO+O3SLo=
X-Gm-Gg: ASbGncvDclqEz+LOQ6FzJggA7Cvr1iMyDxpgR/oLN2Qd7YqATlpdr5P8z2yY9/c19B+
 v9iocRsDGpi9uVDaP6FV5hmy19audkfwuYf6BLXAWViDALUCCUg1AizFQw71Anw4/uL8Qx7eqt2
 5H197KSaUjpA4jjq6Ck9oLaK2Ldk7QtZlF+0bDAs/aDAsXFw5L9NFlSMFNu9vJGnjsEuEsRCNsG
 c1LUqaJURJ2aPOvjoSAnGZLP+zS8jAviKMOGH1BxpMTy7o4+Hdw/6KpwofsRRwxXa6plEw+hh6G
 xZNzCndipEZ3MIZGsVAUY75590gIkU4PlmWfSxro4DOzLIjRSX6CTNH7jWFEuFTs5GJKLvTIRyk
 c6/tu7aUWybQ3341BjcOyMpID/xTkyFMgQqn9wrB1Rs3NoyrtCW0=
X-Google-Smtp-Source: AGHT+IFRDkuYoLjH1zaiFJj72L04vfJU9Ip8svCZbP4GAQhJt5WOLnpldykNST3AJgiR0DD4fVmMiA==
X-Received: by 2002:a05:600d:41e2:b0:459:d3ce:2cbd with SMTP id
 5b1f17b1804b1-46e7110aec4mr96944405e9.13.1759824842523; 
 Tue, 07 Oct 2025 01:14:02 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6c54sm24682601f8f.11.2025.10.07.01.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 01:14:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CEBC65F7EF;
 Tue, 07 Oct 2025 09:14:00 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Vladimir Lukianov <1844144@gmail.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] record/replay: fix race condition on
 test_aarch64_reverse_debug
In-Reply-To: <20250603125459.17688-1-1844144@gmail.com> (Vladimir Lukianov's
 message of "Tue, 3 Jun 2025 14:54:59 +0200")
References: <20250603125459.17688-1-1844144@gmail.com>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Tue, 07 Oct 2025 09:14:00 +0100
Message-ID: <87bjmjyvqv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Vladimir Lukianov <1844144@gmail.com> writes:

> Ensures EVENT_INSTRUCTION written to replay.bin before EVENT_SHUTDOWN_HOS=
T_QMP
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2921
> Signed-off-by: Vladimir Lukianov <1844144@gmail.com>

Queued to pr/031025-10.2-maintainer-1, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

