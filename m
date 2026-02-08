Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7650EF06EC
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 21:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpCCt-0007Oe-Lb; Sun, 08 Feb 2026 16:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <spike.chain.net@gmail.com>)
 id 1vpA2w-0003Lp-Ko
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:02:15 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <spike.chain.net@gmail.com>)
 id 1vpA2u-0000rX-9u
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:02:14 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso19563205e9.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770577329; x=1771182129; darn=nongnu.org;
 h=mime-version:content-transfer-encoding:reply-to:subject:to:from
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ZbR1b4bqveMfm5Ndpr1zrM6/TuG7qw5/yLLRsVZgU20=;
 b=IVsvwHaAMRdq1R2+2OHyqX+xitvNAhk1r/xcOO8quVOFR95r47B2ft6zjsqVJFTKd/
 WGMSdBH5RZUJp2kwbp4qE0vi3TvPPUmm/iCLB2p3EWMmDSlfKUsfiwP8MZjeA1sMAn4e
 sekBkO4jbL8uFuHUzR00XgSxk828W1UJRzuAgTswzF7dIMnoxNHg9uov9vf1OzQFp6tN
 SrjHuPf0Nk9M5xRsBHQ1Y1gcZk3vd7ZERVBkB4TFO45eT+fEECqhP+g95OOMH21zpMLa
 0RFNFz9c3937eLzVvItYLJtuw7o29ZxMlP90b9yjmnveCqCT02lAX4XpdlTP9itLR2SJ
 j+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770577329; x=1771182129;
 h=mime-version:content-transfer-encoding:reply-to:subject:to:from
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZbR1b4bqveMfm5Ndpr1zrM6/TuG7qw5/yLLRsVZgU20=;
 b=PPAjAeEneWfethTOCzM9hBZLG5D4zhRrq4MV2HkQMSYoYOT3giS2tYFuIMcljdzDgl
 aJADKZsXm8/6R/TBLDKK7Sf3tPPICmPmKlO5HBG1zC44jKQrfFq5VwtOyYb1zG1SJ5d/
 9WrDg1NrRR0UjYkUR9ZU5r3pZU/4//C2sip3MvaDjQJ0Q7aLLjuvvE1cB8IZuw1zYUsH
 NeyIYvPiypGae91F0aUE5yk8a+qNoOiBPYIlMLogBfbVnjPQ8u7x/OKEsXnRyJBOcTaF
 AKa+UPhlI6fZ4WrhLXDGoySp12ctQG8ugZPCj8MaXsxCZOJnestVd/1pyOCFKE6YeD1b
 Aw3Q==
X-Gm-Message-State: AOJu0YxAAMK7otih+l9vckY8XepETbIUme+K50gFG7opcPZkaju7NBin
 YfPzvkeOCORW6Q2QnlEuiJoFgeAaEzqHb+8oOQjc9lRCwgS3jnJasvsVkDU1Pd3v
X-Gm-Gg: AZuq6aIOibq568uypOdb7Jx7/ihUwdN/py8cO8RmoZIGEjyIn7YpnuBOtKRB7/YE8Hv
 Q2p8lq2heRoAJ415rqkVF2QdW8sCx59RsJiFJEYMJnmlQw4rULUUaW8sKW2s1bWDJnHufKnnyBX
 YtIFtTKCd+t4xSrBXDWqEU1/Fj1YXV+vzEHQ0G2SdpPQMO6ebI+JaMhPyHtQMqjNWopkrXaR6s5
 W5wQR7yiCJYdZQMuaQFct1zEX0dOIVbIvvxSJfzrjknmNNa7qautaHodUq8ie9TP1mrZP7xpUjP
 0kmnUMW5ksF2eBFWofcd+s67q4QeWh+0zZSYkDvyHsCDedUVpUX6vRN4GAHnEXnFuC1P3JypV/F
 O9Ud4oHMHWrtHerwMUAyG/5TKF20oe4nMwRpzf/0/vwBplo6M0RebFa99WZDQOJKAf1+5vBQEvD
 ZTl/OPFvZmMxGDb7GUnDTbqhDaQzWg0Imqje27x+I=
X-Received: by 2002:a05:600c:1d99:b0:47e:e9bf:dd8a with SMTP id
 5b1f17b1804b1-4832022a57amr114040915e9.37.1770577328595; 
 Sun, 08 Feb 2026 11:02:08 -0800 (PST)
Received: from mail.leaseweb.work ([178.162.236.108])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d8e8d4sm275215755e9.15.2026.02.08.11.02.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:02:08 -0800 (PST)
Message-ID: <6988ddb0.050a0220.1c680e.f6f0@mx.google.com>
Date: Sun, 08 Feb 2026 11:02:08 -0800 (PST)
From: Victoria <spike.chain.net@gmail.com>
To: qemu-devel@nongnu.org
Subject: Python mentoring request (code review + project improvement)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=spike.chain.net@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 08 Feb 2026 16:20:38 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: spike.chain.net@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Dear CF Bolz-Tereick,

My name is Victoria, and I work as an assistant.

We are looking for hands-on Python support focused on a real codebase. I have=
 2 years of Python experience. We already have an existing project written by=
 a more experienced developer (about 1,000 lines plus additional modules). It=
 is a trading bot on Binance.

The task is to understand how the code works, identify issues and mistakes, a=
nd bring it to a high professional standard. The goal is to learn through thi=
s specific task while doing practical work on the project.

We are looking for a qualified Python teacher or mentor who can explain clear=
ly, perform code reviews, point out problems, and help build a structured pla=
n for improvement.

If you prefer no further messages, just reply "no" and I will not follow up.

Respectfully,
Victoria
spike.chain.net@gmail.com

