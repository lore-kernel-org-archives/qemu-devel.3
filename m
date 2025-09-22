Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4650CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 12:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0g2s-0001Xj-V6; Mon, 22 Sep 2025 08:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0g2p-0001X9-Nl
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:53:27 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0g2k-000085-NN
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:53:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so2030223f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 05:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758545576; x=1759150376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hc6D+2jvhkFkj/ob+cLmQkmvhhav557nsMeLMgHkbpQ=;
 b=FV29EHV3SQHDt+L6ETuYiCGpXd/GvqqR/2GFgI6OqzaPGewkeID3ug2ZG8dHI2Bpeh
 p7SSLMSwWYciawLWKKmgyp1uW6O5gunaHYf3+WdE6AGtZM62jJbaHChTAd+vrJj4PzC9
 +asNBFmObsVvoggvKg3RqfwEsVBdG+fhCNwdP+78yzf7I7fKqbPWZeG9BdZPKT4upgQ2
 AT56tB0qykzoo4xllzUxja2Y62ZoNeXZkg2s2tTmwZfkc9s3slPa/CnEtuzmVyzsvfGW
 AOHMR4ZP3cRS0RRzlCzVIl2M0Yfc71QnnJ3hsEUqbUJJhu7rWSjTX9UjnpSmIlwAMnkw
 JaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758545576; x=1759150376;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hc6D+2jvhkFkj/ob+cLmQkmvhhav557nsMeLMgHkbpQ=;
 b=vztQsssws8QFt6LML4ArurwX8R6NvOeswv5VtGFl5uH9EmDAUT8RDl6f0MTqWfqH3F
 cMRT8B0ENUlcDJVHDdGb+UPgIZHpvEzXMoIgbCHUrCDqTAK5/1Qakkk95Kh1cU4Tz8YG
 biDWEqKH1tyyHXtFyjq6Z+w2hmhpxIgBnWp3qRDx0nbwSAJCtGmP7cWdd2r9QN23XNH+
 H0cKkZDttTY0Z86zFvymHRVdm8x/uVKSwAiL20H2xip+KIHKx89ae3IPOn6rO6TcEiCy
 rJexp5VFTA3yZMkgsk7rNFO6weNgWvV0b60Z+22Qs7V0EuI2/OqtIHnJB/d/KdWDTpc2
 OGpA==
X-Gm-Message-State: AOJu0YwT+NbxNiNLO6iEQ+tv+HOpJGa0BuN5wy8qCAMbams9Vka7BNSN
 ln8+STDFzDJtF4ANr8gOO04cxDcrU+Lr2m5sjS6yxPhNWJwbmxjiirnH6e+hfCyUmwc=
X-Gm-Gg: ASbGncucFwBzd7WcqoBJnkKUY9aKsL4Ojtr6EAcDZ5s0Tc8SLetKKel/8TA9AAwLEWz
 JTAvhITCrgu6+aP0JtyQ4+ZN3BCCbnp3tUiuOFgfHygwIsQg8DL10j80g9xphSveBeffQ22mHGL
 EiMqgMEh4PLItNVZKl+hg3ho+N+i7v4DjeTlu9gpkV+Vu3WiFXnBL43D4PLpgdF5JJeMMR+UGvN
 WiBNf+3oT2hwnzifCqsrQTGu045vv+mnmUkBXGajqzCdhJNJKK19/T7IewDuvwOMYWUrcoZonob
 QkmfMTrbTGEhvrVgiuKU+qC9KCCfFrjEXp5WS/Y/HFioVCqCYA9PxKcUeZ0llvKmWxdWN5t5zOw
 gm7Zf5GDBir9sZyUbGyQ7GJw=
X-Google-Smtp-Source: AGHT+IHtoru39zhHo1j7shfr5/Uxjn4pRqw8xGYPHvaoNEY+AoSX8jWQ87iFobOJtz02onr3fyh1ZA==
X-Received: by 2002:a05:6000:2285:b0:3dd:8b62:5fe7 with SMTP id
 ffacd0b85a97d-3ee8567571cmr9320586f8f.49.1758545575954; 
 Mon, 22 Sep 2025 05:52:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3fd84338ca2sm4853685f8f.42.2025.09.22.05.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 05:52:55 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9576E5F7C4;
 Mon, 22 Sep 2025 13:52:54 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC PATCH 1/4] docs/code-provenance: clarify scope very early
In-Reply-To: <20250922113219.32122-2-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 22 Sep 2025 13:32:16 +0200")
References: <20250922113219.32122-1-pbonzini@redhat.com>
 <20250922113219.32122-2-pbonzini@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 22 Sep 2025 13:52:54 +0100
Message-ID: <87a52modi1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

> The AI policy in QEMU is not about content generators, it is about
> generated content.  Other uses are explicitly not covered.  Rename the
> policy and mention its scope only as a matter of convenience to the
> reader, in the TL;DR section.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

