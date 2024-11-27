Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA64D65521
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 04:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGA31-00020M-FS; Tue, 26 Nov 2024 23:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tGA30-00020B-3n
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 23:53:06 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tGA2y-0000qB-L6
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 23:53:05 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7251ce598adso1346576b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 20:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732683183; x=1733287983; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=javaToCsMiTsQ8pDFsFdvCh0qT7TlykghWDR4UvfU3w=;
 b=mFDw+LNQ7V0YUFsoyjQ1FiMhlM7IDOB6ET6zlsRsGxJ+5xjcuc94C2OJ5e3f7lFXL4
 MrRic3GJE32PzRTAKBuGMHooPgv8WChMibC/k648V035kSt2245Yjbzj+Ot9tGc19xaK
 aIdTQNyzoVa4BsSLikqCfdIu66ZKu+KG4/7eOZZRYURkBO1C2Xz1SH5T/hnMdoyaHf82
 2JbYqb193Jr+2AEiUZ3B5CAD1abRQNAX6oJmpxU92wq45oSxfB0ciu0NdDFraapcgpww
 nhHN+RzyafjBPecMGKnLmDOOAlnDBDEkqe6hQm1HysQqCjfeYRMKo7sWjJ/+2kAAjpjV
 D8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732683183; x=1733287983;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=javaToCsMiTsQ8pDFsFdvCh0qT7TlykghWDR4UvfU3w=;
 b=ds22Vzx2tl0weo6NI5HD28vto37H02XVR9yg9qtjso8PzyM/mxU+VWKkmJHOJA2ndt
 tieFP2c5n0FtviAsOcZlriFyrG0EOVZ6lrHXSQkWwuC98VSwgoqhMfKP1VaH+Npt1Wrp
 sLxg1fdbFYRG58h09L/PR3gPhuf+c6qIhrbHTkdSfv4Ng1l8uvFfNMFS5aKKD94GjCg6
 0Mz1iGxzNnWGxjONXrBdd7+7QDMXDsNuedKDC8cW2G/FLFcVGT8+MWx5CH91BwlBZmdm
 Ta/EjsbUcB3VlZKL5ZA6G2xFmNzzFLNsgB/8HAs3T93ixyLoz8PI8pCztZekzH/S9pCZ
 Q+sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhZUEPBoLFsaV7AhDSI4EOgUggcRzIxYLxYd8JaxNPBwC4XtBlB9kI80JwE9EOJgV/zwDnM6QhzuFM@nongnu.org
X-Gm-Message-State: AOJu0Yw00LC97JZcuV4tu/cBJGrPDOsFxFTzQ+tIa+QkcA4acEUKYiX+
 6t/i0tbbBPCpVs8RqFkJNOCxkOtNLJBCzJ6yHDYhIC0hMpyw09kD
X-Gm-Gg: ASbGncvBgFNjRPNtIng3diKUt4gTTyd56QJvp72Agi4zuzd7jMbmyn9VPbscIDn54Co
 VVx1fiIfowtlmyVmP4k2tupdbcoebwqeDAG3EidYvrDsw3jUqeJXf25u/vFty8tZ8fo8UIggbf1
 Sjgwdh0nyF1A12tfl18PJVlGALAar3FwV+tT7xqEX77VWZYQQEqXTIIYSW7hFgk6tjKCU9ywKwo
 q88XYnNrSfA0QPiirvpDKBsJ52NNmHzbe/GOwzdjQQVUQ3qjY0h6wUca2RPxOP+S1ywzgo=
X-Google-Smtp-Source: AGHT+IFx3e1wxZeVagmeCN0qUNm/UHZKSm8km4kffKxyTt0Rb6TImJ6nCZ7a1os3OXtaYs0OdBdHYg==
X-Received: by 2002:a17:902:e94c:b0:20b:8a93:eeff with SMTP id
 d9443c01a7336-21501c60a6amr24847375ad.37.1732683182935; 
 Tue, 26 Nov 2024 20:53:02 -0800 (PST)
Received: from localhost (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc2210dsm93506115ad.245.2024.11.26.20.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 20:53:02 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Nov 2024 14:52:57 +1000
Message-Id: <D5WOXB6WYUGI.5U9UWQCHRI6J@gmail.com>
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>, =?utf-8?q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/2] chardev: fixes for recent record/replay on muxed
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, "Peter Maydell"
 <peter.maydell@linaro.org>
X-Mailer: aerc 0.18.2
References: <20240828043337.14587-1-npiggin@gmail.com>
In-Reply-To: <20240828043337.14587-1-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed Aug 28, 2024 at 2:33 PM AEST, Nicholas Piggin wrote:
> Fix a couple of issues that Peter found with recent record/replay
> fix for muxed device.

Hi,

I've just realised these never got merged. Sorry for losing track of
them, I was on vacation when doing them and things got a bit neglected.
Looks like I forgot to cc you, Marc-Andre.

Thanks,
Nick

