Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53BACAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 09:01:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyo1a-0006ke-9D; Wed, 17 Sep 2025 05:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uyo1Z-0006kB-44
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 05:00:25 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uyo1X-000159-ET
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 05:00:24 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3e9a9298764so2565535f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 02:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758099620; x=1758704420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pgDhOyRLnZwAFn2B2OZc45OsJHZyQdANA0ZrYo5q5cU=;
 b=DYdHV58ApDc17oI6McEFFFEdK9RsKH265VdHc2IuEz4f+6/fU5uK1z6aPzMuG0m2j8
 glBkeaiJD5dajCus/7RQAu/igJ9eO0jTZ7053RDJwMj0keIoPUT+vwRePHULo3t/JMam
 JKzCnAuSkA5p7kWiNzc+Tg94yI60Qm0rJm5y9S49q20QMenWFRJZLiof51NfWHJh7xzw
 Sxjl7FnzNPWoHMaHi5MHrDVYgNMOvctX++IMD6qhmQc5RJlCiGQB+b3PDpl8ZZ19HPkb
 YagHe+7vpHhtDnLZb5ienL6qcBGBE52r01cscLb/wdlBIcc/i2PtRoXrOaSctxFEGnCn
 XaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758099620; x=1758704420;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pgDhOyRLnZwAFn2B2OZc45OsJHZyQdANA0ZrYo5q5cU=;
 b=NKs+6McdHK1SI+sJvozh/I3fZOHFsW0ThXV/leaHP0UQ2/QV1Ka6mUkIFV3p9UeaqH
 8hsdka91zuRANiiFmgg3RvCfOk5m/cU7ciIoaO9zkoW5+BnIl+Dv0PrqCJvTuh3EDll3
 M2Jy+8d8VFLQkN6Lq64jotPxJigfwUnpbrJOffFAaFeEhimLZ8F04S4BEii988zMIkYo
 ov7ylwkc77MzXa9Jv58TqHW840Uh2fhfTVTyry5B/zj7tlIGjJF7Y8rV7Ov1ZD2xpG0O
 iRUtwfhn4PbzsOlFZNZbctqSJZ1DHgaXeZNU2F6zNIUZezxHSwFSy5rY5l+ZtbQ57YtZ
 A+Fw==
X-Gm-Message-State: AOJu0YyYK32MhqSRUF2izVZrLZATD9BDmb/rag6fIREt2iVl6xUEQ03z
 9NyowzXWpgUZwd4MipG1l9Lgl5lcqv916NgSgs3hRThlmyyKR+BilFKlKZ8Cupsf9a4=
X-Gm-Gg: ASbGncsbSHfyQG46g2s8pxTuyQQium960kuP/Cw/KcTASXsGSS1LXnvqRdGZzvULzh+
 pm4r4r6iPES2l37+w1Uf5QR5MTPEOgQhoXhxKxW9XEJf5yAxlh96t2+JJXrcNZ7CLZYWMSfEvFQ
 LFuW+G4OdNIEEWpRApzruQ0xv0SwfBrPPyVfAJS++EdB5+ijubSH5W5zMah4PS/0lhjHdQLYYb3
 TodHf4znuNBcfVSPVJDwx0vaOe5ROfL6b0UJkKbqODaNxCrYharjHSaPJY/oSbutaNBEQCM2gSH
 IvDWfAHI7he1WnvGvtYq3Ipk7vq0ujgk9oRnsECoxl5Sky7n/6PKb0dBO7lGhegN5K97Wu08dae
 OwBZ4Qq9AUQ6y1jgaq67VaAI=
X-Google-Smtp-Source: AGHT+IHzmzPUkQmWTr58Bkb6pxmCWm0leNpestqNXgBydDiLBFrDhLv5Wj8hf4QHomQglMBhKYRHyg==
X-Received: by 2002:a05:6000:220c:b0:3ec:dd33:d0e with SMTP id
 ffacd0b85a97d-3ecdf9b491bmr811128f8f.4.1758099620490; 
 Wed, 17 Sep 2025 02:00:20 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ea6805001dsm12909204f8f.6.2025.09.17.02.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 02:00:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B395B5F834;
 Wed, 17 Sep 2025 10:00:18 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com
Subject: Re: [PATCH] checkpatch: Ignore removed lines in license check
In-Reply-To: <20250916165928.10048-1-nabihestefan@google.com> (Nabih Estefan's
 message of "Tue, 16 Sep 2025 16:59:28 +0000")
References: <20250916165928.10048-1-nabihestefan@google.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 17 Sep 2025 10:00:18 +0100
Message-ID: <871po5o3ml.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Nabih Estefan <nabihestefan@google.com> writes:

> When running the license check, if we are updating a license it is
> possible for the checkpatch script to test against old license lines
> instead of newer ones, since the removal lines appear before the
> addition lines in a .patch file.
>
> Fix this by skipping over lines that start with "-" in the checkpatch
> script.
>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

