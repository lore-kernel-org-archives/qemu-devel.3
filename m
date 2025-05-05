Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849D0C369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBkHd-0001m6-Mt; Sun, 04 May 2025 21:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uBkHa-0001lo-45
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:06:10 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uBkHW-00066V-LQ
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:06:08 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-af59c920d32so2524422a12.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746407164; x=1747011964; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fuAxrZfTz8soLMXxf03NXFqnBFZgEbB3erqaiLmLZ4g=;
 b=ezxhm6SoudITzHEPGKlWlb37VXYW7IC92PqypxPMGr+x6UObj897rF+olpySmPq8yI
 BOIxZsXPeUf7Bal3XIQMTcAjqP9SrSCosPaVwZwCZMg7keCoMR5pTPD6yLBHBsidKwyu
 4MX0Mh3u9KI3WbO2i6y858xjhjgznjj5hzQT3nCMNin6qWPy6sbdFJPHvcqimrn+UhLK
 IbWfIZwccrnT06aZcWYkWDDv1yqF561Yrg131BmyaMid7Q1P4v2HtWW6sQPkcQYSDmod
 tX6cYZKEqCmkzosYLkJB+ZVwPW8xUAqvEDb/17S7gjJ0JJIXkoVVp29fgD9clY8rMTcy
 UmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746407164; x=1747011964;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fuAxrZfTz8soLMXxf03NXFqnBFZgEbB3erqaiLmLZ4g=;
 b=lTTOAH+M7J7sGV2acicIZvBY9s6+kjm9ey1pTsVKrCMOsZF9xDFTClILFmlYcEjL0b
 P6gsqaqeVAW+h/rklc+1YfLN4DKepihNdTCyo2BZu5J6UdR8YZZOakmpP57bR7ylDZh7
 1poPhQBkS5Ws71Sq067gOkdkNvRtNW0RjYiTLJ/WjjXqp7teVtQJLezoVl/ZgiXMl1/Q
 dNbKpOQg6WnTRmcDuRMwFuIsTqC4lf79XE4BkIS4jgDCJXOHXrXnQkKIpAEstiuqMZJ3
 6qDCwXLJfTcy1UyBzzskZDT2Cm0QmXTinBEtoTM23aduoOYh+ytmOREbr11xgfJILYtF
 YU5g==
X-Gm-Message-State: AOJu0Yx+63NDTivw0d93v9XomwRTk3c4eBOkELxUw1isdlB2sTDcfPKA
 qcGMYFUgLL+jxdLXnJDjIBO9Jh7lLQHEtYGEPTSOa58LyRQpEf86
X-Gm-Gg: ASbGncu5t8x0wlE2ss+Ro9z6j10Ph0kLr6TKR054xJWTvcidnoxrnJRZOQ5OlueKd55
 kcl+TbWkrG1c9nxHOEqTudtQAtmFHTG1OjrFPr9AVutnjK3iUAHUlF9X5zXI0X9PsZUF3WzdylJ
 Np1Z8wmtRFE3wGDcQlprk/Q6Tou5/chExOfDLVNufbCZbbQRRLQN8ctkGE1/kpXj7CpFL7V4+Ec
 XwYVYF8DTSGvkKKArZA1tMzeVUpM3R11v79RuBL6sfqccC9pcutHexgN6QJtMduVB6DLl148H0S
 abBrt5jdr34DNzSBuzPHNrC26sJN1uQ=
X-Google-Smtp-Source: AGHT+IH1u9aA6Za46/yr+jYN8EOq0m2pWecH3pRmPLp/uxI95frIq8wMuef1uCcklKZh4lSc66Rghw==
X-Received: by 2002:a17:90b:274d:b0:309:fe2b:306f with SMTP id
 98e67ed59e1d1-30a61a50728mr7834400a91.26.1746407163973; 
 Sun, 04 May 2025 18:06:03 -0700 (PDT)
Received: from localhost ([1.146.94.19]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a4748e852sm7400328a91.23.2025.05.04.18.05.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 18:06:03 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 May 2025 11:05:55 +1000
Message-Id: <D9NTO3B8EVBS.1W5R6F8JHUZ3A@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Kevin Wolf" <kwolf@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>, "Fabiano Rosas"
 <farosas@suse.de>, "Laurent Vivier" <lvivier@redhat.com>, "Phil
 Dennis-Jordan" <phil@philjordan.eu>, "Bernhard Beschow" <shentey@gmail.com>
Subject: Re: [PATCH v4 08/22] tests/qtest/usb-hcd-xhci: Deliver msix interrupts
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Gerd
 Hoffmann" <kraxel@redhat.com>
X-Mailer: aerc 0.19.0
References: <20250502033047.102465-1-npiggin@gmail.com>
 <20250502033047.102465-9-npiggin@gmail.com>
 <14f30ea3-2200-4289-9f66-a23fd77a091f@linaro.org>
In-Reply-To: <14f30ea3-2200-4289-9f66-a23fd77a091f@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
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

On Fri May 2, 2025 at 6:24 PM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/5/25 05:30, Nicholas Piggin wrote:
>> msix
>
> Hmm? :)

Oops, thanks. Too much juggling around of the different patch series.
This depends on some of the libqos pci changes so I split it out (and
it's probably nicer to be separate anyway).

Thanks,
Nick

