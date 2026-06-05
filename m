Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB457CD6E7B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVSC7-0004x1-KT; Fri, 05 Jun 2026 06:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wVSC5-0004uU-W6
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:54:30 -0400
Received: from msg-2.mailo.com ([213.182.54.12] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wVSC4-0008P6-5i
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780656857; bh=jLZ/LShXFSjkqGpQ0ezSkmOvCiaPbNMfAHaszLKw+PQ=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=fqMswC6nY+RWkW5RKkjHDHuduCOg7/MQ1RokDbvQtYpI4hSRCV5XRbIRI1PeOFh1O
 Ov4FFA53WU/8KPxz39VWHagyh6CdrTHynu/DsMf0hhVSxXGc2a56x36jHOM782ZY1t
 12WMfy9xQzKCHep15aXPfZ1BclQOrWg617zwUwa0=
Received: by be1-3.in.mailobj.net [192.168.91.13] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Fri,  5 Jun 2026 12:54:17 +0200 (CEST)
X-EA-Auth: yUlb884BwLNG6fUBlH2PJ52pLl0L36AMirrKaE+wIPd0lS8dSoVA+aW2GDf52Dl/FvZf0oCaeLE9XcF9fP32RDJsk+NtI8WC
Message-ID: <6551d152-1386-46c8-95f7-f6fb53aa636f@mailo.com>
Date: Fri, 5 Jun 2026 12:54:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] target/loongarch: Add wrapper function
 get_csr_offset()
Content-Language: en-US
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <20260605082552.175336-1-maobibo@loongson.cn>
 <20260605083904.175636-1-maobibo@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260605083904.175636-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.12; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/6/26 10:39, Bibo Mao wrote:
> Add wrapper function get_csr_offset(), it is to get offset from structure
> CPULoongArchState. There is no function change, and it is used for future
> LVZ feature.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c                           |  4 ++--
>   target/loongarch/csr.h                           |  4 ++++
>   .../tcg/insn_trans/trans_privileged.c.inc        | 16 +++++++++++-----
>   3 files changed, 17 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>



