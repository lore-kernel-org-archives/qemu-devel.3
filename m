Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CD2E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 15:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLOTb-0000Ic-1t; Wed, 11 Dec 2024 10:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tLOTN-0000HT-Sl
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:18:00 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tLOTM-0007jK-EK
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 10:17:57 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d0bf4ec53fso1183321a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 07:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733930275; x=1734535075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DkFMQ5IUpPXHbUyHcc5o274RRCN41gtiFzl1FIq7oKA=;
 b=JKBDbHZxc6V4ozrkq5A0VD2g84TB8U/Vz/f4byRCfv6N67DxOweV1S4BPKbJuBi2TW
 GIIR9GS3eEFmQhfhUO8HRhz3SRrtOriH7k5LAdcSvpmTtDt8xTualnqr9keyzjYmFbB8
 zC5fa+1Pu6g2OIN7p4ZGGqWeE4NF/2dwTLaKzzmR7RcCinchXWHvVy3zmHZy3TuTrogf
 3WEtrspp3c5uhDhcRRcd+NOgZf0C5VUq/jgSUhOmS7IMtqyB8/CRn50I5t6yqEtInv9d
 XufqVDiR91CGWCbwg55SHpnKRdV1nD3ZuNhLI3qo8Ead/hAZpygu2lDsfRRWXI3xSJqE
 mfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733930275; x=1734535075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DkFMQ5IUpPXHbUyHcc5o274RRCN41gtiFzl1FIq7oKA=;
 b=MeREeYGcaSnGhvPraKJ8t7dG/sunHZWCcXh2CcZ0RwfvercmVFUMy/1LlocwlzmThA
 CsnvqBMw1GGG4rqa6D0qVd11kqIIgfujaCfngNJta9mPETYWN0T45VwtS9AjVWbR8P2+
 Vo2XNTD+dutUO85CTxsRSPL4kf0RayIDjSxPoyLzyyyJzP1TzuUp+etggKzHvL0/eKDJ
 /x34PCIkq6I+LAUGfYwrG0ctQlcgQe1/ZZPyZAxPoBgaj4IoAYyugNCd+7NtwbcC2J8z
 wIZvAuua+KtAJqiKq6hyzOrcFESKpDVdPW9VqucNS7Cw2nMOqbIMPpkAt10u84eBuRwL
 Z1dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8HyVvVIlZWzXixyJQX5vJYsyWQYx3IPOilN0QJbvATEalvvpgwJh7jJEL/ivBBiy6ue3juZSARZDJ@nongnu.org
X-Gm-Message-State: AOJu0YzISoSu5QqQj88URoMP5ABU0qJniPVk2zbfDq9loyLFqWt/D7bZ
 JJQdZqUzUeNV5kO02oPdVOZcjkGxCU6ZAQZP8QtByNMSSsUaYSOc+Q786Ngv
X-Gm-Gg: ASbGnctfvMIVvHJ4Qc2K4iDSTiRpcq+eLQQb6UoOF5uVxrDbfM/SVoeqUHpq6EPfXuu
 kx8gg/uI2clSIIni+HaB2MDeRwhdr/d8+Piskijz0pI25/KaqeS1LH/XDxNzEnQvzrDEhvlRbt+
 RRuSgKzp0601+FqFuX3MhDLdRHcbIVG560HKriwTyYPXhiNLN+1vbfBadTFaEUywYsuuTZj7xHA
 QGcM+H9l+8ZkDPGPQPMnSxFdf4Ss2BmG6+U16ehBpoG6KT14JJMJx2fKTYPGZVZj3AFn4NJxWbx
 BQ==
X-Google-Smtp-Source: AGHT+IGbl2U4Wxmalx1k0d/JPvfkTyzMXU3GEGOOCnMc5G2btq6uJzDs3hSEVoy4Kp+pRd0fMyIKqg==
X-Received: by 2002:a17:907:94c1:b0:a99:a6e0:fa0b with SMTP id
 a640c23a62f3a-aa6b116812emr130779066b.5.1733930274615; 
 Wed, 11 Dec 2024 07:17:54 -0800 (PST)
Received: from L-H2N0CV05D839062.. ([79.175.87.218])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-aa6a3dcbcc2sm262527666b.117.2024.12.11.07.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 07:17:54 -0800 (PST)
From: Aleksandar Rakic <rakicaleksandar1999@gmail.com>
X-Google-Original-From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: rakicaleksandar1999@gmail.com
Cc: aleksandar.rakic@htecgroup.com, alex.bennee@linaro.org, arikalo@gmail.com,
 aurelien@aurel32.net, berrange@redhat.com, cfu@mips.com,
 djordje.todorovic@htecgroup.com, fshahbazker@wavecomp.com,
 hreitz@redhat.com, jiaxun.yang@flygoat.com, kwolf@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, philmd@linaro.org,
 pierrick.bouvier@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/4] Skip NaN mode check for soft-float
Date: Wed, 11 Dec 2024 16:17:37 +0100
Message-Id: <20241211151737.87765-1-aleksandar.rakic@htecgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112164130.2396737-4-aleksandar.rakic@htecgroup.com>
References: <20241112164130.2396737-4-aleksandar.rakic@htecgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=rakicaleksandar1999@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

A kind remind/ping on the patch. Before we send v3,
do you have any comments on this patch?

Kind regards,
Aleksandar Rakic

