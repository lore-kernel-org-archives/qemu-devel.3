Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3ACC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 21:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYtrd-0006hY-U7; Fri, 17 Jan 2025 16:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYtrc-0006hN-FV
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 16:26:48 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYtra-0001HM-RT
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 16:26:48 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d3e9a88793so4238028a12.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 13:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737149205; x=1737754005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wjumgF6EaKTNnP2Dl1TPlNPg+2Xnma+K5d1ucj8pPaA=;
 b=XTlhrqkdaCVHw1+cnt449RRAhhbnXtYqSiNbzPmP9j5Np6CVFaUFRseDjB/Re1nDHM
 2ZbSVqwnNHMo5p6v6QM2IIFKYY1qeoBsGXZnN97KwpYTOx+CzbyeXNogsVlxZQtcRmqa
 IOY15vwHC2Xv6jIDS4yoKntYWHVRJts0tViTaQlsiO+RwVUXwLXAVKEe2asAlNRlOSV5
 8WrfZStv/QBDz2tBsENAAmcT0eecY3L7r0dei0//ch+bDDUYlrQXgFJtgWjtADxC/bOR
 gwWLZV1ALaX/65Z3bB0A2iytc4in3w0Wxs09PtcYmUe9FSMntBXBX2EmpzCkIf8lMOL1
 tb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737149205; x=1737754005;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wjumgF6EaKTNnP2Dl1TPlNPg+2Xnma+K5d1ucj8pPaA=;
 b=YdpW3unIfDKMGGAuTxYHj7kvexwfmYZ4rL++PtMO1R4z51nhZpFWiqJ5NV0ke44uRa
 29plG0KvYn2hMXFDO/FSjl7nSMrMgvBF7h0JVry1xjHXKqRIiptKsqPZjlMnreu1Hd7S
 ECgtV9lMpKy/w+ihIokq4h3lZBEBSD5lwnVwm5QGcoptbeGPVSccPux3IJsZhnkxvpwD
 7mAgmIMRf6Jc9mPH44WCkrMdwYVp42ypKP6UIiz/paYiBPyN75QcesWfpXBO7laCWvW/
 a/+JiiCP1w+8azhbLahgUJjAQx/M+O7akHharuIP8Ae83CM0aUVO0SJZimHhW95a7Wi7
 eGmA==
X-Gm-Message-State: AOJu0YxkZSZM8vD5Bv22MYJaccIdb5eUj4P639GZ+e429im+Q8gK2/Ov
 dp/yQUoSjHuN/jT7oAavZHMxJMzGkfGIFaJZK/iWcG723kE8jMBCuDWC+6HWxitU5X+/O8dZGSK
 iZIY=
X-Gm-Gg: ASbGncvjmh0//6GUTidAxPl4R2Jj/UOhMkSHGRLAhYM7udyUsAacunG97KzboP5ryWk
 kDNz/EygRHKLUsvR3CSuPZJr5dqaEwqXWXxDC0g9k9yOc3FuxPskkf/uSe+Ld6gMLXXTkAbw2uZ
 jMtzQ7j316NJXJDg/3zJunMAAhUgW5E2RZaiIqWx672Ifs7dn922uEJiaKQ2cXwTd8Jbms12WVQ
 uDfaPpgdtEOkUVtQGhkG3hmWQqkkctzJCtVNPfhYS/EkJBAlTsO/H8=
X-Google-Smtp-Source: AGHT+IHky/QNgtBnim2GTAY+HEfI1QV4FZMDtqp7IwmXzZdUmlhUpxzGNFw9OWAcTIvuMlanK8WgNA==
X-Received: by 2002:a17:907:989:b0:aa6:a844:8791 with SMTP id
 a640c23a62f3a-ab38b378d8fmr450432266b.45.1737149205011; 
 Fri, 17 Jan 2025 13:26:45 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f860e1sm231883066b.147.2025.01.17.13.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 13:26:43 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 037186083E;
 Fri, 17 Jan 2025 21:26:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH v2 01/81] tcg: Move call abi parameters from
 tcg-target.h to tcg-target.c.inc
In-Reply-To: <20250107080112.1175095-2-richard.henderson@linaro.org> (Richard
 Henderson's message of "Mon, 6 Jan 2025 23:59:52 -0800")
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-2-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 17 Jan 2025 21:26:41 +0000
Message-ID: <87jzatm8ry.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> These defines are not required outside of tcg/tcg.c,
> which includes tcg-target.c.inc before use.
> Reduces the exported symbol set of tcg-target.h.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

