Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9749C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 19:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRcDW-00065d-39; Tue, 17 Jun 2025 15:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRcDU-00065F-B9
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 15:43:32 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRcDS-0007eP-4u
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 15:43:31 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-60700a745e5so13545789a12.3
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 12:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750189408; x=1750794208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l07Bgvp45/C9vBimHSp38+wyOnfHLNXzhX6n2lQGQeQ=;
 b=FZXSSODXHDEcnV+YNJRR4JztSt7YewPwgKh9nSVCOxlqMddWDO1+yjbOTpCj509gaO
 q/Bu6MNTvLAi2vE2DsqEfCczjeqX9wwyO8SthMFG5oAcfhemFtEmb0VAAhfwResbvBsL
 5R+F211zn7MWqqHBKjkmC8xva1ZzUYMIBuDm0eWEQ0rOCRwKhyw2O0nKAGPgDdfO2GSV
 STR1XdPcWLZDyILWJc9IkUUGWh0PssvT4uhr83JFYwN+hnt4xJGqhZybNyVV1V+XkoUe
 W692wANzNmPseh5NiVTl9KPOlCFTnQPmKeA2/ko5YdEzZoMyyoR8/ixaUvX1y37oetYa
 HoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750189408; x=1750794208;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l07Bgvp45/C9vBimHSp38+wyOnfHLNXzhX6n2lQGQeQ=;
 b=mDieV7rpNvTDsK+LigNz4cDEv+uMeFxbSIfjW9H6qCsnFcV91ZGJZXsrj8TEwzSQuU
 4MjUxkmiZaEr23pDGRm7B/AKNAUhfxAgRqQrHK5poKcmorOVDVu9eUAe88J4gyAUTTvh
 zSEqyaxEKP7RWbcmhURsdrY5Kbl0iODlumkowG3B4XZPL94/7IK3SwVrsOjT79BND13V
 tLB68LQIRVUJQ8/SH+vveckNYwqHdDzndZY5i0ZgTvu9iLmY8KEplN2T3cwykzhjngfl
 eT3p6nb3GPxV+7Ylp+JeHLVbjM4BTeaQpe2L/WLY7Bv0aVqzQQb0a+mK7om1uPXp4NTx
 ElFg==
X-Gm-Message-State: AOJu0YwNJCeXZ2pg4swsK2yWVw4jKGGd34x34R/sniZbkZIcHbCzFgyB
 SzUpMRrA04JNbVGHrz+rkP1r2pOYywrBPpsNPtrUbw+u04vlstjw1jZezRvqAPfuJ0I=
X-Gm-Gg: ASbGncsiYbBYfQKzHJkA1Ckmr0cOk977gVx6pIATHro+nXGjLobB7ZZrS+L7jsK1Uy0
 5OesguJ+PnlxOzfYO1NEWu+NONwYyhyVT6yAEedQ2fLuaiQNlqcCmeBegQdJ+HX+5I+9FGe07rS
 rnNgLVX8JazJJMM+rMa1VHtExAs+vlp9vlRtQD+dtRks5AD8gATBGOpVYj8WRS3+SgB4tFktYLS
 njEEEF1PwjblCSEODeUDpxgNBragiLBEnPA5LY0Lu+IZTStt262hLu0Nqsx8Jm3IYQM+4u5SK2f
 i0X2vW9jFyHxbfaDH6Vv0YExPpkjTvwGGadUFY1rGqL3+pJ14I6WSjAR+Vo30SU=
X-Google-Smtp-Source: AGHT+IGw1OugKEyu+8muZ+GmTDJF3BPs0HheP0qWiB+tnBYopJpBzpmb2fXUUmnD9t7ozIG0ja3gkQ==
X-Received: by 2002:a05:6402:268f:b0:607:425c:3c23 with SMTP id
 4fb4d7f45d1cf-608d0834a34mr12360149a12.5.1750189408259; 
 Tue, 17 Jun 2025 12:43:28 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-608b462699dsm8529470a12.0.2025.06.17.12.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 12:43:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1331E5F845;
 Tue, 17 Jun 2025 20:43:27 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Llu=C3=ADs?= Vilanova
 <vilanova@ac.upc.edu>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Mads Ynddal <mads@ynddal.dk>,  Stefan
 Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 1/3] tracetool: removed the unused vcpu property
In-Reply-To: <20250616201222.6416-2-tanishdesai37@gmail.com> (Tanish Desai's
 message of "Mon, 16 Jun 2025 20:12:20 +0000")
References: <20250616201222.6416-1-tanishdesai37@gmail.com>
 <20250616201222.6416-2-tanishdesai37@gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 17 Jun 2025 20:43:26 +0100
Message-ID: <875xguupb5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Tanish Desai <tanishdesai37@gmail.com> writes:

> The vcpu property is no longer used in these backends. Removing it avoids
> unnecessary checks and simplifies the code generation for these trace bac=
kends.
>
> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

