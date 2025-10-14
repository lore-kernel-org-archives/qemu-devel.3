Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D80CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 09:21:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8bDn-0007zP-Q9; Tue, 14 Oct 2025 05:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8bDl-0007yt-9L
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:21:29 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8bDi-00022H-Tu
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:21:28 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6353f2937f3so5993488d50.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 02:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760433685; x=1761038485; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EoLIPjWxg8TDINbK9pEzBb+cunrAu2Micik44rjNi/4=;
 b=E5sCdoGBiEsLwFtHWO9OXICaH6BumaoXQ5Z3c6TgR28l1QuyBaGJhStbI6B0w6XfBw
 7t0Z9BTd16ujV/YJF5/RnNm3hoiPYnG48zeeqH0JBmjsN6NXTuZKFF/GxUzZj2vRQRBF
 bszbX12FHU+1iu47Khb+gCu1JjcLa3RVdXEiw+KPjhQaUct5z56+HYws4T2d0BD1FGmM
 xGeXmHKJT4vO8xjVDA5AT3hYuvkbBHaTChwJGJv8DcciHZFvWeWOWQ7wUbQ8pSU39Nng
 +muKW2jWfTZoCZU1O2RbdBodLvD0PWcCt/CakjdpHNsWUkirMLa7fknKwH5MpEyxyRyC
 xF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760433685; x=1761038485;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EoLIPjWxg8TDINbK9pEzBb+cunrAu2Micik44rjNi/4=;
 b=uK2r6bCmCqa3MWgX8b3Z7uLNDwQDH7qKZBa7V9RXU12veLhaq1aa53r0JdD+7X4uJZ
 Or/CmztPbzoTKeqe6rzOs7RI1riBXHoZ48OuSRVvunoiI1ELQ43aVq8DBnJB7b3aP4VM
 e2DEfCnxsy538EatZAF2UcYR7ptz+tSYckgoF4ZsjqNj1dgFFBeImNxNcO84vBM8RhJx
 kDFZ+pnuZwsZ37wM+64uuGttupeS5rUc93PYTGeK38gskXU9uyaVJaD0HpNHeC5xx792
 P+wbK+UAaPwb9D/98XT2saUZIz5Nel70DlqlOLAYg13ChYn0B1ZFdiRvhq+u95JxIqW3
 Qabg==
X-Gm-Message-State: AOJu0YwylJ3fdJznlDO7QyBvoiAHZDXAg5VXv1C9ijJiW06sSr7nK5z1
 kC/bwRNU4q2oCYCZY3gj0CdLdyCc1ZJo9cTECWDzrSEyMeGPOxv78WH5wZRvctwdAkikhg9jAke
 QxjcGY4TrVKxgZOPcPC5xbkkrOE3UfnsZ7YXMfxw9lGAQebWtbgA6
X-Gm-Gg: ASbGncuYyeL6KtxtO3UeimJE6rv0zFv2RWsUjbbehulUtnsZn+WtOB1Fvxn1LDHcPk4
 /zQPBtHJJ1MJAiQQPTJZoZ/hGhIk7VhgwdaNv7DksQdLBqyEarprh9lRqtzk6dF1neP4OXoAmX+
 xfSC1WKkQPO3/F5TRtpWoW/cETPa1D9xZWFf3cHm8TI6ktNCsUt8tMIe7+VcQUYUtcK1yESjxLo
 Pf6yasCz+m3hDOWfoupHP1JJUHZCNVKKZH3tNMqdA==
X-Google-Smtp-Source: AGHT+IFnBN/kUumfy2G6+595h8nkFF72QDiwYgJ/388Dka4RqGycHLFWwfC/MxmVIXCw6b41MBitn7vj9E7bhnB9gVM=
X-Received: by 2002:a53:be0a:0:b0:63c:f5a7:3fc with SMTP id
 956f58d0204a3-63cf5a70a2emr7217190d50.64.1760433684784; Tue, 14 Oct 2025
 02:21:24 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Oct 2025 10:21:13 +0100
X-Gm-Features: AS18NWCj0D9ebHLz4WmL-PM1XDzS5drXvoF_JpwfEFD9Jw7iKXh-haa8066oQZ8
Message-ID: <CAFEAcA_HOAY3dvoj7a0GYX85UeN9OVi7SPqYtEmPFWP+DvZfSg@mail.gmail.com>
Subject: proposed schedule for 10.2 release
To: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

I noticed we hadn't yet got around to nailing down the schedule
for 10.2, so I put together a proposal (which is basically just
"same as 9.2 but with all the dates moved back 1 day to be on
Tuesday"):

2025-11-04     Soft feature freeze
2025-11-11     Hard feature freeze. Tag rc0
2025-11-18     Tag rc1
2025-11-25     Tag rc2
2025-12-02     Tag rc3
2025-12-09     Release; or tag rc4 if needed
2025-12-16     Release if we needed an rc4

https://wiki.qemu.org/Planning/10.2

Richard, you're doing the merge handling this cycle: does
that work for you?

thanks
-- PMM

