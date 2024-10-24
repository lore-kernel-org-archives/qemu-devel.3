Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEBFECE8E67
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 12:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3wsa-0000YV-K5; Thu, 24 Oct 2024 08:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3wsZ-0000Y0-CW
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:23:51 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3wsX-00072k-O3
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:23:51 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-539f1292a9bso1046572e87.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729772626; x=1730377426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jCvkKAKUp1d3wjxX0hcCRbHypdfn57UWhepOQFNP38=;
 b=pN7ZhfCswHmCofABulvcWzfhPTrVOMpGMDfrxG7pbxtZCo6nEYaAeXj3kBze5qYshD
 FF3TtoM0fxXjV4PY1urFvhdH36s515s1fJl5JLwsWHOuU1/kqgTvZKttll+a8g+l/xQq
 m/Q7PN++t1icCnRF5heFu2xp7OShDSj3sP/gQhMNPTlnssKul8tt7d3/61ZKLh9vZVPx
 j+956i9HfVMN2qUTPOlb1bBiqxXBDiQPkQgHGzcjfPNKKs9rr4HG6fI3LxZIOY+d9fIO
 gadmqosW66V39bjNdnsm7JBtupscMRIqOwl/w8f6ttXli2lZbcpiaPBAhhY6SzB3r91f
 VM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729772626; x=1730377426;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5jCvkKAKUp1d3wjxX0hcCRbHypdfn57UWhepOQFNP38=;
 b=kAGDw2X8S3pAGO9WhftNBAt7teAOrNDLzNktHzNhtRwY7TRMWH346fut3KAnb4sx+r
 2Tb2mkdGsnJtp/Ns7DCz6/XREn0nYXYW3C2lMsbOFzTOfgJBmcEm3XyB6zs3D0T9x6Aw
 2Wb3FGosXJttDKwdHQogijykRIAqEUqHKXU6Qjn/lbwMS5StVCOEk/dp0l6XCVqSeWUs
 9da4sP0AHedIubKSXETZOfJBlA/tW6fu1I3df3l9ifSicwhjFYbrlmZmpFA1Yq44mxTI
 DxEmmlT+a3aTyeWbzDilY7Sol1z7uN9mUqXHclIN/pjGoKP1BnkLo6QSnJ503huzsSz/
 /BcA==
X-Gm-Message-State: AOJu0Yz+kKHyQDHNcEie42q7VHwrK6ic+wLeoXsj+w5X3qGByvepclT+
 nNlQqaw6gKKnDovksBpf28mWYYWgVKJZ/sX7OgL25o8+Wn8sKYUmu28zqYBLdfPA5DC2Njx7MEa
 b
X-Google-Smtp-Source: AGHT+IGEwY962nu7FMG7sHVpaRg4bD6No5VB9o5AC17qbFghcHtn9mR8fqhv0NY4PT7/tFNgCNhiWA==
X-Received: by 2002:a05:6512:12c5:b0:533:44e7:1b2a with SMTP id
 2adb3069b0e04-53b23e684d2mr1136746e87.40.1729772626342; 
 Thu, 24 Oct 2024 05:23:46 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a654f3sm5671750a12.32.2024.10.24.05.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 05:23:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D17B05F786;
 Thu, 24 Oct 2024 13:23:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH] stubs: avoid duplicate symbols in libqemuutil.a
In-Reply-To: <20241021163449.136804-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 21 Oct 2024 18:34:49 +0200")
References: <20241021163449.136804-1-pbonzini@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Thu, 24 Oct 2024 13:23:44 +0100
Message-ID: <871q05k7u7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12f.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> qapi_event_send_device_deleted is always included (together with the
> rest of QAPI) in libqemuutil.a if either system-mode emulation or tools
> are being built, and in that case the stub causes a duplicate symbol
> to appear in libqemuutil.a.
>
> Add the symbol only if events are not being requested.
>
> Supersedes: <20241018143334.949045-1-pbonzini@redhat.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

(with all the other binggen/rustc fixes in my tree)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

