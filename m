Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F46C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 11:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI53N-0005ri-E0; Fri, 14 Jun 2024 07:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sI53L-0005q6-Jk
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 07:25:07 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sI53J-0003Hq-Tl
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 07:25:07 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a62ef52e837so276543766b.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 04:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718364304; x=1718969104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=79IKEzHCVQTpvU9IKk9aIRX16VqR5YZo8M1iOMcFzG8=;
 b=o3sjxyGJ9tkzDcH8j8Jq79tUHvV/0WxMePaxJvdZqeU6766R2vBv3GdOJvK6zAu/oU
 +fYMmDACX8NCDTp7s2xpTdXOByrGDg61vkfvnLLVJmpX9Sp7JLzVxqWqACSrb//Ia7hO
 98s3aBtem/OXJLJulLWLxS2EzecWnShtqFK5FOr8wdpBNxYRRdU5F56hOXk9PbaBfpQW
 gHCpN/LhhEdo4typ8dNsRunP+4D3HPRqDaCiIFoHv4YcqyTUA7Ga6zfvPicdpJClicZ1
 thn8Roz9iLwCqVdAt43C9XTJ27m+34AYD7GVJBOd/g6p8tcpTjEaBvIvZSCi28ZUXY0E
 xGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718364304; x=1718969104;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79IKEzHCVQTpvU9IKk9aIRX16VqR5YZo8M1iOMcFzG8=;
 b=KvpygLnkl+qRBJwf6uZOjH24CHHj3WMGpB06EcEyUlgr+4cRId8wRVKQ3+8qAcT4ru
 QiWjzP9MbL6ZLNjlyDn1acJ0Ok0pX5mM902QgLHGvzJzD/sYDhSecrftkOY0bG+Ff/bM
 SvrKMGvw6gBRtotNKbsTkdUjkM74UrtlTPIpdaiqLDodd2rQuJ85LLcswWMd4AaRUAjx
 /aW/w3mGZrPBnxRZ4/KaTqV/BCgRy9HfijY1pVI/oOsMUiFr1+6EUoNNhvewt0e8086C
 Zn2EpVsHoNyu/1B4ZiXIcIIxawcvEUOGwors3qd7ZlDLYtvzPv+rBVdDYGJdDES/0C89
 lUNQ==
X-Gm-Message-State: AOJu0YzD5bxh2NYss55NTUkDFDlptpf01L2A/g0iCYHc7e6Swz0lUdQM
 80oqLIMzpgr68S7UHix4i4WTP3Jye4C34MiLAoDfc0BsV7EoaKiIBEWLWGEfLbW/rifMGPpB5Vl
 a
X-Google-Smtp-Source: AGHT+IH5gYYI/ThY5Yp+mGY7p91GJ1yiDS3GcAY75F7d+3NGBFJqV4EAKmvjoHlaDAvqBmHQAMej5g==
X-Received: by 2002:a17:906:3e13:b0:a6f:da1:d077 with SMTP id
 a640c23a62f3a-a6f60d296f3mr161225566b.25.1718364304290; 
 Fri, 14 Jun 2024 04:25:04 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56dd135esm175579166b.96.2024.06.14.04.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 04:25:04 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 473BE5F794;
 Fri, 14 Jun 2024 12:25:03 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PATCH v2 2/9] gdbstub: Move GdbCmdParseEntry into a new header
 file
In-Reply-To: <20240613172103.2987519-3-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Thu, 13 Jun 2024 17:20:56 +0000")
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-3-gustavo.romero@linaro.org>
Date: Fri, 14 Jun 2024 12:25:03 +0100
Message-ID: <875xubvka8.fsf@draig.linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Move GdbCmdParseEntry and its associated types into a separate header
> file to allow the use of GdbCmdParseEntry and other gdbstub command
> functions outside of gdbstub.c.
>
> Since GdbCmdParseEntry and get_param are now public, kdoc
> GdbCmdParseEntry and rename get_param to gdb_get_cmd_param.
>
> This commit also makes gdb_put_packet public since is used in gdbstub
> command handling.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

