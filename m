Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B47C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 10:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRqkB-000515-VU; Thu, 11 Jul 2024 06:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRqk9-00050Q-DR
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:09:41 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sRqk6-0003NE-Dz
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:09:40 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-58e76294858so3225951a12.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 03:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720692576; x=1721297376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/KxKZpfk7o1EtGRRFGejU5UUGua5AZI/7hMyIKWz33Q=;
 b=FHMaLWmU6Cfhso8wKati7fXLHWhJCmUXAONcM7g8FnlhD5u40V1iIuydXquJmRZ0WR
 rNuXrAiMMvtixu8fDsAMjYSZHM+Q6ESJVo2jg26T7l9rg+YAgDYiMWo2ZWtA1Bfl6CNh
 2nc0Ofv1m6X+PtnIsWpT7ilAlKHN0zfqEbTJPOv0asF0ytL8MkJNZ1tnCCtaO6eJLJnT
 fiZftwLTdsi74YyC9VdBFc9H516MOHHyKMylx3j6/MfZRwmfrfqGFGkCMQJyua5fciYy
 C6MmxS3N6uUEpcBucmbA/D4HKQycwb+PmUEPPNr9P1IzINorjR00ZVo2NWTqfTSh2ALX
 e6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720692576; x=1721297376;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/KxKZpfk7o1EtGRRFGejU5UUGua5AZI/7hMyIKWz33Q=;
 b=hVLlHfOgk5qKfzqm9lRsxRNOk/OXWdFgnvqHwIOFplHOYbQtVdx6uDW+4wrpjeiah0
 L7QBd1hwOLGUkC0F+dkfNOI3WXTAEPgd5Q8ZqcD+CdJkFppZVAPd0WlvH/sebX30BlWv
 8afua+Gd3mdqBXThXOJu0mojExmKyOlLOd4vtwyuZvvGjvzJcvaXuugf63rrOoFPPFDJ
 EKMLDZ1AVwBSOkyWHe22XlDqw/dcehRIk79ew3nPCsS3j5To95PDO6NRCGXxmEryvj5l
 WmbRtGyBK17maECnBqmr9cBqSwCybCmjZK47VTumI5k+1/fTZOFfv68j6rDTDzcuHEXd
 7/jQ==
X-Gm-Message-State: AOJu0Ywhp6dmuL93upNgD1sSRRrM+VcC+LmW0BUkSdt7eNGCYApAwBRp
 UZWTaN3a6vbDSYqZ3oMI/N5DWgQhRa7XXt0a41UQOk0wHdtSxuCdos+ThVnruE6HxZgMjmFFD5Q
 8
X-Google-Smtp-Source: AGHT+IEYFw9lVT1TDhkoNuwuMmmKpW0aF7QYoxm+c6VHmqACJfZVYkkBECo0N7AUdUKhG7ROUaRG2A==
X-Received: by 2002:a17:906:52d9:b0:a77:e6dd:7f35 with SMTP id
 a640c23a62f3a-a799216cfe6mr83412366b.13.1720692576130; 
 Thu, 11 Jul 2024 03:09:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a85603fsm245368766b.176.2024.07.11.03.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 03:09:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D5A815F79A;
 Thu, 11 Jul 2024 11:09:34 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: qemu-devel@nongnu.org,  anthony@xenproject.org,  paul@xen.org,
 edgar.iglesias@gmail.com,  peter.maydell@linaro.org,
 richard.henderson@linaro.org,  stefanha@redhat.com
Subject: Re: [PATCH] MAINTAINERS: add Edgar as Xen maintainer
In-Reply-To: <alpine.DEB.2.22.394.2407101322290.3635@ubuntu-linux-20-04-desktop>
 (Stefano Stabellini's message of "Wed, 10 Jul 2024 13:28:52 -0700
 (PDT)")
References: <alpine.DEB.2.22.394.2407101322290.3635@ubuntu-linux-20-04-desktop>
Date: Thu, 11 Jul 2024 11:09:34 +0100
Message-ID: <87frsgqly9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

Stefano Stabellini <sstabellini@kernel.org> writes:

> Add Edgar as Xen subsystem maintainer in QEMU. Edgar has been a QEMU
> maintainer for years, and has already made key changes to one of the
> most difficult areas of the Xen subsystem (the mapcache).
>
> Edgar volunteered helping us maintain the Xen subsystem in QEMU and we
> are very happy to welcome him to the team. His knowledge and expertise
> with QEMU internals will be of great help.
>
> Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

