Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E566C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 06:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saqy2-0002mD-W2; Mon, 05 Aug 2024 02:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1saqxv-0002jh-1C
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:13:08 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1saqxp-000833-FX
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:13:06 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-52f04150796so15640703e87.3
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 23:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722838378; x=1723443178; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qKfUThdQsLkFA6LYklbVLSCEwFJGaxuCvq2ljSDF5/M=;
 b=iwgYjPesHaqZeZVvvC4OE3/TE8LxsSwlUW0IHlKby3X2xU/wBPJxtFcQ9QQ//uj4xF
 bUNbyRWyhS7JH/Ec5eABwOsmkFyQNzuCOBvEJ9SmMfd+GwFk8SC+SWEe2vjgwpQJmw6r
 600Z8t+ri5X0C1SxT2lk1HK6NPVIZD4l5ifkziwdrrortLowdiwKhsIL7PHFJ91RJgwL
 3GPnGINwR/AxjWdrmC6Ptb6EadmSqsLwBfBkumZSLGp4xITkwL1rAY/klp3HeIVYhigN
 56PM7FHkNTj07lV7SBzYFQBX64ZaJJWxQH2X6wo6SX7gcw/Aw10uYel4EhozoAs3A3r8
 VLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722838378; x=1723443178;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qKfUThdQsLkFA6LYklbVLSCEwFJGaxuCvq2ljSDF5/M=;
 b=olMX2KwpP5OnRazi04N4dDrtYtFhtc1XE8PqDDcHress70rHrncy2xMzMLwQHaVQ1Z
 4JtkCPRD4Aq1tT99PIioRE9rL7LqJthWSOK7Cpz55iVx7bvKul3QJou05OCVK3maXUsI
 4Ae/tz/olZ4nKumnS+Cxs1bSYB/ixirkeIIaVy5Aw/0frQo3d9xHZy2PGcQGMXrXsegI
 Q/uungq4c65tMFJNR6gNO+suxwAvSas9J24t44TpkY7sThQKO1JAU35uSrTdHu9PyORG
 fJGRAAfVrChiN5lgAsIir0S+U+cibM91b8TY1zf2wO3i7DYKGJC7fSPtD2+6JVDJ8o+B
 3IAQ==
X-Gm-Message-State: AOJu0YyTy3ltbUwV9vfvFFmbgbPVGyZry7M1NmvvT0A7pcbNovifTiJ1
 N0qUzgGZS4/GJx/1+jN6RAjCwkFaEV9b+XS+es6Mh9zUoo1FZa++
X-Google-Smtp-Source: AGHT+IEe+PmHDPI7oF+fo+ak4vt7dP7sQyr1eoXWAXQHzgm5gUvuBqC6Bzu+RLNXe+LPY3jqKG+UEQ==
X-Received: by 2002:ac2:4c51:0:b0:52e:9882:2cd8 with SMTP id
 2adb3069b0e04-530bb3670f6mr6590163e87.4.1722838377189; 
 Sun, 04 Aug 2024 23:12:57 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e7d585sm124194775e9.35.2024.08.04.23.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 23:12:55 -0700 (PDT)
Date: Mon, 5 Aug 2024 07:12:55 +0100
From: Stafford Horne <shorne@gmail.com>
To: Joel Holdsworth <jholdsworth@nvidia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/openrisc: Fixed undercounting of TTCR in continuous
 mode
Message-ID: <ZrBtZ4VKEC0dgmWG@antec>
References: <20240607222933.45791-1-jholdsworth@nvidia.com>
 <ZmTbnfrp73tAt3KY@antec>
 <DM4PR12MB65656FF201E6BFB43FDB4A3BC8C62@DM4PR12MB6565.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR12MB65656FF201E6BFB43FDB4A3BC8C62@DM4PR12MB6565.namprd12.prod.outlook.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=shorne@gmail.com; helo=mail-lf1-x134.google.com
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

On Mon, Jun 10, 2024 at 07:29:15PM +0000, Joel Holdsworth wrote:
> Hi Stafford, thanks for your response.
> 
> > - You sent this 2 times, is the only change in v2 the sender address?
> 
> Yes, I was just having some difficulty with Git and SMTP. Should be fixed now.

OK.

> >> In the existing design, TTCR is prone to undercounting when running in
> >> continuous mode. This manifests as a timer interrupt appearing to
> >> trigger a few cycles prior to the deadline set in SPR_TTMR_TP.
> 
> > This is a good find, I have noticed the timer is off when running on OpenRISC
> > but never tracked it down to this undercounting issue.  I also notice
> > unexplained RCU stalls when running in Linux when tere is no load, this timer
> issue might be related.
> 
> > Did you notice this via other system symptoms when running OpenRISC or just via
> > code auditing of QEMU?
> 
> I'm working on an OpenRISC port of Zephyr. The under-counting issue causes
> consistent deadlocks in my experiments with the test suite. I wouldn't be
> surprised if it causes problems for other OS's.

Thats cool.  I got around to testing the patch with Linux, unfortunately I didnt
see an improvement in the lockups I have been seeing during boot time.  But I am
sure this is a step in the right direction.

> > In QEMU there is a function clock_ns_to_ticks(). Could this maybe be used
> > instead to give us more standard fix?
> 
> Seems like a good idea, and I now have some nearly-complete patch that brings
> hw/openrisc/cputimer.c into closer alignment with
> target/mips/sysemu/cp0_timer.c.

Hi, I was waiting for this second version patch, v2.  Have you ever completed it?

> However, don't we run into problems with undercounting with clock_ns_to_ticks,
> because if I understand correctly it will round ticks down, not up?, which is
> the problem I was trying to avoid in the first place.

You might be right, but if that is the case maybe it's a but to raise to the
maintainers directly.  I was planning to look into this more cosely after you
sent the followup patch.

-Stafford

