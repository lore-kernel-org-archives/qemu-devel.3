Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF263C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 16:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY7GH-0008TG-Ou; Thu, 08 Feb 2024 11:28:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY7GF-0008OK-CH
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:28:27 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rY7GE-0004st-0C
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:28:27 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55a90a0a1a1so110708a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 08:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707409705; x=1708014505; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LYzX62PjSeZaEff11vxoB68oY0xQpvD9BseKWS54pic=;
 b=HGyJHnRCjhxf8d/ETmUqc2pF6cEwh6gWwQx5RrZVnPPRBAKjrf4V0GolhDLxw+iQ2V
 vaFZUnMy6UXTK6UBIx0IwwptP372u8H6NvDsIuMcLh8oNzmvoG39/53LAfqhifx6UWci
 hLTSbOM6qvj86WJn5ViihTEtDnaNowTBjmVTKDt1TWyYg+zFrZifja9PN3vkwy4xfIx0
 JoHECkJlHnP1j3hKxK8rcr4du2bkeeXYGCtC5w1a7MeTQC5vRxlUAQFkN1BNtyCq5yYA
 KPiBN3zJ7YA1NoM8aimTw9sPqg2lbQs2WpPgd4YjJJmMSONmz9JWmtaWkJPARMEclf2l
 qMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707409705; x=1708014505;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LYzX62PjSeZaEff11vxoB68oY0xQpvD9BseKWS54pic=;
 b=V0q/fyauWu8CgTim0nJu0GiNTHQsaIUEJ4jBD9DtXbE+DIqPQ5RgmHJRmmLkYSsJlQ
 ZXquBug6SN5jF8B47WONMLpaKUSGV/9LYIl67i1whP8NDDcCU1RknIcAwaG+U7C0qbEb
 IIsz1WnpJ7beQRLzipKc6+XvmzP5stw/NuEh1mrlBRkNmnlZVEI5nHcGshbmtJITHjAK
 4q1rsQUvcFEJ6oM+zOH6qCvLW9lhxNYhdcvl7IzkM6uHxk2wowDqtnw2lKCtJtC/h7Qn
 OhzFEGzW6VfTSf9xB87huGgpDO99Poh8UxhDfSsk50SbuzlDYXx6dJlTJgjvZNReR7zL
 QXWQ==
X-Gm-Message-State: AOJu0Yzaeioz3LJhupyIGHXuwgoPOaD/ly0wnISA4XlGrrVe7Cx4FD+I
 nmSPwZYXmhB0KJ8LOsYw6Px5A6ZxPBlhJOSHypUNgSb5dJrEmTnxM9dGhG4X5Q5+wk08iCh6J1R
 fhT0C4xG0stQWTv4wnZ+r1/G2lwZyAGxRGxeMCqvynZsjXOKT
X-Google-Smtp-Source: AGHT+IFsVM0KLR5lrZOPoQQ0v10J1bIGm3RvhqxmBmui1F5/E8oCjSCnjCe7SzvTZILlddTL18x/5e5hmG5+6KKH9W0=
X-Received: by 2002:aa7:c30f:0:b0:55f:8bba:d0ae with SMTP id
 l15-20020aa7c30f000000b0055f8bbad0aemr8132609edq.23.1707409704761; Thu, 08
 Feb 2024 08:28:24 -0800 (PST)
MIME-Version: 1.0
References: <20240202204847.2062798-1-komlodi@google.com>
 <20240202204847.2062798-3-komlodi@google.com>
In-Reply-To: <20240202204847.2062798-3-komlodi@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2024 16:28:13 +0000
Message-ID: <CAFEAcA-+ikk0Ls4N_6cN9kCa=_YD98DEM5fH6AX1LNONMLmdpg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] hw/i2c/smbus_slave: Add object path on error prints
To: Joe Komlodi <komlodi@google.com>
Cc: qemu-devel@nongnu.org, venture@google.com, minyard@acm.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Fri, 2 Feb 2024 at 20:48, Joe Komlodi <komlodi@google.com> wrote:
>
> The current logging doesn't tell us which specific smbus device is an
> error state.
>
> Signed-off-by: Joe Komlodi <komlodi@google.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

