Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6529EC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 17:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUsF2-0000f0-Ff; Tue, 30 Jan 2024 12:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUsEv-0000Y4-1n
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 12:49:42 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUsEs-00027W-GM
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 12:49:40 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55f496d60e4so1141024a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 09:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706636976; x=1707241776; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7C70GGg6nTSa5RvD+OHe9RS1Dt1in06RTmJma65o/RA=;
 b=gnf84FkFQA6YvvRNI7UAFPm5uPQUvveWXH9lnDZp9YskT+trn36HpI6wcm/6fSl8gG
 Jy5SXt1NUHCclgoKtXEZENG5cxIVuiJfR893UPW5i0z4hpi3iMD+tlH2ocr7lvH0/3JF
 zUhGucuEzze235UEiKHBYi5wUCH1TGxSs7qyZDCnGySlSESUQ0+5jDtyEIjYOMrCGTTk
 QotquIwv93kiYsScNHrD7M3ko8k1yZbdLJDdo8WGvwl82OnBVg8eZ7QbOxnFpSjI0ENt
 ZSmxV9lZr510PeAJe0JV/19GYXqigl0HH+H88vDq3k6xpZohJS8BpC6sfgBtjBzR96re
 OkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706636976; x=1707241776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7C70GGg6nTSa5RvD+OHe9RS1Dt1in06RTmJma65o/RA=;
 b=vlNFjQi0iFYHVoiRR2oKw9W1cGmwH5Y3wQloZjV73TCwDhzq//8Evo0JJ96dmgNK7Q
 j15qVdph/mwJFexxaN+MpRVwUD53egovS4aRR333H0jItnkkHBwnR5LDlKN4/h7niDvL
 gi+fc6Hukic719djzCD5eiC97bRQzoIE/L2uheiwL5wVkynyJIIWi8pRwKFbjk+Yuv+H
 AOCK5BcBiCFyjQIzsef4HcfUhnwYA5V6I2LSVs6p0y3WCgIn9nTgMQV5snSeSYnjLWe3
 ucmBo1dOGnFYP041G5aUeiLZU2NHO9Jb9nqeyAWYjhEn1h0BU8rlq73LezhfmJP/kaHY
 P1RA==
X-Gm-Message-State: AOJu0Yxg5kID5FjVeLZaUpljD7CwuN5ZrOjClHPgMtPBEof0sghnLeys
 xeWWLbxnKa4xGyPt7zJ12Z6UJp/Fn/kOjhtkdckEp97Z49Yx9OzeDfel+FUi0rfCv6LhO+tMEIE
 tg6Hx4+O+GpYACRAdcZE+FYKO50HIjy0Nl2TD+A==
X-Google-Smtp-Source: AGHT+IGiv+zOJyez+LmAbomFOBPweqPYrZguyODcMgnQ7mbTHoJzI9DkcfdOBKEDXHUyYnf3j0QrxttVcAH6+sQGfzs=
X-Received: by 2002:a05:6402:f93:b0:55e:f047:92f6 with SMTP id
 eh19-20020a0564020f9300b0055ef04792f6mr4331226edb.38.1706636976601; Tue, 30
 Jan 2024 09:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20240125194247.1589037-1-nabihestefan@google.com>
 <20240125194247.1589037-4-nabihestefan@google.com>
In-Reply-To: <20240125194247.1589037-4-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jan 2024 17:49:25 +0000
Message-ID: <CAFEAcA-spMr3eHtdTYppD=Pt_fYQ6pjkD+b-Z1VM9gSvLT309w@mail.gmail.com>
Subject: Re: [PATCH v15 3/9] hw/misc: Add qtest for NPCM7xx PCI Mailbox
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Thu, 25 Jan 2024 at 19:42, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Hao Wu <wuhaotsh@google.com>
>
> This patches adds a qtest for NPCM7XX PCI Mailbox module.
> It sends read and write requests to the module, and verifies that
> the module contains the correct data after the requests.
>
> Change-Id: I2e1dbaecf8be9ec7eab55cb54f7fdeb0715b8275
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>

> +/*
> + * Create a local TCP socket with any port, then save off the port we got.
> + */
> +static in_port_t open_socket(void)

This should be "int" -- you've lost a change that I noted in
my review on v12 and made in the patchset I sent to the list
in the pullreq. (in_port_t doesn't exist on Windows.)

thanks
-- PMM

