Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA49DC54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 19:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riJCE-0006vG-T8; Thu, 07 Mar 2024 14:14:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riJCB-0006ur-2Q
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 14:14:23 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riJC9-0004cV-JQ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 14:14:22 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412fc5f5152so9576705e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 11:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709838859; x=1710443659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sylq+yNNqGwADLcXVsURvmSGes8QdqYhE4QjNOBiEgs=;
 b=JT6Tma9bwJzDC0/FHmxyFgoEAnTiiK+LAn3RtosGuYMcrIH0eaGij2lDisQ5VFrrCP
 cvvySXxWQeceLLGPcDZ3SY7GpHedNsxknW00dBno/9qK44UjIohhN4FG6kPIDBWGuHeG
 mPLaff8eyxKCJ14WGYIgxAK9MQrHQVHbfwdKG3B4r5YiLTFw4TPKrHKvTRBltt6CUva4
 B14GhLN7BGPSy+RcOkTBeeK2X1SwIrzc9NNr9DR5W3AfFbc3/2dVOTrNVJIGphUkQFq/
 TmP4+G3hPEk5v4eE/L3gdohfHvjym8Age2VUd+QW0GUE8KxyjHWx3WW9jAb1PUcoBD0Q
 9p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709838859; x=1710443659;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sylq+yNNqGwADLcXVsURvmSGes8QdqYhE4QjNOBiEgs=;
 b=tUY/fAHy/elne+vwvIS9qsN6jUVmYyWemCD6JDb/5i9QUk6roymxDcgwxKWJxSWvOb
 o5LZ6T4pPEH8fuDT9lEw1GE+bYUuCzAcyfXzNioCdSKsUK01AL/T29M0B/1WPKE9cwqE
 I5enha0qnS11zySlaXdtOr6p7855IdhoZyF1Zn6jOf8a6xBA4PueD5sP5+GPXuZa9mFM
 5Sz95rAyHdC7LjN9QrwuDBIvdjjZUIAlvOR0P2eGoTVtWxNue+geYjd4JEkAOSHO9P6V
 62jPTzXdOqpn+TkeYrjeqgfE1QYahd6a6SHIrmbNOrsJN7yGEoQ69BX4RJS4vBloKhns
 kZPA==
X-Gm-Message-State: AOJu0YyWMIPE5Djxbjho4gLuAoIxK3zOaxfMdC48lK5VzvEiWKp7lQjb
 j+lL1ajrsPqb1RXHF9uFqRu5TagHIAWGPtNO2G0mRDjVXJRIsnrESAzpVZMaJ58=
X-Google-Smtp-Source: AGHT+IFMY7RmRdcw+uMskLMpVPYuCTWsycH8Aq9Xfmrs1wSZ1WFGlvIEC/qw2lrsswEn9ftGFm8rqA==
X-Received: by 2002:adf:e6d0:0:b0:33e:836:ea1a with SMTP id
 y16-20020adfe6d0000000b0033e0836ea1amr11899596wrm.18.1709838858986; 
 Thu, 07 Mar 2024 11:14:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bp16-20020a5d5a90000000b0033e0567e90bsm21757432wrb.5.2024.03.07.11.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 11:14:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4CF3F5F737;
 Thu,  7 Mar 2024 19:14:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,
 peter.maydell@linaro.org,  laurent@vivier.eu,  philmd@linaro.org
Subject: Re: [PATCH v2 1/5] gdbstub: Rename back gdb_handlesig
In-Reply-To: <20240307182623.1450717-1-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Thu, 7 Mar 2024 18:26:19 +0000")
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Thu, 07 Mar 2024 19:14:18 +0000
Message-ID: <87cys5voqd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

> Rename gdb_handlesig_reason back to gdb_handlesig. There is no need to
> add a wrapper for gdb_handlesig and rename it when a new parameter is
> added.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

