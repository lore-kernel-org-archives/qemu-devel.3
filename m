Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56E8CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 23:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO1Ww-0003cP-CB; Fri, 15 May 2026 19:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wO1Wc-0003aY-UB
 for qemu-devel@nongnu.org; Fri, 15 May 2026 19:01:01 -0400
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wO1Wb-0002ob-BF
 for qemu-devel@nongnu.org; Fri, 15 May 2026 19:00:58 -0400
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-12c19d23b19so452014c88.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 16:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778886055; x=1779490855; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JI5F+7Vux+E2/tIiQSfm/Vb8/uONQYx2nvo6h9SpnmI=;
 b=UnBjsfJ0wAyMeSBwY235guJwFwDYhYmpqdo+jogI4bfk0/NGhE5R35ykHHVODZP8vN
 PhvqNKbBSzkaXr3mwE6cic5pq/bq0a3+DUPS76LD1JNpBgkAPSzf2E+W0HNbZiX7NDHF
 XmPGmjK0Lsx8Se/VhfED/6bDcnbSnzqKEgCPeKDLfZPYIv2iDbF7A7ocmuhCLQsxlvFz
 V/0Hhmggf/8XCVeG1UaHzMbOgWvZEZDbV9gjOkEy9RxJw/SRFIFa/dfOGmoxnXsLzEN4
 OceCR/m6RcImy2mavOMPbelFrc79iTUcbMrS1rBBGYghRQd2A7avMmLzRPlFuK0BU8dD
 cnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778886055; x=1779490855;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JI5F+7Vux+E2/tIiQSfm/Vb8/uONQYx2nvo6h9SpnmI=;
 b=cXlxIatG5TbpWDQNBPZDlU1COTIyL+jLdEX0J7UxUi8FvR6dlAl/TvOF1dx13k0zn+
 eP0AL9ienArUOB2y7nsUHWJYVtCVIJxjIpj+Hvbci2pDAXSUt2f7t9t4kZcijgsPmEmK
 g3zH/aDTTt+GKulrGHRes5HAPtPXq1u9fEioV0ncf20X8/5tZOljo6eqUox5BRoZaLGA
 KZG9C8ir8bC+SRFBgc83rtjhtcnFlfFV1xQHeXfDMXq5m40G5zz0qU6ZBI0eBDDfZtk/
 ZDQfD+WnDv1m+c4/SdMMr/FbWEx82G9kWiGFuZto4S3jAOt2DuL8Sj8eSW8RlMX9oA/4
 FA8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BhPbQdJyuT5ytBIFfrLVJk6tsUn/6QkwdolVpC1DQoUfWh3CQd8kW0dFG51ulHs7FVxKgiKyq272U@nongnu.org
X-Gm-Message-State: AOJu0YwU8cxjp6sUG0oXG/AkSRFYZONivDiKmJO28dODnIiy7XnpNrYp
 +5IYhxTPrY53xKXT7KmQxrTcV9NhuGqUpj+O95W058v+DmLnPqhg5/T2
X-Gm-Gg: Acq92OEiwfVw8WIkcx51uBm1PFe2i4HuRs4Hf+Cj/hrIlR+QVoeg4/wURHdOkD1OApF
 RBVxw35htUwHAgSUxEWcybWdItwpjMdOdpS5/2p8od2bsu78+NDYMIFm6oXxmsxN3fyNJutpFOV
 gAsKwwohdg2EsJmVphOXz4hNwQb9LtRIDgvAdgHJ5yZnFvne7d5MnoZ9OKcl0g2ZSo0BsNIcKF4
 UAzul+PEaa71PJ2D5UAf/7K37MBcYuqDfqMu+NP/zyC3Xud0rC3hhjc3hthhkbd3BqBNzHm1js0
 cIYZanhzCXOZ53cbguDq95Vqn+CNy7VPa0dEndu2/O5io5LGe7YJNlYQsyjb4sla72F+3YgTiz5
 kZtoYVtwdN34xsQDowDKOSVXbOfqiZKcMM6F4ArdoGX14bndkCwVfMAYhijxEBnISUzLaKXkX10
 QZ80pPKZdJJ9dJ97sgsDlrTwbPrI2/Ryk=
X-Received: by 2002:a05:7300:641b:b0:2ca:7eb4:3e0f with SMTP id
 5a478bee46e88-30398287da3mr3115751eec.5.1778886055258; 
 Fri, 15 May 2026 16:00:55 -0700 (PDT)
Received: from localhost ([38.104.138.51]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30293e2e3c0sm10314861eec.3.2026.05.15.16.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 16:00:54 -0700 (PDT)
Date: Fri, 15 May 2026 16:00:53 -0700
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <cminyard@mvista.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Chris Rauer <crauer@google.com>, Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 0/4] hw/i2c: Add designware i2c controller
Message-ID: <agelQcm_i612YLbW@lima-default>
References: <20260507120524.111056-1-npiggin@gmail.com>
 <agCCOdfvlRVtCpYf@mail.minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agCCOdfvlRVtCpYf@mail.minyard.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::122e;
 envelope-from=npiggin@gmail.com; helo=mail-dl1-x122e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun, May 10, 2026 at 08:03:53AM -0500, Corey Minyard wrote:
> On Thu, May 07, 2026 at 10:05:18PM +1000, Nicholas Piggin wrote:
> > Hi,
> > 
> > This series contains the DW I2C model written by Chris Rauer and
> > updated for the Tenstorrent Atlantis machine recently. There was
> > some more review comment on that submission and so we decided to
> > take the I2C device out of that series and work on it separately,
> > see here:
> > 
> > https://lore.kernel.org/qemu-devel/20260425131721.932250-1-joel@jms.id.au/T/#mb1ef2824c2f1f37bf4574dc1ef0fb95566c3a2f2
> > 
> > The big thing suggested was to move to the QEMU register API. That
> > is a big change and difficult to review, so I have split that and
> > a some smaller changes out into their own patches. I don't expect
> > detailed reviews on the register API patch -- it's quite mechanical
> > and I did attempt to verify it by diff'ing register traces. But it
> > would be good to make sure maintainers are happy to go that way.
> > 
> > Unfortunately the patch 1 was quite well reviewed and tested so
> > incremental changes would be preferable, but it is painful to maintain
> > migration compatibility across these changes.
> 
> I had a few comments on the first patch, but they were all fixed in
> later patches.  From my review this all looks good.
> 
> Yes, please squash these as you suggested in the second patch.
> 
> Acked-by: Corey Minyard <cminyard@mvista.com>

Thank you for the Ack, Corey. Since everybody is happier with it now
I will squash and submit it with the next revision of the tt-atlantis
series.

Thanks,
Nick

